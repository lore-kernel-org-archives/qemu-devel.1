Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E2C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 615962081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=connect-hku-hk.20150623.gappssmtp.com header.i=@connect-hku-hk.20150623.gappssmtp.com header.b="r44WL8h2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 615962081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=connect.hku.hk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMaOQ-0007aS-CE
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:46:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMaMo-0006Wv-4i
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hMaMm-00074K-Ko
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:44:54 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hMaMm-00073Q-3H
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:44:52 -0400
Received: by mail-pl1-x642.google.com with SMTP id z8so2890200pln.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=R2hpq7LFnN789SJV8H0dRncbRmWoPJ79brlTZStixtQ=;
	b=r44WL8h2vux5pIomx++XyV/VMk5g4X4AnHfQsjNiUDRFPkPPVNzasNJmjEhlDJuMOI
	H0CivYDe8kvcpt5ozn1Yy9BKipqfCo+428VEZHgNSLp9F34iiCb1nJBMJwBjXsNkeFZa
	LpaZJadEKk2+qVWXUPNuG93EM/LmoFYnMhUCOCY7ddyzn1F7t76JfONv96T34zg+U5un
	jpmuiTMHZ8WdBt75u0liOAsKHEdPdV3B6lVul+X5rK52lSlydHHkIMFmHQudAwF5XLAd
	X+FpzAdDUkXrg2oYj+CESrj6KtOZofjS2JXVFLRtk12ldLyFerRW2D2xt3+u93+ykWXL
	L+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=R2hpq7LFnN789SJV8H0dRncbRmWoPJ79brlTZStixtQ=;
	b=nG5yoNPjlqV046TjeZvHGnvtugT+a1yUbRIwKRmE1kRguuNzsJpG2xBTGXUt1TSkph
	WSZhIUrXHRMG4x5K+wngMLjCri8Q77RXeHdIADQfeuX6gbbxog3lJDEf97OOwxvAPvuk
	UDcXtj3HjsDWMukKf9bA4UGebUEewUYxQI2B1BmxleC/9NT5ApeKIvBHol1Fdc4wXVrS
	JO44L7UCt8+O+69h3zXC3dcQG/ckBcKeGjzawWWst5h4d3UUNoWm4tlrO8TdGmYrfrXw
	t5jHmtQlf5cKrYLvERiBUMzCg+IxpcWQPsj6h9PeCLR2HfMo+LDMvBYw/ePNzemdbLQu
	K2fA==
X-Gm-Message-State: APjAAAVr0m2gzAtUJpZGWtsvLetE0rMhcYtJQYMh81mssPCIaO9zdX3u
	Zb3fs0UkPIkKEZoWXBZLbbYwYtTcX3iGMg==
X-Google-Smtp-Source: APXvYqyWTuTUbXFl7xAtWBiRZUyL9wfBA8XJ3utnLHZKh1yt15cNr8GlRc61pkckLQkFMFwnY9SF8g==
X-Received: by 2002:a17:902:84:: with SMTP id
	a4mr11352275pla.210.1556898290312; 
	Fri, 03 May 2019 08:44:50 -0700 (PDT)
Received: from MBP.local.hk ([175.159.180.1])
	by smtp.gmail.com with ESMTPSA id 6sm4481148pfd.85.2019.05.03.08.44.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 03 May 2019 08:44:49 -0700 (PDT)
From: Boxuan Li <liboxuan@connect.hku.hk>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 23:44:24 +0800
Message-Id: <20190503154424.73933-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.13.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v4] hw/virtio/virtio-mmio: Convert DPRINTF to
 trace and log
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
	yuval.shaia@oracle.com, alex.bennee@linaro.org,
	Boxuan Li <liboxuan@connect.hku.hk>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503154424.syNClMXuriUxfXWrCjgxcdD-oeQj0rrkwFdbQ5zqIS0@z>

Use traces for debug message and qemu_log_mask for errors.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
v1: https://patchew.org/QEMU/20190428110258.86681-1-liboxuan@connect.hku.hk/
v2: https://patchew.org/QEMU/20190501081039.58938-1-liboxuan@connect.hku.hk/
v3: https://patchew.org/QEMU/20190503084654.18413-1-liboxuan@connect.hku.hk/
v4: Fix indentation and do not convert uint64_t to int
---
 hw/virtio/trace-events  |  7 +++++++
 hw/virtio/virtio-mmio.c | 44 +++++++++++++++++++++-----------------------
 2 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 60c649c4bc..e28ba48da6 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -46,3 +46,10 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
 virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
 virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
 virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
+
+# virtio-mmio.c
+virtio_mmio_read(uint64_t offset) "virtio_mmio_read offset 0x%" PRIx64
+virtio_mmio_write_offset(uint64_t offset, uint64_t value) "virtio_mmio_write offset 0x%" PRIx64 " value 0x%" PRIx64
+virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRIx64 " shift %d"
+virtio_mmio_queue_write(uint64_t value, int max_size) "mmio_queue write 0x%" PRIx64 " max %d"
+virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa87fe..96c762f0bf 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -27,16 +27,8 @@
 #include "sysemu/kvm.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qemu/error-report.h"
-
-/* #define DEBUG_VIRTIO_MMIO */
-
-#ifdef DEBUG_VIRTIO_MMIO
-
-#define DPRINTF(fmt, ...) \
-do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#include "qemu/log.h"
+#include "trace.h"
 
 /* QOM macros */
 /* virtio-mmio-bus */
@@ -107,7 +99,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
     VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
+    trace_virtio_mmio_read(offset);
 
     if (!vdev) {
         /* If no backend is present, we treat most registers as
@@ -144,7 +136,9 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
         }
     }
     if (size != 4) {
-        DPRINTF("wrong size access to register!\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: wrong size access to register!\n",
+                      __func__);
         return 0;
     }
     switch (offset) {
@@ -182,10 +176,12 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
     case VIRTIO_MMIO_QUEUE_ALIGN:
     case VIRTIO_MMIO_QUEUE_NOTIFY:
     case VIRTIO_MMIO_INTERRUPT_ACK:
-        DPRINTF("read of write-only register\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: read of write-only register\n",
+                      __func__);
         return 0;
     default:
-        DPRINTF("bad register offset\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
         return 0;
     }
     return 0;
@@ -197,8 +193,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    DPRINTF("virtio_mmio_write offset 0x%x value 0x%" PRIx64 "\n",
-            (int)offset, value);
+    trace_virtio_mmio_write_offset(offset, value);
 
     if (!vdev) {
         /* If no backend is present, we just make all registers
@@ -226,7 +221,9 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
     if (size != 4) {
-        DPRINTF("wrong size access to register!\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: wrong size access to register!\n",
+                      __func__);
         return;
     }
     switch (offset) {
@@ -246,8 +243,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         if (proxy->guest_page_shift > 31) {
             proxy->guest_page_shift = 0;
         }
-        DPRINTF("guest page size %" PRIx64 " shift %d\n", value,
-                proxy->guest_page_shift);
+        trace_virtio_mmio_guest_page(value, proxy->guest_page_shift);
         break;
     case VIRTIO_MMIO_QUEUE_SEL:
         if (value < VIRTIO_QUEUE_MAX) {
@@ -255,7 +251,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case VIRTIO_MMIO_QUEUE_NUM:
-        DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MAX_SIZE);
+        trace_virtio_mmio_queue_write(value, VIRTQUEUE_MAX_SIZE);
         virtio_queue_set_num(vdev, vdev->queue_sel, value);
         /* Note: only call this function for legacy devices */
         virtio_queue_update_rings(vdev, vdev->queue_sel);
@@ -303,11 +299,13 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     case VIRTIO_MMIO_DEVICE_FEATURES:
     case VIRTIO_MMIO_QUEUE_NUM_MAX:
     case VIRTIO_MMIO_INTERRUPT_STATUS:
-        DPRINTF("write to readonly register\n");
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to readonly register\n",
+                      __func__);
         break;
 
     default:
-        DPRINTF("bad register offset\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad register offset\n", __func__);
     }
 }
 
@@ -327,7 +325,7 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
         return;
     }
     level = (atomic_read(&vdev->isr) != 0);
-    DPRINTF("virtio_mmio setting IRQ %d\n", level);
+    trace_virtio_mmio_setting_irq(level);
     qemu_set_irq(proxy->irq, level);
 }
 
-- 
2.13.2


