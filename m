Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB0CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 10:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0952071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 10:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hD7IZGXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0952071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZuJ8-0001Gs-WB
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 05:12:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iZuI1-0008RL-QF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iZuI0-0000Fa-DD
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:11:17 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iZuI0-0000Eu-4Y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 05:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574849475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UB2XnY70MSb2I8FZeFFjzSl2nlOMsaWbK6TzpJ3ZZ3s=;
 b=hD7IZGXsRRv0Vpo8eWOtMo8vTmJiAfNM8wB5oW3RfuFMa9zp3Yb124Jg7GfbxijmYt3qVS
 zzkrxlLFjNyXBA9K5M3LY2xg/D6LlVVmENRIpSSflrV28JGZILfa2Fh7jYaR68mgyk9x0R
 hqq09ujHYhvZoFkeUksqe86VG3KGv+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197--2tVxEqGPTGcSlgwoyJjuw-1; Wed, 27 Nov 2019 05:11:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B3B591223
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 10:11:12 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BA4019C6A;
 Wed, 27 Nov 2019 10:11:06 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] analyze-migration.py: replace numpy with python 3.2
Date: Wed, 27 Nov 2019 14:10:38 +0400
Message-Id: <20191127101038.327080-3-marcandre.lureau@redhat.com>
In-Reply-To: <20191127101038.327080-1-marcandre.lureau@redhat.com>
References: <20191127101038.327080-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: -2tVxEqGPTGcSlgwoyJjuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use int.from_bytes() from python 3.2 instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
2.24.0


