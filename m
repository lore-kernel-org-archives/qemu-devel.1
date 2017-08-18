Received: from eggs.gnu.org ([2001:4830:134:3::10]:60735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDQ-00047J-5Q
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDP-0000iK-3k
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDO-0000h6-QT
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF4AF37E67
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:17 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 64F4B5D743
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:17 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:46 +0200
Message-Id: <1503050939-227939-15-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.11 14/27] nios2: replace cpu_nios2_init()
 with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

cpu_nios2_init() always falls back to TYPE_NIOS2_CPU object
regardless of cpu_model. Put fallback logic into
nios2_cpu_class_by_name() which would translate any cpu_model
into TYPE_NIOS2_CPU class and replace cpu_nios2_init()
with cpu_generic_init()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 target/nios2/cpu.h        | 3 +--
 hw/nios2/10m50_devboard.c | 2 +-
 target/nios2/cpu.c        | 9 +++------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 13931f3..50d803a 100644
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
index b6868b8..e4007f6 100644
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
index d56bb72..5b02fb6 100644
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
2.7.4
