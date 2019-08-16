Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBCAC3A59E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BA721726
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alpbskrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BA721726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycDg-0003kU-Ml
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6u-0003Qa-FM
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6s-0005Xg-Mr
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:40449)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6q-0005Sb-LB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id v19so4057903wmj.5
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OkO0WX+Yks9fNXG6VzX2xd8OuM7EspjpvGVsxonv0p4=;
 b=alpbskrwMUkQh4Z69h3+XulP0J3pQsaz1eLbpUce47BCmHqI/PCZQf56s82Qj7U2Id
 NyMHXibdiML00bH5vaEhjZXJ2H3cH0uDEy2Rz6mYjTc6D5eY9NAYaXwtDuqURSA2OoON
 4MZ7Q6s6FircIl7EhcbEh5CmZDH9EIn8LuMo41fgqEjlTEj0wuelg7b4Fj3bL4W8IRBE
 fMbUflCTDJs/YOpxCX2XeWuVw1P3+xHCprQweCZgwSxkk3lgF25Pc2/2lGxA+TXnge10
 BUC/u0ehxKZGPIr7OMTvMtReDm79mADJECAqKXIYy1qY/i+ALKgepJuHF8JXuD1aC+Ab
 JzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OkO0WX+Yks9fNXG6VzX2xd8OuM7EspjpvGVsxonv0p4=;
 b=JiPujrmZmNEhmDFOeMTC8tEJ1l1KWgK6aQfkFXz4+zkWapaef8lMBZAj4SrLktD4Av
 260Z8ckoiYWROggll743GVa2sZ0LfTnzyb9KwmCIE5wM1FiMlwKwSah56wRaSASWuPdF
 9WioA9+guEz636oP2bpiHe2TYd2MY0w4FoWEUaCjBrJOH08FFwb2y/3wl4/OBzuG79wB
 N2d/vAJ23I5zU5taAYcrvLBd1Dzk+5X+9qMp2daen50dtk6Loz//mpoA3UV9Ih0CBwLW
 +6+PIGDJxOyXEik1nRqr65AWwphrdA1SzoUB2t//QTbJyyFXmnQRo4W0237+Vev3f2tI
 T5qQ==
X-Gm-Message-State: APjAAAUONzZF28fZotfo890/qcfycUDQGpBmxUNQgPTvFd1+yfq9KumG
 z3khbDkUEDDQef3Dew056UdW1FrOzuJ6VQ==
X-Google-Smtp-Source: APXvYqxBD1BdrYpbSJ1uyGi3XzeX43rXqy8prh8ceOSe32wF0oXFA/NtKacsVItHY7jIDm63JEVZ0w==
X-Received: by 2002:a1c:1d86:: with SMTP id d128mr6898093wmd.123.1565961453871; 
 Fri, 16 Aug 2019 06:17:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:02 +0100
Message-Id: <20190816131719.28244-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 12/29] target/arm: Replace offset with pc in
 gen_exception_insn
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The offset is variable depending on the instruction set, whereas
we have stored values for the current pc and the next pc.  Passing
in the actual value is clearer in intent.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190807045335.1361-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c     | 25 ++++++++++++++-----------
 target/arm/translate-vfp.inc.c |  6 +++---
 target/arm/translate.c         | 31 ++++++++++++++++---------------
 3 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index bc89f2c8317..70caf3becb1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -260,10 +260,10 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_insn(DisasContext *s, int offset, int excp,
+static void gen_exception_insn(DisasContext *s, uint64_t pc, int excp,
                                uint32_t syndrome, uint32_t target_el)
 {
-    gen_a64_set_pc_im(s->base.pc_next - offset);
+    gen_a64_set_pc_im(pc);
     gen_exception(excp, syndrome, target_el);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -342,7 +342,7 @@ static inline void gen_goto_tb(DisasContext *s, int n, uint64_t dest)
 void unallocated_encoding(DisasContext *s)
 {
     /* Unallocated and reserved encodings are uncategorized */
-    gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
@@ -1114,8 +1114,8 @@ static inline bool fp_access_check(DisasContext *s)
         return true;
     }
 
-    gen_exception_insn(s, 4, EXCP_UDEF, syn_fp_access_trap(1, 0xe, false),
-                       s->fp_excp_el);
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                       syn_fp_access_trap(1, 0xe, false), s->fp_excp_el);
     return false;
 }
 
@@ -1125,7 +1125,7 @@ static inline bool fp_access_check(DisasContext *s)
 bool sve_access_check(DisasContext *s)
 {
     if (s->sve_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_sve_access_trap(),
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_sve_access_trap(),
                            s->sve_excp_el);
         return false;
     }
@@ -1859,8 +1859,8 @@ static void disas_exc(DisasContext *s, uint32_t insn)
         switch (op2_ll) {
         case 1:                                                     /* SVC */
             gen_ss_advance(s);
-            gen_exception_insn(s, 0, EXCP_SWI, syn_aa64_svc(imm16),
-                               default_exception_el(s));
+            gen_exception_insn(s, s->base.pc_next, EXCP_SWI,
+                               syn_aa64_svc(imm16), default_exception_el(s));
             break;
         case 2:                                                     /* HVC */
             if (s->current_el == 0) {
@@ -1873,7 +1873,8 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             gen_a64_set_pc_im(s->pc_curr);
             gen_helper_pre_hvc(cpu_env);
             gen_ss_advance(s);
-            gen_exception_insn(s, 0, EXCP_HVC, syn_aa64_hvc(imm16), 2);
+            gen_exception_insn(s, s->base.pc_next, EXCP_HVC,
+                               syn_aa64_hvc(imm16), 2);
             break;
         case 3:                                                     /* SMC */
             if (s->current_el == 0) {
@@ -1885,7 +1886,8 @@ static void disas_exc(DisasContext *s, uint32_t insn)
             gen_helper_pre_smc(cpu_env, tmp);
             tcg_temp_free_i32(tmp);
             gen_ss_advance(s);
-            gen_exception_insn(s, 0, EXCP_SMC, syn_aa64_smc(imm16), 3);
+            gen_exception_insn(s, s->base.pc_next, EXCP_SMC,
+                               syn_aa64_smc(imm16), 3);
             break;
         default:
             unallocated_encoding(s);
@@ -14064,7 +14066,8 @@ static void disas_a64_insn(CPUARMState *env, DisasContext *s)
             if (s->btype != 0
                 && s->guarded_page
                 && !btype_destination_ok(insn, s->bt, s->btype)) {
-                gen_exception_insn(s, 4, EXCP_UDEF, syn_btitrap(s->btype),
+                gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                                   syn_btitrap(s->btype),
                                    default_exception_el(s));
                 return;
             }
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 262d4177e50..5065d4524cd 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -96,10 +96,10 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 {
     if (s->fp_excp_el) {
         if (arm_dc_feature(s, ARM_FEATURE_M)) {
-            gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
+            gen_exception_insn(s, s->pc_curr, EXCP_NOCP, syn_uncategorized(),
                                s->fp_excp_el);
         } else {
-            gen_exception_insn(s, 4, EXCP_UDEF,
+            gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
                                syn_fp_access_trap(1, 0xe, false),
                                s->fp_excp_el);
         }
@@ -108,7 +108,7 @@ static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 
     if (!s->vfp_enabled && !ignore_vfp_enabled) {
         assert(!arm_dc_feature(s, ARM_FEATURE_M));
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                            default_exception_el(s));
         return false;
     }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 14572b8501b..60f1b3998a1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1249,11 +1249,11 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
     s->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_exception_insn(DisasContext *s, int offset, int excp,
+static void gen_exception_insn(DisasContext *s, uint32_t pc, int excp,
                                int syn, uint32_t target_el)
 {
     gen_set_condexec(s);
-    gen_set_pc_im(s, s->base.pc_next - offset);
+    gen_set_pc_im(s, pc);
     gen_exception(excp, syn, target_el);
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -1300,7 +1300,7 @@ static inline void gen_hlt(DisasContext *s, int imm)
         return;
     }
 
-    gen_exception_insn(s, s->thumb ? 2 : 4, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
@@ -3177,7 +3177,8 @@ static bool msr_banked_access_decode(DisasContext *s, int r, int sysm, int rn,
 
 undef:
     /* If we get here then some access check did not pass */
-    gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(), exc_target);
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                       syn_uncategorized(), exc_target);
     return false;
 }
 
@@ -3571,7 +3572,7 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
      */
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -4842,7 +4843,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
      */
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -6970,7 +6971,7 @@ static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
     }
 
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -7093,7 +7094,7 @@ static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
         off_rm = vfp_reg_offset(0, rm);
     }
     if (s->fp_excp_el) {
-        gen_exception_insn(s, 4, EXCP_UDEF,
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
                            syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
         return 0;
     }
@@ -7586,7 +7587,7 @@ static void gen_srs(DisasContext *s,
      * For the UNPREDICTABLE cases we choose to UNDEF.
      */
     if (s->current_el == 1 && !s->ns && mode == ARM_CPU_MODE_MON) {
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(), 3);
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(), 3);
         return;
     }
 
@@ -7622,7 +7623,7 @@ static void gen_srs(DisasContext *s,
     }
 
     if (undef) {
-        gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                            default_exception_el(s));
         return;
     }
@@ -7713,7 +7714,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
      * UsageFault exception.
      */
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
-        gen_exception_insn(s, 4, EXCP_INVSTATE, syn_uncategorized(),
+        gen_exception_insn(s, s->pc_curr, EXCP_INVSTATE, syn_uncategorized(),
                            default_exception_el(s));
         return;
     }
@@ -9250,7 +9251,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             break;
         default:
         illegal_op:
-            gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+            gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                                default_exception_el(s));
             break;
         }
@@ -10275,7 +10276,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
 
             /* All other insns: NOCP */
-            gen_exception_insn(s, 4, EXCP_NOCP, syn_uncategorized(),
+            gen_exception_insn(s, s->pc_curr, EXCP_NOCP, syn_uncategorized(),
                                default_exception_el(s));
             break;
         }
@@ -10939,7 +10940,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     return;
 illegal_op:
-    gen_exception_insn(s, 4, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
@@ -11763,7 +11764,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     return;
 illegal_op:
 undef:
-    gen_exception_insn(s, 2, EXCP_UDEF, syn_uncategorized(),
+    gen_exception_insn(s, s->pc_curr, EXCP_UDEF, syn_uncategorized(),
                        default_exception_el(s));
 }
 
-- 
2.20.1


