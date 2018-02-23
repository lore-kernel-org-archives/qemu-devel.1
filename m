Received: from eggs.gnu.org ([2001:4830:134:3::10]:48183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYE-0003j3-7m
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYC-0008FY-Oj
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:22 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFYC-0008Cq-Gd
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:20 -0500
Received: by mail-wm0-x232.google.com with SMTP id z9so5366016wmb.3
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:46:20 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:46:09 +0000
Message-Id: <20180223154613.2096-5-alex.bennee@linaro.org>
In-Reply-To: <20180223154613.2096-1-alex.bennee@linaro.org>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 4/8] new contrib/generate_all.sh: batch
 risugen script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a simple script for generating all instructions in a given
RISU file. You can split up the batch size by passing a -n N command
line options. For example:

  ./contrib/generate_all.sh -n 2 hp.risu testcases.armv8.2_hp

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/generate_all.sh | 96 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100755 contrib/generate_all.sh

diff --git a/contrib/generate_all.sh b/contrib/generate_all.sh
new file mode 100755
index 0000000..1e6b847
--- /dev/null
+++ b/contrib/generate_all.sh
@@ -0,0 +1,96 @@
+#!/bin/bash
+#
+# Generate all patterns in a given RISU file
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
+#   ./contrib/generate_all.sh <arch.risu> <target directory>
+
+set -e
+
+USAGE="Usage: `basename $0` [-h] [-n x] <risufile> <target dir>"
+SPLIT=4
+RISUGEN=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P)/risugen
+
+# Parse command line options.
+while getopts hn: OPT; do
+    case "$OPT" in
+        h)
+            echo $USAGE
+            exit 0
+            ;;
+        n)
+            SPLIT=$OPTARG
+            ;;
+        \?)
+            # getopts issues an error message
+            echo $USAGE >&2
+            exit 1
+            ;;
+    esac
+done
+
+# Remove the switches we parsed above.
+shift `expr $OPTIND - 1`
+
+while [ $# -ne 0 ]; do
+
+    if [ -f $1 ]; then
+        RISU_FILE=$1;
+    elif [ -d $1 ]; then
+        TARGET_DIR=$1;
+    elif [ ! -e $1 ]; then
+        TARGET_DIR=$1
+    fi
+
+    shift
+done
+
+if test -z "${RISUGEN}" || test ! -x "${RISUGEN}";  then
+    echo "Couldn't find risugen (${RISUGEN})"
+    exit 1
+fi
+
+if [ -z "$RISU_FILE" ]; then
+    echo "Need to set a .risu file for patterns"
+    exit 1
+fi
+
+if [ -z "${TARGET_DIR}" ]; then
+    echo "Need to set a TARGET_DIR"
+    exit 1
+fi
+
+
+mkdir -p ${TARGET_DIR}
+
+ALL_INSNS=$(cat ${RISU_FILE} | ag "^\w" | cut -f 1 -d " " | sort)
+COUNT=$(cat ${RISU_FILE=} | ag "^\w" | cut -f 1 -d " " | wc -l)
+set -- $ALL_INSNS
+
+GROUP=$((COUNT / ${SPLIT}))
+
+while test $# -gt 0 ; do
+    INSN_PATTERNS=""
+    I_FILE="${TARGET_DIR}/insn_"
+    for i in `seq 1 ${SPLIT}`; do
+        I=$1
+        if test -n "${I}"; then
+            shift
+            INSN_PATTERNS="${INSN_PATTERNS} --pattern ${I}"
+            I_FILE="${I_FILE}${I}_"
+        fi
+    done
+    I_FILE="${I_FILE}_INC.risu.bin"
+    CMD="${RISUGEN} ${INSN_PATTERNS} ${RISU_FILE} ${I_FILE}"
+    echo "Running: $CMD"
+    $CMD
+done
-- 
2.15.1
