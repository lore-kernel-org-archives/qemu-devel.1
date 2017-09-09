Received: from eggs.gnu.org ([2001:4830:134:3::10]:33726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbQ-00068l-06
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbN-0006OX-JC
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYbN-0006OA-D4
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:45 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:45:51 +0800
Message-Id: <20170909054613.19148-16-famz@redhat.com>
In-Reply-To: <20170909054613.19148-1-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v2 15/37] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The image is prepared following instructions as in:

https://wiki.qemu.org/Hosts/BSD

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170905021201.25684-9-famz@redhat.com>
---
 tests/vm/openbsd | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 tests/vm/openbsd

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
new file mode 100755
index 0000000000..6ae16d97fd
--- /dev/null
+++ b/tests/vm/openbsd
@@ -0,0 +1,43 @@
+#!/usr/bin/env python
+#
+# OpenBSD VM image
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
+class OpenBSDVM(basevm.BaseVM):
+    name = "openbsd"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        tar -xf /dev/rsd1c;
+        ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
+        gmake -j{jobs};
+        # XXX: "gmake check" seems to always hang or fail
+        #gmake check;
+    """
+
+    def build_image(self, img):
+        cimg = self._download_with_cache("http://download.patchew.org/openbsd-6.1-amd64.img.xz",
+                sha256sum='8c6cedc483e602cfee5e04f0406c64eb99138495e8ca580bc0293bcf0640c1bf')
+        img_tmp_xz = img + ".tmp.xz"
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        if os.path.exists(img):
+            os.remove(img)
+        os.rename(img_tmp, img)
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(OpenBSDVM))
-- 
2.13.5
