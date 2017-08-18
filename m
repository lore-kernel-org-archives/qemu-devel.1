Received: from eggs.gnu.org ([2001:4830:134:3::10]:60778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDT-0004BR-6y
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDP-0000jw-QY
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDP-0000i7-K6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B145A20274
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:18 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3494E5D743
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:18 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:47 +0200
Message-Id: <1503050939-227939-16-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 15/27] tilegx: replace
 cpu_tilegx_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

cpu_tilegx_init() always falls back to TYPE_TILEGX_CPU object
regardless of cpu_model. Put fallback logic into
tilegx_cpu_class_by_name() which would translate any cpu_model
into TYPE_TILEGX_CPU class and replace cpu_tilegx_init()
with cpu_generic_init().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/tilegx/cpu.h |  4 +---
 target/tilegx/cpu.c | 11 +++--------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index f32be49..71cea04 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -164,9 +164,7 @@ static inline TileGXCPU *tilegx_env_get_cpu(CPUTLGState *env)
 void tilegx_tcg_init(void);
 int cpu_tilegx_signal_handler(int host_signum, void *pinfo, void *puc);
 
-TileGXCPU *cpu_tilegx_init(const char *cpu_model);
-
-#define cpu_init(cpu_model) CPU(cpu_tilegx_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_TILEGX_CPU, cpu_model)
 
 #define cpu_signal_handler cpu_tilegx_signal_handler
 
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index 4532639..7345f5a 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -52,15 +52,9 @@ static void tilegx_cpu_dump_state(CPUState *cs, FILE *f,
                 env->pc, env->spregs[TILEGX_SPR_CMPEXCH]);
 }
 
-TileGXCPU *cpu_tilegx_init(const char *cpu_model)
+static ObjectClass *tilegx_cpu_class_by_name(const char *cpu_model)
 {
-    TileGXCPU *cpu;
-
-    cpu = TILEGX_CPU(object_new(TYPE_TILEGX_CPU));
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
+    return object_class_by_name(TYPE_TILEGX_CPU);
 }
 
 static void tilegx_cpu_set_pc(CPUState *cs, vaddr value)
@@ -159,6 +153,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     tcc->parent_reset = cc->reset;
     cc->reset = tilegx_cpu_reset;
 
+    cc->class_by_name = tilegx_cpu_class_by_name;
     cc->has_work = tilegx_cpu_has_work;
     cc->do_interrupt = tilegx_cpu_do_interrupt;
     cc->cpu_exec_interrupt = tilegx_cpu_exec_interrupt;
-- 
2.7.4
