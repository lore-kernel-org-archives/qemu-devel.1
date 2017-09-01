Received: from eggs.gnu.org ([2001:4830:134:3::10]:41054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUW-0008Tr-RS
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUP-00037X-3J
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUO-00037L-UH
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:09 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:06 -0300
Message-Id: <20170901150317.10380-19-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 18/29] tilegx: replace cpu_tilegx_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

cpu_tilegx_init() always falls back to TYPE_TILEGX_CPU object
regardless of cpu_model. Put fallback logic into
tilegx_cpu_class_by_name() which would translate any cpu_model
into TYPE_TILEGX_CPU class and replace cpu_tilegx_init()
with cpu_generic_init().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1503592308-93913-15-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/tilegx/cpu.h |  4 +---
 target/tilegx/cpu.c | 11 +++--------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index f32be49f65..71cea04589 100644
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
index 45326398cc..7345f5a8b5 100644
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
2.13.5
