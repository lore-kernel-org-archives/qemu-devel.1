Received: from eggs.gnu.org ([2001:4830:134:3::10]:41833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMwz-0005wq-1q
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMwx-0003Yw-KY
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:08 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:41380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMwx-0003YA-Bm
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:22:07 -0400
Received: by mail-wr0-x231.google.com with SMTP id h10-v6so6879736wrq.8
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:22:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:55 +0100
Message-Id: <20180622141205.16306-13-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 12/22] contrib/generate_all.sh: allow
 passing of arguments to risugen
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

This allows us to use any new risugen options when generating all our
test patterns.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/generate_all.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/contrib/generate_all.sh b/contrib/generate_all.sh
index 1e6b847..651cb23 100755
--- a/contrib/generate_all.sh
+++ b/contrib/generate_all.sh
@@ -12,11 +12,11 @@
 #     Alex Bennée <alex.bennee@linaro.org> - initial implementation
 #
 # Usage:
-#   ./contrib/generate_all.sh <arch.risu> <target directory>
+#   ./contrib/generate_all.sh <arch.risu> <target directory> -- risugen args
 
 set -e
 
-USAGE="Usage: `basename $0` [-h] [-n x] <risufile> <target dir>"
+USAGE="Usage: `basename $0` [-h] [-n x] <risufile> <target dir> -- [risugen args]"
 SPLIT=4
 RISUGEN=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd -P)/risugen
 
@@ -41,18 +41,24 @@ done
 # Remove the switches we parsed above.
 shift `expr $OPTIND - 1`
 
-while [ $# -ne 0 ]; do
+# Parse up to and including any --
+RISUGEN_ARGS=""
+while [ $# -ne 0 ] && [ -z "$RISUGEN_ARGS" ]; do
 
     if [ -f $1 ]; then
         RISU_FILE=$1;
     elif [ -d $1 ]; then
         TARGET_DIR=$1;
+    elif [ "$1" = "--" ]; then
+        RISUGEN_ARGS=$1
     elif [ ! -e $1 ]; then
         TARGET_DIR=$1
     fi
 
     shift
 done
+# anything left is for RISUGEN
+RISUGEN_ARGS=$@
 
 if test -z "${RISUGEN}" || test ! -x "${RISUGEN}";  then
     echo "Couldn't find risugen (${RISUGEN})"
@@ -90,7 +96,7 @@ while test $# -gt 0 ; do
         fi
     done
     I_FILE="${I_FILE}_INC.risu.bin"
-    CMD="${RISUGEN} ${INSN_PATTERNS} ${RISU_FILE} ${I_FILE}"
+    CMD="${RISUGEN} ${RISUGEN_ARGS} ${INSN_PATTERNS} ${RISU_FILE} ${I_FILE}"
     echo "Running: $CMD"
     $CMD
 done
-- 
2.17.1
