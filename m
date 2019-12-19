Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95ACC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9182024676
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlF1dLp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9182024676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii16e-00067R-NH
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 14:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0ti-00078R-GQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tg-00083J-Nj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:42 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tg-0007yc-F1; Thu, 19 Dec 2019 13:51:40 -0500
Received: by mail-wm1-x343.google.com with SMTP id p9so6523558wmc.2;
 Thu, 19 Dec 2019 10:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ut5YgBRvjV0s9vJYJb1Jm2VxjMe8Smrb/fftQKlotks=;
 b=tlF1dLp9sSYb8LMXVv7K7cDXZlqumuq9LifLg45AsPkz5CeM5+i6LSNjhc8gBBXPDo
 YsEcvuQ8Zx/AmvldOwOmHna/+YAIB1HQt/zbvalN2mgZNZof0MwB/fK6D99EhA7nowgx
 1E6IWPASbpIk38Ci6t+AJRXyg7MuuJwNrDQ3ANnKhifhOH7r3hgihgFScbtwzqDebmsu
 Yh8PVGvAktM9Ot0bgGIFC4MxZCH/nyUU4fwJpE7+IGLIHX/PbMy+LXqyFD+hovWemJtu
 LP7BvI8zCl4Ju2l4vZUfsL2uRXassV8+/zdX81E7lTF8Yb0qIo+1Cxs2slS8jDuw9Vzp
 lasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ut5YgBRvjV0s9vJYJb1Jm2VxjMe8Smrb/fftQKlotks=;
 b=l0nyZCRyJ6JkbBfp8AXW56Y5d9CQVflpNOYHa3iG3c5t3AbwsZ6lAA0HEW9fIiubng
 voFHB12Ou6yeuT4uzhY8t1c6zyejgmIWjlRgydWZfdsebX53/tVYO7siNwKn3Ka01pZR
 JLOfx2AtTcVUwB8HhOBO/R2iesjb2WfAqDeWyPuOIyi5SbytsyUu7yPFbMmrZBEYJ5El
 9nfZLTL9EAcDttU2ZSBU92IpZeM8xt3X/m5S9GVnSduNmnn8Qgw+JXF0s+zMwGgaQ9H5
 uluXlsmCo43se1kzDKVCXqk2PUhk3DuJW+D7TnBnfIYWNZRW0W4AbqRZqbd5tmltEskM
 eOIQ==
X-Gm-Message-State: APjAAAUKXEtbDxsitxP1haJHg0GnOm9KrcYn2ZGDggMN2w/5mU/W0ql/
 zFV2Cs2wUv0yGdDSnsG/aQn1BMlx
X-Google-Smtp-Source: APXvYqwFJu/ocP0dt38fiw9hi6XsBa0pFZ0dZoHv5eBxSfExfizRYD91ZAkeJ4XoRUjOGNkp7kTN1A==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr12019344wmc.154.1576781498236; 
 Thu, 19 Dec 2019 10:51:38 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [RFC PATCH 07/13] hw/timer/allwinner: Move timer specific fields into
 AwA10TimerContext
Date: Thu, 19 Dec 2019 19:51:21 +0100
Message-Id: <20191219185127.24388-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219185127.24388-1-f4bug@amsat.org>
References: <20191219185127.24388-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move all the timer-related fields into the same structure.
We scrambled the migration structure, so we need to increase the
version_id.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Before I was using g_new(), now I keep AW_PIT_TIMER_MAX so
We might avoid this patch.
---
 include/hw/timer/allwinner-a10-pit.h | 10 +--
 hw/timer/allwinner-a10-pit.c         | 99 ++++++++++++++++------------
 2 files changed, 63 insertions(+), 46 deletions(-)

diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index b5ac6898fa..e0f864a954 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -13,23 +13,23 @@ typedef struct AwA10PITState AwA10PITState;
 typedef struct AwA10TimerContext {
     AwA10PITState *container;
     int index;
+    ptimer_state *ptimer;
+    qemu_irq irq;
+    uint32_t control;
+    uint32_t interval;
+    uint32_t count;
 } AwA10TimerContext;
 
 struct AwA10PITState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
-    qemu_irq irq[AW_PIT_TIMER_MAX];
-    ptimer_state * ptimer[AW_PIT_TIMER_MAX];
     AwA10TimerContext timer[AW_PIT_TIMER_MAX];
     MemoryRegion iomem;
     uint32_t clk_freq[4];
 
     uint32_t irq_enable;
     uint32_t irq_status;
-    uint32_t control[AW_PIT_TIMER_MAX];
-    uint32_t interval[AW_PIT_TIMER_MAX];
-    uint32_t count[AW_PIT_TIMER_MAX];
     uint32_t watch_dog_mode;
     uint32_t watch_dog_control;
     uint32_t count_lo;
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 44e6eee3a8..ea92fdda32 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -59,7 +59,8 @@ static void a10_pit_update_irq(AwA10PITState *s)
     int i;
 
     for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
-        qemu_set_irq(s->irq[i], !!(s->irq_status & s->irq_enable & (1 << i)));
+        qemu_set_irq(s->timer[i].irq,
+                     !!(s->irq_status & s->irq_enable & (1 << i)));
     }
 }
 
@@ -79,12 +80,12 @@ static uint64_t a10_pit_read(void *opaque, hwaddr offset, unsigned size)
         index -= 1;
         switch (offset & 0x0f) {
         case AW_A10_PIT_TIMER_CONTROL:
-            return s->control[index];
+            return s->timer[index].control;
         case AW_A10_PIT_TIMER_INTERVAL:
-            return s->interval[index];
+            return s->timer[index].interval;
         case AW_A10_PIT_TIMER_COUNT:
-            s->count[index] = ptimer_get_count(s->ptimer[index]);
-            return s->count[index];
+            s->timer[index].count = ptimer_get_count(s->timer[index].ptimer);
+            return s->timer[index].count;
         default:
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Bad offset 0x%x\n",  __func__, (int)offset);
@@ -109,17 +110,17 @@ static uint64_t a10_pit_read(void *opaque, hwaddr offset, unsigned size)
     return 0;
 }
 
-/* Must be called inside a ptimer transaction block for s->ptimer[index] */
+/* Must be called inside a ptimer transaction block for s->timer[idx].ptimer */
 static void a10_pit_set_freq(AwA10PITState *s, int index)
 {
     uint32_t prescaler, source, source_freq;
 
-    prescaler = 1 << extract32(s->control[index], 4, 3);
-    source = extract32(s->control[index], 2, 2);
+    prescaler = 1 << extract32(s->timer[index].control, 4, 3);
+    source = extract32(s->timer[index].control, 2, 2);
     source_freq = s->clk_freq[source];
 
     if (source_freq) {
-        ptimer_set_freq(s->ptimer[index], source_freq / prescaler);
+        ptimer_set_freq(s->timer[index].ptimer, source_freq / prescaler);
     } else {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid clock source %u\n",
                       __func__, source);
@@ -147,31 +148,33 @@ static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
         index -= 1;
         switch (offset & 0x0f) {
         case AW_A10_PIT_TIMER_CONTROL:
-            s->control[index] = value;
-            ptimer_transaction_begin(s->ptimer[index]);
+            s->timer[index].control = value;
+            ptimer_transaction_begin(s->timer[index].ptimer);
             a10_pit_set_freq(s, index);
-            if (s->control[index] & AW_A10_PIT_TIMER_RELOAD) {
-                ptimer_set_count(s->ptimer[index], s->interval[index]);
+            if (s->timer[index].control & AW_A10_PIT_TIMER_RELOAD) {
+                ptimer_set_count(s->timer[index].ptimer,
+                                 s->timer[index].interval);
             }
-            if (s->control[index] & AW_A10_PIT_TIMER_EN) {
+            if (s->timer[index].control & AW_A10_PIT_TIMER_EN) {
                 int oneshot = 0;
-                if (s->control[index] & AW_A10_PIT_TIMER_MODE) {
+                if (s->timer[index].control & AW_A10_PIT_TIMER_MODE) {
                     oneshot = 1;
                 }
-                ptimer_run(s->ptimer[index], oneshot);
+                ptimer_run(s->timer[index].ptimer, oneshot);
             } else {
-                ptimer_stop(s->ptimer[index]);
+                ptimer_stop(s->timer[index].ptimer);
             }
-            ptimer_transaction_commit(s->ptimer[index]);
+            ptimer_transaction_commit(s->timer[index].ptimer);
             break;
         case AW_A10_PIT_TIMER_INTERVAL:
-            s->interval[index] = value;
-            ptimer_transaction_begin(s->ptimer[index]);
-            ptimer_set_limit(s->ptimer[index], s->interval[index], 1);
-            ptimer_transaction_commit(s->ptimer[index]);
+            s->timer[index].interval = value;
+            ptimer_transaction_begin(s->timer[index].ptimer);
+            ptimer_set_limit(s->timer[index].ptimer,
+                             s->timer[index].interval, 1);
+            ptimer_transaction_commit(s->timer[index].ptimer);
             break;
         case AW_A10_PIT_TIMER_COUNT:
-            s->count[index] = value;
+            s->timer[index].count = value;
             break;
         default:
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -226,22 +229,35 @@ static Property a10_pit_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const VMStateDescription vmstate_aw_timer = {
+    .name = "aw_timer",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(control, AwA10TimerContext),
+        VMSTATE_UINT32(interval, AwA10TimerContext),
+        VMSTATE_UINT32(count, AwA10TimerContext),
+        VMSTATE_PTIMER(ptimer, AwA10TimerContext),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_a10_pit = {
     .name = "a10.pit",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(irq_enable, AwA10PITState),
         VMSTATE_UINT32(irq_status, AwA10PITState),
-        VMSTATE_UINT32_ARRAY(control, AwA10PITState, AW_PIT_TIMER_MAX),
-        VMSTATE_UINT32_ARRAY(interval, AwA10PITState, AW_PIT_TIMER_MAX),
-        VMSTATE_UINT32_ARRAY(count, AwA10PITState, AW_PIT_TIMER_MAX),
+        VMSTATE_STRUCT_ARRAY(timer, AwA10PITState,
+                             AW_PIT_TIMER_MAX,
+                             0, vmstate_aw_timer,
+                             AwA10TimerContext),
         VMSTATE_UINT32(watch_dog_mode, AwA10PITState),
         VMSTATE_UINT32(watch_dog_control, AwA10PITState),
         VMSTATE_UINT32(count_lo, AwA10PITState),
         VMSTATE_UINT32(count_hi, AwA10PITState),
         VMSTATE_UINT32(count_ctl, AwA10PITState),
-        VMSTATE_PTIMER_ARRAY(ptimer, AwA10PITState, AW_PIT_TIMER_MAX),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -256,13 +272,13 @@ static void a10_pit_reset(DeviceState *dev)
     a10_pit_update_irq(s);
 
     for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
-        s->control[i] = AW_A10_PIT_DEFAULT_CLOCK;
-        s->interval[i] = 0;
-        s->count[i] = 0;
-        ptimer_transaction_begin(s->ptimer[i]);
-        ptimer_stop(s->ptimer[i]);
+        s->timer[i].control = AW_A10_PIT_DEFAULT_CLOCK;
+        s->timer[i].interval = 0;
+        s->timer[i].count = 0;
+        ptimer_transaction_begin(s->timer[i].ptimer);
+        ptimer_stop(s->timer[i].ptimer);
         a10_pit_set_freq(s, i);
-        ptimer_transaction_commit(s->ptimer[i]);
+        ptimer_transaction_commit(s->timer[i].ptimer);
     }
     s->watch_dog_mode = 0;
     s->watch_dog_control = 0;
@@ -277,11 +293,11 @@ static void a10_pit_timer_cb(void *opaque)
     AwA10PITState *s = tc->container;
     uint8_t i = tc->index;
 
-    if (s->control[i] & AW_A10_PIT_TIMER_EN) {
+    if (s->timer[i].control & AW_A10_PIT_TIMER_EN) {
         s->irq_status |= 1 << i;
-        if (s->control[i] & AW_A10_PIT_TIMER_MODE) {
-            ptimer_stop(s->ptimer[i]);
-            s->control[i] &= ~AW_A10_PIT_TIMER_EN;
+        if (s->timer[i].control & AW_A10_PIT_TIMER_MODE) {
+            ptimer_stop(s->timer[i].ptimer);
+            s->timer[i].control &= ~AW_A10_PIT_TIMER_EN;
         }
         a10_pit_update_irq(s);
     }
@@ -294,7 +310,7 @@ static void a10_pit_init(Object *obj)
     uint8_t i;
 
     for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
+        sysbus_init_irq(sbd, &s->timer[i].irq);
     }
     memory_region_init_io(&s->iomem, OBJECT(s), &a10_pit_ops, s,
                           TYPE_AW_A10_PIT, 0x400);
@@ -305,7 +321,8 @@ static void a10_pit_init(Object *obj)
 
         tc->container = s;
         tc->index = i;
-        s->ptimer[i] = ptimer_init(a10_pit_timer_cb, tc, PTIMER_POLICY_DEFAULT);
+        s->timer[i].ptimer = ptimer_init(a10_pit_timer_cb, tc,
+                                         PTIMER_POLICY_DEFAULT);
     }
 }
 
-- 
2.21.0


