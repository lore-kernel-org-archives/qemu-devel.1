Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C9BC18E5A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4942072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTsUpbvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4942072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBFK3-0006eS-Lt
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 06:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1jBFH3-0001t7-7E
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1jBFH1-0008BX-Le
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:37 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1jBFH1-0008BG-F8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 06:04:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id b1so4481758pgm.8
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wTo8h7gb61ffT8pheYbd6IIprBqt/dCew1k7yKHmFdU=;
 b=eTsUpbvsFi3EkKEORm4dT2251jhNJuU/KQlEPmFTe3kyTlENgYWhy1Wi59VXh6LPSz
 4EhUNEzsyjV1Oq3yCK4FHUW1rVenx9j5elu7GSG7n8QS3cO4mDfAVao7mNidtDUtESIE
 VnZ5A8W66oXvCkbsCCkKh+aE9uv6bAGKaIcwDbQd2DoWjtxUqPjvxQ0BNw7WGCVm+2xX
 66JMYe3+H1+rBMgAImrJ1X88k1q2NvjQVyQBnyTxz4h4aZfF3/Xh2HYu3vx5qVlUxMWt
 0wM2icyJmhZLL8d+T3VcvdsgxH//XuxjHJ3fOGjkqUxdRSI1BcEhSle+YHJPVomqfl4e
 RmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wTo8h7gb61ffT8pheYbd6IIprBqt/dCew1k7yKHmFdU=;
 b=dF7bfYTkH2jfy0OCZ2TuK4zD9fSawKZEx83+6kb6CoJLG8Hb5ipZtkareMiTFODBaf
 DAjwxewvud8ty8KD4gekScVU3wNU5hkezpysTqZ9yJ3gIPpZhyYy2VJAKZIvik4xYbtM
 ozq1dMsOkHAyZXsjONdeaMteaGU6pLJAw5m74BSiPlzn2FNPwVdBnJir9o3V5Ag2NWg1
 S72d1NL8RAIbFYBoW+fpiaX7UVS+6fY9o9b+YUSXbKSQ9ICSgFam4J7WHqiEQTzD8IMs
 hsUF0tbtDR2+279Jk1WLrsoLdT9wueltxAiDRXc02YAzMuHKfh8HUXxtERZGCKSmJZES
 9baw==
X-Gm-Message-State: ANhLgQ0HnTLe8hsgLnUZSQqlnIIOcaGsERUUxt+h5XB31Y/hycxEoE48
 hzxpgg7cFxeruCH880NXB0kNgVdn9D6HQA==
X-Google-Smtp-Source: ADFU+vspHjThR8VKVeZIHAzggPq9OdXRBveJ7R35d3pOQORpnAQPGlnudJvpeL2fJAnDOkCB+BL2Ig==
X-Received: by 2002:a63:ee02:: with SMTP id e2mr4871289pgi.183.1583748274138; 
 Mon, 09 Mar 2020 03:04:34 -0700 (PDT)
Received: from localhost.localdomain
 (tunnel571398-pt.tunnel.tserv14.sea1.ipv6.he.net. [2001:470:a:247::2])
 by smtp.googlemail.com with ESMTPSA id s21sm16077377pfd.99.2020.03.09.03.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 03:04:33 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/5] allow vu_message_read to be replaced
Date: Mon,  9 Mar 2020 18:03:38 +0800
Message-Id: <20200309100342.14921-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309100342.14921-1-coiby.xu@gmail.com>
References: <20200309100342.14921-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, Coiby Xu <coiby.xu@gmail.com>,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow vu_message_read to be replaced by one which will make use of the
QIOChannel functions. Thus reading vhost-user message won't stall the
guest.

Remove watch for kick fd in vu_deinit. When QEMU as vhost-user client
process is restarted in gdb, QEMU as vhost-user-server will still dispatch
the event. When vu_kick_cb is trying to access vq->kick_fd, a segmentation
fault will occur since vq has become a NULL pointer.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 contrib/libvhost-user/libvhost-user-glib.c |  2 +-
 contrib/libvhost-user/libvhost-user.c      | 11 ++++++-----
 contrib/libvhost-user/libvhost-user.h      |  6 ++++++
 tests/vhost-user-bridge.c                  |  2 ++
 tools/virtiofsd/fuse_virtio.c              |  4 ++--
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhost-user/libvhost-user-glib.c
index 53f1ca4cdd..0df2ec9271 100644
--- a/contrib/libvhost-user/libvhost-user-glib.c
+++ b/contrib/libvhost-user/libvhost-user-glib.c
@@ -147,7 +147,7 @@ vug_init(VugDev *dev, uint16_t max_queues, int socket,
     g_assert(dev);
     g_assert(iface);

-    if (!vu_init(&dev->parent, max_queues, socket, panic, set_watch,
+    if (!vu_init(&dev->parent, max_queues, socket, panic, NULL, set_watch,
                  remove_watch, iface)) {
         return false;
     }
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 3bca996c62..0c7368baa2 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -67,8 +67,6 @@
 /* The version of inflight buffer */
 #define INFLIGHT_VERSION 1

-#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
-
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION 1
 #define LIBVHOST_USER_DEBUG 0
@@ -412,7 +410,7 @@ vu_process_message_reply(VuDev *dev, const VhostUserMsg *vmsg)
         goto out;
     }

-    if (!vu_message_read(dev, dev->slave_fd, &msg_reply)) {
+    if (!dev->read_msg(dev, dev->slave_fd, &msg_reply)) {
         goto out;
     }

@@ -647,7 +645,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
     /* Wait for QEMU to confirm that it's registered the handler for the
      * faults.
      */
-    if (!vu_message_read(dev, dev->sock, vmsg) ||
+    if (!dev->read_msg(dev, dev->sock, vmsg) ||
         vmsg->size != sizeof(vmsg->payload.u64) ||
         vmsg->payload.u64 != 0) {
         vu_panic(dev, "failed to receive valid ack for postcopy set-mem-table");
@@ -1653,7 +1651,7 @@ vu_dispatch(VuDev *dev)
     int reply_requested;
     bool need_reply, success = false;

-    if (!vu_message_read(dev, dev->sock, &vmsg)) {
+    if (!dev->read_msg(dev, dev->sock, &vmsg)) {
         goto end;
     }

@@ -1704,6 +1702,7 @@ vu_deinit(VuDev *dev)
         }

         if (vq->kick_fd != -1) {
+            dev->remove_watch(dev, vq->kick_fd);
             close(vq->kick_fd);
             vq->kick_fd = -1;
         }
@@ -1751,6 +1750,7 @@ vu_init(VuDev *dev,
         uint16_t max_queues,
         int socket,
         vu_panic_cb panic,
+        vu_read_msg_cb read_msg,
         vu_set_watch_cb set_watch,
         vu_remove_watch_cb remove_watch,
         const VuDevIface *iface)
@@ -1768,6 +1768,7 @@ vu_init(VuDev *dev,

     dev->sock = socket;
     dev->panic = panic;
+    dev->read_msg = read_msg ? read_msg : vu_message_read;
     dev->set_watch = set_watch;
     dev->remove_watch = remove_watch;
     dev->iface = iface;
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 6fc8000e99..7e3f0c8598 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -30,6 +30,8 @@

 #define VHOST_MEMORY_MAX_NREGIONS 8

+#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
+
 typedef enum VhostSetConfigType {
     VHOST_SET_CONFIG_TYPE_MASTER = 0,
     VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
@@ -205,6 +207,7 @@ typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
 typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
 typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
                                   int *do_reply);
+typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
 typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool started);
 typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx);
 typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t len);
@@ -373,6 +376,8 @@ struct VuDev {
     bool broken;
     uint16_t max_queues;

+    /* allowing vu_read_msg_cb to be replaced */
+    vu_read_msg_cb read_msg;
     /* @set_watch: add or update the given fd to the watch set,
      * call cb when condition is met */
     vu_set_watch_cb set_watch;
@@ -416,6 +421,7 @@ bool vu_init(VuDev *dev,
              uint16_t max_queues,
              int socket,
              vu_panic_cb panic,
+             vu_read_msg_cb read_msg,
              vu_set_watch_cb set_watch,
              vu_remove_watch_cb remove_watch,
              const VuDevIface *iface);
diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 6c3d490611..bd43607a4d 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -520,6 +520,7 @@ vubr_accept_cb(int sock, void *ctx)
                  VHOST_USER_BRIDGE_MAX_QUEUES,
                  conn_fd,
                  vubr_panic,
+                 NULL,
                  vubr_set_watch,
                  vubr_remove_watch,
                  &vuiface)) {
@@ -573,6 +574,7 @@ vubr_new(const char *path, bool client)
                      VHOST_USER_BRIDGE_MAX_QUEUES,
                      dev->sock,
                      vubr_panic,
+                     NULL,
                      vubr_set_watch,
                      vubr_remove_watch,
                      &vuiface)) {
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 3b6d16a041..666945c897 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -980,8 +980,8 @@ int virtio_session_mount(struct fuse_session *se)
     se->vu_socketfd = data_sock;
     se->virtio_dev->se = se;
     pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
-    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, fv_set_watch,
-            fv_remove_watch, &fv_iface);
+    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
+            fv_set_watch, fv_remove_watch, &fv_iface);

     return 0;
 }
--
2.25.1


