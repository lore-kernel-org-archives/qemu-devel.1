Received: from eggs.gnu.org ([209.51.188.92]:53206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNEoL-0005Hr-Px
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNEoJ-00026A-Rs
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:56:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hNEoI-00025A-8r
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:55:59 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun,  5 May 2019 13:55:18 +0300
Message-Id: <20190505105518.22793-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/rdma: Add support for GID state changes for
 non-qmp frameworks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia@oracle.com>

Any GID change in guest must be propogate to host. This is already done
by firing QMP event to managment system such as libvirt which in turn
will update the host with the relevant change.

When qemu is executed on non-qmp framework (ex from command-line) we
need to update the host instead.
Fix it by adding support to update the RoCE device's Ethernet function
IP list from qemu via netlink.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 configure              |  6 ++++
 hw/rdma/rdma_backend.c | 74 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 5b183c2e39..1f707b1a62 100755
--- a/configure
+++ b/configure
@@ -3132,6 +3132,8 @@ fi
 
 cat > $TMPC <<EOF &&
 #include <sys/mman.h>
+#include <libmnl/libmnl.h>
+#include <linux/rtnetlink.h>
 
 int
 main(void)
@@ -3144,10 +3146,13 @@ main(void)
 }
 EOF
 
+pvrdma_libs="-lmnl"
+
 if test "$rdma" = "yes" ; then
     case "$pvrdma" in
     "")
         if compile_prog "" ""; then
+            libs_softmmu="$libs_softmmu $pvrdma_libs"
             pvrdma="yes"
         else
             pvrdma="no"
@@ -3156,6 +3161,7 @@ if test "$rdma" = "yes" ; then
     "yes")
         if ! compile_prog "" ""; then
             error_exit "PVRDMA is not supported since mremap is not implemented"
+                        " or libmnl-devel is not installed"
         fi
         pvrdma="yes"
         ;;
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 05f6b03221..bc57b1a624 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -16,6 +16,11 @@
 #include "qemu/osdep.h"
 #include "qapi/qapi-events-rdma.h"
 
+#include "linux/if_addr.h"
+#include "libmnl/libmnl.h"
+#include "linux/rtnetlink.h"
+#include "net/if.h"
+
 #include <infiniband/verbs.h>
 
 #include "contrib/rdmacm-mux/rdmacm-mux.h"
@@ -47,6 +52,61 @@ static void dummy_comp_handler(void *ctx, struct ibv_wc *wc)
     rdma_error_report("No completion handler is registered");
 }
 
+static int netlink_route_update(const char *ifname, union ibv_gid *gid,
+                                __u16 type)
+{
+    char buf[MNL_SOCKET_BUFFER_SIZE];
+    struct nlmsghdr *nlh;
+    struct ifaddrmsg *ifm;
+    struct mnl_socket *nl;
+    int ret;
+    uint32_t ipv4;
+
+    nl = mnl_socket_open(NETLINK_ROUTE);
+    if (!nl) {
+        rdma_error_report("Fail to connect to netlink\n");
+        return -EIO;
+    }
+
+    ret = mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID);
+    if (ret < 0) {
+        rdma_error_report("Fail to bind to netlink\n");
+        goto out;
+    }
+
+    nlh = mnl_nlmsg_put_header(buf);
+    nlh->nlmsg_type = type;
+    nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
+    nlh->nlmsg_seq = 1;
+
+    ifm = mnl_nlmsg_put_extra_header(nlh, sizeof(*ifm));
+    ifm->ifa_index = if_nametoindex(ifname);
+    if (gid->global.subnet_prefix) {
+        ifm->ifa_family = AF_INET6;
+        ifm->ifa_prefixlen = 64;
+        ifm->ifa_flags = IFA_F_PERMANENT;
+        ifm->ifa_scope = RT_SCOPE_UNIVERSE;
+        mnl_attr_put(nlh, IFA_ADDRESS, sizeof(*gid), gid);
+    } else {
+        ifm->ifa_family = AF_INET;
+        ifm->ifa_prefixlen = 24;
+        memcpy(&ipv4, (char *)&gid->global.interface_id + 4, sizeof(ipv4));
+        mnl_attr_put(nlh, IFA_LOCAL, 4, &ipv4);
+    }
+
+    ret = mnl_socket_sendto(nl, nlh, nlh->nlmsg_len);
+    if (ret < 0) {
+        rdma_error_report("Fail to send msg to to netlink\n");
+        goto out;
+    }
+
+    ret = 0;
+
+out:
+    mnl_socket_close(nl);
+    return ret;
+}
+
 static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
                                  void *ctx)
 {
@@ -1123,7 +1183,13 @@ int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
                                             gid->global.subnet_prefix,
                                             gid->global.interface_id);
 
-    return ret;
+    /*
+     * We ignore return value since operation might completed sucessfully
+     * by the QMP consumer
+     */
+    netlink_route_update(ifname, gid, RTM_NEWADDR);
+
+    return 0;
 }
 
 int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
@@ -1149,6 +1215,12 @@ int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
                                             gid->global.subnet_prefix,
                                             gid->global.interface_id);
 
+    /*
+     * We ignore return value since operation might completed sucessfully
+     * by the QMP consumer
+     */
+    netlink_route_update(ifname, gid, RTM_DELADDR);
+
     return 0;
 }
 
-- 
2.20.1
