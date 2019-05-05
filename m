Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F8C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 10:56:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2ED208C0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 10:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fEz/EF15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2ED208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39429 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNEp9-0005af-Lm
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 06:56:51 -0400
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
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x45AsYRo148776; Sun, 5 May 2019 10:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : mime-version : content-transfer-encoding; 
	s=corp-2018-07-02; bh=gV1kW32mit71+wxEeBlfTg2NOTCOXntVwlzg++tFl70=;
	b=fEz/EF15f91Moh9o/UwNaQLL+nzlSIqA6Sq1E4Z7NFZ2C9pzvfl7beGqoe+MwELRGtGG
	4gaB4Jn2lpbGT77zow9KqAuHV5RlW9g5nxEKvzt+OspfJB4GcjnPhXjNptX8jxEVRAD+
	tmgvoSwE+31UeVRUauildAgzsKCGTjFZdeCyaKB7dYRk5chB6Odl+9o5mgU0X7H+ANib
	06bbS8wg4x6shtW2EkQLhLZwTiI2e6fEXydoSgvFRjo2D348Stz5IleJt9qaiFB8PLhj
	K21TW4NR94NDcikktbHfIrsYp6a9lrOARZwyV1ngSp60FeGcKxPYT9SRvmvcLVX5vEg0
	/w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2s94b0any9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2019 10:55:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x45AtW9u185190; Sun, 5 May 2019 10:55:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 2s9aydy62x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 May 2019 10:55:55 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x45Atsdx004720;
	Sun, 5 May 2019 10:55:54 GMT
Received: from host4.lan (/77.138.183.59)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sun, 05 May 2019 10:55:54 +0000
From: Yuval Shaia <yuval.shaia@oracle.com>
To: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Date: Sun,  5 May 2019 13:55:18 +0300
Message-Id: <20190505105518.22793-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9247
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905050099
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9247
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905050099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [PATCH] hw/rdma: Add support for GID state changes for
 non-qmp frameworks
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190505105518.dX-cK2_vYBLOmB6NHjENtS-gIdck1S15zc7n13-1VsM@z>

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


