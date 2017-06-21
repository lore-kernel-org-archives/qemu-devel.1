Received: from eggs.gnu.org ([2001:4830:134:3::10]:52574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNhlw-0006O2-HB
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNhls-0002tK-5w
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:24 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNhlr-0002t3-VB
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:20 -0400
Received: by mail-wr0-x231.google.com with SMTP id c11so84699427wrc.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 08:42:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 16:42:43 +0100
Message-Id: <20170621154244.28309-10-alex.bennee@linaro.org>
In-Reply-To: <20170621154244.28309-1-alex.bennee@linaro.org>
References: <20170621154244.28309-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v6 09/10] new: record_traces.sh helper
 script
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

A simple script to run through a bunch of binaries and generate their
trace files.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v6
  - moved into contrib/
v5
  - author, license and usage header
v3
  - allow overriding of RISU binary
---
 contrib/record_traces.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 contrib/record_traces.sh

diff --git a/contrib/record_traces.sh b/contrib/record_traces.sh
new file mode 100755
index 0000000..1234a61
--- /dev/null
+++ b/contrib/record_traces.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# A risu helper script to batch process a bunch of binaries and record their outputs
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
+#   export RISU=/path/to/risu
+#   ./record_traces.sh  ./testcases.aarch64/*.bin
+#
+
+set -e
+
+if test -z "$RISU"; then
+    script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
+    RISU=${script_dir}/risu
+fi
+
+for f in $@; do
+    echo "Running risu against $f"
+    t="$f.trace"
+    ${RISU} --master $f -t $t
+    echo "Checking trace file OK"
+    ${RISU} $f -t $t
+done
-- 
2.13.0
