Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DFAC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:29:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B161120657
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQ9FYqH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B161120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cpq-0002jQ-AP
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9S-0005zq-Jz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9Q-0006fU-4I
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:14 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9P-0006f0-SB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:12 -0400
Received: by mail-pf1-x442.google.com with SMTP id h195so36729pfe.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ahxD9fosMvb1g5phzerFB+P0cZoPHlkyqtQ2Wc64cSg=;
 b=fQ9FYqH0+U7b2+59Xv0YlyCWmlmeVKSyKcAKW+mIO17JQL4fX7nyAh7Z7BJkBbTtb/
 KlSgoGbFQBU3zmyx78NTo0bKVaG5SZZKVSjasbysVpXjAle8ai5UIRWppS5d1truVhlL
 vpRvkTYyI+ISAEA9Ni1c28nAACxWclFvPe5wO7osJTpsBBRl5c55LSpmTFPEyBi7a+2g
 dFQK0dGFRS9iljNoPCTPXwTQ6a74LC9ZT1Yb9tyLOdCJz2C/bcNM46MjKj8HNcF1jvx4
 s0s8zY98+Qtxeyww/Xo+OsxOFhJb8WypaaRClK4WzJekivVbQNIzurcwjCdeKuuKl0pD
 lrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ahxD9fosMvb1g5phzerFB+P0cZoPHlkyqtQ2Wc64cSg=;
 b=CcKNdCoeqh7N9U9GCaWOskDtKJpeWmdsR38mApjGMTmrEi0G+owOyN3Ld0maPiDSgE
 t4rNqoqCIrEPMFd1qC3HiudLnZBoU3EgLguZG7KXqn3fymZ1yhNfsiVUYESOh4NCtFR9
 rMVMOFo96fA9FOraIADK1vEogdKcs9LIndUKNIJb7sE/FB5qWyKEYbzOC5KK45deFsjJ
 QCkKcgmmKKWX4UAXhOOTyfuZnNWMaDeXwKEh3VreQum8ac3s+vquXuIjjJjRYg0hNIWB
 AaVZ7Gxvi5yIK9mGqqXZdnpeUlJqZMBS6bvatI9lV8t8jaqeFrjccinv/HqdOsNrthDQ
 CLWw==
X-Gm-Message-State: APjAAAWwOl/VNfEGmyA4b5Kgkuwoa0yapFKDylIyM+eQPYeHMF48cwAh
 HQ3/pNJNRbCe4LyTysqCaQ31wMpETi4=
X-Google-Smtp-Source: APXvYqzVDdznNGhxI6HXwg8kfm6VmFGRRxG0mAalqnGeV3RgS++n1NGZ5gqgvODJnLVuTLnRXrHaig==
X-Received: by 2002:a62:e80e:: with SMTP id c14mr47206pfi.4.1567629910311;
 Wed, 04 Sep 2019 13:45:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:44:55 -0700
Message-Id: <20190904204507.32457-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PULL 01/13] target/openrisc: Add DisasContext
 parameter to check_r0_write
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need this context in the next patch.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 96 +++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 47 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index b189c506c5..8d72edf9b7 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -163,14 +163,16 @@ static void check_ov64s(DisasContext *dc)
 }
 #endif*/
 
-/* We're about to write to REG.  On the off-chance that the user is
-   writing to R0, re-instate the architectural register.  */
-#define check_r0_write(reg)             \
-    do {                                \
-        if (unlikely(reg == 0)) {       \
-            cpu_R[0] = cpu_R0;          \
-        }                               \
-    } while (0)
+/*
+ * We're about to write to REG.  On the off-chance that the user is
+ * writing to R0, re-instate the architectural register.
+ */
+static void check_r0_write(DisasContext *dc, int reg)
+{
+    if (unlikely(reg == 0)) {
+        cpu_R[0] = cpu_R0;
+    }
+}
 
 static void gen_ove_cy(DisasContext *dc)
 {
@@ -436,98 +438,98 @@ static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
 
 static bool trans_l_add(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     gen_add(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_addc(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     gen_addc(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sub(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     gen_sub(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_and(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_and_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_or(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_or_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_xor(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_xor_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sll(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_shl_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_srl(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_shr_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_sra(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_sar_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_ror(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_rotr_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_exths(DisasContext *dc, arg_da *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_ext16s_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
 }
 
 static bool trans_l_extbs(DisasContext *dc, arg_da *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_ext8s_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
 }
 
 static bool trans_l_exthz(DisasContext *dc, arg_da *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_ext16u_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
 }
 
 static bool trans_l_extbz(DisasContext *dc, arg_da *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_ext8u_tl(cpu_R[a->d], cpu_R[a->a]);
     return true;
 }
@@ -536,7 +538,7 @@ static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 {
     TCGv zero;
 
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     zero = tcg_const_tl(0);
     tcg_gen_movcond_tl(TCG_COND_NE, cpu_R[a->d], cpu_sr_f, zero,
                        cpu_R[a->a], cpu_R[a->b]);
@@ -546,7 +548,7 @@ static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 
 static bool trans_l_ff1(DisasContext *dc, arg_da *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_ctzi_tl(cpu_R[a->d], cpu_R[a->a], -1);
     tcg_gen_addi_tl(cpu_R[a->d], cpu_R[a->d], 1);
     return true;
@@ -554,7 +556,7 @@ static bool trans_l_ff1(DisasContext *dc, arg_da *a)
 
 static bool trans_l_fl1(DisasContext *dc, arg_da *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_clzi_tl(cpu_R[a->d], cpu_R[a->a], TARGET_LONG_BITS);
     tcg_gen_subfi_tl(cpu_R[a->d], TARGET_LONG_BITS, cpu_R[a->d]);
     return true;
@@ -562,28 +564,28 @@ static bool trans_l_fl1(DisasContext *dc, arg_da *a)
 
 static bool trans_l_mul(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     gen_mul(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_mulu(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     gen_mulu(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_div(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     gen_div(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
 
 static bool trans_l_divu(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     gen_divu(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
     return true;
 }
@@ -671,7 +673,7 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)
 {
     TCGv ea;
 
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R[a->a], a->i);
     tcg_gen_qemu_ld_tl(cpu_R[a->d], ea, dc->mem_idx, MO_TEUL);
@@ -685,7 +687,7 @@ static void do_load(DisasContext *dc, arg_load *a, MemOp mop)
 {
     TCGv ea;
 
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     ea = tcg_temp_new();
     tcg_gen_addi_tl(ea, cpu_R[a->a], a->i);
     tcg_gen_qemu_ld_tl(cpu_R[a->d], ea, dc->mem_idx, mop);
@@ -798,7 +800,7 @@ static bool trans_l_addi(DisasContext *dc, arg_rri *a)
 {
     TCGv t0;
 
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     t0 = tcg_const_tl(a->i);
     gen_add(dc, cpu_R[a->d], cpu_R[a->a], t0);
     tcg_temp_free(t0);
@@ -809,7 +811,7 @@ static bool trans_l_addic(DisasContext *dc, arg_rri *a)
 {
     TCGv t0;
 
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     t0 = tcg_const_tl(a->i);
     gen_addc(dc, cpu_R[a->d], cpu_R[a->a], t0);
     tcg_temp_free(t0);
@@ -820,7 +822,7 @@ static bool trans_l_muli(DisasContext *dc, arg_rri *a)
 {
     TCGv t0;
 
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     t0 = tcg_const_tl(a->i);
     gen_mul(dc, cpu_R[a->d], cpu_R[a->a], t0);
     tcg_temp_free(t0);
@@ -839,28 +841,28 @@ static bool trans_l_maci(DisasContext *dc, arg_l_maci *a)
 
 static bool trans_l_andi(DisasContext *dc, arg_rrk *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_andi_tl(cpu_R[a->d], cpu_R[a->a], a->k);
     return true;
 }
 
 static bool trans_l_ori(DisasContext *dc, arg_rrk *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_ori_tl(cpu_R[a->d], cpu_R[a->a], a->k);
     return true;
 }
 
 static bool trans_l_xori(DisasContext *dc, arg_rri *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_xori_tl(cpu_R[a->d], cpu_R[a->a], a->i);
     return true;
 }
 
 static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
 
     if (is_user(dc)) {
         gen_illegal_exception(dc);
@@ -927,42 +929,42 @@ static bool trans_l_msbu(DisasContext *dc, arg_ab *a)
 
 static bool trans_l_slli(DisasContext *dc, arg_dal *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_shli_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
 static bool trans_l_srli(DisasContext *dc, arg_dal *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_shri_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
 static bool trans_l_srai(DisasContext *dc, arg_dal *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_sari_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
 static bool trans_l_rori(DisasContext *dc, arg_dal *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_rotri_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
 static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_movi_tl(cpu_R[a->d], a->k << 16);
     return true;
 }
 
 static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     tcg_gen_trunc_i64_tl(cpu_R[a->d], cpu_mac);
     tcg_gen_movi_i64(cpu_mac, 0);
     return true;
@@ -1134,7 +1136,7 @@ static bool trans_l_rfe(DisasContext *dc, arg_l_rfe *a)
 static void do_fp2(DisasContext *dc, arg_da *a,
                    void (*fn)(TCGv, TCGv_env, TCGv))
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     fn(cpu_R[a->d], cpu_env, cpu_R[a->a]);
     gen_helper_update_fpcsr(cpu_env);
 }
@@ -1142,7 +1144,7 @@ static void do_fp2(DisasContext *dc, arg_da *a,
 static void do_fp3(DisasContext *dc, arg_dab *a,
                    void (*fn)(TCGv, TCGv_env, TCGv, TCGv))
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     fn(cpu_R[a->d], cpu_env, cpu_R[a->a], cpu_R[a->b]);
     gen_helper_update_fpcsr(cpu_env);
 }
@@ -1206,7 +1208,7 @@ static bool trans_lf_ftoi_s(DisasContext *dc, arg_da *a)
 
 static bool trans_lf_madd_s(DisasContext *dc, arg_dab *a)
 {
-    check_r0_write(a->d);
+    check_r0_write(dc, a->d);
     gen_helper_float_madd_s(cpu_R[a->d], cpu_env, cpu_R[a->d],
                             cpu_R[a->a], cpu_R[a->b]);
     gen_helper_update_fpcsr(cpu_env);
-- 
2.17.1


