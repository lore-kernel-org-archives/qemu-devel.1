Received: from eggs.gnu.org ([2001:4830:134:3::10]:41173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUg-0000Az-OY
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUW-00039e-Py
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUW-00039Q-Hc
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:10 -0300
Message-Id: <20170901150317.10380-23-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 22/29] arm: replace cpu_arm_init() with
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
Reviewed-by: Andrew Jones <drjones@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1503592308-93913-19-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/arm/cpu.h    | 3 +--
 hw/arm/musicpal.c   | 2 +-
 hw/arm/omap1.c      | 2 +-
 hw/arm/omap2.c      | 2 +-
 hw/arm/pxa2xx.c     | 4 ++--
 hw/arm/strongarm.c  | 2 +-
 target/arm/helper.c | 5 -----
 7 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b39d64aa0b..5932ef1e22 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -748,7 +748,6 @@ int aarch64_cpu_gdb_read_register(CPUState *cpu, uint=
8_t *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg)=
;
 #endif
=20
-ARMCPU *cpu_arm_init(const char *cpu_model);
 target_ulong do_arm_semihosting(CPUARMState *env);
 void aarch64_sync_32_to_64(CPUARMState *env);
 void aarch64_sync_64_to_32(CPUARMState *env);
@@ -2001,7 +2000,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, =
unsigned int excp_idx,
     return unmasked || pstate_unmasked;
 }
=20
-#define cpu_init(cpu_model) CPU(cpu_arm_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_ARM_CPU, cpu_model)
=20
 #define cpu_signal_handler cpu_arm_signal_handler
 #define cpu_list arm_cpu_list
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 7e8ab3184c..a8b3d463fc 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1593,7 +1593,7 @@ static void musicpal_init(MachineState *machine)
     if (!cpu_model) {
         cpu_model =3D "arm926";
     }
-    cpu =3D cpu_arm_init(cpu_model);
+    cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
     if (!cpu) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 3d15ff6779..400ba30c94 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3863,7 +3863,7 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryReg=
ion *system_memory,
=20
     /* Core */
     s->mpu_model =3D omap310;
-    s->cpu =3D cpu_arm_init(core);
+    s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core));
     if (s->cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index bbf0b7e188..ece25ae744 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -2261,7 +2261,7 @@ struct omap_mpu_state_s *omap2420_mpu_init(MemoryRe=
gion *sysmem,
=20
     /* Core */
     s->mpu_model =3D omap2420;
-    s->cpu =3D cpu_arm_init(core ?: "arm1136-r2");
+    s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, core ?: "arm1136-r=
2"));
     if (s->cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 194b0bc808..b0ac3cfd64 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2066,7 +2066,7 @@ PXA2xxState *pxa270_init(MemoryRegion *address_spac=
e,
     if (!revision)
         revision =3D "pxa270";
=20
-    s->cpu =3D cpu_arm_init(revision);
+    s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, revision));
     if (s->cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
@@ -2196,7 +2196,7 @@ PXA2xxState *pxa255_init(MemoryRegion *address_spac=
e, unsigned int sdram_size)
=20
     s =3D g_new0(PXA2xxState, 1);
=20
-    s->cpu =3D cpu_arm_init("pxa255");
+    s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, "pxa255"));
     if (s->cpu =3D=3D NULL) {
         fprintf(stderr, "Unable to find CPU definition\n");
         exit(1);
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 6a45dcc009..884242b2dc 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -1597,7 +1597,7 @@ StrongARMState *sa1110_init(MemoryRegion *sysmem,
         exit(1);
     }
=20
-    s->cpu =3D cpu_arm_init(rev);
+    s->cpu =3D ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, rev));
=20
     if (!s->cpu) {
         error_report("Unable to find CPU definition");
diff --git a/target/arm/helper.c b/target/arm/helper.c
index fa60040361..0ec92d3214 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5233,11 +5233,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 }
=20
-ARMCPU *cpu_arm_init(const char *cpu_model)
-{
-    return ARM_CPU(cpu_generic_init(TYPE_ARM_CPU, cpu_model));
-}
-
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 {
     CPUState *cs =3D CPU(cpu);
--=20
2.13.5
