Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A6CCA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B696420869
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 17:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDFRqqxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B696420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRgLL-0001wN-UA
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 12:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRgHm-0006Cy-6x
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRgHk-0000zu-2t
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:02 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:47007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRgHj-0000zb-T5
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 12:37:00 -0500
Received: by mail-wr1-x42d.google.com with SMTP id b3so12334054wrs.13
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FjjmRzG7VpaTW0V21y7CdXVm7zUUzOnKit95Yf46DtY=;
 b=FDFRqqxasCjbmaqIwl/IhJhKJWFYBlJm/+7Yl83Cj6E77D7BVIl/wzr1NPoLVpnndt
 8c6luyAi3l+Jb+XV6pCbfyIkIF+C8R2EP8T+CdGFThTlR/mc48e5Qy9oqsPZY2YopZ3A
 qhqN4ILhqMbHz5t7s9pFxrQChM2FrvzrszROWLFQhD8NqQQiZNMAS0/4sn1k5mK2o2ip
 PU8XJRH7+hS53AyhsaBXb8H7xb9Rrzsn0QJK/Neag5aj6URY3yUSeDYDSba6vu/jDkvM
 FYj3eUVfVW1Mh6w8Q8/8DCwdXHkAILgB/bYPiGTYaCtMGSxcvT+Tz8bxdS4HlnM3P8+O
 KyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FjjmRzG7VpaTW0V21y7CdXVm7zUUzOnKit95Yf46DtY=;
 b=Ijxdnu+MXk0MXPY6vmImCtBaFQoeKF0kYa9pGQ7BdZavMTSM/42aaUJ950xzjEE6mR
 oZDSnEhJYchK/JQ8QmlSFPQcDMLWiG2o/laINhFvOBUzK0v2or/+OUPidD6/yen45/KH
 UwH+MDXs/Eoiye3RP6C+gMdG9E0/M0SI/V2WuPqLanD8FYyyYs8vdODOVywe+l1GyXGc
 gEq1/CHwybtmVCqYWOmXJdkQB+lWaYoNg3i/BfwVgRihSnd9NzqJZnyt5qYpkUfYJuQx
 bstFyXFf7yw1AHzOF4n0BLU3AL0KW72r45ubEQ4/pXFWtXSW1eXra4N03QjgrOpTzMwV
 KiJg==
X-Gm-Message-State: APjAAAVzDuJf0puSLcievWzXIkaNzB5XI/VU07UIwgsWtHgoghNCYr5H
 Ka4/wum6nb5ZNHaUw/Wvx2C1Lw==
X-Google-Smtp-Source: APXvYqzJGT0WkVRCl/ITdxWAhQ7MZ+84D2rWS/MgiFzveLGDVTsWzofRgiESwOPYlqR5d5jd2cFqSw==
X-Received: by 2002:a5d:4748:: with SMTP id o8mr25239734wrs.239.1572889018722; 
 Mon, 04 Nov 2019 09:36:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v8sm19851770wra.79.2019.11.04.09.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 09:36:56 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 13FAA1FF91;
 Mon,  4 Nov 2019 17:36:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 4/6] tests/vm: update netbsd to version 8.1
Date: Mon,  4 Nov 2019 17:36:52 +0000
Message-Id: <20191104173654.30125-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191104173654.30125-1-alex.bennee@linaro.org>
References: <20191104173654.30125-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20191031085306.28888-5-kraxel@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/netbsd | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index d1bccccfd01..33779402dd1 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -22,7 +22,7 @@ class NetBSDVM(basevm.BaseVM):
     name = "netbsd"
     arch = "x86_64"
 
-    link = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetBSD-8.0-amd64.iso"
+    link = "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.1/images/NetBSD-8.1-amd64.iso"
     size = "20G"
     pkgs = [
         # tools
-- 
2.20.1


