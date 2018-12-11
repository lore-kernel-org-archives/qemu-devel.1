Received: from eggs.gnu.org ([2001:4830:134:3::10]:57341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjpx-00042Q-FB
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gWjpt-0001Vu-EU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:20:41 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Tue, 11 Dec 2018 15:20:24 +0000
Message-ID: <20181211151945.29137-6-aaron@os.amperecomputing.com>
References: <20181211151945.29137-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181211151945.29137-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v10 05/14] target/arm: Allow AArch32 access for
 PMCCFILTR
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

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ddb47813d2..0aff261528 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -994,6 +994,10 @@ static const ARMCPRegInfo v6_cp_reginfo[] =3D {
                                PMXEVTYPER_M | PMXEVTYPER_MT | \
                                PMXEVTYPER_EVTCOUNT)
=20
+#define PMCCFILTR             0xf8000000
+#define PMCCFILTR_M           PMXEVTYPER_M
+#define PMCCFILTR_EL0         (PMCCFILTR | PMCCFILTR_M)
+
 static inline uint32_t pmu_num_counters(CPUARMState *env)
 {
   return (env->cp15.c9_pmcr & PMCRN_MASK) >> PMCRN_SHIFT;
@@ -1297,10 +1301,26 @@ static void pmccfiltr_write(CPUARMState *env, const=
 ARMCPRegInfo *ri,
                             uint64_t value)
 {
     pmccntr_op_start(env);
-    env->cp15.pmccfiltr_el0 =3D value & 0xfc000000;
+    env->cp15.pmccfiltr_el0 =3D value & PMCCFILTR_EL0;
+    pmccntr_op_finish(env);
+}
+
+static void pmccfiltr_write_a32(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    pmccntr_op_start(env);
+    /* M is not accessible from AArch32 */
+    env->cp15.pmccfiltr_el0 =3D (env->cp15.pmccfiltr_el0 & PMCCFILTR_M) |
+        (value & PMCCFILTR);
     pmccntr_op_finish(env);
 }
=20
+static uint64_t pmccfiltr_read_a32(CPUARMState *env, const ARMCPRegInfo *r=
i)
+{
+    /* M is not visible in AArch32 */
+    return env->cp15.pmccfiltr_el0 & PMCCFILTR;
+}
+
 static void pmcntenset_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -1536,6 +1556,11 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
       .readfn =3D pmccntr_read, .writefn =3D pmccntr_write,
       .raw_readfn =3D raw_read, .raw_writefn =3D raw_write, },
 #endif
+    { .name =3D "PMCCFILTR", .cp =3D 15, .opc1 =3D 0, .crn =3D 14, .crm =
=3D 15, .opc2 =3D 7,
+      .writefn =3D pmccfiltr_write_a32, .readfn =3D pmccfiltr_read_a32,
+      .access =3D PL0_RW, .accessfn =3D pmreg_access,
+      .type =3D ARM_CP_ALIAS | ARM_CP_IO,
+      .resetvalue =3D 0, },
     { .name =3D "PMCCFILTR_EL0", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 15, .opc2 =3D 7,
       .writefn =3D pmccfiltr_write, .raw_writefn =3D raw_write,
--=20
2.19.2
