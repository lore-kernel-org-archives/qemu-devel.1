Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482ACC38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13DC22054F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpu9n7i1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DC22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqDC-0005t3-4l
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBg-00046r-JC
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBe-0004uO-FZ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:24 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51723)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqBe-0004sR-9Q
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:22 -0400
Received: by mail-pj1-x1043.google.com with SMTP id kb16so2558703pjb.1
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/fduq7+z5S6wjChMKi9oJb/vmTzyRgenbcyuQtF0AWE=;
 b=kpu9n7i1gDNQH7fWevb1vvS82BmFoT8ajpqan0W86tzv3rJfWeqtEylutyfS8tydi1
 5TWeEs0fpHppawRhv2WPcDexQmT9VIOojjNVVne23o5dQBVyV6pjile3uZEkjmG7FeFW
 olDsYIpt1h3UCv1PLjlM+exc0Oesr7LuPiD6ejcyXZzCtKnuUYCpsiD57oU1E9LsLq7M
 5pLTyUAsa6oAgdAJ/m/h16AxlzDZqagP0LxWvA/x72nS2PvVcrZYL9GRHqGKc675O5gC
 csAC4Oz7dvBVVG5m1gTgY0H3ZPu+G4ZF4wplZgFTZ879TC+R6s3I+QuqhHu4FLt5P5Vw
 mIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/fduq7+z5S6wjChMKi9oJb/vmTzyRgenbcyuQtF0AWE=;
 b=UEsuqhfB70FRSiCKIUuAXlrCGDEqBrvKHsQV4oE2c9MPscvTL3VEj2UpAOnNkM7PqT
 xJiKbRVP+N43Pc15DK3PEJaSN1AVbaH8Z//qcYAL5ZiOhQi4jZx9xPY3W2e+JQvCuL89
 idf+qg7rqtIjtiwWvLokWYBYxaz4wacIW+GMfx1t1YyTtG6JOwT+ZGxvTKqhSM8De4Cv
 PYTFWiGgxTbqYHSYjbyi4dh3Ctmyv6asMlD2BZ1JmChq3eQZ0ZvFxj3S4nbvnzDCMz/a
 o6+/4bCSgyyKH2GO5tOmKLtJ9ZiIJoNS0Wdxa0Zg+wgcaPJOadXhdDojp8/OCzyxxNPO
 EviQ==
X-Gm-Message-State: AGi0PubwPe+68MZqWhAH8jqJ17Nd/czbB8GFnqj16Cz392CjxXYX0FIk
 zoOYZsYEs4crU6+3X7F9qDNGmYL5Mw8=
X-Google-Smtp-Source: APiQypITvEIym9Jxw021lDzSjm7haZ3gmV6Wy2dnO9zSg+MgFWYxrlh+6+sacaSq/jf2VhstpNoZCQ==
X-Received: by 2002:a17:90a:2023:: with SMTP id
 n32mr11250411pjc.150.1587226760981; 
 Sat, 18 Apr 2020 09:19:20 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i187sm22398382pfc.112.2020.04.18.09.19.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:19:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/16] tcg: Use tcg_constant_i32 with icount expander
Date: Sat, 18 Apr 2020 09:19:01 -0700
Message-Id: <20200418161914.4387-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418161914.4387-1-richard.henderson@linaro.org>
References: <20200418161914.4387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must do this before we adjust how tcg_out_movi_i32,
lest the under-the-hood poking that we do be broken.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gen-icount.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 822c43cfd3..404732518a 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -34,7 +34,7 @@ static inline void gen_io_end(void)
 
 static inline void gen_tb_start(TranslationBlock *tb)
 {
-    TCGv_i32 count, imm;
+    TCGv_i32 count;
 
     tcg_ctx->exitreq_label = gen_new_label();
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
@@ -48,15 +48,13 @@ static inline void gen_tb_start(TranslationBlock *tb)
                    offsetof(ArchCPU, env));
 
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
-        imm = tcg_temp_new_i32();
-        /* We emit a movi with a dummy immediate argument. Keep the insn index
-         * of the movi so that we later (when we know the actual insn count)
-         * can update the immediate argument with the actual insn count.  */
-        tcg_gen_movi_i32(imm, 0xdeadbeef);
+        /*
+         * We emit a sub with a dummy immediate argument. Keep the insn index
+         * of the sub so that we later (when we know the actual insn count)
+         * can update the argument with the actual insn count.
+         */
+        tcg_gen_sub_i32(count, count, tcg_constant_i32(0));
         icount_start_insn = tcg_last_op();
-
-        tcg_gen_sub_i32(count, count, imm);
-        tcg_temp_free_i32(imm);
     }
 
     tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, tcg_ctx->exitreq_label);
@@ -74,9 +72,12 @@ static inline void gen_tb_start(TranslationBlock *tb)
 static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 {
     if (tb_cflags(tb) & CF_USE_ICOUNT) {
-        /* Update the num_insn immediate parameter now that we know
-         * the actual insn count.  */
-        tcg_set_insn_param(icount_start_insn, 1, num_insns);
+        /*
+         * Update the num_insn immediate parameter now that we know
+         * the actual insn count.
+         */
+        tcg_set_insn_param(icount_start_insn, 2,
+                           tcgv_i32_arg(tcg_constant_i32(num_insns)));
     }
 
     gen_set_label(tcg_ctx->exitreq_label);
-- 
2.20.1


