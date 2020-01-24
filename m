Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1D9C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69502071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAA/OUw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69502071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv8Lg-0006WH-TL
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 18:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8Fo-0004sE-N2
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8Fn-0006Gj-G5
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:44 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:38214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv8Fn-0006FK-9s
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:43 -0500
Received: by mail-pg1-x531.google.com with SMTP id a33so1897279pgm.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 15:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UyCQge1KXUAicsccNG4/t552CMDJ9UzmYHcJdartGao=;
 b=nAA/OUw8/taL8k9ueq3WwA8/0jMt6J9uHGCXCVyFueNRE3zHqMdkwnvvdRGIbX6rCR
 k6cajBM+YHyX2DxdFt57Px2pI9/g1abHMFFjW22teQU+AtbdOfnuCODK3Op7EJin4IHv
 5DjPXbFYvbZ4QK4da3YZws6p95xoNEk2AqsU/MzKyjLmVKpyzYCQCHssBqoTdLygR9NM
 bcTTdQ2fXCjMLy18bdg+8uynCY72FWETb/7Bf54ZC+wj7mDKklvvRFedVWe/qSYBgJvB
 upryRslcoAY7x/2XoV6FcqVnvwdKDUVJd7b00QZ6L2DuQ9aFWKSr6+sc6CjwhZBIKBHE
 O1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UyCQge1KXUAicsccNG4/t552CMDJ9UzmYHcJdartGao=;
 b=qEOJgU7NIqIKFP3yW+lIgiEMaT9x7IyV0LIrSszgNwHZf9H5CqK1TZJtfCLBA1Kajj
 kOvLrc1k0qllnBzySyCuIfI3IGaZGkMq9J8WiCp0clPMJh56eGmvuiwFbRCy2/sVbdKz
 M4bNtV1XOzIllTJ9XUO7NjosKWyMbtlLsewmqq4IQF9iIV82xwFkNbn5/qj8utkCS6uN
 IcMAiFQ2DWFQa8NR8nCi5z9LNgAbZkFmooWjRmzaRUzZkAp6oAsMLtlmLSzcDzKUFiaX
 IgO4XQJn4qv55YdjNHUTYhoM5V4BzPa3UrINzfHbsQoQorRbJaXn1dQDJQVMjoPuWkvy
 kk7Q==
X-Gm-Message-State: APjAAAVKWLEqQCrh1Ol1vvrlCOv4tlVgnQ8eNGQxux9rbxflkNF2P2Gy
 z5TvWZhXpcsIvumJ4x4RwT+68zczbdQ=
X-Google-Smtp-Source: APXvYqx7J7VQGSC0UN8DQSwXlvCVd6mqyTrkKrH6/hLA3eS7vCh/9ExC5w3Q0oY9LwBa66JqR3McQw==
X-Received: by 2002:a63:5220:: with SMTP id g32mr3720534pgb.116.1579908041931; 
 Fri, 24 Jan 2020 15:20:41 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id v4sm8377880pgo.63.2020.01.24.15.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 15:20:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 11/11] target/hppa: Allow, but diagnose,
 LDCW aligned only mod 4
Date: Fri, 24 Jan 2020 13:20:09 -1000
Message-Id: <20200124232009.12928-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124232009.12928-1-richard.henderson@linaro.org>
References: <20200124232009.12928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::531
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
Cc: peter.maydell@linaro.org, deller@gmx.de,
 John David Anglin <dave.anglin@bell.net>, svens@stackframe.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PA-RISC 1.1 specification says that LDCW must be aligned mod 16
or the operation is undefined.  However, real hardware only generates
an unaligned access trap for unaligned mod 4.

Match real hardware, but diagnose with GUEST_ERROR a violation of
the specification.

At the same time fix a bug in the initialization of mop, where the
size was specified twice, and another to free the zero temporary.

Tested-by: Helge Deller <deller@gmx.de>
Reported-by: Helge Deller <deller@gmx.de>
Suggested-by: John David Anglin <dave.anglin@bell.net>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h    |  2 ++
 target/hppa/op_helper.c |  9 +++++++++
 target/hppa/translate.c | 15 ++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 38d834ef6b..2d483aab58 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -17,6 +17,8 @@ DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 
+DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
+
 DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tr, env, tl, i32, i32)
 
 DEF_HELPER_FLAGS_1(loaded_fr0, TCG_CALL_NO_RWG, void, env)
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index f0516e81f1..7823706e9c 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -153,6 +153,15 @@ void HELPER(stby_e_parallel)(CPUHPPAState *env, target_ulong addr,
     do_stby_e(env, addr, val, true, GETPC());
 }
 
+void HELPER(ldc_check)(target_ulong addr)
+{
+    if (unlikely(addr & 0xf)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Undefined ldc to unaligned address mod 16: "
+                      TARGET_FMT_lx "\n", addr);
+    }
+}
+
 target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
                           uint32_t level, uint32_t want)
 {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f25927aeca..52d7bea1ea 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2942,7 +2942,7 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
 
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 {
-    MemOp mop = MO_TEUL | MO_ALIGN_16 | a->size;
+    MemOp mop = MO_TE | MO_ALIGN | a->size;
     TCGv_reg zero, dest, ofs;
     TCGv_tl addr;
 
@@ -2958,8 +2958,21 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 
     form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
              a->disp, a->sp, a->m, ctx->mmu_idx == MMU_PHYS_IDX);
+
+    /*
+     * For hppa1.1, LDCW is undefined unless aligned mod 16.
+     * However actual hardware succeeds with aligned mod 4.
+     * Detect this case and log a GUEST_ERROR.
+     *
+     * TODO: HPPA64 relaxes the over-alignment requirement
+     * with the ,co completer.
+     */
+    gen_helper_ldc_check(addr);
+
     zero = tcg_const_reg(0);
     tcg_gen_atomic_xchg_reg(dest, addr, zero, ctx->mmu_idx, mop);
+    tcg_temp_free(zero);
+
     if (a->m) {
         save_gpr(ctx, a->b, ofs);
     }
-- 
2.20.1


