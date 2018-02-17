Received: from eggs.gnu.org ([2001:4830:134:3::10]:46174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en5Xa-0005OO-I2
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 11:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en5XY-0001ji-SD
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 11:40:46 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:37696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en5XY-0001jM-Ju
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 11:40:44 -0500
Received: by mail-pl0-x242.google.com with SMTP id ay8so3358073plb.4
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 08:40:44 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	a6sm29152324pfi.99.2018.02.17.08.40.41 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 08:40:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 08:40:36 -0800
Message-Id: <20180217164037.15727-2-richard.henderson@linaro.org>
In-Reply-To: <20180217164037.15727-1-richard.henderson@linaro.org>
References: <20180217164037.15727-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] tcg: Fold unspecified opcode test into
 tcg_can_emit_vec_op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This releases the callers from having to check themselves,
which tidies up the code a bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c |  4 ++++
 tcg/i386/tcg-target.inc.c    |  4 ++++
 tcg/tcg-op-gvec.c            | 28 ++++++++++++----------------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index be3192078d..9b0a803d79 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2217,6 +2217,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
+    case 0:
+        /* Unspecified opcode */
+        return 1;
+
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_mul_vec:
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index fc05909d1d..45943e540c 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3064,6 +3064,10 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
+    case 0:
+        /* Unspecified opcode.  */
+        return 1;
+
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_and_vec:
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index bfe44bba81..29f9cf34b4 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -878,7 +878,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
        store operation.  This is true for aarch64 and x86_64 hosts.  */
 
     if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))) {
+        && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece)) {
         uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256, g->fniv);
         if (some == oprsz) {
@@ -891,12 +891,11 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     }
 
     if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece)) {
         expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128, g->fniv);
     } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
                && g->fniv && check_size_impl(oprsz, 8)
-               && (!g->opc
-                   || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+               && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece)) {
         expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64, g->fniv);
     } else if (g->fni8 && check_size_impl(oprsz, 8)) {
         expand_2_i64(dofs, aofs, oprsz, g->fni8);
@@ -926,7 +925,7 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
        that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
 
     if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))) {
+        && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece)) {
         uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_2i_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
                       c, g->load_dest, g->fniv);
@@ -940,13 +939,12 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     }
 
     if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece)) {
         expand_2i_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
                       c, g->load_dest, g->fniv);
     } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
                && g->fniv && check_size_impl(oprsz, 8)
-               && (!g->opc
-                   || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+               && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece)) {
         expand_2i_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
                       c, g->load_dest, g->fniv);
     } else if (g->fni8 && check_size_impl(oprsz, 8)) {
@@ -1063,7 +1061,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
        that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
 
     if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))) {
+        && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece)) {
         uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_3_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,
                      g->load_dest, g->fniv);
@@ -1078,13 +1076,12 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     }
 
     if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece)) {
         expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,
                      g->load_dest, g->fniv);
     } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
                && g->fniv && check_size_impl(oprsz, 8)
-               && (!g->opc
-                   || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+               && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece)) {
         expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
                      g->load_dest, g->fniv);
     } else if (g->fni8 && check_size_impl(oprsz, 8)) {
@@ -1114,7 +1111,7 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
        that e.g. oprsz == 80 would be expanded with 2x32 + 1x16.  */
 
     if (TCG_TARGET_HAS_v256 && g->fniv && check_size_impl(oprsz, 32)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece))) {
+        && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V256, g->vece)) {
         uint32_t some = QEMU_ALIGN_DOWN(oprsz, 32);
         expand_4_vec(g->vece, dofs, aofs, bofs, cofs, some,
                      32, TCG_TYPE_V256, g->fniv);
@@ -1130,13 +1127,12 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
     }
 
     if (TCG_TARGET_HAS_v128 && g->fniv && check_size_impl(oprsz, 16)
-        && (!g->opc || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece))) {
+        && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V128, g->vece)) {
         expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,
                      16, TCG_TYPE_V128, g->fniv);
     } else if (TCG_TARGET_HAS_v64 && !g->prefer_i64
                && g->fniv && check_size_impl(oprsz, 8)
-                && (!g->opc
-                    || tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece))) {
+               && tcg_can_emit_vec_op(g->opc, TCG_TYPE_V64, g->vece)) {
         expand_4_vec(g->vece, dofs, aofs, bofs, cofs, oprsz,
                      8, TCG_TYPE_V64, g->fniv);
     } else if (g->fni8 && check_size_impl(oprsz, 8)) {
-- 
2.14.3
