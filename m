Received: from eggs.gnu.org ([2001:4830:134:3::10]:41541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUs-0000q0-B6
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUr-0006Tm-Cz
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUr-0006Oj-5q
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:09 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUn-0002rg-3m
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:41 +0100
Message-Id: <20180531142357.904-10-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/25] Correct CPACR reset value for v7 cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In commit f0aff255700 we made cpacr_write() enforce that some CPACR
bits are RAZ/WI and some are RAO/WI for ARMv7 cores. Unfortunately
we forgot to also update the register's reset value. The effect
was that (a) a guest that read CPACR on reset would not see ones in
the RAO bits, and (b) if you did a migration before the guest did
a write to the CPACR then the migration would fail because the
destination would enforce the RAO bits and then complain that they
didn't match the zero value from the source.

Implement reset for the CPACR using a custom reset function
that just calls cpacr_write(), to avoid having to duplicate
the logic for which bits are RAO.

This bug would affect migration for TCG CPUs which are ARMv7
with VFP but without one of Neon or VFPv3.

Reported-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180522173713.26282-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a4bfac3932..f75aa6e9ca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -863,6 +863,14 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->cp15.cpacr_el1 = value;
 }
 
+static void cpacr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* Call cpacr_write() so that we reset with the correct RAO bits set
+     * for our CPU features.
+     */
+    cpacr_write(env, ri, 0);
+}
+
 static CPAccessResult cpacr_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
 {
@@ -920,7 +928,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
     { .name = "CPACR", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
       .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 2, .accessfn = cpacr_access,
       .access = PL1_RW, .fieldoffset = offsetof(CPUARMState, cp15.cpacr_el1),
-      .resetvalue = 0, .writefn = cpacr_write },
+      .resetfn = cpacr_reset, .writefn = cpacr_write },
     REGINFO_SENTINEL
 };
 
-- 
2.17.1
