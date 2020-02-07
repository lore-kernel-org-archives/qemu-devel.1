Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41F1C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01DA20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QkUxzlo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01DA20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j021h-0006s1-QO
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j01z7-0002qW-O6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j01z6-0005gX-Pk
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:45 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j01z6-0005f0-Ik
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:44 -0500
Received: by mail-wr1-x444.google.com with SMTP id z9so2257184wrs.10
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LzvIeCvpZEKsmxLMGQeNvccjyd2G+1aRycbt9INNqtg=;
 b=QkUxzlo3KnDGlDcI7bmDbx4zP1J+9D5tXvdpAwQPShJcUBtLBBDjBmfH5fk1Wn6aDd
 YCmCofrPp83CtjA6AqPK2xCGNE8VKCXRdpp4R34qb6GwVf6Vfd7MJLapU+VzV5omoea7
 qErwKSfk6TbOjdeXTBqzCymY9DdBPmWZX25T6YLxqFkyNQpHaGDk/m6jjsF7aNOPawdk
 FF3e4EWNjnrqBFTEo2LkIH46b09dZd5TY2SsweYLBtOV9OI19pN/Sg+nfr74jsdgaELI
 66EDosIXqzUbI5pKyKXJEOlYdXhE4zWMFDSJqVYonnQJDIxUmUjh2s6khPFlwkH5m1+b
 NXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LzvIeCvpZEKsmxLMGQeNvccjyd2G+1aRycbt9INNqtg=;
 b=bK8qp0bm8Bcdzs3xEtmDdtc0wRsPs6XARv2Yf+Aq5eyMRZI6pdpBxDRl+0kU4v7KR1
 zlxgAISvJVApUyVcaX0e5KDZ4sBjV6QKk59zmuQ4HAdgM14ZxJ5WRRI5z67OwVj/DJEl
 cofRxkGmxr+m7/rODdsojKAUELDkXPeU/iAd1IzccPn5jchWtHfSqHllj557R5T012BG
 vg6sP1PAVjQMepcCj50RnAP8bxH8OR2khX3jkSKFanxaCElPGYpDArXoeH7mUeP4ho4D
 QdaHQM8zuWFyl+NnpGljA0SCVObScKyCzmpRf8z1nPzwcIUvbr+scfTPfXi9xQqBb8U4
 iy2A==
X-Gm-Message-State: APjAAAX0LPG00U0DOWhSLioocBE29eYm/EbjwhKOgLN2KWFeQNQebjKY
 Ztcbiu+lMpHRj+XATP/8blbDUA==
X-Google-Smtp-Source: APXvYqykYVKt2TskCy/Myu8ELcadctHorXAXtlrCSGjts+ZtDPkTZGnPPOGPW2su4XDlsCs4AODMVg==
X-Received: by 2002:adf:f103:: with SMTP id r3mr4250317wro.295.1581075583589; 
 Fri, 07 Feb 2020 03:39:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 25sm2957049wmi.32.2020.02.07.03.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 03:39:41 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9D4CB1FF8F;
 Fri,  7 Feb 2020 11:39:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 2/5] tests/rcutorture: update usage hint
Date: Fri,  7 Feb 2020 11:39:36 +0000
Message-Id: <20200207113939.9247-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207113939.9247-1-alex.bennee@linaro.org>
References: <20200207113939.9247-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although documented in the comments we don't display all the various
invocations we can in the usage.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


