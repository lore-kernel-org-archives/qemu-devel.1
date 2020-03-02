Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB27C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368F62173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1pQib3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368F62173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8uP5-0003ZG-Eb
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8uOM-00038D-Kp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8uOK-000878-DL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:22:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20069
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8uOJ-00086z-Ea
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583191346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XIzzPU6TK1HvTc7AP1+zjNKaDnqrx+JRI5qcKpD826k=;
 b=H1pQib3L23e33k8HA2X/lujRn5m+FERM5+ymKeKVJH0vk1GTCqZ7fxUD1WjT1t9IhaH4DM
 M4ShVDHo8sTpg5BOel0M5htJ2DjEsNAEkEiiw7Tw4kzBOO7rsGcGrP9ZdjEzCr/LYz1sqI
 E+NkL1D73LOO/nQr2L+SKb6pW4NhRFY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-HLHAsI6yNNqlV_6FiV8r_w-1; Mon, 02 Mar 2020 18:22:24 -0500
X-MC-Unique: HLHAsI6yNNqlV_6FiV8r_w-1
Received: by mail-wr1-f71.google.com with SMTP id w6so373499wrm.16
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 15:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YmLWssg44GsN3l2TznuH1BZyXlCf0mTuIWiPnGS2M20=;
 b=sa/sjd9DhW/AqiKugdp+DLd1XU2+3lyQ6v9oOXrmaKsYFYbLBnP6jWJFShpRoeQSEn
 ZKJOMG8ZWHgo3kF8K0d0YWVnb49tIp026qxh9qy4FkalI4knXnn7XX2gBCBE1BwbdBme
 F6CQpi6WbDnKQ3B+0Dc6uPE6+yNimngc0hxk0AExpmtrSDoD1WpMkF963ZNTB8IkUuAt
 VoHHqMlZwxqS9Xf9zIdu5B47QKf0gB9oAPW2icZfcVVgStugUIM4JL9sDCL57w+JHI+u
 /L1X5mRCH9jTwaNSk8gXVEnqnibAYMXvZ4/sdkP4r60t8w3IykM/bhbKnkncyd9nZvsQ
 q4MQ==
X-Gm-Message-State: ANhLgQ3YKhh1zUHWQ5iqSY1OQwS1lYzLejssf51XwgwJ8qN9lDsKSEBa
 ax+8uWfMJrhL2Y0rK6nZE2zrmzVvjInTlWkdHd4fRRbn8IpVJSqswWS0JpzKpZHQ5kGvWTGIIQY
 LJwZiFNJ26S+0X+8=
X-Received: by 2002:adf:fa4a:: with SMTP id y10mr1738738wrr.322.1583191342554; 
 Mon, 02 Mar 2020 15:22:22 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuy4Z+MvAihMuJr/w/ukDe+oUAhBcvkC5ZZPN2dk0i/dGpotB/xuNN4wcYkRjSzDxlRHDjrtw==
X-Received: by 2002:adf:fa4a:: with SMTP id y10mr1738723wrr.322.1583191342333; 
 Mon, 02 Mar 2020 15:22:22 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id
 l17sm884645wmi.10.2020.03.02.15.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 15:22:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance: move @skipUnless decoration to test itself
Date: Tue,  3 Mar 2020 00:22:20 +0100
Message-Id: <20200302232220.761-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

It appears ignore the decoration if just applied to the class.

Fixes: 0484d9d4fbe9beacd
Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
[PMD: Move decorations to each test function]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/machine_mips_malta.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/mach=
ine_mips_malta.py
index 92b4f28a11..98463f7757 100644
--- a/tests/acceptance/machine_mips_malta.py
+++ b/tests/acceptance/machine_mips_malta.py
@@ -30,8 +30,6 @@
     CV2_AVAILABLE =3D False
=20
=20
-@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
-@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
 class MaltaMachineFramebuffer(Test):
=20
     timeout =3D 30
@@ -91,6 +89,8 @@ def do_test_i6400_framebuffer_logo(self, cpu_cores_count)=
:
             cv2.imwrite(debug_png, screendump_bgr)
         self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
=20
+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
     def test_mips_malta_i6400_framebuffer_logo_1core(self):
         """
         :avocado: tags=3Darch:mips64el
@@ -99,6 +99,8 @@ def test_mips_malta_i6400_framebuffer_logo_1core(self):
         """
         self.do_test_i6400_framebuffer_logo(1)
=20
+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
     def test_mips_malta_i6400_framebuffer_logo_7cores(self):
         """
         :avocado: tags=3Darch:mips64el
@@ -108,6 +110,8 @@ def test_mips_malta_i6400_framebuffer_logo_7cores(self)=
:
         """
         self.do_test_i6400_framebuffer_logo(7)
=20
+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
     def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         """
         :avocado: tags=3Darch:mips64el
--=20
2.21.1


