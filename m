Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D1C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 18:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A439220730
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 18:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VF8WXZNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A439220730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVg3L-0002J1-02
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 13:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iVg1S-0000aw-S8
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 13:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iVg1R-00022T-E5
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 13:08:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44051
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iVg1R-00021q-Ae
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 13:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573841320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTwoBZzhvVrQ8sIB4Y50CVXpuaNkV8Buw3+5mqXw8u8=;
 b=VF8WXZNY/VcCju9s7NJcwJfFPAvNvyttuumqWyqbf3LZh1M6eMWPuG1PT8XvaSVTN57XCQ
 F/y+FK63j0WHcoydA6o764NysDR4HZ3pSx8SFCYGqK1GdopWKt3UzrSG+7dS12zmi7Ounf
 r7d1vHRCAlJDUIMyrcrHivNC7VzNFZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-egsPnsN_OHGWF4Cdd58ISg-1; Fri, 15 Nov 2019 13:08:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DAAD1005500;
 Fri, 15 Nov 2019 18:08:37 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66EEC60557;
 Fri, 15 Nov 2019 18:08:36 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] python/qemu: Move kvm_available() to its own module
Date: Fri, 15 Nov 2019 13:08:26 -0500
Message-Id: <20191115180829.10275-2-wainersm@redhat.com>
In-Reply-To: <20191115180829.10275-1-wainersm@redhat.com>
References: <20191115180829.10275-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: egsPnsN_OHGWF4Cdd58ISg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: fam@euphon.net, ehabkost@redhat.com, philmd@redhat.com, jsnow@redhat.com,
 crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This creates the 'accel' Python module to be the home for
utilities that deal with accelerators. Also moved kvm_available()
from __init__.py to this new module.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 python/qemu/__init__.py | 20 +-------------------
 python/qemu/accel.py    | 36 ++++++++++++++++++++++++++++++++++++
 tests/vm/basevm.py      |  2 +-
 3 files changed, 38 insertions(+), 20 deletions(-)
 create mode 100644 python/qemu/accel.py

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
diff --git a/python/qemu/accel.py b/python/qemu/accel.py
new file mode 100644
index 0000000000..1b825126c5
--- /dev/null
+++ b/python/qemu/accel.py
@@ -0,0 +1,36 @@
+"""
+QEMU accel module:
+
+This module provides utilities for discover and check the availability of
+accelerators.
+"""
+# Copyright (C) 2015-2016 Red Hat Inc.
+# Copyright (C) 2012 IBM Corp.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+#
+# Based on qmp.py.
+#
+
+import logging
+import os
+
+LOG =3D logging.getLogger(__name__)
+
+# Mapping host architecture to any additional architectures it can
+# support which often includes its 32 bit cousin.
+ADDITIONAL_ARCHES =3D {
+    "x86_64" : "i386",
+    "aarch64" : "armhf"
+}
+
+def kvm_available(target_arch=3DNone):
+    host_arch =3D os.uname()[4]
+    if target_arch and target_arch !=3D host_arch:
+        if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
+            return False
+    return os.access("/dev/kvm", os.R_OK | os.W_OK)
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 91a9226026..3e2b69c96c 100755
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
2.18.1


