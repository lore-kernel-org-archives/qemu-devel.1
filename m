Received: from eggs.gnu.org ([2001:4830:134:3::10]:45208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwq-0006sT-Ca
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwn-00066c-2C
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:44 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwm-0005lJ-Lv
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:40 -0400
Received: by mail-pl1-x643.google.com with SMTP id p25-v6so4780510pli.11
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:52:05 -0700
Message-Id: <20181011205206.3552-20-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 19/20] target/arm: Promote consecutive memory
 ops for aa32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

For a sequence of loads or stores from a single register,
little-endian operations can be promoted to an 8-byte op.
This can reduce the number of operations by a factor of 8.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 12a744b3c3..09f2d648b7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5011,6 +5011,16 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
         if (size == 3 && (interleave | spacing) != 1) {
             return 1;
         }
+        /* For our purposes, bytes are always little-endian.  */
+        if (size == 0) {
+            endian = MO_LE;
+        }
+        /* Consecutive little-endian elements from a single register
+         * can be promoted to a larger little-endian operation.
+         */
+        if (interleave == 1 && endian == MO_LE) {
+            size = 3;
+        }
         tmp64 = tcg_temp_new_i64();
         addr = tcg_temp_new_i32();
         tmp2 = tcg_const_i32(1 << size);
-- 
2.17.1
