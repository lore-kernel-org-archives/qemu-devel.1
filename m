Received: from eggs.gnu.org ([2001:4830:134:3::10]:41046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUV-0008Sv-Oo
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUQ-000386-T4
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUQ-00037r-Kn
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:07 -0300
Message-Id: <20170901150317.10380-20-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/29] xtensa: replace cpu_xtensa_init() with
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

call xtensa_irq_init() at realize time which makes
cpu_xtensa_init() like generic cpu creation function.
As result we can replace it with cpu_generic_init()
which does the same job, reducing code duplication a bit.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1503592308-93913-16-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/xtensa/cpu.h    |  4 +---
 hw/xtensa/sim.c        |  2 +-
 hw/xtensa/xtfpga.c     |  2 +-
 target/xtensa/cpu.c    |  3 +++
 target/xtensa/helper.c | 22 ----------------------
 5 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index ee29fb1a14..48033313c5 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -475,9 +475,7 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, va=
ddr addr,
 #define XTENSA_DEFAULT_CPU_MODEL "dc232b"
 #endif
=20
-XtensaCPU *cpu_xtensa_init(const char *cpu_model);
-
-#define cpu_init(cpu_model) CPU(cpu_xtensa_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_model)
=20
 void xtensa_translate_init(void);
 void xtensa_breakpoint_handler(CPUState *cs);
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 249cd1e8c9..1b4767f58b 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -84,7 +84,7 @@ static void xtensa_sim_init(MachineState *machine)
     }
=20
     for (n =3D 0; n < smp_cpus; n++) {
-        cpu =3D cpu_xtensa_init(cpu_model);
+        cpu =3D XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model))=
;
         if (cpu =3D=3D NULL) {
             error_report("unable to find CPU definition '%s'",
                          cpu_model);
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 635a4d4ec3..182ec1e31c 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -232,7 +232,7 @@ static void lx_init(const LxBoardDesc *board, Machine=
State *machine)
     }
=20
     for (n =3D 0; n < smp_cpus; n++) {
-        cpu =3D cpu_xtensa_init(cpu_model);
+        cpu =3D XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model))=
;
         if (cpu =3D=3D NULL) {
             error_report("unable to find CPU definition '%s'",
                          cpu_model);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index cd7f95823f..85897df0a8 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -100,9 +100,12 @@ static ObjectClass *xtensa_cpu_class_by_name(const c=
har *cpu_model)
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs =3D CPU(dev);
+    XtensaCPU *cpu =3D XTENSA_CPU(dev);
     XtensaCPUClass *xcc =3D XTENSA_CPU_GET_CLASS(dev);
     Error *local_err =3D NULL;
=20
+    xtensa_irq_init(&cpu->env);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err !=3D NULL) {
         error_propagate(errp, local_err);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index bcd0b7738d..e8fba20918 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -113,28 +113,6 @@ void xtensa_breakpoint_handler(CPUState *cs)
     }
 }
=20
-XtensaCPU *cpu_xtensa_init(const char *cpu_model)
-{
-    ObjectClass *oc;
-    XtensaCPU *cpu;
-    CPUXtensaState *env;
-
-    oc =3D cpu_class_by_name(TYPE_XTENSA_CPU, cpu_model);
-    if (oc =3D=3D NULL) {
-        return NULL;
-    }
-
-    cpu =3D XTENSA_CPU(object_new(object_class_get_name(oc)));
-    env =3D &cpu->env;
-
-    xtensa_irq_init(env);
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
-}
-
-
 void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
 {
     XtensaConfigList *core =3D xtensa_cores;
--=20
2.13.5
