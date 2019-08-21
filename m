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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96916C3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658D322D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMZUZ9jH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658D322D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V7y-0000QX-0Z
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URM-0001Fp-5E
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URK-0007dS-LM
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:32 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:36301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URK-0007d2-ET
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:30 -0400
Received: by mail-yb1-xb43.google.com with SMTP id m9so1348822ybm.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6bOlBMUzHxMY+ckeyPeMo2G/Pj7vU+8jQz+taX0+9kU=;
 b=gMZUZ9jHX3S2XhvcYCTmxCN0gfPyfHVzgBP+D8FC3f6t9rKeyLwObycra7v2X16oPo
 jWgdGLb8BjO3+zyZ5DTXgq6pmB5hBjc9GPU/ISZTb0LkUq2klo85VlZmLXpHvz+hF1Ln
 SzE7jzKbJnFdYUm5XqCNtC0qI2bT666F+o1+ibAsFtL8l/zEAD2MEb7msBq3pl4jz4D5
 L2cgrJm+VleSFiO2pwsx7urlEn9dXPBagqeFagScdWK/JAiengdeSGoICeuugaOO+ynX
 F0vHm3phDmn29+lnyzVJppDD0ZWHPGA0lR80Z+ve05OaXNaahHbHgHRR5iLRlL6+RA86
 zFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6bOlBMUzHxMY+ckeyPeMo2G/Pj7vU+8jQz+taX0+9kU=;
 b=FPNflBtgrjb2qiQ4CWkIg9jCVHdsQOZHlM6Lr6Cdvs48aJmdqGLKc2cCamLfhR/0mr
 +E8aVThWcEs1HmvbAa7DCA4XmD3pczRAv6MX2LxLJfqZRUQ7ty+ND2iqlvN3QffSntL7
 yCPuUt3wx9TVwAd6K8Wo434ge8SdKmlmjS7t3Us7lNkbEdIo8d0L4uHkb5KNrlfKDnkI
 coY/rFHLrkys8ggFGJfFtojPvKMot9ZanLDeOQzIR8ID3jgodzqDkvQ5ucy3TD4e4XtC
 VWdoDK/h2mEzlH/LW/iBKXIzStqte8mwKTvYbFWGQUoOHGRY/GGY73AcHApCL82RwtTG
 /11Q==
X-Gm-Message-State: APjAAAU1H2AlC7DPlEsXf3VwzUNmTZ6wfkfGafpsWXdcazJhkS+yyoo7
 gufITJhoacprJ+JNN0cQJQWBfO5J
X-Google-Smtp-Source: APXvYqxm4sG/ZZJLAtV2ziLHlGvY4p3YzW0zIsUDNwUmFhkqAyUpwHMEcEnvlEiG5fN4yuQHqpD5jg==
X-Received: by 2002:a25:324b:: with SMTP id y72mr12447519yby.361.1566408629759; 
 Wed, 21 Aug 2019 10:30:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:29 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:05 -0400
Message-Id: <20190821172951.15333-30-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 29/75] target/i386: introduce H*, L*, V*,
 U*, W* (SSE/AVX) operands
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

These address the SSE/AVX-technology register file. Offset of the
entire corresponding register is passed as the operand value,
regardless of operand-size suffix.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 220 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 220 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 815354f12b..23ba1d5edd 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4941,6 +4941,7 @@ DEF_INSNOP_ALIAS(Mb, M)
 DEF_INSNOP_ALIAS(Mw, M)
 DEF_INSNOP_ALIAS(Md, M)
 DEF_INSNOP_ALIAS(Mq, M)
+DEF_INSNOP_ALIAS(Mhq, M)
 DEF_INSNOP_ALIAS(Mdq, M)
 DEF_INSNOP_ALIAS(Mqq, M)
 
@@ -5112,6 +5113,225 @@ INSNOP_LDST(mm, Mq)
     tcg_temp_free_i64(r64);
 }
 
+/*
+ * vex_v
+ *
+ * Operand whose value is the VVVV field of the VEX prefix.
+ */
+typedef int insnop_arg_t(vex_v);
+typedef struct {} insnop_ctxt_t(vex_v);
+
+INSNOP_INIT(vex_v)
+{
+    return s->prefix & PREFIX_VEX;
+}
+INSNOP_PREPARE(vex_v)
+{
+    return s->vex_v;
+}
+INSNOP_FINALIZE(vex_v)
+{
+}
+
+/*
+ * is4
+ *
+ * Upper 4 bits of the 8-bit immediate selector, used with the SSE/AVX
+ * register file in some instructions.
+ */
+typedef int insnop_arg_t(is4);
+typedef struct {
+    insnop_ctxt_t(Ib) ctxt_Ib;
+    insnop_arg_t(Ib) arg_Ib;
+} insnop_ctxt_t(is4);
+
+INSNOP_INIT(is4)
+{
+    return insnop_init(Ib)(&ctxt->ctxt_Ib, env, s, modrm, is_write);
+}
+INSNOP_PREPARE(is4)
+{
+    ctxt->arg_Ib = insnop_prepare(Ib)(&ctxt->ctxt_Ib, env, s, modrm, is_write);
+    return (ctxt->arg_Ib >> 4) & 0xf;
+}
+INSNOP_FINALIZE(is4)
+{
+    insnop_finalize(Ib)(&ctxt->ctxt_Ib, env, s, modrm, is_write, ctxt->arg_Ib);
+}
+
+/*
+ * SSE/AVX-technology registers
+ */
+typedef unsigned int insnop_arg_t(xmm);
+typedef struct {} insnop_ctxt_t(xmm);
+
+INSNOP_INIT(xmm)
+{
+    return true;
+}
+INSNOP_PREPARE(xmm)
+{
+    return offsetof(CPUX86State, xmm_t0);
+}
+INSNOP_FINALIZE(xmm)
+{
+}
+
+#define DEF_INSNOP_XMM(opT, opTxmmid)                                   \
+    typedef insnop_arg_t(xmm) insnop_arg_t(opT);                        \
+    typedef struct {                                                    \
+        insnop_ctxt_t(opTxmmid) xmmid;                                  \
+    } insnop_ctxt_t(opT);                                               \
+                                                                        \
+    INSNOP_INIT(opT)                                                    \
+    {                                                                   \
+        return insnop_init(opTxmmid)(&ctxt->xmmid, env, s, modrm, is_write); \
+    }                                                                   \
+    INSNOP_PREPARE(opT)                                                 \
+    {                                                                   \
+        const insnop_arg_t(opTxmmid) xmmid =                            \
+            insnop_prepare(opTxmmid)(&ctxt->xmmid, env, s, modrm, is_write); \
+        const insnop_arg_t(opT) arg =                                   \
+            offsetof(CPUX86State, xmm_regs[xmmid]);                     \
+        insnop_finalize(opTxmmid)(&ctxt->xmmid, env, s,                 \
+                                  modrm, is_write, xmmid);              \
+        return arg;                                                     \
+    }                                                                   \
+    INSNOP_FINALIZE(opT)                                                \
+    {                                                                   \
+    }
+
+DEF_INSNOP_XMM(V, modrm_reg)
+DEF_INSNOP_ALIAS(Vd, V)
+DEF_INSNOP_ALIAS(Vq, V)
+DEF_INSNOP_ALIAS(Vdq, V)
+DEF_INSNOP_ALIAS(Vqq, V)
+
+DEF_INSNOP_XMM(U, modrm_rm_direct)
+DEF_INSNOP_ALIAS(Ub, U)
+DEF_INSNOP_ALIAS(Uw, U)
+DEF_INSNOP_ALIAS(Ud, U)
+DEF_INSNOP_ALIAS(Uq, U)
+DEF_INSNOP_ALIAS(Udq, U)
+DEF_INSNOP_ALIAS(Uqq, U)
+
+DEF_INSNOP_XMM(H, vex_v)
+DEF_INSNOP_ALIAS(Hd, H)
+DEF_INSNOP_ALIAS(Hq, H)
+DEF_INSNOP_ALIAS(Hdq, H)
+DEF_INSNOP_ALIAS(Hqq, H)
+
+DEF_INSNOP_XMM(L, is4)
+DEF_INSNOP_ALIAS(Ldq, L)
+DEF_INSNOP_ALIAS(Lqq, L)
+
+DEF_INSNOP_LDST(MWb, xmm, Mb)
+DEF_INSNOP_LDST(MWw, xmm, Mw)
+DEF_INSNOP_LDST(MWd, xmm, Md)
+DEF_INSNOP_LDST(MWq, xmm, Mq)
+DEF_INSNOP_LDST(MWdq, xmm, Mdq)
+DEF_INSNOP_LDST(MWqq, xmm, Mqq)
+DEF_INSNOP_LDST(MUdqMhq, xmm, Mhq)
+DEF_INSNOP_EITHER(Wb, Ub, MWb)
+DEF_INSNOP_EITHER(Ww, Uw, MWw)
+DEF_INSNOP_EITHER(Wd, Ud, MWd)
+DEF_INSNOP_EITHER(Wq, Uq, MWq)
+DEF_INSNOP_EITHER(Wdq, Udq, MWdq)
+DEF_INSNOP_EITHER(Wqq, Uqq, MWqq)
+DEF_INSNOP_EITHER(UdqMq, Udq, MWq)
+DEF_INSNOP_EITHER(UdqMhq, Udq, MUdqMhq)
+
+INSNOP_LDST(xmm, Mb)
+{
+    const insnop_arg_t(xmm) ofs = offsetof(ZMMReg, ZMM_B(0));
+    const TCGv_i32 r32 = tcg_temp_new_i32();
+    if (is_write) {
+        tcg_gen_ld_i32(r32, cpu_env, arg + ofs);
+        tcg_gen_qemu_st_i32(r32, ptr, s->mem_index, MO_UB);
+    } else {
+        tcg_gen_qemu_ld_i32(r32, ptr, s->mem_index, MO_UB);
+        tcg_gen_st_i32(r32, cpu_env, arg + ofs);
+    }
+    tcg_temp_free_i32(r32);
+}
+INSNOP_LDST(xmm, Mw)
+{
+    const insnop_arg_t(xmm) ofs = offsetof(ZMMReg, ZMM_W(0));
+    const TCGv_i32 r32 = tcg_temp_new_i32();
+    if (is_write) {
+        tcg_gen_ld_i32(r32, cpu_env, arg + ofs);
+        tcg_gen_qemu_st_i32(r32, ptr, s->mem_index, MO_LEUW);
+    } else {
+        tcg_gen_qemu_ld_i32(r32, ptr, s->mem_index, MO_LEUW);
+        tcg_gen_st_i32(r32, cpu_env, arg + ofs);
+    }
+    tcg_temp_free_i32(r32);
+}
+INSNOP_LDST(xmm, Md)
+{
+    const insnop_arg_t(xmm) ofs = offsetof(ZMMReg, ZMM_L(0));
+    const TCGv_i32 r32 = tcg_temp_new_i32();
+    if (is_write) {
+        tcg_gen_ld_i32(r32, cpu_env, arg + ofs);
+        tcg_gen_qemu_st_i32(r32, ptr, s->mem_index, MO_LEUL);
+    } else {
+        tcg_gen_qemu_ld_i32(r32, ptr, s->mem_index, MO_LEUL);
+        tcg_gen_st_i32(r32, cpu_env, arg + ofs);
+    }
+    tcg_temp_free_i32(r32);
+}
+INSNOP_LDST(xmm, Mq)
+{
+    const insnop_arg_t(xmm) ofs = offsetof(ZMMReg, ZMM_Q(0));
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    if (is_write) {
+        tcg_gen_ld_i64(r64, cpu_env, arg + ofs);
+        tcg_gen_qemu_st_i64(r64, ptr, s->mem_index, MO_LEQ);
+    } else {
+        tcg_gen_qemu_ld_i64(r64, ptr, s->mem_index, MO_LEQ);
+        tcg_gen_st_i64(r64, cpu_env, arg + ofs);
+    }
+    tcg_temp_free_i64(r64);
+}
+INSNOP_LDST(xmm, Mdq)
+{
+    const insnop_arg_t(xmm) ofs = offsetof(ZMMReg, ZMM_Q(0));
+    const insnop_arg_t(xmm) ofs1 = offsetof(ZMMReg, ZMM_Q(1));
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    const TCGv ptr1 = tcg_temp_new();
+    tcg_gen_addi_tl(ptr1, ptr, sizeof(uint64_t));
+    if (is_write) {
+        tcg_gen_ld_i64(r64, cpu_env, arg + ofs);
+        tcg_gen_qemu_st_i64(r64, ptr, s->mem_index, MO_LEQ);
+        tcg_gen_ld_i64(r64, cpu_env, arg + ofs1);
+        tcg_gen_qemu_st_i64(r64, ptr1, s->mem_index, MO_LEQ);
+    } else {
+        tcg_gen_qemu_ld_i64(r64, ptr, s->mem_index, MO_LEQ);
+        tcg_gen_st_i64(r64, cpu_env, arg + ofs);
+        tcg_gen_qemu_ld_i64(r64, ptr1, s->mem_index, MO_LEQ);
+        tcg_gen_st_i64(r64, cpu_env, arg + ofs1);
+    }
+    tcg_temp_free_i64(r64);
+    tcg_temp_free(ptr1);
+}
+INSNOP_LDST(xmm, Mqq)
+{
+    insnop_ldst(xmm, Mdq)(env, s, is_write, arg, ptr);
+}
+INSNOP_LDST(xmm, Mhq)
+{
+    const insnop_arg_t(xmm) ofs = offsetof(ZMMReg, ZMM_Q(1));
+    const TCGv_i64 r64 = tcg_temp_new_i64();
+    if (is_write) {
+        tcg_gen_ld_i64(r64, cpu_env, arg + ofs);
+        tcg_gen_qemu_st_i64(r64, ptr, s->mem_index, MO_LEQ);
+    } else {
+        tcg_gen_qemu_ld_i64(r64, ptr, s->mem_index, MO_LEQ);
+        tcg_gen_st_i64(r64, cpu_env, arg + ofs);
+    }
+    tcg_temp_free_i64(r64);
+}
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


