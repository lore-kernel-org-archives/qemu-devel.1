Received: from eggs.gnu.org ([2001:4830:134:3::10]:55116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv3D-0000mk-1E
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkv3B-0007ZA-RZ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkv3B-0007Yk-J2
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:32:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A7B06147A
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:08 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E8DD1F8
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 16:32:07 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 24 Aug 2017 18:31:41 +0200
Message-Id: <1503592308-93913-19-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.11 v3 18/25] arm: replace cpu_arm_init()
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

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
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
index b39d64a..5932ef1 100644
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
index 7e8ab31..a8b3d46 100644
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
index 3d15ff6..400ba30 100644
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
index bbf0b7e..ece25ae 100644
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
index 194b0bc..b0ac3cf 100644
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
index 6a45dcc..884242b 100644
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
index fa60040..0ec92d3 100644
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
2.7.4
