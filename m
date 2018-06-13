Received: from eggs.gnu.org ([2001:4830:134:3::10]:52600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5SO-0001ek-Dt
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5SI-0005cO-CO
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:05:00 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:45607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fT5SI-0005ZI-2Z
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:04:54 -0400
Received: by mail-wr0-x22a.google.com with SMTP id o12-v6so2668941wrm.12
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 06:04:53 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 13 Jun 2018 13:55:51 +0100
Message-Id: <20180613125601.14371-13-alex.bennee@linaro.org>
In-Reply-To: <20180613125601.14371-1-alex.bennee@linaro.org>
References: <20180613125601.14371-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 12/22] contrib/generate_all.sh: allow
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
