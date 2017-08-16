Received: from eggs.gnu.org ([2001:4830:134:3::10]:41887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhseS-0001YN-HE
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhseL-0001pc-DG
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:22:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhseL-0001ne-0d
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 03:21:57 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 16 Aug 2017 15:21:01 +0800
Message-Id: <20170816072104.24420-7-famz@redhat.com>
In-Reply-To: <20170816072104.24420-1-famz@redhat.com>
References: <20170816072104.24420-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 6/9] tests: Add FreeBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, stefanha@redhat.com, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Kamil Rytarowski <kamil@netbsd.org>

The image is prepared following instructions as in:

https://wiki.qemu.org/Hosts/BSD

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/freebsd | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100755 tests/vm/freebsd

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
new file mode 100755
index 0000000000..fb23164676
--- /dev/null
+++ b/tests/vm/freebsd
@@ -0,0 +1,44 @@
+#!/usr/bin/env python
+#
+# FreeBSD VM image
+#
+# Copyright (C) 2017 Red Hat Inc.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.  See
+# the COPYING file in the top-level directory.
+#
+
+import os
+import sys
+import logging
+import subprocess
+import tempfile
+import time
+import basevm
+
+class FreeBSDVM(basevm.BaseVM):
+    name = "freebsd"
+    BUILD_SCRIPT = """
+        set -e;
+        cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
+        tar -xf /dev/vtbd1;
+        ./configure {configure_opts};
+        gmake -j{jobs};
+        gmake check;
+    """
+
+    def build_image(self, img, rebuild=False):
+        if os.path.exists(img) and not rebuild:
+            return
+        cimg = self._download_with_cache("http://download.patchew.org/freebsd.img.xz")
+        img_tmp_xz = img + ".tmp.xz"
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        subprocess.check_call(["mv", img_tmp, img])
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(FreeBSDVM))
-- 
2.13.4
