Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE9DC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEF72072B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaS25IoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEF72072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5Q4-0005iM-37
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ih5DJ-0003Kz-U5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ih5DI-0003cj-Ge
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28556
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ih5DI-0003bC-DK
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576559763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnxf8sfzIAVFpqegiNwwqTzgx0xhyT5dLDF1Z50dmzM=;
 b=HaS25IoO696Uhc6BNZFao/EL591fk5l5A3NrJOe53X9902e8+eDU2XlbeZmcO9UMlIyYzO
 gh5HkMqKw0vnr6aS/FvRvN8U5YgDOxQbI+POceYg23R5JB0nNbTnf9nrj6Zkm+IHmh0aUU
 +3Yd18S6ztxAgmNy5GWr1i+j3P9eMc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-1VB2ToWuMsW5DgTq33ZYxQ-1; Tue, 17 Dec 2019 00:15:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A3BB8017DF;
 Tue, 17 Dec 2019 05:15:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-6.gru2.redhat.com
 [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A17F419C4F;
 Tue, 17 Dec 2019 05:15:48 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/15] analyze-migration.py: replace numpy with python 3.2
Date: Tue, 17 Dec 2019 00:15:10 -0500
Message-Id: <20191217051521.1239-5-crosa@redhat.com>
In-Reply-To: <20191217051521.1239-1-crosa@redhat.com>
References: <20191217051521.1239-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 1VB2ToWuMsW5DgTq33ZYxQ-1
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Use int.from_bytes() from python 3.2 instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191127101038.327080-3-marcandre.lureau@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/analyze-migration.py | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 2b835d9b70..96a31d3974 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 #  Migration Stream Analyzer
 #
@@ -17,12 +17,18 @@
 # You should have received a copy of the GNU Lesser General Public
 # License along with this library; if not, see <http://www.gnu.org/license=
s/>.
=20
-from __future__ import print_function
-import numpy as np
 import json
 import os
 import argparse
 import collections
+import struct
+import sys
+
+
+MIN_PYTHON =3D (3, 2)
+if sys.version_info < MIN_PYTHON:
+    sys.exit("Python %s.%s or later is required.\n" % MIN_PYTHON)
+
=20
 def mkdir_p(path):
     try:
@@ -30,29 +36,26 @@ def mkdir_p(path):
     except OSError:
         pass
=20
+
 class MigrationFile(object):
     def __init__(self, filename):
         self.filename =3D filename
         self.file =3D open(self.filename, "rb")
=20
     def read64(self):
-        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i8'=
)[0])
+        return int.from_bytes(self.file.read(8), byteorder=3D'big', signed=
=3DTrue)
=20
     def read32(self):
-        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i4'=
)[0])
+        return int.from_bytes(self.file.read(4), byteorder=3D'big', signed=
=3DTrue)
=20
     def read16(self):
-        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i2'=
)[0])
+        return int.from_bytes(self.file.read(2), byteorder=3D'big', signed=
=3DTrue)
=20
     def read8(self):
-        return np.asscalar(np.fromfile(self.file, count=3D1, dtype=3D'>i1'=
)[0])
+        return int.from_bytes(self.file.read(1), byteorder=3D'big', signed=
=3DTrue)
=20
     def readstr(self, len =3D None):
-        if len is None:
-            len =3D self.read8()
-        if len =3D=3D 0:
-            return ""
-        return np.fromfile(self.file, count=3D1, dtype=3D('S%d' % len))[0]
+        return self.readvar(len).decode('utf-8')
=20
     def readvar(self, size =3D None):
         if size is None:
@@ -275,7 +278,7 @@ class VMSDFieldGeneric(object):
         return str(self.__str__())
=20
     def __str__(self):
-        return " ".join("{0:02x}".format(ord(c)) for c in self.data)
+        return " ".join("{0:02x}".format(c) for c in self.data)
=20
     def getDict(self):
         return self.__str__()
@@ -307,8 +310,8 @@ class VMSDFieldInt(VMSDFieldGeneric):
=20
     def read(self):
         super(VMSDFieldInt, self).read()
-        self.sdata =3D np.fromstring(self.data, count=3D1, dtype=3D(self.s=
dtype))[0]
-        self.udata =3D np.fromstring(self.data, count=3D1, dtype=3D(self.u=
dtype))[0]
+        self.sdata =3D int.from_bytes(self.data, byteorder=3D'big', signed=
=3DTrue)
+        self.udata =3D int.from_bytes(self.data, byteorder=3D'big', signed=
=3DFalse)
         self.data =3D self.sdata
         return self.data
=20
@@ -363,7 +366,7 @@ class VMSDFieldStruct(VMSDFieldGeneric):
             array_len =3D field.pop('array_len')
             field['index'] =3D 0
             new_fields.append(field)
-            for i in xrange(1, array_len):
+            for i in range(1, array_len):
                 c =3D field.copy()
                 c['index'] =3D i
                 new_fields.append(c)
--=20
2.21.0


