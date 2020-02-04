Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE421C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856082084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pd7hDJjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856082084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3ID-0004LG-Oy
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz3Dy-0006vm-U3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz3Dx-0003Y2-Ib
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:47:02 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:41642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz3Dx-0003Of-Bg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:47:01 -0500
Received: by mail-wr1-x433.google.com with SMTP id c9so24429796wrw.8
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rIHuVIbSJsbfCEGZb34sLirpxbWRjaj8BKp12hdsmGc=;
 b=pd7hDJjFR0meZ8D0HhLfyIlEREBdm5O3tF2Ab6ls+HQANbi0wghU8j1LfHEPzn9G6i
 EKwqFAxBqdeIIVSggqE/dXXETD1RzyonqwKornveiK3xTkd307fUrQs+hEdDHlnON2BU
 dsx6/lR4uHG3yKqSA+cts7cEhi4c+GeMtVL4n2wrZHx40P+ozYbbGMgAlRZxrroyeZz/
 dr3hTPJjka1HdQ4qt4g5JAczOTVhf3TTWAS551QDP6WeTJ3ZczFXncxJL4Wy/Dwx6QCC
 1Wi76FtcsCo1Bk3sCBudVn0Em4CY9D25INBGWq3d1mBw/KOCKDZqS/2uDMSjvzSR0Wmp
 njgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rIHuVIbSJsbfCEGZb34sLirpxbWRjaj8BKp12hdsmGc=;
 b=dJgCaZ0LVwcsvixgQUE5fXSp3yNlBt6DErjJz6n1zbvfk/hL8a9xZwaG306+aVLplY
 OEyk3I538VcCsX7KpANNP8hgPGH83xu58cHPRvrlZgdKUL1W50xd12sfNuXkrml8hAKR
 PeXFkoMRlT9phUypggFUXmjX2tF6vw3IlZfgs4ioFRHmILCOUcYOwEqAQTFKwaTIt1iL
 d6rOZ2usP4RasaG6pA5LGRnJMNHq25bIO5WfMWEMANQiiIU4c5DFU1VE/vssKeck/MJC
 fsmd4CkScxMxA3DkZb4gyA1Hkzyh5Z6o143E75Oxt49e01+/YSr/1XhSDd1uiaCHDUPf
 4Zrw==
X-Gm-Message-State: APjAAAXVaeRUO5TDRErYcWDWrMIjcZ2sJIy75UcXwEnDwUyyVP1Tb4Ek
 JKF9E36Of1gyl1Y356ktYITpog==
X-Google-Smtp-Source: APXvYqxBNvwom6imZN1UORlEl8NTVP5gBAvjj36SWf+DJ/zkm01MiDprUO6AcjOYm2JrxMxbYhcWcQ==
X-Received: by 2002:adf:df83:: with SMTP id z3mr23282447wrl.389.1580842018663; 
 Tue, 04 Feb 2020 10:46:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t5sm30813085wrr.35.2020.02.04.10.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:46:57 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8B9231FF9D;
 Tue,  4 Feb 2020 18:40:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 13/16] .travis.yml: drop the travis_retry from tests
Date: Tue,  4 Feb 2020 18:40:25 +0000
Message-Id: <20200204184028.13708-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This was a crutch when we introduced it - however it does have the
disadvantage of causing tests to timeout with large amounts of logs.
Lets drop it and see if the stability has improved since.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200203090932.19147-16-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 022462f6981..875671325c8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -103,7 +103,12 @@ script:
     else
         $(exit $BUILD_RC);
     fi
-  - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(exit $BUILD_RC); fi
+  - |
+    if [ "$BUILD_RC" -eq 0 ] ; then
+        ${TEST_CMD} ;
+    else
+        $(exit $BUILD_RC);
+    fi
 after_script:
   - if command -v ccache ; then ccache --show-stats ; fi
 
-- 
2.20.1


