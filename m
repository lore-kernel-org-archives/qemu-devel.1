Received: from eggs.gnu.org ([2001:4830:134:3::10]:42055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzH-000549-Iq
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzE-0004Qq-Ij
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOzE-0004Pi-6d
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:43 -0300
Message-Id: <20170919201850.14772-6-ehabkost@redhat.com>
In-Reply-To: <20170919201850.14772-1-ehabkost@redhat.com>
References: <20170919201850.14772-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/12] cpu: make cpu_generic_init() abort QEMU
 on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Almost every user of cpu_generic_init() checks for
returned NULL and then reports failure in a custom way
and aborts process.
Some users assume that call can't fail and don't check
for failure, though they should have checked for it.

In either cases cpu_generic_init() failure is fatal,
so instead of checking for failure and reporting
it various ways, make cpu_generic_init() report
errors in consistent way and terminate QEMU on failure.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1505318697-77161-3-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/cpu.h              |  3 ++-
 bsd-user/main.c                |  4 ----
 hw/alpha/dp264.c               |  4 ----
 hw/arm/musicpal.c              |  4 ----
 hw/arm/omap1.c                 |  4 ----
 hw/arm/omap2.c                 |  4 ----
 hw/arm/pxa2xx.c                |  8 --------
 hw/arm/strongarm.c             |  5 -----
 hw/lm32/lm32_boards.c          |  8 --------
 hw/lm32/milkymist.c            |  4 ----
 hw/m68k/an5206.c               |  4 ----
 hw/m68k/mcf5208.c              |  4 ----
 hw/mips/cps.c                  |  4 ----
 hw/mips/mips_fulong2e.c        |  4 ----
 hw/mips/mips_jazz.c            |  4 ----
 hw/mips/mips_malta.c           |  4 ----
 hw/mips/mips_mipssim.c         |  4 ----
 hw/mips/mips_r4k.c             |  4 ----
 hw/moxie/moxiesim.c            |  4 ----
 hw/openrisc/openrisc_sim.c     |  4 ----
 hw/ppc/e500.c                  |  4 ----
 hw/ppc/mac_newworld.c          |  4 ----
 hw/ppc/mac_oldworld.c          |  4 ----
 hw/ppc/ppc440_bamboo.c         |  4 ----
 hw/ppc/ppc4xx_devs.c           |  5 -----
 hw/ppc/prep.c                  |  9 ---------
 hw/ppc/virtex_ml507.c          |  4 ----
 hw/sh4/r2d.c                   |  4 ----
 hw/sh4/shix.c                  |  4 ----
 hw/sparc/leon3.c               |  4 ----
 hw/sparc/sun4m.c               |  4 ----
 hw/sparc64/sparc64.c           |  4 ----
 hw/tricore/tricore_testboard.c |  4 ----
 hw/unicore32/puv3.c            |  4 ----
 hw/xtensa/sim.c                |  5 -----
 hw/xtensa/xtfpga.c             |  5 -----
 linux-user/main.c              |  4 ----
 qom/cpu.c                      | 19 +++++--------------
 38 files changed, 7 insertions(+), 176 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 885276c0cf..6d33cf1878 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -661,7 +661,8 @@ CPUState *cpu_create(const char *typename);
  *
  * processes optional parameters and registers them as global properties
  *
- * Returns: type of CPU to create or %NULL if an error occurred.
+ * Returns: type of CPU to create or prints error and terminates process
+ *          if an error occurred.
  */
 const char *cpu_parse_cpu_model(const char *typename, const char *cpu_mo=
del);
=20
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 8a6706a1c8..836daac15c 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -902,10 +902,6 @@ int main(int argc, char **argv)
     /* NOTE: we need to init the CPU at this stage to get
        qemu_host_page_size */
     cpu =3D cpu_init(cpu_model);
-    if (!cpu) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     env =3D cpu->env_ptr;
 #if defined(TARGET_SPARC) || defined(TARGET_PPC)
     cpu_reset(cpu);
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 1c5a177102..1b121306c2 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -68,10 +68,6 @@ static void clipper_init(MachineState *machine)
     memset(cpus, 0, sizeof(cpus));
     for (i =3D 0; i < smp_cpus; ++i) {
         cpus[i] =3D ALPHA_CPU(cpu_generic_init(TYPE_ALPHA_CPU, cpu_model=
));
-        if (!cpus[i]) {
-            error_report("Unable to find CPU definition");
-            exit(1);
-        }
     }
=20
     cpus[0]->env.trap_arg0 =3D ram_size;
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index ab4ba31a24..7a6c0a6deb 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1594,10 +1594,6 @@ static void musicpal_init(MachineState *machine)
         cpu_model =3D "arm926";
     }
     cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
-    if (!cpu) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
=20
     /* For now we use a fixed - the original - RAM size */
     memory_region_allocate_system_memory(ram, NULL, "musicpal.ram",
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 400ba30c94..04e65ce168 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3864,10 +3864,6 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRe=
gion *system_memory,
     /* Core */
     s->mpu_model =3D omap310;
     s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core));
-    if (s->cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     s->sdram_size =3D sdram_size;
     s->sram_size =3D OMAP15XX_SRAM_SIZE;
=20
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index ece25ae744..5821477950 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2262,10 +2262,6 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryR=
egion *sysmem,
     /* Core */
     s->mpu_model =3D omap2420;
     s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core ?: "arm1136-r=
2"));
-    if (s->cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     s->sdram_size =3D sdram_size;
     s->sram_size =3D OMAP242X_SRAM_SIZE;
=20
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index b0ac3cfd64..c16657da86 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2067,10 +2067,6 @@ PXA2xxState *pxa270_init(MemoryRegion *address_spa=
ce,
         revision =3D "pxa270";
=20
     s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, revision));
-    if (s->cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     s->reset =3D qemu_allocate_irq(pxa2xx_reset, s, 0);
=20
     /* SDRAM & Internal Memory Storage */
@@ -2197,10 +2193,6 @@ PXA2xxState *pxa255_init(MemoryRegion *address_spa=
ce, unsigned int sdram_size)
     s =3D g_new0(PXA2xxState, 1);
=20
     s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, "pxa255"));
-    if (s->cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     s->reset =3D qemu_allocate_irq(pxa2xx_reset, s, 0);
=20
     /* SDRAM & Internal Memory Storage */
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 884242b2dc..c1145dd723 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1599,11 +1599,6 @@ StrongARMState *sa1110_init(MemoryRegion *sysmem,
=20
     s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, rev));
=20
-    if (!s->cpu) {
-        error_report("Unable to find CPU definition");
-        exit(1);
-    }
-
     memory_region_allocate_system_memory(&s->sdram, NULL, "strongarm.sdr=
am",
                                          sdram_size);
     memory_region_add_subregion(sysmem, SA_SDCS0, &s->sdram);
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index eccf0ac5a1..b0bb3ef58a 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -105,10 +105,6 @@ static void lm32_evr_init(MachineState *machine)
         cpu_model =3D "lm32-full";
     }
     cpu =3D LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "qemu: unable to find CPU '%s'\n", cpu_model);
-        exit(1);
-    }
=20
     env =3D &cpu->env;
     reset_info->cpu =3D cpu;
@@ -206,10 +202,6 @@ static void lm32_uclinux_init(MachineState *machine)
         cpu_model =3D "lm32-full";
     }
     cpu =3D LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "qemu: unable to find CPU '%s'\n", cpu_model);
-        exit(1);
-    }
=20
     env =3D &cpu->env;
     reset_info->cpu =3D cpu;
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index dffd8797bb..4db4d2d533 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -112,10 +112,6 @@ milkymist_init(MachineState *machine)
         cpu_model =3D "lm32-full";
     }
     cpu =3D LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "qemu: unable to find CPU '%s'\n", cpu_model);
-        exit(1);
-    }
=20
     env =3D &cpu->env;
     reset_info->cpu =3D cpu;
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 7b9b15d6c4..9002c460e5 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -43,10 +43,6 @@ static void an5206_init(MachineState *machine)
         cpu_model =3D "m5206";
     }
     cpu =3D M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
-    if (!cpu) {
-        error_report("Unable to find m68k CPU definition");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     /* Initialize CPU registers.  */
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 1a0f18073a..b9dde75106 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -233,10 +233,6 @@ static void mcf5208evb_init(MachineState *machine)
         cpu_model =3D "m5208";
     }
     cpu =3D M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
-    if (!cpu) {
-        fprintf(stderr, "Unable to find m68k CPU definition\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     /* Initialize CPU registers.  */
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 4ef337d5c4..79d4c5e30a 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -72,10 +72,6 @@ static void mips_cps_realize(DeviceState *dev, Error *=
*errp)
=20
     for (i =3D 0; i < s->num_vp; i++) {
         cpu =3D cpu_mips_init(s->cpu_model);
-        if (cpu =3D=3D NULL) {
-            error_setg(errp, "%s: CPU initialization failed",  __func__)=
;
-            return;
-        }
=20
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 3532399a13..439a3d7a66 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -281,10 +281,6 @@ static void mips_fulong2e_init(MachineState *machine=
)
         cpu_model =3D "Loongson-2E";
     }
     cpu =3D cpu_mips_init(cpu_model);
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     qemu_register_reset(main_cpu_reset, cpu);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index df2262a2a8..ae10670efd 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -152,10 +152,6 @@ static void mips_jazz_init(MachineState *machine,
         cpu_model =3D "R4000";
     }
     cpu =3D cpu_mips_init(cpu_model);
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     env =3D &cpu->env;
     qemu_register_reset(main_cpu_reset, cpu);
=20
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index af678f5784..c82e0af340 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -932,10 +932,6 @@ static void create_cpu_without_cps(const char *cpu_m=
odel,
=20
     for (i =3D 0; i < smp_cpus; i++) {
         cpu =3D cpu_mips_init(cpu_model);
-        if (cpu =3D=3D NULL) {
-            fprintf(stderr, "Unable to find CPU definition\n");
-            exit(1);
-        }
=20
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 07fc4c2300..49cd38d680 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -164,10 +164,6 @@ mips_mipssim_init(MachineState *machine)
 #endif
     }
     cpu =3D cpu_mips_init(cpu_model);
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     reset_info =3D g_malloc0(sizeof(ResetData));
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 2f5ced7409..60da6070bc 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -194,10 +194,6 @@ void mips_r4k_init(MachineState *machine)
 #endif
     }
     cpu =3D cpu_mips_init(cpu_model);
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     reset_info =3D g_malloc0(sizeof(ResetData));
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 4c27b45c46..5ea8dd3a93 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -119,10 +119,6 @@ static void moxiesim_init(MachineState *machine)
         cpu_model =3D "MoxieLite-moxie-cpu";
     }
     cpu =3D MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
-    if (!cpu) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     qemu_register_reset(main_cpu_reset, cpu);
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 243d8020db..86bf2849c4 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -110,10 +110,6 @@ static void openrisc_sim_init(MachineState *machine)
=20
     for (n =3D 0; n < smp_cpus; n++) {
         cpu =3D OPENRISC_CPU(cpu_generic_init(TYPE_OPENRISC_CPU, cpu_mod=
el));
-        if (cpu =3D=3D NULL) {
-            fprintf(stderr, "Unable to find CPU definition!\n");
-            exit(1);
-        }
         qemu_register_reset(main_cpu_reset, cpu);
         main_cpu_reset(cpu);
     }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 55cad780f4..db0e49ab8f 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -817,10 +817,6 @@ void ppce500_init(MachineState *machine, PPCE500Para=
ms *params)
=20
         cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
                                            machine->cpu_model));
-        if (cpu =3D=3D NULL) {
-            fprintf(stderr, "Unable to initialize CPU!\n");
-            exit(1);
-        }
         env =3D &cpu->env;
         cs =3D CPU(cpu);
=20
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index d466634997..33b46cb50b 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -189,10 +189,6 @@ static void ppc_core99_init(MachineState *machine)
     for (i =3D 0; i < smp_cpus; i++) {
         cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
                                            machine->cpu_model));
-        if (cpu =3D=3D NULL) {
-            fprintf(stderr, "Unable to find PowerPC CPU definition\n");
-            exit(1);
-        }
         env =3D &cpu->env;
=20
         /* Set time-base frequency to 100 Mhz */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index fcac399562..193b9047d9 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -118,10 +118,6 @@ static void ppc_heathrow_init(MachineState *machine)
     for (i =3D 0; i < smp_cpus; i++) {
         cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
                                            machine->cpu_model));
-        if (cpu =3D=3D NULL) {
-            fprintf(stderr, "Unable to find PowerPC CPU definition\n");
-            exit(1);
-        }
         env =3D &cpu->env;
=20
         /* Set time-base frequency to 16.6 Mhz */
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index ca26398036..f92d47f28d 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -187,10 +187,6 @@ static void bamboo_init(MachineState *machine)
         machine->cpu_model =3D "440EP";
     }
     cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_=
model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to initialize CPU!\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index ec90f13295..6d7f7857fe 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -57,11 +57,6 @@ PowerPCCPU *ppc4xx_init(const char *cpu_model,
=20
     /* init CPUs */
     cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find PowerPC %s CPU definition\n",
-                cpu_model);
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     cpu_clk->cb =3D NULL; /* We don't care about CPU clock frequency cha=
nges */
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 00f3321a60..94138a4e8c 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -522,10 +522,6 @@ static void ppc_prep_init(MachineState *machine)
     for (i =3D 0; i < smp_cpus; i++) {
         cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
                                            machine->cpu_model));
-        if (cpu =3D=3D NULL) {
-            fprintf(stderr, "Unable to find PowerPC CPU definition\n");
-            exit(1);
-        }
         env =3D &cpu->env;
=20
         if (env->flags & POWERPC_FLAG_RTC_CLK) {
@@ -726,11 +722,6 @@ static void ibm_40p_init(MachineState *machine)
         machine->cpu_model =3D "604";
     }
     cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_=
model));
-    if (!cpu) {
-        error_report("could not initialize CPU '%s'",
-                     machine->cpu_model);
-        exit(1);
-    }
     env =3D &cpu->env;
     if (PPC_INPUT(env) !=3D PPC_FLAGS_INPUT_6xx) {
         error_report("only 6xx bus is supported on this machine");
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index d5fdc16b59..ed9b406fd3 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -97,10 +97,6 @@ static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_=
size,
     qemu_irq *irqs;
=20
     cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to initialize CPU!\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     ppc_booke_timers_init(cpu, sysclk, 0/* no flags */);
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 22bc534e5f..16b9ed2db2 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -247,10 +247,6 @@ static void r2d_init(MachineState *machine)
     }
=20
     cpu =3D SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     reset_info =3D g_malloc0(sizeof(ResetData));
diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
index 7f8a4b6484..50ee36a5c5 100644
--- a/hw/sh4/shix.c
+++ b/hw/sh4/shix.c
@@ -57,10 +57,6 @@ static void shix_init(MachineState *machine)
         cpu_model =3D "any";
=20
     cpu =3D SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(1);
-    }
=20
     /* Allocate memory space */
     memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &error_fatal);
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 56512ecd00..ec2816bf94 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -127,10 +127,6 @@ static void leon3_generic_hw_init(MachineState *mach=
ine)
     }
=20
     cpu =3D SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "qemu: Unable to find Sparc CPU definition\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     cpu_sparc_set_id(env, 0);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index cf47dca83a..e1bdd4828d 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -798,10 +798,6 @@ static void cpu_devinit(const char *cpu_model, unsig=
ned int id,
     CPUSPARCState *env;
=20
     cpu =3D SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "qemu: Unable to find Sparc CPU definition\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     cpu_sparc_set_id(env, id);
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index ecf38a45da..097d529ff1 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -354,10 +354,6 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_model,
         cpu_model =3D default_cpu_model;
     }
     cpu =3D SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
-    if (cpu =3D=3D NULL) {
-        fprintf(stderr, "Unable to find Sparc CPU definition\n");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     env->tick =3D cpu_timer_create("tick", cpu, tick_irq,
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboar=
d.c
index 3fcd8bb70e..0486f8a1d9 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -75,10 +75,6 @@ static void tricore_testboard_init(MachineState *machi=
ne, int board_id)
         machine->cpu_model =3D "tc1796";
     }
     cpu =3D TRICORE_CPU(cpu_generic_init(TYPE_TRICORE_CPU, machine->cpu_=
model));
-    if (!cpu) {
-        error_report("Unable to find CPU definition");
-        exit(1);
-    }
     env =3D &cpu->env;
     memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
                            2 * 1024 * 1024, &error_fatal);
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index eb9862fa2f..504ea46211 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -128,10 +128,6 @@ static void puv3_init(MachineState *machine)
     }
=20
     cpu =3D UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model=
));
-    if (!cpu) {
-        error_report("Unable to find CPU definition");
-        exit(1);
-    }
     env =3D &cpu->env;
=20
     puv3_soc_init(env);
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 1b4767f58b..b3580b11fa 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -85,11 +85,6 @@ static void xtensa_sim_init(MachineState *machine)
=20
     for (n =3D 0; n < smp_cpus; n++) {
         cpu =3D XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model))=
;
-        if (cpu =3D=3D NULL) {
-            error_report("unable to find CPU definition '%s'",
-                         cpu_model);
-            exit(EXIT_FAILURE);
-        }
         env =3D &cpu->env;
=20
         env->sregs[PRID] =3D n;
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 182ec1e31c..a19ccebdba 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -233,11 +233,6 @@ static void lx_init(const LxBoardDesc *board, Machin=
eState *machine)
=20
     for (n =3D 0; n < smp_cpus; n++) {
         cpu =3D XTENSA_CPU(cpu_generic_init(TYPE_XTENSA_CPU, cpu_model))=
;
-        if (cpu =3D=3D NULL) {
-            error_report("unable to find CPU definition '%s'",
-                         cpu_model);
-            exit(EXIT_FAILURE);
-        }
         env =3D &cpu->env;
=20
         env->sregs[PRID] =3D n;
diff --git a/linux-user/main.c b/linux-user/main.c
index 03666ef657..829f974662 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4323,10 +4323,6 @@ int main(int argc, char **argv, char **envp)
     /* NOTE: we need to init the CPU at this stage to get
        qemu_host_page_size */
     cpu =3D cpu_init(cpu_model);
-    if (!cpu) {
-        fprintf(stderr, "Unable to find CPU definition\n");
-        exit(EXIT_FAILURE);
-    }
     env =3D cpu->env_ptr;
     cpu_reset(cpu);
=20
diff --git a/qom/cpu.c b/qom/cpu.c
index 483f26a5fb..94fa8fe005 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -62,7 +62,7 @@ CPUState *cpu_create(const char *typename)
     if (err !=3D NULL) {
         error_report_err(err);
         object_unref(OBJECT(cpu));
-        return NULL;
+        exit(EXIT_FAILURE);
     }
     return cpu;
 }
@@ -71,7 +71,6 @@ const char *cpu_parse_cpu_model(const char *typename, c=
onst char *cpu_model)
 {
     ObjectClass *oc;
     CPUClass *cc;
-    Error *err =3D NULL;
     gchar **model_pieces;
     const char *cpu_type;
=20
@@ -79,18 +78,15 @@ const char *cpu_parse_cpu_model(const char *typename,=
 const char *cpu_model)
=20
     oc =3D cpu_class_by_name(typename, model_pieces[0]);
     if (oc =3D=3D NULL) {
+        error_report("unable to find CPU model '%s'", model_pieces[0]);
         g_strfreev(model_pieces);
-        return NULL;
+        exit(EXIT_FAILURE);
     }
=20
     cpu_type =3D object_class_get_name(oc);
     cc =3D CPU_CLASS(oc);
-    cc->parse_features(cpu_type, model_pieces[1], &err);
+    cc->parse_features(cpu_type, model_pieces[1], &error_fatal);
     g_strfreev(model_pieces);
-    if (err !=3D NULL) {
-        error_report_err(err);
-        return NULL;
-    }
     return cpu_type;
 }
=20
@@ -99,12 +95,7 @@ CPUState *cpu_generic_init(const char *typename, const=
 char *cpu_model)
     /* TODO: all callers of cpu_generic_init() need to be converted to
      * call cpu_parse_features() only once, before calling cpu_generic_i=
nit().
      */
-    const char *cpu_type =3D cpu_parse_cpu_model(typename, cpu_model);
-
-    if (cpu_type) {
-        return cpu_create(cpu_type);
-    }
-    return NULL;
+    return cpu_create(cpu_parse_cpu_model(typename, cpu_model));
 }
=20
 bool cpu_paging_enabled(const CPUState *cpu)
--=20
2.13.5
