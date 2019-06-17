Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ACFC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5412084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aI4xjgkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5412084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsxT-00010U-KF
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiQ-0003k4-DM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiO-0008AS-H2
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiO-00089c-AA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id r16so10200990wrl.11
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YQocH3JzOwJkJhKLmOCIia7aopw+9WsCQO9KTDk9Jlk=;
 b=aI4xjgkOuZC9bMQ25yFaC0ciIkLPzaxcvyi3Ggx1oKsLwJYWDPm3oOECpE+JGIO0Bw
 Q9qnghYHO99AJ644EnzUZFtS5Orkkv7BZu4OupfEISYrQ5YpSiC8L3tjaO3Wy0br1vE0
 hx1N7ROr2oJSb2gI3sP/QteYbb8+5x/BG4ZCINwXd5cFui4gpvbaLVNmDuj1dk8OUfDV
 Z/BMPnP10VlHVOLPHZhgoJRnH9AaH/vghxZ8TLArprKr6GWmt3CHCJJMCgdoqYpWPZI3
 X7Ka23xytSEt494bjXKDbKvsFBeCi5Rv8sk98zommlvcM9VeRX8C7Jvx9DRVCUK6n751
 Hczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YQocH3JzOwJkJhKLmOCIia7aopw+9WsCQO9KTDk9Jlk=;
 b=bk3ICgI6ACvpxMiLLrAQ4oQpt8LMnDQQkjZ9jb8Fn4f7KrhsxWcnLnkyndk0RLlcbp
 +ObzpB5sreBQpH73Q0e13KEblhQaoghQ7v2MFZLZdS6rdVVSLaPMZ3mxeunZbw2HsV13
 lA7E2UUryN9g/kKpVNet1LUjooeQHjSuBFb3H89CspljGPR74kUntpOt3fgNQ8UeDTi3
 7PtUtDd+LqpyiOLJ1iz13NJaONZq7HmqcHjce456StZWfHKB+KpJ757oBATKb3QdH1z/
 WcpCiH/Zlx9SvRrC/Cddu1mdSt7ZxtScfkyHiOpJSV10N9ZrXysdp4xdiYL1BTBX2lHp
 WvaQ==
X-Gm-Message-State: APjAAAU4jZd7IQNLdWHC6vWRrWbGOrru8ABAz91JH/MaPfIoHhf/TtHQ
 cLwyiY8O+Y7E51XUvYMnO9qMDJpQ6/xtJA==
X-Google-Smtp-Source: APXvYqzASZSSxHgByzPrWEpo2Opm8uby5TtwH+rqeiGwfa2hCqYBp/pVjN1MOqvBdArdGZky/c/7xA==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr62859940wrw.26.1560782071009; 
 Mon, 17 Jun 2019 07:34:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:03 +0100
Message-Id: <20190617143412.5734-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 15/24] target/arm: Stop using cpu_F0s for
 NEON_2RM_VRINT*
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

Switch NEON_2RM_VRINT* away from using cpu_F0s.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-6-peter.maydell@linaro.org
---
 target/arm/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a006ab498e7..243dbee8357 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4181,9 +4181,7 @@ static int neon_2rm_is_float_op(int op)
      * what we are asking here is "does the code for this case in
      * the Neon for-each-pass loop use cpu_F0s?".
      */
-    return ((op >= NEON_2RM_VRINTN && op <= NEON_2RM_VRINTZ) ||
-            op == NEON_2RM_VRINTM ||
-            (op >= NEON_2RM_VRINTP && op <= NEON_2RM_VCVTMS) ||
+    return ((op >= NEON_2RM_VCVTAU && op <= NEON_2RM_VCVTMS) ||
             op >= NEON_2RM_VRECPE_F);
 }
 
@@ -6786,7 +6784,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             tcg_rmode = tcg_const_i32(arm_rmode_to_sf(rmode));
                             gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode,
                                                       cpu_env);
-                            gen_helper_rints(cpu_F0s, cpu_F0s, fpstatus);
+                            gen_helper_rints(tmp, tmp, fpstatus);
                             gen_helper_set_neon_rmode(tcg_rmode, tcg_rmode,
                                                       cpu_env);
                             tcg_temp_free_ptr(fpstatus);
@@ -6796,7 +6794,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         case NEON_2RM_VRINTX:
                         {
                             TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_rints_exact(cpu_F0s, cpu_F0s, fpstatus);
+                            gen_helper_rints_exact(tmp, tmp, fpstatus);
                             tcg_temp_free_ptr(fpstatus);
                             break;
                         }
-- 
2.20.1


