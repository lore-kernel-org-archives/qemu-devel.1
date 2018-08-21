Received: from eggs.gnu.org ([2001:4830:134:3::10]:53713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6Nx-0001FK-0I
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs6Nn-0008Pb-63
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35474 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs6Nm-0008Mg-Jq
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 09:07:38 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 15:07:03 +0200
Message-Id: <1534856848-12102-22-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534856848-12102-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534856848-12102-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 21/46] target/mips: Implement emulation of
 nanoMIPS ROTX instruction
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

From: Matthew Fortune <matthew.fortune@mips.com>

Added a helper for ROTX based on the pseudocode from the
architecture spec. This instraction was not present in previous
MIPS instruction sets.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/helper.h    |  2 ++
 target/mips/op_helper.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/mips/translate.c | 15 ++++++++
 3 files changed, 111 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 5f49234..b2a780a 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -40,6 +40,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 #endif
 
+DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
+
 #ifndef CONFIG_USER_ONLY
 /* CP0 helpers */
 DEF_HELPER_1(mfc0_mvpcontrol, tl, env)
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 0b2663b..b3eef9f 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -249,6 +249,100 @@ target_ulong helper_bitswap(target_ulong rt)
     return (int32_t)bitswap(rt);
 }
 
+target_ulong helper_rotx(target_ulong rs, uint32_t shift, uint32_t shiftx,
+                        uint32_t stripe)
+{
+    int i;
+    uint64_t tmp0 = ((uint64_t)rs) << 32 | ((uint64_t)rs & 0xffffffff);
+    uint64_t tmp1 = tmp0;
+    for (i = 0; i <= 46; i++) {
+        int s;
+        if (i & 0x8) {
+            s = shift;
+        } else {
+            s = shiftx;
+        }
+
+        if (stripe != 0 && !(i & 0x4)) {
+            s = ~s;
+        }
+        if (s & 0x10) {
+            if (tmp0 & (1LL << (i + 16))) {
+                tmp1 |= 1LL << i;
+            } else {
+                tmp1 &= ~(1LL << i);
+            }
+        }
+    }
+
+    uint64_t tmp2 = tmp1;
+    for (i = 0; i <= 38; i++) {
+        int s;
+        if (i & 0x4) {
+            s = shift;
+        } else {
+            s = shiftx;
+        }
+
+        if (s & 0x8) {
+            if (tmp1 & (1LL << (i + 8))) {
+                tmp2 |= 1LL << i;
+            } else {
+                tmp2 &= ~(1LL << i);
+            }
+        }
+    }
+
+    uint64_t tmp3 = tmp2;
+    for (i = 0; i <= 34; i++) {
+        int s;
+        if (i & 0x2) {
+            s = shift;
+        } else {
+            s = shiftx;
+        }
+        if (s & 0x4) {
+            if (tmp2 & (1LL << (i + 4))) {
+                tmp3 |= 1LL << i;
+            } else {
+                tmp3 &= ~(1LL << i);
+            }
+        }
+    }
+
+    uint64_t tmp4 = tmp3;
+    for (i = 0; i <= 32; i++) {
+        int s;
+        if (i & 0x1) {
+            s = shift;
+        } else {
+            s = shiftx;
+        }
+        if (s & 0x2) {
+            if (tmp3 & (1LL << (i + 2))) {
+                tmp4 |= 1LL << i;
+            } else {
+                tmp4 &= ~(1LL << i);
+            }
+        }
+    }
+
+    uint64_t tmp5 = tmp4;
+    for (i = 0; i <= 31; i++) {
+        int s;
+        s = shift;
+        if (s & 0x1) {
+            if (tmp4 & (1LL << (i + 1))) {
+                tmp5 |= 1LL << i;
+            } else {
+                tmp5 &= ~(1LL << i);
+            }
+        }
+    }
+
+    return (int64_t)(int32_t)(uint32_t)tmp5;
+}
+
 #ifndef CONFIG_USER_ONLY
 
 static inline hwaddr do_translate_address(CPUMIPSState *env,
diff --git a/target/mips/translate.c b/target/mips/translate.c
index b00d28b..7b2ffb2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17811,6 +17811,21 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             }
             break;
         case NM_P_ROTX:
+            if (rt != 0) {
+                TCGv t0 = tcg_temp_new();
+                TCGv_i32 shift = tcg_const_i32(extract32(ctx->opcode, 0, 5));
+                TCGv_i32 shiftx = tcg_const_i32(extract32(ctx->opcode, 7, 4)
+                                                << 1);
+                TCGv_i32 stripe = tcg_const_i32(extract32(ctx->opcode, 6, 1));
+
+                gen_load_gpr(t0, rs);
+                gen_helper_rotx(cpu_gpr[rt], t0, shift, shiftx, stripe);
+                tcg_temp_free(t0);
+
+                tcg_temp_free_i32(shift);
+                tcg_temp_free_i32(shiftx);
+                tcg_temp_free_i32(stripe);
+            }
             break;
         case NM_P_INS:
             switch (((ctx->opcode >> 10) & 2) |
-- 
2.7.4
