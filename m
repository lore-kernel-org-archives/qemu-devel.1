Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10997C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF62620873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqbgT5Uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF62620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NLQ-0006SE-Vz
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKG-0004bJ-1O
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKF-0003cT-1r
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:15 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKE-0003aU-PD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:14 -0500
Received: by mail-wr1-x444.google.com with SMTP id g3so8725903wrs.12
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FlL6Bcf4soitUd0txOakm4oS8jrNtXcuMA7Ur/DGB9o=;
 b=UqbgT5UcJMg8gqiYdnNyvLuonIVm3I7KCiblCyhikQXRHI0L/NQXo+JVpaY8WhNZr1
 /UgDkSBmYODIPshL+IB1ssT108wG1mn2qOcJdQd+N0yqQZipptF17T23Jhjv52HC+Agr
 sZUHtIVos4frw3xjngqEyMhMMhwmUCV/Ig0i0Adus18NiYZXbfljjJVFW4Ge4nBXy6Ks
 kzfPhRyxRlX0bc6BVafq6l5RzLHDGssGLHWz4jkyXfk+GtCWUBjpFc7BID7qbBkvzGBK
 VeaXw3D22OQA5TPkuQxeTEfm7DylPLDJ2ZMJuxgdNsspXWm55PxDOVaHXpdd8hCA2k6L
 WOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FlL6Bcf4soitUd0txOakm4oS8jrNtXcuMA7Ur/DGB9o=;
 b=KiFeSNdhHb8d9ZsbJdz2R4B21xbe2QChZ5fFdltw9WSIKq8SNMd+3oU9+yh7K+W1UV
 VomHuooLI/38uU4p24qlSIJnGvLBuffMxnwSGD6JwpjO98MOOiR838+T8TR54ksbaZ4P
 ddGxoyhkDbMFrZYkHpACgYHyRDl21UzThL8gJW+hu8TnE+WLIi2QQR8bq/Lmk2rTcrqI
 QGe1e/qGFQPJ8rppPulsAOnYltDAV1RY8VzBcZvCQqB1KbrJ4fuRrewacClJ1TcxLsJT
 RqXpH9HZlPxnY9YGYIumz0wUbEb7lTe66cjMki4RGEaj9XJxOwgYeslelphjKGrXv/TJ
 g7lA==
X-Gm-Message-State: APjAAAXeqXsBwSYtoWAxY8eJCSgndgh7Mx7gOyLzzWU5NiV/xk7i/scL
 ObYEYloAmAujH5JaeCXiHYdUrQ==
X-Google-Smtp-Source: APXvYqy0izTN/wPfLGl+wfo65ZFSgUe8SDkd6ng1aLdO/DFglVyd0GfNib4S6ZbkNHxVtTgV6E5CWw==
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr24035955wrm.59.1581634273674; 
 Thu, 13 Feb 2020 14:51:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v14sm4658025wrm.28.2020.02.13.14.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:10 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CB8001FF8F;
 Thu, 13 Feb 2020 22:51:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 02/19] tests/rcutorture: update usage hint
Date: Thu, 13 Feb 2020 22:50:52 +0000
Message-Id: <20200213225109.13120-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although documented in the comments we don't display all the various
invocations we can in the usage.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 49311c82ea4..e8b2169e7dd 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -413,7 +413,8 @@ static void gtest_stress_10_5(void)
 
 static void usage(int argc, char *argv[])
 {
-    fprintf(stderr, "Usage: %s [nreaders [ perf | stress ] ]\n", argv[0]);
+    fprintf(stderr, "Usage: %s [nreaders [ [r|u]perf | stress [duration]]\n",
+            argv[0]);
     exit(-1);
 }
 
-- 
2.20.1


