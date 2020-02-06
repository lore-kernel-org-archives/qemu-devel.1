Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BAC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 19:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF10D21741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 19:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF10D21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iznBi-0000Eo-0j
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 14:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1iznAG-0007kO-DT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 14:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1iznAE-00039W-RP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 14:50:15 -0500
Received: from gecko.sbs.de ([194.138.37.40]:46138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1iznAE-0002vG-H2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 14:50:14 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 016JoBR9026091
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Feb 2020 20:50:12 +0100
Received: from [139.25.68.37] ([139.25.68.37])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 016JoB2I029164;
 Thu, 6 Feb 2020 20:50:11 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] apic: Report current_count via 'info lapic'
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <f6c36298-5e63-f4c6-654c-3b16010ae6da@siemens.com>
Date: Thu, 6 Feb 2020 20:50:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.138.37.40
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This is helpful when debugging stuck guest timers.

As we need apic_get_current_count for that, and it is really not
emulation specific, move it to apic_common.c and export it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 hw/intc/apic.c                  | 18 ------------------
 hw/intc/apic_common.c           | 18 ++++++++++++++++++
 include/hw/i386/apic_internal.h |  1 +
 target/i386/helper.c            |  5 +++--
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index bd40467965..f2207d0ace 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -615,24 +615,6 @@ int apic_accept_pic_intr(DeviceState *dev)
     return 0;
 }
 
-static uint32_t apic_get_current_count(APICCommonState *s)
-{
-    int64_t d;
-    uint32_t val;
-    d = (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->initial_count_load_time) >>
-        s->count_shift;
-    if (s->lvt[APIC_LVT_TIMER] & APIC_LVT_TIMER_PERIODIC) {
-        /* periodic */
-        val = s->initial_count - (d % ((uint64_t)s->initial_count + 1));
-    } else {
-        if (d >= s->initial_count)
-            val = 0;
-        else
-            val = s->initial_count - d;
-    }
-    return val;
-}
-
 static void apic_timer_update(APICCommonState *s, int64_t current_time)
 {
     if (apic_next_timer(s, current_time)) {
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 9ec0f2deb2..6f4e877878 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -189,6 +189,24 @@ bool apic_next_timer(APICCommonState *s, int64_t current_time)
     return true;
 }
 
+uint32_t apic_get_current_count(APICCommonState *s)
+{
+    int64_t d;
+    uint32_t val;
+    d = (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->initial_count_load_time) >>
+        s->count_shift;
+    if (s->lvt[APIC_LVT_TIMER] & APIC_LVT_TIMER_PERIODIC) {
+        /* periodic */
+        val = s->initial_count - (d % ((uint64_t)s->initial_count + 1));
+    } else {
+        if (d >= s->initial_count)
+            val = 0;
+        else
+            val = s->initial_count - d;
+    }
+    return val;
+}
+
 void apic_init_reset(DeviceState *dev)
 {
     APICCommonState *s;
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index b04bdd947f..2597000e03 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -211,6 +211,7 @@ void vapic_report_tpr_access(DeviceState *dev, CPUState *cpu, target_ulong ip,
                              TPRAccess access);
 
 int apic_get_ppr(APICCommonState *s);
+uint32_t apic_get_current_count(APICCommonState *s);
 
 static inline void apic_set_bit(uint32_t *tab, int index)
 {
diff --git a/target/i386/helper.c b/target/i386/helper.c
index c3a6e4fabe..e3c3726c29 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -370,10 +370,11 @@ void x86_cpu_dump_local_apic_state(CPUState *cs, int flags)
     dump_apic_lvt("LVTTHMR", lvt[APIC_LVT_THERMAL], false);
     dump_apic_lvt("LVTT", lvt[APIC_LVT_TIMER], true);
 
-    qemu_printf("Timer\t DCR=0x%x (divide by %u) initial_count = %u\n",
+    qemu_printf("Timer\t DCR=0x%x (divide by %u) initial_count = %u"
+                " current_count = %u\n",
                 s->divide_conf & APIC_DCR_MASK,
                 divider_conf(s->divide_conf),
-                s->initial_count);
+                s->initial_count, apic_get_current_count(s));
 
     qemu_printf("SPIV\t 0x%08x APIC %s, focus=%s, spurious vec %u\n",
                 s->spurious_vec,
-- 
2.16.4

