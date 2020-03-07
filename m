Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36194C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A0620674
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 17:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWk/yfGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A0620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAdAt-0006lt-8k
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 12:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAd9v-0005mF-V4
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAd9u-0005ax-On
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24217
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAd9u-0005ZE-L7
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 12:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583601762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBJ1sudf5WnnIaHPde8WDgODXPCnsbhLM8rbqsSbxFI=;
 b=fWk/yfGNGrsSHl6SntbZ2KvCKaMxU5xLz3eI8jvS9PNP/vBOAJyKa8iUGYsWdFdhVqTF+z
 xUkyGcloGnjXi9i4JrHYiPydvoocYLwkKCVJt9WR3/5UtE9bBQiIJeAOnskh5XVDAdxKu7
 OITgHliKd3N6ybD8xQkC8nvZxIcYM3E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-87mcYfgiN7Our3ygrlnUPg-1; Sat, 07 Mar 2020 12:22:40 -0500
X-MC-Unique: 87mcYfgiN7Our3ygrlnUPg-1
Received: by mail-wr1-f71.google.com with SMTP id y5so1973097wrq.8
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2020 09:22:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gH+PqTi7GdMZxsgDCI5jLrLvY6uT/rdhdrDjJ1UgrFU=;
 b=NeV/lDiY5Gex857HPO7clh4YBIdOYi7l783bfMmEM3PGN0rT44zujJOa6P2MrFzBDB
 DCWglAkgkNtRyt8kyJcbWnHDcuMg0aPfM1yZRzJQlfld2EkGuEKnb5076HXszLna8PQ8
 wSw1cWSS00Lp15vKyqkUneDGxnU6qkYHZNSFCHXYsoWxafGO9Nq0YdICEK8hFE5PGGQy
 E4+RRXlc0rC5iqHqthfC7uaQa+zNpSFiHQjYfLyScWInaWVBESJwrBKZ5Z5xTdAGxyi/
 U52XZbatH/yWgK88Hg35PYCgoO3W8NdBazEZEYlkqLU6CS+CO98ZAFx8rcJrrDyGyg3M
 SVTA==
X-Gm-Message-State: ANhLgQ0iIk1squhAK7cnRZDDiRB+kRkGXAkpfcdqhje2NQ0ctZKbV1WS
 s4WiHXpM5hMQ7qxYvfYhmZWhdtN32XYP4HL7NMd0GRVnvtcMugK55xcODsiY1b1wQLeVyh5lBte
 Y/qyHuk2ZYzRABOs=
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr8846420wmb.81.1583601758936; 
 Sat, 07 Mar 2020 09:22:38 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvhCY0Ko3v2KLxDptgqCScrHgxUdUEebQp/4yxib+vRMI2iV+JdmXNuPQRzC0jEUSu1xViK7g==
X-Received: by 2002:a1c:5fc4:: with SMTP id t187mr8846400wmb.81.1583601758773; 
 Sat, 07 Mar 2020 09:22:38 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id b24sm18074821wmj.13.2020.03.07.09.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2020 09:22:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/docker: Install SASL library to extend code
 coverage on amd64
Date: Sat,  7 Mar 2020 18:22:22 +0100
Message-Id: <20200307172222.14764-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200307172222.14764-1-philmd@redhat.com>
References: <20200307172222.14764-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9=20=D0=9F=D0=B0=D0=B2=D0=BB=D0=BE=D0=B2?=
 <alexey.pawlow@gmail.com>,
 =?UTF-8?q?=D0=9C=D0=B5=D1=82=D0=BB=D0=B8=D1=86=D0=BA=D0=B8=D0=B9=20=D0=AE=D1=80=D0=B8=D0=B9=20=D0=92=D0=B8=D0=BA=D1=82=D0=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87?=
 <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install the SASL library to build the VNC SASL auth protocol code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/do=
ckerfiles/debian-amd64.docker
index 3b860af106..0456fc7a0c 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -17,6 +17,7 @@ RUN apt update && \
         libbz2-dev \
         liblzo2-dev \
         librdmacm-dev \
+        libsasl2-dev \
         libsnappy-dev \
         libvte-dev
=20
--=20
2.21.1


