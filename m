Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4EAC32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04824208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qII2byqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04824208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37641 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5eX-0006rY-RK
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dg-0006NE-EL
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5De-0000Hf-Jy
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:28 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:36577)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5De-0000H1-EA
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:26 -0400
Received: by mail-yw1-xc42.google.com with SMTP id m11so301867ywh.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qFqxp1mdJWiFIlgrVcvkkZuxlJcRYoAmYu88MoR1zMw=;
 b=qII2byqFNdtUZ1SkdNM29p8J8eb1r/tyDggTZV9XfdR6AtxO7Vl1PQ3Q4YW5umwH+r
 dtrYPqk+iMzF8wtjuMBbmRPVNN9tzgeu2GnnvoWRnd87LZqV1iQA68bQKNlt03bKhqME
 sr3bX75MJQTNILJQdVM2nFYNb6aO3mrXNYFKsTEbSAVDFo10espAoxKvb3rJ36TpQP0d
 0YA/saXKwn5JHFBPBfDTo0JqeHaDdJTC1MhXSQ/ACy+lEpD/d+xg4YHExn5YK6/ZbLBU
 WfO4A1PqBZIzovB5YOg/M0H+KNZE6VLM5N9qrFTiFM934njgZcsYN0Z0ziSDjt/icUPj
 APWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qFqxp1mdJWiFIlgrVcvkkZuxlJcRYoAmYu88MoR1zMw=;
 b=hC03VBNuDD5ML3ewrha4ARbmTES6GtoElnxrlPRETD/BSviNIpIRnVftfwwX4NYyhx
 45kKDQZm26IfoclnnPzmWE0mTzKkKCus0v6uQn1zyljwBNVwfzGdvtNBGMkSvX0nufpC
 9+jwecXaZod+lrsyl7HOSOjOOGibSlG1zg8cwsvhy8eJzXugQ3uEJVzLodE40bv3QlKr
 ImmGUQQk52e5BUQei089Udjnwc3rKXseMwKU5eBGPDzSsoQnEGwx7M6o88qpNRhJWWWs
 xG1Ai5y0C4iz7Vp/FxRa/JatB93ETpuWY0C+zXBiG8JQuHGn8TxAIQXBnxyXahpK/Tn1
 /gUg==
X-Gm-Message-State: APjAAAXx5/g8Pq83JFaV7Eg+V2zDedFIbL+xQAFfnpHbogOo/xUZmZ+x
 +eoWZFt3goIm6nnZXbsgwNiEHbnV
X-Google-Smtp-Source: APXvYqz4aSLAjGdSb6DNQ2tcYTkUnv6QlI7KdIkwWqqpG5TXVfroDzt2WopvPVKRSwF2p7vvRtdjIQ==
X-Received: by 2002:a81:50a:: with SMTP id 10mr1586981ywf.129.1565835025604;
 Wed, 14 Aug 2019 19:10:25 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:24 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:16 -0400
Message-Id: <20190815020928.9679-35-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RFC PATCH v3 34/46] target/i386: introduce
 instruction translator macros
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

Instruction "translators" are responsible for decoding and loading
instruction operands, calling the passed-in code generator, and
storing the operands back (if applicable). Once a translator returns,
the instruction has been translated to TCG ops, hence the name.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 237 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 75652afb45..76c27d0380 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5364,6 +5364,228 @@ INSNOP_LDST(xmm_t0, Mhq)
         tcg_gen_gvec_ ## gvec(vece, arg1, arg2, arg3, oprsz, maxsz);    \
     }
 
+/*
+ * Instruction translators
+ */
+#define translate_insn(argc, ...)               \
+    glue(translate_insn, argc)(__VA_ARGS__)
+#define translate_insn0()                       \
+    translate_insn_0
+#define translate_insn1(opT1)                   \
+    translate_insn_1 ## opT1
+#define translate_insn2(opT1, opT2)             \
+    translate_insn_2 ## opT1 ## opT2
+#define translate_insn3(opT1, opT2, opT3)       \
+    translate_insn_3 ## opT1 ## opT2 ## opT3
+#define translate_insn4(opT1, opT2, opT3, opT4)         \
+    translate_insn_4 ## opT1 ## opT2 ## opT3 ## opT4
+#define translate_group(grpname)                \
+    translate_group_ ## grpname
+
+static void translate_insn0()(
+    CPUX86State *env, DisasContext *s, int modrm,
+    int ck_cpuid_feat, unsigned int argc_wr,
+    void (*gen_insn_fp)(CPUX86State *, DisasContext *))
+{
+    if (ck_cpuid(env, s, ck_cpuid_feat)) {
+        gen_illegal_opcode(s);
+        return;
+    }
+
+    (*gen_insn_fp)(env, s);
+}
+
+#define DEF_TRANSLATE_INSN1(opT1)                                       \
+    static void translate_insn1(opT1)(                                  \
+        CPUX86State *env, DisasContext *s, int modrm,                   \
+        int ck_cpuid_feat, unsigned int argc_wr,                        \
+        void (*gen_insn1_fp)(CPUX86State *, DisasContext *,             \
+                             insnop_arg_t(opT1)))                       \
+    {                                                                   \
+        insnop_ctxt_t(opT1) ctxt1;                                      \
+                                                                        \
+        const bool is_write1 = (1 <= argc_wr);                          \
+                                                                        \
+        int ret = ck_cpuid(env, s, ck_cpuid_feat);                      \
+        if (!ret) {                                                     \
+            ret = insnop_init(opT1)(&ctxt1, env, s, modrm, is_write1);  \
+        }                                                               \
+        if (!ret) {                                                     \
+            const insnop_arg_t(opT1) arg1 =                             \
+                insnop_prepare(opT1)(&ctxt1, env, s, modrm, is_write1); \
+                                                                        \
+            (*gen_insn1_fp)(env, s, arg1);                              \
+                                                                        \
+            insnop_finalize(opT1)(&ctxt1, env, s, modrm, is_write1, arg1); \
+        } else {                                                        \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+
+#define DEF_TRANSLATE_INSN2(opT1, opT2)                                 \
+    static void translate_insn2(opT1, opT2)(                            \
+        CPUX86State *env, DisasContext *s, int modrm,                   \
+        int ck_cpuid_feat, unsigned int argc_wr,                        \
+        void (*gen_insn2_fp)(CPUX86State *, DisasContext *,             \
+                             insnop_arg_t(opT1), insnop_arg_t(opT2)))   \
+    {                                                                   \
+        insnop_ctxt_t(opT1) ctxt1;                                      \
+        insnop_ctxt_t(opT2) ctxt2;                                      \
+                                                                        \
+        const bool is_write1 = (1 <= argc_wr);                          \
+        const bool is_write2 = (2 <= argc_wr);                          \
+                                                                        \
+        int ret = ck_cpuid(env, s, ck_cpuid_feat);                      \
+        if (!ret) {                                                     \
+            ret = insnop_init(opT1)(&ctxt1, env, s, modrm, is_write1);  \
+        }                                                               \
+        if (!ret) {                                                     \
+            ret = insnop_init(opT2)(&ctxt2, env, s, modrm, is_write2);  \
+        }                                                               \
+        if (!ret) {                                                     \
+            const insnop_arg_t(opT1) arg1 =                             \
+                insnop_prepare(opT1)(&ctxt1, env, s, modrm, is_write1); \
+            const insnop_arg_t(opT2) arg2 =                             \
+                insnop_prepare(opT2)(&ctxt2, env, s, modrm, is_write2); \
+                                                                        \
+            (*gen_insn2_fp)(env, s, arg1, arg2);                        \
+                                                                        \
+            insnop_finalize(opT1)(&ctxt1, env, s, modrm, is_write1, arg1); \
+            insnop_finalize(opT2)(&ctxt2, env, s, modrm, is_write2, arg2); \
+        } else {                                                        \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+
+#define DEF_TRANSLATE_INSN3(opT1, opT2, opT3)                           \
+    static void translate_insn3(opT1, opT2, opT3)(                      \
+        CPUX86State *env, DisasContext *s, int modrm,                   \
+        int ck_cpuid_feat, unsigned int argc_wr,                        \
+        void (*gen_insn3_fp)(CPUX86State *, DisasContext *,             \
+                             insnop_arg_t(opT1), insnop_arg_t(opT2),    \
+                             insnop_arg_t(opT3)))                       \
+    {                                                                   \
+        insnop_ctxt_t(opT1) ctxt1;                                      \
+        insnop_ctxt_t(opT2) ctxt2;                                      \
+        insnop_ctxt_t(opT3) ctxt3;                                      \
+                                                                        \
+        const bool is_write1 = (1 <= argc_wr);                          \
+        const bool is_write2 = (2 <= argc_wr);                          \
+        const bool is_write3 = (3 <= argc_wr);                          \
+                                                                        \
+        int ret = ck_cpuid(env, s, ck_cpuid_feat);                      \
+        if (!ret) {                                                     \
+            ret = insnop_init(opT1)(&ctxt1, env, s, modrm, is_write1);  \
+        }                                                               \
+        if (!ret) {                                                     \
+            ret = insnop_init(opT2)(&ctxt2, env, s, modrm, is_write2);  \
+        }                                                               \
+        if (!ret) {                                                     \
+            ret = insnop_init(opT3)(&ctxt3, env, s, modrm, is_write3);  \
+        }                                                               \
+        if (!ret) {                                                     \
+            const insnop_arg_t(opT1) arg1 =                             \
+                insnop_prepare(opT1)(&ctxt1, env, s, modrm, is_write1); \
+            const insnop_arg_t(opT2) arg2 =                             \
+                insnop_prepare(opT2)(&ctxt2, env, s, modrm, is_write2); \
+            const insnop_arg_t(opT3) arg3 =                             \
+                insnop_prepare(opT3)(&ctxt3, env, s, modrm, is_write3); \
+                                                                        \
+            (*gen_insn3_fp)(env, s, arg1, arg2, arg3);                  \
+                                                                        \
+            insnop_finalize(opT1)(&ctxt1, env, s, modrm, is_write1, arg1); \
+            insnop_finalize(opT2)(&ctxt2, env, s, modrm, is_write2, arg2); \
+            insnop_finalize(opT3)(&ctxt3, env, s, modrm, is_write3, arg3); \
+        } else {                                                        \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+
+#define DEF_TRANSLATE_INSN4(opT1, opT2, opT3, opT4)                     \
+    static void translate_insn4(opT1, opT2, opT3, opT4)(                \
+        CPUX86State *env, DisasContext *s, int modrm,                   \
+        int ck_cpuid_feat, unsigned int argc_wr,                        \
+        void (*gen_insn4_fp)(CPUX86State *, DisasContext *,             \
+                             insnop_arg_t(opT1), insnop_arg_t(opT2),    \
+                             insnop_arg_t(opT3), insnop_arg_t(opT4)))   \
+    {                                                                   \
+        insnop_ctxt_t(opT1) ctxt1;                                      \
+        insnop_ctxt_t(opT2) ctxt2;                                      \
+        insnop_ctxt_t(opT3) ctxt3;                                      \
+        insnop_ctxt_t(opT4) ctxt4;                                      \
+                                                                        \
+        const bool is_write1 = (1 <= argc_wr);                          \
+        const bool is_write2 = (2 <= argc_wr);                          \
+        const bool is_write3 = (3 <= argc_wr);                          \
+        const bool is_write4 = (4 <= argc_wr);                          \
+                                                                        \
+        int ret = ck_cpuid(env, s, ck_cpuid_feat);                      \
+        if (!ret) {                                                     \
+            ret = insnop_init(opT1)(&ctxt1, env, s, modrm, is_write1);  \
+        }                                                               \
+        if (!ret) {                                                     \
+            ret = insnop_init(opT2)(&ctxt2, env, s, modrm, is_write2);  \
+        }                                                               \
+        if (!ret) {                                                     \
+            ret = insnop_init(opT3)(&ctxt3, env, s, modrm, is_write3);  \
+        }                                                               \
+        if (!ret) {                                                     \
+            ret = insnop_init(opT4)(&ctxt4, env, s, modrm, is_write4);  \
+        }                                                               \
+        if (!ret) {                                                     \
+            const insnop_arg_t(opT1) arg1 =                             \
+                insnop_prepare(opT1)(&ctxt1, env, s, modrm, is_write1); \
+            const insnop_arg_t(opT2) arg2 =                             \
+                insnop_prepare(opT2)(&ctxt2, env, s, modrm, is_write2); \
+            const insnop_arg_t(opT3) arg3 =                             \
+                insnop_prepare(opT3)(&ctxt3, env, s, modrm, is_write3); \
+            const insnop_arg_t(opT4) arg4 =                             \
+                insnop_prepare(opT4)(&ctxt4, env, s, modrm, is_write4); \
+                                                                        \
+            (*gen_insn4_fp)(env, s, arg1, arg2, arg3, arg4);            \
+                                                                        \
+            insnop_finalize(opT1)(&ctxt1, env, s, modrm, is_write1, arg1); \
+            insnop_finalize(opT2)(&ctxt2, env, s, modrm, is_write2, arg2); \
+            insnop_finalize(opT3)(&ctxt3, env, s, modrm, is_write3, arg3); \
+            insnop_finalize(opT4)(&ctxt4, env, s, modrm, is_write4, arg4); \
+        } else {                                                        \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+
+#define OPCODE_GRP_BEGIN(grpname)                                       \
+    static void translate_group(grpname)(                               \
+        CPUX86State *env, DisasContext *s, int modrm)                   \
+    {                                                                   \
+        insnop_ctxt_t(modrm_reg) regctxt;                               \
+                                                                        \
+        int ret = insnop_init(modrm_reg)(&regctxt, env, s, modrm, 0);   \
+        if (!ret) {                                                     \
+            const insnop_arg_t(modrm_reg) reg =                         \
+                insnop_prepare(modrm_reg)(&regctxt, env, s, modrm, 0);  \
+                                                                        \
+            switch (reg & 7) {
+#define OPCODE_GRPMEMB(grpname, mnem, opcode, feat, fmt, ...)           \
+            case opcode:                                                \
+                translate_insn(FMT_ARGC(fmt), ## __VA_ARGS__)(          \
+                    env, s, modrm, CK_CPUID_ ## feat, FMT_ARGC_WR(fmt), \
+                    gen_insn(mnem, FMT_ARGC(fmt), ## __VA_ARGS__));     \
+                break;
+#define OPCODE_GRP_END(grpname)                                         \
+            default:                                                    \
+                ret = 1;                                                \
+                break;                                                  \
+            }                                                           \
+                                                                        \
+            insnop_finalize(modrm_reg)(&regctxt, env, s, modrm, 0, reg); \
+        }                                                               \
+                                                                        \
+        if (ret) {                                                      \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+#include "sse-opcode.inc.h"
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
@@ -5383,6 +5605,21 @@ static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
             | (s->prefix & PREFIX_REPNZ ? P_F2 : 0)
             | (REX_W(s) > 0 ? W_1 : W_0)) {
 
+#define LEG(p, m, w, opcode)                    \
+    case opcode | M_ ## m | P_ ## p | W_ ## w:
+#define OPCODE(mnem, cases, feat, fmt, ...)                             \
+    cases {                                                             \
+        const int modrm = 0 < FMT_ARGC(fmt) ? x86_ldub_code(env, s) : -1; \
+        translate_insn(FMT_ARGC(fmt), ## __VA_ARGS__)(                  \
+            env, s, modrm, CK_CPUID_ ## feat, FMT_ARGC_WR(fmt),         \
+            gen_insn(mnem, FMT_ARGC(fmt), ## __VA_ARGS__));             \
+    } return;
+#define OPCODE_GRP(grpname, cases)                  \
+    cases {                                         \
+        const int modrm = x86_ldub_code(env, s);    \
+        translate_group(grpname)(env, s, modrm);    \
+    } return;
+#include "sse-opcode.inc.h"
     default:
         gen_sse(env, s, b);
         return;
-- 
2.20.1


