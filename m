Received: from eggs.gnu.org ([2001:4830:134:3::10]:54532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGp84-000671-RD
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGp82-00054t-NB
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:48 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGp82-00054A-Gs
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:46 -0400
Received: by mail-wm0-x232.google.com with SMTP id d127so30559941wmf.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 09:08:46 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  2 Jun 2017 17:08:48 +0100
Message-Id: <20170602160848.4913-11-alex.bennee@linaro.org>
In-Reply-To: <20170602160848.4913-1-alex.bennee@linaro.org>
References: <20170602160848.4913-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 10/10] new: run_risu.sh script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A simple script to work through running all of a bunch of files with
record/playback traces. Dumps a summary and the number of failed tests
at the end.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - tweak to allow specifying RISU binary
---
 run_risu.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 run_risu.sh

diff --git a/run_risu.sh b/run_risu.sh
new file mode 100755
index 0000000..7740d6f
--- /dev/null
+++ b/run_risu.sh
@@ -0,0 +1,53 @@
+#!/bin/bash
+#
+# Run risu against a set of binaries + trace files
+#
+#
+#set -e
+
+passed=()
+failed=()
+missing=()
+
+if test -z "$RISU"; then
+    script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
+    RISU=${script_dir}/risu
+fi
+
+for f in $@; do
+    t="$f.trace"
+    echo "Running $f against $t"
+    if [ -e $t ]; then
+        ${QEMU} ${RISU} $f -t $t
+        if [ $? == 0 ]; then
+            passed=( "${passed[@]}" $f )
+        else
+            failed=( "${failed[@]}" $f )
+        fi
+    else
+        missing=( "${missing[@]}" $f )
+    fi
+done
+
+if test ${#missing[@]} -gt 0; then
+    echo "Tests missing ${#missing[@]} trace files:"
+    for m in "${missing[@]}"; do
+        echo "$m"
+    done
+fi
+
+if test ${#passed[@]} -gt 0; then
+    echo "Passed ${#passed[@]} tests:"
+    for p in "${passed[@]}"; do
+        echo "$p"
+    done
+fi
+
+if test ${#failed[@]} -gt 0; then
+    echo "Failed ${#failed[@]} tests:"
+    for f in "${failed[@]}"; do
+        echo "$f"
+    done
+fi
+
+exit ${#failed[@]}
-- 
2.13.0
