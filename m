Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02197C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF1220838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfLv4Yto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF1220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLQ4-0000i1-FF
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLGA-0005dB-L7
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLG9-0000Ko-MI
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:38 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLG9-0000HL-FQ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:37 -0500
Received: by mail-pl1-x644.google.com with SMTP id c23so13202440plz.4
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lItfuMC+44mOHKIMDg46S+jTWfWeuHiIELhnH02jZNM=;
 b=FfLv4YtosmjEWcdwjsAJVCTUQsL5sYfcdqOaZ8fZArdbwXNkT99TdL/bKd3Kr175yA
 igrXF+RDnM/NX3FWX9GEFMQmtPK2tj3z5VoxcLll7dT12lKtZCsXNw9Zq5Zx3XcPZAXP
 gN6duYJMTdT0UdxGKN/JwnHNxm7teV7dRAC7aq6MJQHU3a6DlU3hEkJvnSjXpSdtZQWv
 KsnvwlHuSuunNWJyeOEVi4QXo9LzbK2UTv0xe6skIBfESwKWaQwXyjfX8bbE251n2FGF
 65KWXB2vF022Z+hYPek9DUngz7XEvvh9Kng0L/+kNEuoT5OBDJkNzGeIg00rVc3bTwCr
 +UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lItfuMC+44mOHKIMDg46S+jTWfWeuHiIELhnH02jZNM=;
 b=o2gj6Lrvy+qE16zQEpL2WchrTmzRXUSyCD50rLnJzhkm5rZtgt+XRk0NkSzC3Z47M3
 Oc0M8jZyt7asbOGyWGnAFhaWRf7I/Nlvx1A2XOv1adm3PDM+l9GoMv53X+W5qshqESRI
 RwaIKqxq2/4l4exrajTWopoY7sQHNlKQ0pJpZRbh9cm0unzz4ioqiGa6Y5XBfIekG281
 d0PQgfaR2zDs5HTbSWdSzK87BxE0eOQvOnbew4EV1rKD8yU1eT1qoG3qD/fcfpp07ZRG
 YwOgCpKrmMfnqPaDLvf/OlxvXkEu+4MZTlsL0OgIP3J31ej7vM8kr3BoGmG6Ywez36TP
 yj1Q==
X-Gm-Message-State: APjAAAXg5FY7t2m9Bl3X0Nibd1lAzMKp1ZzL5HrQUjl0mDjTvIXMZNb3
 KSoZ33J6HtIJY/FMSyUEPhv3kKujUX0=
X-Google-Smtp-Source: APXvYqwieynKrGcnLQRjNpHf9bsSKX4h+l+q2JbIqJ/7rKpq5g/t7JHF8d7z1XR5HuKcHZQkUl7Gig==
X-Received: by 2002:a17:902:bc8c:: with SMTP id
 bb12mr44330431plb.218.1577574756033; 
 Sat, 28 Dec 2019 15:12:36 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 22/29] target/unicore32: Remove MMU_MODE{0,1}_SUFFIX
Date: Sun, 29 Dec 2019 10:11:17 +1100
Message-Id: <20191228231124.18307-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/unicore32/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 50ed9dd99c..7a32e086ed 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -133,8 +133,6 @@ void cpu_asr_write(CPUUniCore32State *env1, target_ulong val, target_ulong mask)
 int uc32_cpu_signal_handler(int host_signum, void *pinfo, void *puc);
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 {
-- 
2.20.1


