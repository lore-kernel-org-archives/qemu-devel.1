Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C9FC38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F5820CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="quXhbJVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F5820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L2M-0000Wr-1o
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmc-0007OG-RJ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmb-0003h4-2z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kma-0003gC-RP
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:53 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqWdh017600;
 Mon, 24 Feb 2020 20:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=Ir7O9f1JIYFBmWd17NtDMCFQCpbqhXj4vR6Wr4D9z1k=;
 b=quXhbJVXcqP/RfX+S4XWoyvq0LqixiN24cCOtLYWEieaxhAu8hHFg63i9rvPx1Ia6A+6
 UlJHHE5G3ex0tyr5cqmDn/7stRZrTn4IQEMWIhsK3WTm8fdGX1W4YvsV5J8Ig7LicXrC
 /Y4sMCsj+lnnT2mCF9H3HWTrftd0bGNuhjcABb4Vzxw0UoX0K8cmwyhTs5xjlZREi1OT
 vixdF2SJmpzzTQJ2aVKI0rdrPu+bVuacjCQcrbIdkIyNaf99ayFd3sPq63uZ4i/8MKeF
 /rtG5FXsDfVl6IRGvIcoWS+zbdZvrNjTRYHwH7A9ORwtKrdCCnhAdT9jeG9VuYIbobsL og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2yavxrhyhs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKucBa072957;
 Mon, 24 Feb 2020 20:56:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2ybduv6dej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:46 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKukDk028703;
 Mon, 24 Feb 2020 20:56:46 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:45 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 32/50] multi-process: Use separate MMIO communication
 channel
Date: Mon, 24 Feb 2020 15:55:23 -0500
Message-Id: <d776913e1796fe9f929a665c0265eff3978fcc16.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using a separate communication channel for MMIO helps
with improving Performance

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 hw/proxy/qemu-proxy.c         | 51 ++++++++++++++++++++++++++++---------------
 include/hw/proxy/qemu-proxy.h |  1 +
 include/io/mpqemu-link.h      |  7 ++++++
 io/mpqemu-link.c              |  2 ++
 qdev-monitor.c                |  1 +
 remote/remote-main.c          | 18 ++++++++++-----
 6 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index bcb24f7..68517aa 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -283,13 +283,14 @@ static int remote_spawn(PCIProxyDev *pdev, const char *opts,
                         const char *exec_name, Error **errp)
 {
     pid_t rpid;
-    int fd[2] = {-1, -1};
+    int fd[2], mmio[2];
     Error *local_error = NULL;
     char *argv[64];
     int argc = 0;
     char *sfd;
     char *exec_dir;
     int rc = -EINVAL;
+    struct timeval timeout = {.tv_sec = 10, .tv_usec = 0};
 
     if (pdev->managed) {
         /* Child is forked by external program (such as libvirt). */
@@ -302,7 +303,8 @@ static int remote_spawn(PCIProxyDev *pdev, const char *opts,
         return rc;
     }
 
-    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd) ||
+        socketpair(AF_UNIX, SOCK_STREAM, 0, mmio)) {
         error_setg(errp, "Unable to create unix socket.");
         return rc;
     }
@@ -310,6 +312,8 @@ static int remote_spawn(PCIProxyDev *pdev, const char *opts,
     argc = add_argv(exec_dir, argv, argc);
     sfd = g_strdup_printf("%d", fd[1]);
     argc = add_argv(sfd, argv, argc);
+    sfd = g_strdup_printf("%d", mmio[1]);
+    argc = add_argv(sfd, argv, argc);
     argc = make_argv((char *)opts, argv, argc);
 
     /* TODO: Restrict the forked process' permissions and capabilities. */
@@ -318,24 +322,35 @@ static int remote_spawn(PCIProxyDev *pdev, const char *opts,
     if (rpid == -1) {
         error_setg(errp, "Unable to spawn emulation program.");
         close(fd[0]);
-        goto fail;
+        close(fd[1]);
+        close(mmio[0]);
+        close(mmio[1]);
+        return rc;
     }
 
     if (rpid == 0) {
         close(fd[0]);
+        close(mmio[0]);
 
         rc = execv(argv[0], (char *const *)argv);
         exit(1);
     }
     pdev->remote_pid = rpid;
     pdev->socket = fd[0];
+    pdev->mmio_sock = mmio[0];
 
-    rc = 0;
+    rc = setsockopt(mmio[0], SOL_SOCKET, SO_RCVTIMEO, (char *)&timeout,
+                   sizeof(timeout));
+    if (rc < 0) {
+        close(fd[0]);
+        close(mmio[0]);
 
-fail:
-    close(fd[1]);
+        error_setg(errp, "Unable to set timeout for socket");
 
-    return rc;
+        return rc;
+    }
+
+    return 0;
 }
 
 static int get_proxy_sock(PCIDevice *dev)
@@ -523,6 +538,9 @@ static void init_proxy(PCIDevice *dev, char *command, char *exec_name,
     mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
                         pdev->socket);
 
+    mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->mmio,
+                        pdev->mmio_sock);
+
     configure_memory_sync(pdev->sync, pdev->mpqemu_link);
 }
 
@@ -575,10 +593,10 @@ static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
                                 unsigned size, bool memory)
 {
     MPQemuLinkState *mpqemu_link = dev->mpqemu_link;
-    MPQemuMsg msg;
-    int wait;
+    MPQemuMsg msg, ret;
 
     memset(&msg, 0, sizeof(MPQemuMsg));
+    memset(&ret, 0, sizeof(MPQemuMsg));
 
     msg.bytestream = 0;
     msg.size = sizeof(msg.data1);
@@ -590,19 +608,18 @@ static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
         msg.cmd = BAR_WRITE;
         msg.data1.bar_access.val = *val;
     } else {
-        wait = GET_REMOTE_WAIT;
-
         msg.cmd = BAR_READ;
-        msg.num_fds = 1;
-        msg.fds[0] = wait;
     }
 
-    mpqemu_msg_send(&msg, mpqemu_link->com);
+    mpqemu_msg_send(&msg, mpqemu_link->mmio);
 
-    if (!write) {
-        *val = wait_for_remote(wait);
-        PUT_REMOTE_WAIT(wait);
+    if (write) {
+        return;
     }
+
+    mpqemu_msg_recv(&ret, mpqemu_link->mmio);
+
+    *val = ret.data1.mmio_ret.val;
 }
 
 void proxy_default_bar_write(void *opaque, hwaddr addr, uint64_t val,
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index f7666fb..2a2c732 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -58,6 +58,7 @@ struct PCIProxyDev {
     EventNotifier en_ping;
 
     int socket;
+    int mmio_sock;
 
     char *rid;
     char *dev_id;
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index aaaf1a4..3962630 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -61,6 +61,7 @@ typedef enum {
     GET_PCI_INFO,
     RET_PCI_INFO,
     PROXY_PING,
+    MMIO_RETURN,
     MAX,
 } mpqemu_cmd_t;
 
@@ -107,6 +108,10 @@ typedef struct {
 } ret_pci_info_msg_t;
 
 typedef struct {
+    uint64_t val;
+} mmio_ret_msg_t;
+
+typedef struct {
     mpqemu_cmd_t cmd;
     int bytestream;
     size_t size;
@@ -117,6 +122,7 @@ typedef struct {
         bar_access_msg_t bar_access;
         set_irqfd_msg_t set_irqfd;
         ret_pci_info_msg_t ret_pci_info;
+        mmio_ret_msg_t mmio_ret;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
@@ -171,6 +177,7 @@ typedef struct MPQemuLinkState {
     GMainLoop *loop;
 
     MPQemuChannel *com;
+    MPQemuChannel *mmio;
 
     mpqemu_link_callback callback;
 } MPQemuLinkState;
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 73b7032..07a9be9 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -57,6 +57,7 @@ void mpqemu_link_finalize(MPQemuLinkState *s)
     g_main_loop_quit(s->loop);
 
     mpqemu_destroy_channel(s->com);
+    mpqemu_destroy_channel(s->mmio);
 
     object_unref(OBJECT(s));
 }
@@ -330,6 +331,7 @@ void mpqemu_start_coms(MPQemuLinkState *s)
 {
 
     g_assert(g_source_attach(&s->com->gsrc, s->ctx));
+    g_assert(g_source_attach(&s->mmio->gsrc, s->ctx));
 
     g_main_loop_run(s->loop);
 }
diff --git a/qdev-monitor.c b/qdev-monitor.c
index ccd2ce0..27b2ddc 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -730,6 +730,7 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
     pdev->rid = g_strdup(rid);
     if (old_pdev) {
         pdev->socket = old_pdev->socket;
+        pdev->mmio_sock = old_pdev->mmio_sock;
         pdev->remote_pid = old_pdev->remote_pid;
     } else {
         pdev->socket = managed ? socket : -1;
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 2c05d20..6cfc446 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -104,8 +104,8 @@ static void process_bar_write(MPQemuMsg *msg, Error **errp)
 static void process_bar_read(MPQemuMsg *msg, Error **errp)
 {
     bar_access_msg_t *bar_access = &msg->data1.bar_access;
+    MPQemuMsg ret = { 0 };
     AddressSpace *as;
-    int wait = msg->fds[0];
     MemTxResult res;
     uint64_t val = 0;
 
@@ -139,9 +139,10 @@ static void process_bar_read(MPQemuMsg *msg, Error **errp)
     }
 
 fail:
-    notify_proxy(wait, val);
-
-    PUT_REMOTE_WAIT(wait);
+    ret.cmd = MMIO_RETURN;
+    ret.data1.mmio_ret.val = val;
+    ret.size = sizeof(ret.data1);
+    mpqemu_msg_send(&ret, mpqemu_link->mmio);
 }
 
 static void process_get_pci_info_msg(PCIDevice *pci_dev, MPQemuMsg *msg)
@@ -456,7 +457,14 @@ int main(int argc, char *argv[])
 
     mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, fd);
 
-    parse_cmdline(argc - 2, argv + 2, NULL);
+    fd = qemu_parse_fd(argv[2]);
+    if (fd == -1) {
+        printf("Failed to parse fd for remote process.\n");
+        return -EINVAL;
+    }
+    mpqemu_init_channel(mpqemu_link, &mpqemu_link->mmio, fd);
+
+    parse_cmdline(argc - 3, argv + 3, NULL);
 
     mpqemu_link_set_callback(mpqemu_link, process_msg);
 
-- 
1.8.3.1


