Received: from eggs.gnu.org ([2001:4830:134:3::10]:52538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNhls-0006Iq-1J
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNhlr-0002sv-0y
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:20 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNhlq-0002sP-RL
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:18 -0400
Received: by mail-wr0-x230.google.com with SMTP id r103so140136018wrb.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 08:42:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 16:42:44 +0100
Message-Id: <20170621154244.28309-11-alex.bennee@linaro.org>
In-Reply-To: <20170621154244.28309-1-alex.bennee@linaro.org>
References: <20170621154244.28309-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v6 10/10] new: run_risu.sh script
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
v6
  - moved into contrib/
v5
  - author, license, usage header
v3
  - tweak to allow specifying RISU binary
---
 contrib/run_risu.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100755 contrib/run_risu.sh

diff --git a/contrib/run_risu.sh b/contrib/run_risu.sh
new file mode 100755
index 0000000..439cd36
--- /dev/null
+++ b/contrib/run_risu.sh
@@ -0,0 +1,66 @@
+#!/bin/bash
+#
+# Run risu against a set of binaries + trace files
+#
+# Copyright (c) 2017 Linaro Limited
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     Alex Bennée <alex.bennee@linaro.org> - initial implementation
+#
+# Usage:
+#   (optional) export QEMU=/path/to/qemu
+#   (optional) export RISU=/path/to/risu
+#   ./run_risu.sh  ./testcases.aarch64/*.bin
+
+set -e
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
