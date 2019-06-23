Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CABC43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C174A20840
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C174A20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45832 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf637-0007QA-2V
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 13:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34211)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hf5wP-0001g0-4G
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hf5wM-0004M3-RV
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:08 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41131 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hf5wM-0004JQ-Em
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 13:06:06 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id D9DE91A1DBE;
 Sun, 23 Jun 2019 19:05:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 9DBF61A1DBF;
 Sun, 23 Jun 2019 19:05:45 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Sun, 23 Jun 2019 19:04:47 +0200
Message-Id: <1561309489-16146-15-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561309489-16146-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v5 14/16] tcg/ppc: Update vector support to
 v2.06
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: richard.henderson@linaro.org,
 "David Gibson --cc=amarkovic @ wavecomp . com"
 <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This includes double-word loads and stores, double-word load and splat,
double-word permute, and bit select.  All of which require multiple
operations in the base Altivec instruction set.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |  5 +++--
 tcg/ppc/tcg-target.inc.c | 51 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index a130192..40544f9 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -60,6 +60,7 @@ typedef enum {
 
 extern bool have_isa_altivec;
 extern bool have_isa_2_06;
+extern bool have_isa_2_06_vsx;
 extern bool have_isa_3_00;
 
 /* optional instructions automatically implemented */
@@ -141,7 +142,7 @@ extern bool have_isa_3_00;
  * instruction and substituting two 32-bit stores makes the generated
  * code quite large.
  */
-#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v64              have_isa_2_06_vsx
 #define TCG_TARGET_HAS_v128             have_isa_altivec
 #define TCG_TARGET_HAS_v256             0
 
@@ -157,7 +158,7 @@ extern bool have_isa_3_00;
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       have_isa_2_06_vsx
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
 void flush_icache_range(uintptr_t start, uintptr_t stop);
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 61732c1..0c2ad8d 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -66,6 +66,7 @@ static tcg_insn_unit *tb_ret_addr;
 
 bool have_isa_altivec;
 bool have_isa_2_06;
+bool have_isa_2_06_vsx;
 bool have_isa_3_00;
 
 #define HAVE_ISA_2_06  have_isa_2_06
@@ -470,9 +471,12 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define LVEBX      XO31(7)
 #define LVEHX      XO31(39)
 #define LVEWX      XO31(71)
+#define LXSDX      XO31(588)      /* v2.06 */
+#define LXVDSX     XO31(332)      /* v2.06 */
 
 #define STVX       XO31(231)
 #define STVEWX     XO31(199)
+#define STXSDX     XO31(716)      /* v2.06 */
 
 #define VADDSBS    VX4(768)
 #define VADDUBS    VX4(512)
@@ -561,6 +565,9 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 
 #define VSLDOI     VX4(44)
 
+#define XXPERMDI   (OPCD(60) | (10 << 3))   /* v2.06 */
+#define XXSEL      (OPCD(60) | (3 << 4))    /* v2.06 */
+
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
 #define RA(r) ((r)<<16)
@@ -887,11 +894,21 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
         add = 0;
     }
 
-    load_insn = LVX | VRT(ret) | RB(TCG_REG_TMP1);
-    if (TCG_TARGET_REG_BITS == 64) {
-        new_pool_l2(s, rel, s->code_ptr, add, val, val);
+    if (have_isa_2_06_vsx) {
+        load_insn = type == TCG_TYPE_V64 ? LXSDX : LXVDSX;
+        load_insn |= VRT(ret) | RB(TCG_REG_TMP1) | 1;
+        if (TCG_TARGET_REG_BITS == 64) {
+            new_pool_label(s, val, rel, s->code_ptr, add);
+        } else {
+            new_pool_l2(s, rel, s->code_ptr, add, val, val);
+        }
     } else {
-        new_pool_l4(s, rel, s->code_ptr, add, val, val, val, val);
+        load_insn = LVX | VRT(ret) | RB(TCG_REG_TMP1);
+        if (TCG_TARGET_REG_BITS == 64) {
+            new_pool_l2(s, rel, s->code_ptr, add, val, val);
+        } else {
+            new_pool_l4(s, rel, s->code_ptr, add, val, val, val, val);
+        }
     }
 
     if (USE_REG_TB) {
@@ -1138,6 +1155,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
         /* fallthru */
     case TCG_TYPE_V64:
         tcg_debug_assert(ret >= 32);
+        if (have_isa_2_06_vsx) {
+            tcg_out_mem_long(s, 0, LXSDX | 1, ret & 31, base, offset);
+            break;
+        }
         assert((offset & 7) == 0);
         tcg_out_mem_long(s, 0, LVX, ret & 31, base, offset & -16);
         if (offset & 8) {
@@ -1181,6 +1202,10 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         /* fallthru */
     case TCG_TYPE_V64:
         tcg_debug_assert(arg >= 32);
+        if (have_isa_2_06_vsx) {
+            tcg_out_mem_long(s, 0, STXSDX | 1, arg & 31, base, offset);
+            break;
+        }
         assert((offset & 7) == 0);
         if (offset & 8) {
             tcg_out_vsldoi(s, TCG_VEC_TMP1, arg, arg, 8);
@@ -2900,6 +2925,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
         return vece <= MO_32 ? -1 : 0;
+    case INDEX_op_bitsel_vec:
+        return have_isa_2_06_vsx;
     default:
         return 0;
     }
@@ -2926,6 +2953,10 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
         tcg_out32(s, VSPLTW | VRT(dst) | VRB(src) | (1 << 16));
         break;
     case MO_64:
+        if (have_isa_2_06_vsx) {
+            tcg_out32(s, XXPERMDI | 7 | VRT(dst) | VRA(src) | VRB(src));
+            break;
+        }
         tcg_out_vsldoi(s, TCG_VEC_TMP1, src, src, 8);
         tcg_out_vsldoi(s, dst, TCG_VEC_TMP1, src, 8);
         break;
@@ -2970,6 +3001,10 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
         tcg_out32(s, VSPLTW | VRT(out) | VRB(out) | (elt << 16));
         break;
     case MO_64:
+        if (have_isa_2_06_vsx) {
+            tcg_out_mem_long(s, 0, LXVDSX | 1, out, base, offset);
+            break;
+        }
         assert((offset & 7) == 0);
         tcg_out_mem_long(s, 0, LVX, out, base, offset & -16);
         tcg_out_vsldoi(s, TCG_VEC_TMP1, out, out, 8);
@@ -3104,6 +3139,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_bitsel_vec:
+        tcg_out32(s, XXSEL | 0xf | VRT(a0) | VRC(a1) | VRB(a2) | VRA(args[3]));
+        return;
+
     case INDEX_op_dup2_vec:
         assert(TCG_TARGET_REG_BITS == 32);
         /* With inputs a1 = xLxx, a2 = xHxx  */
@@ -3499,6 +3538,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
         return &v_r;
+    case INDEX_op_bitsel_vec:
     case INDEX_op_ppc_msum_vec:
         return &v_v_v_v;
 
@@ -3517,6 +3557,9 @@ static void tcg_target_init(TCGContext *s)
     }
     if (hwcap & PPC_FEATURE_ARCH_2_06) {
         have_isa_2_06 = true;
+        if (hwcap & PPC_FEATURE_HAS_VSX) {
+            have_isa_2_06_vsx = true;
+        }
     }
 #ifdef PPC_FEATURE2_ARCH_3_00
     if (hwcap2 & PPC_FEATURE2_ARCH_3_00) {
-- 
2.7.4


