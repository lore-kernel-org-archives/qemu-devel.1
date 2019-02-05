Received: from eggs.gnu.org ([209.51.188.92]:36055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AV-0001v4-2k
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AS-0000ao-Hn
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:54 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AS-0000Vo-4C
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:52 -0500
Received: by mail-wr1-x430.google.com with SMTP id t27so4457572wra.6
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.43
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:05:10 +0000
Message-Id: <20190205170510.21984-23-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/22] target/arm: Make FPSCR/FPCR
 trapped-exception bits RAZ/WI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190131130700.28392-1-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 6 ++++++
 target/arm/helper.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ec14d3e228d..47238e42458 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1418,6 +1418,12 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
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
index aaf5b0cd7ab..520ceea7a41 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12637,6 +12637,12 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
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
