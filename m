Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B50C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B946F20869
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 21:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B946F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47323 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHEEU-00081u-S2
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 17:06:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0d-0005CC-2m
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0V-0005Hg-M0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0V-0005FG-4w
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42BB4D7813
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DE6EB60BE5
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id EE55D110CFCD; Thu, 18 Apr 2019 22:51:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:51:29 +0200
Message-Id: <20190418205135.6686-31-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 18 Apr 2019 20:51:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 30/36] target/i386: Simplify how
 x86_cpu_dump_local_apic_state() prints
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418205129.G5jHPu0I9oNbUbNAgpfsPYUFMZhjEacUhq4cDiDRhyI@z>

x86_cpu_dump_local_apic_state() takes an fprintf()-like callback and a
FILE * to pass to it, and so do its helper functions.

Its only caller hmp_info_local_apic() passes monitor_fprintf() and the
current monitor cast to FILE *.  monitor_fprintf() casts it right
back, and is otherwise identical to monitor_printf().  The
type-punning is ugly.

Drop the callback, and call qemu_printf() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190417191805.28198-12-armbru@redhat.com>
---
 target/i386/cpu.h     |  3 +-
 target/i386/helper.c  | 79 ++++++++++++++++++++-----------------------
 target/i386/monitor.c |  3 +-
 3 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b39327dcb7..139fe30960 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1924,8 +1924,7 @@ void enable_compat_apic_id_mode(void);
 #define APIC_DEFAULT_ADDRESS 0xfee00000
 #define APIC_SPACE_SIZE      0x100000
 
-void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
-                                   fprintf_function cpu_fprintf, int flags);
+void x86_cpu_dump_local_apic_state(CPUState *cs, int flags);
 
 /* cpu.c */
 bool cpu_is_bsp(X86CPU *cpu);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index e695f8ba7a..565391a9f6 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "qemu/qemu-print.h"
 #include "sysemu/kvm.h"
 #include "kvm_i386.h"
 #ifndef CONFIG_USER_ONLY
@@ -231,12 +232,10 @@ static inline const char *dm2str(uint32_t dm)
     return str[dm];
 }
 
-static void dump_apic_lvt(FILE *f, fprintf_function cpu_fprintf,
-                          const char *name, uint32_t lvt, bool is_timer)
+static void dump_apic_lvt(const char *name, uint32_t lvt, bool is_timer)
 {
     uint32_t dm = (lvt & APIC_LVT_DELIV_MOD) >> APIC_LVT_DELIV_MOD_SHIFT;
-    cpu_fprintf(f,
-                "%s\t 0x%08x %s %-5s %-6s %-7s %-12s %-6s",
+    qemu_printf("%s\t 0x%08x %s %-5s %-6s %-7s %-12s %-6s",
                 name, lvt,
                 lvt & APIC_LVT_INT_POLARITY ? "active-lo" : "active-hi",
                 lvt & APIC_LVT_LEVEL_TRIGGER ? "level" : "edge",
@@ -248,9 +247,9 @@ static void dump_apic_lvt(FILE *f, fprintf_function cpu_fprintf,
                                             "tsc-deadline" : "one-shot",
                 dm2str(dm));
     if (dm != APIC_DM_NMI) {
-        cpu_fprintf(f, " (vec %u)\n", lvt & APIC_VECTOR_MASK);
+        qemu_printf(" (vec %u)\n", lvt & APIC_VECTOR_MASK);
     } else {
-        cpu_fprintf(f, "\n");
+        qemu_printf("\n");
     }
 }
 
@@ -282,8 +281,7 @@ static inline void mask2str(char *str, uint32_t val, uint8_t size)
 
 #define MAX_LOGICAL_APIC_ID_MASK_SIZE 16
 
-static void dump_apic_icr(FILE *f, fprintf_function cpu_fprintf,
-                          APICCommonState *s, CPUX86State *env)
+static void dump_apic_icr(APICCommonState *s, CPUX86State *env)
 {
     uint32_t icr = s->icr[0], icr2 = s->icr[1];
     uint8_t dest_shorthand = \
@@ -293,16 +291,16 @@ static void dump_apic_icr(FILE *f, fprintf_function cpu_fprintf,
     uint32_t dest_field;
     bool x2apic;
 
-    cpu_fprintf(f, "ICR\t 0x%08x %s %s %s %s\n",
+    qemu_printf("ICR\t 0x%08x %s %s %s %s\n",
                 icr,
                 logical_mod ? "logical" : "physical",
                 icr & APIC_ICR_TRIGGER_MOD ? "level" : "edge",
                 icr & APIC_ICR_LEVEL ? "assert" : "de-assert",
                 shorthand2str(dest_shorthand));
 
-    cpu_fprintf(f, "ICR2\t 0x%08x", icr2);
+    qemu_printf("ICR2\t 0x%08x", icr2);
     if (dest_shorthand != 0) {
-        cpu_fprintf(f, "\n");
+        qemu_printf("\n");
         return;
     }
     x2apic = env->features[FEAT_1_ECX] & CPUID_EXT_X2APIC;
@@ -310,9 +308,9 @@ static void dump_apic_icr(FILE *f, fprintf_function cpu_fprintf,
 
     if (!logical_mod) {
         if (x2apic) {
-            cpu_fprintf(f, " cpu %u (X2APIC ID)\n", dest_field);
+            qemu_printf(" cpu %u (X2APIC ID)\n", dest_field);
         } else {
-            cpu_fprintf(f, " cpu %u (APIC ID)\n",
+            qemu_printf(" cpu %u (APIC ID)\n",
                         dest_field & APIC_LOGDEST_XAPIC_ID);
         }
         return;
@@ -320,87 +318,84 @@ static void dump_apic_icr(FILE *f, fprintf_function cpu_fprintf,
 
     if (s->dest_mode == 0xf) { /* flat mode */
         mask2str(apic_id_str, icr2 >> APIC_ICR_DEST_SHIFT, 8);
-        cpu_fprintf(f, " mask %s (APIC ID)\n", apic_id_str);
+        qemu_printf(" mask %s (APIC ID)\n", apic_id_str);
     } else if (s->dest_mode == 0) { /* cluster mode */
         if (x2apic) {
             mask2str(apic_id_str, dest_field & APIC_LOGDEST_X2APIC_ID, 16);
-            cpu_fprintf(f, " cluster %u mask %s (X2APIC ID)\n",
+            qemu_printf(" cluster %u mask %s (X2APIC ID)\n",
                         dest_field >> APIC_LOGDEST_X2APIC_SHIFT, apic_id_str);
         } else {
             mask2str(apic_id_str, dest_field & APIC_LOGDEST_XAPIC_ID, 4);
-            cpu_fprintf(f, " cluster %u mask %s (APIC ID)\n",
+            qemu_printf(" cluster %u mask %s (APIC ID)\n",
                         dest_field >> APIC_LOGDEST_XAPIC_SHIFT, apic_id_str);
         }
     }
 }
 
-static void dump_apic_interrupt(FILE *f, fprintf_function cpu_fprintf,
-                                const char *name, uint32_t *ireg_tab,
+static void dump_apic_interrupt(const char *name, uint32_t *ireg_tab,
                                 uint32_t *tmr_tab)
 {
     int i, empty = true;
 
-    cpu_fprintf(f, "%s\t ", name);
+    qemu_printf("%s\t ", name);
     for (i = 0; i < 256; i++) {
         if (apic_get_bit(ireg_tab, i)) {
-            cpu_fprintf(f, "%u%s ", i,
+            qemu_printf("%u%s ", i,
                         apic_get_bit(tmr_tab, i) ? "(level)" : "");
             empty = false;
         }
     }
-    cpu_fprintf(f, "%s\n", empty ? "(none)" : "");
+    qemu_printf("%s\n", empty ? "(none)" : "");
 }
 
-void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
-                                   fprintf_function cpu_fprintf, int flags)
+void x86_cpu_dump_local_apic_state(CPUState *cs, int flags)
 {
     X86CPU *cpu = X86_CPU(cs);
     APICCommonState *s = APIC_COMMON(cpu->apic_state);
     if (!s) {
-        cpu_fprintf(f, "local apic state not available\n");
+        qemu_printf("local apic state not available\n");
         return;
     }
     uint32_t *lvt = s->lvt;
 
-    cpu_fprintf(f, "dumping local APIC state for CPU %-2u\n\n",
+    qemu_printf("dumping local APIC state for CPU %-2u\n\n",
                 CPU(cpu)->cpu_index);
-    dump_apic_lvt(f, cpu_fprintf, "LVT0", lvt[APIC_LVT_LINT0], false);
-    dump_apic_lvt(f, cpu_fprintf, "LVT1", lvt[APIC_LVT_LINT1], false);
-    dump_apic_lvt(f, cpu_fprintf, "LVTPC", lvt[APIC_LVT_PERFORM], false);
-    dump_apic_lvt(f, cpu_fprintf, "LVTERR", lvt[APIC_LVT_ERROR], false);
-    dump_apic_lvt(f, cpu_fprintf, "LVTTHMR", lvt[APIC_LVT_THERMAL], false);
-    dump_apic_lvt(f, cpu_fprintf, "LVTT", lvt[APIC_LVT_TIMER], true);
+    dump_apic_lvt("LVT0", lvt[APIC_LVT_LINT0], false);
+    dump_apic_lvt("LVT1", lvt[APIC_LVT_LINT1], false);
+    dump_apic_lvt("LVTPC", lvt[APIC_LVT_PERFORM], false);
+    dump_apic_lvt("LVTERR", lvt[APIC_LVT_ERROR], false);
+    dump_apic_lvt("LVTTHMR", lvt[APIC_LVT_THERMAL], false);
+    dump_apic_lvt("LVTT", lvt[APIC_LVT_TIMER], true);
 
-    cpu_fprintf(f, "Timer\t DCR=0x%x (divide by %u) initial_count = %u\n",
+    qemu_printf("Timer\t DCR=0x%x (divide by %u) initial_count = %u\n",
                 s->divide_conf & APIC_DCR_MASK,
                 divider_conf(s->divide_conf),
                 s->initial_count);
 
-    cpu_fprintf(f, "SPIV\t 0x%08x APIC %s, focus=%s, spurious vec %u\n",
+    qemu_printf("SPIV\t 0x%08x APIC %s, focus=%s, spurious vec %u\n",
                 s->spurious_vec,
                 s->spurious_vec & APIC_SPURIO_ENABLED ? "enabled" : "disabled",
                 s->spurious_vec & APIC_SPURIO_FOCUS ? "on" : "off",
                 s->spurious_vec & APIC_VECTOR_MASK);
 
-    dump_apic_icr(f, cpu_fprintf, s, &cpu->env);
+    dump_apic_icr(s, &cpu->env);
 
-    cpu_fprintf(f, "ESR\t 0x%08x\n", s->esr);
+    qemu_printf("ESR\t 0x%08x\n", s->esr);
 
-    dump_apic_interrupt(f, cpu_fprintf, "ISR", s->isr, s->tmr);
-    dump_apic_interrupt(f, cpu_fprintf, "IRR", s->irr, s->tmr);
+    dump_apic_interrupt("ISR", s->isr, s->tmr);
+    dump_apic_interrupt("IRR", s->irr, s->tmr);
 
-    cpu_fprintf(f, "\nAPR 0x%02x TPR 0x%02x DFR 0x%02x LDR 0x%02x",
+    qemu_printf("\nAPR 0x%02x TPR 0x%02x DFR 0x%02x LDR 0x%02x",
                 s->arb_id, s->tpr, s->dest_mode, s->log_dest);
     if (s->dest_mode == 0) {
-        cpu_fprintf(f, "(cluster %u: id %u)",
+        qemu_printf("(cluster %u: id %u)",
                     s->log_dest >> APIC_LOGDEST_XAPIC_SHIFT,
                     s->log_dest & APIC_LOGDEST_XAPIC_ID);
     }
-    cpu_fprintf(f, " PPR 0x%02x\n", apic_get_ppr(s));
+    qemu_printf(" PPR 0x%02x\n", apic_get_ppr(s));
 }
 #else
-void x86_cpu_dump_local_apic_state(CPUState *cs, FILE *f,
-                                   fprintf_function cpu_fprintf, int flags)
+void x86_cpu_dump_local_apic_state(CPUState *cs, int flags)
 {
 }
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 74a13c571b..56e2dbece7 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -664,8 +664,7 @@ void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    x86_cpu_dump_local_apic_state(cs, (FILE *)mon, monitor_fprintf,
-                                  CPU_DUMP_FPU);
+    x86_cpu_dump_local_apic_state(cs, CPU_DUMP_FPU);
 }
 
 void hmp_info_io_apic(Monitor *mon, const QDict *qdict)
-- 
2.17.2


