Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F3EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E012921726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOav/tuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E012921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cYD-00006W-Dc
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvJ-0008Bt-MG
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvA-0006f4-FX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:56318)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bv9-0006dL-Hz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id g207so182165wmg.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zh8cJOMlQoU86gylTdnIBMbDSjCDSeGhH9/trBdCYUA=;
 b=gOav/tuua1E4hp8ziE/1je/+tdtkNkgZUpWFXm2jAFqUB5HsZLjUd0GZRxVOZv1gm6
 iJKaKaGzuY7EYwN8A4Ks8dIu6v1s+fckqkZqgKR51m5u2alDiKU9z2ptwG5FfOxnq3zi
 40/v+4BDg9Vw0Jn1qVl+xht4HPrqsYNo5JfL/qobiaJLRHUwm2UAQ/Kh26EsaTjsbNZW
 lwXoPHDMvP8XOBMtCbqSQvwjKBd5S6IKEMccFBsf7nQCPzRfYTlV9bZEphWgRnRauGe1
 sq+e48t+T/9ue+4UuuJlezWPaDFYtERf2kpotGArdxgKzzaC3nUkTN9FOQoDIOSJPfZL
 0AZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zh8cJOMlQoU86gylTdnIBMbDSjCDSeGhH9/trBdCYUA=;
 b=EtDYLzF5z5xoz5Dm/9kvmUYIwaYJ4JmFSV3x4EUrbLZ0+La3UyI3//aHSlaBlScFIT
 WZcfKY6cIyWTfjvv6KnNsWbKWWY3ifZq+i9NOpovV2dKzNAl+z9bHkQ31jf91W9CwbuP
 o5qtQ8+npLmH7KbBtqCHIgXOq8JS6HPXE6TysJeqy++S7TpJ8X9aGJc/a0jTjkqcTQt4
 oxyi10uvzvuJZcffLWgmRmgXFe7CyZp48sPq0k/2WwXZ3kDm8z7kC1ZHFrwMueqXXp8O
 x9N9pniV4wDrPJmFHBsJIdvjC+TW0HspJKCFB6Q0zQAe9VkSnZ9CHx792BMgOlqyKxfL
 82og==
X-Gm-Message-State: APjAAAUSTmUae45jtZin/4ZTJWs8ukDWM406PpGuta0dTnFjOiEytRX/
 ny5t63ahAQTUcriunfjNuSgr9g==
X-Google-Smtp-Source: APXvYqxTKm5hvm+VzFha5tugezzMxqoAIxnWWvEKjuzcPaiY8F8awFnO8nkYyg+hVQnWGILoYdsADA==
X-Received: by 2002:a05:600c:23cd:: with SMTP id
 p13mr89932wmb.148.1567629026315; 
 Wed, 04 Sep 2019 13:30:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b136sm130137wme.18.2019.09.04.13.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF38A1FF9E;
 Wed,  4 Sep 2019 21:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:45 +0100
Message-Id: <20190904203013.9028-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PATCH v1 14/42] tests/docker: move our HPPA cross
 compile to Buster
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now Buster is released we can stop relying on the movable feast that
is Sid for our cross-compiler for building tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                     | 2 +-
 tests/docker/dockerfiles/debian-hppa-cross.docker | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index e7379f1d732..ba5a624eaec 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -100,9 +100,9 @@ docker-image-debian-win64-cross: docker-image-debian9-mxe
 
 docker-image-debian-alpha-cross: docker-image-debian10
 docker-image-debian-arm64-cross: docker-image-debian10
+docker-image-debian-hppa-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
 
-docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-debian-m68k-cross: docker-image-debian-sid
 docker-image-debian-sh4-cross: docker-image-debian-sid
 docker-image-debian-sparc64-cross: docker-image-debian-sid
diff --git a/tests/docker/dockerfiles/debian-hppa-cross.docker b/tests/docker/dockerfiles/debian-hppa-cross.docker
index ee6d9a24ce8..5c68b2d3304 100644
--- a/tests/docker/dockerfiles/debian-hppa-cross.docker
+++ b/tests/docker/dockerfiles/debian-hppa-cross.docker
@@ -1,10 +1,9 @@
 #
 # Docker cross-compiler target
 #
-# This docker target builds on the debian sid base image which
-# contains cross compilers for Debian "ports" targets.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian-sid
+FROM qemu:debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
-- 
2.20.1


