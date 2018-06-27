Received: from eggs.gnu.org ([2001:4830:134:3::10]:38919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzzM-0007FW-NU
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzzH-0002en-Nk
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:15:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXzzH-0002e4-IO
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:15:15 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Jun 2018 23:14:22 -0300
Message-Id: <20180627021423.18404-6-ehabkost@redhat.com>
In-Reply-To: <20180627021423.18404-1-ehabkost@redhat.com>
References: <20180627021423.18404-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] docker: Make _get_so_libs() work on Python
 3
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

The "ldd" output is a byte sequence, not a string.  Use bytes
literals while handling the output, and use os.fsdecode() on the
resulting file paths before returning.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/docker/docker.py | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index bc34bd872b..f58af8e894 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -41,6 +41,15 @@ FILTERED_ENV_NAMES = ['ftp_proxy', 'http_proxy', 'https_proxy']
 
 DEVNULL = open(os.devnull, 'wb')
 
+def _fsdecode(name):
+    # type: (bytes) -> str
+    """Decode filename to str, try to use os.fsdecode() if available"""
+    if hasattr(os, 'fsdecode'):
+        # Python 3
+        return os.fsdecode(name) # type: ignore
+    else:
+        # Python 2.7
+        return name # type: ignore
 
 def _text_checksum(text):
     # type: (bytes) -> str
@@ -90,15 +99,15 @@ def _get_so_libs(executable):
     ensure theright data is copied."""
 
     libs = []
-    ldd_re = re.compile(r"(/.*/)(\S*)")
+    ldd_re = re.compile(b"(/.*/)(\S*)")
     try:
         ldd_output = subprocess.check_output(["ldd", executable])
-        for line in ldd_output.split("\n"):
+        for line in ldd_output.split(b"\n"):
             search = ldd_re.search(line)
             if search and len(search.groups()) == 2:
                 so_path = search.groups()[0]
                 so_lib = search.groups()[1]
-                libs.append("%s/%s" % (so_path, so_lib))
+                libs.append(_fsdecode(b"%s/%s" % (so_path, so_lib)))
     except subprocess.CalledProcessError:
         print("%s had no associated libraries (static build?)" % (executable))
 
-- 
2.18.0.rc1.1.g3f1ff2140
