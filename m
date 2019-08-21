Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CADC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E18D216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqtbVLnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E18D216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VOe-0002Xq-1a
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0US1-0001wZ-LJ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URs-0008Ul-Bf
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:13 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:35835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URq-0008M9-6r
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:04 -0400
Received: by mail-yw1-xc41.google.com with SMTP id g19so1247814ywe.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v2J7lZuo2hwLkHP3u8XrlTjAOasnUCxw+XflXLKr1xk=;
 b=hqtbVLnH+Hls/Ar18ADTFNN8qzKyyGadWf6YlO5w/aHYmiVwcBHRxYx5+3w8/OSs4M
 pwNlUrL4JIf7mezvUELD85IkwnjBTTuKnWaekgrh3Opwqcb2PRblmO90s9IoZ9/yboPm
 iSJ1t8rpW42Mim2kAob6fkDajXynftfYWRr0czHwnLaSLqz3GXPE7Nq8QsqMBS31FfAx
 a9MJt7FLaSmvusaMWBnxtVib38rA6IGG8C44EHmJ/rbOGHHuk+DltwPoVI76QOOgY8lu
 fFou3hLT3hAgFb8k1MR/+atTjAcLBcwC7nEKQZArflV8YMxGn1ru2qTs7TLRMCbtmMHz
 QrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v2J7lZuo2hwLkHP3u8XrlTjAOasnUCxw+XflXLKr1xk=;
 b=Z3OfPDnXwakE776l5h/ub4LKlg+8zucquojHKdQsZwMs/vuzY+FBidJVQhEDO4JRq6
 RODOdPuLjasrwUXcnxyrLbCeaV0pz9fHrvBdGmHvom8a1fCWQNIHTIZxcOX6Dh3oH9L0
 21oHxmL6gEXZPSZfwdqhWGpmAOvZHOIB5Zbylzh+1vE45UoObuVxmnuUvhcHBG1JrLtX
 rgn/JZPPiKVDi8PQp6IHVQObtzp3/KbAZmyp7wMw4ZeOf+nsMBcv53G4UsaI5N6PJMfe
 BqNvXEw7uLH6zEe2Oq9jBZWt41iXndcD+UtZRzoigX4d5DMV8htQyzJ88W5WSvpd4/fn
 /1jQ==
X-Gm-Message-State: APjAAAWuVNM2H8GMIRmf9/5YaTykjP54kd66nKgl/HyCO9gN0gRk+mQD
 8tnoDrEFwnSHblfLVwbv9B1A7k+z
X-Google-Smtp-Source: APXvYqzI4u5gBGL4/dQQAmxkrKiXJ9Jy9GKNxzDkBl6V1WMkAAo/HlHnh3VmrhYSlEfbJgnyEJA2LA==
X-Received: by 2002:a0d:cb0f:: with SMTP id n15mr24562403ywd.443.1566408657542; 
 Wed, 21 Aug 2019 10:30:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:56 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:36 -0400
Message-Id: <20190821172951.15333-61-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RFC PATCH v4 60/75] target/i386: introduce AVX code
 generators
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce code generators required by AVX instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 954 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 954 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 9b9f0d4ed1..50eab9181c 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5586,6 +5586,14 @@ GEN_INSN2(movd, Ed, Vdq)
 {
     tcg_gen_ld_i32(arg1, cpu_env, arg2 + offsetof(ZMMReg, ZMM_L(0)));
 }
+GEN_INSN2(vmovd, Vdq, Ed)
+{
+    gen_insn2(movd, Vdq, Ed)(env, s, arg1, arg2);
+}
+GEN_INSN2(vmovd, Ed, Vdq)
+{
+    gen_insn2(movd, Ed, Vdq)(env, s, arg1, arg2);
+}
 
 GEN_INSN2(movq, Pq, Eq)
 {
@@ -5607,6 +5615,14 @@ GEN_INSN2(movq, Eq, Vdq)
 {
     tcg_gen_ld_i64(arg1, cpu_env, arg2 + offsetof(ZMMReg, ZMM_Q(0)));
 }
+GEN_INSN2(vmovq, Vdq, Eq)
+{
+    gen_insn2(movq, Vdq, Eq)(env, s, arg1, arg2);
+}
+GEN_INSN2(vmovq, Eq, Vdq)
+{
+    gen_insn2(movq, Eq, Vdq)(env, s, arg1, arg2);
+}
 
 DEF_GEN_INSN2_GVEC(movq, Pq, Qq, mov, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movq, Qq, Pq, mov, MM_OPRSZ, MM_MAXSZ, MO_64)
@@ -5621,19 +5637,51 @@ GEN_INSN2(movq, UdqMq, Vq)
 {
     gen_insn2(movq, Vdq, Wq)(env, s, arg1, arg2);
 }
+GEN_INSN2(vmovq, Vdq, Wq)
+{
+    gen_insn2(movq, Vdq, Wq)(env, s, arg1, arg2);
+}
+GEN_INSN2(vmovq, UdqMq, Vq)
+{
+    gen_insn2(movq, UdqMq, Vq)(env, s, arg1, arg2);
+}
 
 DEF_GEN_INSN2_GVEC(movaps, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movaps, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovaps, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovaps, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovaps, Vqq, Wqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovaps, Wqq, Vqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movapd, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movapd, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovapd, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovapd, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovapd, Vqq, Wqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovapd, Wqq, Vqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movdqa, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movdqa, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovdqa, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovdqa, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovdqa, Vqq, Wqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovdqa, Wqq, Vqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movups, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movups, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovups, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovups, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovups, Vqq, Wqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovups, Wqq, Vqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movupd, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movupd, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovupd, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovupd, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovupd, Vqq, Wqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovupd, Wqq, Vqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movdqu, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN2_GVEC(movdqu, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovdqu, Vdq, Wdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovdqu, Wdq, Vdq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovdqu, Vqq, Wqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(vmovdqu, Wqq, Vqq, mov, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 
 GEN_INSN4(movss, Vdq, Vdq, Wd, modrm_mod)
 {
@@ -5664,6 +5712,24 @@ GEN_INSN2(movss, Wd, Vd)
 {
     gen_insn4(movss, Vdq, Vdq, Wd, modrm_mod)(env, s, arg1, arg1, arg2, 3);
 }
+GEN_INSN5(vmovss, Vdq, Hdq, Wd, modrm_mod, vex_v)
+{
+    if (arg4 == 3 || arg5 == 0) {
+        gen_insn4(movss, Vdq, Vdq, Wd, modrm_mod)(env, s, arg1,
+                                                  arg2, arg3, arg4);
+    } else {
+        gen_unknown_opcode(env, s);
+    }
+}
+GEN_INSN5(vmovss, Wdq, Hdq, Vd, modrm_mod, vex_v)
+{
+    if (arg4 == 3 || arg5 == 0) {
+        gen_insn4(movss, Vdq, Vdq, Wd, modrm_mod)(env, s, arg1,
+                                                  arg2, arg3, 3);
+    } else {
+        gen_unknown_opcode(env, s);
+    }
+}
 
 GEN_INSN4(movsd, Vdq, Vdq, Wq, modrm_mod)
 {
@@ -5687,6 +5753,24 @@ GEN_INSN2(movsd, Wq, Vq)
 {
     gen_insn4(movsd, Vdq, Vdq, Wq, modrm_mod)(env, s, arg1, arg1, arg2, 3);
 }
+GEN_INSN5(vmovsd, Vdq, Hdq, Wq, modrm_mod, vex_v)
+{
+    if (arg4 == 3 || arg5 == 0) {
+        gen_insn4(movsd, Vdq, Vdq, Wq, modrm_mod)(env, s, arg1,
+                                                  arg2, arg3, arg4);
+    } else {
+        gen_unknown_opcode(env, s);
+    }
+}
+GEN_INSN5(vmovsd, Wdq, Hdq, Vq, modrm_mod, vex_v)
+{
+    if (arg4 == 3 || arg5 == 0) {
+        gen_insn4(movsd, Vdq, Vdq, Wq, modrm_mod)(env, s, arg1,
+                                                  arg2, arg3, 3);
+    } else {
+        gen_unknown_opcode(env, s);
+    }
+}
 
 GEN_INSN2(movq2dq, Vdq, Nq)
 {
@@ -5716,10 +5800,18 @@ GEN_INSN3(movhlps, Vdq, Vdq, UdqMhq)
     }
     tcg_temp_free_i64(r64);
 }
+GEN_INSN3(vmovhlps, Vdq, Hdq, UdqMhq)
+{
+    gen_insn3(movhlps, Vdq, Vdq, UdqMhq)(env, s, arg1, arg2, arg3);
+}
 GEN_INSN2(movlps, Mq, Vq)
 {
     insnop_ldst(xmm, Mq)(env, s, 1, arg2, arg1);
 }
+GEN_INSN2(vmovlps, Mq, Vq)
+{
+    gen_insn2(movlps, Mq, Vq)(env, s, arg1, arg2);
+}
 
 GEN_INSN3(movlpd, Vdq, Vdq, Mq)
 {
@@ -5731,10 +5823,18 @@ GEN_INSN3(movlpd, Vdq, Vdq, Mq)
         tcg_temp_free_i64(r64);
     }
 }
+GEN_INSN3(vmovlpd, Vdq, Hdq, Mq)
+{
+    gen_insn3(movlpd, Vdq, Vdq, Mq)(env, s, arg1, arg2, arg3);
+}
 GEN_INSN2(movlpd, Mq, Vq)
 {
     insnop_ldst(xmm, Mq)(env, s, 1, arg2, arg1);
 }
+GEN_INSN2(vmovlpd, Mq, Vq)
+{
+    gen_insn2(movlpd, Mq, Vq)(env, s, arg1, arg2);
+}
 
 GEN_INSN3(movlhps, Vdq, Vq, Wq)
 {
@@ -5747,10 +5847,18 @@ GEN_INSN3(movlhps, Vdq, Vq, Wq)
     }
     tcg_temp_free_i64(r64);
 }
+GEN_INSN3(vmovlhps, Vdq, Hq, Wq)
+{
+    gen_insn3(movlhps, Vdq, Vq, Wq)(env, s, arg1, arg2, arg3);
+}
 GEN_INSN2(movhps, Mq, Vdq)
 {
     insnop_ldst(xmm, Mhq)(env, s, 1, arg2, arg1);
 }
+GEN_INSN2(vmovhps, Mq, Vdq)
+{
+    gen_insn2(movhps, Mq, Vdq)(env, s, arg1, arg2);
+}
 
 GEN_INSN3(movhpd, Vdq, Vq, Mq)
 {
@@ -5766,6 +5874,14 @@ GEN_INSN2(movhpd, Mq, Vdq)
 {
     insnop_ldst(xmm, Mhq)(env, s, 1, arg2, arg1);
 }
+GEN_INSN3(vmovhpd, Vdq, Hq, Mq)
+{
+    gen_insn3(movhpd, Vdq, Vq, Mq)(env, s, arg1, arg2, arg3);
+}
+GEN_INSN2(vmovhpd, Mq, Vdq)
+{
+    gen_insn2(movhpd, Mq, Vdq)(env, s, arg1, arg2);
+}
 
 DEF_GEN_INSN2_HELPER_DEP(pmovmskb, pmovmskb_mmx, Gd, Nq)
 GEN_INSN2(pmovmskb, Gq, Nq)
@@ -5783,6 +5899,14 @@ GEN_INSN2(pmovmskb, Gq, Udq)
     tcg_gen_extu_i32_i64(arg1, arg1_r32);
     tcg_temp_free_i32(arg1_r32);
 }
+DEF_GEN_INSN2_HELPER_DEP(vpmovmskb, pmovmskb_xmm, Gd, Udq)
+GEN_INSN2(vpmovmskb, Gq, Udq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(vpmovmskb, Gd, Udq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
 
 DEF_GEN_INSN2_HELPER_DEP(movmskps, movmskps, Gd, Udq)
 GEN_INSN2(movmskps, Gq, Udq)
@@ -5792,6 +5916,22 @@ GEN_INSN2(movmskps, Gq, Udq)
     tcg_gen_extu_i32_i64(arg1, arg1_r32);
     tcg_temp_free_i32(arg1_r32);
 }
+DEF_GEN_INSN2_HELPER_DEP(vmovmskps, movmskps, Gd, Udq)
+GEN_INSN2(vmovmskps, Gq, Udq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(vmovmskps, Gd, Udq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
+DEF_GEN_INSN2_HELPER_DEP(vmovmskps, movmskps, Gd, Uqq)
+GEN_INSN2(vmovmskps, Gq, Uqq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(vmovmskps, Gd, Uqq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
 
 DEF_GEN_INSN2_HELPER_DEP(movmskpd, movmskpd, Gd, Udq)
 GEN_INSN2(movmskpd, Gq, Udq)
@@ -5801,11 +5941,35 @@ GEN_INSN2(movmskpd, Gq, Udq)
     tcg_gen_extu_i32_i64(arg1, arg1_r32);
     tcg_temp_free_i32(arg1_r32);
 }
+DEF_GEN_INSN2_HELPER_DEP(vmovmskpd, movmskpd, Gd, Udq)
+GEN_INSN2(vmovmskpd, Gq, Udq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(vmovmskpd, Gd, Udq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
+DEF_GEN_INSN2_HELPER_DEP(vmovmskpd, movmskpd, Gd, Uqq)
+GEN_INSN2(vmovmskpd, Gq, Uqq)
+{
+    const TCGv_i32 arg1_r32 = tcg_temp_new_i32();
+    gen_insn2(vmovmskpd, Gd, Uqq)(env, s, arg1_r32, arg2);
+    tcg_gen_extu_i32_i64(arg1, arg1_r32);
+    tcg_temp_free_i32(arg1_r32);
+}
 
 GEN_INSN2(lddqu, Vdq, Mdq)
 {
     insnop_ldst(xmm, Mdq)(env, s, 0, arg1, arg2);
 }
+GEN_INSN2(vlddqu, Vdq, Mdq)
+{
+    gen_insn2(lddqu, Vdq, Mdq)(env, s, arg1, arg2);
+}
+GEN_INSN2(vlddqu, Vqq, Mqq)
+{
+    gen_insn2(vlddqu, Vdq, Mdq)(env, s, arg1, arg2);
+}
 
 GEN_INSN2(movshdup, Vdq, Wdq)
 {
@@ -5825,6 +5989,15 @@ GEN_INSN2(movshdup, Vdq, Wdq)
 
     tcg_temp_free_i32(r32);
 }
+GEN_INSN2(vmovshdup, Vdq, Wdq)
+{
+    gen_insn2(movshdup, Vdq, Wdq)(env, s, arg1, arg2);
+}
+GEN_INSN2(vmovshdup, Vqq, Wqq)
+{
+    gen_insn2(vmovshdup, Vdq, Wdq)(env, s, arg1, arg2);
+}
+
 GEN_INSN2(movsldup, Vdq, Wdq)
 {
     const TCGv_i32 r32 = tcg_temp_new_i32();
@@ -5843,6 +6016,15 @@ GEN_INSN2(movsldup, Vdq, Wdq)
 
     tcg_temp_free_i32(r32);
 }
+GEN_INSN2(vmovsldup, Vdq, Wdq)
+{
+    gen_insn2(movsldup, Vdq, Wdq)(env, s, arg1, arg2);
+}
+GEN_INSN2(vmovsldup, Vqq, Wqq)
+{
+    gen_insn2(movsldup, Vdq, Wdq)(env, s, arg1, arg2);
+}
+
 GEN_INSN2(movddup, Vdq, Wq)
 {
     const TCGv_i64 r64 = tcg_temp_new_i64();
@@ -5855,154 +6037,285 @@ GEN_INSN2(movddup, Vdq, Wq)
 
     tcg_temp_free_i64(r64);
 }
+GEN_INSN2(vmovddup, Vdq, Wq)
+{
+    gen_insn2(movddup, Vdq, Wq)(env, s, arg1, arg2);
+}
+GEN_INSN2(vmovddup, Vqq, Wqq)
+{
+    gen_insn2(vmovddup, Vdq, Wq)(env, s, arg1, arg2);
+}
 
 DEF_GEN_INSN3_GVEC(paddb, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddb, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpaddb, Vdq, Hdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddw, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddw, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpaddw, Vdq, Hdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddd, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(paddd, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpaddd, Vdq, Hdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(paddq, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(paddq, Vdq, Vdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpaddq, Vdq, Hdq, Wdq, add, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(paddsb, Pq, Pq, Qq, ssadd, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddsb, Vdq, Vdq, Wdq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpaddsb, Vdq, Hdq, Wdq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddsw, Pq, Pq, Qq, ssadd, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddsw, Vdq, Vdq, Wdq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpaddsw, Vdq, Hdq, Wdq, ssadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddusb, Pq, Pq, Qq, usadd, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddusb, Vdq, Vdq, Wdq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpaddusb, Vdq, Hdq, Wdq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(paddusw, Pq, Pq, Qq, usadd, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(paddusw, Vdq, Vdq, Wdq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpaddusw, Vdq, Hdq, Wdq, usadd, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(addps, addps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaddps, addps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaddps, addps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(addpd, addpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaddpd, addpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaddpd, addpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(addss, addss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vaddss, addss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(addsd, addsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vaddsd, addsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(phaddw, phaddw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phaddw, phaddw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphaddw, phaddw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(phaddd, phaddd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phaddd, phaddd_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphaddd, phaddd_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(phaddsw, phaddsw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phaddsw, phaddsw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphaddsw, phaddsw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(haddps, haddps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vhaddps, haddps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vhaddps, haddps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(haddpd, haddpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vhaddpd, haddpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vhaddpd, haddpd, Vqq, Hqq, Wqq)
 
 DEF_GEN_INSN3_GVEC(psubb, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubb, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpsubb, Vdq, Hdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubw, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubw, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpsubw, Vdq, Hdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubd, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(psubd, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpsubd, Vdq, Hdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(psubq, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(psubq, Vdq, Vdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpsubq, Vdq, Hdq, Wdq, sub, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(psubsb, Pq, Pq, Qq, sssub, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubsb, Vdq, Vdq, Wdq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpsubsb, Vdq, Hdq, Wdq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubsw, Pq, Pq, Qq, sssub, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubsw, Vdq, Vdq, Wdq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpsubsw, Vdq, Hdq, Wdq, sssub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubusb, Pq, Pq, Qq, ussub, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubusb, Vdq, Vdq, Wdq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpsubusb, Vdq, Hdq, Wdq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(psubusw, Pq, Pq, Qq, ussub, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(psubusw, Vdq, Vdq, Wdq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpsubusw, Vdq, Hdq, Wdq, ussub, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_HELPER_EPP(subps, subps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vsubps, subps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vsubps, subps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(subpd, subpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vsubpd, subpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vsubpd, subpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(subss, subss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vsubss, subss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(subsd, subsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vsubsd, subsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(phsubw, phsubw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phsubw, phsubw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphsubw, phsubw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(phsubd, phsubd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phsubd, phsubd_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphsubd, phsubd_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(phsubsw, phsubsw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(phsubsw, phsubsw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vphsubsw, phsubsw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(hsubps, hsubps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vhsubps, hsubps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vhsubps, hsubps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(hsubpd, hsubpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vhsubpd, hsubpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vhsubpd, hsubpd, Vqq, Hqq, Wqq)
 
 DEF_GEN_INSN3_HELPER_EPP(addsubps, addsubps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaddsubps, addsubps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaddsubps, addsubps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(addsubpd, addsubpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaddsubpd, addsubpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vaddsubpd, addsubpd, Vqq, Hqq, Wqq)
 
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmullw, pmullw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulld, pmulld_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmulld, pmulld_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmulhw, pmulhw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhuw, pmulhuw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmulhuw, pmulhuw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmuldq, pmuldq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmuldq, pmuldq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmuludq, pmuludq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmuludq, pmuludq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhrsw, pmulhrsw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmulhrsw, pmulhrsw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmulhrsw, pmulhrsw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(mulps, mulps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vmulps, mulps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vmulps, mulps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(mulpd, mulpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vmulpd, mulpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vmulpd, mulpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(mulss, mulss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vmulss, mulss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(mulsd, mulsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vmulsd, mulsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmaddwd, pmaddwd_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddubsw, pmaddubsw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pmaddubsw, pmaddubsw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpmaddubsw, pmaddubsw_xmm, Vdq, Hdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_EPP(divps, divps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vdivps, divps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vdivps, divps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(divpd, divpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vdivpd, divpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vdivpd, divpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(divss, divss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vdivss, divss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(divsd, divsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vdivsd, divsd, Vq, Hq, Wq)
 
 DEF_GEN_INSN2_HELPER_EPP(rcpps, rcpps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vrcpps, rcpps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vrcpps, rcpps, Vqq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(rcpss, rcpss, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vrcpss, rcpss, Vd, Hd, Wd)
 DEF_GEN_INSN2_HELPER_EPP(sqrtps, sqrtps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vsqrtps, sqrtps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vsqrtps, sqrtps, Vqq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(sqrtpd, sqrtpd, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vsqrtpd, sqrtpd, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vsqrtpd, sqrtpd, Vqq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(sqrtss, sqrtss, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vsqrtss, sqrtss, Vd, Hd, Wd)
 DEF_GEN_INSN2_HELPER_EPP(sqrtsd, sqrtsd, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vsqrtsd, sqrtsd, Vq, Hq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(rsqrtps, rsqrtps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vrsqrtps, rsqrtps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vrsqrtps, rsqrtps, Vqq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(rsqrtss, rsqrtss, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vrsqrtss, rsqrtss, Vd, Hd, Wd)
 
 DEF_GEN_INSN3_GVEC(pminub, Pq, Pq, Qq, umin, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pminub, Vdq, Vdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpminub, Vdq, Hdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pminuw, Vdq, Vdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpminuw, Vdq, Hdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pminud, Vdq, Vdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpminud, Vdq, Hdq, Wdq, umin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(pminsb, Vdq, Vdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpminsb, Vdq, Hdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pminsw, Pq, Pq, Qq, smin, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pminsw, Vdq, Vdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpminsw, Vdq, Hdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pminsd, Vdq, Vdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpminsd, Vdq, Hdq, Wdq, smin, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_HELPER_EPP(minps, minps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vminps, minps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vminps, minps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(minpd, minpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vminpd, minpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vminpd, minpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(minss, minss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vminss, minss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(minsd, minsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vminsd, minsd, Vq, Hq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(phminposuw, phminposuw_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vphminposuw, phminposuw_xmm, Vdq, Wdq)
 DEF_GEN_INSN3_GVEC(pmaxub, Pq, Pq, Qq, umax, MM_OPRSZ, MM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pmaxub, Vdq, Vdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpmaxub, Vdq, Hdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pmaxuw, Vdq, Vdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpmaxuw, Vdq, Hdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pmaxud, Vdq, Vdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpmaxud, Vdq, Hdq, Wdq, umax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_GVEC(pmaxsb, Vdq, Vdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(vpmaxsb, Vdq, Hdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_8)
 DEF_GEN_INSN3_GVEC(pmaxsw, Pq, Pq, Qq, smax, MM_OPRSZ, MM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pmaxsw, Vdq, Vdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(vpmaxsw, Vdq, Hdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_16)
 DEF_GEN_INSN3_GVEC(pmaxsd, Vdq, Vdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(vpmaxsd, Vdq, Hdq, Wdq, smax, XMM_OPRSZ, XMM_MAXSZ, MO_32)
 DEF_GEN_INSN3_HELPER_EPP(maxps, maxps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vmaxps, maxps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vmaxps, maxps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(maxpd, maxpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vmaxpd, maxpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vmaxpd, maxpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(maxss, maxss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vmaxss, maxss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(maxsd, maxsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vmaxsd, maxsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pavgb, pavgb_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpavgb, pavgb_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pavgw, pavgw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpavgw, pavgw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psadbw, psadbw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsadbw, psadbw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN4_HELPER_EPPI(mpsadbw, mpsadbw_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vmpsadbw, mpsadbw_xmm, Vdq, Hdq, Wdq, Ib)
 DEF_GEN_INSN2_HELPER_EPP(pabsb, pabsb_mmx, Pq, Qq)
 DEF_GEN_INSN2_HELPER_EPP(pabsb, pabsb_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vpabsb, pabsb_xmm, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(pabsw, pabsw_mmx, Pq, Qq)
 DEF_GEN_INSN2_HELPER_EPP(pabsw, pabsw_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vpabsw, pabsw_xmm, Vdq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(pabsd, pabsd_mmx, Pq, Qq)
 DEF_GEN_INSN2_HELPER_EPP(pabsd, pabsd_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vpabsd, pabsd_xmm, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psignb, psignb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psignb, psignb_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsignb, psignb_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psignw, psignw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psignw, psignw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsignw, psignw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psignd, psignd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psignd, psignd_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsignd, psignd_xmm, Vdq, Hdq, Wdq)
 
 DEF_GEN_INSN4_HELPER_EPPI(dpps, dpps_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vdpps, dpps_xmm, Vdq, Hdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vdpps, dpps_xmm, Vqq, Hqq, Wqq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(dppd, dppd_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vdppd, dppd_xmm, Vdq, Hdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_EPPI(roundps, roundps_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(vroundps, roundps_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(vroundps, roundps_xmm, Vqq, Wqq, Ib)
 DEF_GEN_INSN3_HELPER_EPPI(roundpd, roundpd_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(vroundpd, roundpd_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(vroundpd, roundpd_xmm, Vqq, Wqq, Ib)
 DEF_GEN_INSN3_HELPER_EPPI(roundss, roundss_xmm, Vd, Wd, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vroundss, roundss_xmm, Vd, Hd, Wd, Ib)
 DEF_GEN_INSN3_HELPER_EPPI(roundsd, roundsd_xmm, Vq, Wq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vroundsd, roundsd_xmm, Vq, Hq, Wq, Ib)
 
 DEF_GEN_INSN3_HELPER_EPP(aesdec, aesdec_xmm, Vdq, Vdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(vaesdec, aesdec_xmm, Vdq, Hdq, Wdq)
@@ -6021,58 +6334,124 @@ DEF_GEN_INSN4_HELPER_EPPI(vpclmulqdq, pclmulqdq_xmm, Vdq, Hdq, Wdq, Ib)
 
 DEF_GEN_INSN3_GVEC(pcmpeqb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqb, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(vpcmpeqb, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqw, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(vpcmpeqw, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqd, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(vpcmpeqd, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpeqq, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(vpcmpeqq, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_EQ)
 DEF_GEN_INSN3_GVEC(pcmpgtb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtb, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(vpcmpgtb, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_8, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtw, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(vpcmpgtw, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_16, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtd, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(vpcmpgtd, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_32, TCG_COND_GT)
 DEF_GEN_INSN3_GVEC(pcmpgtq, Vdq, Vdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(vpcmpgtq, Vdq, Hdq, Wdq, cmp, XMM_OPRSZ, XMM_MAXSZ, MO_64, TCG_COND_GT)
 
 DEF_GEN_INSN3_HELPER_EPPI(pcmpestrm, pcmpestrm_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(vpcmpestrm, pcmpestrm_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_EPPI(pcmpestri, pcmpestri_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(vpcmpestri, pcmpestri_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_EPPI(pcmpistrm, pcmpistrm_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(vpcmpistrm, pcmpistrm_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_EPPI(pcmpistri, pcmpistri_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_EPPI(vpcmpistri, pcmpistri_xmm, Vdq, Wdq, Ib)
 
 DEF_GEN_INSN2_HELPER_EPP(ptest, ptest_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vptest, ptest_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vptest, ptest_xmm, Vqq, Wqq)
+DEF_GEN_INSN2_HELPER_EPP(vtestps, ptest_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vtestps, ptest_xmm, Vqq, Wqq)
+DEF_GEN_INSN2_HELPER_EPP(vtestpd, ptest_xmm, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vtestpd, ptest_xmm, Vqq, Wqq)
 
 DEF_GEN_INSN3_HELPER_EPP(cmpeqps, cmpeqps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpeqps, cmpeqps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpeqps, cmpeqps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpeqpd, cmpeqpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpeqpd, cmpeqpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpeqpd, cmpeqpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpeqss, cmpeqss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vcmpeqss, cmpeqss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(cmpeqsd, cmpeqsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpeqsd, cmpeqsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpltps, cmpltps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpltps, cmpltps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpltps, cmpltps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpltpd, cmpltpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpltpd, cmpltpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpltpd, cmpltpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpltss, cmpltss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vcmpltss, cmpltss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(cmpltsd, cmpltsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpltsd, cmpltsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpleps, cmpleps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpleps, cmpleps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpleps, cmpleps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmplepd, cmplepd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmplepd, cmplepd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmplepd, cmplepd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpless, cmpless, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vcmpless, cmpless, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(cmplesd, cmplesd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vcmplesd, cmplesd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpunordps, cmpunordps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpunordps, cmpunordps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpunordps, cmpunordps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpunordpd, cmpunordpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpunordpd, cmpunordpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpunordpd, cmpunordpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpunordss, cmpunordss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vcmpunordss, cmpunordss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(cmpunordsd, cmpunordsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpunordsd, cmpunordsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpneqps, cmpneqps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpneqps, cmpneqps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpneqps, cmpneqps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpneqpd, cmpneqpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpneqpd, cmpneqpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpneqpd, cmpneqpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpneqss, cmpneqss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vcmpneqss, cmpneqss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(cmpneqsd, cmpneqsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpneqsd, cmpneqsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnltps, cmpnltps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnltps, cmpnltps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnltps, cmpnltps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnltpd, cmpnltpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnltpd, cmpnltpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnltpd, cmpnltpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnltss, cmpnltss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnltss, cmpnltss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(cmpnltsd, cmpnltsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnltsd, cmpnltsd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnleps, cmpnleps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnleps, cmpnleps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnleps, cmpnleps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnlepd, cmpnlepd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnlepd, cmpnlepd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnlepd, cmpnlepd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpnless, cmpnless, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnless, cmpnless, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(cmpnlesd, cmpnlesd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpnlesd, cmpnlesd, Vq, Hq, Wq)
 DEF_GEN_INSN3_HELPER_EPP(cmpordps, cmpordps, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpordps, cmpordps, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpordps, cmpordps, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpordpd, cmpordpd, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpordpd, cmpordpd, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpordpd, cmpordpd, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(cmpordss, cmpordss, Vd, Vd, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vcmpordss, cmpordss, Vd, Hd, Wd)
 DEF_GEN_INSN3_HELPER_EPP(cmpordsd, cmpordsd, Vq, Vq, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vcmpordsd, cmpordsd, Vq, Hq, Wq)
 
 GEN_INSN4(cmpps, Vdq, Vdq, Wdq, Ib)
 {
@@ -6106,6 +6485,70 @@ GEN_INSN4(cmpps, Vdq, Vdq, Wdq, Ib)
     g_assert_not_reached();
 }
 
+GEN_INSN4(vcmpps, Vdq, Hdq, Wdq, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(vcmpeqps, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(vcmpltps, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(vcmpleps, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(vcmpunordps, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(vcmpneqps, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(vcmpnltps, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(vcmpnleps, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(vcmpordps, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
+GEN_INSN4(vcmpps, Vqq, Hqq, Wqq, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(vcmpeqps, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(vcmpltps, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(vcmpleps, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(vcmpunordps, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(vcmpneqps, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(vcmpnltps, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(vcmpnleps, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(vcmpordps, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
 GEN_INSN4(cmppd, Vdq, Vdq, Wdq, Ib)
 {
     switch (arg4 & 7) {
@@ -6138,6 +6581,70 @@ GEN_INSN4(cmppd, Vdq, Vdq, Wdq, Ib)
     g_assert_not_reached();
 }
 
+GEN_INSN4(vcmppd, Vdq, Hdq, Wdq, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(vcmpeqpd, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(vcmpltpd, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(vcmplepd, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(vcmpunordpd, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(vcmpneqpd, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(vcmpnltpd, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(vcmpnlepd, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(vcmpordpd, Vdq, Hdq, Wdq)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
+GEN_INSN4(vcmppd, Vqq, Hqq, Wqq, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(vcmpeqpd, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(vcmpltpd, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(vcmplepd, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(vcmpunordpd, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(vcmpneqpd, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(vcmpnltpd, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(vcmpnlepd, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(vcmpordpd, Vqq, Hqq, Wqq)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
 GEN_INSN4(cmpss, Vd, Vd, Wd, Ib)
 {
     switch (arg4 & 7) {
@@ -6170,6 +6677,38 @@ GEN_INSN4(cmpss, Vd, Vd, Wd, Ib)
     g_assert_not_reached();
 }
 
+GEN_INSN4(vcmpss, Vd, Hd, Wd, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(vcmpeqss, Vd, Hd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(vcmpltss, Vd, Hd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(vcmpless, Vd, Hd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(vcmpunordss, Vd, Hd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(vcmpneqss, Vd, Hd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(vcmpnltss, Vd, Hd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(vcmpnless, Vd, Hd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(vcmpordss, Vd, Hd, Wd)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
 GEN_INSN4(cmpsd, Vq, Vq, Wq, Ib)
 {
     switch (arg4 & 7) {
@@ -6202,46 +6741,112 @@ GEN_INSN4(cmpsd, Vq, Vq, Wq, Ib)
     g_assert_not_reached();
 }
 
+GEN_INSN4(vcmpsd, Vq, Hq, Wq, Ib)
+{
+    switch (arg4 & 7) {
+    case 0:
+        gen_insn3(vcmpeqsd, Vq, Hq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 1:
+        gen_insn3(vcmpltsd, Vq, Hq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 2:
+        gen_insn3(vcmplesd, Vq, Hq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 3:
+        gen_insn3(vcmpunordsd, Vq, Hq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 4:
+        gen_insn3(vcmpneqsd, Vq, Hq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 5:
+        gen_insn3(vcmpnltsd, Vq, Hq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 6:
+        gen_insn3(vcmpnlesd, Vq, Hq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    case 7:
+        gen_insn3(vcmpordsd, Vq, Hq, Wq)(env, s, arg1, arg2, arg3);
+        return;
+    }
+
+    g_assert_not_reached();
+}
+
 DEF_GEN_INSN2_HELPER_EPP(comiss, comiss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(vcomiss, comiss, Vd, Wd)
 DEF_GEN_INSN2_HELPER_EPP(comisd, comisd, Vq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vcomisd, comisd, Vq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(ucomiss, ucomiss, Vd, Wd)
+DEF_GEN_INSN2_HELPER_EPP(vucomiss, ucomiss, Vd, Wd)
 DEF_GEN_INSN2_HELPER_EPP(ucomisd, ucomisd, Vq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vucomisd, ucomisd, Vq, Wq)
 
 DEF_GEN_INSN3_GVEC(pand, Pq, Pq, Qq, and, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pand, Vdq, Vdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpand, Vdq, Hdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(andps, Vdq, Vdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vandps, Vdq, Hdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vandps, Vqq, Hqq, Wqq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(andpd, Vdq, Vdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vandpd, Vdq, Hdq, Wdq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vandpd, Vqq, Hqq, Wqq, and, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pandn, Pq, Pq, Qq, andn, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pandn, Vdq, Vdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpandn, Vdq, Hdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(andnps, Vdq, Vdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vandnps, Vdq, Hdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vandnps, Vqq, Hqq, Wqq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(andnpd, Vdq, Vdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vandnpd, Vdq, Hdq, Wdq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vandnpd, Vqq, Hqq, Wqq, andn, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(por, Pq, Pq, Qq, or, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(por, Vdq, Vdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpor, Vdq, Hdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(orps, Vdq, Vdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vorps, Vdq, Hdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vorps, Vqq, Hqq, Wqq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(orpd, Vdq, Vdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vorpd, Vdq, Hdq, Wdq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vorpd, Vqq, Hqq, Wqq, or, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pxor, Pq, Pq, Qq, xor, MM_OPRSZ, MM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(pxor, Vdq, Vdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vpxor, Vdq, Hdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(xorps, Vdq, Vdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vxorps, Vdq, Hdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vxorps, Vqq, Hqq, Wqq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 DEF_GEN_INSN3_GVEC(xorpd, Vdq, Vdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vxorpd, Vdq, Hdq, Wdq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(vxorpd, Vqq, Hqq, Wqq, xor, XMM_OPRSZ, XMM_MAXSZ, MO_64)
 
 DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsllw, psllw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpslld, pslld_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsllq, psllq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(pslldq, pslldq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpslldq, pslldq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsrlw, psrlw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsrld, psrld_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsrlq, psrlq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrldq, psrldq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsrldq, psrldq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsraw, psraw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpsrad, psrad_xmm, Vdq, Hdq, Wdq)
 
 #define DEF_GEN_PSHIFT_IMM_MM(mnem, opT1, opT2)                         \
     GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
@@ -6267,71 +6872,151 @@ DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_xmm, Vdq, Vdq, Wdq)
         gen_insn2(movq, Vdq, Eq)(env, s, arg3_xmm, arg3_r64);           \
         gen_insn3(mnem, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3_xmm);   \
     }
+#define DEF_GEN_VPSHIFT_IMM_XMM(mnem, opT1, opT2)                       \
+    GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
+    {                                                                   \
+        const uint64_t arg3_ui64 = (uint8_t)arg3;                       \
+        const insnop_arg_t(Eq) arg3_r64 = s->tmp1_i64;                  \
+        const insnop_arg_t(Wdq) arg3_xmm =                              \
+            offsetof(CPUX86State, xmm_t0.ZMM_Q(0));                     \
+                                                                        \
+        tcg_gen_movi_i64(arg3_r64, arg3_ui64);                          \
+        gen_insn2(movq, Vdq, Eq)(env, s, arg3_xmm, arg3_r64);           \
+        gen_insn3(mnem, Vdq, Hdq, Wdq)(env, s, arg2, arg2, arg3_xmm);   \
+    }
 
 DEF_GEN_PSHIFT_IMM_MM(psllw, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psllw, Udq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpsllw, Hdq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(pslld, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(pslld, Udq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpslld, Hdq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psllq, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psllq, Udq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpsllq, Hdq, Udq)
 DEF_GEN_PSHIFT_IMM_XMM(pslldq, Udq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpslldq, Hdq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrlw, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psrlw, Udq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpsrlw, Hdq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrld, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psrld, Udq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpsrld, Hdq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrlq, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psrlq, Udq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpsrlq, Hdq, Udq)
 DEF_GEN_PSHIFT_IMM_XMM(psrldq, Udq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpsrldq, Hdq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psraw, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psraw, Udq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpsraw, Hdq, Udq)
 DEF_GEN_PSHIFT_IMM_MM(psrad, Nq, Nq)
 DEF_GEN_PSHIFT_IMM_XMM(psrad, Udq, Udq)
+DEF_GEN_VPSHIFT_IMM_XMM(vpsrad, Hdq, Udq)
 
 DEF_GEN_INSN4_HELPER_EPPI(palignr, palignr_mmx, Pq, Pq, Qq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(palignr, palignr_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vpalignr, palignr_xmm, Vdq, Hdq, Wdq, Ib)
 
 DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpacksswb, packsswb_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpackssdw, packssdw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpackuswb, packuswb_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(packusdw, packusdw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpackusdw, packusdw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_mmx, Pq, Pq, Qd)
 DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpcklbw, punpcklbw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklwd, punpcklwd_mmx, Pq, Pq, Qd)
 DEF_GEN_INSN3_HELPER_EPP(punpcklwd, punpcklwd_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpcklwd, punpcklwd_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckldq, punpckldq_mmx, Pq, Pq, Qd)
 DEF_GEN_INSN3_HELPER_EPP(punpckldq, punpckldq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpckldq, punpckldq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpcklqdq, punpcklqdq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpcklqdq, punpcklqdq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpckhbw, punpckhbw_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhwd, punpckhwd_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhwd, punpckhwd_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpckhwd, punpckhwd_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhdq, punpckhdq_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhdq, punpckhdq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpckhdq, punpckhdq_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_EPP(punpckhqdq, punpckhqdq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpunpckhqdq, punpckhqdq_xmm, Vdq, Hdq, Wdq)
 
 DEF_GEN_INSN3_HELPER_EPP(unpcklps, punpckldq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vunpcklps, punpckldq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vunpcklps, punpckldq_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(unpcklpd, punpcklqdq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vunpcklpd, punpcklqdq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vunpcklpd, punpcklqdq_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(unpckhps, punpckhdq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vunpckhps, punpckhdq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vunpckhps, punpckhdq_xmm, Vqq, Hqq, Wqq)
 DEF_GEN_INSN3_HELPER_EPP(unpckhpd, punpckhqdq_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vunpckhpd, punpckhqdq_xmm, Vdq, Hdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vunpckhpd, punpckhqdq_xmm, Vqq, Hqq, Wqq)
 
 DEF_GEN_INSN3_HELPER_EPP(pshufb, pshufb_mmx, Pq, Pq, Qq)
 DEF_GEN_INSN3_HELPER_EPP(pshufb, pshufb_xmm, Vdq, Vdq, Wdq)
+DEF_GEN_INSN3_HELPER_EPP(vpshufb, pshufb_xmm, Vdq, Hdq, Wdq)
 DEF_GEN_INSN3_HELPER_PPI(pshufw, pshufw_mmx, Pq, Qq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(pshuflw, pshuflw_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(vpshuflw, pshuflw_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(pshufhw, pshufhw_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(vpshufhw, pshufhw_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN3_HELPER_PPI(pshufd, pshufd_xmm, Vdq, Wdq, Ib)
+DEF_GEN_INSN3_HELPER_PPI(vpshufd, pshufd_xmm, Vdq, Wdq, Ib)
 DEF_GEN_INSN4_HELPER_PPI(shufps, shufps, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_PPI(vshufps, shufps, Vdq, Hdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_PPI(vshufps, shufps, Vqq, Hqq, Wqq, Ib)
 DEF_GEN_INSN4_HELPER_PPI(shufpd, shufpd, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_PPI(vshufpd, shufpd, Vdq, Hdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_PPI(vshufpd, shufpd, Vqq, Hqq, Wqq, Ib)
 
 DEF_GEN_INSN4_HELPER_EPPI(blendps, blendps_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vblendps, blendps_xmm, Vdq, Hdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vblendps, blendps_xmm, Vqq, Hqq, Wqq, Ib)
 DEF_GEN_INSN4_HELPER_EPPI(blendpd, blendpd_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vblendpd, blendpd_xmm, Vdq, Hdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vblendpd, blendpd_xmm, Vqq, Hqq, Wqq, Ib)
+
 DEF_GEN_INSN3_HELPER_EPP(blendvps, blendvps_xmm, Vdq, Vdq, Wdq)
+GEN_INSN4(vblendvps, Vdq, Hdq, Wdq, Ldq)
+{
+    gen_insn3(blendvps, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+}
+GEN_INSN4(vblendvps, Vqq, Hqq, Wqq, Lqq)
+{
+    gen_insn3(blendvps, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+}
+
 DEF_GEN_INSN3_HELPER_EPP(blendvpd, blendvpd_xmm, Vdq, Vdq, Wdq)
+GEN_INSN4(vblendvpd, Vdq, Hdq, Wdq, Ldq)
+{
+    gen_insn3(blendvpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+}
+GEN_INSN4(vblendvpd, Vqq, Hqq, Wqq, Lqq)
+{
+    gen_insn3(blendvpd, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+}
+
 DEF_GEN_INSN3_HELPER_EPP(pblendvb, pblendvb_xmm, Vdq, Vdq, Wdq)
+GEN_INSN4(vpblendvb, Vdq, Hdq, Wdq, Ldq)
+{
+    gen_insn3(pblendvb, Vdq, Vdq, Wdq)(env, s, arg1, arg2, arg3);
+}
+
 DEF_GEN_INSN4_HELPER_EPPI(pblendw, pblendw_xmm, Vdq, Vdq, Wdq, Ib)
+DEF_GEN_INSN4_HELPER_EPPI(vpblendw, pblendw_xmm, Vdq, Hdq, Wdq, Ib)
 
 GEN_INSN4(insertps, Vdq, Vdq, Wd, Ib)
 {
@@ -6341,6 +7026,13 @@ GEN_INSN4(insertps, Vdq, Vdq, Wd, Ib)
     const size_t aofs = offsetof(ZMMReg, ZMM_L(0));
     gen_op_movl(s, arg1 + dofs, arg3 + aofs);
 }
+GEN_INSN4(vinsertps, Vdq, Hdq, Wd, Ib)
+{
+    if (arg1 != arg2) {
+        gen_insn2(vmovaps, Vdq, Wdq)(env, s, arg1, arg2);
+    }
+    gen_insn4(insertps, Vdq, Vdq, Wd, Ib)(env, s, arg1, arg1, arg3, arg4);
+}
 GEN_INSN4(pinsrb, Vdq, Vdq, RdMb, Ib)
 {
     assert(arg1 == arg2);
@@ -6348,6 +7040,13 @@ GEN_INSN4(pinsrb, Vdq, Vdq, RdMb, Ib)
     const size_t ofs = offsetof(ZMMReg, ZMM_B(arg4 & 15));
     tcg_gen_st8_i32(arg3, cpu_env, arg1 + ofs);
 }
+GEN_INSN4(vpinsrb, Vdq, Hdq, RdMb, Ib)
+{
+    if (arg1 != arg2) {
+        gen_insn2(vmovaps, Vdq, Wdq)(env, s, arg1, arg2);
+    }
+    gen_insn4(pinsrb, Vdq, Vdq, RdMb, Ib)(env, s, arg1, arg1, arg3, arg4);
+}
 GEN_INSN4(pinsrw, Pq, Pq, RdMw, Ib)
 {
     assert(arg1 == arg2);
@@ -6362,6 +7061,13 @@ GEN_INSN4(pinsrw, Vdq, Vdq, RdMw, Ib)
     const size_t ofs = offsetof(ZMMReg, ZMM_W(arg4 & 7));
     tcg_gen_st16_i32(arg3, cpu_env, arg1 + ofs);
 }
+GEN_INSN4(vpinsrw, Vdq, Hdq, RdMw, Ib)
+{
+    if (arg1 != arg2) {
+        gen_insn2(vmovaps, Vdq, Wdq)(env, s, arg1, arg2);
+    }
+    gen_insn4(pinsrw, Vdq, Vdq, RdMw, Ib)(env, s, arg1, arg1, arg3, arg4);
+}
 GEN_INSN4(pinsrd, Vdq, Vdq, Ed, Ib)
 {
     assert(arg1 == arg2);
@@ -6369,6 +7075,13 @@ GEN_INSN4(pinsrd, Vdq, Vdq, Ed, Ib)
     const size_t ofs = offsetof(ZMMReg, ZMM_L(arg4 & 3));
     tcg_gen_st_i32(arg3, cpu_env, arg1 + ofs);
 }
+GEN_INSN4(vpinsrd, Vdq, Hdq, Ed, Ib)
+{
+    if (arg1 != arg2) {
+        gen_insn2(vmovaps, Vdq, Wdq)(env, s, arg1, arg2);
+    }
+    gen_insn4(pinsrd, Vdq, Vdq, Ed, Ib)(env, s, arg1, arg1, arg3, arg4);
+}
 GEN_INSN4(pinsrq, Vdq, Vdq, Eq, Ib)
 {
     assert(arg1 == arg2);
@@ -6376,32 +7089,63 @@ GEN_INSN4(pinsrq, Vdq, Vdq, Eq, Ib)
     const size_t ofs = offsetof(ZMMReg, ZMM_Q(arg4 & 1));
     tcg_gen_st_i64(arg3, cpu_env, arg1 + ofs);
 }
+GEN_INSN4(vpinsrq, Vdq, Hdq, Eq, Ib)
+{
+    if (arg1 != arg2) {
+        gen_insn2(vmovaps, Vdq, Wdq)(env, s, arg1, arg2);
+    }
+    gen_insn4(pinsrq, Vdq, Vdq, Eq, Ib)(env, s, arg1, arg1, arg3, arg4);
+}
+GEN_INSN4(vinsertf128, Vqq, Hqq, Wdq, Ib)
+{
+    gen_insn2(movaps, Vdq, Wdq)(env, s, arg1, arg3);
+}
 
 GEN_INSN3(extractps, Ed, Vdq, Ib)
 {
     const size_t ofs = offsetof(ZMMReg, ZMM_L(arg3 & 3));
     tcg_gen_ld_i32(arg1, cpu_env, arg2 + ofs);
 }
+GEN_INSN3(vextractps, Ed, Vdq, Ib)
+{
+    gen_insn3(extractps, Ed, Vdq, Ib)(env, s, arg1, arg2, arg3);
+}
 GEN_INSN3(pextrb, RdMb, Vdq, Ib)
 {
     const size_t ofs = offsetof(ZMMReg, ZMM_B(arg3 & 15));
     tcg_gen_ld8u_i32(arg1, cpu_env, arg2 + ofs);
 }
+GEN_INSN3(vpextrb, RdMb, Vdq, Ib)
+{
+    gen_insn3(pextrb, RdMb, Vdq, Ib)(env, s, arg1, arg2, arg3);
+}
 GEN_INSN3(pextrw, RdMw, Vdq, Ib)
 {
     const size_t ofs = offsetof(ZMMReg, ZMM_W(arg3 & 7));
     tcg_gen_ld16u_i32(arg1, cpu_env, arg2 + ofs);
 }
+GEN_INSN3(vpextrw, RdMw, Vdq, Ib)
+{
+    gen_insn3(pextrw, RdMw, Vdq, Ib)(env, s, arg1, arg2, arg3);
+}
 GEN_INSN3(pextrd, Ed, Vdq, Ib)
 {
     const size_t ofs = offsetof(ZMMReg, ZMM_L(arg3 & 3));
     tcg_gen_ld_i32(arg1, cpu_env, arg2 + ofs);
 }
+GEN_INSN3(vpextrd, Ed, Vdq, Ib)
+{
+    gen_insn3(pextrd, Ed, Vdq, Ib)(env, s, arg1, arg2, arg3);
+}
 GEN_INSN3(pextrq, Eq, Vdq, Ib)
 {
     const size_t ofs = offsetof(ZMMReg, ZMM_Q(arg3 & 1));
     tcg_gen_ld_i64(arg1, cpu_env, arg2 + ofs);
 }
+GEN_INSN3(vpextrq, Eq, Vdq, Ib)
+{
+    gen_insn3(pextrq, Eq, Vdq, Ib)(env, s, arg1, arg2, arg3);
+}
 GEN_INSN3(pextrw, Gd, Nq, Ib)
 {
     const size_t ofs = offsetof(MMXReg, MMX_W(arg3 & 3));
@@ -6422,49 +7166,173 @@ GEN_INSN3(pextrw, Gq, Udq, Ib)
     const size_t ofs = offsetof(ZMMReg, ZMM_W(arg3 & 7));
     tcg_gen_ld16u_i64(arg1, cpu_env, arg2 + ofs);
 }
+GEN_INSN3(vpextrw, Gd, Udq, Ib)
+{
+    gen_insn3(pextrw, Gd, Udq, Ib)(env, s, arg1, arg2, arg3);
+}
+GEN_INSN3(vpextrw, Gq, Udq, Ib)
+{
+    gen_insn3(pextrw, Gq, Udq, Ib)(env, s, arg1, arg2, arg3);
+}
+GEN_INSN3(vextractf128, Wdq, Vqq, Ib)
+{
+    gen_insn2(movaps, Wdq, Vdq)(env, s, arg1, arg2);
+}
+
+GEN_INSN2(vbroadcastss, Vdq, Md)
+{
+    const TCGv_i32 r32 = tcg_temp_new_i32();
+    insnop_ldst(tcg_i32, Md)(env, s, 0, r32, arg2);
+
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(0)));
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(1)));
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(2)));
+    tcg_gen_st_i32(r32, cpu_env, arg1 + offsetof(ZMMReg, ZMM_L(3)));
+
+    tcg_temp_free_i32(r32);
+}
+GEN_INSN2(vbroadcastss, Vqq, Md)
+{
+    gen_insn2(vbroadcastss, Vdq, Md)(env, s, arg1, arg2);
+}
+GEN_INSN2(vbroadcastsd, Vqq, Mq)
+{
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    insnop_ldst(tcg_i64, Mq)(env, s, 0, r64, arg2);
+
+    tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(0)));
+    tcg_gen_st_i64(r64, cpu_env, arg1 + offsetof(ZMMReg, ZMM_Q(1)));
+
+    tcg_temp_free_i64(r64);
+}
+GEN_INSN2(vbroadcastf128, Vqq, Mdq)
+{
+    insnop_ldst(xmm, Mqq)(env, s, 0, arg1, arg2);
+}
+
+GEN_INSN4(vperm2f128, Vqq, Hqq, Wqq, Ib)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN3(vpermilps, Vdq, Hdq, Wdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpermilps, Vqq, Hqq, Wqq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpermilps, Vdq, Wdq, Ib)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpermilps, Vqq, Wqq, Ib)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN3(vpermilpd, Vdq, Hdq, Wdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpermilpd, Vqq, Hqq, Wqq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpermilpd, Vdq, Wdq, Ib)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vpermilpd, Vqq, Wqq, Ib)
+{
+    /* XXX TODO implement this */
+}
 
 DEF_GEN_INSN2_HELPER_EPP(pmovsxbw, pmovsxbw_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxbw, pmovsxbw_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(pmovsxbd, pmovsxbd_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxbd, pmovsxbd_xmm, Vdq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(pmovsxbq, pmovsxbq_xmm, Vdq, Ww)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxbq, pmovsxbq_xmm, Vdq, Ww)
 DEF_GEN_INSN2_HELPER_EPP(pmovsxwd, pmovsxwd_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxwd, pmovsxwd_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(pmovsxwq, pmovsxwq_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxwq, pmovsxwq_xmm, Vdq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(pmovsxdq, pmovsxdq_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovsxdq, pmovsxdq_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxbw, pmovzxbw_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxbw, pmovzxbw_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxbd, pmovzxbd_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxbd, pmovzxbd_xmm, Vdq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxbq, pmovzxbq_xmm, Vdq, Ww)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxbq, pmovzxbq_xmm, Vdq, Ww)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxwd, pmovzxwd_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxwd, pmovzxwd_xmm, Vdq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxwq, pmovzxwq_xmm, Vdq, Wd)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxwq, pmovzxwq_xmm, Vdq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(pmovzxdq, pmovzxdq_xmm, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vpmovzxdq, pmovzxdq_xmm, Vdq, Wq)
 
 DEF_GEN_INSN2_HELPER_EPP(cvtpi2ps, cvtpi2ps, Vdq, Qq)
 DEF_GEN_INSN2_HELPER_EPD(cvtsi2ss, cvtsi2ss, Vd, Ed)
 DEF_GEN_INSN2_HELPER_EPQ(cvtsi2ss, cvtsq2ss, Vd, Eq)
+DEF_GEN_INSN3_HELPER_EPD(vcvtsi2ss, cvtsi2ss, Vd, Hd, Ed)
+DEF_GEN_INSN3_HELPER_EPQ(vcvtsi2ss, cvtsq2ss, Vd, Hd, Eq)
 DEF_GEN_INSN2_HELPER_EPP(cvtpi2pd, cvtpi2pd, Vdq, Qq)
 DEF_GEN_INSN2_HELPER_EPD(cvtsi2sd, cvtsi2sd, Vq, Ed)
 DEF_GEN_INSN2_HELPER_EPQ(cvtsi2sd, cvtsq2sd, Vq, Eq)
+DEF_GEN_INSN3_HELPER_EPD(vcvtsi2sd, cvtsi2sd, Vq, Hq, Ed)
+DEF_GEN_INSN3_HELPER_EPQ(vcvtsi2sd, cvtsq2sd, Vq, Hq, Eq)
 DEF_GEN_INSN2_HELPER_EPP(cvtps2pi, cvtps2pi, Pq, Wq)
 DEF_GEN_INSN2_HELPER_DEP(cvtss2si, cvtss2si, Gd, Wd)
 DEF_GEN_INSN2_HELPER_QEP(cvtss2si, cvtss2sq, Gq, Wd)
+DEF_GEN_INSN2_HELPER_DEP(vcvtss2si, cvtss2si, Gd, Wd)
+DEF_GEN_INSN2_HELPER_QEP(vcvtss2si, cvtss2sq, Gq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(cvtpd2pi, cvtpd2pi, Pq, Wdq)
 DEF_GEN_INSN2_HELPER_DEP(cvtsd2si, cvtsd2si, Gd, Wq)
 DEF_GEN_INSN2_HELPER_QEP(cvtsd2si, cvtsd2sq, Gq, Wq)
+DEF_GEN_INSN2_HELPER_DEP(vcvtsd2si, cvtsd2si, Gd, Wq)
+DEF_GEN_INSN2_HELPER_QEP(vcvtsd2si, cvtsd2sq, Gq, Wq)
 DEF_GEN_INSN2_HELPER_EPP(cvttps2pi, cvttps2pi, Pq, Wq)
 DEF_GEN_INSN2_HELPER_DEP(cvttss2si, cvttss2si, Gd, Wd)
 DEF_GEN_INSN2_HELPER_QEP(cvttss2si, cvttss2sq, Gq, Wd)
+DEF_GEN_INSN2_HELPER_DEP(vcvttss2si, cvttss2si, Gd, Wd)
+DEF_GEN_INSN2_HELPER_QEP(vcvttss2si, cvttss2sq, Gq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(cvttpd2pi, cvttpd2pi, Pq, Wdq)
 DEF_GEN_INSN2_HELPER_DEP(cvttsd2si, cvttsd2si, Gd, Wq)
 DEF_GEN_INSN2_HELPER_QEP(cvttsd2si, cvttsd2sq, Gq, Wq)
+DEF_GEN_INSN2_HELPER_DEP(vcvttsd2si, cvttsd2si, Gd, Wq)
+DEF_GEN_INSN2_HELPER_QEP(vcvttsd2si, cvttsd2sq, Gq, Wq)
 
 DEF_GEN_INSN2_HELPER_EPP(cvtpd2dq, cvtpd2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtpd2dq, cvtpd2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtpd2dq, cvtpd2dq, Vdq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(cvttpd2dq, cvttpd2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvttpd2dq, cvttpd2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvttpd2dq, cvttpd2dq, Vdq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(cvtdq2pd, cvtdq2pd, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtdq2pd, cvtdq2pd, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtdq2pd, cvtdq2pd, Vqq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(cvtps2pd, cvtps2pd, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtps2pd, cvtps2pd, Vdq, Wq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtps2pd, cvtps2pd, Vqq, Wdq)
 DEF_GEN_INSN2_HELPER_EPP(cvtpd2ps, cvtpd2ps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtpd2ps, cvtpd2ps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtpd2ps, cvtpd2ps, Vdq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(cvtss2sd, cvtss2sd, Vq, Wd)
+DEF_GEN_INSN3_HELPER_EPP(vcvtss2sd, cvtss2sd, Vq, Hq, Wd)
 DEF_GEN_INSN2_HELPER_EPP(cvtsd2ss, cvtsd2ss, Vd, Wq)
+DEF_GEN_INSN3_HELPER_EPP(vcvtsd2ss, cvtsd2ss, Vd, Hd, Wq)
 DEF_GEN_INSN2_HELPER_EPP(cvtdq2ps, cvtdq2ps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtdq2ps, cvtdq2ps, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtdq2ps, cvtdq2ps, Vqq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(cvtps2dq, cvtps2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtps2dq, cvtps2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvtps2dq, cvtps2dq, Vqq, Wqq)
 DEF_GEN_INSN2_HELPER_EPP(cvttps2dq, cvttps2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvttps2dq, cvttps2dq, Vdq, Wdq)
+DEF_GEN_INSN2_HELPER_EPP(vcvttps2dq, cvttps2dq, Vqq, Wqq)
 
 GEN_INSN2(maskmovq, Pq, Nq)
 {
@@ -6498,15 +7366,70 @@ GEN_INSN2(maskmovdqu, Vdq, Udq)
     tcg_temp_free_ptr(arg1_ptr);
     tcg_temp_free_ptr(arg2_ptr);
 }
+GEN_INSN2(vmaskmovdqu, Vdq, Udq)
+{
+    gen_insn2(maskmovdqu, Vdq, Udq)(env, s, arg1, arg2);
+}
+
+GEN_INSN3(vmaskmovps, Vdq, Hdq, Mdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vmaskmovps, Mdq, Hdq, Vdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vmaskmovps, Vqq, Hqq, Mqq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vmaskmovps, Mqq, Hqq, Vqq)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN3(vmaskmovpd, Vdq, Hdq, Mdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vmaskmovpd, Mdq, Hdq, Vdq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vmaskmovpd, Vqq, Hqq, Mqq)
+{
+    /* XXX TODO implement this */
+}
+GEN_INSN3(vmaskmovpd, Mqq, Hqq, Vqq)
+{
+    /* XXX TODO implement this */
+}
 
 GEN_INSN2(movntps, Mdq, Vdq)
 {
     insnop_ldst(xmm, Mdq)(env, s, 1, arg2, arg1);
 }
+GEN_INSN2(vmovntps, Mdq, Vdq)
+{
+    gen_insn2(movntps, Mdq, Vdq)(env, s, arg1, arg2);
+}
+GEN_INSN2(vmovntps, Mqq, Vqq)
+{
+    gen_insn2(vmovntps, Mdq, Vdq)(env, s, arg1, arg2);
+}
+
 GEN_INSN2(movntpd, Mdq, Vdq)
 {
     insnop_ldst(xmm, Mdq)(env, s, 1, arg2, arg1);
 }
+GEN_INSN2(vmovntpd, Mdq, Vdq)
+{
+    gen_insn2(movntpd, Mdq, Vdq)(env, s, arg1, arg2);
+}
+GEN_INSN2(vmovntpd, Mqq, Vqq)
+{
+    gen_insn2(vmovntpd, Mdq, Vdq)(env, s, arg1, arg2);
+}
 
 GEN_INSN2(movnti, Md, Gd)
 {
@@ -6525,10 +7448,23 @@ GEN_INSN2(movntdq, Mdq, Vdq)
 {
     insnop_ldst(xmm, Mdq)(env, s, 1, arg2, arg1);
 }
+GEN_INSN2(vmovntdq, Mdq, Vdq)
+{
+    gen_insn2(movntdq, Mdq, Vdq)(env, s, arg1, arg2);
+}
+GEN_INSN2(vmovntdq, Mqq, Vqq)
+{
+    gen_insn2(vmovntdq, Mdq, Vdq)(env, s, arg1, arg2);
+}
+
 GEN_INSN2(movntdqa, Vdq, Mdq)
 {
     insnop_ldst(xmm, Mdq)(env, s, 0, arg1, arg2);
 }
+GEN_INSN2(vmovntdqa, Vdq, Mdq)
+{
+    gen_insn2(movntdqa, Vdq, Mdq)(env, s, arg1, arg2);
+}
 
 GEN_INSN0(pause)
 {
@@ -6538,6 +7474,16 @@ GEN_INSN0(pause)
 
 DEF_GEN_INSN0_HELPER(emms, emms)
 
+GEN_INSN0(vzeroupper)
+{
+    /* XXX TODO implement this */
+}
+
+GEN_INSN0(vzeroall)
+{
+    /* XXX TODO implement this */
+}
+
 GEN_INSN2(sfence_clflush, modrm_mod, modrm)
 {
     if (arg1 == 3) {
@@ -6584,6 +7530,10 @@ GEN_INSN1(ldmxcsr, Md)
         gen_helper_ldmxcsr(cpu_env, s->tmp2_i32);
     }
 }
+GEN_INSN1(vldmxcsr, Md)
+{
+    gen_insn1(ldmxcsr, Md)(env, s, arg1);
+}
 GEN_INSN1(stmxcsr, Md)
 {
     if ((s->flags & HF_EM_MASK) || !(s->flags & HF_OSFXSR_MASK)) {
@@ -6596,6 +7546,10 @@ GEN_INSN1(stmxcsr, Md)
         tcg_gen_qemu_st_i32(s->tmp2_i32, arg1, s->mem_index, MO_LEUL);
     }
 }
+GEN_INSN1(vstmxcsr, Md)
+{
+    gen_insn1(stmxcsr, Md)(env, s, arg1);
+}
 
 GEN_INSN1(prefetcht0, Mb)
 {
-- 
2.20.1


