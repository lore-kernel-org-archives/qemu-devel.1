Received: from eggs.gnu.org ([2001:4830:134:3::10]:56029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPU-0003nS-0x
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eqgPT-00085V-4t
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:16 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eqgPS-00084v-P3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:39:15 -0500
Received: by mail-wr0-x242.google.com with SMTP id n7so25120784wrn.5
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:39:14 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 27 Feb 2018 14:38:49 +0000
Message-Id: <20180227143852.11175-29-alex.bennee@linaro.org>
In-Reply-To: <20180227143852.11175-1-alex.bennee@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 28/31] arm/translate-a64: add FP16 FMOV to
 simd_mod_imm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Only one half-precision instruction has been added to this group.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2
  - checkpatch fixes
v3
  - use vfp_expand_imm
---
 target/arm/translate-a64.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 86231b33bb..7c2bc05b92 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6234,6 +6234,8 @@ static void disas_simd_copy(DisasContext *s, uint32_t insn)
  *   MVNI - move inverted (shifted) imm into register
  *   ORR  - bitwise OR of (shifted) imm with register
  *   BIC  - bitwise clear of (shifted) imm with register
+ * With ARMv8.2 we also have:
+ *   FMOV half-precision
  */
 static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
 {
@@ -6248,8 +6250,11 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
     uint64_t imm = 0;
 
     if (o2 != 0 || ((cmode == 0xf) && is_neg && !is_q)) {
-        unallocated_encoding(s);
-        return;
+        /* Check for FMOV (vector, immediate) - half-precision */
+        if (!(arm_dc_feature(s, ARM_FEATURE_V8_FP16) && o2 && cmode == 0xf)) {
+            unallocated_encoding(s);
+            return;
+        }
     }
 
     if (!fp_access_check(s)) {
@@ -6307,19 +6312,29 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
                     imm |= 0x4000000000000000ULL;
                 }
             } else {
-                imm = (abcdefgh & 0x3f) << 19;
-                if (abcdefgh & 0x80) {
-                    imm |= 0x80000000;
-                }
-                if (abcdefgh & 0x40) {
-                    imm |= 0x3e000000;
+                if (o2) {
+                    /* FMOV (vector, immediate) - half-precision */
+                    imm = vfp_expand_imm(MO_16, abcdefgh);
+                    /* now duplicate across the lanes */
+                    imm = bitfield_replicate(imm, 16);
                 } else {
-                    imm |= 0x40000000;
+                    imm = (abcdefgh & 0x3f) << 19;
+                    if (abcdefgh & 0x80) {
+                        imm |= 0x80000000;
+                    }
+                    if (abcdefgh & 0x40) {
+                        imm |= 0x3e000000;
+                    } else {
+                        imm |= 0x40000000;
+                    }
+                    imm |= (imm << 32);
                 }
-                imm |= (imm << 32);
             }
         }
         break;
+    default:
+        fprintf(stderr, "%s: cmode_3_1: %x\n", __func__, cmode_3_1);
+        g_assert_not_reached();
     }
 
     if (cmode_3_1 != 7 && is_neg) {
-- 
2.15.1
