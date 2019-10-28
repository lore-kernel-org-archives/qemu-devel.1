Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB58CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB45F214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlzrouWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB45F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzbS-0006j6-7F
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzZf-00042B-VA
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzZe-0002qQ-In
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:36:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27725
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzZe-0002q5-EX
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVLHaBXaewDE1UDpHAgCzCVsYc9pZRiy5F+75Z2ZeoA=;
 b=hlzrouWngNyV5L+UgRzXqRNTLjUsfL2RoJgdPnh2TqBcJrBUO+hEIcxJV98Ruq4V67V0/x
 KkC7I8m3u+KR33R06+3q4dYIh4lLxVA9pycsHz+qgwnzRsdPXvkyAcIKF9RdT2DtCxsDQG
 ligW/n0tt3lLtapVl8Ns7RT7c7fYTDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-ynCwNO7xPly6I7NO7QOkMQ-1; Mon, 28 Oct 2019 03:36:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F42A107AD28;
 Mon, 28 Oct 2019 07:36:13 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BC06165DB;
 Mon, 28 Oct 2019 07:36:07 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/26] tests/acceptance: Add test that boots the HelenOS
 microkernel on Leon3
Date: Mon, 28 Oct 2019 08:34:25 +0100
Message-Id: <20191028073441.6448-11-philmd@redhat.com>
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
References: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: ynCwNO7xPly6I7NO7QOkMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Release notes:
http://www.helenos.org/wiki/Download#HelenOS0.6.0

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 MAINTAINERS                             |  1 +
 tests/acceptance/machine_sparc_leon3.py | 37 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tests/acceptance/machine_sparc_leon3.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 556ce0bfe3..17ff741c63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1173,6 +1173,7 @@ S: Maintained
 F: hw/sparc/leon3.c
 F: hw/*/grlib*
 F: include/hw/*/grlib*
+F: tests/acceptance/machine_sparc_leon3.py
=20
 S390 Machines
 -------------
diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance/mac=
hine_sparc_leon3.py
new file mode 100644
index 0000000000..a1394ba8ad
--- /dev/null
+++ b/tests/acceptance/machine_sparc_leon3.py
@@ -0,0 +1,37 @@
+# Functional test that boots a Leon3 machine and checks its serial console=
.
+#
+# Copyright (c) Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import os
+import logging
+
+from avocado import skipIf
+from avocado_qemu import MachineTest
+
+
+class Leon3Machine(MachineTest):
+
+    timeout =3D 60
+
+    def test_leon3_helenos_uimage(self):
+        """
+        :avocado: tags=3Darch:sparc
+        :avocado: tags=3Dmachine:leon3
+        :avocado: tags=3Dbinfmt:uimage
+        """
+        kernel_url =3D ('http://www.helenos.org/releases/'
+                      'HelenOS-0.6.0-sparc32-leon3.bin')
+        kernel_hash =3D 'a88c9cfdb8430c66650e5290a08765f9bf049a30'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
+
+        self.vm.set_machine('leon3_generic')
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path)
+
+        self.vm.launch()
+
+        wait_for_console_pattern(self,'Copyright (c) 2001-2014 HelenOS pro=
ject')
+        wait_for_console_pattern(self,'Booting the kernel ...')
--=20
2.21.0


