Received: from eggs.gnu.org ([2001:4830:134:3::10]:38554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzyk-0006fu-KY
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzyj-00020l-PO
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:14:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXzyj-0001zu-Ia
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:14:41 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Jun 2018 23:14:18 -0300
Message-Id: <20180627021423.18404-2-ehabkost@redhat.com>
In-Reply-To: <20180627021423.18404-1-ehabkost@redhat.com>
References: <20180627021423.18404-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] docker: Use BytesIO instead of StringIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The file passed as argument to TarFile.addfile() must be a binary
file, so BytesIO is more appropriate than StringIO.

This is necessary to make the code work on Python 3.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/docker/docker.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 8e13f18e6c..0de7662146 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -24,10 +24,7 @@ import tempfile
 import re
 import signal
 from tarfile import TarFile, TarInfo
-try:
-    from StringIO import StringIO
-except ImportError:
-    from io import StringIO
+from io import BytesIO
 from shutil import copy, rmtree
 from pwd import getpwuid
 from datetime import datetime,timedelta
@@ -372,13 +369,13 @@ class UpdateCommand(SubCommand):
                 tmp_tar.add(os.path.realpath(l), arcname=l)
 
         # Create a Docker buildfile
-        df = StringIO()
-        df.write("FROM %s\n" % args.tag)
-        df.write("ADD . /\n")
-        df.seek(0)
+        df = BytesIO()
+        df.write(b"FROM %s\n" % args.tag.encode())
+        df.write(b"ADD . /\n")
 
         df_tar = TarInfo(name="Dockerfile")
-        df_tar.size = len(df.buf)
+        df_tar.size = df.tell()
+        df.seek(0)
         tmp_tar.addfile(df_tar, fileobj=df)
 
         tmp_tar.close()
-- 
2.18.0.rc1.1.g3f1ff2140
