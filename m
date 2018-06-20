Received: from eggs.gnu.org ([2001:4830:134:3::10]:36075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbyL-00073v-9z
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbyH-0006UG-Ve
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:25 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:35269)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVbyH-0006Pn-Lq
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:21 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:06 +0100
Message-ID: <20180620120620.12806-22-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 21/35] target/mips: Add nanoMIPS rotx
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Matthew Fortune <matthew.fortune@imgtec.com>

Added a helper for rotx based on the pseudocode from the
arch spec.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/helper.h    |  2 ++
 target/mips/op_helper.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 target/mips/translate.c | 15 ++++++++
 3 files changed, 111 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index b239adc..deca307 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -42,6 +42,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 #endif
 
+DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
+
 #ifndef CONFIG_USER_ONLY
 /* CP0 helpers */
 DEF_HELPER_1(mfc0_mvpcontrol, tl, env)
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index c9a111c..102a039 100644
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
index 6237f97..9e29dd7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17581,6 +17581,21 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
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
1.9.1
