Received: from eggs.gnu.org ([2001:4830:134:3::10]:57339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjpx-00042K-CU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjpw-0001Xp-Jh
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:20:41 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Tue, 11 Dec 2018 15:20:29 +0000
Message-ID: <20181211151945.29137-7-aaron@os.amperecomputing.com>
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181211151945.29137-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v10 06/14] target/arm: Implement PMOVSSET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aaron@os.amperecomputing.com>, Aaron Lindsay <alindsay@codeaurora.org>

Add an array for PMOVSSET so we only define it for v7ve+ platforms

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0aff261528..71be6fb578 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1342,6 +1342,13 @@ static void pmovsr_write(CPUARMState *env, const ARM=
CPRegInfo *ri,
     env->cp15.c9_pmovsr &=3D ~value;
 }
=20
+static void pmovsset_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                         uint64_t value)
+{
+    value &=3D pmu_counter_mask(env);
+    env->cp15.c9_pmovsr |=3D value;
+}
+
 static void pmxevtyper_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
@@ -1709,6 +1716,24 @@ static const ARMCPRegInfo v7mp_cp_reginfo[] =3D {
     REGINFO_SENTINEL
 };
=20
+static const ARMCPRegInfo pmovsset_cp_reginfo[] =3D {
+    /* PMOVSSET is not implemented in v7 before v7ve */
+    { .name =3D "PMOVSSET", .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D =
14, .opc2 =3D 3,
+      .access =3D PL0_RW, .accessfn =3D pmreg_access,
+      .type =3D ARM_CP_ALIAS,
+      .fieldoffset =3D offsetoflow32(CPUARMState, cp15.c9_pmovsr),
+      .writefn =3D pmovsset_write,
+      .raw_writefn =3D raw_write },
+    { .name =3D "PMOVSSET_EL0", .state =3D ARM_CP_STATE_AA64,
+      .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 14, .opc2 =3D 3,
+      .access =3D PL0_RW, .accessfn =3D pmreg_access,
+      .type =3D ARM_CP_ALIAS,
+      .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmovsr),
+      .writefn =3D pmovsset_write,
+      .raw_writefn =3D raw_write },
+    REGINFO_SENTINEL
+};
+
 static void teecr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -5191,6 +5216,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         !arm_feature(env, ARM_FEATURE_PMSA)) {
         define_arm_cp_regs(cpu, v7mp_cp_reginfo);
     }
+    if (arm_feature(env, ARM_FEATURE_V7VE)) {
+        define_arm_cp_regs(cpu, pmovsset_cp_reginfo);
+    }
     if (arm_feature(env, ARM_FEATURE_V7)) {
         /* v7 performance monitor control register: same implementor
          * field as main ID register, and we implement only the cycle
--=20
2.19.2
