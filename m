Received: from eggs.gnu.org ([2001:4830:134:3::10]:38276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1fFnNX-0002NW-F4
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonynpavlov@gmail.com>) id 1fFnNU-0005FG-99
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:09:03 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:43832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <antonynpavlov@gmail.com>)
	id 1fFnNT-0005ER-Tc
	for qemu-devel@nongnu.org; Mon, 07 May 2018 17:09:00 -0400
Received: by mail-lf0-x242.google.com with SMTP id g12-v6so42690498lfb.10
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 14:08:59 -0700 (PDT)
From: Antony Pavlov <antonynpavlov@gmail.com>
Date: Tue,  8 May 2018 00:08:38 +0300
Message-Id: <20180507210838.16451-1-antonynpavlov@gmail.com>
Subject: [Qemu-devel] [PATCH] RISC-V: make it possible to alter default
 reset vector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

The RISC-V Instruction Set Manual, Volume II:
Privileged Architecture, Version 1.10 states
that upon reset the pc is set to
an implementation-defined reset vector
(see chapter 3.3 Reset).

This patch makes it possible to alter default
reset vector by setting "rstvec" property
for TYPE_RISCV_HART_ARRAY.

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
Cc: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/riscv/riscv_hart.c         |  3 +++
 include/hw/riscv/riscv_hart.h |  1 +
 target/riscv/cpu.c            | 17 ++++++++++-------
 target/riscv/cpu.h            |  2 ++
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 14e3c186fe..98e5e50f33 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -27,6 +27,7 @@
 static Property riscv_harts_props[] = {
     DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
     DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
+    DEFINE_PROP_UINT64("rstvec", RISCVHartArrayState, rstvec, DEFAULT_RSTVEC),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -50,6 +51,8 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
         s->harts[n].env.mhartid = n;
         object_property_add_child(OBJECT(s), "harts[*]", OBJECT(&s->harts[n]),
                                   &error_abort);
+        object_property_set_uint(OBJECT(&s->harts[n]), s->rstvec,
+                                 "rstvec", &err);
         qemu_register_reset(riscv_harts_cpu_reset, &s->harts[n]);
         object_property_set_bool(OBJECT(&s->harts[n]), true,
                                  "realized", &err);
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index 0671d88a44..3cc19e2b60 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -34,6 +34,7 @@ typedef struct RISCVHartArrayState {
     uint32_t num_harts;
     char *cpu_type;
     RISCVCPU *harts;
+    uint64_t rstvec;
 } RISCVHartArrayState;
 
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a527fbba0..061aa5cc6b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
 
 /* RISC-V CPU definitions */
 
@@ -112,7 +113,6 @@ static void riscv_any_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 #if defined(TARGET_RISCV32)
@@ -122,7 +122,6 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
 }
 
@@ -131,7 +130,6 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
 }
 
@@ -140,7 +138,6 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV32 | RVI | RVM | RVA | RVC | RVU);
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 #elif defined(TARGET_RISCV64)
@@ -150,7 +147,6 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_09_1);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
 }
 
@@ -159,7 +155,6 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV64 | RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
     set_feature(env, RISCV_FEATURE_MMU);
 }
 
@@ -168,7 +163,6 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     set_misa(env, RV64 | RVI | RVM | RVA | RVC | RVU);
     set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
-    set_resetvec(env, DEFAULT_RSTVEC);
 }
 
 #endif
@@ -292,6 +286,7 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
+    RISCVCPU *cpu = RISCV_CPU(dev);
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
@@ -302,6 +297,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     qemu_init_vcpu(cs);
+    set_resetvec(&cpu->env, cpu->rstvec);
     cpu_reset(cs);
 
     mcc->parent_realize(dev, errp);
@@ -315,6 +311,11 @@ static void riscv_cpu_init(Object *obj)
     cs->env_ptr = &cpu->env;
 }
 
+static Property riscv_cpu_properties[] = {
+    DEFINE_PROP_UINT64("rstvec", RISCVCPU, rstvec, DEFAULT_RSTVEC),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .unmigratable = 1,
@@ -329,6 +330,8 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     mcc->parent_realize = dc->realize;
     dc->realize = riscv_cpu_realize;
 
+    dc->props = riscv_cpu_properties;
+
     mcc->parent_reset = cc->reset;
     cc->reset = riscv_cpu_reset;
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 41e06ac0f9..80f7772b04 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -210,6 +210,8 @@ typedef struct RISCVCPU {
     CPUState parent_obj;
     /*< public >*/
     CPURISCVState env;
+
+    uint64_t rstvec;
 } RISCVCPU;
 
 static inline RISCVCPU *riscv_env_get_cpu(CPURISCVState *env)
-- 
2.17.0
