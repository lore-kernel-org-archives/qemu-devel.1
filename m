Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2B5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A13206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhiYLtgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A13206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtHbn-0007jw-Ig
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHaJ-0006Jq-10
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:26:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtHaH-0001qQ-4L
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLLRrHRCmQ0fT3RWibI9NNyWibMEIXt2EXl5mXVZPQ0=;
 b=XhiYLtgHtjxNiSyEa1JZGe4QQmLECaMmekwhO6gO+DtwtUySo2YUJjtwVRqHvdZKew7uuX
 qbJv316Yg4YtEuUt5s08p3Lb9UaaaJZHROy3twIOdcUISmNSO4B2m+gFJYWWuXttsUeZL5
 njJ+ed0Aj59Ul2n2P0R4rhhGeqkkXO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-McJHBvdvNAiIasYlLCF10Q-1; Wed, 08 Jul 2020 13:25:47 -0400
X-MC-Unique: McJHBvdvNAiIasYlLCF10Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB9D7107ACCA;
 Wed,  8 Jul 2020 17:25:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5587BC007C;
 Wed,  8 Jul 2020 17:25:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 52/52] apic: Report current_count via 'info lapic'
Date: Wed,  8 Jul 2020 13:25:42 -0400
Message-Id: <20200708172542.25012-4-pbonzini@redhat.com>
In-Reply-To: <20200708172542.25012-1-pbonzini@redhat.com>
References: <20200708172542.25012-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This is helpful when debugging stuck guest timers.

As we need apic_get_current_count for that, and it is really not
emulation specific, move it to apic_common.c and export it. Fix its
style at this chance as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <e00e2896-ca5b-a929-de7a-8e5762f0c1c2@siemens.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/apic.c                  | 18 ------------------
 hw/intc/apic_common.c           | 19 +++++++++++++++++++
 include/hw/i386/apic_internal.h |  1 +
 target/i386/helper.c            |  5 +++--
 4 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 6b46839ef4..38aabd60cd 100644
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
index 7da2862b3d..bd4a95c7ca 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -189,6 +189,25 @@ bool apic_next_timer(APICCommonState *s, int64_t current_time)
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
+        if (d >= s->initial_count) {
+            val = 0;
+        } else {
+            val = s->initial_count - d;
+        }
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
index fa2a1dcdda..70be53e2c3 100644
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
2.26.2


