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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF85C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16501208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixz3l+hQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16501208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5ih-0003mL-TK
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dh-0006On-E4
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Df-0000JW-Vr
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:29 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:35390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Df-0000Is-OS
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:27 -0400
Received: by mail-yw1-xc43.google.com with SMTP id g19so303346ywe.2
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Oa5aZEs83L472CM0YZbfZrmUS/bt8pTnh7Q8gJGZz9w=;
 b=Ixz3l+hQ66tm6CAXUOzoGjlXs/GoTQEQX/Nn+U/pAZvkm/fFNvr5TP5xe+0oJVht5M
 1Y/st4M1lDJrRyRhBzDqf+/pRDiul//iC/akQSFhlA7ypvoYs5f7nvp91x1ZKh7u8feo
 MXQQLsk39GKlpe/y2/FPm+92Junn6epSLkpTTawmPbQ6F5iQlqOvxU1m9+Atv8kfPIwn
 g6b527qta73zvsl78COtxA7zF4qVxDo4KtKfbbTWGt9H/jWNVfVZ56Siw8eUdmf4r9I0
 V610rCJJGtiu6hHgLY7Y12eksV07VnSHK1kihxIqjBSqacjfeaPwW60W5TMN3L8cutqu
 Qmkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Oa5aZEs83L472CM0YZbfZrmUS/bt8pTnh7Q8gJGZz9w=;
 b=XoQ/kTxdPHC2AJSfRvUV4k6tqwxgKNwIxllDKW6C9uF/p/Gfr0bYmvW622sLuoSgD8
 Dh3TS7mnPoVCddO4kMdc023dcU4G9kMjcMfMYszWoaq6sAUNLUXdtwsKyuI4a0Etg7mq
 86nhFXKk9MPLqHI+ouiwpOstmRDgxGkdKhxyNGpzlwJmkwOT+k96mCIU5qkikU68KgjA
 e0viyPnW9yCp4Kk6JeZ9TAheMaipPOcmlkBHpW469sRhctaSBcVfADOQknXwLtfQybQU
 wdgEgWz7ge6FHLQwnc79cjJU/c1kfbH/dt8/kIJ6A5BYyTsePp8efbTzJBQCtCQ149MV
 vbjg==
X-Gm-Message-State: APjAAAX5BVLQGKPqZELaV0aPP34ULZN6SYqVHpw/hbmd0KHdM27YWQ6l
 XqVFsGgVgzOoGIV5e/rHSfl+tUt0
X-Google-Smtp-Source: APXvYqzJqIjXyThj9CBBPRByG9eh0pyygxiwsdVZXPmXu6eqZ0CwXRdW3oTbSoI4fx1sAQPQIUJREA==
X-Received: by 2002:a0d:c841:: with SMTP id k62mr1513667ywd.95.1565835027092; 
 Wed, 14 Aug 2019 19:10:27 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:26 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:18 -0400
Message-Id: <20190815020928.9679-37-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RFC PATCH v3 36/46] target/i386: introduce MMX code
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

Define code generators required for MMX instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 111 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 4fecb0d240..a02e9cd0d2 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5357,12 +5357,123 @@ INSNOP_LDST(xmm_t0, Mhq)
     {                                                                   \
         tcg_gen_gvec_ ## gvec(vece, arg1, arg2, oprsz, maxsz);          \
     }
+#define DEF_GEN_INSN2_GVEC_MM(mnem, gvec, opT1, opT2, vece)       \
+    DEF_GEN_INSN2_GVEC(mnem, gvec, opT1, opT2, vece,              \
+                       sizeof(MMXReg), sizeof(MMXReg))
 
 #define DEF_GEN_INSN3_GVEC(mnem, gvec, opT1, opT2, opT3, vece, oprsz, maxsz) \
     GEN_INSN3(mnem, opT1, opT2, opT3)                                   \
     {                                                                   \
         tcg_gen_gvec_ ## gvec(vece, arg1, arg2, arg3, oprsz, maxsz);    \
     }
+#define DEF_GEN_INSN3_GVEC_MM(mnem, gvec, opT1, opT2, opT3, vece)   \
+    DEF_GEN_INSN3_GVEC(mnem, gvec, opT1, opT2, opT3, vece,          \
+                       sizeof(MMXReg), sizeof(MMXReg))
+
+GEN_INSN2(movq, Pq, Eq);        /* forward declaration */
+GEN_INSN2(movd, Pq, Ed)
+{
+    const insnop_arg_t(Eq) arg2_r64 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(arg2_r64, arg2);
+    gen_insn2(movq, Pq, Eq)(env, s, arg1, arg2_r64);
+    tcg_temp_free_i64(arg2_r64);
+}
+
+GEN_INSN2(movd, Ed, Pq)
+{
+    const insnop_arg_t(Pq) ofs = offsetof(MMXReg, MMX_L(0));
+    tcg_gen_ld_i32(arg1, cpu_env, arg2 + ofs);
+}
+
+GEN_INSN2(movq, Pq, Eq)
+{
+    const insnop_arg_t(Pq) ofs = offsetof(MMXReg, MMX_Q(0));
+    tcg_gen_st_i64(arg2, cpu_env, arg1 + ofs);
+}
+
+GEN_INSN2(movq, Eq, Pq)
+{
+    const insnop_arg_t(Pq) ofs = offsetof(MMXReg, MMX_Q(0));
+    tcg_gen_ld_i64(arg1, cpu_env, arg2 + ofs);
+}
+
+DEF_GEN_INSN2_GVEC_MM(movq, mov, Pq, Qq, MO_64)
+DEF_GEN_INSN2_GVEC_MM(movq, mov, Qq, Pq, MO_64)
+
+DEF_GEN_INSN3_GVEC_MM(paddb, add, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_MM(paddw, add, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_MM(paddd, add, Pq, Pq, Qq, MO_32)
+DEF_GEN_INSN3_GVEC_MM(paddsb, ssadd, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_MM(paddsw, ssadd, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_MM(paddusb, usadd, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_MM(paddusw, usadd, Pq, Pq, Qq, MO_16)
+
+DEF_GEN_INSN3_GVEC_MM(psubb, sub, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_MM(psubw, sub, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_MM(psubd, sub, Pq, Pq, Qq, MO_32)
+DEF_GEN_INSN3_GVEC_MM(psubsb, sssub, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_MM(psubsw, sssub, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_MM(psubusb, ussub, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_MM(psubusw, ussub, Pq, Pq, Qq, MO_16)
+
+DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
+
+DEF_GEN_INSN3_GVEC_MM(pcmpeqb, cmpeq, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_MM(pcmpeqw, cmpeq, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_MM(pcmpeqd, cmpeq, Pq, Pq, Qq, MO_32)
+DEF_GEN_INSN3_GVEC_MM(pcmpgtb, cmpgt, Pq, Pq, Qq, MO_8)
+DEF_GEN_INSN3_GVEC_MM(pcmpgtw, cmpgt, Pq, Pq, Qq, MO_16)
+DEF_GEN_INSN3_GVEC_MM(pcmpgtd, cmpgt, Pq, Pq, Qq, MO_32)
+
+DEF_GEN_INSN3_GVEC_MM(pand, and, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_MM(pandn, andn, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_MM(por, or, Pq, Pq, Qq, MO_64)
+DEF_GEN_INSN3_GVEC_MM(pxor, xor, Pq, Pq, Qq, MO_64)
+
+DEF_GEN_INSN3_HELPER_EPP(psllw, psllw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pslld, pslld_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psllq, psllq_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrlw, psrlw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrld, psrld_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrlq, psrlq_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psraw, psraw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(psrad, psrad_mmx, Pq, Pq, Qq)
+
+#define DEF_GEN_PSHIFT_IMM_MM(mnem, opT1, opT2)                         \
+    GEN_INSN3(mnem, opT1, opT2, Ib)                                     \
+    {                                                                   \
+        const uint64_t arg3_ui64 = (uint8_t)arg3;                       \
+        const insnop_arg_t(Eq) arg3_r64 = s->tmp1_i64;                  \
+        const insnop_arg_t(Qq) arg3_mm =                                \
+            offsetof(CPUX86State, mmx_t0.MMX_Q(0));                     \
+                                                                        \
+        tcg_gen_movi_i64(arg3_r64, arg3_ui64);                          \
+        gen_insn2(movq, Pq, Eq)(env, s, arg3_mm, arg3_r64);             \
+        gen_insn3(mnem, Pq, Pq, Qq)(env, s, arg1, arg2, arg3_mm);       \
+    }
+
+DEF_GEN_PSHIFT_IMM_MM(psllw, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_MM(pslld, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_MM(psllq, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_MM(psrlw, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_MM(psrld, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_MM(psrlq, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_MM(psraw, Nq, Nq)
+DEF_GEN_PSHIFT_IMM_MM(psrad, Nq, Nq)
+
+DEF_GEN_INSN3_HELPER_EPP(packsswb, packsswb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(packssdw, packssdw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(packuswb, packuswb_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(punpcklbw, punpcklbw_mmx, Pq, Pq, Qd)
+DEF_GEN_INSN3_HELPER_EPP(punpcklwd, punpcklwd_mmx, Pq, Pq, Qd)
+DEF_GEN_INSN3_HELPER_EPP(punpckldq, punpckldq_mmx, Pq, Pq, Qd)
+DEF_GEN_INSN3_HELPER_EPP(punpckhbw, punpckhbw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(punpckhwd, punpckhwd_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(punpckhdq, punpckhdq_mmx, Pq, Pq, Qq)
+
+DEF_GEN_INSN0_HELPER(emms, emms)
 
 /*
  * Instruction translators
-- 
2.20.1


