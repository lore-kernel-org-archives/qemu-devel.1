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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A29BC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F1B217F4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 04:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saPoLzXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F1B217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwIyT-00038P-Jl
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 00:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlC-0006hi-NH
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hwIlB-0004a2-Ip
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:42 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hwIlB-0004Zu-Eh
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 00:13:41 -0400
Received: by mail-ot1-x343.google.com with SMTP id l15so140515952otn.9
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 21:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N4tHF3eRuLT2Ndh8Oa4DP4jmO01AL16MODDlTeXhk24=;
 b=saPoLzXOCpkkr5T7zjc+7BykXmpkJBsviRnxqhcd4TuB7VcWTaudFiF7JJ3jTfYdQh
 LCU39sKfziys6wYFXBkvmIRYx8vfqhxmKyXkg1upwn76uBDW2CsHh9iPPlHZbGOrSAoC
 tQSYvrUvTJHcZ2vKfkgGk2K3wvR2iDfun8Itw+gbDOPTth0MTgZzFDaML+mUceFlFwwp
 UZR2QlNo8FwsImuw1+HR9OAK20B7UbW+KU/e4SGbRW6n5+oeC1gNaGWG2U2YJXGqip22
 VuMVR158F8fVWDyKjSIoQ5xPM5p/cZAkz9u6Z+w03vhMYSOrciwSE0EbvlChHjqiIpcD
 JJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N4tHF3eRuLT2Ndh8Oa4DP4jmO01AL16MODDlTeXhk24=;
 b=ry/IoY4nupkNDs6RQz4AnATSi4IGd909nPradEHPCATYP3/1RqWbW1zi5NUEcAYA8K
 KjR4hXRngS4eZgJ6lsDDoTFRy3bT3BySeuejIf9U5OqwXLlo3KzoOutf93ckEW25tLdp
 QRjvKMnTzenCSn9jc+Ha/ryf3ODXXHU/uF6Jbp0voY8IqkPZlVp9AE1daYLaNdfvNV4F
 QNBPvXBAdUk/r3H/hDRzLD2muI5ywu1w6f/D8bmuGsDbcQq22U37y6M2FHR79Ni+nTT3
 Idpl6bsmSOlk4GctD8kSsQ3j3ofjnA6e0NL0UBApJwUbCZU4DU9E4M4v9C7XE9tgrYak
 fHEQ==
X-Gm-Message-State: APjAAAXJKw7WxQXE/KXWYAA/6ZIosRXae2aJFpVrfYHVlDtZpyyfJ5p2
 KJcu6HsaPJCcmga1OIUo0+NvmQSv
X-Google-Smtp-Source: APXvYqzc/Hqfn6Vb36rcReWX4JLF8+XGBfudWyNfWIe8EmPoTZ8G/WNxeniRxLXf1Wgj4bUguHyc0A==
X-Received: by 2002:aca:fdc3:: with SMTP id b186mr7815403oii.114.1565410420716; 
 Fri, 09 Aug 2019 21:13:40 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id f84sm33383540oig.43.2019.08.09.21.13.40
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 21:13:40 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Sat, 10 Aug 2019 00:12:50 -0400
Message-Id: <20190810041255.6820-35-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190810041255.6820-1-jan.bobek@gmail.com>
References: <20190810041255.6820-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [RFC PATCH v2 34/39] target/i386: introduce V*, U*,
 W* (SSE/AVX) operands
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
 target/i386/translate.c | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index aa6fb8b013..97614e5941 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4839,6 +4839,51 @@ INSNOP_LDST(NqMq, Nq, Mq, offsetof(CPUX86State, mmx_t0),
 INSNOP_LDST_UNIFY(Qd, Nd, NdMd)
 INSNOP_LDST_UNIFY(Qq, Nq, NqMq)
 
+/*
+ * SSE/AVX registers
+ */
+#define INSNOP_INIT_XMM(xmmid_fp)                               \
+    do {                                                        \
+        const int xmmid = xmmid_fp(env, s, modrm);              \
+        INSNOP_INIT_OK(offsetof(CPUX86State, xmm_regs[xmmid])); \
+    } while (0)
+
+#define INSNOP_XMM(opT, init_stmt)     \
+    INSNOP(opT, uint32_t,              \
+           init_stmt,                  \
+           INSNOP_PREPARE_NOOP,        \
+           INSNOP_FINALIZE_NOOP)
+
+INSNOP_XMM(V, INSNOP_INIT_XMM(decode_modrm_reg_rexr))
+INSNOP_ALIAS(Vd, V)
+INSNOP_ALIAS(Vq, V)
+INSNOP_ALIAS(Vdq, V)
+INSNOP_ALIAS(Vqq, V)
+
+INSNOP_XMM(U, INSNOP_INIT_DIRECT_ONLY(INSNOP_INIT_XMM(decode_modrm_rm_rexb)))
+INSNOP_ALIAS(Ud, U)
+INSNOP_ALIAS(Uq, U)
+INSNOP_ALIAS(Udq, U)
+INSNOP_ALIAS(Uqq, U)
+
+INSNOP_LDST(UdMd, Ud, Md, offsetof(CPUX86State, xmm_t0),
+            (assert(ptr == s->A0),
+             gen_ldd_env_A0(s, reg + offsetof(ZMMReg, ZMM_L(0)))),
+            (assert(ptr == s->A0),
+             gen_std_env_A0(s, reg + offsetof(ZMMReg, ZMM_L(0)))))
+INSNOP_LDST(UqMq, Uq, Mq, offsetof(CPUX86State, xmm_t0),
+            (assert(ptr == s->A0),
+             gen_ldq_env_A0(s, reg + offsetof(ZMMReg, ZMM_Q(0)))),
+            (assert(ptr == s->A0),
+             gen_stq_env_A0(s, reg + offsetof(ZMMReg, ZMM_Q(0)))))
+INSNOP_LDST(UdqMdq, Udq, Mdq, offsetof(CPUX86State, xmm_t0),
+            (assert(ptr == s->A0), gen_ldo_env_A0(s, reg)),
+            (assert(ptr == s->A0), gen_sto_env_A0(s, reg)))
+
+INSNOP_LDST_UNIFY(Wd, Ud, UdMd)
+INSNOP_LDST_UNIFY(Wq, Uq, UqMq)
+INSNOP_LDST_UNIFY(Wdq, Udq, UdqMdq)
+
 /*
  * Code generators
  */
-- 
2.20.1


