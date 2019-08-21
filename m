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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEFFC3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD95A233A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 17:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNhSru+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD95A233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Usw-0004O4-P9
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 13:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URO-0001Jm-UN
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URN-0007hI-FA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:34 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:32970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URN-0007gv-9a
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:33 -0400
Received: by mail-yb1-xb43.google.com with SMTP id b16so1357194ybq.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=netrSEZQl2bmTZcuntz1QA9QFA375JtQxyUKl0B/xrw=;
 b=hNhSru+H6LBc1SmAAHNHVBMHJEiNKOVnqyBmB5iQyXXjbE60K5cxvnkYeFmZ+U2xdL
 Peq1ykFsjpnQKjMvMjzmRxgGxvm0fFKczR5pbPj4+WgXRnXXmVRAmSGOCFacB9sjftLu
 w0gFYl5clXb2HUNPEmvs8z/WFeARjBVrUzXXhFQ+nBWVe9JDBucwEbMZrHczXOj6Crl2
 vB+2m3LVXHFXw+TLKLiTLQI1i/SXrAUVDlX21gM1XWQF1XyEdcSk0M60w1mRZA9MbCZh
 +g7Rs2JxbjwikNRm6CefkswsFnI+jkwVLgZXMxxRfoZct+kFph6CGu1ic6CemrojtEf6
 6ETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=netrSEZQl2bmTZcuntz1QA9QFA375JtQxyUKl0B/xrw=;
 b=POswP5BIDzPIFMUn7+gJEkM8/CeYpDLTKSqsj8wSb5pOlwninSAEYPxDaHxzpOSyQi
 tVpM4OpZhPKEHYjLx6kVaaZ7E/04Fd+jLlj5Tpig3hs+txoEqSBbCUPeqaULkoByOmrn
 yYiMwpkBJlGR86naCOdc71S3kE3pxM2HKWjP27CBayYwCMInZV/G2BESv0omthEXD03/
 5sjmfBhr+RCrMidO3VwobMsJvgx2zzxXWnLo00ItdEOZW5l3hQEQyZgOt3riMB2+kvkd
 5aGm1VDCKt0KW/T8i7Gx2KkLLJpaX7KlyRdYtrBv+CWWkGlGSFOdjx+QsswM6VMw8cx3
 hKHw==
X-Gm-Message-State: APjAAAWHKOhBDRT3arWreJz/m88sW8eJjkxcuaSifWA6KJDdRO5D3M6P
 IPT5YGhlM3lpkzaFmMAUyxy1a7WI
X-Google-Smtp-Source: APXvYqxDpNULtr8341LbscrzcYwLwANTSsWPz3fPyiBXLLDK67xTX9UtsNK2c2jYXoZMG6uofwh9kA==
X-Received: by 2002:a25:6846:: with SMTP id d67mr25597595ybc.483.1566408632650; 
 Wed, 21 Aug 2019 10:30:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:31 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:08 -0400
Message-Id: <20190821172951.15333-33-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 32/75] target/i386: introduce
 helper-based code generator macros
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

Code generators defined using these macros rely on a helper function
(as emitted by gen_helper_*).

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 160 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 603a5b80a1..046914578b 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5377,6 +5377,166 @@ INSNOP_LDST(xmm, Mhq)
         insnop_arg_t(opT3) arg3, insnop_arg_t(opT4) arg4,       \
         insnop_arg_t(opT5) arg5)
 
+#define DEF_GEN_INSN0_HELPER(mnem, helper)      \
+    GEN_INSN0(mnem)                             \
+    {                                           \
+        gen_helper_ ## helper(cpu_env);         \
+    }
+
+#define DEF_GEN_INSN2_HELPER_EPD(mnem, helper, opT1, opT2)      \
+    GEN_INSN2(mnem, opT1, opT2)                                 \
+    {                                                           \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();           \
+                                                                \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);              \
+        gen_helper_ ## helper(cpu_env, arg1_ptr, arg2);         \
+                                                                \
+        tcg_temp_free_ptr(arg1_ptr);                            \
+    }
+#define DEF_GEN_INSN2_HELPER_DEP(mnem, helper, opT1, opT2)      \
+    GEN_INSN2(mnem, opT1, opT2)                                 \
+    {                                                           \
+        const TCGv_ptr arg2_ptr = tcg_temp_new_ptr();           \
+                                                                \
+        tcg_gen_addi_ptr(arg2_ptr, cpu_env, arg2);              \
+        gen_helper_ ## helper(arg1, cpu_env, arg2_ptr);         \
+                                                                \
+        tcg_temp_free_ptr(arg2_ptr);                            \
+    }
+#ifdef TARGET_X86_64
+#define DEF_GEN_INSN2_HELPER_EPQ(mnem, helper, opT1, opT2)      \
+    DEF_GEN_INSN2_HELPER_EPD(mnem, helper, opT1, opT2)
+#define DEF_GEN_INSN2_HELPER_QEP(mnem, helper, opT1, opT2)      \
+    DEF_GEN_INSN2_HELPER_DEP(mnem, helper, opT1, opT2)
+#else /* !TARGET_X86_64 */
+#define DEF_GEN_INSN2_HELPER_EPQ(mnem, helper, opT1, opT2)      \
+    GEN_INSN2(mnem, opT1, opT2)                                 \
+    {                                                           \
+        g_assert_not_reached();                                 \
+    }
+#define DEF_GEN_INSN2_HELPER_QEP(mnem, helper, opT1, opT2)      \
+    GEN_INSN2(mnem, opT1, opT2)                                 \
+    {                                                           \
+        g_assert_not_reached();                                 \
+    }
+#endif /* !TARGET_X86_64 */
+#define DEF_GEN_INSN2_HELPER_EPP(mnem, helper, opT1, opT2)      \
+    GEN_INSN2(mnem, opT1, opT2)                                 \
+    {                                                           \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();           \
+        const TCGv_ptr arg2_ptr = tcg_temp_new_ptr();           \
+                                                                \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);              \
+        tcg_gen_addi_ptr(arg2_ptr, cpu_env, arg2);              \
+        gen_helper_ ## helper(cpu_env, arg1_ptr, arg2_ptr);     \
+                                                                \
+        tcg_temp_free_ptr(arg1_ptr);                            \
+        tcg_temp_free_ptr(arg2_ptr);                            \
+    }
+
+#define DEF_GEN_INSN3_HELPER_EPD(mnem, helper, opT1, opT2, opT3)        \
+    GEN_INSN3(mnem, opT1, opT2, opT3)                                   \
+    {                                                                   \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();                   \
+                                                                        \
+        assert(arg1 == arg2);                                           \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);                      \
+        gen_helper_ ## helper(cpu_env, arg1_ptr, arg3);                 \
+                                                                        \
+        tcg_temp_free_ptr(arg1_ptr);                                    \
+    }
+#ifdef TARGET_X86_64
+#define DEF_GEN_INSN3_HELPER_EPQ(mnem, helper, opT1, opT2, opT3)        \
+    DEF_GEN_INSN3_HELPER_EPD(mnem, helper, opT1, opT2, opT3)
+#else /* !TARGET_X86_64 */
+#define DEF_GEN_INSN3_HELPER_EPQ(mnem, helper, opT1, opT2, opT3)        \
+    GEN_INSN3(mnem, opT1, opT2, opT3)                                   \
+    {                                                                   \
+        g_assert_not_reached();                                         \
+    }
+#endif /* !TARGET_X86_64 */
+#define DEF_GEN_INSN3_HELPER_EPP(mnem, helper, opT1, opT2, opT3)        \
+    GEN_INSN3(mnem, opT1, opT2, opT3)                                   \
+    {                                                                   \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_ptr arg3_ptr = tcg_temp_new_ptr();                   \
+                                                                        \
+        assert(arg1 == arg2);                                           \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);                      \
+        tcg_gen_addi_ptr(arg3_ptr, cpu_env, arg3);                      \
+        gen_helper_ ## helper(cpu_env, arg1_ptr, arg3_ptr);             \
+                                                                        \
+        tcg_temp_free_ptr(arg1_ptr);                                    \
+        tcg_temp_free_ptr(arg3_ptr);                                    \
+    }
+#define DEF_GEN_INSN3_HELPER_PPI(mnem, helper, opT1, opT2, opT3)        \
+    GEN_INSN3(mnem, opT1, opT2, opT3)                                   \
+    {                                                                   \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_ptr arg2_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_i32 arg3_r32 = tcg_temp_new_i32();                   \
+                                                                        \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);                      \
+        tcg_gen_addi_ptr(arg2_ptr, cpu_env, arg2);                      \
+        tcg_gen_movi_i32(arg3_r32, arg3);                               \
+        gen_helper_ ## helper(arg1_ptr, arg2_ptr, arg3_r32);            \
+                                                                        \
+        tcg_temp_free_ptr(arg1_ptr);                                    \
+        tcg_temp_free_ptr(arg2_ptr);                                    \
+        tcg_temp_free_i32(arg3_r32);                                    \
+    }
+#define DEF_GEN_INSN3_HELPER_EPPI(mnem, helper, opT1, opT2, opT3)       \
+    GEN_INSN3(mnem, opT1, opT2, opT3)                                   \
+    {                                                                   \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_ptr arg2_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_i32 arg3_r32 = tcg_temp_new_i32();                   \
+                                                                        \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);                      \
+        tcg_gen_addi_ptr(arg2_ptr, cpu_env, arg2);                      \
+        tcg_gen_movi_i32(arg3_r32, arg3);                               \
+        gen_helper_ ## helper(cpu_env, arg1_ptr, arg2_ptr, arg3_r32);   \
+                                                                        \
+        tcg_temp_free_ptr(arg1_ptr);                                    \
+        tcg_temp_free_ptr(arg2_ptr);                                    \
+        tcg_temp_free_i32(arg3_r32);                                    \
+    }
+
+#define DEF_GEN_INSN4_HELPER_PPI(mnem, helper, opT1, opT2, opT3, opT4)  \
+    GEN_INSN4(mnem, opT1, opT2, opT3, opT4)                             \
+    {                                                                   \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_ptr arg3_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_i32 arg4_r32 = tcg_temp_new_i32();                   \
+                                                                        \
+        assert(arg1 == arg2);                                           \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);                      \
+        tcg_gen_addi_ptr(arg3_ptr, cpu_env, arg3);                      \
+        tcg_gen_movi_i32(arg4_r32, arg4);                               \
+        gen_helper_ ## helper(arg1_ptr, arg3_ptr, arg4_r32);            \
+                                                                        \
+        tcg_temp_free_ptr(arg1_ptr);                                    \
+        tcg_temp_free_ptr(arg3_ptr);                                    \
+        tcg_temp_free_i32(arg4_r32);                                    \
+    }
+#define DEF_GEN_INSN4_HELPER_EPPI(mnem, helper, opT1, opT2, opT3, opT4) \
+    GEN_INSN4(mnem, opT1, opT2, opT3, opT4)                             \
+    {                                                                   \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_ptr arg3_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_i32 arg4_r32 = tcg_temp_new_i32();                   \
+                                                                        \
+        assert(arg1 == arg2);                                           \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);                      \
+        tcg_gen_addi_ptr(arg3_ptr, cpu_env, arg3);                      \
+        tcg_gen_movi_i32(arg4_r32, arg4);                               \
+        gen_helper_ ## helper(cpu_env, arg1_ptr, arg3_ptr, arg4_r32);   \
+                                                                        \
+        tcg_temp_free_ptr(arg1_ptr);                                    \
+        tcg_temp_free_ptr(arg3_ptr);                                    \
+        tcg_temp_free_i32(arg4_r32);                                    \
+    }
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


