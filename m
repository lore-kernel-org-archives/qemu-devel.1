Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54660C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5E420828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCb+9M3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5E420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34Cq-0004ub-PN
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H8-0004AC-0z
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33H6-0000sm-KD
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:33 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33H5-0000pv-4m
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:32 -0400
Received: by mail-pl1-x642.google.com with SMTP id 4so388790pld.10
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gHxh7NJ9ZDQD5ad3sh/ZYrxo8RnJxM/j1QAWPCspKQ8=;
 b=jCb+9M3HZ8mMyUcbr7jvJ4BKrD6Mldz8iF22quWO5UNM3T/caBgOkNaKkOuP52mdkS
 rpSC6bnPRLSF4UbTvKiLJBnNEC7WFDphwL7+qjnRMJbc5oTuVRIohGQZmyDOKd//ok/+
 kVJ+qq/XY+xVG7Y5uOrht+zJDeYwyt6P59/kib/Pqns+ZbnC4mLU8k0tI/OQuhGfEgsN
 Sy3xYwHe0ihKhfCaLwVakpplAGcFr03tWd/8fj5d4P9xVOVzsXmmIqI7ZNBSWbrX7vMd
 w6lW6dJ97hImbuQ2TatuJdvL/ppt6ZCyHLCOXjreefGXr77s/iMcuzBQtTlHg6NnYMO2
 S9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gHxh7NJ9ZDQD5ad3sh/ZYrxo8RnJxM/j1QAWPCspKQ8=;
 b=jLeEECvhbI3WBQ3VPy6Qt7z3Z/ZXHlOpzk3VlyGyO6ZkFsa2fmZ52GtXZrNM88rgSk
 PQHT/+ZNSl+TjaeU/divPjWUw48qYpmWH7b5Jt3nGgOPGfmmQ94Plwu/5jHQnqN6lVAX
 KXhPt8QXdeEI/PsoxUBlDxPyzh/I2NDkoMcCIM+wodlzdnnKc4YywPtZ3V7qY73FC7EV
 NPmHQaiwWxSHjAD6AjtPa0SYzeeRMC1UCjr52c33oSLTXQtAvjuRtOVGMFQDdF8V+urR
 fVBkqQbnM2EDs1Cqky9zzzjt9SAlvl2X1HWnKov11oy2oRWPVMFMN8aUzlRF5Y1RmG+/
 uVxA==
X-Gm-Message-State: APjAAAUIXYZFoEjh6o3nu5VuF0jTJoXkNj5uE9yG61TAyKYDn7gkMbWs
 4yg/ObKhiNn8+TOHROdzGLSqZvnBHOE=
X-Google-Smtp-Source: APXvYqyMVJVO9vo6O1Edw5z188wJGJzrUTjqjTqXwv0ORnN/YWpuVeqSgzjuZFrUfrI6c75KZ5ftgQ==
X-Received: by 2002:a17:902:ff02:: with SMTP id
 f2mr5394995plj.99.1567019187200; 
 Wed, 28 Aug 2019 12:06:27 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:06:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:56 -0700
Message-Id: <20190828190456.30315-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v3 69/69] target/arm: Inline gen_bx_im into
 callers
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are only two remaining uses of gen_bx_im.  In each case, we
know the destination mode -- not changing in the case of gen_jmp
or changing in the case of trans_BLX_i.  Use this to simplify the
surrounding code.

For trans_BLX_i, use gen_jmp for the actual branch.  For gen_jmp,
use gen_set_pc_im to set up the single-step.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5a9a6d3a1e..253f9f4142 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -765,21 +765,6 @@ static inline void gen_set_pc_im(DisasContext *s, target_ulong val)
     tcg_gen_movi_i32(cpu_R[15], val);
 }
 
-/* Set PC and Thumb state from an immediate address.  */
-static inline void gen_bx_im(DisasContext *s, uint32_t addr)
-{
-    TCGv_i32 tmp;
-
-    s->base.is_jmp = DISAS_JUMP;
-    if (s->thumb != (addr & 1)) {
-        tmp = tcg_temp_new_i32();
-        tcg_gen_movi_i32(tmp, addr & 1);
-        tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUARMState, thumb));
-        tcg_temp_free_i32(tmp);
-    }
-    tcg_gen_movi_i32(cpu_R[15], addr & ~1);
-}
-
 /* Set PC and Thumb state from var.  var is marked as dead.  */
 static inline void gen_bx(DisasContext *s, TCGv_i32 var)
 {
@@ -2706,9 +2691,8 @@ static inline void gen_jmp (DisasContext *s, uint32_t dest)
 {
     if (unlikely(is_singlestepping(s))) {
         /* An indirect jump so that we still trigger the debug exception.  */
-        if (s->thumb)
-            dest |= 1;
-        gen_bx_im(s, dest);
+        gen_set_pc_im(s, dest);
+        s->base.is_jmp = DISAS_JUMP;
     } else {
         gen_goto_tb(s, 0, dest);
     }
@@ -10105,12 +10089,16 @@ static bool trans_BL(DisasContext *s, arg_i *a)
 
 static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
 {
+    TCGv_i32 tmp;
+
     /* For A32, ARCH(5) is checked near the start of the uncond block. */
     if (s->thumb && (a->imm & 2)) {
         return false;
     }
     tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | s->thumb);
-    gen_bx_im(s, (read_pc(s) & ~3) + a->imm + !s->thumb);
+    tmp = tcg_const_i32(!s->thumb);
+    store_cpu_field(tmp, thumb);
+    gen_jmp(s, (read_pc(s) & ~3) + a->imm);
     return true;
 }
 
-- 
2.17.1


