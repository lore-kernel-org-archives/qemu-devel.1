Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B0DC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184EB20767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6r/jcu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184EB20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFMz8-00071J-6C
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 15:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFMyD-0005My-6j
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFMyC-0000SI-53
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32669)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFMyC-0000S6-1C
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584731171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BI3CU53utsPO+Tb4X7/sEAnrYB8Z4l9ApbiifxW226M=;
 b=O6r/jcu5VXYb8uAxFMeoRzOXS+9RbNGH+pGyNfj1MQOd2dsYSVsAjlrVxT4iDtLuz71jrA
 T2iSSaX/R6w1chhxImXZlQit6OwMwcuv2keMFnNC36Z+Xib9FIUAPfHI3HyioPRlovNfRb
 ekB/f80BB+mrTjELozLjByvcMwJJFAU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-OStm0tt4OZSLbYdkQushTA-1; Fri, 20 Mar 2020 15:06:09 -0400
X-MC-Unique: OStm0tt4OZSLbYdkQushTA-1
Received: by mail-wm1-f72.google.com with SMTP id 7so498598wmg.4
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 12:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qh+QkdwguaGGgaxA6kiZOQLA7e4zuciqa7fH19CdweY=;
 b=lcf39W8BKVXmGDVM/2mAkpRj6yj3/fX+ey4v05kp9XHgWSsxXqVb4E/p6hFjnR7SX/
 1zDH/YJBG+/NznI+51mGbhyZOwQRjQrmYcbEldfWrwuxrVMoeyCUt44sFw2vjwba1077
 4hBH3VbRBvOxknZiYdQ8HatjBf3js4T5gIHictYU2v/WkNCIotHcNqvsZfMPcMYRdtUJ
 r24ezVMsu+msyo4j4p1TKYeNPtE4rCWHjiGb7wSqBYrQIRquCaZOETA2wGF5y9xrFxVO
 LqsEJSRJpbKIHG0hxa3Qa4ZJXw9NxXLMwbppPescYyj5k6ozejIjWByq2oeripM/FSns
 /9yg==
X-Gm-Message-State: ANhLgQ08ZVcn5EuIGJeby5+4Q32k5tFZWosm+M2B/bHjL2+rhR0YI6jA
 bLMHuFgTF66AyNPIQfDUXWdqYhz9BrbvaGrXjCNE4ks4Fhjtbqn69Fzp/kvJxfuFeda3abp9I+S
 RyI07FozhAuHQC8U=
X-Received: by 2002:a05:600c:258c:: with SMTP id
 12mr12414969wmh.140.1584731168335; 
 Fri, 20 Mar 2020 12:06:08 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv4I/3a1bcOUytYEWszq3dC+/AuOl0xZviQ+VaNmXEJgd2Uwxpd5AnEJAnOpPNlS6wZ/8Ifdg==
X-Received: by 2002:a05:600c:258c:: with SMTP id
 12mr12414944wmh.140.1584731168129; 
 Fri, 20 Mar 2020 12:06:08 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id f9sm9970136wro.47.2020.03.20.12.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 12:06:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 2/4] tests/docker: Install gcrypt devel package in
 Debian image
Date: Fri, 20 Mar 2020 20:05:51 +0100
Message-Id: <20200320190553.9363-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320190553.9363-1-philmd@redhat.com>
References: <20200320190553.9363-1-philmd@redhat.com>
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

Apparently Debian Stretch was listing gcrypt as a QEMU dependency,
but this is not the case anymore in Buster, so we need to install
it manually (it it not listed by 'apt-get -s build-dep qemu' in
the common debian10.docker anymore).

 $ ../configure $QEMU_CONFIGURE_OPTS

  ERROR: User requested feature gcrypt
         configure was not able to find it.
         Install gcrypt devel >=3D 1.5.0

Fixes: 698a71edbed & 6f8bbb374be
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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


