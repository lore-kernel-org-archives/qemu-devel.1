Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C974DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948B12469D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sIsrjMY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948B12469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7s7g-0000JR-PF
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 21:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6g-00076g-LB
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6e-000378-Js
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:58 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:41617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7s6e-00034V-EP
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:56 -0500
Received: by mail-pl1-x62e.google.com with SMTP id t14so1950681plr.8
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 18:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vSmE5SkJs7bKw32GyNmYKHJ7/xdEHXIomHMfGHtsHSw=;
 b=sIsrjMY62M5uoJsoSqolyGqkaDW2hQ/NhnqnCqy7UYdo4NPZKErLWMP0QNdggmmp+u
 p9thnGwGo35b53VXBcTTx0znZWvxEQYs+hMi3bzszSH/vblJnu1g2y6d41jmGZXEa2rO
 hwZi8W3FDCqIu3UTZrO44Hd9adkk5+KBYm4YdKB7IUoYWB9hOj7PWXg2/rEsxBOC/Oj7
 10OMAIG0SZ3mggshw9Ao2A7IMOX6u0JlokNqt75BlcqxZjzPcqCn5q6DI46UMeQNW7Hy
 4gScqBMsuhACsaQVwXC6Url8/ueotV6joNau6o5lkRrOomh4i3U65+ZOOGKA56cDeDj6
 soUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vSmE5SkJs7bKw32GyNmYKHJ7/xdEHXIomHMfGHtsHSw=;
 b=p75pxC9TN73Rm1IHeAnhVcWqE4Pd0hsOy9g5vpcVaNtXgVyGNdEg10W60HhNfO2aOf
 3zA73cWmKjrGI7IefiehaQ1eCNOl746HZ1Pd4QulI+gBiIakhssFsJ2z5yJzXLElJ/UA
 Oeq5bI3P0t/DGp3eZha1bqrf4Wsc+Rq/oUiHgxe7DCNlZtq98En60Fr5ZjJfUPY8IZ2W
 iIjqUT3ImtFJ3vBo+0cEOWECKIigQVuQuBMkpe7t3nl7IHC6IkfkMC/0O4E3jSWsnJdQ
 Ns2oerR/VBzbU6WcLi3jaB0vAfG0cyrfR9GidgmiK5gis0FA3lyMy921W/gn+76S4yRt
 0m6A==
X-Gm-Message-State: APjAAAVOX8lHxWhMCEUfLfDLWWAq6biDVuwgnChsiAWqRdhzL/h8VLg1
 cofz4VQEDznWavde0LKQu1ppWV5lYCI=
X-Google-Smtp-Source: APXvYqzGcKXhU+9d7yaAyappzbsP5xPoJpCoDZDowmv0P5dQds05WWb8Ueh2BIG6hdisJzS8XfzMHA==
X-Received: by 2002:a17:902:8204:: with SMTP id
 x4mr6682194pln.225.1582944233921; 
 Fri, 28 Feb 2020 18:43:53 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id k9sm3649321pjo.19.2020.02.28.18.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 18:43:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] tcg/arm: Split out tcg_out_epilogue
Date: Fri, 28 Feb 2020 18:43:42 -0800
Message-Id: <20200229024347.22826-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229024347.22826-1-richard.henderson@linaro.org>
References: <20200229024347.22826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62e
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

We will shortly use this function from tcg_out_op as well.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
2.20.1


