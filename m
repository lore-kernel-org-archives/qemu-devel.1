Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFE3C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7C224685
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hL8N6PPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7C224685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1yeN-0000nG-9N
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1ybq-0005y5-E7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1ybp-0001m5-9w
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1ybp-0001lL-3M
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581539263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r2Wz558U9wVJDH89Gu47AWDi63xsJ973GjLCuPw1D5A=;
 b=hL8N6PPF60chXtHO4AYGXEukVFDWaJVKbnSiPQAEvtEVx141m8jkIrItMsPXEhCZMKHq0D
 q7mIZ1b06CLHIC2ut+Ane6utzhsu/kQC2g5UxJ5cq3ezkEyC2ITx5yBjp3QFRVZnbu3GXa
 HWJkirBys1w6RvreJ8U/bYxFQ5jaWJA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-6V_CscO2MPmpugWppYIl7A-1; Wed, 12 Feb 2020 15:27:42 -0500
Received: by mail-wm1-f69.google.com with SMTP id z7so1439274wmi.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NECG2RR5sx/M/Q1IqDusFs0lGE/ZPcLiLdwmgWxl1Jw=;
 b=VJv2hgwagMYSgyWOnA/nokpw85vBSr8+11dWoIjCkV3Ih6R4/ocCUwxfeh3lT3CmGg
 W2yhV9R7WrS/wxUi1XilpJvt/+9G7pgSOslV9S4dATNOm5YUYpj+uXBREAtkUWw6PAR/
 TBkAIgScEf00ugRxEt8vXz6IcueSM7D53eRS+FsjlD6rATwm3TK/kB7r2q4oO41vAW+N
 aYcSrEJy9OKm/ZWWyEFAK5RWGM7yNBoGNzny2ovNBwL2q70aMUfV+F1xy7GQrB33VMBK
 EmqCpuClakrHp+YoNsVAZrp251rB316abhEiRKJeNeNzqWikuH90IKy4kayR7THS/EyS
 U6bQ==
X-Gm-Message-State: APjAAAWYs2pwwOx/vOxNo+PaUOJ/5dkbQA6t5FAGhvc9V74E3YKik42s
 VQ03VlbjuybhW4nC+f0E+VqmZna051nr+jx7rEBqt5O6nsPJDhWdoVFyQDG/HJ6Rr2yo6B26f9A
 9QxHSCFET/nY68EM=
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr16341241wro.375.1581539260538; 
 Wed, 12 Feb 2020 12:27:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMh21P2iMO4YtwJqgybVyp/irc7p/ig2JHP42OsDbiA4SXihdW/EFN1VKJqLF93A3gpGf8hQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr16341229wro.375.1581539260367; 
 Wed, 12 Feb 2020 12:27:40 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y139sm2233757wmd.24.2020.02.12.12.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 12:27:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/docker: Install tools to cross-debug and build Linux
 kernels
Date: Wed, 12 Feb 2020 21:27:38 +0100
Message-Id: <20200212202738.12986-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: 6V_CscO2MPmpugWppYIl7A-1
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

We often run Linux kernels to test QEMU. We sometimes need
to build them manually to use non-default features. We only
miss the tiny 'bc' tool.

The ncurses library is helpful to run 'make menuconfig'.

Finally, gdb-multiarch allow us to debug a TCG guest when its
architecture is different than the host.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian10.docker | 3 +++
 tests/docker/dockerfiles/debian9.docker  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/docker=
files/debian10.docker
index 5de79ae552..2fcdc406e8 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -17,14 +17,17 @@ RUN apt update && \
     DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt install -y --no-install-recommends \
+        bc \
         bison \
         build-essential \
         ca-certificates \
         clang \
         dbus \
         flex \
+        gdb-multiarch \
         gettext \
         git \
+        libncurses5-dev \
         pkg-config \
         psmisc \
         python3 \
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerf=
iles/debian9.docker
index 8cbd742bb5..92edbbf0f4 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -17,13 +17,16 @@ RUN apt update && \
     DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt install -y --no-install-recommends \
+        bc \
         bison \
         build-essential \
         ca-certificates \
         clang \
         flex \
+        gdb-multiarch \
         gettext \
         git \
+        libncurses5-dev \
         pkg-config \
         psmisc \
         python3 \
--=20
2.21.1


