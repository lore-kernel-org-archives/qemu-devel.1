Received: from eggs.gnu.org ([2001:4830:134:3::10]:47774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsmX3-0006PO-Sd
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsmWl-0002hX-Hx
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:03:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dsmWl-0002gz-96
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:03:11 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 15 Sep 2017 17:02:47 +0800
Message-Id: <20170915090253.12201-6-famz@redhat.com>
In-Reply-To: <20170915090253.12201-1-famz@redhat.com>
References: <20170915090253.12201-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v4 14/38] tests: Add FreeBSD image
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
Message-Id: <20170913030119.3957-8-famz@redhat.com>
---
 tests/vm/freebsd | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tests/vm/freebsd

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
new file mode 100755
index 0000000000..039dad8f69
--- /dev/null
+++ b/tests/vm/freebsd
@@ -0,0 +1,42 @@
+#!/usr/bin/env python
+#
+# FreeBSD VM image
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
+    def build_image(self, img):
+        cimg = self._download_with_cache("http://download.patchew.org/freebsd-11.1-amd64.img.xz",
+                sha256sum='adcb771549b37bc63826c501f05121a206ed3d9f55f49145908f7e1432d65891')
+        img_tmp_xz = img + ".tmp.xz"
+        img_tmp = img + ".tmp"
+        subprocess.check_call(["cp", "-f", cimg, img_tmp_xz])
+        subprocess.check_call(["xz", "-df", img_tmp_xz])
+        if os.path.exists(img):
+            os.remove(img)
+        os.rename(img_tmp, img)
+
+if __name__ == "__main__":
+    sys.exit(basevm.main(FreeBSDVM))
-- 
2.13.5
