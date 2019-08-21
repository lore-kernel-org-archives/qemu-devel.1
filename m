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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67207C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3191E214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwphZGUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3191E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Ve0-0002Hz-BQ
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0US1-0001vl-0l
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URz-0000Bv-Fe
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:12 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:35838)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URz-0000B7-9U
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:11 -0400
Received: by mail-yw1-xc44.google.com with SMTP id g19so1248003ywe.2
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qrd/tOzvej+7yu0bXKKIJuAV1cC6hhFiLyDQ1JmkJMo=;
 b=BwphZGUxWQedHvlzzzyK+SfZGYVtp4NJJBlDe7MxqE9sJiYUot5ttJZZo+ay6tk3SU
 6wBnby2jVdUNLUT1IpwYxoDDrFTz+It1TohgprrNriVbHO8mtt5Y553Iwtt/+Sv54xUh
 Bg+zOLC0/kMQ7rn8qugEAn3zbXYpHtl3XkB3+s+zIhVgX03IGTKvSEM8QxbY/SwUGQFW
 fXOFHBvqsCjhI2QBMzEQFbHw5+u7CoEtJMHtW/y/caCrjNFIzS3pxq6YdxMQ9AyKG/kV
 6ODtWb4iJo2rJk6Z6EiT/xXVZmv47Hg51s13ROMmNcx0Rj0ZhNci9k03tnvHs96hKuqP
 +ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qrd/tOzvej+7yu0bXKKIJuAV1cC6hhFiLyDQ1JmkJMo=;
 b=B1G3t8HY1JQBocg5/B1O8ddI1fgMpK+pXxFrWzqDQ694nt75glfjWyX+uDh8R9XEP7
 J4mXL9poikRAtnEMbqcWua3rGiHvJDy7Tix3E4XgHAMVHL2tdjBiOr5Z7h/J0dTNa4lB
 fNTj5A3MlvpvVMQgmyIievxXvM7bRfno3/wKocUNLgoJtQfcOZPN01duZKpbS4kubfBM
 +BPi8UNI7z+47OpZXP5e4PN5zMy5Lf0MVV/hdGinDV/c451TqM9yD2EVQkuPkXHEaw3H
 AbmrOr9+5XrXCVjxMKnUBXB/B5n6PhG4MnSR3zjkViRPu0hA7Wr+NP7tfMujwafAG2QM
 pqgQ==
X-Gm-Message-State: APjAAAUQw+O5S1QQQAcOza+AC3St56Hyx2qdg7acb0u22bXMfVXQ6AFN
 Y+fjMJYnq38MkSZY/00XIqubcowP
X-Google-Smtp-Source: APXvYqwmfdsNRm6AP224HlUnI6oA/Qf1AzA5pxQYk6xq5Nn+zZF5gm/R8zlk/ajsf7pbVDvwSVhRPA==
X-Received: by 2002:a81:5ec2:: with SMTP id s185mr24953795ywb.35.1566408670585; 
 Wed, 21 Aug 2019 10:31:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:31:10 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:49 -0400
Message-Id: <20190821172951.15333-74-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v4 73/75] target/i386: remove obsoleted
 helper_mov(l, q)_mm_T0
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

This helper has been obsoleted by the new code.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/ops_sse.h        | 19 -------------------
 target/i386/ops_sse_header.h |  4 ----
 target/i386/translate.c      | 33 ---------------------------------
 3 files changed, 56 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index b866ead1c8..8172324e34 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -550,25 +550,6 @@ void glue(helper_maskmov, SUFFIX)(CPUX86State *env, Reg *a, Reg *b,
     }
 }
 
-void glue(helper_movl_mm_T0, SUFFIX)(Reg *d, uint32_t val)
-{
-    d->L(0) = val;
-    d->L(1) = 0;
-#if SHIFT == 1
-    d->Q(1) = 0;
-#endif
-}
-
-#ifdef TARGET_X86_64
-void glue(helper_movq_mm_T0, SUFFIX)(Reg *d, uint64_t val)
-{
-    d->Q(0) = val;
-#if SHIFT == 1
-    d->Q(1) = 0;
-#endif
-}
-#endif
-
 #if SHIFT == 0
 void glue(helper_pshufw, SUFFIX)(Reg *d, Reg *s, int order)
 {
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index ec7d1fc686..ee8bd4c1af 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -76,10 +76,6 @@ DEF_HELPER_4(glue(pmaddwd, SUFFIX), void, Reg, Reg, Reg, i32)
 
 DEF_HELPER_4(glue(psadbw, SUFFIX), void, Reg, Reg, Reg, i32)
 DEF_HELPER_4(glue(maskmov, SUFFIX), void, env, Reg, Reg, tl)
-DEF_HELPER_2(glue(movl_mm_T0, SUFFIX), void, Reg, i32)
-#ifdef TARGET_X86_64
-DEF_HELPER_2(glue(movq_mm_T0, SUFFIX), void, Reg, i64)
-#endif
 
 #if SHIFT == 0
 DEF_HELPER_3(glue(pshufw, SUFFIX), void, Reg, Reg, int)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 6bffbaee4c..3554086336 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3079,39 +3079,6 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
                 gen_op_st_v(s, MO_32, s->T0, s->A0);
             }
             break;
-        case 0x6e: /* movd mm, ea */
-#ifdef TARGET_X86_64
-            if (s->dflag == MO_64) {
-                gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 0);
-                tcg_gen_st_tl(s->T0, cpu_env,
-                              offsetof(CPUX86State, fpregs[reg].mmx));
-            } else
-#endif
-            {
-                gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 0);
-                tcg_gen_addi_ptr(s->ptr0, cpu_env,
-                                 offsetof(CPUX86State,fpregs[reg].mmx));
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                gen_helper_movl_mm_T0_mmx(s->ptr0, s->tmp2_i32);
-            }
-            break;
-        case 0x16e: /* movd xmm, ea */
-#ifdef TARGET_X86_64
-            if (s->dflag == MO_64) {
-                gen_ldst_modrm(env, s, modrm, MO_64, OR_TMP0, 0);
-                tcg_gen_addi_ptr(s->ptr0, cpu_env,
-                                 offsetof(CPUX86State,xmm_regs[reg]));
-                gen_helper_movq_mm_T0_xmm(s->ptr0, s->T0);
-            } else
-#endif
-            {
-                gen_ldst_modrm(env, s, modrm, MO_32, OR_TMP0, 0);
-                tcg_gen_addi_ptr(s->ptr0, cpu_env,
-                                 offsetof(CPUX86State,xmm_regs[reg]));
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                gen_helper_movl_mm_T0_xmm(s->ptr0, s->tmp2_i32);
-            }
-            break;
         case 0x6f: /* movq mm, ea */
             if (mod != 3) {
                 gen_lea_modrm(env, s, modrm);
-- 
2.20.1


