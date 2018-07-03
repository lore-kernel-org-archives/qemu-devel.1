Received: from eggs.gnu.org ([2001:4830:134:3::10]:44811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISo-0004Yx-KN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1faISl-0004XR-GZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:14 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:54939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1faISl-0004Wv-AL
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:23:11 -0400
Received: by mail-wm0-x232.google.com with SMTP id i139-v6so1717358wmf.4
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 03:23:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  3 Jul 2018 11:14:42 +0100
Message-Id: <20180703101444.23778-19-alex.bennee@linaro.org>
In-Reply-To: <20180703101444.23778-1-alex.bennee@linaro.org>
References: <20180703101444.23778-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/20] docker: add special handling for
 FROM:debian-%-user targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

These will have been build with debootstrap so we need to check
against the debian-bootstrap dockerfile. This does mean sticking to
debian-FOO-user as the naming conventions for boot-strapped images.
The actual cross image is built on top.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index b279836154..69e7130db7 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -113,6 +113,10 @@ def _copy_binary_with_libs(src, dest_dir):
             _copy_with_mkdir(l , dest_dir, so_path)
 
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
