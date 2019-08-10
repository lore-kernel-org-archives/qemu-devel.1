Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A8BC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71934217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0GOzEG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71934217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIyY-0003Gf-Ph
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34864)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl2-0006AA-Mk
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIl0-0004Qw-Uo
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:32 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIl0-0004Qd-Ox
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:30 -0400
Received: by mail-ot1-x342.google.com with SMTP id j19so63824774otq.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=49k4L6Ed4GjJbtEpz/mWICDG8bIJSDwKyFJ7IpyHgb4=;
 b=i0GOzEG/TuAuakcReWv4mmDO83sFXHIkf7FXrJfohVzOUo827HzJH6fXFC5WdLEAJB
 E9iWo1A5/4+gPrWKYKg2xm3q5TS/yoXuunFpmtrrnJ6sLZMufmlE1zFGtFmyb6sKQYdr
 dHkLrIcINT6vdAuw2xmpbe2chbW3IramaDlkO8+9l82v3sIuvsD3aIleQNqj1TS0APFC
 Rij9bN5MVnm+UR7PGw2dnV9zuIPTOdXkxSSL1rlcJhQeSKBM1M/DiVo/FuRJXzLaoUaE
 CZBzonHkKZ3BPi8m36ZoITGjhRYzSlIU3nKl1lVurngOwE2xLWZ75qII+pt5Ysc/y51b
 nmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=49k4L6Ed4GjJbtEpz/mWICDG8bIJSDwKyFJ7IpyHgb4=;
 b=eavyiKsFOZZrr60ki5JL1UBK0pknWF2tmjL1JZRF4sNPpceg9Gwdlb6P06K7BpEDAp
 6Ff4R+98DilEh4Rz5ULT0wdOw4xfKE9nnMsslI+znJTcQ2gFFhQZKlfTGo/2+wD+SmAH
 vVHcJboDM3sm8YHO82MSgRervMgRjdOt2bkO3Gg+W9Ay087LiymuwYucE0pDkerxQeV9
 U3WQClhmX2P/JYHRV02mROoieUaTqC7DPMqtAbyskU9Hs9fpmKaxsbs7K1vThBIi6NwO
 XolPCzC6boWhPDPCUhdxnxcsnLz1R8QnQ559nvnLyvX+6OKkDvp+cKznJ/3GDW0PuibB
 F7Qw==
X-Gm-Message-State: APjAAAU4X1WwM82LYmw97xxTmj9DufPpmVW8iST7SFGiLICiPLp3hf5j
 2hA8Fk5NK8ewuq9wyF26Az3dTWLp
X-Google-Smtp-Source: APXvYqxPFF4tz9Zij61f3Y5LXqQPZFPSsJIxpv8BdMmAKHa0sB7RYzTRS8LqbO7aPwsIA8g//GL9oQ==
X-Received: by 2002:a9d:76ce:: with SMTP id p14mr5690952otl.342.1565410409998; 
 Fri, 09 Aug 2019 21:13:29 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.29
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:29 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:39 -0400
Message-Id: <20190810041255.6820-24-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: [Qemu-devel] [RFC PATCH v2 23/39] target/i386: introduce
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
 target/i386/translate.c | 288 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 288 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 30180d1c25..0da064d5fd 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4715,6 +4715,222 @@ static int ck_cpuid(CPUX86State *env, DisasContext *s, int ck_cpuid_feat)
 #define gen_insn_wrrr(mnem, opW1, opR1, opR2, opR3)     \
     gen_ ## mnem ## _ ## opW1 ## opR1 ## opR2 ## opR3
 
+/*
+ * Instruction translators
+ */
+#define translate_insn_r(opR1)                  \
+    translate_insn_r_ ## opR1
+#define translate_insn_rr(opR1, opR2)           \
+    translate_insn_rr_ ## opR1 ## opR2
+#define translate_insn_w(opW1)                  \
+    translate_insn_w_ ## opW1
+#define translate_insn_wr(opW1, opR1)           \
+    translate_insn_wr_ ## opW1 ## opR1
+#define translate_insn_wrr(opW1, opR1, opR2)    \
+    translate_insn_wrr_ ## opW1 ## opR1 ## opR2
+#define translate_insn_wrrr(opW1, opR1, opR2, opR3)             \
+    translate_insn_wrrr_ ## opW1 ## opR1 ## opR2 ## opR3
+#define translate_group(grpname)                \
+    translate_group_ ## grpname
+
+static void translate_insn(
+    CPUX86State *env, DisasContext *s, int ck_cpuid_feat,
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
+#define TRANSLATE_INSN_R(opR1)                                          \
+    static void translate_insn_r(opR1)(                                 \
+        CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
+        void (*gen_insn_fp)(CPUX86State *, DisasContext *, insnop_t(opR1))) \
+    {                                                                   \
+        insnop_t(opR1) arg1;                                            \
+                                                                        \
+        if (ck_cpuid(env, s, ck_cpuid_feat)                             \
+            || insnop_init(opR1)(env, s, modrm, &arg1)) {               \
+            gen_illegal_opcode(s);                                      \
+            return;                                                     \
+        }                                                               \
+                                                                        \
+        insnop_prepare(opR1)(env, s, modrm, &arg1);                     \
+        (*gen_insn_fp)(env, s, arg1);                                   \
+    }
+
+#define TRANSLATE_INSN_RR(opR1, opR2)                                   \
+    static void translate_insn_rr(opR1, opR2)(                          \
+        CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
+        void (*gen_insn_fp)(CPUX86State *, DisasContext *, insnop_t(opR1), \
+                            insnop_t(opR2)))                            \
+    {                                                                   \
+        insnop_t(opR1) arg1;                                            \
+        insnop_t(opR2) arg2;                                            \
+                                                                        \
+        if (ck_cpuid(env, s, ck_cpuid_feat)                             \
+            || insnop_init(opR1)(env, s, modrm, &arg1)                  \
+            || insnop_init(opR2)(env, s, modrm, &arg2)) {               \
+            gen_illegal_opcode(s);                                      \
+            return;                                                     \
+        }                                                               \
+                                                                        \
+        insnop_prepare(opR1)(env, s, modrm, &arg1);                     \
+        insnop_prepare(opR2)(env, s, modrm, &arg2);                     \
+        (*gen_insn_fp)(env, s, arg1, arg2);                             \
+    }
+
+#define TRANSLATE_INSN_W(opW1)                                          \
+    static void translate_insn_w(opW1)(                                 \
+        CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
+        void (*gen_insn_fp)(CPUX86State *, DisasContext *, insnop_t(opW1))) \
+    {                                                                   \
+        insnop_t(opW1) ret;                                             \
+                                                                        \
+        if (ck_cpuid(env, s, ck_cpuid_feat)                             \
+            || insnop_init(opW1)(env, s, modrm, &ret)) {                \
+            gen_illegal_opcode(s);                                      \
+            return;                                                     \
+        }                                                               \
+                                                                        \
+        (*gen_insn_fp)(env, s, ret);                                    \
+        insnop_finalize(opW1)(env, s, modrm, &ret);                     \
+    }
+
+#define TRANSLATE_INSN_WR(opW1, opR1)                                   \
+    static void translate_insn_wr(opW1, opR1)(                          \
+        CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
+        void (*gen_insn_fp)(CPUX86State *, DisasContext *, insnop_t(opW1), \
+                            insnop_t(opR1)))                            \
+    {                                                                   \
+        insnop_t(opW1) ret;                                             \
+        insnop_t(opR1) arg1;                                            \
+                                                                        \
+        if (ck_cpuid(env, s, ck_cpuid_feat)                             \
+            || insnop_init(opW1)(env, s, modrm, &ret)                   \
+            || insnop_init(opR1)(env, s, modrm, &arg1)) {               \
+            gen_illegal_opcode(s);                                      \
+            return;                                                     \
+        }                                                               \
+                                                                        \
+        insnop_prepare(opR1)(env, s, modrm, &arg1);                     \
+        (*gen_insn_fp)(env, s, ret, arg1);                              \
+        insnop_finalize(opW1)(env, s, modrm, &ret);                     \
+    }
+
+#define TRANSLATE_INSN_WRR(opW1, opR1, opR2)                            \
+    static void translate_insn_wrr(opW1, opR1, opR2)(                   \
+        CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
+        void (*gen_insn_fp)(CPUX86State *, DisasContext *, insnop_t(opW1), \
+                            insnop_t(opR1), insnop_t(opR2)))            \
+    {                                                                   \
+        insnop_t(opW1) ret;                                             \
+        insnop_t(opR1) arg1;                                            \
+        insnop_t(opR2) arg2;                                            \
+                                                                        \
+        if (ck_cpuid(env, s, ck_cpuid_feat)                             \
+            || insnop_init(opW1)(env, s, modrm, &ret)                   \
+            || insnop_init(opR1)(env, s, modrm, &arg1)                  \
+            || insnop_init(opR2)(env, s, modrm, &arg2)) {               \
+            gen_illegal_opcode(s);                                      \
+            return;                                                     \
+        }                                                               \
+                                                                        \
+        insnop_prepare(opR1)(env, s, modrm, &arg1);                     \
+        insnop_prepare(opR2)(env, s, modrm, &arg2);                     \
+        (*gen_insn_fp)(env, s, ret, arg1, arg2);                        \
+        insnop_finalize(opW1)(env, s, modrm, &ret);                     \
+    }
+
+#define TRANSLATE_INSN_WRRR(opW1, opR1, opR2, opR3)                     \
+    static void translate_insn_wrrr(opW1, opR1, opR2, opR3)(            \
+        CPUX86State *env, DisasContext *s, int modrm, int ck_cpuid_feat, \
+        void (*gen_insn_fp)(CPUX86State *, DisasContext *, insnop_t(opW1), \
+                            insnop_t(opR1), insnop_t(opR2), insnop_t(opR3))) \
+    {                                                                   \
+        insnop_t(opW1) ret;                                             \
+        insnop_t(opR1) arg1;                                            \
+        insnop_t(opR2) arg2;                                            \
+        insnop_t(opR3) arg3;                                            \
+                                                                        \
+        if (ck_cpuid(env, s, ck_cpuid_feat)                             \
+            || insnop_init(opW1)(env, s, modrm, &ret)                   \
+            || insnop_init(opR1)(env, s, modrm, &arg1)                  \
+            || insnop_init(opR2)(env, s, modrm, &arg2)                  \
+            || insnop_init(opR3)(env, s, modrm, &arg3)) {               \
+            gen_illegal_opcode(s);                                      \
+            return;                                                     \
+        }                                                               \
+                                                                        \
+        insnop_prepare(opR1)(env, s, modrm, &arg1);                     \
+        insnop_prepare(opR2)(env, s, modrm, &arg2);                     \
+        insnop_prepare(opR3)(env, s, modrm, &arg3);                     \
+        (*gen_insn_fp)(env, s, ret, arg1, arg2, arg3);                  \
+        insnop_finalize(opW1)(env, s, modrm, &ret);                     \
+    }
+
+#define INSN_GRP_BEGIN(grpname)                                 \
+    static void translate_group(grpname)(                       \
+        CPUX86State *env, DisasContext *s, int modrm)           \
+    {                                                           \
+        const int reg = decode_modrm_reg_norexr(env, s, modrm); \
+                                                                \
+        switch (reg) {
+#define INSN_GRPMEMB(grpname, mnem, opcode, feat) \
+        case opcode:                              \
+            translate_insn(                       \
+                env, s, CK_CPUID_ ## feat,        \
+                gen_insn(mnem));                  \
+            return;
+#define INSN_GRPMEMB_R(grpname, mnem, opcode, feat, opR1) \
+        case opcode:                                      \
+            translate_insn_r(opR1)(                       \
+                env, s, modrm, CK_CPUID_ ## feat,         \
+                gen_insn_r(mnem, opR1));                  \
+            return;
+#define INSN_GRPMEMB_RR(grpname, mnem, opcode, feat, opR1, opR2) \
+        case opcode:                                             \
+            translate_insn_rr(opR1, opR2)(                       \
+                env, s, modrm, CK_CPUID_ ## feat,                \
+                gen_insn_rr(mnem, opR1, opR2));                  \
+            return;
+#define INSN_GRPMEMB_W(grpname, mnem, opcode, feat, opW1) \
+        case opcode:                                      \
+            translate_insn_w(opW1)(                       \
+                env, s, modrm, CK_CPUID_ ## feat,         \
+                gen_insn_w(mnem, opW1));                  \
+            return;
+#define INSN_GRPMEMB_WR(grpname, mnem, opcode, feat, opW1, opR1) \
+        case opcode:                                             \
+            translate_insn_wr(opW1, opR1)(                       \
+                env, s, modrm, CK_CPUID_ ## feat,                \
+                gen_insn_wr(mnem, opW1, opR1));                  \
+            return;
+#define INSN_GRPMEMB_WRR(grpname, mnem, opcode, feat, opW1, opR1, opR2) \
+        case opcode:                                                    \
+            translate_insn_wrr(opW1, opR1, opR2)(                       \
+                env, s, modrm, CK_CPUID_ ## feat,                       \
+                gen_insn_wrr(mnem, opW1, opR1, opR2));                  \
+            return;
+#define INSN_GRPMEMB_WRRR(grpname, mnem, opcode, feat, opW1, opR1, opR2, opR3) \
+        case opcode:                                                    \
+            translate_insn_wrrr(opW1, opR1, opR2, opR3)(                \
+                env, s, modrm, CK_CPUID_ ## feat,                       \
+                gen_insn_wrrr(mnem, opW1, opR1, opR2, opR3));           \
+            return;
+#define INSN_GRP_END(grpname)                   \
+        default:                                \
+            gen_illegal_opcode(s);              \
+            return;                             \
+        }                                       \
+                                                \
+        g_assert_not_reached();                 \
+    }
+#include "insn.h"
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
@@ -4726,15 +4942,87 @@ static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
         M_0F = 1 << (4 + 8),
     };
 
+    int modrm;
+
     switch (b | M_0F
             | (s->prefix & PREFIX_DATA ? P_66 : 0)
             | (s->prefix & PREFIX_REPZ ? P_F3 : 0)
             | (s->prefix & PREFIX_REPNZ ? P_F2 : 0)
             | (REX_W(s) > 0 ? W_1 : W_0)) {
 
+#define CASES_LEG_NP_0F_W0(opcode)              \
+    case opcode | M_0F | W_0:
+#define CASES_LEG_NP_0F_W1(opcode)              \
+    case opcode | M_0F | W_1:
+#define CASES_LEG_F3_0F_W0(opcode)              \
+    case opcode | M_0F | P_F3 | W_0:
+#define CASES_LEG_F3_0F_W1(opcode)              \
+    case opcode | M_0F | P_F3 | W_1:
+
+#define LEG(p, m, w)                            \
+    CASES_LEG_ ## p ## _ ## m ## _W ## w
+#define INSN(mnem, cases, opcode, feat)         \
+    cases(opcode)                               \
+        translate_insn(                         \
+            env, s, CK_CPUID_ ## feat,          \
+            gen_insn(mnem));                    \
+        return;
+#define INSN_R(mnem, cases, opcode, feat, opR1)      \
+    cases(opcode)                                    \
+        modrm = x86_ldub_code(env, s);               \
+        translate_insn_r(opR1)(                      \
+            env, s, modrm, CK_CPUID_ ## feat,        \
+            gen_insn_r(mnem, opR1));                 \
+        return;
+#define INSN_RR(mnem, cases, opcode, feat, opR1, opR2)       \
+    cases(opcode)                                            \
+        modrm = x86_ldub_code(env, s);                       \
+        translate_insn_rr(opR1, opR2)(                       \
+            env, s, modrm, CK_CPUID_ ## feat,                \
+            gen_insn_rr(mnem, opR1, opR2));                  \
+        return;
+#define INSN_W(mnem, cases, opcode, feat, opW1)       \
+    cases(opcode)                                     \
+        modrm = x86_ldub_code(env, s);                \
+        translate_insn_wr(opW1)(                      \
+            env, s, modrm, CK_CPUID_ ## feat,         \
+            gen_insn_wr(mnem, opW1));                 \
+        return;
+#define INSN_WR(mnem, cases, opcode, feat, opW1, opR1)      \
+    cases(opcode)                                           \
+        modrm = x86_ldub_code(env, s);                      \
+        translate_insn_wr(opW1, opR1)(                      \
+            env, s, modrm, CK_CPUID_ ## feat,               \
+            gen_insn_wr(mnem, opW1, opR1));                 \
+        return;
+#define INSN_WRR(mnem, cases, opcode, feat, opW1, opR1, opR2)       \
+    cases(opcode)                                                   \
+        modrm = x86_ldub_code(env, s);                              \
+        translate_insn_wrr(opW1, opR1, opR2)(                       \
+            env, s, modrm, CK_CPUID_ ## feat,                       \
+            gen_insn_wrr(mnem, opW1, opR1, opR2));                  \
+        return;
+#define INSN_WRRR(mnem, cases, opcode, feat, opW1, opR1, opR2, opR3)    \
+    cases(opcode)                                                   \
+        modrm = x86_ldub_code(env, s);                              \
+        translate_insn_wrrr(opW1, opR1, opR2, opR3)(                \
+            env, s, modrm, CK_CPUID_ ## feat,                       \
+            gen_insn_wrrr(mnem, opW1, opR1, opR2, opR3));           \
+        return;
+#define INSN_GRP(grpname, cases, opcode)                \
+    cases(opcode)                                       \
+        modrm = x86_ldub_code(env, s);                  \
+        translate_group(grpname)(env, s, modrm);        \
+        return;
+#include "insn.h"
     default:
         gen_sse(env, s, b);
         return;
+
+#undef CASES_LEG_NP_0F_W0
+#undef CASES_LEG_NP_0F_W1
+#undef CASES_LEG_F3_0F_W0
+#undef CASES_LEG_F3_0F_W1
     }
 
     g_assert_not_reached();
-- 
2.20.1


