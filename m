Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B6C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF7B20678
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hkH/zDta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF7B20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCt8-0006fl-4Y
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipCrK-0004gr-9A
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipCrI-0000qk-Ur
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:02:58 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44753)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipCrI-0000px-LM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:02:56 -0500
Received: by mail-wr1-x442.google.com with SMTP id q10so3683772wrm.11
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=84JoBWqx+ve5fbgwlbi9R0MpJnP9SRzR7nMEMgeLfQI=;
 b=hkH/zDta4bkX6o89XOdDN1FOrOM11ZKFDXmgt57fJvE2y0UPY65jsjJDpJcguXVXyo
 uasx38TZWbtaxD03l8oQFIoVa6OIqMIskRj3y/kKDduUcaaC5aUT7Jibdx7bkWf1cOHK
 zbHK8UqA084N3FoCQzHp2yuDQ1d6hhLxtRJg+MzexGEu2ixVHilNrJSrqrywQqLyil85
 KjB4NVbMS6Ng6qMdGsevgSgWCoc30zg2b3AWohamgsC7u4szn8wd1eXtCe0Cq944GF5Z
 VSLFcZCmCeQ52hm190umQ8f/d0DICNflmzNYJYqZS70h7f+R817JEvJi2zRn+sh4g6PU
 2Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=84JoBWqx+ve5fbgwlbi9R0MpJnP9SRzR7nMEMgeLfQI=;
 b=Dyvtyloqv4MdbyDdUA/hKXSEI7q2smkz7uHDmBMXZdo5IGxbJ5KlakevcBg6PkCdpK
 Hj0TjmlHei/kmONi8M5fnaYXOARst8uQBTl3cCVk0o27GPizqqLwvfCqrr4CewHutiuT
 DW+G5Ioni8sKsc1PUemMnZ3tID2f8NzRPgDd18hZKQDS6Wdh4ZD6D5KWowElHIzkbnnA
 ABewJr5MO/mnBwAUfy1F8iAbciJlgnbfpE8cdvCvCNDUf6pQwZBvJ65mvqOpxs36GNxj
 wiHvyTSG6FCER1VDmR0hQM/a+tE/oAgk/W7H95YKwa8+hmST1WtK/xPznuRBFii8D7Ko
 3xXg==
X-Gm-Message-State: APjAAAWEE7HgZ4yGDCgmFsUX0f8vH899/jzOGcy+pvL1s12XB+8svdKi
 iNdrblwPpYFfUZRHdWD7dpwT2g==
X-Google-Smtp-Source: APXvYqybbNvW9ojxN3wpBnZC5S/h/Mcx53YAFZYRtG3XOxtOLnvW0xz5uwrW94M+/s9DXl/UsN9Itg==
X-Received: by 2002:adf:df03:: with SMTP id y3mr5500605wrl.260.1578495775242; 
 Wed, 08 Jan 2020 07:02:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l15sm4289805wrv.39.2020.01.08.07.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 07:02:53 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0631B1FF8C;
 Wed,  8 Jan 2020 15:02:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 1/6] target/arm: remove unused EXCP_SEMIHOST leg
Date: Wed,  8 Jan 2020 15:02:47 +0000
Message-Id: <20200108150252.6216-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108150252.6216-1-alex.bennee@linaro.org>
References: <20200108150252.6216-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
index b6bec42f48e..da22c198006 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8566,12 +8566,6 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
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


