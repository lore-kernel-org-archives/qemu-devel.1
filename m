Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEA1C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AEA620714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHUFNSj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEA620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYc2-0006qN-G8
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL4-0007lq-Na
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL3-00023i-M4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:50 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:45620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYL3-00023R-H2
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:49 -0400
Received: by mail-qk1-x743.google.com with SMTP id c145so8140085qke.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E/tQbITHc97dgORFyK3tE34tNsNJB0LGdPZMzeOAZ2A=;
 b=LHUFNSj09e1Iwyy7HMTWa3Ovt9W1QkOMIp2LOA3ETkRGMl9Q+hGKcY+F8ZN+bOUMfV
 zXHS5U+3AnGVr2PXZcQOVSBYXgXS7z3vi+7mREwMJo8dt9qy4op07f3vqWd1ihDUW5BD
 hTkUuJlnA9b3T4WMCgjnoRrpKTzeQeLBm4SXXfSE21k6cxtnEWjHtAm0gzxAXb6/Ff8x
 qXMWkt7VqzD0riG3S29go8py/1JkxGIQ5dpmHNxp4tOikFEsuR0KNGYiy/KiZT8Gx/ci
 18dNL6UXXbzvZi79pffz0hurbeaDQBGu12a9K+YUgsyaS0Jq2fKk1mJAmcs2PDBwYN03
 K/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E/tQbITHc97dgORFyK3tE34tNsNJB0LGdPZMzeOAZ2A=;
 b=nM7cQQWmQHy5HtlVF/6tu8kYUOdd9PNiYBnnXPS/lF0tg7OcwO9h2mS0M5ojn1y71h
 KpUWSTlMw26lsShZjXmvrrovxZmaT5goBpOlrE53I0ak9SXBwhKi/fHkZE90ltnNNZ0E
 AD860pZaqutA7COxqCgUXz5tikrErm6cA0yXeWJXeH6VmYA3P9NFQjfi44cvSGOH8KLs
 JW80eaa79nlShGYSA8hY3sBNVsc4Xr6T3Aix74+kqm7LrLf7lHx0GFRefM8tf9qNuC12
 sZSsAqXmYvtJRq7DaDIfohKnb3BxhkOHJqcoUgUC2x0gM3I9NHXB/N+z6bAG4Sl9LIOL
 bPPg==
X-Gm-Message-State: ANhLgQ0/Wj4j4s7MRAGaCNw8ZOFuRcG10K6hxXHWl2dV8Nwo66rfVEgL
 8PyZnNiVxh6m85WuZojNYmdp5nGbZJjeAA==
X-Google-Smtp-Source: ADFU+vuhr4FflNMpspeUClfN0j2bRUxuv1v7UYX8p+4rHaSXob1BUduSuU3tQdAfIu1xtHe5MygPVw==
X-Received: by 2002:ae9:dd83:: with SMTP id r125mr5093651qkf.105.1585251528776; 
 Thu, 26 Mar 2020 12:38:48 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:48 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 54/74] alpha: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:36 -0400
Message-Id: <20200326193156.4322-55-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/alpha/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b3fd6643e8..09677c6c44 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -42,10 +42,10 @@ static bool alpha_cpu_has_work(CPUState *cs)
        assume that if a CPU really wants to stay asleep, it will mask
        interrupts at the chipset level, which will prevent these bits
        from being set in the first place.  */
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD
-                                    | CPU_INTERRUPT_TIMER
-                                    | CPU_INTERRUPT_SMP
-                                    | CPU_INTERRUPT_MCHK);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD
+                                        | CPU_INTERRUPT_TIMER
+                                        | CPU_INTERRUPT_SMP
+                                        | CPU_INTERRUPT_MCHK);
 }
 
 static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.17.1


