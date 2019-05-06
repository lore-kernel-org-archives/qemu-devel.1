Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91338C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C70A20578
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HRb72wat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C70A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgfM-0001Ss-JQ
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:40:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNgcK-0007eg-VK
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hNgcJ-0002wj-J8
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:37:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hNgcJ-0002w9-Ae
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:37:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x46GYwww190970; Mon, 6 May 2019 16:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : mime-version : content-transfer-encoding; 
	s=corp-2018-07-02; bh=rIopbdL2utFWcfnoE/fKk/xq29RWgwisk34FhNDMvi0=;
	b=HRb72watlKQXod9pCgiGzOxJLMFTOyYmewE7Buj+2Y2nKOlbtUoBQ6XNLtT4eA++7YmK
	RdQ+jS7ziuJNaFKVcfc+9cpdfJ5WFbWlue73eqBBV6U6Ki655JlX1Vxg7QfYVNgM82oG
	pqSEs3gcKteofN1N4J54rAp7gQjtZWZp1bCK9bJQjOhAInDrlDtA2glpXw/h7FX7jY7h
	qDB8o1Qg7KQZBNixqlck2SRZalzPKFzyJqB+5BqiR7zA4mJQLsmXIUiK11F1+J/rhWHm
	wry+z5BR5QXsqivnJXmEngugQvuR171erZrJwossN0/s7axSW5+xR3vjpp0pAtXgbmgr
	FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 2s94b0fta4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2019 16:37:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x46GbHRC052523; Mon, 6 May 2019 16:37:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 2s94af0eqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2019 16:37:23 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x46GbNEs010955;
	Mon, 6 May 2019 16:37:23 GMT
Received: from host4.lan (/77.138.183.59)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 06 May 2019 09:37:22 -0700
From: Yuval Shaia <yuval.shaia@oracle.com>
To: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, eblake@redhat.com
Date: Mon,  6 May 2019 19:37:03 +0300
Message-Id: <20190506163704.1378-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905060141
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9249
	signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905060141
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [PATCH v1] hw/rdma: Add support for GID state changes
 for non-qmp frameworks
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

Any GID change in guest must be propagated to the host. This is already
done by firing QMP event to management system such as libvirt which in
turn will update the host with the relevant change.

When qemu is executed on non-qmp framework (ex from command-line) we
need to update the host instead.
Fix it by adding support to update the RoCE device's Ethernet function
IP list from qemu via netlink.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
v0 -> v1:
	* Fix spelling mistakes pointed by Eric Blake
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
index 05f6b03221..f75e916195 100644
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
+     * We ignore return value since operation might have completed
+     * successfully by the QMP consumer
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
+     * We ignore return value since operation might have completed
+     * successfully by the QMP consumer
+     */
+    netlink_route_update(ifname, gid, RTM_DELADDR);
+
     return 0;
 }
 
-- 
2.20.1


