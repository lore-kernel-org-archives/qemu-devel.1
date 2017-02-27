Received: from eggs.gnu.org ([2001:4830:134:3::10]:52140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfi-0002PK-Ll
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfg-0001w6-GL
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ciPfg-0001qs-6u
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:05:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ciPfU-0002L8-FE
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:05:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 18:04:37 +0000
Message-Id: <1488218699-31035-9-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 08/30] Add missing fp_access_check() to aarch64
 crypto instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Nick Reilly <nreilly@blackberry.com>

The aarch64 crypto instructions for AES and SHA are missing the
check for if the FPU is enabled.

Signed-off-by: Nick Reilly <nreilly@blackberry.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e15eae6..24de30d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10933,6 +10933,10 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (!fp_access_check(s)) {
+        return;
+    }
+
     /* Note that we convert the Vx register indexes into the
      * index within the vfp.regs[] array, so we can share the
      * helper with the AArch32 instructions.
@@ -10997,6 +11001,10 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (!fp_access_check(s)) {
+        return;
+    }
+
     tcg_rd_regno = tcg_const_i32(rd << 1);
     tcg_rn_regno = tcg_const_i32(rn << 1);
     tcg_rm_regno = tcg_const_i32(rm << 1);
@@ -11060,6 +11068,10 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (!fp_access_check(s)) {
+        return;
+    }
+
     tcg_rd_regno = tcg_const_i32(rd << 1);
     tcg_rn_regno = tcg_const_i32(rn << 1);
 
-- 
2.7.4
