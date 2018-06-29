Received: from eggs.gnu.org ([2001:4830:134:3::10]:57772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Sj-0004Gm-Ur
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Sf-0005IE-2T
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:57:50 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZ0Se-0005G7-RS
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:57:44 -0400
Received: by mail-wr0-x243.google.com with SMTP id p12-v6so9977198wrn.11
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:57:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 29 Jun 2018 21:52:29 +0100
Message-Id: <20180629205232.27190-19-alex.bennee@linaro.org>
In-Reply-To: <20180629205232.27190-1-alex.bennee@linaro.org>
References: <20180629205232.27190-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 18/21] docker: add special handling for
 FROM:debian-%-user targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

These will have been build with debootstrap so we need to check
against the debian-bootstrap dockerfile. This does mean sticking to
debian-FOO-user as the naming conventions for boot-strapped images.
The actual cross image is built on top.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 388e86ada2..8ceaf78681 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -110,9 +110,13 @@ def _copy_binary_with_libs(src, dest_dir):
     if libs:
         for l in libs:
             so_path = os.path.dirname(l)
-            _copy_with_mkdir(l , dest_dir, so_path)
+            _copy_with_mkdir(l, dest_dir, so_path)
 
 def _read_qemu_dockerfile(img_name):
+    # special case for Debian linux-user images
+    if img_name.startswith("debian") and img_name.endswith("user"):
+        img_name = "debian-bootstrap"
+
     df = os.path.join(os.path.dirname(__file__), "dockerfiles",
                       img_name + ".docker")
     return open(df, "r").read()
-- 
2.17.1
