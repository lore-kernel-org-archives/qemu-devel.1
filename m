Received: from eggs.gnu.org ([2001:4830:134:3::10]:58017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgMe3-0007Zl-Av
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgMe0-0000jn-IR
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:03:55 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:45967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgMe0-0000jc-CH
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 00:03:52 -0400
Received: by mail-pl0-x242.google.com with SMTP id 94-v6so4573334ple.12
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 21:03:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 19 Jul 2018 21:03:37 -0700
Message-Id: <20180720040337.21426-2-richard.henderson@linaro.org>
In-Reply-To: <20180720040337.21426-1-richard.henderson@linaro.org>
References: <20180720040337.21426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-3.0 1/1] tcg/aarch64: limit mul_vec size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

In AdvSIMD we can only do 32x32 integer multiples although SVE is
capable of larger 64 bit multiples. As a result we can end up
generating invalid opcodes. Fix this by only reprting we can emit
mul vector ops if the size is small enough.

Fixes a crash on:

  sve-all-short-v8.3+sve@vq3/insn_mul_z_zi___INC.risu.bin

When running on AArch64 hardware.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20180719154248.29669-1-alex.bennee@linaro.org>
[rth: Removed the tcg_debug_assert -- there are plenty of other
cases that we do not diagnose within the insn encoding helpers.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 4562d36d1b..083592a4d7 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2219,7 +2219,6 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     switch (opc) {
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
-    case INDEX_op_mul_vec:
     case INDEX_op_and_vec:
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
@@ -2232,6 +2231,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
         return 1;
+    case INDEX_op_mul_vec:
+        return vece < MO_64;
 
     default:
         return 0;
-- 
2.17.1
