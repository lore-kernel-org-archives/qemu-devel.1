Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1A2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586B72068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mITxmaZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586B72068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby03-00053X-Vr
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwd-0002xn-00
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxwb-0007u9-T4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:42 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwb-0007sq-Ng
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:29:41 -0500
Received: by mail-pf1-x444.google.com with SMTP id s18so974685pfd.8
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bqFmG5Z1vaxgrnnahQPUtAEMOtLoaTFE8WYhisDg6pA=;
 b=mITxmaZC7eclvocYyjWfbqDgOESFlDcSqs07Xn72GZulYpILeHcMKJK9qExMo1nb0t
 Ws3LZ+i7fdamiuHCPRgHfAWZmoYVgGYOAI5/m3IWNEHsJWr9+UJALPoH2wXrlfKCVlsp
 WnieNIVJ3oefOuG/AjQw2EN6DUVZbyQENzx79k7btiGIWJDAtDN9TOTNer5o9tx74u8n
 NBbZ6QhBn/LfKhNjBLOI8+MDAPyzWPLxDuOXKZjee0oW+KQNtiBEPbRUX00Ttw3q5q6d
 a9LoglXoGgpnOudbjjgil0bzoXkKR0HrMlFfrMmX9+MftC/TyQUNg6llZ4dx/xM4Vfjf
 R2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bqFmG5Z1vaxgrnnahQPUtAEMOtLoaTFE8WYhisDg6pA=;
 b=pwQLkZjfRwwzm2YDdoACN35dkJZL2/Y6gSu+FM1qtzasZgB3dzq9T7aKxT+6WRbbdF
 zYMN1aqKAaeTvR8osk7E/1pLH+2WcqUxq4ZaK3cxX7Xilh0tGTjZWahW3stVWw1RNl7d
 laJ0k4QhdEe+z6HyTTYDAB7vmJZrtmzR+4tVmA/ovwhsPpGWpySyM4Npgj1g3Mv31Dvj
 I5oqGe3/5Vbuh5okbzZMUyitgWHQVsoFFtYGqC302yezRxf7lCYdNzqxR4vahLUzTHYk
 WY89b/nRefG+CRW06totgqnPV1GRSsvusl9mr+hXFrppnrmFoNDpnqwQn+YT55twRE7a
 IYrQ==
X-Gm-Message-State: APjAAAWSpCyTI+wWJG2tJUCzRhkigkwX8bKUr4wQ+ZfxXFk5BoHqwCgo
 WFfjWGU2eBHJH7SJzNEV4+uVa/6rOg8=
X-Google-Smtp-Source: APXvYqyjYrTMidUh438qrX5fwv9SAgp+L4vbPniO4kTyjPld0K64wY0iFS+81WP03eCnW3p9MzWQNA==
X-Received: by 2002:aa7:968b:: with SMTP id f11mr2326350pfk.209.1575340180449; 
 Mon, 02 Dec 2019 18:29:40 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/40] target/arm: Define isar_feature_aa64_vh
Date: Mon,  2 Dec 2019 18:28:58 -0800
Message-Id: <20191203022937.1474-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83a809d4ba..994cad2014 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3632,6 +3632,11 @@ static inline bool isar_feature_aa64_sve(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, SVE) != 0;
 }
 
+static inline bool isar_feature_aa64_vh(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, VH) != 0;
+}
+
 static inline bool isar_feature_aa64_lor(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, LO) != 0;
-- 
2.17.1


