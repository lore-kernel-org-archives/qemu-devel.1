Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EDFC33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D80320720
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 14:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frZv65WA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D80320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw5b6-00030Q-J5
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 09:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iw5aE-0002Bb-7p
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iw5aC-0002R9-Fs
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:41:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42950
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iw5aC-0002Qd-Am
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 09:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580136103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jxMld//p9nIoSEIK1/s/JmrCXmNJEodd+FZJ21SJ4XI=;
 b=frZv65WAyAcL/uHFGuEfBGAKmHURKedfa89BOnqc/nwT9u/xCQsF+vxUuweNIfEgaw2VZA
 Kl1/Dg46ifRQH7yIZE2g1hqinzs6iqlkAsNm+C/SQbkwVvEhhZvwosXci9NfU2OzKcLSr/
 KMysrTZRh4IUzLxpv7ixUi7EaTI3rIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-c9gyecCIPpax7YppQWCKfw-1; Mon, 27 Jan 2020 09:41:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 486F818FF663;
 Mon, 27 Jan 2020 14:41:37 +0000 (UTC)
Received: from thuth.com (ovpn-117-94.ams2.redhat.com [10.36.117.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCDB460BF4;
 Mon, 27 Jan 2020 14:41:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance: Add a test for the canon-a1100 machine
Date: Mon, 27 Jan 2020 15:41:26 +0100
Message-Id: <20200127144126.15515-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: c9gyecCIPpax7YppQWCKfw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The canon-a1100 machine can be used with the Barebox firmware. The
QEMU Advent Calendar 2018 features a pre-compiled image which we
can use for testing.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/acceptance/machine_arm_canon-a1100.py | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 tests/acceptance/machine_arm_canon-a1100.py

diff --git a/tests/acceptance/machine_arm_canon-a1100.py b/tests/acceptance=
/machine_arm_canon-a1100.py
new file mode 100644
index 0000000000..3888168451
--- /dev/null
+++ b/tests/acceptance/machine_arm_canon-a1100.py
@@ -0,0 +1,33 @@
+# Functional test that boots the canon-a1100 machine with firmware
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
+from avocado.utils import archive
+
+class CanonA1100Machine(Test):
+
+    timeout =3D 90
+
+    def test_arm_canona1100(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:canon-a1100
+        """
+        tar_url =3D ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day18.tar.xz')
+        tar_hash =3D '068b5fc4242b29381acee94713509f8a876e9db6'
+        file_path =3D self.fetch_asset(tar_url, asset_hash=3Dtar_hash)
+        archive.extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-bios',
+                         self.workdir + '/day18/barebox.canon-a1100.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'running /env/bin/init')
--=20
2.18.1


