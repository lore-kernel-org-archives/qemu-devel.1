Received: from eggs.gnu.org ([209.51.188.92]:59556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnZ-0005z8-Do
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hHMnY-00059K-2J
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hHMnX-00058n-Qe
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 02:14:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 19 Apr 2019 03:14:29 -0300
Message-Id: <20190419061429.17695-8-ehabkost@redhat.com>
In-Reply-To: <20190419061429.17695-1-ehabkost@redhat.com>
References: <20190419061429.17695-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 7/7] cpu: Set fixed class name on some
 architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

hppa, microblaze, nios2, and tilegx have a fixed class name being
returned by CPUClass::class_by_name.  We can implement the same
behavior by setting CPUClass::class_name_format.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Richard Henderson <rth@twiddle.net>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Marek Vasut <marex@denx.de>
---
 target/hppa/cpu.c       | 8 ++------
 target/microblaze/cpu.c | 8 ++------
 target/nios2/cpu.c      | 8 ++------
 target/tilegx/cpu.c     | 8 ++------
 4 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 00bf444620..c4a1106df9 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -144,11 +144,6 @@ static void hppa_cpu_initfn(Object *obj)
     cpu_hppa_put_psw(env, PSW_W);
 }
 
-static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
-{
-    return object_class_by_name(TYPE_HPPA_CPU);
-}
-
 static void hppa_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -158,7 +153,8 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
     device_class_set_parent_realize(dc, hppa_cpu_realizefn,
                                     &acc->parent_realize);
 
-    cc->class_by_name = hppa_cpu_class_by_name;
+    /* All CPU model names are translated to the same QOM class */
+    cc->class_name_format = TYPE_HPPA_CPU;
     cc->has_work = hppa_cpu_has_work;
     cc->do_interrupt = hppa_cpu_do_interrupt;
     cc->cpu_exec_interrupt = hppa_cpu_exec_interrupt;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 5596cd5485..aee09f7d96 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -280,11 +280,6 @@ static Property mb_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
-{
-    return object_class_by_name(TYPE_MICROBLAZE_CPU);
-}
-
 static void mb_cpu_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -296,7 +291,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     mcc->parent_reset = cc->reset;
     cc->reset = mb_cpu_reset;
 
-    cc->class_by_name = mb_cpu_class_by_name;
+    /* All CPU model names are translated to the same QOM class */
+    cc->class_name_format = TYPE_MICROBLAZE_CPU;
     cc->has_work = mb_cpu_has_work;
     cc->do_interrupt = mb_cpu_do_interrupt;
     cc->cpu_exec_interrupt = mb_cpu_exec_interrupt;
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index fbfaa2ce26..3427ffedca 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -77,11 +77,6 @@ static void nios2_cpu_initfn(Object *obj)
 #endif
 }
 
-static ObjectClass *nios2_cpu_class_by_name(const char *cpu_model)
-{
-    return object_class_by_name(TYPE_NIOS2_CPU);
-}
-
 static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -193,7 +188,8 @@ static void nios2_cpu_class_init(ObjectClass *oc, void *data)
     ncc->parent_reset = cc->reset;
     cc->reset = nios2_cpu_reset;
 
-    cc->class_by_name = nios2_cpu_class_by_name;
+    /* All CPU model names are translated to the same QOM class */
+    cc->class_name_format = TYPE_NIOS2_CPU;
     cc->has_work = nios2_cpu_has_work;
     cc->do_interrupt = nios2_cpu_do_interrupt;
     cc->cpu_exec_interrupt = nios2_cpu_exec_interrupt;
diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index bfe9be59b5..710af17507 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -51,11 +51,6 @@ static void tilegx_cpu_dump_state(CPUState *cs, FILE *f,
                 env->pc, env->spregs[TILEGX_SPR_CMPEXCH]);
 }
 
-static ObjectClass *tilegx_cpu_class_by_name(const char *cpu_model)
-{
-    return object_class_by_name(TYPE_TILEGX_CPU);
-}
-
 static void tilegx_cpu_set_pc(CPUState *cs, vaddr value)
 {
     TileGXCPU *cpu = TILEGX_CPU(cs);
@@ -146,7 +141,8 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     tcc->parent_reset = cc->reset;
     cc->reset = tilegx_cpu_reset;
 
-    cc->class_by_name = tilegx_cpu_class_by_name;
+    /* All CPU model names are translated to the same QOM class */
+    cc->class_name_format = TYPE_TILEGX_CPU;
     cc->has_work = tilegx_cpu_has_work;
     cc->do_interrupt = tilegx_cpu_do_interrupt;
     cc->cpu_exec_interrupt = tilegx_cpu_exec_interrupt;
-- 
2.18.0.rc1.1.g3f1ff2140
