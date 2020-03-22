Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BF4C4332E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804AF2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 12:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXBm3uc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804AF2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFzJR-0001Zz-Ha
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 08:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFzIA-0000Z5-NC
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFzI9-0001S6-JL
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:21738)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFzI9-0001Rr-F5
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 08:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584878481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HR85THirGrRubaJXrP0zhSj5RRMPaILm65JYID0iOvI=;
 b=ZXBm3uc8QdmL5eCDQsa/0ewWwhg1MKL7NTSHJSqHaKqEptTv37cCp7NzVpgnQzIFtmiUR8
 xh7c6+5Q6uiFIaoaYZnTc2aluKb8A4AkReWyAWIRcMMwpDML8EaVXew499ThKj0n4QOC6X
 ipE+vo3hWD+7vspwgqMBCEfbM/e9JgI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-tOsFxJt6PU6QbiX29ndaCQ-1; Sun, 22 Mar 2020 08:01:18 -0400
X-MC-Unique: tOsFxJt6PU6QbiX29ndaCQ-1
Received: by mail-wr1-f70.google.com with SMTP id d17so5717058wrw.19
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 05:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w5pIm6ZcNYKkaXeolWHSHFzKOmcIZRr6UxX1a0Co/a8=;
 b=jAOIOdZiiqZXmXyex9MOJzMmmSMIkh7y8Q3U9qVkXlGMVXDfYKOQzIomvEj1cI1Ij8
 qIw5RNkxO+W0LkWpUsrkMXQriG5SAxRcozq/3kjzIYmNmNjhLUTUaPOQSy+oHt7FNcmX
 p9aEsVvGFLypehc/kIHwoTwDOh+fYdbc1YDI6jk9BK7v1A56kEdx+lZ13iEUrUpKnjjm
 XTkeWmJ1GQ2bmvB2jYP+uNWWOMkAnNdiabg+NteoDI8aB2Lyd4E1A9Nyznklxrje/+6v
 HifiZnHAcL5WdDKiaPxyT5bTEhuAzbTnFEKc8QKlbWAFQQ6y9EUIQMplWNVFCr7N1NjH
 9pHg==
X-Gm-Message-State: ANhLgQ2eyC1ZjAhluYtnY4glX3FFFu2120FTgX3pfcr5sxfS5BheZCAz
 5DWPjgTE8NuzujLKHVD7wkAHIVs2UF6+W1yJyR5KMIizb6/C53gSg1luyce9aeut4KsH7fDwHVn
 XyIxSLBIaxwUex+c=
X-Received: by 2002:a7b:ca58:: with SMTP id m24mr20619594wml.76.1584878477360; 
 Sun, 22 Mar 2020 05:01:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvHHhKTVeB4/FC2oDQESykw12HsVKj1Fl/48e/n10oaew3smarRU8mTPNTxV8G0mG7wi2430g==
X-Received: by 2002:a7b:ca58:: with SMTP id m24mr20619573wml.76.1584878477046; 
 Sun, 22 Mar 2020 05:01:17 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id f10sm18211949wrw.96.2020.03.22.05.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 05:01:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 2/4] tests/docker: Install gcrypt devel package in
 Debian image
Date: Sun, 22 Mar 2020 13:01:02 +0100
Message-Id: <20200322120104.21267-3-philmd@redhat.com>
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
X-Received-From: 63.128.21.74
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 6f8bbb374be we enabled building with the gcrypt library
on the the Debian 'x86 host', which was based on Debian Stretch.
Later in commit 698a71edbed we upgraded the Debian base image to
Buster.

Apparently Debian Stretch was listing gcrypt as a QEMU dependency,
but this is not the case anymore in Buster, so we need to install
it manually (it it not listed by 'apt-get -s build-dep qemu' in
the common debian10.docker anymore). This fixes:

 $ ../configure $QEMU_CONFIGURE_OPTS

  ERROR: User requested feature gcrypt
         configure was not able to find it.
         Install gcrypt devel >=3D 1.5.0

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Reword description, do not use 'Fixes:' tag (Aleksandar)
---
 tests/docker/dockerfiles/debian-amd64.docker | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/do=
ckerfiles/debian-amd64.docker
index d4849f509f..957f0bc2e7 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -16,6 +16,7 @@ RUN apt update && \
     apt install -y --no-install-recommends \
         libbz2-dev \
         liblzo2-dev \
+        libgcrypt20-dev \
         librdmacm-dev \
         libsasl2-dev \
         libsnappy-dev \
--=20
2.21.1


