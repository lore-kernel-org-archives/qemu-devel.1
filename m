Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337FCC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3206217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6a9pdWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3206217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu5vv-0000xU-3a
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pp-0001HI-Jj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pm-00020c-Nz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:37 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:34774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu5pm-00020A-IW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:34 -0500
Received: by mail-pl1-x636.google.com with SMTP id c9so2254963plo.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UyCQge1KXUAicsccNG4/t552CMDJ9UzmYHcJdartGao=;
 b=P6a9pdWhEQdsL7H5Lj0qzg+IH+4x8rzCq6HlLwto9yCm5ko8JGTHUPNv+Jk4WvN+aQ
 dBYGi9E+Q7UC11o5kuDJI9I/kBEqaekqDZQFTRJPi+RxfcrOWFDLszJRAEC5Zp2Ea5/V
 5XzTDrw65cyAAzW3fQ38l5kjj2+Zn6xx5YoD9RZ4rLy7N0JG07Nj1ujG9/6nmi796ghe
 CB+xrMu4N1t45haP4xuELs8kgripEQPBt72Z09UeZ9ZjI6B0oNm82j9OW1viUo2uhQ6b
 6Y29jSBx2YQjPwY+tIDQU8ihdgHtXOpL+UP7Qc+JCl/r025sb6zXv3tIZAEfaz8yqwPR
 gXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UyCQge1KXUAicsccNG4/t552CMDJ9UzmYHcJdartGao=;
 b=ODErJOVeu4Ilqx+uW0yymaRF1DhfevZjnuRN1oARk8MCuDatADY0JpXcoUWFuw+xVU
 jJqD8LQ+h7aZY3QhS5GvSG6I/7eTQ86PZPXTNaxlLIJTIxraV7goGPiFNTkMOSwjU2Mc
 3IDLqi/qKmlfmylUFDt/f1DRNWqcbXCEVGazzrKSKe5vJ5Y4dzfWonnhM4HZ6IGjPWr4
 e24/+kkU5+tFa2MON6Tu8fuYPLUzpD5yQHQT9r6Q0Or+pS/vbhUe0/qsDvhZIl8eyVCY
 CqkJ6/e+4L84wfmRoBoKllGEBOW8SieuK7cASHMhrPJLrAxgIqDpO2c1MnHEIL61TZ2T
 uoqQ==
X-Gm-Message-State: APjAAAXcA2aKK4yQ8nt6dKy6ENtbjQoyGHqiClbF4T+GUYoULkE9MkS9
 S3StDPBNEBs2ITrA2cfewc9t04OT3Ug=
X-Google-Smtp-Source: APXvYqzRYjNd1Vbg4edqZx/QLjqUhDMJS0jLQ0M2yd+0pNyJC9ga0i7j/2zxYM2zt6vLwqoG8fM8eA==
X-Received: by 2002:a17:902:b206:: with SMTP id
 t6mr8706584plr.211.1579660413259; 
 Tue, 21 Jan 2020 18:33:33 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id t1sm42935209pgq.23.2020.01.21.18.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:33:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] target/hppa: Allow, but diagnose, LDCW aligned only mod 4
Date: Tue, 21 Jan 2020 16:32:56 -1000
Message-Id: <20200122023256.27556-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122023256.27556-1-richard.henderson@linaro.org>
References: <20200122023256.27556-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>,
 John David Anglin <dave.anglin@bell.net>
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


