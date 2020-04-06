Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1783CC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55E5206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pvmIbv9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55E5206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOPt-00022D-06
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGp-0002G6-Q1
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGo-0002M1-HS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGo-0002Ky-8k
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cxbN025132;
 Mon, 6 Apr 2020 09:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=RM+C3xEy7RjPnPzF/4GEN8h76sUo5WL9hA6KDYrbvm0=;
 b=pvmIbv9L0AszPYD2bRI9BXaH2opZmFnPv5/2NR2LR3I6z5KEb9knkZaoNjitZ/JzQuz+
 OUXoZQhrLlpJJmKPCwUrkpHK3vYojDqX1x1SeVhE+HJWCevel9IILoYT6eI2KxvA9u+P
 WISninIavJBf5TQESoV7YpdoUmHTjjWIEEhN24R2fd4aij86bkrh+JREPFs7EXQEtgWO
 FjyRQLi9q3LWdM8TNhIBEZfBQbeVlZBb+Ak6IhgI00NMDclDX45RoI4tFPWSSagoaDak
 hMbsrcHz2SyX7/oT28ChcujgJYD2+9lgi70x2QwCQIz2IEft76CCMw/MjpJNzICti0u+ fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 306jvmwr5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cgIY092169;
 Mon, 6 Apr 2020 09:42:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 3073spk68m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:05 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369g3vr006937;
 Mon, 6 Apr 2020 09:42:03 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:03 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 19/36] multi-process: Connect Proxy Object with device in
 the remote process
Date: Mon,  6 Apr 2020 02:41:09 -0700
Message-Id: <0b56423127fe29ddd74ce1162038d028f9ba7fe3.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=3 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=3
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
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

From: Jagannathan Raman <jag.raman@oracle.com>

Send a message to the remote process to connect PCI device with the
corresponding Proxy object in QEMU

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/proxy/qemu-proxy.c    | 34 +++++++++++++++++++++++++++++++
 include/io/mpqemu-link.h |  5 +++++
 io/mpqemu-link.c         |  3 +++
 remote/remote-main.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 40bf56fd37..9b5e429a88 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -17,11 +17,45 @@
 static void proxy_set_socket(Object *obj, const char *str, Error **errp)
 {
     PCIProxyDev *pdev = PCI_PROXY_DEV(obj);
+    DeviceState *dev = DEVICE(obj);
+    MPQemuMsg msg = { 0 };
+    int wait, fd[2];
 
     pdev->socket = atoi(str);
 
     mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
                         pdev->socket);
+
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
+        error_setg(errp, "Failed to create socket for device channel");
+        return;
+    }
+
+    wait = GET_REMOTE_WAIT;
+
+    msg.cmd = CONNECT_DEV;
+    msg.bytestream = 1;
+    msg.data2 = (uint8_t *)g_strdup(dev->id);
+    msg.size = sizeof(msg.data2);
+    msg.num_fds = 2;
+    msg.fds[0] = wait;
+    msg.fds[1] = fd[1];
+
+    mpqemu_msg_send(&msg, pdev->mpqemu_link->com);
+
+    if (wait_for_remote(wait)) {
+        error_setg(errp, "Failed to connect device to the remote");
+        close(fd[0]);
+    } else {
+        mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->dev,
+                            fd[0]);
+    }
+
+    PUT_REMOTE_WAIT(wait);
+
+    close(fd[1]);
+
+    g_free(msg.data2);
 }
 
 static void proxy_init(Object *obj)
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 73cc59b874..ebae9afc45 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -38,6 +38,7 @@
 typedef enum {
     INIT = 0,
     SYNC_SYSMEM,
+    CONNECT_DEV,
     MAX,
 } mpqemu_cmd_t;
 
@@ -120,8 +121,12 @@ struct MPQemuLinkState {
     GMainLoop *loop;
 
     MPQemuChannel *com;
+    MPQemuChannel *dev;
 
     mpqemu_link_callback callback;
+
+    void *opaque;
+    QemuThread thread;
 };
 
 MPQemuLinkState *mpqemu_link_create(void);
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index 330a6deffe..b395869a22 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -46,6 +46,9 @@ MPQemuLinkState *mpqemu_link_create(void)
     MPQemuLinkState *link = MPQEMU_LINK(object_new(TYPE_MPQEMU_LINK));
 
     link->com = NULL;
+    link->dev = NULL;
+
+    link->opaque = NULL;
 
     return link;
 }
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 51595f3141..22319cb5ea 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -34,8 +34,48 @@
 #include "block/block.h"
 #include "exec/ramlist.h"
 
+static void process_msg(GIOCondition cond, MPQemuLinkState *link,
+                        MPQemuChannel *chan);
+
 static MPQemuLinkState *mpqemu_link;
 
+#define LINK_TO_DEV(link) ((PCIDevice *)link->opaque)
+
+static gpointer dev_thread(gpointer data)
+{
+    MPQemuLinkState *link = data;
+
+    mpqemu_start_coms(link, link->dev);
+
+    return NULL;
+}
+
+static void process_connect_dev_msg(MPQemuMsg *msg)
+{
+    char *devid = (char *)msg->data2;
+    MPQemuLinkState *link = NULL;
+    DeviceState *dev = NULL;
+    int wait = msg->fds[0];
+    int ret = 0;
+
+    dev = qdev_find_recursive(sysbus_get_default(), devid);
+    if (!dev) {
+        ret = 0xff;
+        goto exit;
+    }
+
+    link = mpqemu_link_create();
+    link->opaque = (void *)PCI_DEVICE(dev);
+
+    mpqemu_init_channel(link, &link->dev, msg->fds[1]);
+    mpqemu_link_set_callback(link, process_msg);
+    qemu_thread_create(&link->thread, "dev_thread", dev_thread, link,
+                       QEMU_THREAD_JOINABLE);
+
+exit:
+    notify_proxy(wait, ret);
+}
+
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan)
 {
@@ -56,6 +96,9 @@ static void process_msg(GIOCondition cond, MPQemuLinkState *link,
     switch (msg->cmd) {
     case INIT:
         break;
+    case CONNECT_DEV:
+        process_connect_dev_msg(msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
2.25.GIT


