Received: from eggs.gnu.org ([2001:4830:134:3::10]:60261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3Lu-0003B6-LV
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp3Lp-000803-W3
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:12:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp3Lp-0007zq-Po
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:12:29 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 10:11:52 +0800
Message-Id: <20170905021201.25684-4-famz@redhat.com>
In-Reply-To: <20170905021201.25684-1-famz@redhat.com>
References: <20170905021201.25684-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 03/12] scripts: Add archive-source.sh
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

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 scripts/archive-source.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100755 scripts/archive-source.sh

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
new file mode 100755
index 0000000000..3cae7f34d3
--- /dev/null
+++ b/scripts/archive-source.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+#
+# Author: Fam Zheng <famz@redhat.com>
+#
+# Create archive of source tree, including submodules
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+set -e
+
+if test $# -lt 1; then
+    echo "Usage: $0 <output>"
+    exit 1
+fi
+
+submodules=$(git submodule foreach --recursive --quiet 'echo $name')
+
+if test -n "$submodules"; then
+    {
+        git ls-files
+        for sm in $submodules; do
+            (cd $sm; git ls-files) | sed "s:^:$sm/:"
+        done
+    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > $1.list
+else
+    git ls-files > $1.list
+fi
+
+tar -cf $1 -T $1.list
+rm $1.list
-- 
2.13.5
