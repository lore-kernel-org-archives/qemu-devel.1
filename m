Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39F4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662A022CE8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEauZHcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662A022CE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq8y-0004JS-Dk
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMz-00031U-I4
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMy-0006wv-EQ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMy-0006we-9G
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:16 -0400
Received: by mail-pf1-x443.google.com with SMTP id c81so1937724pfc.11
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5Xh6zbX+N9ttY9MdN7vquKBp46pmYyv37TGDy5UrKa0=;
 b=GEauZHcmeYZyYb7r0mtCqhm7fEgMEQr7ln33eZAolSBWsVQIW2vrWi9MsyV6MO0nuy
 maE5eUhj8CdPEf5/8mYnq1Pd0hx0xe7PTnZgBlyxLaTRbCYIraHcv1ON8rArq/Fa5KQp
 VEgOys8hsO6GeLmjs2iY9e+MVqgVmSdXynB0PFf4g/YgqafiHuVPjyKI1zaD9e0akV7i
 2nktUOkpludSh3/dB79fB6Mrd1k4liQVNvJf54E3zUmv+ut6v+C1Pkvh0ApTx2kQTPtv
 FY2VQQxLPA3RV7e1vmXcM7ZiUacUfwzOWZcobk6UaAXJVIlnRQqgQFD0Do5VklrFlHmY
 /gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5Xh6zbX+N9ttY9MdN7vquKBp46pmYyv37TGDy5UrKa0=;
 b=pk4OKtzLt0shfwE1dawNSC5o2CaGBYwZZLh4PQT2tDuGjJcQ0yddwegLwQGqIFgM8w
 zbMevdW4JB3jdf0Ha0mHoUL/fu2/wfZ/OwgcKCACiGd5N6REiEcRb9H20joONqQtwwnF
 yHrl9QUsMWT2pSMxxb91YEAAvso8PEWHnoXmEg3UECF6TUiLf0oy64Y425+r5xH3OttA
 6C4Nj5m/RQ6xW9sX7fBJrdVyN8Idy4H8GVjN9guTEWiXHpg9x18PpLhqzQEICBsd0mnz
 g8o8Hs29ay5y3C7uE0Xo97dcbj62n1AiQa9x5qF40lD1dZMkmItML2z6018FeJjlJesu
 P42w==
X-Gm-Message-State: APjAAAV5aRZ/oP4VoadW3vbRyur9jzyENXmN/lMr/WA4z2meoNlviTMI
 VPDo/7uPRmI4FfHX/2BgFI1ChFiGcUk=
X-Google-Smtp-Source: APXvYqyeSGA4P+L5UTMPgvjSHTSXK4apIn129eMpfidfuqS7MaZzAw9BbcHLUlnzF2mxMbihA5ayqQ==
X-Received: by 2002:a63:1f03:: with SMTP id f3mr21525885pgf.249.1566250754989; 
 Mon, 19 Aug 2019 14:39:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:50 -0700
Message-Id: <20190819213755.26175-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v2 63/68] target/arm: Convert T16,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 ++------------------------
 target/arm/t16.decode  |  8 ++++++++
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index dc670c9724..dc3c9049cd 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10630,7 +10630,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rd, shift;
+    uint32_t val, rd;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10642,29 +10642,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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
index 4ecbabd364..1adad20804 100644
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


