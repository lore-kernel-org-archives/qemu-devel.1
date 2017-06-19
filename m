Received: from eggs.gnu.org ([2001:4830:134:3::10]:42839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuIT-0004TP-KC
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuIS-0000Nl-CD
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:52:41 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuIS-0000N1-5k
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:52:40 -0400
Received: by mail-wr0-x234.google.com with SMTP id 77so69584236wrb.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:52:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 19 Jun 2017 11:46:54 +0100
Message-Id: <20170619104655.31104-13-alex.bennee@linaro.org>
In-Reply-To: <20170619104655.31104-1-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v5 12/13] new: record_traces.sh helper
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
v5
  - author, license and usage header
v3
  - allow overriding of RISU binary
---
 record_traces.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 record_traces.sh

diff --git a/record_traces.sh b/record_traces.sh
new file mode 100755
index 0000000..1234a61
--- /dev/null
+++ b/record_traces.sh
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
