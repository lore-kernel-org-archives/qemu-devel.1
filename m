Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA14CC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E55D20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTNIgwi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E55D20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5gl-0003oN-3K
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:46:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ih5Du-0004MB-9t
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ih5Dt-00049Y-0e
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32471
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ih5Ds-00049D-SI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576559800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VC3E9bUtyognMzeek+bKqozA8nCsA+Ong7czPK+2nI4=;
 b=jTNIgwi0GeCImELXXKPDdVDgHlp2JEx2XZpXyYPQZ3UnjC4lu9C11a8cIGJ9CQ7KTprPQO
 GYSY8b5BqfYopi0vftd2tAZN61Ygpq6N5F0R3s9vLXiY721MVqRrXVgY02cuTuluYFecTP
 ERntB9LCjmqkHCxEmwFGMe1S5UPYRtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-CKfxVonHOiG_wpVV9bHLHQ-1; Tue, 17 Dec 2019 00:16:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 179DADC21;
 Tue, 17 Dec 2019 05:16:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-6.gru2.redhat.com
 [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9700D19C4F;
 Tue, 17 Dec 2019 05:16:27 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 11/15] python/qemu: Move kvm_available() to its own module
Date: Tue, 17 Dec 2019 00:15:17 -0500
Message-Id: <20191217051521.1239-12-crosa@redhat.com>
In-Reply-To: <20191217051521.1239-1-crosa@redhat.com>
References: <20191217051521.1239-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CKfxVonHOiG_wpVV9bHLHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

This creates the 'accel' Python module to be the home for
utilities that deal with accelerators. Also moved kvm_available()
from __init__.py to this new module.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191216191438.93418-2-wainersm@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 python/qemu/__init__.py               | 20 +-------------------
 python/qemu/{__init__.py =3D> accel.py} | 16 ++++++----------
 tests/vm/basevm.py                    |  2 +-
 3 files changed, 8 insertions(+), 30 deletions(-)
 copy python/qemu/{__init__.py =3D> accel.py} (84%)

diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
index 6c919a3d56..eff17a306e 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/__init__.py
@@ -12,24 +12,6 @@
 # Based on qmp.py.
 #
=20
-import logging
-import os
-
 from . import qmp
 from . import machine
-
-LOG =3D logging.getLogger(__name__)
-
-# Mapping host architecture to any additional architectures it can
-# support which often includes its 32 bit cousin.
-ADDITIONAL_ARCHES =3D {
-    "x86_64" : "i386",
-    "aarch64" : "armhf"
-}
-
-def kvm_available(target_arch=3DNone):
-    host_arch =3D os.uname()[4]
-    if target_arch and target_arch !=3D host_arch:
-        if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
-            return False
-    return os.access("/dev/kvm", os.R_OK | os.W_OK)
+from . import accel
diff --git a/python/qemu/__init__.py b/python/qemu/accel.py
similarity index 84%
copy from python/qemu/__init__.py
copy to python/qemu/accel.py
index 6c919a3d56..cbeac10dd1 100644
--- a/python/qemu/__init__.py
+++ b/python/qemu/accel.py
@@ -1,5 +1,9 @@
-# QEMU library
-#
+"""
+QEMU accel module:
+
+This module provides utilities for discover and check the availability of
+accelerators.
+"""
 # Copyright (C) 2015-2016 Red Hat Inc.
 # Copyright (C) 2012 IBM Corp.
 #
@@ -9,17 +13,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
 #
-# Based on qmp.py.
-#
=20
-import logging
 import os
=20
-from . import qmp
-from . import machine
-
-LOG =3D logging.getLogger(__name__)
-
 # Mapping host architecture to any additional architectures it can
 # support which often includes its 32 bit cousin.
 ADDITIONAL_ARCHES =3D {
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 0b8c1b2657..53b9515ee2 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -21,7 +21,7 @@ import logging
 import time
 import datetime
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
-from qemu import kvm_available
+from qemu.accel import kvm_available
 from qemu.machine import QEMUMachine
 import subprocess
 import hashlib
--=20
2.21.0


