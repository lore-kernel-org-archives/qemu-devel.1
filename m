Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852BEC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 08:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58882081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 08:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=connect-hku-hk.20150623.gappssmtp.com header.i=@connect-hku-hk.20150623.gappssmtp.com header.b="WtWN1F7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58882081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=connect.hku.hk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLkRu-0004Qx-SF
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 04:18:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hLkQt-00042g-Cw
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hLkQq-0006jR-8x
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:17:39 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hLkQo-0006fX-IJ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 04:17:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id 85so8039175pgc.3
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 01:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=uf0NAWKR2kSgvSfafMUznqPu7S7vIK+L8js8xkHFZ0M=;
	b=WtWN1F7Me9RgX0a1+5obe/BQ+V5gECPaDrXFxfWdTFhF5PFoMXyr5fZdrJ5Z8owv89
	3RpLxQUtafOmsuxy6S/ghB6f95bYgrtMV53+PJDJelDPWl5gZ4c0e1neUp95tHDpzEs7
	XeknOp39QLaGhYydR8YL1NUZHy0xgpF8GwUjPMBnmRxlqNiTWfPyiJFfZs4OMS6y8sIu
	zNtbRfTTkgeeoJ7nb6hHNY8bAD27iis74flSIpOOaNFxknfa9zxrKPAm4BWyJMEmINFJ
	9IbrGq/hcC1npAqyLUq0sztgtJjivUwbyX/7qpiwyiPwie2bzWCf/5hwV5zZndNtYV6T
	P3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=uf0NAWKR2kSgvSfafMUznqPu7S7vIK+L8js8xkHFZ0M=;
	b=dTdvKNOZud3VcJmBULRaBehWnVl96UUxzhZ/l1LbutjiyLSFT+41ww32oOX2D9xaup
	Q3EZxZZ2bSAyRKLZH52P4OUu6bTtT3M0WSzLR0UVg7iznWV2bkL8Sxpymdeabz/p5GZ1
	LQh4pr/ShFgtkWQgcWj9XCVszyDCNkOd8UVam8RgoWFfxqwpVHopcdA93fmzwJSB3e+S
	s8yUmEaBZyjQeRFp4B/4Ck9UR6FQTP0HmglWN/YSSyMoUHq8uaZLYsJlym9VIWwI1/Fw
	vfxDH84y6M+phuBZ55czPShMPJYkJWyT4PBiV6CJJpqvlCKrokMQs4Wk1iiphT45DUmd
	0jkQ==
X-Gm-Message-State: APjAAAX5/8ZgZwXtiNAcLsKe1YfiZSUpFwAR/D89Q9sJIsEpFpzyOYr/
	uEzau2rSAVDl+43LZ3e+6GDn7zgu/jWNBg==
X-Google-Smtp-Source: APXvYqyLSSoyWAI+wlbAvG+DsnN2WwGBjUZOxvlqVQP8kV4YfM/9lwrZU6z1uCkKWKt/PdbsvcR2jg==
X-Received: by 2002:a62:5f84:: with SMTP id
	t126mr77227231pfb.185.1556698650388; 
	Wed, 01 May 2019 01:17:30 -0700 (PDT)
Received: from MBP.local.hk ([175.159.180.1]) by smtp.gmail.com with ESMTPSA id
	p2sm113797118pfi.73.2019.05.01.01.17.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 01 May 2019 01:17:29 -0700 (PDT)
From: Boxuan Li <liboxuan@connect.hku.hk>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 16:10:39 +0800
Message-Id: <20190501081039.58938-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.13.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2] hw/virtio/virtio-mmio: Convert DPRINTF to
 traces
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
Cc: qemu-trivial@nongnu.org, philmd@redhat.com,
	Boxuan Li <liboxuan@connect.hku.hk>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501081039.ssAV5zE-JF2MvfR2-I7xF5rcyDAUFq06fuEwCrg5t6k@z>

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
v2: Instead of using conditional debugs, convert DPRINTF to traces
---
 hw/virtio/trace-events  | 13 +++++++++++++
 hw/virtio/virtio-mmio.c | 35 ++++++++++++-----------------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 60c649c4bc..37c781b487 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -46,3 +46,16 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
 virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
 virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
 virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
+
+# virtio-mmio.c
+virtio_mmio_read(int offset) "virtio_mmio_read offset 0x%x"
+virtio_mmio_wrong_size_read(void) "wrong size access to register!"
+virtio_mmio_read_interrupt(void) "read of write-only register"
+virtio_mmio_bad_read_offset(void) "bad register offset"
+virtio_mmio_write_offset(int offset, uint64_t value) "virtio_mmio_write offset 0x%x value 0x%" PRIx64
+virtio_mmio_wrong_size_write(void) "wrong size access to register!"
+virtio_mmio_guest_page(uint64_t size, int shift) "guest page size 0x%" PRIx64 " shift %d"
+virtio_mmio_queue_write(int value, int max_size) "mmio_queue write %d max %d"
+virtio_mmio_write_interrupt(void) "write to readonly register"
+virtio_mmio_bad_write_offset(void) "bad register offset"
+virtio_mmio_setting_irq(int level) "virtio_mmio setting IRQ %d"
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa87fe..4251df399d 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -27,16 +27,7 @@
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
+#include "trace.h"
 
 /* QOM macros */
 /* virtio-mmio-bus */
@@ -107,7 +98,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
     VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    DPRINTF("virtio_mmio_read offset 0x%x\n", (int)offset);
+    trace_virtio_mmio_read((int)offset);
 
     if (!vdev) {
         /* If no backend is present, we treat most registers as
@@ -144,7 +135,7 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
         }
     }
     if (size != 4) {
-        DPRINTF("wrong size access to register!\n");
+        trace_virtio_mmio_wrong_size_read();
         return 0;
     }
     switch (offset) {
@@ -182,10 +173,10 @@ static uint64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)
     case VIRTIO_MMIO_QUEUE_ALIGN:
     case VIRTIO_MMIO_QUEUE_NOTIFY:
     case VIRTIO_MMIO_INTERRUPT_ACK:
-        DPRINTF("read of write-only register\n");
+        trace_virtio_mmio_read_interrupt();
         return 0;
     default:
-        DPRINTF("bad register offset\n");
+        trace_virtio_mmio_bad_read_offset();
         return 0;
     }
     return 0;
@@ -197,8 +188,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     VirtIOMMIOProxy *proxy = (VirtIOMMIOProxy *)opaque;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
-    DPRINTF("virtio_mmio_write offset 0x%x value 0x%" PRIx64 "\n",
-            (int)offset, value);
+    trace_virtio_mmio_write_offset((int)offset, value);
 
     if (!vdev) {
         /* If no backend is present, we just make all registers
@@ -226,7 +216,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
     if (size != 4) {
-        DPRINTF("wrong size access to register!\n");
+        trace_virtio_mmio_wrong_size_write();
         return;
     }
     switch (offset) {
@@ -246,8 +236,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         if (proxy->guest_page_shift > 31) {
             proxy->guest_page_shift = 0;
         }
-        DPRINTF("guest page size %" PRIx64 " shift %d\n", value,
-                proxy->guest_page_shift);
+        trace_virtio_mmio_guest_page(value, proxy->guest_page_shift);
         break;
     case VIRTIO_MMIO_QUEUE_SEL:
         if (value < VIRTIO_QUEUE_MAX) {
@@ -255,7 +244,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case VIRTIO_MMIO_QUEUE_NUM:
-        DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MAX_SIZE);
+        trace_virtio_mmio_queue_write((int)value, VIRTQUEUE_MAX_SIZE);
         virtio_queue_set_num(vdev, vdev->queue_sel, value);
         /* Note: only call this function for legacy devices */
         virtio_queue_update_rings(vdev, vdev->queue_sel);
@@ -303,11 +292,11 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
     case VIRTIO_MMIO_DEVICE_FEATURES:
     case VIRTIO_MMIO_QUEUE_NUM_MAX:
     case VIRTIO_MMIO_INTERRUPT_STATUS:
-        DPRINTF("write to readonly register\n");
+        trace_virtio_mmio_write_interrupt();
         break;
 
     default:
-        DPRINTF("bad register offset\n");
+        trace_virtio_mmio_bad_write_offset();
     }
 }
 
@@ -327,7 +316,7 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
         return;
     }
     level = (atomic_read(&vdev->isr) != 0);
-    DPRINTF("virtio_mmio setting IRQ %d\n", level);
+    trace_virtio_mmio_setting_irq(level);
     qemu_set_irq(proxy->irq, level);
 }
 
-- 
2.13.2


