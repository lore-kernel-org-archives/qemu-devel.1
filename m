Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED850C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 05:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C1D2064C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 05:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAsFp3fK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C1D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3v7t-0004Vm-PD
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 00:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j3v76-0003Cv-MA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j3v74-0004SR-0D
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:08:03 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j3v73-0004S9-QM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:08:01 -0500
Received: by mail-pj1-x1043.google.com with SMTP id n96so476019pjc.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 21:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RRDnThdt4ySg1vAIm76nnPSu+KXuwzNmopRaMhLWftw=;
 b=EAsFp3fKmIwYgvF6aSxlmiPd/zxa0+CObhm7eG82EYvKDywtztnWJRdycQIYmO18iC
 P1l2SQ+NQyJ2MAmBsk/du5B1tM5pqI77/Px0bz8pf1sc9G30lI3gooO1hIHkqeDZjIHl
 BfxyUIP5FE42CegN/moKY7UYKh0mLJY+HYFu8/OEsgmZiFBMtF2hRI8idcOjxfNdA6zO
 SwbUiklncxMUKGme0YSB0BN6wxmIGSeXp6SVRm9hGR45/Ygqzgyr4z2g9sXrUk0z1Kht
 OOmI+jUd4O5HrZy69WvPF8SSgPf+vsXTUJ8IYL+LeUINsYl329qtANQiRPaKfvEb/ABq
 rWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RRDnThdt4ySg1vAIm76nnPSu+KXuwzNmopRaMhLWftw=;
 b=ogwHUXVr5smUM9xmCueQjFIZMlwSwRaQmExegukqhEIe3vYK9Xi6zznmza5ScxeYRc
 1F9yRlZf/abf5ocMjecDxEFElv1PN2UYOXq9QlDmBHrYwgRfyeXNphth7ZAKJ5zps6U5
 hLhuoR+dS+r9++Y8TMnHS8QkHrNe6GNLHv1IQyzYaGtw+CTP+7DxNjCY8rGymYAlLlrZ
 QfQMT1fdfIO/JGlOsS+DZA7H7pyGi41XLq1TfJsdFrJSr+8nzowumsy2Tbx+Ckhk6K9F
 5ghSXNQoW2PZWPvZe3ogylbZ33D+giEZmfG9J3/Hiik5L7uo4uef03PKO87qVOxnUTUa
 yG9w==
X-Gm-Message-State: APjAAAUnl694sDaoXeil9agzoqPNvDu7SdNEToqfXKhjRzcrNnORB6K7
 PeVJwqcuvlI5k0KheeF/EI0QOHXxIGo=
X-Google-Smtp-Source: APXvYqwIO2LKKXy+6YPKahuX6fn+9ISKSUmwb91SZWh2wiVdRwYaLMFbPNo+ilYaTApi+Xa5lIFFzQ==
X-Received: by 2002:a17:90a:1ac9:: with SMTP id
 p67mr467955pjp.51.1582002480501; 
 Mon, 17 Feb 2020 21:08:00 -0800 (PST)
Received: from localhost.localdomain ([2402:9e80:0:1000::1:c192])
 by smtp.googlemail.com with ESMTPSA id 3sm1181613pjg.27.2020.02.17.21.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 21:07:59 -0800 (PST)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/5] extend libvhost to support IOThread and coroutine
Date: Tue, 18 Feb 2020 13:07:07 +0800
Message-Id: <20200218050711.8133-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200218050711.8133-1-coiby.xu@gmail.com>
References: <20200218050711.8133-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

Previously libvhost dispatch events in its own GMainContext. Now vhost-user
client's kick event can be dispatched in block device drive's AioContext
thus IOThread is supported. And also allow vu_message_read and
vu_kick_cb to be replaced so QEMU can run them as coroutines.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 contrib/libvhost-user/libvhost-user.c | 54 ++++++++++++++++++++++++---
 contrib/libvhost-user/libvhost-user.h | 38 ++++++++++++++++++-
 2 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index b89bf18501..f95664bb22 100644
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
@@ -260,7 +258,7 @@ have_userfault(void)
 }
 
 static bool
-vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+vu_message_read_(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 {
     char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] = { };
     struct iovec iov = {
@@ -328,6 +326,17 @@ fail:
     return false;
 }
 
+static bool vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    vu_read_msg_cb read_msg;
+    if (dev->co_iface) {
+        read_msg = dev->co_iface->read_msg;
+    } else {
+        read_msg = vu_message_read_;
+    }
+    return read_msg(dev, conn_fd, vmsg);
+}
+
 static bool
 vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
 {
@@ -1075,9 +1084,14 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
     }
 
     if (dev->vq[index].kick_fd != -1 && dev->vq[index].handler) {
+        if (dev->set_watch_packed_data) {
+            dev->set_watch_packed_data(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
+                                       dev->co_iface->kick_callback,
+                                       (void *)(long)index);
+        } else {
         dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
                        vu_kick_cb, (void *)(long)index);
-
+        }
         DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
                dev->vq[index].kick_fd, index);
     }
@@ -1097,8 +1111,14 @@ void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
     vq->handler = handler;
     if (vq->kick_fd >= 0) {
         if (handler) {
+            if (dev->set_watch_packed_data) {
+                dev->set_watch_packed_data(dev, vq->kick_fd, VU_WATCH_IN,
+                                           dev->co_iface->kick_callback,
+                                           (void *)(long)qidx);
+            } else {
             dev->set_watch(dev, vq->kick_fd, VU_WATCH_IN,
                            vu_kick_cb, (void *)(long)qidx);
+            }
         } else {
             dev->remove_watch(dev, vq->kick_fd);
         }
@@ -1627,6 +1647,12 @@ vu_deinit(VuDev *dev)
         }
 
         if (vq->kick_fd != -1) {
+            /* remove watch for kick_fd
+             * When client process is running in gdb and
+             * quit command is run in gdb, QEMU will still dispatch the event
+             * which will cause segment fault in the callback function
+             */
+            dev->remove_watch(dev, vq->kick_fd);
             close(vq->kick_fd);
             vq->kick_fd = -1;
         }
@@ -1682,7 +1708,7 @@ vu_init(VuDev *dev,
 
     assert(max_queues > 0);
     assert(socket >= 0);
-    assert(set_watch);
+    /* assert(set_watch); */
     assert(remove_watch);
     assert(iface);
     assert(panic);
@@ -1715,6 +1741,24 @@ vu_init(VuDev *dev,
     return true;
 }
 
+bool
+vu_init_packed_data(VuDev *dev,
+        uint16_t max_queues,
+        int socket,
+        vu_panic_cb panic,
+        vu_set_watch_cb_packed_data set_watch_packed_data,
+        vu_remove_watch_cb remove_watch,
+        const VuDevIface *iface,
+        const CoIface *co_iface)
+{
+    if (vu_init(dev, max_queues, socket, panic, NULL, remove_watch, iface)) {
+        dev->set_watch_packed_data = set_watch_packed_data;
+        dev->co_iface = co_iface;
+        return true;
+    }
+    return false;
+}
+
 VuVirtq *
 vu_get_queue(VuDev *dev, int qidx)
 {
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 5cb7708559..6aadeaa0f2 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -30,6 +30,8 @@
 
 #define VHOST_MEMORY_MAX_NREGIONS 8
 
+#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
+
 typedef enum VhostSetConfigType {
     VHOST_SET_CONFIG_TYPE_MASTER = 0,
     VHOST_SET_CONFIG_TYPE_MIGRATION = 1,
@@ -201,6 +203,7 @@ typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
 typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
 typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
                                   int *do_reply);
+typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
 typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool started);
 typedef bool (*vu_queue_is_processed_in_order_cb) (VuDev *dev, int qidx);
 typedef int (*vu_get_config_cb) (VuDev *dev, uint8_t *config, uint32_t len);
@@ -208,6 +211,20 @@ typedef int (*vu_set_config_cb) (VuDev *dev, const uint8_t *data,
                                  uint32_t offset, uint32_t size,
                                  uint32_t flags);
 
+typedef void (*vu_watch_cb_packed_data) (void *packed_data);
+
+typedef void (*vu_set_watch_cb_packed_data) (VuDev *dev, int fd, int condition,
+                                             vu_watch_cb_packed_data cb,
+                                             void *data);
+/*
+ * allowing vu_read_msg_cb and kick_callback to be replaced so QEMU
+ * can run them as coroutines
+ */
+typedef struct CoIface {
+    vu_read_msg_cb read_msg;
+    vu_watch_cb_packed_data kick_callback;
+} CoIface;
+
 typedef struct VuDevIface {
     /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
     vu_get_features_cb get_features;
@@ -372,7 +389,8 @@ struct VuDev {
     /* @set_watch: add or update the given fd to the watch set,
      * call cb when condition is met */
     vu_set_watch_cb set_watch;
-
+    /* AIO dispatch will only one data pointer to callback function */
+    vu_set_watch_cb_packed_data set_watch_packed_data;
     /* @remove_watch: remove the given fd from the watch set */
     vu_remove_watch_cb remove_watch;
 
@@ -380,7 +398,7 @@ struct VuDev {
      * re-initialize */
     vu_panic_cb panic;
     const VuDevIface *iface;
-
+    const CoIface *co_iface;
     /* Postcopy data */
     int postcopy_ufd;
     bool postcopy_listening;
@@ -417,6 +435,22 @@ bool vu_init(VuDev *dev,
              const VuDevIface *iface);
 
 
+/**
+ * vu_init_packed_data:
+ * Same as vu_init except for set_watch_packed_data which will pack
+ * two parameters into a struct thus QEMU aio_dispatch can pass the
+ * required data to callback function.
+ *
+ * Returns: true on success, false on failure.
+ **/
+bool vu_init_packed_data(VuDev *dev,
+                         uint16_t max_queues,
+                         int socket,
+                         vu_panic_cb panic,
+                         vu_set_watch_cb_packed_data set_watch_packed_data,
+                         vu_remove_watch_cb remove_watch,
+                         const VuDevIface *iface,
+                         const CoIface *co_iface);
 /**
  * vu_deinit:
  * @dev: a VuDev context
-- 
2.25.0


