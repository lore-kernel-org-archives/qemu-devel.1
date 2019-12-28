Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237AAC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA312168B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2nNpB8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA312168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLNR-0005cQ-D2
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFy-0005Md-Tn
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFx-0007nI-Tq
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:26 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFx-0007js-Nw
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:25 -0500
Received: by mail-pl1-x643.google.com with SMTP id c23so13202330plz.4
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RE7ec3tQf69S6u/1sbXcwZ3prYFhHBLumgiHfSGx76I=;
 b=j2nNpB8PfmKj9UkpQ5d/F6lWTCiErIHYw3MpigY+9/gkCuFxZpx3m25mcZw7nGuyf+
 i04ugRzul7E/+ot+1HPjdKCTGSY1Buefi+ujTDDH/HXatZcT2DQzfwRpvLVpiW+fDrPF
 MpkgrmtmWGHc5p4dadeXf/CCCa55y5Ck1/g05Td03jhcWkHZkBr5ae1cXeQDUQeTuu7d
 1G8D5H4gp0CBXaNwvfmqGcXU0EKZBILc2lkJIi7uxjNdj/BI6/gwtJDvh4xsHnHx5E79
 UDMsLlEverpZZqKqzEoUmSLrR/4qcq7bmAJe7wxakgFM02Q3SA+LqUK5errkSl8m48uy
 Y6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RE7ec3tQf69S6u/1sbXcwZ3prYFhHBLumgiHfSGx76I=;
 b=HejH0oO8ielsNxudES93m5HXQtmRqQTI/ZscyaS+hOkYADshBpwwSSh66T9qaHxXwk
 PSUXlB1wv0J1Qbpsu0Sz9M7IhmoHJY6+vsN/vk9/seTTDit19vOXcBuaRi5swH0F8YG/
 0QflWSVJHJg2AHEzY+d3ZCwyxSNfqDdUKhSeUHTjh90cEwEuov3R+xwL6vdaCroEf+y2
 qnFP6DUpknUKjZjTPguRgOcpFlEaDP3QBjjqq1Vv17zBjyNkGocuMvvDuJZOpqMp2vcK
 OMAxN3gqlUqV5z4pXTeTArWJElqnFROlLuUnrnHdWqq44Y7Rk+4xExqNmRQTVyxGC/LV
 Fe3w==
X-Gm-Message-State: APjAAAXM+ENNC2eeaFfgILLO3C4MoBZAaGy0K8cOzCnfXYQN9IImJp/1
 k9Xpv8JMroM1Vc3I+hxKOMWO5wAsBDo=
X-Google-Smtp-Source: APXvYqz0dO0b76S6bdAymrHQJRxT+GU6X564caV0Qk73ePHtQYZl77I/eVD+1VOsWk+apjJTuYXGaw==
X-Received: by 2002:a17:90a:da01:: with SMTP id
 e1mr36375757pjv.29.1577574744553; 
 Sat, 28 Dec 2019 15:12:24 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/29] target/cris: Remove MMU_MODE{0,1}_SUFFIX
Date: Sun, 29 Dec 2019 10:11:13 +1100
Message-Id: <20191228231124.18307-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index aba0a66474..bc43bc23a1 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -252,8 +252,6 @@ enum {
 #define cpu_signal_handler cpu_cris_signal_handler
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
 {
-- 
2.20.1


