Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB25C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4682084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+1QKluG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4682084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6e0C-0004Bn-0Y
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:28:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6dxc-0001ap-PQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6dxb-0008Jj-9k
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:25:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43761
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6dxb-0008J5-4e
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582651530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0sDdYdU2Zg83hGZi3GeRkZRcAWYITv/cxF0BtQAkBg=;
 b=h+1QKluGdbtKIpx2F4eAWH9NO49Q4ikgV4btZLGfSxxMlZgLtBaDXvrylRxBKdcRIX1r+r
 pE0jHkfKD9LLl2bl1rNuTVJ366EuBUcqa1nqa06rDjqJvLrmQGYO0uIai+x8lJs79sRX/7
 D8+QiMwqXX5rkjVxd9oVmp1VAZD5rIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70--UjjEoXJO0aaisDBY_C-vA-1; Tue, 25 Feb 2020 12:25:23 -0500
X-MC-Unique: -UjjEoXJO0aaisDBY_C-vA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0F5E800D5B;
 Tue, 25 Feb 2020 17:25:22 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-195.brq.redhat.com [10.40.205.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B23FF61069;
 Tue, 25 Feb 2020 17:25:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] tests/acceptance/integratorcp: Verify Tux is displayed on
 framebuffer
Date: Tue, 25 Feb 2020 18:25:01 +0100
Message-Id: <20200225172501.29609-5-philmd@redhat.com>
In-Reply-To: <20200225172501.29609-1-philmd@redhat.com>
References: <20200225172501.29609-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Add a test that verifies the Tux logo is displayed on the framebuffer.

We simply follow the OpenCV "Template Matching with Multiple Objects"
tutorial, replacing Lionel Messi by Tux:
https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html

When OpenCV and NumPy are installed, this test can be run using:

  $ AVOCADO_ALLOW_UNTRUSTED_CODE=3Dhmmm \
    avocado --show=3Dapp,framebuffer run -t device:framebuffer \
      tests/acceptance/machine_arm_integratorcp.py
  JOB ID     : 8c46b0f8269242e87d738247883ea2a470df949e
  JOB LOG    : avocado/job-results/job-2020-01-31T21.38-8c46b0f/job.log
   (1/1) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachine.tes=
t_framebuffer_tux_logo:
  framebuffer: found Tux at position [x, y] =3D (0, 0)
  PASS (3.96 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 4.23 s

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200131211102.29612-3-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 tests/acceptance/machine_arm_integratorcp.py | 52 ++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/acceptanc=
e/machine_arm_integratorcp.py
index 22afd3b82a..49c8ebff78 100644
--- a/tests/acceptance/machine_arm_integratorcp.py
+++ b/tests/acceptance/machine_arm_integratorcp.py
@@ -9,11 +9,26 @@
 # later.  See the COPYING file in the top-level directory.
=20
 import os
+import logging
=20
 from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import wait_for_console_pattern
=20
+
+NUMPY_AVAILABLE =3D True
+try:
+    import numpy as np
+except ImportError:
+    NUMPY_AVAILABLE =3D False
+
+CV2_AVAILABLE =3D True
+try:
+    import cv2
+except ImportError:
+    CV2_AVAILABLE =3D False
+
+
 class IntegratorMachine(Test):
=20
     timeout =3D 90
@@ -45,3 +60,40 @@ def test_integratorcp_console(self):
         """
         self.boot_integratorcp()
         wait_for_console_pattern(self, 'Log in as root')
+
+    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
+    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
+    def test_framebuffer_tux_logo(self):
+        """
+        Boot Linux and verify the Tux logo is displayed on the framebuffer=
.
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:integratorcp
+        :avocado: tags=3Ddevice:pl110
+        :avocado: tags=3Ddevice:framebuffer
+        """
+        screendump_path =3D os.path.join(self.workdir, "screendump.pbm")
+        tuxlogo_url =3D ('https://github.com/torvalds/linux/raw/v2.6.12/'
+                       'drivers/video/logo/logo_linux_vga16.ppm')
+        tuxlogo_hash =3D '3991c2ddbd1ddaecda7601f8aafbcf5b02dc86af'
+        tuxlogo_path =3D self.fetch_asset(tuxlogo_url, asset_hash=3Dtuxlog=
o_hash)
+
+        self.boot_integratorcp()
+        framebuffer_ready =3D 'Console: switching to colour frame buffer d=
evice'
+        wait_for_console_pattern(self, framebuffer_ready)
+        self.vm.command('human-monitor-command', command_line=3D'stop')
+        self.vm.command('human-monitor-command',
+                        command_line=3D'screendump %s' % screendump_path)
+        logger =3D logging.getLogger('framebuffer')
+
+        cpu_count =3D 1
+        match_threshold =3D 0.92
+        screendump_bgr =3D cv2.imread(screendump_path)
+        screendump_gray =3D cv2.cvtColor(screendump_bgr, cv2.COLOR_BGR2GRA=
Y)
+        result =3D cv2.matchTemplate(screendump_gray, cv2.imread(tuxlogo_p=
ath, 0),
+                                   cv2.TM_CCOEFF_NORMED)
+        loc =3D np.where(result >=3D match_threshold)
+        tux_count =3D 0
+        for tux_count, pt in enumerate(zip(*loc[::-1]), start=3D1):
+            logger.debug('found Tux at position [x, y] =3D %s', pt)
+        self.assertGreaterEqual(tux_count, cpu_count)
--=20
2.21.1


