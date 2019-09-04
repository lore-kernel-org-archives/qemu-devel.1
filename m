Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BD5C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB51A20828
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7XkMm8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB51A20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5dGz-0008Ek-S7
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDX-0001wQ-83
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDV-0002Rg-Pf
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5cDV-0002R1-JF
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id q12so255943wmj.4
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qKLxOOykUq5mR0vUYJUVr2Z+HnNQRrDR3i+FrJMMXro=;
 b=A7XkMm8uP4pO1m8nNBXRV4F2LExqjnwmiGjtX8u32IEggqbdU7mh/BG3HQ2Vavn3wn
 4/La5P85lnJQPhOr4V165XPgGY6mtMxl+aruh1dA/M4elqqoSModGiwhpgKv1wKDej1v
 Kn8lUESJRQuCYDUZAiax44j/LR5aDOAgknxcxfhOYlfXgdNCzNCaC8LWmhB8EUwEf4jL
 DhzTylpU2NVlxZf/gfB2oaemQG+xivru30arFXw5A/aZEIthQtajabxVuFDggf9LphCi
 hvWBwaF7jvQ4WWjwGo4hIisVXdbT1egEpyBUGBP2TMRmZlIO/qYZEh3YagJCtggoS8Hv
 ElOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qKLxOOykUq5mR0vUYJUVr2Z+HnNQRrDR3i+FrJMMXro=;
 b=P2vDkd68Jr2k4J75OHXX//xU1SIC06jkxd4vvkVCJH+qVtfLaGa9AfEO2OEET10uBI
 9RRuYusP5UfzgWT3h2eR79bLMq5YSokBjFpPv/NXf+I5DW45qwjhO78I3v4xMRIzNIqi
 c4eMFfJ7Rr315jV3yoQcAMYleS9ZlGvcBImeDbKzjhqRgEN/Nlq7iQ2rFouQxnek6Dxq
 JAoXmP5CveBYRjz2UlesVhWeTh3RX8OFyAXAmTMkq2zF1cwfqMRrcQ5NkT0YqT8Ar6K7
 orAAkjQzvY/Qg7aQ6pUT6Jd7lBTT/G9LR7GgBtgaleSba/shsbURRD/tHuUatMvJ5UC9
 IsHQ==
X-Gm-Message-State: APjAAAURr8IDpo3sgfh111RogWlt6jmuxLoumGWe1MThyPNUcttL9vKI
 h/fFtT8V9z1ORyHWEYPhGWRgig==
X-Google-Smtp-Source: APXvYqysDg041UkV6HZxUNpL9qAnb8g+jAG1tekGysCxM6NsTuGNosJCOvick3WyLdm3UgpqGJOXOw==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr150655wmc.31.1567630164472;
 Wed, 04 Sep 2019 13:49:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o3sm23527653wrv.90.2019.09.04.13.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:49:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BEF3D1FF87;
 Wed,  4 Sep 2019 21:30:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:30:08 +0100
Message-Id: <20190904203013.9028-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v1 37/42] .travis.yml: Cache Linux/GCC 'debug
 profile' jobs together
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

These jobs build different components but use the same
host features. Put them in the same cache bucket.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index ab3e4ebaadf..ab4ee425e4f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -120,11 +120,13 @@ matrix:
 
     - env:
         - CONFIG="--enable-debug --enable-debug-tcg --disable-user"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
 
 
     # TCG debug can be run just on it's own and is mostly agnostic to user/softmmu distinctions
     - env:
         - CONFIG="--enable-debug-tcg --disable-system"
+        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
 
 
     - env:
-- 
2.20.1


