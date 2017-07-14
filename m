Received: from eggs.gnu.org ([2001:4830:134:3::10]:41501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12O-0002Lh-Tn
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12N-0001q4-Vu
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW12N-0001pi-Pn
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:43 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:08 +0200
Message-Id: <1500040339-119465-18-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 17/28] tilegx: replace cpu_tilegx_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>

cpu_tilegx_init() always falls back to TYPE_TILEGX_CPU object
regardless of cpu_model. Put fallback logic into
tilegx_cpu_class_by_name() which would translate any cpu_model
into TYPE_TILEGX_CPU class and replace cpu_tilegx_init()
with cpu_generic_init().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Laurent Vivier <laurent@vivier.eu>
CC: Richard Henderson <rth@twiddle.net>
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
