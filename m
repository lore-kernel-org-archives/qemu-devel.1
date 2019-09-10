Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B55CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAEF206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UD0bd3+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAEF206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7c6Z-0001e2-G0
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkt-0003Xe-2W
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkr-0006QY-Sj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:06 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:32982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkr-0006Q4-MH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:05 -0400
Received: by mail-wr1-x42f.google.com with SMTP id u16so18412998wrr.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KqEnFRpupENR9kNbZVcJtQySlE8FhTwxtFose9RX2lY=;
 b=UD0bd3+58ih9vuVTEMcBwAH9je9j3ZtsaBmTQo1cmHZCWxM0jx0GYsEqPF/v+o0pAR
 V8VNZZFFgPB5B+orcXvLVvFFdAuQD44P2K2vszwR5Rff5Od1DhMhCgjGA9csYWZdMt7F
 m/XnAoTu3pDz/NV/XXXUOlJ+BrODFEn44EUgr2hdfcfgAujsgExnSNvUqgDic2Z0s4HZ
 Hw5pjQBDy8NArYAJF4d4wCbGtB4ZNTyozo4z0gfcCLJaoTYGyennHU6D/9xJKRw1RZGw
 bX0KruxKeTtsc9fh7TwxT1KSfZS8lCJ1zvup2deWsR5NENanVIhwWAAF5/OCfDHZ0P+q
 m6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KqEnFRpupENR9kNbZVcJtQySlE8FhTwxtFose9RX2lY=;
 b=d+SxTds639uHyLViITCZEowRNznwLnJ7CiXnNIRwP7ufsZHU4sZxxVi2MYqD6fuVHO
 Cog7yGeJOjJkJisSpzhv+fDiJCVulTbl60vgy2hFeEt94bkErkt+JZZYUdAn+1nTEZuw
 He+PHcBJbTz2DLWef2bagisSl9sosfLIYKpd4YOLyX1Vw8TPGhpTTfsNDqkTQU3pv1g2
 y1gYr/MHWTSdqq/evyqfeCDnzmuho2RMssWIg8xqtUBKradbPdqkunXFx48Oly/Q2vtw
 bGxwPStqOQXpHDoHvRD83P/+/ZiUkSJ37JXVnqZIL+B/m1PRcWVPnddGXkQVTKfiG55+
 8Xeg==
X-Gm-Message-State: APjAAAWCrxz/n6rsQn5MR22lRlTctyvxf9QTTIW/7Z23e3L87pJ4Ib8r
 bF3zg9wxgiLgCapdZslx5GK+22mGC9g=
X-Google-Smtp-Source: APXvYqycPxV73n4wsbBAgi22t/ZXHSVBRjZ/3KOhASR2F1S+ttncATh+pq0IJH8XkgOTdZhmdqF0Cg==
X-Received: by 2002:adf:e7c4:: with SMTP id e4mr17159506wrn.62.1568105044669; 
 Tue, 10 Sep 2019 01:44:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b194sm4098036wmg.46.2019.09.10.01.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:44:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8CEA91FFB7;
 Tue, 10 Sep 2019 09:43:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:36 +0100
Message-Id: <20190910084349.28817-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: [Qemu-devel] [PULL 32/45] tests/docker: --disable-libssh on
 ubuntu1804 builds
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

Currently this stops the mega:

  make docker-test-build

from working. Once the source is patched to deal with the case this
workaround can be removed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index 44bbf0f77ae..883f9bcf31c 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -56,3 +56,6 @@ RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt-get -y install $PACKAGES
 RUN dpkg -l $PACKAGES | sort > /packages.txt
 ENV FEATURES clang pyyaml sdl2
+
+# https://bugs.launchpad.net/qemu/+bug/1838763
+ENV QEMU_CONFIGURE_OPTS --disable-libssh
-- 
2.20.1


