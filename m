Received: from eggs.gnu.org ([2001:4830:134:3::10]:41832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgS-0007Mu-Bh
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFJgM-0007pZ-SM
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:48 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFJgM-0007p4-Lo
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 06:49:42 -0500
Received: by mail-wm0-f50.google.com with SMTP id f82so23297455wmf.1
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 03:49:42 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Dec 2016 11:48:28 +0000
Message-Id: <20161209114830.9158-9-alex.bennee@linaro.org>
In-Reply-To: <20161209114830.9158-1-alex.bennee@linaro.org>
References: <20161209114830.9158-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 08/10] new: generate_all.sh script
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

A simple script to cut up a full .risu file and generate binaries for
the whole set. Call with risu file and instruction count and directory:

  ./generate_all.sh aarch64.risu 4 20000 testcases.aarch64

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 generate_all.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 generate_all.sh

diff --git a/generate_all.sh b/generate_all.sh
new file mode 100755
index 0000000..4c490be
--- /dev/null
+++ b/generate_all.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# Generate All Patterns
+#
+# Work through a given .risu file and generate full coverage
+#
+
+BASE_SHELL_PARAMS="./risugen"
+
+risufile=$1
+divisor=$2
+insns=$3
+dir=$4
+
+if test -z "$risufile"; then
+    echo "Need to specify a risu defintiion file"
+    exit 1
+fi
+
+if test -z "$divisor"; then
+    divisor=4
+fi
+
+if test -n "$insns"; then
+    BASE_SHELL_PARAMS="${BASE_SHELL_PARAMS} --numinsns $insns"
+fi
+
+if test -n "dir"; then
+    mkdir -p $dir
+else
+    dir="./"
+fi
+
+ALL_INSNS=$(cat $risufile | ag "^\w" | cut -f 1 -d " " | sort)
+COUNT=$(cat $risufile | ag "^\w" | cut -f 1 -d " " | wc -l)
+set -- $ALL_INSNS
+
+GROUP=$((COUNT / $divisor))
+
+while test $# -gt 0 ; do
+    INSN_PATTERNS=""
+    I_FILE="$dir/insn_"
+    for i in `seq 1 $divisor`; do
+        I=$1
+        if test -n "${I}"; then
+            shift
+            INSN_PATTERNS="${INSN_PATTERNS} --pattern ${I}"
+            I_FILE="${I_FILE}${I}_"
+        fi
+    done
+    I_FILE="${I_FILE}_INC.risu.bin"
+    CMD="$BASE_SHELL_PARAMS ${INSN_PATTERNS} $risufile ${I_FILE}"
+    echo "Running: $CMD"
+    $CMD
+done
-- 
2.11.0
