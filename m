Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D35C17442
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B69206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcUAjp/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B69206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUrLM-0006K1-H0
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrJV-0004zd-MV
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrJU-0004CU-KD
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:59:57 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUrJU-0004BB-CR
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:59:56 -0500
Received: by mail-wm1-x331.google.com with SMTP id f3so1693001wmc.5
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 03:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nyA9Rfm3P2Cacqj24bQZxFtOgORLSIreXZLe4TXhnIU=;
 b=qcUAjp/dL6/KapTqH2+MWLjDEK8bg8Eve6Ce6QtTFlnOSLLcHD5cQfqjmetgD9zA60
 KgGrvcaEmnkleNHZKgikuOLP9ci2xSB3vc7ExV1PwLfCC41JK/Hz83tiYyClmCu9JWFZ
 ZyJKyXCdFr0EQDsLSUSwJN2rRNsB8B57OOsrKTYd4LMVlAwnqO6DqX9GJfWNTuXz6P+E
 P9szTeDJ1gYYUSSTwjhiG5Fzm1Azc1cwl7+JYiOLc7q28nCeAf5htKAE/gQlWxqqrpc5
 QC1OxQHDodt3DKl+z2ZA0dXn3BkbHWJseh8B2VxrnuxiX1oat0NJNJa2QNdNzxy9pNlb
 Hz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nyA9Rfm3P2Cacqj24bQZxFtOgORLSIreXZLe4TXhnIU=;
 b=shjpeJYWlYrTKFJIq+EYCFKj+knvtLfWsJvNEDecin0NNiXzlhJMiFtsEPAPCLLD7Z
 hmHzGTiui18zCbPu6q/o4WzJG7Z19c35BuUmW4WK54ZyCdy6CY3JdovEziONohYd3pGz
 ABV8SKKyXmxZOy2eODbqtEeTBP35eK6UflMyz3xe3keQlBZZnRSxD48f1NCsTLjxxGEP
 3rBp8I6xfqitvGcH9Jjog0e3t2/w5BiJlsHYznp6oGf6m47XBRGHZm0yjHtMTnuI7hfO
 BiIdryF0DFCKckvxwF0yvpNQDvOM3v1vYs5JW9TjL+OKHz4rGXC1en1EQ3jMmzxjnm/u
 cX9g==
X-Gm-Message-State: APjAAAXgvBh7Gg3fp8sAKm5uUPT+mkyL/M9mCI9+TL7xiWlWHOgsrLux
 Q7clMaO1pfbvtQkSn3SVRoe6bw==
X-Google-Smtp-Source: APXvYqzxYD+OA422PVH4aovk7+qB+wzwg5vx1K3TDeVZeBfjAGLH00Lyi3LHquTeHaAKYMzkyEyIHQ==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr2478473wmo.147.1573646394032; 
 Wed, 13 Nov 2019 03:59:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y67sm2183975wmy.31.2019.11.13.03.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 03:59:52 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 430431FF8C;
 Wed, 13 Nov 2019 11:59:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/5] tests/vm: make --interactive (and therefore DEBUG=1)
 unconditional
Date: Wed, 13 Nov 2019 11:59:48 +0000
Message-Id: <20191113115952.775-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113115952.775-1-alex.bennee@linaro.org>
References: <20191113115952.775-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the concept of only dropping to ssh if a test fails is nice it
is more useful for this to be unconditional. You usually just want to
get the build up and running and then noodle around debugging or
attempting to replicate.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix spelling
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 91a9226026d..0b8c1b26576 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -403,7 +403,7 @@ def main(vmcls):
     exitcode = 0
     if vm.ssh(*cmd) != 0:
         exitcode = 3
-    if exitcode != 0 and args.interactive:
+    if args.interactive:
         vm.ssh()
 
     if not args.snapshot:
-- 
2.20.1


