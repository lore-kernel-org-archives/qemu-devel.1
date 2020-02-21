Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D26C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1252073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IuCN3yQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1252073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j586u-0006qc-F9
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5828-0006fU-6h
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5827-0002XP-7M
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:56 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5826-0002X2-QJ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:55 -0500
Received: by mail-wm1-x342.google.com with SMTP id a9so1774937wmj.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ows304RxUz9Hn/1Tf4KQX6grU12RJO2tytM+z5pmWvE=;
 b=IuCN3yQh1GwsRynYk3smduSDINEdq8H6PPNJdPEm9N+NslQXrS1a5rF5ohh05vr0hW
 vQrqKsFzvI1jisVJ/RexhOKbcXOdEMveX98EtaAj905E+Q0fBK0Jw6vsWfJ8LZL1ddhQ
 c+nMRjm4YIBBIg663Q3jcFnDdCMHspP6wJeNPpn4O8LxVfo8K5FVjFRCDwHbbBp4JLqx
 cr0t5fCxR/YoRcajzXzlHmKjYSEDul6kSbUcUt5sWNOT56qLuzxs7t+tI+pBpZpScJ1K
 4//J+kLdmPSjp6ZznULGEZ0IDiT8BzUHX+E09XY9tPXb2i9LGzCEPKMrFDG3SgZo4Qa6
 clXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ows304RxUz9Hn/1Tf4KQX6grU12RJO2tytM+z5pmWvE=;
 b=kR2BIrEajaW1IqvjTvLkCsWavlczWb+AotSB4yZgwy2BOSNpyMyaaKGRA4xSvvQP08
 zAok8+JJSRvTrBb1zZXN2JUIckqzJHu4/J/v1rNRQjJnfYuAHAer/4INTmllli5CUpQd
 KKma13W0dvjm9+PLm4w/kvk0v5t+OjQU1EyVitLQLescCaQshERmCtVOP5jpLVo3c013
 raXbo/v0MKXTcwJoh2bzq1AqT68q19COCbwTrwNTxpbtLGgPLje7/tfwEFMECUcgZkRb
 8qATEqWBTSKhxx+Z6dcVvWD9KSY6ePsyDX7HiqA22w33bdJyJnoeku4gwVDc3l87ki7P
 vLUg==
X-Gm-Message-State: APjAAAUN5aMoftO880pK1934c4KCAouwUpy5ONaKyWrVH5LBOx02QL/6
 fgCf4JKoJTlbQShnFQX3ARpewkvqOS7ypQ==
X-Google-Smtp-Source: APXvYqwRkZmn/Ht/UrjgVGqUeDsTzQS6GE9l1p2wn7R32qNKn5ekmTPbrfZxZDOPHaIOIxNnM+p+mQ==
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr3820640wmm.188.1582290473497; 
 Fri, 21 Feb 2020 05:07:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.07.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:07:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/52] target/arm: Flush high bits of sve register after
 AdvSIMD INS
Date: Fri, 21 Feb 2020 13:06:57 +0000
Message-Id: <20200221130740.7583-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Writes to AdvSIMD registers flush the bits above 128.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200214194643.23317-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b83d09dbcd7..bd68588a710 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7412,6 +7412,9 @@ static void handle_simd_inse(DisasContext *s, int rd, int rn,
     write_vec_element(s, tmp, rd, dst_index, size);
 
     tcg_temp_free_i64(tmp);
+
+    /* INS is considered a 128-bit write for SVE. */
+    clear_vec_high(s, true, rd);
 }
 
 
@@ -7441,6 +7444,9 @@ static void handle_simd_insg(DisasContext *s, int rd, int rn, int imm5)
 
     idx = extract32(imm5, 1 + size, 4 - size);
     write_vec_element(s, cpu_reg(s, rn), rd, idx, size);
+
+    /* INS is considered a 128-bit write for SVE. */
+    clear_vec_high(s, true, rd);
 }
 
 /*
-- 
2.20.1


