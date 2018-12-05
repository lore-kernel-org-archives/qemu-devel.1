Received: from eggs.gnu.org ([2001:4830:134:3::10]:51869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXTE-0008A7-Ux
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gUXTD-0005eZ-NS
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:44:08 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Wed, 5 Dec 2018 13:43:27 +0000
Message-ID: <20181205134243.4791-13-aaron@os.amperecomputing.com>
References: <20181205134243.4791-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181205134243.4791-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v9 12/14] target/arm: PMU: Set PMCR.N to 4
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

This both advertises that we support four counters and enables them
because the pmu_num_counters() reads this value from PMCR.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a45ab5d9da..724c2f1d69 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1768,7 +1768,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
       .access =3D PL1_W, .type =3D ARM_CP_NOP },
     /* Performance monitors are implementation defined in v7,
      * but with an ARM recommended set of registers, which we
-     * follow (although we don't actually implement any counters)
+     * follow.
      *
      * Performance registers fall into three categories:
      *  (a) always UNDEF in PL0, RW in PL1 (PMINTENSET, PMINTENCLR)
@@ -5502,10 +5502,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
     if (arm_feature(env, ARM_FEATURE_V7)) {
         /* v7 performance monitor control register: same implementor
-         * field as main ID register, and we implement only the cycle
-         * count register.
+         * field as main ID register, and we implement four counters in
+         * addition to the cycle count register.
          */
-        unsigned int i, pmcrn =3D 0;
+        unsigned int i, pmcrn =3D 4;
         ARMCPRegInfo pmcr =3D {
             .name =3D "PMCR", .cp =3D 15, .crn =3D 9, .crm =3D 12, .opc1 =
=3D 0, .opc2 =3D 0,
             .access =3D PL0_RW,
@@ -5520,7 +5520,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .access =3D PL0_RW, .accessfn =3D pmreg_access,
             .type =3D ARM_CP_IO,
             .fieldoffset =3D offsetof(CPUARMState, cp15.c9_pmcr),
-            .resetvalue =3D cpu->midr & 0xff000000,
+            .resetvalue =3D (cpu->midr & 0xff000000) | (pmcrn << PMCRN_SHI=
FT),
             .writefn =3D pmcr_write, .raw_writefn =3D raw_write,
         };
         define_one_arm_cp_reg(cpu, &pmcr);
--=20
2.19.1
