Received: from eggs.gnu.org ([209.51.188.92]:47634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpC3d-0006Bj-OY
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpC3c-00082j-RA
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:07:05 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpC3c-00082D-L4
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:07:04 -0500
Received: by mail-wm1-x344.google.com with SMTP id m22so2488677wml.3
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 05:07:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 13:07:00 +0000
Message-Id: <20190131130700.28392-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/arm: Make FPSCR/FPCR trapped-exception
 bits RAZ/WI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Martin Husemann <martin@netbsd.org>

The {IOE, DZE, OFE, UFE, IXE, IDE} bits in the FPSCR/FPCR are for
enabling trapped IEEE floating point exceptions (where IEEE exception
conditions cause a CPU exception rather than updating the FPSR status
bits). QEMU doesn't implement this (and nor does the hardware we're
modelling), but for implementations which don't implement trapped
exception handling these control bits are supposed to be RAZ/WI.
This allows guest code to test for whether the feature is present
by trying to write to the bit and checking whether it sticks.

QEMU is incorrectly making these bits read as written. Make them
RAZ/WI as the architecture requires.

In particular this was causing problems for the NetBSD automatic
test suite.

Reported-by: Martin Husemann <martin@netbsd.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Martin: this is a different fix to the one I suggested you test,
because I realized we need to make these bits RAZ/WI in the aarch32
FPSCR as well as the aarch64 FPCR, but it should have the same effect.

General note: the difference between "RAZ/WI" and "RES0" is a bit
subtle (see the Arm ARM glossary), but the main distinction is that
RES0 bits can often be implemented as reads-as-written whilst
RAZ/WI bits never can.
---
 target/arm/cpu.h    | 6 ++++++
 target/arm/helper.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b8161cb6d73..15e1464460f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1404,6 +1404,12 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPSR_MASK 0xf800009f
 #define FPCR_MASK 0x07ff9f00
 
+#define FPCR_IOE    (1 << 8)    /* Invalid Operation exception trap enable */
+#define FPCR_DZE    (1 << 9)    /* Divide by Zero exception trap enable */
+#define FPCR_OFE    (1 << 10)   /* Overflow exception trap enable */
+#define FPCR_UFE    (1 << 11)   /* Underflow exception trap enable */
+#define FPCR_IXE    (1 << 12)   /* Inexact exception trap enable */
+#define FPCR_IDE    (1 << 15)   /* Input Denormal exception trap enable */
 #define FPCR_FZ16   (1 << 19)   /* ARMv8.2+, FP16 flush-to-zero */
 #define FPCR_FZ     (1 << 24)   /* Flush-to-zero enable bit */
 #define FPCR_DN     (1 << 25)   /* Default NaN enable bit */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 66faebea8ec..c5f10ddbe92 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12508,6 +12508,12 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
         val &= ~FPCR_FZ16;
     }
 
+    /*
+     * We don't implement trapped exception handling, so the
+     * trap enable bits are all RAZ/WI (not RES0!)
+     */
+    val &= ~(FPCR_IDE | FPCR_IXE | FPCR_UFE | FPCR_OFE | FPCR_DZE | FPCR_IOE);
+
     changed = env->vfp.xregs[ARM_VFP_FPSCR];
     env->vfp.xregs[ARM_VFP_FPSCR] = (val & 0xffc8ffff);
     env->vfp.vec_len = (val >> 16) & 7;
-- 
2.20.1
