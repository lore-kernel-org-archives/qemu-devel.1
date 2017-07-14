Received: from eggs.gnu.org ([2001:4830:134:3::10]:41767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12p-00039z-6F
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12l-000220-Ob
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:54:11 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:19 +0200
Message-Id: <1500040339-119465-29-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 28/28] ppc: replace cpu_ppc_init() with
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
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Alexander Graf <agraf@suse.de>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
CC: qemu-ppc@nongnu.org
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
index 6ee2a26..696cbeb 100644
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
index 62f1857..f0596f3 100644
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
index bae1c0a..72c98e9 100644
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
index 97bb854..6fc2a19 100644
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
index 9d997bf..ca26398 100644
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
index e7f413e..6b38ed7 100644
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
index 36d3dcd..00f3321 100644
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
index fdbcf22..d5fdc16 100644
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
index 783bf98..b4eaabb 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10250,11 +10250,6 @@ const char *ppc_cpu_lookup_alias(const char *ali=
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
2.7.4
