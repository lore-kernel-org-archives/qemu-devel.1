Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174B3C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D3F207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1xkaCfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D3F207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47126 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAqh-0005tg-0R
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39328)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAoz-00047I-Qr
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAox-0004G8-9Y
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:01 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAou-0003yc-1U
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:05:58 -0400
Received: by mail-wr1-x436.google.com with SMTP id c2so1337965wrm.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qCnUPR9lwJDCVN+3iAAkawz91A004gE5+vwI6CE6U4k=;
 b=C1xkaCfPyiVd7QKIq+Jx8gMCa0vNYwcNBA7ZrqE7ZgsLK7JMkxqnA5jF2C3Vniyp8d
 ryqpI9fQrhCYF3H5/6HQnOzLhUotjJKPhHaqZ2oAJHFNtFekKM52EOveiO203X6t7Mdr
 aRrB00uqa2/EjDB3C0BHWTFvxCF9/EPilAmexy1ixJHDd8gFVTuxgvVH+bhxOY648sxR
 wbnxFbEeyTyPwIWCg8kuaaORXl+RJ0VogkU5dySS3x106k9c31GnleOjc+EPXn2OK4m5
 DDUtL30zXHlYkmzLkVfRgHLJbPEfUa+Tn4U6OC1y91Tv1RSRFYNH3kANFw7NOxmUHMkc
 M59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qCnUPR9lwJDCVN+3iAAkawz91A004gE5+vwI6CE6U4k=;
 b=n+pA9xHT1JyDQ5JpFfVOglztH856VSAxP1m2t3H7VQ05g6gf0fxGXSVU+GfVqlBX/q
 TeMCNO8Pbv5olJECX6RRhEM/bPkaeq7w0SCULYkJcTr8EoXWy3jNO7CLCmVuqmcJtzl8
 oKWFkWwfRrG7XJPLbLKad4OUWjHtyAOhz5bVvNw+8vFm2rOrx14YrEMPl0mDJJIFsIR3
 ogtKiMN+8oXZMLzjGf0Zc517Bw1ZTqSv0KEL2fVHncLG4kUgP/XchTuDb05MtifLujjw
 PSDloAIgtvlffc/rSpRhnY+jev+qn1QHw/V69eW7dwTiCR+klYH3jABpCNcMo94sOAWz
 /Ndw==
X-Gm-Message-State: APjAAAXtR61z7G03pS+sQSt+7FpylGc/HPj0w6E7meZ40UQz6H0AAuWx
 KIC+qG51YdWFlecFdhUcZhtoGw==
X-Google-Smtp-Source: APXvYqwT8H9WJGY0HE4EzUbc/T3fUIupFXV6MXZk+NelMb9H4/98P61gXcmSUEbwB5A4YAjlhuJT+A==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr8791262wrl.134.1559898355024; 
 Fri, 07 Jun 2019 02:05:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f10sm1685621wrg.24.2019.06.07.02.05.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:53 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4444C1FF90;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:02 +0100
Message-Id: <20190607090552.12434-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 03/52] tests/docker: Update the Fedora image to
 Fedora 30
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
 qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fedora 30 got released:

  https://fedoramagazine.org/announcing-fedora-30/

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190528153304.27157-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index afbba29ada..12c460597e 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,4 @@
-FROM fedora:29
+FROM fedora:30
 ENV PACKAGES \
     bc \
     bison \
-- 
2.20.1


