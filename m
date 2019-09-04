Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE53C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295A021726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOneeAFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295A021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5brr-0004Sa-4B
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b11-0005b8-76
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0y-0003I3-QU
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0x-0003Fv-9E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:23 -0400
Received: by mail-pf1-x444.google.com with SMTP id y72so6330451pfb.12
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yenO3oE4SSaYXrdcFyWSo2Ub5XpLvK6VEnhxFO59r04=;
 b=sOneeAFEQVgGvPkBjDxeEb9He06PDg8B6Brizk84ZzVO6ZbgHla3sOdmDQogtjU+RS
 WW4o3b8dxgQJgPDz2njww3KR4wu6QIggogNmy9l2HKzhlB7YuuGnPQMfmU80B6j22bac
 583kRFfrjlFxUFdP93Yg4jhtZykMsklJaMzuAwiQvNcxHvxFJMoACjx7zeymYzhRhDpF
 3uLAOjqZdX6EVQk07cLkyPU0E1HoAAQgkfWp9GK1aeb9Z4zlY5KPjz+9Ig0poAa2Ezja
 KGuLx7pR19bawgYULliWQ4tzF88EcC5mbApH5wyMl/GtYVsmDFE7vsSWD4f/Xrql+uQn
 REzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yenO3oE4SSaYXrdcFyWSo2Ub5XpLvK6VEnhxFO59r04=;
 b=aZOi/PeAUqgSvxIPpZvpdAhabIraELcSvQ8QsUhMpKs/MCtMqgT++Ebc+2iW+UW1FC
 RdTyuuJOKMszK3Sf+zON0R4MABjPGeL+mNQx1UuwV5E0adi7Faqwit/3U1JWM3w3eCYu
 m9o+7sCy7WoCf+AUk+izqUji8x0nL1GHPUH5XoGAep9vB7JIdZfcyT3wejEljo26EHtq
 HJGzo5VejIqM7NFqtvl3+SFxcSe+6VIl6NjucnaUeQS8IMHTbsACaV9l/hFOd/7Kwfe0
 75UmcqxKA6EzTBs21N2fh0y5YjoD3QGby+YXy2jvW01SdEteeIivePNmoqy5ApsanNfe
 JCfA==
X-Gm-Message-State: APjAAAWnezHPN5zRRJSanqYqrt/uSsoDUML49UfCYwY6VvUEeC1WNA/6
 GN+gLGYCq4yyD9tfGGqTvVCi0RuNLJ4=
X-Google-Smtp-Source: APXvYqy/lnsRo6rRGCMuBxGCFb2hO+CMHjGL75nIEtNPXflVjlmCajwrtMVeqc7qabc+chSE1+wo3w==
X-Received: by 2002:aa7:9117:: with SMTP id 23mr24820154pfh.94.1567625541967; 
 Wed, 04 Sep 2019 12:32:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:54 -0700
Message-Id: <20190904193059.26202-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 64/69] target/arm: Convert T16,
 shift immediate
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 ++------------------------
 target/arm/t16.decode  |  8 ++++++++
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 48ed6f6b5d..d409afd55f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10754,7 +10754,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rd, shift;
+    uint32_t val, rd;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10766,29 +10766,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     /* fall back to legacy decoder */
 
     switch (insn >> 12) {
-    case 0: case 1:
-
-        rd = insn & 7;
-        op = (insn >> 11) & 3;
-        if (op == 3) {
-            /*
-             * 0b0001_1xxx_xxxx_xxxx
-             *  - Add, subtract (three low registers)
-             *  - Add, subtract (two low registers and immediate)
-             * In decodetree.
-             */
-            goto illegal_op;
-        } else {
-            /* shift immediate */
-            rm = (insn >> 3) & 7;
-            shift = (insn >> 6) & 0x1f;
-            tmp = load_reg(s, rm);
-            gen_arm_shift_im(tmp, op, shift, s->condexec_mask == 0);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            store_reg(s, rd, tmp);
-        }
-        break;
+    case 0: case 1: /* add/sub (3reg, 2reg imm), shift imm; in decodetree */
     case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
         goto illegal_op;
     case 4:
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index f128110dee..79a1d66d6c 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -126,6 +126,14 @@ ADD_rri         10101 rd:3 ........ \
 STM             11000 ... ........              @ldstm
 LDM_t16         11001 ... ........              @ldstm
 
+# Shift (immediate)
+
+@shift_i        ..... shim:5 rm:3 rd:3          &s_rrr_shi %s rn=%reg_0
+
+MOV_rxri        000 00 ..... ... ...            @shift_i shty=0  # LSL
+MOV_rxri        000 01 ..... ... ...            @shift_i shty=1  # LSR
+MOV_rxri        000 10 ..... ... ...            @shift_i shty=2  # ASR
+
 # Add/subtract (three low registers)
 
 @addsub_3       ....... rm:3 rn:3 rd:3 \
-- 
2.17.1


