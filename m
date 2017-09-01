Received: from eggs.gnu.org ([2001:4830:134:3::10]:40954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUH-0008CG-PH
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUC-00032m-Sh
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUC-00031S-K5
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:03:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:05 -0300
Message-Id: <20170901150317.10380-18-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/29] nios2: replace cpu_nios2_init() with
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

cpu_nios2_init() always falls back to TYPE_NIOS2_CPU object
regardless of cpu_model. Put fallback logic into
nios2_cpu_class_by_name() which would translate any cpu_model
into TYPE_NIOS2_CPU class and replace cpu_nios2_init()
with cpu_generic_init()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1503592308-93913-14-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/nios2/cpu.h        | 3 +--
 hw/nios2/10m50_devboard.c | 2 +-
 target/nios2/cpu.c        | 9 +++------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 13931f3f0b..50d803a217 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -212,7 +212,6 @@ static inline Nios2CPU *nios2_env_get_cpu(CPUNios2Sta=
te *env)
 #define ENV_OFFSET offsetof(Nios2CPU, env)
=20
 void nios2_tcg_init(void);
-Nios2CPU *cpu_nios2_init(const char *cpu_model);
 void nios2_cpu_do_interrupt(CPUState *cs);
 int cpu_nios2_signal_handler(int host_signum, void *pinfo, void *puc);
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUNios2State *env)=
;
@@ -229,7 +228,7 @@ void nios2_check_interrupts(CPUNios2State *env);
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
=20
-#define cpu_init(cpu_model) CPU(cpu_nios2_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_NIOS2_CPU, cpu_model)
=20
 #define cpu_gen_code cpu_nios2_gen_code
 #define cpu_signal_handler cpu_nios2_signal_handler
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index b6868b8233..e4007f6d7f 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -75,7 +75,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine=
)
                                 phys_ram_alias);
=20
     /* Create CPU -- FIXME */
-    cpu =3D cpu_nios2_init("nios2");
+    cpu =3D NIOS2_CPU(cpu_generic_init(TYPE_NIOS2_CPU, "nios2"));
=20
     /* Register: CPU interrupt controller (PIC) */
     cpu_irq =3D nios2_cpu_pic_init(cpu);
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index d56bb7245a..5b02fb67ea 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -83,13 +83,9 @@ static void nios2_cpu_initfn(Object *obj)
     }
 }
=20
-Nios2CPU *cpu_nios2_init(const char *cpu_model)
+static ObjectClass *nios2_cpu_class_by_name(const char *cpu_model)
 {
-    Nios2CPU *cpu =3D NIOS2_CPU(object_new(TYPE_NIOS2_CPU));
-
-    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
-
-    return cpu;
+    return object_class_by_name(TYPE_NIOS2_CPU);
 }
=20
 static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -203,6 +199,7 @@ static void nios2_cpu_class_init(ObjectClass *oc, voi=
d *data)
     ncc->parent_reset =3D cc->reset;
     cc->reset =3D nios2_cpu_reset;
=20
+    cc->class_by_name =3D nios2_cpu_class_by_name;
     cc->has_work =3D nios2_cpu_has_work;
     cc->do_interrupt =3D nios2_cpu_do_interrupt;
     cc->cpu_exec_interrupt =3D nios2_cpu_exec_interrupt;
--=20
2.13.5
