Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D6CC282CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E862083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E862083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50895 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbnd-0000pF-MV
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:39:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEbZz-0005kx-6r
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEbZx-0006ht-6L
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEbZv-0006af-EP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 779373007452
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:25:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8695119652;
	Thu, 11 Apr 2019 15:25:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id ACA70113298A; Thu, 11 Apr 2019 17:25:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 17:25:15 +0200
Message-Id: <20190411152520.10061-13-armbru@redhat.com>
In-Reply-To: <20190411152520.10061-1-armbru@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Thu, 11 Apr 2019 15:25:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 12/17] qom/cpu: Simplify how
 CPUClass::dump_statistics() prints
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
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411152515.9nHgJMETn7w_pX9lM3w6ci_ohCJBZjsH4EOD0d1k04M@z>

CPUClass method dump_statistics() takes an fprintf()-like callback and
a FILE * to pass to it.

Its only caller hmp_info_cpustats() (via cpu_dump_statistics()) passes
monitor_fprintf() and the current monitor cast to FILE *.
monitor_fprintf() casts it right back, and is otherwise identical to
monitor_printf().  The type-punning is ugly.

Drop the callback, and call qemu_printf() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/cpu.h      | 11 ++++-------
 monitor.c              |  2 +-
 qom/cpu.c              |  5 ++---
 target/ppc/cpu.h       |  3 +--
 target/ppc/translate.c |  9 ++++-----
 5 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1d6099e5d4..31bafee2b1 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -184,8 +184,7 @@ typedef struct CPUClass {
     void (*dump_state)(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
                        int flags);
     GuestPanicInformation* (*get_crash_info)(CPUState *cpu);
-    void (*dump_statistics)(CPUState *cpu, FILE *f,
-                            fprintf_function cpu_fprintf, int flags);
+    void (*dump_statistics)(CPUState *cpu, int flags);
     int64_t (*get_arch_id)(CPUState *cpu);
     bool (*get_paging_enabled)(const CPUState *cpu);
     void (*get_memory_mapping)(CPUState *cpu, MemoryMappingList *list,
@@ -576,14 +575,12 @@ void cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
 /**
  * cpu_dump_statistics:
  * @cpu: The CPU whose state is to be dumped.
- * @f: File to dump to.
- * @cpu_fprintf: Function to dump with.
  * @flags: Flags what to dump.
  *
- * Dumps CPU statistics.
+ * Dump CPU statistics to the current monitor if we have one, else to
+ * stdout.
  */
-void cpu_dump_statistics(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                         int flags);
+void cpu_dump_statistics(CPUState *cpu, int flags);
 
 #ifndef CONFIG_USER_ONLY
 /**
diff --git a/monitor.c b/monitor.c
index 0819b99ef7..fb5b681099 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1364,7 +1364,7 @@ static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
-    cpu_dump_statistics(cs, (FILE *)mon, &monitor_fprintf, 0);
+    cpu_dump_statistics(cs, 0);
 }
 
 static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
diff --git a/qom/cpu.c b/qom/cpu.c
index a8d2958956..029e7fe9b0 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -230,13 +230,12 @@ void cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
     }
 }
 
-void cpu_dump_statistics(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
-                         int flags)
+void cpu_dump_statistics(CPUState *cpu, int flags)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->dump_statistics) {
-        cc->dump_statistics(cpu, f, cpu_fprintf, flags);
+        cc->dump_statistics(cpu, flags);
     }
 }
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 8572241364..27a36b9605 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1270,8 +1270,7 @@ void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_fprintf,
                         int flags);
-void ppc_cpu_dump_statistics(CPUState *cpu, FILE *f,
-                             fprintf_function cpu_fprintf, int flags);
+void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int ppc_cpu_gdb_read_register_apple(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index badc1ae1a3..f99f27a134 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7593,8 +7593,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
 #undef RFPL
 }
 
-void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
-                             fprintf_function cpu_fprintf, int flags)
+void ppc_cpu_dump_statistics(CPUState *cs, int flags)
 {
 #if defined(DO_PPC_STATISTICS)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
@@ -7614,7 +7613,7 @@ void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
                         handler = t3[op3];
                         if (handler->count == 0)
                             continue;
-                        cpu_fprintf(f, "%02x %02x %02x (%02x %04d) %16s: "
+                        qemu_printf("%02x %02x %02x (%02x %04d) %16s: "
                                     "%016" PRIx64 " %" PRId64 "\n",
                                     op1, op2, op3, op1, (op3 << 5) | op2,
                                     handler->oname,
@@ -7623,7 +7622,7 @@ void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
                 } else {
                     if (handler->count == 0)
                         continue;
-                    cpu_fprintf(f, "%02x %02x    (%02x %04d) %16s: "
+                    qemu_printf("%02x %02x    (%02x %04d) %16s: "
                                 "%016" PRIx64 " %" PRId64 "\n",
                                 op1, op2, op1, op2, handler->oname,
                                 handler->count, handler->count);
@@ -7632,7 +7631,7 @@ void ppc_cpu_dump_statistics(CPUState *cs, FILE*f,
         } else {
             if (handler->count == 0)
                 continue;
-            cpu_fprintf(f, "%02x       (%02x     ) %16s: %016" PRIx64
+            qemu_printf("%02x       (%02x     ) %16s: %016" PRIx64
                         " %" PRId64 "\n",
                         op1, op1, handler->oname,
                         handler->count, handler->count);
-- 
2.17.2


