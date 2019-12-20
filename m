Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9603CC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60525206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2+bLZoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60525206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIJN-0004uW-P5
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiIF3-0007S4-Vm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiIF2-0005Rt-52
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:53 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiIF1-0005NG-Nb
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:51 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so9236065wma.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tq4uTuTrF1sjaAQeE45sTsyrBhoioBCJJ0MxAc2jFgg=;
 b=n2+bLZoXUIjpILnemC+nImUg3xPzAb+dJGK3kwH6yv2Pw7+0XsroNA+cITIssOScdH
 5fO9iilbZSj+ygSANDaLmWhOKGTmzyvqJMKRWzHrzyeNZVwUdWY1drgWc5ZAe+F08qyc
 uu1w+bQecM3O7j2y50K/aQ8OMbs1aE2PhJ3X9tSE3PSh+khjbuv/oOcoZwrDtY6b2BpQ
 v7RtUSQ3ktfSOtNb1vE5ybW/OA8TFC+Fr12uJR9EEq4Jqv/JKV4qr2CJZmpFj9e0oZE+
 Kzg1RFbyL1tvX3qjq+tODsNyIWB7DIYFPA4SOl/P+OUWpbI9aWyepAWBDwRLsobbSN8M
 nD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tq4uTuTrF1sjaAQeE45sTsyrBhoioBCJJ0MxAc2jFgg=;
 b=teDwcNTEGYTwwVFK9txon/4KdonXOZbsVSazteNQc0liNE2hlHQW+K+diFC0DmIkhp
 aAb7XKdF5EkAgB+mPowpxvJbl4Ma3E4tQIlfF1QNHRDj5po/mMPGajknj4/63rodcqRd
 7fAx0g7NiK3RtuMFAHogNESLAjKsUNo+aitdu/LdwFndQBxAP/nXRhapNU61+kJHw+uV
 uaj95TAm99nuyhn1nBirC/4ixH/YzWtVoS6Irer3SjJu5iP+pOGC/7o2Wkz6J9qsniCn
 fY0B5RBYAU46tF/GH8MCLBOHHtvdOYHG651T9+g7hEYH29afwynEVsOLNvK4CSSHiQir
 C+Nw==
X-Gm-Message-State: APjAAAVBNeSokk3p5tQbdDdji2UYW6G7/8aYGiALEMe6fkAi2gqcZvJh
 +5YJTcz7PKHJGqWYfdhbRMI4Ng==
X-Google-Smtp-Source: APXvYqwPPRuJrhjFoxxUPR7D/zHH4ZkVaEVPFnI2YqCqBv6g/C/ERIkCv9Gp7rQ8wcBFiSK8lueBlg==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr15708176wmi.51.1576848170053; 
 Fri, 20 Dec 2019 05:22:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t1sm9763073wma.43.2019.12.20.05.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 05:22:47 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABC081FF8C;
 Fri, 20 Dec 2019 13:22:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 1/5] target/arm: remove unused EXCP_SEMIHOST leg
Date: Fri, 20 Dec 2019 13:22:42 +0000
Message-Id: <20191220132246.6759-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220132246.6759-1-alex.bennee@linaro.org>
References: <20191220132246.6759-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Richard Henderson <richard.henderson@linaro.org>, keithp@keithp.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All semihosting exceptions are dealt with earlier in the common code
so we should never get here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Keith Packard <keithp@keithp.com>
Tested-by: Keith Packard <keithp@keithp.com>
---
 target/arm/helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5074b5f69ca..b4dc2274c8b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8554,12 +8554,6 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     case EXCP_VFIQ:
         addr += 0x100;
         break;
-    case EXCP_SEMIHOST:
-        qemu_log_mask(CPU_LOG_INT,
-                      "...handling as semihosting call 0x%" PRIx64 "\n",
-                      env->xregs[0]);
-        env->xregs[0] = do_arm_semihosting(env);
-        return;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
     }
-- 
2.20.1


