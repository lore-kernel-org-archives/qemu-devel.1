Received: from eggs.gnu.org ([2001:4830:134:3::10]:47603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nreilly@blackberry.com>) id 1cemna-0003yf-DA
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nreilly@blackberry.com>) id 1cemnX-0003fP-9h
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 12:58:26 -0500
From: Nick Reilly <nreilly@blackberry.com>
Date: Fri, 17 Feb 2017 12:58:04 -0500
Message-Id: <1487354284-7587-1-git-send-email-nreilly@blackberry.com>
Subject: [Qemu-devel] [PATCH] Add missing fp_access_check() to aarch64
 crypto instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, Nick Reilly <nreilly@blackberry.com>

The aarch64 crypto instructions for AES and SHA are missing the
check for if the FPU is enabled.

Signed-off-by: Nick Reilly <nreilly@blackberry.com>
---
 target/arm/translate-a64.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e61bbd6..8105e7e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10929,6 +10929,10 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (!fp_access_check(s)) {
+        return;
+    }
+
     /* Note that we convert the Vx register indexes into the
      * index within the vfp.regs[] array, so we can share the
      * helper with the AArch32 instructions.
@@ -10993,6 +10997,10 @@ static void disas_crypto_three_reg_sha(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (!fp_access_check(s)) {
+        return;
+    }
+
     tcg_rd_regno = tcg_const_i32(rd << 1);
     tcg_rn_regno = tcg_const_i32(rn << 1);
     tcg_rm_regno = tcg_const_i32(rm << 1);
@@ -11056,6 +11064,10 @@ static void disas_crypto_two_reg_sha(DisasContext *s, uint32_t insn)
         return;
     }
 
+    if (!fp_access_check(s)) {
+        return;
+    }
+
     tcg_rd_regno = tcg_const_i32(rd << 1);
     tcg_rn_regno = tcg_const_i32(rn << 1);
 
-- 
1.9.1
