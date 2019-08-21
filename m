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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC7C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845C52082F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvL9pH30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845C52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Uwk-0001W4-HF
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URT-0001PL-C5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URR-0007mp-Vt
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:39 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:40392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URR-0007mZ-Rx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:37 -0400
Received: by mail-yw1-xc41.google.com with SMTP id z64so1236900ywe.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e7TSPLQJppV2kJSUSSJUOZp4SK6UfMc7HuT2qa4iFuk=;
 b=bvL9pH30UdHSfjqzq9uEuoTrBCg+OVGZRZUZJO2fcv6LHsdjitAQby7vqyg42I73Ap
 QB3jCUoSmm5C0Fqu2GokCTPYuHIQKo7Sri2LsfKI89Sl+bwWuOOtIbVJeby7isMKPhKk
 Cxzqn4q2UO+yWT1e5ErpC1v0fOU9JVBzVjYH+SN/pzAeW6jOrS4563uI52w0nB7BVZG6
 itaY04VfkByVW4dkDovnFDdYnQy6IZA1ORSzfaSSJU9zfrZvIDFOBh+/7xF37oJqYpOO
 u3TpOSdXWl2BLXU0jCs4tmoya9mr3zjk6mE2nXb1AdJSjmgT79kRd/19W2yHyj1Flt5G
 tD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e7TSPLQJppV2kJSUSSJUOZp4SK6UfMc7HuT2qa4iFuk=;
 b=ZepMKaRLjp6cUOGhjaBFBfo6SjXCO3+f60L2JzUkGWDWCImPqBEcxsXpzR69QRvpsE
 HlS5jLZVcxOdaCtiCyM9E9SZtlWImrO+GJYzg2+hPOR5yCN7O/7ov0beidVnyTUH4xew
 KAhz9ICt4DqIa9BxOdH6nB3U8KB6qoHrEhojMxX43VIclAQaE1Kqbo6nFHt59JLnBicd
 gFCvd7LmyQjH3ZdPj+qOnuei50GUmY1jCnnH9qOvqiGDI8medjLroWxKhE/kfH1bYP4D
 gloG5q7ttl3v2KySfMRVTkgObdIoUk8EfiM6g/f6TnFpPWK/YuFjvPucdQHzmiHATl5y
 wn5w==
X-Gm-Message-State: APjAAAXST6envxKeJyQp2GO0YC8lNtH+SwrDp8WlpIn6vAcnREqePItY
 L/Fn3gyW/7FEdj8lh7gTM7ypOu8A
X-Google-Smtp-Source: APXvYqz8iPJ486nXZBSSij+afjOnO1NdFydOM/wRoVOMHiKXA87XavabpN2QQIugtsgnHsOa7g88Qg==
X-Received: by 2002:a81:5ed7:: with SMTP id s206mr2104333ywb.441.1566408636959; 
 Wed, 21 Aug 2019 10:30:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:36 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:13 -0400
Message-Id: <20190821172951.15333-38-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RFC PATCH v4 37/75] target/i386: introduce MMX code
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
 target/i386/translate.c | 100 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 96ba0f5704..fdfca03071 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5562,6 +5562,106 @@ INSNOP_LDST(xmm, Mhq)
         gen_gvec_ ## gvec(arg1, arg2, arg3, arg4, ## __VA_ARGS__);      \
     }
 
+GEN_INSN2(movq, Pq, Eq);        /* forward declaration */
+GEN_INSN2(movd, Pq, Ed)
+{
+    const insnop_arg_t(Eq) arg2_r64 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(arg2_r64, arg2);
+    gen_insn2(movq, Pq, Eq)(env, s, arg1, arg2_r64);
+    tcg_temp_free_i64(arg2_r64);
+}
+GEN_INSN2(movd, Ed, Pq)
+{
+    tcg_gen_ld_i32(arg1, cpu_env, arg2 + offsetof(MMXReg, MMX_L(0)));
+}
+
+GEN_INSN2(movq, Pq, Eq)
+{
+    tcg_gen_st_i64(arg2, cpu_env, arg1 + offsetof(MMXReg, MMX_Q(0)));
+}
+GEN_INSN2(movq, Eq, Pq)
+{
+    tcg_gen_ld_i64(arg1, cpu_env, arg2 + offsetof(MMXReg, MMX_Q(0)));
+}
+
+DEF_GEN_INSN2_GVEC(movq, Pq, Qq, mov, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN2_GVEC(movq, Qq, Pq, mov, MM_OPRSZ, MM_MAXSZ, MO_64)
+
+DEF_GEN_INSN3_GVEC(paddb, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(paddw, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(paddd, Pq, Pq, Qq, add, MM_OPRSZ, MM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(paddsb, Pq, Pq, Qq, ssadd, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(paddsw, Pq, Pq, Qq, ssadd, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(paddusb, Pq, Pq, Qq, usadd, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(paddusw, Pq, Pq, Qq, usadd, MM_OPRSZ, MM_MAXSZ, MO_16)
+
+DEF_GEN_INSN3_GVEC(psubb, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(psubw, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(psubd, Pq, Pq, Qq, sub, MM_OPRSZ, MM_MAXSZ, MO_32)
+DEF_GEN_INSN3_GVEC(psubsb, Pq, Pq, Qq, sssub, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(psubsw, Pq, Pq, Qq, sssub, MM_OPRSZ, MM_MAXSZ, MO_16)
+DEF_GEN_INSN3_GVEC(psubusb, Pq, Pq, Qq, ussub, MM_OPRSZ, MM_MAXSZ, MO_8)
+DEF_GEN_INSN3_GVEC(psubusw, Pq, Pq, Qq, ussub, MM_OPRSZ, MM_MAXSZ, MO_16)
+
+DEF_GEN_INSN3_HELPER_EPP(pmullw, pmullw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmulhw, pmulhw_mmx, Pq, Pq, Qq)
+DEF_GEN_INSN3_HELPER_EPP(pmaddwd, pmaddwd_mmx, Pq, Pq, Qq)
+
+DEF_GEN_INSN3_GVEC(pcmpeqb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(pcmpeqw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(pcmpeqd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_EQ)
+DEF_GEN_INSN3_GVEC(pcmpgtb, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_8, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(pcmpgtw, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_16, TCG_COND_GT)
+DEF_GEN_INSN3_GVEC(pcmpgtd, Pq, Pq, Qq, cmp, MM_OPRSZ, MM_MAXSZ, MO_32, TCG_COND_GT)
+
+DEF_GEN_INSN3_GVEC(pand, Pq, Pq, Qq, and, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(pandn, Pq, Pq, Qq, andn, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(por, Pq, Pq, Qq, or, MM_OPRSZ, MM_MAXSZ, MO_64)
+DEF_GEN_INSN3_GVEC(pxor, Pq, Pq, Qq, xor, MM_OPRSZ, MM_MAXSZ, MO_64)
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
+
 /*
  * Instruction translators
  */
-- 
2.20.1


