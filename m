Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903D6C83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 00:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438992070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 00:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC/VAB8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438992070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTEX9-0001hG-9z
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 20:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jTEVf-0007iJ-Sv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jTEVe-0007H5-0f
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:54:03 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jTEVd-0007Br-Gs
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 20:54:01 -0400
Received: by mail-pl1-x642.google.com with SMTP id w3so7666463plz.5
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 17:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=9FgnM4HvErXKWZJbbQvfcjSzozlq0cqUHZYYv5AzslI=;
 b=fC/VAB8lBsZlb18inIvhMBhcSiJ35XGETryBYVCOXrWdY9fOpf+p1f66F2pwytntRh
 lJLUChw7MUlI/ju65ks68FB+0R736dDukarSpfc3TM9fj2VL0XxTc72Grd0qNJaJW6Fx
 Kj85JWn/K/S+70A3zd+xGseyN2UT9voUCsoPnmeNAbnEvoNDQ/OPjmCbmaiRx2s0w2dE
 /bKjuPPRTHat9QnF9/fUnenBZPe6WCsTk6RDwU+OhNbQjTfTP+T6zoPiCrE53okS3hOu
 Lp9cFjJwCrjVFsBrkJDeuKVhtCHd8rQgFW0mIASXgalc9a6GPGKAFp7Zy0M6VZUrhM/p
 7xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=9FgnM4HvErXKWZJbbQvfcjSzozlq0cqUHZYYv5AzslI=;
 b=YLZsEWAVAdAoJXiZhz4+VG1Ux7lSBgiTmQzDzZQvmCrhk6dvIvOm4rZ/1T8xnBKusu
 EZnz1TDPQZ/jM4ijxyJRw4ZACilm9y9vHwEfkM/MuckTsDqu8xRbSc4SwUDHeDMqR8+f
 2ozdiZQ43WqCYBKQP8SIWYccypDB3rCXs6L0M/IMeSh6N/ZGJmrlnmBIe2mu985nMQad
 fMCCjaZ8Dji4UicjXvyi3pABprbLjRj7pt/0+XnhFv8yG9HDlmqffyDyJb59Xeyg9Afp
 xyT/XnKuwlDCqPe3dbe6qOhA9HiBgcHvE0j2PbKHtZQr1qcsD4O1AIxlZ+xKs1FcvxFh
 m5bQ==
X-Gm-Message-State: AGi0PubP+n4aYFI9Zf822tGCVPDjVSkW0XRC5VAMHiE0pkGLkotUd77I
 Ewck4NZGDAkwHPZ0JLxlaHc=
X-Google-Smtp-Source: APiQypIE+5e36IJ+32l2laknrspbcxX7sbnim0PteZ/7159B8W+3Yg2zIYajiKeGZ0SpCmHfGo5w0w==
X-Received: by 2002:a17:902:bd81:: with SMTP id
 q1mr16611569pls.46.1588035239608; 
 Mon, 27 Apr 2020 17:53:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id u9sm12857569pfn.197.2020.04.27.17.53.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Apr 2020 17:53:59 -0700 (PDT)
Subject: [PATCH v23 QEMU 3/5] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Mon, 27 Apr 2020 17:53:58 -0700
Message-ID: <20200428005358.6158.80784.stgit@localhost.localdomain>
In-Reply-To: <20200428005134.6158.88521.stgit@localhost.localdomain>
References: <20200428005134.6158.88521.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

In an upcoming patch a feature named Free Page Reporting is about to be
added. In order to avoid any confusion we should drop the use of the word
'report' when referring to Free Page Hinting. So what this patch does is go
through and replace all instances of 'report' with 'hint" when we are
referring to free page hinting.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c         |   78 ++++++++++++++++++------------------
 include/hw/virtio/virtio-balloon.h |   20 +++++----
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc930..a209706b4d8d 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -466,21 +466,21 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             ret = false;
             goto out;
         }
-        if (id == dev->free_page_report_cmd_id) {
-            dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
+        if (id == dev->free_page_hint_cmd_id) {
+            dev->free_page_hint_status = FREE_PAGE_HINT_S_START;
         } else {
             /*
              * Stop the optimization only when it has started. This
              * avoids a stale stop sign for the previous command.
              */
-            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
-                dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+            if (dev->free_page_hint_status == FREE_PAGE_HINT_S_START) {
+                dev->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
             }
         }
     }
 
     if (elem->in_num) {
-        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
+        if (dev->free_page_hint_status == FREE_PAGE_HINT_S_START) {
             qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
                                       elem->in_sg[0].iov_len);
         }
@@ -506,11 +506,11 @@ static void virtio_ballloon_get_free_page_hints(void *opaque)
         qemu_mutex_unlock(&dev->free_page_lock);
         virtio_notify(vdev, vq);
       /*
-       * Start to poll the vq once the reporting started. Otherwise, continue
+       * Start to poll the vq once the hinting started. Otherwise, continue
        * only when there are entries on the vq, which need to be given back.
        */
     } while (continue_to_get_hints ||
-             dev->free_page_report_status == FREE_PAGE_REPORT_S_START);
+             dev->free_page_hint_status == FREE_PAGE_HINT_S_START);
     virtio_queue_set_notification(vq, 1);
 }
 
@@ -531,14 +531,14 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
-    if (s->free_page_report_cmd_id == UINT_MAX) {
-        s->free_page_report_cmd_id =
-                       VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
+    if (s->free_page_hint_cmd_id == UINT_MAX) {
+        s->free_page_hint_cmd_id =
+                       VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
     } else {
-        s->free_page_report_cmd_id++;
+        s->free_page_hint_cmd_id++;
     }
 
-    s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
+    s->free_page_hint_status = FREE_PAGE_HINT_S_REQUESTED;
     virtio_notify_config(vdev);
 }
 
@@ -546,18 +546,18 @@ static void virtio_balloon_free_page_stop(VirtIOBalloon *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    if (s->free_page_report_status != FREE_PAGE_REPORT_S_STOP) {
+    if (s->free_page_hint_status != FREE_PAGE_HINT_S_STOP) {
         /*
          * The lock also guarantees us that the
          * virtio_ballloon_get_free_page_hints exits after the
-         * free_page_report_status is set to S_STOP.
+         * free_page_hint_status is set to S_STOP.
          */
         qemu_mutex_lock(&s->free_page_lock);
         /*
-         * The guest hasn't done the reporting, so host sends a notification
-         * to the guest to actively stop the reporting.
+         * The guest isn't done hinting, so send a notification
+         * to the guest to actively stop the hinting.
          */
-        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
+        s->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
         qemu_mutex_unlock(&s->free_page_lock);
         virtio_notify_config(vdev);
     }
@@ -567,15 +567,15 @@ static void virtio_balloon_free_page_done(VirtIOBalloon *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
-    s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
+    s->free_page_hint_status = FREE_PAGE_HINT_S_DONE;
     virtio_notify_config(vdev);
 }
 
 static int
-virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
+virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data)
 {
     VirtIOBalloon *dev = container_of(n, VirtIOBalloon,
-                                      free_page_report_notify);
+                                      free_page_hint_notify);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     PrecopyNotifyData *pnd = data;
 
@@ -624,7 +624,7 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
     if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         return offsetof(struct virtio_balloon_config, poison_val);
     }
-    return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
+    return offsetof(struct virtio_balloon_config, free_page_hint_cmd_id);
 }
 
 static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
@@ -635,14 +635,14 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
 
-    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
-        config.free_page_report_cmd_id =
-                       cpu_to_le32(dev->free_page_report_cmd_id);
-    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
-        config.free_page_report_cmd_id =
+    if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
+        config.free_page_hint_cmd_id =
+                       cpu_to_le32(dev->free_page_hint_cmd_id);
+    } else if (dev->free_page_hint_status == FREE_PAGE_HINT_S_STOP) {
+        config.free_page_hint_cmd_id =
                        cpu_to_le32(VIRTIO_BALLOON_CMD_ID_STOP);
-    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_DONE) {
-        config.free_page_report_cmd_id =
+    } else if (dev->free_page_hint_status == FREE_PAGE_HINT_S_DONE) {
+        config.free_page_hint_cmd_id =
                        cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
     }
 
@@ -743,14 +743,14 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
     return 0;
 }
 
-static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
+static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
     .name = "virtio-balloon-device/free-page-report",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = virtio_balloon_free_page_support,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
-        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
+        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
+        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -766,7 +766,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * []) {
-        &vmstate_virtio_balloon_free_page_report,
+        &vmstate_virtio_balloon_free_page_hint,
         NULL
     }
 };
@@ -797,12 +797,12 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
                            VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
                                            virtio_balloon_handle_free_page_vq);
-        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
-        s->free_page_report_cmd_id =
-                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
-        s->free_page_report_notify.notify =
-                                       virtio_balloon_free_page_report_notify;
-        precopy_add_notifier(&s->free_page_report_notify);
+        s->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
+        s->free_page_hint_cmd_id =
+                           VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
+        s->free_page_hint_notify.notify =
+                                       virtio_balloon_free_page_hint_notify;
+        precopy_add_notifier(&s->free_page_hint_notify);
         if (s->iothread) {
             object_ref(OBJECT(s->iothread));
             s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
@@ -827,7 +827,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev, Error **errp)
     if (virtio_balloon_free_page_support(s)) {
         qemu_bh_delete(s->free_page_bh);
         virtio_balloon_free_page_stop(s);
-        precopy_remove_notifier(&s->free_page_report_notify);
+        precopy_remove_notifier(&s->free_page_hint_notify);
     }
     balloon_stats_destroy_timer(s);
     qemu_remove_balloon_handler(s);
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d1c968d2376e..108cff97e71a 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -23,7 +23,7 @@
 #define VIRTIO_BALLOON(obj) \
         OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
 
-#define VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN 0x80000000
+#define VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN 0x80000000
 
 typedef struct virtio_balloon_stat VirtIOBalloonStat;
 
@@ -33,20 +33,20 @@ typedef struct virtio_balloon_stat_modern {
        uint64_t val;
 } VirtIOBalloonStatModern;
 
-enum virtio_balloon_free_page_report_status {
-    FREE_PAGE_REPORT_S_STOP = 0,
-    FREE_PAGE_REPORT_S_REQUESTED = 1,
-    FREE_PAGE_REPORT_S_START = 2,
-    FREE_PAGE_REPORT_S_DONE = 3,
+enum virtio_balloon_free_page_hint_status {
+    FREE_PAGE_HINT_S_STOP = 0,
+    FREE_PAGE_HINT_S_REQUESTED = 1,
+    FREE_PAGE_HINT_S_START = 2,
+    FREE_PAGE_HINT_S_DONE = 3,
 };
 
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
     VirtQueue *ivq, *dvq, *svq, *free_page_vq;
-    uint32_t free_page_report_status;
+    uint32_t free_page_hint_status;
     uint32_t num_pages;
     uint32_t actual;
-    uint32_t free_page_report_cmd_id;
+    uint32_t free_page_hint_cmd_id;
     uint64_t stats[VIRTIO_BALLOON_S_NR];
     VirtQueueElement *stats_vq_elem;
     size_t stats_vq_offset;
@@ -55,7 +55,7 @@ typedef struct VirtIOBalloon {
     QEMUBH *free_page_bh;
     /*
      * Lock to synchronize threads to access the free page reporting related
-     * fields (e.g. free_page_report_status).
+     * fields (e.g. free_page_hint_status).
      */
     QemuMutex free_page_lock;
     QemuCond  free_page_cond;
@@ -64,7 +64,7 @@ typedef struct VirtIOBalloon {
      * stopped.
      */
     bool block_iothread;
-    NotifierWithReturn free_page_report_notify;
+    NotifierWithReturn free_page_hint_notify;
     int64_t stats_last_update;
     int64_t stats_poll_interval;
     uint32_t host_features;


