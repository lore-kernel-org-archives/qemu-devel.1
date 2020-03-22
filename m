Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5B5C4332E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DE0A2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="em6Nmibe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE0A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFzNK-0005DG-Aj
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 08:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFzIN-0000iH-7Y
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFzIK-0001XF-Ne
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58297)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFzIK-0001X4-Ho
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584878492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWg8qEkdtHLS5RiJUs/y2SIc9XLbwUaK9DS/kS4AUxY=;
 b=em6NmibexIotHy6EK82WNFFF1EdolBVe5hWGMtJn4pQVp+iipJJhwL39NzAEowzXkR6Us8
 ie/kPhHqtzxVWLLdeZSb3NdBBCrUR1r0JMi3A+pgecyS4AqkDMM8scM2jvg74fMOw9EGKG
 aWIgt+Uqtu3QY2HwneAXU3B46IV73kQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-Xr9i-N69OyWOFByhUAHl1w-1; Sun, 22 Mar 2020 08:01:28 -0400
X-MC-Unique: Xr9i-N69OyWOFByhUAHl1w-1
Received: by mail-wr1-f71.google.com with SMTP id v6so5660690wrg.22
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 05:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FIrEvJM3MZZKAXLyDJ7b+Sj8plkho1NeMMKpejJfyeY=;
 b=QGlJ26pp4nwgER49wL8UEnymWo/WzRJpSe/iM+fKI2vv2OBPnHv4njuePhoi7B5IZW
 oGhIjbfawqIbWmQXg25w9tW/2KgZoO1VTJ+yiMvwjHl1Sj2UJxPmzYIoZPxpWJHUI6K1
 3UeT0F0QXe58gN6bzc6DpJ31lQZZzHM22ajbFGi7UJOCyweVyCiIFTRLt1CuahLdET1s
 FV5s9EojolqnB4zo7hr2PwyBhYlYd/fCL1+byqERo+6vUQQBEAnQOjQS6iMDdzNONr7H
 RGglnnOEtc6xOrwewZxk/VW5xe5t9ZRBub1V4xKjfuYlpY0C+FnotqtOB3k5EaNUEau/
 YEUg==
X-Gm-Message-State: ANhLgQ37dDT7cXho183DTGlR+Z2FXgGhyqohGVC9zPXJy5Z6i0wA0Mvq
 8oVQA5051Ekx8aM3iuIoZitRS15bZKtfFxZnlnvEb2bkn2GnZxNuUoYqsD3mo7slpF4lKgx6bew
 LgAfNG6ZcJcbDK/M=
X-Received: by 2002:adf:fc8a:: with SMTP id g10mr22820318wrr.82.1584878487056; 
 Sun, 22 Mar 2020 05:01:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuwj0ttfBmDGhxKpBCrFMAH/r8tIJToX6p8qZbkzwN3kTEeUMelj4n0LUe5mvhmCYRv2GqbWQ==
X-Received: by 2002:adf:fc8a:: with SMTP id g10mr22820303wrr.82.1584878486897; 
 Sun, 22 Mar 2020 05:01:26 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id h26sm14912074wmb.19.2020.03.22.05.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 05:01:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 4/4] tests/docker: Add libepoxy and libudev
 packages to the Fedora image
Date: Sun, 22 Mar 2020 13:01:04 +0100
Message-Id: <20200322120104.21267-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200322120104.21267-1-philmd@redhat.com>
References: <20200322120104.21267-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install optional dependencies of QEMU to get better coverage.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfi=
les/fedora.docker
index 174979c7af..4bd2c953af 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -29,6 +29,7 @@ ENV PACKAGES \
     libblockdev-mpath-devel \
     libcap-ng-devel \
     libcurl-devel \
+    libepoxy-devel \
     libfdt-devel \
     libiscsi-devel \
     libjpeg-devel \
@@ -38,6 +39,7 @@ ENV PACKAGES \
     libseccomp-devel \
     libssh-devel \
     libubsan \
+    libudev-devel \
     libusbx-devel \
     libxml2-devel \
     libzstd-devel \
--=20
2.21.1


