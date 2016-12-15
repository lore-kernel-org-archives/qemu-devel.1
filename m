Received: from eggs.gnu.org ([2001:4830:134:3::10]:51764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cHWjD-0006ZV-2t
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cHWj7-00075e-T6
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:09:47 -0500
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:35523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cHWj7-00074V-N7
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:09:41 -0500
Received: from player786.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 1A134689E0
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 15:09:39 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 15 Dec 2016 15:09:30 +0100
Message-Id: <1481810970-9692-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] target-arm: Add VBAR support to ARM1176 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

ARM1176 CPUs have TrustZone support and can use the Vector Base
Address Register, but currently, qemu only adds VBAR support to ARMv7
CPUs. Fix this by adding a new feature ARM_FEATURE_VBAR which can used
for ARMv7 and ARM1176 CPUs.

The VBAR feature is always set for ARMv7 because some legacy boards
require it even if this is not architecturally correct.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Hopefully, this is correct this time ...

 Thanks,

 C.

 Changes since v2 :
 - simplified the logic leading to the definition of VBAR

 Changes since v1 :
 - disable VBAR for non EL3 1176 CPU configs=20
 - always enable VBAR for v7 CPUs

 target-arm/cpu.c    |  9 +++++++++
 target-arm/cpu.h    |  1 +
 target-arm/helper.c | 19 +++++++++++++------
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/target-arm/cpu.c b/target-arm/cpu.c
index 99f0dbebb9f6..f5dc7ea9544c 100644
--- a/target-arm/cpu.c
+++ b/target-arm/cpu.c
@@ -597,6 +597,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
         } else {
             set_feature(env, ARM_FEATURE_V6);
         }
+
+        /* Always define VBAR for V7 CPUs even if it doesn't exist in
+         * non-EL3 configs. This is needed by some legacy boards.
+         */
+        set_feature(env, ARM_FEATURE_VBAR);
     }
     if (arm_feature(env, ARM_FEATURE_V6K)) {
         set_feature(env, ARM_FEATURE_V6);
@@ -721,6 +726,10 @@ static void arm_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
         }
     }
=20
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
+        set_feature(env, ARM_FEATURE_VBAR);
+    }
+
     register_cp_regs_for_features(cpu);
     arm_cpu_register_gdb_regs_for_features(cpu);
=20
diff --git a/target-arm/cpu.h b/target-arm/cpu.h
index ca5c849ed65e..ab119e62ab0f 100644
--- a/target-arm/cpu.h
+++ b/target-arm/cpu.h
@@ -1125,6 +1125,7 @@ enum arm_features {
     ARM_FEATURE_V8_PMULL, /* implements PMULL part of v8 Crypto Extensio=
ns */
     ARM_FEATURE_THUMB_DSP, /* DSP insns supported in the Thumb encodings=
 */
     ARM_FEATURE_PMU, /* has PMU support */
+    ARM_FEATURE_VBAR, /* has cp15 VBAR */
 };
=20
 static inline int arm_feature(CPUARMState *env, int feature)
diff --git a/target-arm/helper.c b/target-arm/helper.c
index b5b65caadf8a..8dcabbf57654 100644
--- a/target-arm/helper.c
+++ b/target-arm/helper.c
@@ -1252,12 +1252,6 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
       .access =3D PL1_RW, .accessfn =3D access_tpm, .type =3D ARM_CP_ALI=
AS,
       .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pminten),
       .writefn =3D pmintenclr_write },
-    { .name =3D "VBAR", .state =3D ARM_CP_STATE_BOTH,
-      .opc0 =3D 3, .crn =3D 12, .crm =3D 0, .opc1 =3D 0, .opc2 =3D 0,
-      .access =3D PL1_RW, .writefn =3D vbar_write,
-      .bank_fieldoffsets =3D { offsetof(CPUARMState, cp15.vbar_s),
-                             offsetof(CPUARMState, cp15.vbar_ns) },
-      .resetvalue =3D 0 },
     { .name =3D "CCSIDR", .state =3D ARM_CP_STATE_BOTH,
       .opc0 =3D 3, .crn =3D 0, .crm =3D 0, .opc1 =3D 1, .opc2 =3D 0,
       .access =3D PL1_R, .readfn =3D ccsidr_read, .type =3D ARM_CP_NO_RA=
W },
@@ -5094,6 +5088,19 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         }
     }
=20
+    if (arm_feature(env, ARM_FEATURE_VBAR)) {
+        ARMCPRegInfo vbar_cp_reginfo[] =3D {
+            { .name =3D "VBAR", .state =3D ARM_CP_STATE_BOTH,
+              .opc0 =3D 3, .crn =3D 12, .crm =3D 0, .opc1 =3D 0, .opc2 =3D=
 0,
+              .access =3D PL1_RW, .writefn =3D vbar_write,
+              .bank_fieldoffsets =3D { offsetof(CPUARMState, cp15.vbar_s=
),
+                                     offsetof(CPUARMState, cp15.vbar_ns)=
 },
+              .resetvalue =3D 0 },
+            REGINFO_SENTINEL
+        };
+        define_arm_cp_regs(cpu, vbar_cp_reginfo);
+    }
+
     /* Generic registers whose values depend on the implementation */
     {
         ARMCPRegInfo sctlr =3D {
--=20
2.7.4
