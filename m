Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9118C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94FA20702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTUlq948"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94FA20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51483 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwupg-00069N-Tb
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwuoi-0004NE-JT
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwuoh-0008OW-BF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29434
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwuoh-0008OJ-7W
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CozjYogK+MTL4Nj0sSGoUCM1eCoUClPwxenFA/JCEiw=;
 b=ZTUlq948Hy0blVQ4forBp9jF1DWM9DCxHVB+Bzef9rsv+7B9SJvGwfG12IdnbaOnGfP1zC
 3e1K9QBT3kRVlLnXqs0K7rkdpWcy0zrhtvykv54biBUh6WFS79rfhnWrGaA0/EBRdZEq6A
 AJ+qVQ8G9mz18SdoCx3C0MFm7r5K/6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-YNdXmr0CMRq1nR9El42gFw-1; Wed, 29 Jan 2020 16:24:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39F6010054E3;
 Wed, 29 Jan 2020 21:24:02 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E98060BF3;
 Wed, 29 Jan 2020 21:24:00 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 03/29] python/qemu: Add binutils::binary_get_version()
Date: Wed, 29 Jan 2020 22:23:19 +0100
Message-Id: <20200129212345.20547-4-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: YNdXmr0CMRq1nR9El42gFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a helper to query the version of a QEMU binary.
We simply send the 'query-version' command over a QMP
socket.
Introduce the PythonQemuCoreScripts class to test our
new helper.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/binutils.py          | 38 ++++++++++++++++++++++++++++++++
 tests/acceptance/core_scripts.py | 31 ++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 python/qemu/binutils.py
 create mode 100644 tests/acceptance/core_scripts.py

diff --git a/python/qemu/binutils.py b/python/qemu/binutils.py
new file mode 100644
index 0000000000..96b200eef4
--- /dev/null
+++ b/python/qemu/binutils.py
@@ -0,0 +1,38 @@
+"""
+QEMU binary utility module:
+
+The binary utility module provides helpers to query QEMU binary for
+build-dependent configuration options at runtime.
+"""
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later=
.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import logging
+
+from .machine import QEMUMachine
+
+LOG =3D logging.getLogger(__name__)
+
+
+def binary_get_version(qemu_bin):
+    '''
+    Get QEMU binary version
+
+    @param qemu_bin (str): path to the QEMU binary
+    @return binary version (dictionary with major/minor/micro keys)
+    '''
+    with QEMUMachine(qemu_bin) as vm:
+        vm.set_machine('none')
+        vm.launch()
+        res =3D vm.command('query-version')
+        LOG.info(res)
+        vm.shutdown()
+        return res['qemu']
diff --git a/tests/acceptance/core_scripts.py b/tests/acceptance/core_scrip=
ts.py
new file mode 100644
index 0000000000..3f253337cd
--- /dev/null
+++ b/tests/acceptance/core_scripts.py
@@ -0,0 +1,31 @@
+# Tests covering various python/qemu/ scripts
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later=
.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import sys
+import os
+import logging
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
+from avocado_qemu import Test
+from qemu.binutils import binary_get_version
+
+
+class PythonQemuCoreScripts(Test):
+
+    def test_get_version(self):
+        logger =3D logging.getLogger('core')
+        version =3D binary_get_version(self.qemu_bin)
+        logger.debug('version: {}'.format(version))
+        # QMP 'query-version' introduced with QEMU v0.14
+        self.assertGreaterEqual(version['major'], 0)
+        if version['major'] =3D=3D 0:
+            self.assertGreaterEqual(version['minor'], 14)
--=20
2.21.1


