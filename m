Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5E1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25885204EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cv2zke3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25885204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GDE-0001aw-JH
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaR-000880-Ov
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaQ-0000q3-6P
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaP-0000pR-Uk
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KdRYQ067206;
 Tue, 3 Sep 2019 20:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=92lOO3sen5W02+vlyfSiJKk2wS4yY+jdYK76D6K75H0=;
 b=cv2zke3/VhZ2md6Wb5uBVHF8Xd3YBnQxGSG+CYIJK4Mkg2chJK8zKYnuLxGrVQknA50P
 AgvoGviY8qNm9MCxmy9qvFeHwcQPeC5DB2oJLhBwMf0NGU87qzOfQ5ko53pP4FRhurEY
 zpLnvWxDLg4rjDCfqywL5P9b4sr69gzmaqkgKH1S7wG4/N38S3xjqF6wiAVevJyCBfFn
 fjwOxeiCrU18kNmrzwubkl9mqPDKeA7kmNRVk84AtojZYHGiUj/2TVVJk0IATp9Par0f
 Yph/kJh+Al6VAJsb/huXK5dKbFtdCqUeOyLgYQC9BRPO1VfExuFxf4LmVj7Y+OCl0J7H Xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2usy66r2hn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcYNW178177;
 Tue, 3 Sep 2019 20:39:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2us4wegrbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83KdLZZ028933;
 Tue, 3 Sep 2019 20:39:21 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:19 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:38:02 -0400
Message-Id: <6c736da21b554548b7ba2af04fb5eee1cf806883.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030207
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 36/45] multi-process: Use separate MMIO
 communication channel
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using a separate communication channel for MMIO helps
with improving Performance

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 New patch in v3

 hw/proxy/qemu-proxy.c         | 38 ++++++++++++++++++++++++++------------
 include/hw/proxy/qemu-proxy.h |  1 +
 include/io/proxy-link.h       |  7 +++++++
 io/proxy-link.c               |  2 ++
 qdev-monitor.c                |  1 +
 remote/remote-main.c          | 20 ++++++++++++++------
 6 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 699a0b1..db9a208 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -205,20 +205,22 @@ static int make_argv(char *command_str, char **argv, int argc)
 int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
 {
     pid_t rpid;
-    int fd[2] = {-1, -1};
+    int fd[2], mmio[2];
     Error *local_error = NULL;
     char *argv[64];
     int argc = 0, _argc;
     char *sfd;
     char *exec_dir;
     int rc = -EINVAL;
+    struct timeval timeout = {.tv_sec = 10, .tv_usec = 0};
 
     if (pdev->managed) {
         /* Child is forked by external program (such as libvirt). */
         return rc;
     }
 
-    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd) ||
+        socketpair(AF_UNIX, SOCK_STREAM, 0, mmio)) {
         error_setg(errp, "Unable to create unix socket.");
         return rc;
     }
@@ -226,6 +228,8 @@ int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
     argc = add_argv(exec_dir, argv, argc);
     sfd = g_strdup_printf("%d", fd[1]);
     argc = add_argv(sfd, argv, argc);
+    sfd = g_strdup_printf("%d", mmio[1]);
+    argc = add_argv(sfd, argv, argc);
     _argc = argc;
     argc = make_argv((char *)command, argv, argc);
 
@@ -235,22 +239,32 @@ int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
     if (rpid == -1) {
         error_setg(errp, "Unable to spawn emulation program.");
         close(fd[0]);
+        close(mmio[0]);
         goto fail;
     }
 
     if (rpid == 0) {
         close(fd[0]);
+        close(mmio[0]);
         execvp(argv[0], (char *const *)argv);
         exit(1);
     }
     pdev->remote_pid = rpid;
     pdev->rsocket = fd[1];
     pdev->socket = fd[0];
+    pdev->mmio_sock = mmio[0];
+
+    if (setsockopt(mmio[0], SOL_SOCKET, SO_RCVTIMEO, (char *)&timeout,
+                   sizeof(timeout)) < 0) {
+        error_setg(errp, "Unable to set timeout for socket");
+        goto fail;
+    }
 
     rc = 0;
 
 fail:
     close(fd[1]);
+    close(mmio[1]);
 
     for (int i = 0; i < _argc; i++) {
         g_free(argv[i]);
@@ -466,6 +480,9 @@ static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **e
     proxy_link_init_channel(pdev->proxy_link, &pdev->proxy_link->com,
                             pdev->socket);
 
+    proxy_link_init_channel(pdev->proxy_link, &pdev->proxy_link->mmio,
+                            pdev->mmio_sock);
+
     configure_memory_sync(pdev->sync, pdev->proxy_link);
 }
 
@@ -514,8 +531,7 @@ static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
                                 unsigned size, bool memory)
 {
     ProxyLinkState *proxy_link;
-    ProcMsg msg;
-    int wait;
+    ProcMsg msg, ret;
 
     proxy_link = dev->proxy_link;
 
@@ -531,11 +547,7 @@ static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
         msg.cmd = BAR_WRITE;
         msg.data1.bar_access.val = *val;
     } else {
-        wait = GET_REMOTE_WAIT;
-
         msg.cmd = BAR_READ;
-        msg.num_fds = 1;
-        msg.fds[0] = wait;
     }
 
     if (dev->dev_id) {
@@ -546,17 +558,19 @@ static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
         msg.size_id = 0;
     }
 
-    proxy_proc_send(proxy_link, &msg, proxy_link->com);
+    proxy_proc_send(proxy_link, &msg, proxy_link->mmio);
 
-    if (!write) {
-        *val = wait_for_remote(wait);
-        PUT_REMOTE_WAIT(wait);
+    if (write) {
+        return;
     }
 
     if (msg.id) {
         free(msg.id);
     }
 
+    proxy_proc_recv(proxy_link, &ret, proxy_link->mmio);
+
+    *val = ret.data1.mmio_ret.val;
 }
 
 void proxy_default_bar_write(PCIProxyDev *dev, MemoryRegion *mr, hwaddr addr,
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index fb408cf..a03c6cc 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -59,6 +59,7 @@ typedef struct PCIProxyDev {
     pid_t remote_pid;
     int rsocket;
     int socket;
+    int mmio_sock;
 
     char *rid;
 
diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
index ae98eac..32b2c1a 100644
--- a/include/io/proxy-link.h
+++ b/include/io/proxy-link.h
@@ -75,6 +75,7 @@ typedef enum {
     DEVICE_ADD,
     DEVICE_DEL,
     PROXY_PING,
+    MMIO_RETURN,
     MAX,
 } proc_cmd_t;
 
@@ -108,6 +109,10 @@ typedef struct {
 } set_irqfd_msg_t;
 
 typedef struct {
+    uint64_t val;
+} mmio_ret_msg_t;
+
+typedef struct {
     proc_cmd_t cmd;
     int bytestream;
     size_t size;
@@ -118,6 +123,7 @@ typedef struct {
         sync_sysmem_msg_t sync_sysmem;
         bar_access_msg_t bar_access;
         set_irqfd_msg_t set_irqfd;
+        mmio_ret_msg_t mmio_ret;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
@@ -170,6 +176,7 @@ struct ProxyLinkState {
     GMainLoop *loop;
 
     ProcChannel *com;
+    ProcChannel *mmio;
 
     proxy_link_callback callback;
 };
diff --git a/io/proxy-link.c b/io/proxy-link.c
index 6f60117..3ca0185 100644
--- a/io/proxy-link.c
+++ b/io/proxy-link.c
@@ -74,6 +74,7 @@ void proxy_link_finalize(ProxyLinkState *s)
     g_main_loop_quit(s->loop);
 
     proxy_link_destroy_channel(s->com);
+    proxy_link_destroy_channel(s->mmio);
 
     object_unref(OBJECT(s));
 }
@@ -356,6 +357,7 @@ void start_handler(ProxyLinkState *s)
 {
 
     g_assert(g_source_attach(&s->com->gsrc, s->ctx));
+    g_assert(g_source_attach(&s->mmio->gsrc, s->ctx));
 
     g_main_loop_run(s->loop);
 }
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 69e467e..f1065af 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -710,6 +710,7 @@ DeviceState *qdev_proxy_add(const char *rid, const char *id, char *bus,
     if (old_pdev) {
         pdev->rsocket = old_pdev->rsocket;
         pdev->socket = old_pdev->socket;
+        pdev->mmio_sock = old_pdev->mmio_sock;
         pdev->remote_pid = old_pdev->remote_pid;
     } else {
         pdev->rsocket = managed ? rsocket : -1;
diff --git a/remote/remote-main.c b/remote/remote-main.c
index f0a4de9..2a9ebae 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -180,8 +180,8 @@ static void process_bar_write(ProcMsg *msg, Error **errp)
 static void process_bar_read(ProcMsg *msg, Error **errp)
 {
     bar_access_msg_t *bar_access = &msg->data1.bar_access;
+    ProcMsg ret = { 0 };
     AddressSpace *as;
-    int wait = msg->fds[0];
     MemTxResult res;
     uint64_t val = 0;
 
@@ -215,9 +215,10 @@ static void process_bar_read(ProcMsg *msg, Error **errp)
     }
 
 fail:
-    notify_proxy(wait, val);
-
-    PUT_REMOTE_WAIT(wait);
+    ret.cmd = MMIO_RETURN;
+    ret.data1.mmio_ret.val = val;
+    ret.size = sizeof(ret.data1);
+    proxy_proc_send(proxy_link, &ret, proxy_link->mmio);
 }
 
 static void process_device_add_msg(ProcMsg *msg)
@@ -581,10 +582,17 @@ int main(int argc, char *argv[], char **envp)
         printf("Failed to parse fd for remote process.\n");
         return -EINVAL;
     }
-
     proxy_link_init_channel(proxy_link, &proxy_link->com, fd);
 
-    parse_cmdline(argc - 2, argv + 2, NULL);
+    fd = qemu_parse_fd(argv[2]);
+    if (fd == -1) {
+        printf("Failed to parse fd for remote process.\n");
+        return -EINVAL;
+    }
+    proxy_link_init_channel(proxy_link, &proxy_link->mmio, fd);
+
+    parse_cmdline(argc - 3, argv + 3, NULL);
+
     qemu_mutex_init(&remote_ds_lock);
     QLIST_INIT(&pci_devs_head);
 
-- 
1.8.3.1


