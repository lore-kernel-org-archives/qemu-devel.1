Received: from eggs.gnu.org ([208.118.235.92]:52240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8ax-000542-60
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8V3-00065H-7Q
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57262 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8V2-000649-DH
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:57:40 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:54:48 +0200
Message-Id: <1532004912-13899-17-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 16/40] target/mips: Implement emulation of
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Matthew Fortune <matthew.fortune@mips.com>

Added a helper for ROTX based on the pseudocode from the
architecture spec. This instraction was not present in previous
MIPS instruction sets.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
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
index f3753bb..3cff488 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17578,6 +17578,21 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             }
             break;
         case NM_P_ROTX:
+            if (rt != 0) {
+                TCGv t0 = tcg_temp_new();
+                TCGv_i32 shift = tcg_const_i32(extract32(ctx->opcode, 0, 5));
+                TCGv_i32 shiftx = tcg_const_i32(extract32(ctx->opcode, 7, 4)
+                                                << 1);
+                TCGv_i32 stripe = tcg_const_i32((ctx->opcode >> 6) & 1);
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
             switch (((ctx->opcode >> 10) & 2) | ((ctx->opcode >> 5) & 1)) {
-- 
2.7.4
