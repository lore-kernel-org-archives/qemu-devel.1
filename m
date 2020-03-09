Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F1C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D7720727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dnuk7+r4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D7720727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHnZ-0002w3-TL
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBHT9-0000kt-P4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBHT8-0005Ev-Jt
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:25:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBHT8-0005Bc-4D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583756712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1UIJmWp50NCXJ9jA3JpEhNiS4tUEpUfB6wtljAS87M=;
 b=Dnuk7+r44juGgQjAgEP8aUJ9nas3kRQUjQ30D2YvhZanKNc4A8/MH+/msC33r7k7c8Yzq/
 3BUpw/zLpXOFsnb1b9aaepuoU+KN3+tbk1R4JrXkJ/4R3mD5SxrrbbCBERXY3QNSHINU/V
 eM31EdYwBXMDMqcGlOU+MA4w2dO4pUw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-3AWDmbtJNr2xVZnLaufDLQ-1; Mon, 09 Mar 2020 08:25:11 -0400
X-MC-Unique: 3AWDmbtJNr2xVZnLaufDLQ-1
Received: by mail-wr1-f70.google.com with SMTP id j17so455124wru.19
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 05:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WtSYnxMTIM2oSCTkFU21A7hWXD9gH2v5a4TadNHL0EQ=;
 b=QgOV3K7VB8mpsJCwTtK2N/PgVEfho+GQWXODOjDK3KwwsPC9T0y2ZACy/coqa0vqyJ
 kXaxPE45kdqF5cWGjcbyjqKj0iFsWbfpBQQ/IZZNzIUWY5OyMJw3olYtxnyEt6MGJjC4
 ebq5i/pfIxFQgVKHm8rxJdKLi7hekbQ8xsrAl7IaOj5GCbZkRSbxzNrwC3PBW0vEzni7
 f65IO3SyLAEtQtMU13HdhWxKYe3QeU7I2eewyldMr9dVTk8miPQurXHqZZPIKiGOH+Bg
 Oup2uOPW0JtwBbkRE6u3IIuUNhBGWFn4qR7XF5F285F6lFVW/ah7VtHy/AgBWhzPtLPv
 2nxg==
X-Gm-Message-State: ANhLgQ3XGry3ZLPx8z1uL1AuJ2WM308ttBhI2AK/7ySStxD28ByX7xSq
 gGno2Tp8hbVUwvG194CXyxxW7fEP+pekHGo87vqa5VqjkW/R4n4KMwGOi1sqPe8gIhT2/GElEP/
 4f+TvIXajH1bScdQ=
X-Received: by 2002:a5d:640e:: with SMTP id z14mr6417604wru.204.1583756709482; 
 Mon, 09 Mar 2020 05:25:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv1/ZMZyQiOQQODKhAnvnqYZuAATY//ISYLjApLUNURBLvmbdVT3xtt6MJbEZMi8l5urw/Y9Q==
X-Received: by 2002:a5d:640e:: with SMTP id z14mr6417588wru.204.1583756709332; 
 Mon, 09 Mar 2020 05:25:09 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id s14sm49317097wrv.44.2020.03.09.05.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 05:25:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] tests/docker: Install SASL library to extend code
 coverage on amd64
Date: Mon,  9 Mar 2020 13:24:54 +0100
Message-Id: <20200309122454.22551-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309122454.22551-1-philmd@redhat.com>
References: <20200309122454.22551-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9=20=D0=9F=D0=B0=D0=B2=D0=BB=D0=BE=D0=B2?=
 <alexey.pawlow@gmail.com>,
 =?UTF-8?q?=D0=9C=D0=B5=D1=82=D0=BB=D0=B8=D1=86=D0=BA=D0=B8=D0=B9=20=D0=AE=D1=80=D0=B8=D0=B9=20=D0=92=D0=B8=D0=BA=D1=82=D0=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87?=
 <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install the SASL library to build the VNC SASL auth protocol code.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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


