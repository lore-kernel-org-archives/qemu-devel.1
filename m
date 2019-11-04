Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F1CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD3E20869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lku22ZuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD3E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRgK0-0008KS-Nc
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRgHv-0006S2-Fc
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRgHo-00011e-0I
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:11 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRgHn-00011H-Qu
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:03 -0500
Received: by mail-wm1-x341.google.com with SMTP id q70so17627353wme.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sEHnGi1dpcWkzmcNmi3sg94gf4w8+sRwyHjEqhhS/R4=;
 b=lku22ZuQNs40GznxyzwPrTGZBDLwcQA1GAQb7Y9qMKTkX9G2tLRUjWNg34owoh+P3o
 aE+51fHCfpbRX1/AlH4hiB/+OmSnEv9EafqOa1GTrQ06fNoPQMv5pivxydsCXXzTIvX2
 gHC5z187YWFqvbODxRryAW+Fr4xvuxmkSG7RNexbAUZASKZnt5uzGiI6Ou4y6u7jS7dA
 5nXm1E1at4TjJQyxNfWz7Wo7gzc0+fTNaWOKP66Y0ZH3S1RopGtRmTETMYfEL5OSYCsm
 /blXaZV6pqtR4VigeEKfpRQj9w+KixuqL6Dth1mtxHaH2hvLlC8PxyXi2l6ucVqCnaiE
 NEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sEHnGi1dpcWkzmcNmi3sg94gf4w8+sRwyHjEqhhS/R4=;
 b=BwiAZQX3tKZyMyk1hYQGZIIgrr7McF1NbhVCY05xJWrxZHWGxUugfvuleLkbAWzb/s
 7H2mzI3+P6+PsstjGuwd5J4/wHWzRXVJbY3Lr/f2bowSgDua+WFzMyeLW8P04s6AObfi
 AlVvIwHy/Hl9/HO+O0G8rf3XGVmKA5IxqohfZYH3rawLCQamt7FvwTiOj5RsJH3PyUO6
 XJrWXGyCYzgxAnhZWQPt8Wkkx+bvaswqcLvMxs2kgwiiSj3J8ZACHNuo26RVAv5OJQi7
 nsK8weDriUsNbzTUW2+Sa0gkfaVb/1pzhtNV9vSbL+yHUlhT6U0ZjUJF1oT2jX8VwB10
 LMdw==
X-Gm-Message-State: APjAAAUy7pnWPYegzMOep5BV3bDmCeUSpwYVXD1N9ik9kPh+pDZbRnnx
 FNdVAHUE06+Jh2MCF+Zp4uQDZg==
X-Google-Smtp-Source: APXvYqwcszFd93sizY0JiCtQv58ZshV933K7g3rWe6CK0nd7CSw/4xLm90Ac5DhBgmSDnFu5rsOD/w==
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr245276wmb.142.1572889022681; 
 Mon, 04 Nov 2019 09:37:02 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l4sm31953123wrf.46.2019.11.04.09.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 09:37:01 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 35B781FF92;
 Mon,  4 Nov 2019 17:36:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 5/6] tests: only run ipmi-bt-test if CONFIG_LINUX
Date: Mon,  4 Nov 2019 17:36:53 +0000
Message-Id: <20191104173654.30125-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104173654.30125-1-alex.bennee@linaro.org>
References: <20191104173654.30125-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, Corey Minyard <cminyard@mvista.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test has been unstable on NetBSD for awhile. It seems the
mechanism used to listen to a random port is a Linux-ism (although a
received wisdom Linux-ism rather than a well documented one). As
working around would add more hard to test complexity to the test I've
gone for the easier option of making it CONFIG_LINUX only.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Corey Minyard <cminyard@mvista.com>
Cc: Kamil Rytarowski <kamil@netbsd.org>
---
 tests/Makefile.include | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 534ee487436..8566f5f119d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -177,7 +177,9 @@ check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-i386-y += tests/rtc-test$(EXESUF)
 check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
+ifdef CONFIG_LINUX
 check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
+endif
 check-qtest-i386-y += tests/i440fx-test$(EXESUF)
 check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
 check-qtest-i386-y += tests/device-plug-test$(EXESUF)
-- 
2.20.1


