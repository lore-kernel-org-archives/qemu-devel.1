Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D26C7619B
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9525D20857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 09:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0VusJOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9525D20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3GRj-00027O-O7
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 04:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GQv-0000rz-JU
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3GQu-00023v-C5
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:41:49 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3GQu-00023p-6S
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 04:41:48 -0500
Received: by mail-pg1-x542.google.com with SMTP id v23so4075111pgk.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 01:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2wtlXnnDoBZhRjp682Do8PbWI+JcM4MYW5/nGRf6l4c=;
 b=V0VusJOABEIR3jsUOwK8IXEoXkrRy7M3UebeQ/XMKvyi3ciYzYuzg9VtJ95EXzCKmM
 6wCv4EYfq9xV9EzU4KuTvpim2zOJmDrV2SeRGmYlivV8culy10P6U7VVv1dA7NB4cJrJ
 n4Q8kfy8Tsia55n4dH7yDJNXy3GtHHXHQ9/3pTEggKT7qC1CiMI+8EqlTFXQOoudLQ+F
 87tcMaa5qVmLvRrDeYn7uzUHXDv1M3Z9+QR9Wa+i+PWFFyT0m5t90jTE5ACIKm7zy0KJ
 dpr08Q+MEKiRo3AmEYr2ra63ZVsX0oD1/Yo7l2fe7w4oY8nU5mm5HLWTLvVJ75bBtYvO
 1w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2wtlXnnDoBZhRjp682Do8PbWI+JcM4MYW5/nGRf6l4c=;
 b=jdp4lPpteJE9Vtt2JEXBub/n/WLXpkIZnBM3Y5eOQ8ZVhhD8PNQ37f74Z6tN8++ZU1
 V1cXFH14WvUyFP9mLUytCpichGFPLjLz0t8w96GJgEUYLqnAcnLXPK4gesASSGH1k3Jv
 dw06X84Oxt4UpO696er7LqR9EZxmQoioNODCZdbyhkWvg3VgTEjACgeg4S0dJpZyhP+1
 nI7f4on1Vq1wKLTM7WxnEQQvjM18NVYCddtNUhBTCSs3ZaM7iBU9jrXqfxa13+r8aLuR
 fVCBSqCM0dX/cIgKKC6Ywq/11ppBuyemsxbs9uPJhtTDNaJcRrYO+M7fErInjaNdBxZ/
 E0nw==
X-Gm-Message-State: APjAAAVTy5JzCTaBByNdkIkd3Izn77D8aeaBIgk7T9AAL1C3u1/vNDb1
 5/kHDOGSICgqMyq+pqQn7/Byk9vJo5Q=
X-Google-Smtp-Source: APXvYqwgcwDN0e18M5iyLK9ONMz5Gg0kE54wHL8S7KEQQPEQPWGwUkhJx3lrNs5kjyi6+He1/l1GJQ==
X-Received: by 2002:a63:584:: with SMTP id 126mr12404441pgf.447.1581846106780; 
 Sun, 16 Feb 2020 01:41:46 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l15sm13023553pgi.31.2020.02.16.01.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2020 01:41:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] tcg/arm: Split out tcg_out_epilogue
Date: Sun, 16 Feb 2020 01:41:42 -0800
Message-Id: <20200216094143.14201-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200216094143.14201-1-richard.henderson@linaro.org>
References: <20200216094143.14201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: philmd@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

We will shortly use this function from tcg_out_op as well.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index fffb6611e2..e1aa740ba4 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1746,6 +1746,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TCGArg *args, bool is64)
 }
 
 static tcg_insn_unit *tb_ret_addr;
+static void tcg_out_epilogue(TCGContext *s);
 
 static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
                 const TCGArg *args, const int *const_args)
@@ -2284,19 +2285,17 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
       + TCG_TARGET_STACK_ALIGN - 1) \
      & -TCG_TARGET_STACK_ALIGN)
 
+#define STACK_ADDEND  (FRAME_SIZE - PUSH_SIZE)
+
 static void tcg_target_qemu_prologue(TCGContext *s)
 {
-    int stack_addend;
-
     /* Calling convention requires us to save r4-r11 and lr.  */
     /* stmdb sp!, { r4 - r11, lr } */
     tcg_out32(s, (COND_AL << 28) | 0x092d4ff0);
 
     /* Reserve callee argument and tcg temp space.  */
-    stack_addend = FRAME_SIZE - PUSH_SIZE;
-
     tcg_out_dat_rI(s, COND_AL, ARITH_SUB, TCG_REG_CALL_STACK,
-                   TCG_REG_CALL_STACK, stack_addend, 1);
+                   TCG_REG_CALL_STACK, STACK_ADDEND, 1);
     tcg_set_frame(s, TCG_REG_CALL_STACK, TCG_STATIC_CALL_ARGS_SIZE,
                   CPU_TEMP_BUF_NLONGS * sizeof(long));
 
@@ -2310,11 +2309,15 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      */
     s->code_gen_epilogue = s->code_ptr;
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 0);
-
-    /* TB epilogue */
     tb_ret_addr = s->code_ptr;
+    tcg_out_epilogue(s);
+}
+
+static void tcg_out_epilogue(TCGContext *s)
+{
+    /* Release local stack frame.  */
     tcg_out_dat_rI(s, COND_AL, ARITH_ADD, TCG_REG_CALL_STACK,
-                   TCG_REG_CALL_STACK, stack_addend, 1);
+                   TCG_REG_CALL_STACK, STACK_ADDEND, 1);
 
     /* ldmia sp!, { r4 - r11, pc } */
     tcg_out32(s, (COND_AL << 28) | 0x08bd8ff0);
-- 
2.23.0


