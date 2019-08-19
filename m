Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3171C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978DD22CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szYWKgnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978DD22CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzqD4-0001qP-Pd
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpN5-0003CL-QP
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpN4-00073T-M7
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:23 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpN4-000735-Gb
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:22 -0400
Received: by mail-pl1-x643.google.com with SMTP id bj8so1587466plb.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pOrmu4hSyVv/uT8dsNEbfV+BcoCBHIkgixiHAKgiaBE=;
 b=szYWKgnbjQZEyqcsTvJZwySHhotNNZp7oNO0mFXiSwrXztSEMf/pZcRYx1fEL+KZR9
 tmfY/8DvfXaWvxGAnVm7gPjJPZT46j2Vba0RgNh+bCQvBIpPa41tTyS2YaTQ2aRlk7C6
 vCgAotQhYMekCV9dxyXfcqQS/0KsNjFhUgq0Civeddgx8VbeasuAPndSRcSQ6O/In2yN
 YR64X2uxYUFdA23mGwM2f3blTbBOh3R1iWArkePm2wD2M3ZjX4TjYy0Wfy64tfxF92hx
 UvU8nw8X4yu3uM/xBOwreT685/qPPb+5sA1eGCaNhYPQ6llll+EcEo/1Yp+llAZ6fXlX
 AMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pOrmu4hSyVv/uT8dsNEbfV+BcoCBHIkgixiHAKgiaBE=;
 b=pSuGZhiHlLhUcLuq1ILISbRUhAblrHN99IoECIWXJ4O9iibDHbI8JMDehfl9hMy2vl
 G9DFrKOx9BX+TRmnUita/VoRl27XJfcu83tDuJ311J6JRUcB4308MRMIh6L479q9KeBv
 yB93toldfYK5fhlgl7DCvCJEtn70KWYkGoWO70NEDizKlazB6REksawWJUF0I22AX0NF
 65klB0oWiAgsspA05zlbJoerWTWPUz0uSv0/03zwdoFhwCi0EhhSgssyj39HnPjlXUsF
 MDPjnuf0GauU2OmVQ3xK3r/yQ2nIHQrEjMVUdsvqbA9RbxKTDwkaJkKBo5tdUkP5uNyZ
 jq8w==
X-Gm-Message-State: APjAAAVHPT4rmg/Y2VkbTrWDvB5K8U8ws08AR/aF7sHXvweX87bzQJ8p
 1DrJyY46RBVUutjHw5u9OAZ6gTyX5po=
X-Google-Smtp-Source: APXvYqwG71x5PrOX4J+5+jRM2Eg8cMmBpqnVHk5NuDA0yW4nLmnPD6oZL0pGRp9T4osjVV5Tsfi5iA==
X-Received: by 2002:a17:902:543:: with SMTP id
 61mr24756723plf.20.1566250761305; 
 Mon, 19 Aug 2019 14:39:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:55 -0700
Message-Id: <20190819213755.26175-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v2 68/68] target/arm: Inline gen_bx_im into
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index bac38e6261..9162ad113a 100644
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
@@ -10016,12 +10000,16 @@ static bool trans_BL(DisasContext *s, arg_i *a)
 
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


