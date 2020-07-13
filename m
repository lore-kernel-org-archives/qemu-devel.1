Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667DCC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6032072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llvH6/4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6032072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzIg-00034m-EQ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAm-0004sE-SK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:12 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:32971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAl-0006br-3B
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:12 -0400
Received: by mail-wr1-x42a.google.com with SMTP id f18so16751418wrs.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZzxnSEdSIbjUDo31ld+i28V1pOQM11woAIfNcfAFUY8=;
 b=llvH6/4sj9EVvlU03YI9aw+j5qKgY6n5fXesFXb1ZEYXNOoF7dg74nxpfLgkjjd/lk
 1/awIWdFAg9p0WqvOHRZ4YhO7Z3TRzfAtpuM8GpS3j8NIMx7abpGKhN0LIcDw6X4DBDY
 tZL5+naU8yC7TDr5mXwRlVFVXqYV/RiEVEZKcOYQBnZKKlqvaRTiHzghWSi5TCkUTXZy
 B+aoEQi0Aaebiqh5tWoKZqG+dTgBcAjq6PxsYXoRexYB7XUS1CS1wMYAD8Lr680EPD3z
 I5LN0e7q9/sMiXIiUC9FtI/4sQGaSuG2y95/oMFbkRISedFCoLeTDBdR31MGfD7r7Tnb
 BHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZzxnSEdSIbjUDo31ld+i28V1pOQM11woAIfNcfAFUY8=;
 b=rP6AD3lYP7EN/RtlI0skfcBOCR9FQxgyFiZEi+GnHRO7ev0sxCI815sEUI5YdtDkhC
 EIM9clkxhm6kesUvPwt+29msvPTn2QE/zPYNsj7dFS61gRlJwaGfgpY4lINtGRpCbqmZ
 D9bMKCC9YzEuzbyo+gHvAuSc6vA8lscNsnMPQxgHudL5KIKEgYPwSAWOzwhX4YAv22wC
 r10kZy70IlpE1PjjFIs954JgjdR57Fwt/YjrhxnYGQMcf25Y9as/ZkcXJnurSlTkBrYn
 6nB6LMQoHBNUQ+p7vxCSsoYt3e2vAclc1n403N1rKu0Prk2snMiKSlH2zJmbOuPK5N1b
 rTJw==
X-Gm-Message-State: AOAM533BP1CR23K34bYMCnJjz9g5J6ix8qFur+H/OjgdAD/2y6KL1wzE
 pl3X/dDsnsD4X59Fj1HqH4l21IgxIIAzzg==
X-Google-Smtp-Source: ABdhPJwv+Gw76WHezMoWqx3FSZF1B62E3MWo/7Z8g4uwHfHpSFhVxe03WBlbw4Hf+Z7lztsZ706f5A==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr79163275wrw.262.1594649469191; 
 Mon, 13 Jul 2020 07:11:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/25] target/arm: Fix mtedesc for do_mem_zpz
Date: Mon, 13 Jul 2020 15:10:41 +0100
Message-Id: <20200713141104.5139-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Richard Henderson <richard.henderson@linaro.org>

The mtedesc that was constructed was not actually passed in.
Found by Coverity (CID 1429996).

Fixes: d28d12f008e
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200706202345.193676-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 08f0fd15b28..88a2fb271d1 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5275,7 +5275,7 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
         desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << msz);
         desc <<= SVE_MTEDESC_SHIFT;
     }
-    desc = simd_desc(vsz, vsz, scale);
+    desc = simd_desc(vsz, vsz, desc | scale);
     t_desc = tcg_const_i32(desc);
 
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
-- 
2.20.1


