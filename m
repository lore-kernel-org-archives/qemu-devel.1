Received: from eggs.gnu.org ([2001:4830:134:3::10]:38344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duCwm-0001nL-Fp
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1duCwl-0007pk-Jo
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:27:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1duCwl-0007pb-E6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:27:55 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 19 Sep 2017 15:27:09 +0800
Message-Id: <20170919072719.11815-4-famz@redhat.com>
In-Reply-To: <20170919072719.11815-1-famz@redhat.com>
References: <20170919072719.11815-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 scripts/archive-source.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 scripts/archive-source.sh

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
new file mode 100755
index 0000000000..e155d980ee
--- /dev/null
+++ b/scripts/archive-source.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Author: Fam Zheng <famz@redhat.com>
+#
+# Archive source tree, including submodules. This is created for test code to
+# export the source files, in order to be built in a different enviornment,
+# such as in a docker instance or VM.
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+
+error() {
+    echo "$@" >&2
+    exit 1
+}
+
+if test $# -lt 1; then
+    error "Usage: $0 <output tarball>"
+fi
+
+submodules=$(git submodule foreach --recursive --quiet 'echo $name')
+
+if test $? -ne 0; then
+    error "git submodule command failed"
+fi
+
+if test -n "$submodules"; then
+    {
+        git ls-files || error "git ls-files failed"
+        for sm in $submodules; do
+            (cd $sm; git ls-files) | sed "s:^:$sm/:"
+            if test ${PIPESTATUS[0]} -ne 0 -o $? -ne 0; then
+                error "git ls-files in submodule $sm failed"
+            fi
+        done
+    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > "$1".list
+else
+    git ls-files > "$1".list
+fi
+
+if test $? -ne 0; then
+    error "failed to generate list file"
+fi
+
+tar -cf "$1" -T "$1".list || error "failed to create tar file"
+rm "$1".list
-- 
2.13.5
