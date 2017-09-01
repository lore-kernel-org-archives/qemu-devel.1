Received: from eggs.gnu.org ([2001:4830:134:3::10]:41311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUv-0000R7-8S
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUq-0003Gb-0G
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUp-0003GG-Ns
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:35 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:17 -0300
Message-Id: <20170901150317.10380-30-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/29] ppc: replace cpu_ppc_init() with
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

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1503592308-93913-26-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/ppc/cpu.h            | 3 +--
 hw/ppc/e500.c               | 3 ++-
 hw/ppc/mac_newworld.c       | 3 ++-
 hw/ppc/mac_oldworld.c       | 3 ++-
 hw/ppc/ppc440_bamboo.c      | 2 +-
 hw/ppc/ppc4xx_devs.c        | 2 +-
 hw/ppc/prep.c               | 5 +++--
 hw/ppc/virtex_ml507.c       | 2 +-
 target/ppc/translate_init.c | 5 -----
 9 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 46d3dd88f6..12f09492fb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1276,7 +1276,6 @@ extern const struct VMStateDescription vmstate_ppc_=
cpu;
 #endif
=20
 /***********************************************************************=
******/
-PowerPCCPU *cpu_ppc_init(const char *cpu_model);
 void ppc_translate_init(void);
 const char *ppc_cpu_lookup_alias(const char *alias);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
@@ -1353,7 +1352,7 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *en=
v, int gprn)
 int ppc_dcr_read (ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
 int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
=20
-#define cpu_init(cpu_model) CPU(cpu_ppc_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_POWERPC_CPU, cpu_model=
)
=20
 #define cpu_signal_handler cpu_ppc_signal_handler
 #define cpu_list ppc_cpu_list
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 62f1857206..f0596f34ff 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -819,7 +819,8 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
         CPUState *cs;
         qemu_irq *input;
=20
-        cpu =3D cpu_ppc_init(machine->cpu_model);
+        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
+                                           machine->cpu_model));
         if (cpu =3D=3D NULL) {
             fprintf(stderr, "Unable to initialize CPU!\n");
             exit(1);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3056d5f075..d466634997 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -187,7 +187,8 @@ static void ppc_core99_init(MachineState *machine)
 #endif
     }
     for (i =3D 0; i < smp_cpus; i++) {
-        cpu =3D cpu_ppc_init(machine->cpu_model);
+        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
+                                           machine->cpu_model));
         if (cpu =3D=3D NULL) {
             fprintf(stderr, "Unable to find PowerPC CPU definition\n");
             exit(1);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index f2ae60a360..fcac399562 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -116,7 +116,8 @@ static void ppc_heathrow_init(MachineState *machine)
     if (machine->cpu_model =3D=3D NULL)
         machine->cpu_model =3D "G3";
     for (i =3D 0; i < smp_cpus; i++) {
-        cpu =3D cpu_ppc_init(machine->cpu_model);
+        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
+                                           machine->cpu_model));
         if (cpu =3D=3D NULL) {
             fprintf(stderr, "Unable to find PowerPC CPU definition\n");
             exit(1);
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 9d997bf743..ca26398036 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -186,7 +186,7 @@ static void bamboo_init(MachineState *machine)
     if (machine->cpu_model =3D=3D NULL) {
         machine->cpu_model =3D "440EP";
     }
-    cpu =3D cpu_ppc_init(machine->cpu_model);
+    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_=
model));
     if (cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to initialize CPU!\n");
         exit(1);
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index e7f413e49d..6b38ed7bc7 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -56,7 +56,7 @@ PowerPCCPU *ppc4xx_init(const char *cpu_model,
     CPUPPCState *env;
=20
     /* init CPUs */
-    cpu =3D cpu_ppc_init(cpu_model);
+    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
     if (cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to find PowerPC %s CPU definition\n",
                 cpu_model);
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 36d3dcd89a..00f3321a60 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -520,7 +520,8 @@ static void ppc_prep_init(MachineState *machine)
     if (machine->cpu_model =3D=3D NULL)
         machine->cpu_model =3D "602";
     for (i =3D 0; i < smp_cpus; i++) {
-        cpu =3D cpu_ppc_init(machine->cpu_model);
+        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
+                                           machine->cpu_model));
         if (cpu =3D=3D NULL) {
             fprintf(stderr, "Unable to find PowerPC CPU definition\n");
             exit(1);
@@ -724,7 +725,7 @@ static void ibm_40p_init(MachineState *machine)
     if (!machine->cpu_model) {
         machine->cpu_model =3D "604";
     }
-    cpu =3D cpu_ppc_init(machine->cpu_model);
+    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_=
model));
     if (!cpu) {
         error_report("could not initialize CPU '%s'",
                      machine->cpu_model);
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index fdbcf22a0c..d5fdc16b59 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -96,7 +96,7 @@ static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_s=
ize,
     CPUPPCState *env;
     qemu_irq *irqs;
=20
-    cpu =3D cpu_ppc_init(cpu_model);
+    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
     if (cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to initialize CPU!\n");
         exit(1);
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 8fb407ed73..43be9a8331 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10271,11 +10271,6 @@ const char *ppc_cpu_lookup_alias(const char *ali=
as)
     return NULL;
 }
=20
-PowerPCCPU *cpu_ppc_init(const char *cpu_model)
-{
-    return POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
-}
-
 PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
 {
     ObjectClass *oc =3D OBJECT_CLASS(pcc);
--=20
2.13.5
