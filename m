Received: from eggs.gnu.org ([2001:4830:134:3::10]:34270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtm3R-0006eO-Ko
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 22:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtm3O-0005MU-Ht
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 22:45:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dtm3O-0005M7-Bo
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 22:44:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 18 Sep 2017 10:43:57 +0800
Message-Id: <20170918024402.3265-9-famz@redhat.com>
In-Reply-To: <20170918024402.3265-1-famz@redhat.com>
References: <20170918024402.3265-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v8 08/13] tests: Add NetBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

The image is prepared following instructions as in:

https://wiki.qemu.org/Hosts/BSD

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Kamil Rytarowski <n54@gmx.com>
---
 tests/vm/netbsd | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tests/vm/netbsd

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
new file mode 100755
index 0000000000..3972d8b45c
--- /dev/null
+++ b/tests/vm/netbsd
@@ -0,0 +1,42 @@
+#!/usr/bin/env python
+#
+# NetBSD VM image
+#
+# Copyright 2017 Red Hat Inc.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import sys
+import subprocess
+import basevm
+
+class NetBSDVM(basevm.BaseVM):
+    name = "netbsd"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        tar -xf /dev/rld1a;
+        ./configure --python=python2.7 {configure_opts};
+        gmake -j{jobs};
+        gmake check;
+    """
+
+    def build_image(self, img):
+        cimg = self._download_with_cache("http://download.patchew.org/netbsd-7.1-amd64.img.xz",
+                                         sha256sum='b633d565b0eac3d02015cd0c81440bd8a7a8df8512615ac1ee05d318be015732')
+        img_tmp_xz = img + ".tmp.xz"
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        if os.path.exists(img):
+            os.remove(img)
+        os.rename(img_tmp, img)
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(NetBSDVM))
-- 
2.13.5
