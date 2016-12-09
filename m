Received: from eggs.gnu.org ([2001:4830:134:3::10]:41844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgU-0007SD-9Z
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgS-0007uR-5w
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:50 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFJgR-0007th-VZ
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:48 -0500
Received: by mail-wm0-f44.google.com with SMTP id f82so23300607wmf.1
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 03:49:47 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Dec 2016 11:48:29 +0000
Message-Id: <20161209114830.9158-10-alex.bennee@linaro.org>
In-Reply-To: <20161209114830.9158-1-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 09/10] new: record_traces.sh helper
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
Cc: qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A simple script to run through a bunch of binaries and generate their
trace files.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - allow overriding of RISU binary
---
 record_traces.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100755 record_traces.sh

diff --git a/record_traces.sh b/record_traces.sh
new file mode 100755
index 0000000..78ce47f
--- /dev/null
+++ b/record_traces.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+#
+# Record traces
+#
+# A risu helper script to batch process a bunch of binaries and record their outputs
+#
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
2.11.0
