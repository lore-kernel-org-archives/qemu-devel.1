Received: from eggs.gnu.org ([2001:4830:134:3::10]:53542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0V-0004Sx-N9
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0U-0007tz-8k
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:51 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0U-0007sb-10
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:50 -0400
Received: by mail-wr0-x230.google.com with SMTP id k71so18508166wrc.2
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:16 +0100
Message-Id: <20170720150426.12393-14-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 13/23] target/arm/translate-a64.c:
 add FP16 FADD to AdvSIMD 3 Same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper-a64.h    | 1 +
 target/arm/translate-a64.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 48b400ca8e..f4992e7b36 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -47,3 +47,4 @@ DEF_HELPER_FLAGS_4(paired_cmpxchg64_be, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 
 /* helper_advsimd.c */
 DEF_HELPER_3(advsimd_acgt_f16, i32, i32, i32, ptr)
+DEF_HELPER_3(advsimd_addh, f32, f32, f32, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 06da8408f6..f6aca395bd 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9764,6 +9764,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
 
         switch (fpopcode) {
+        case 0x2: /* FADD */
+            gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         case 0x35: /* FACGT */
             gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
             break;
-- 
2.13.0
