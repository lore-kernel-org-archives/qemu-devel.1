Return-Path: <SRS0=rHaa=U4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7238CC4321A
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBE6208E3
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2019 13:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8OnKA39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBE6208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhDDr-0004bm-6q
	for qemu-devel@archiver.kernel.org; Sat, 29 Jun 2019 09:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41297)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCyC-0007zV-53
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hhCy8-0003be-GL
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hhCy8-0003Uy-18
 for qemu-devel@nongnu.org; Sat, 29 Jun 2019 09:00:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id r16so7114433wrl.11
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2019 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QAZO41QqU1wEXGsPMCkf/ZSgTgfyO9M/Nk9MvXQm6g4=;
 b=Y8OnKA390xPMrXuhsixn/uuMgc28m3twhWM0blfa5ZXMawwxCn4GIvMb+0M+0Ab3cp
 8FkR90ZQ37KxXfooljtqg9qvZCmbVcllpHhglSipoyfVTd0DGYIx8y/wAd1RREdnbatU
 YTuYhqMNolkB4n0o98+gj+bab0H2XnFOUgZeYKPK4y5OVBdf4yQk8NuTJcnjbmpYfFnF
 3JZfVOc2wgEDV27Zh2RGo/75D9XX1AhjW+0v14E+Rth2nEhspbU0Dg5Gw/xP7knvPoDZ
 kNlzizKlBYHvHpXM600grvqjTQqGQG5CEBiBhgFXcNOgdU/kLjByAAxFPm56rQmWpjGo
 6KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QAZO41QqU1wEXGsPMCkf/ZSgTgfyO9M/Nk9MvXQm6g4=;
 b=X0CAfVjsbLaEWLzuvkFAwRHrGgAIAQorK01S6lwe0QR4lKyovf2ebaHWx2f9LOTp2z
 IFxIks28eBPo3KIM3mbWFpGHbypmeZpf86UiwuCJuZOf+NPQAv36uTBWz6gYEZRyaKCq
 2k7mgIlMumu0v3GMNpwdZIWotdD5PjbaR+cUyTiq5zUcFNQnRMsBzq2g9fLYM6xzGSeE
 QUzxjAMy6AL1AbCqJXrynL2XI+U66kgcEfbZvD/4xqMpajisiGt6yXdiS7B+NXI5TDfv
 2a2M1H6DH1KxUpOhNr9nkGPGUSkDInrx7gL0FiSCsN0Y1NeAT7fNQ0aoRQB3D4hz21Gr
 JIlA==
X-Gm-Message-State: APjAAAXREhh+xA7UWTLQBtC+7J79oB6kFQO2/LJASzUjvpIjswZF0tCS
 m+c4ovSOm2C3Q0V8q6MiGBfiWGA2RmASNg==
X-Google-Smtp-Source: APXvYqy26yqiOwUa28Um/frEUNCP9ISRYL0V7HkSFMLarjQYSiJi2XkjbnR+wGWIbgwgOrpEmBWdig==
X-Received: by 2002:a5d:438f:: with SMTP id i15mr6295751wrq.37.1561813233140; 
 Sat, 29 Jun 2019 06:00:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id d10sm4937676wro.18.2019.06.29.06.00.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 29 Jun 2019 06:00:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 29 Jun 2019 15:00:15 +0200
Message-Id: <20190629130017.2973-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190629130017.2973-1-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v6 14/16] tcg/ppc: Update vector support to
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes double-word loads and stores, double-word load and splat,
double-word permute, and bit select.  All of which require multiple
operations in the base Altivec instruction set.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |  5 ++--
 tcg/ppc/tcg-target.inc.c | 51 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index a130192cbd..40544f996d 100644
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
index c6defd4df7..50d1b5612c 100644
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
@@ -1139,6 +1156,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
         /* fallthru */
     case TCG_TYPE_V64:
         tcg_debug_assert(ret >= TCG_REG_V0);
+        if (have_isa_2_06_vsx) {
+            tcg_out_mem_long(s, 0, LXSDX | 1, ret, base, offset);
+            break;
+        }
         assert((offset & 7) == 0);
         tcg_out_mem_long(s, 0, LVX, ret, base, offset & -16);
         if (offset & 8) {
@@ -1183,6 +1204,10 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         /* fallthru */
     case TCG_TYPE_V64:
         tcg_debug_assert(arg >= TCG_REG_V0);
+        if (have_isa_2_06_vsx) {
+            tcg_out_mem_long(s, 0, STXSDX | 1, arg, base, offset);
+            break;
+        }
         assert((offset & 7) == 0);
         if (offset & 8) {
             tcg_out_vsldoi(s, TCG_VEC_TMP1, arg, arg, 8);
@@ -2902,6 +2927,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
         return vece <= MO_32 ? -1 : 0;
+    case INDEX_op_bitsel_vec:
+        return have_isa_2_06_vsx;
     default:
         return 0;
     }
@@ -2928,6 +2955,10 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
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
@@ -2971,6 +3002,10 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
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
@@ -3105,6 +3140,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_bitsel_vec:
+        tcg_out32(s, XXSEL | 0xf | VRT(a0) | VRC(a1) | VRB(a2) | VRA(args[3]));
+        return;
+
     case INDEX_op_dup2_vec:
         assert(TCG_TARGET_REG_BITS == 32);
         /* With inputs a1 = xLxx, a2 = xHxx  */
@@ -3500,6 +3539,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
         return &v_r;
+    case INDEX_op_bitsel_vec:
     case INDEX_op_ppc_msum_vec:
         return &v_v_v_v;
 
@@ -3518,6 +3558,9 @@ static void tcg_target_init(TCGContext *s)
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
2.17.1


