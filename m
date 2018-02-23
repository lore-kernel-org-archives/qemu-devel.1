Received: from eggs.gnu.org ([2001:4830:134:3::10]:48208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYE-0003jo-UA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1epFYE-0008J0-7q
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:22 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1epFYE-0008HF-1C
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:46:22 -0500
Received: by mail-wm0-x242.google.com with SMTP id k87so5479487wmi.0
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 07:46:21 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 23 Feb 2018 15:46:10 +0000
Message-Id: <20180223154613.2096-6-alex.bennee@linaro.org>
In-Reply-To: <20180223154613.2096-1-alex.bennee@linaro.org>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 5/8] contrib/run_risu.sh: allow appending of
 QEMU_FLAGS
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

Useful if you want to disable a feature for your run. For example:

  set -x QEMU_FLAGS "-cpu fp16=off"

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/run_risu.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/run_risu.sh b/contrib/run_risu.sh
index 439cd36..63649dd 100755
--- a/contrib/run_risu.sh
+++ b/contrib/run_risu.sh
@@ -13,6 +13,7 @@
 #
 # Usage:
 #   (optional) export QEMU=/path/to/qemu
+#   (optional) export QEMU_FLAGS="-cpu any,fp16=off"
 #   (optional) export RISU=/path/to/risu
 #   ./run_risu.sh  ./testcases.aarch64/*.bin
 
@@ -29,9 +30,10 @@ fi
 
 for f in $@; do
     t="$f.trace"
-    echo "Running $f against $t"
+    CMD="${QEMU} ${QEMU_FLAGS} ${RISU} $f -t $t"
+    echo "Running: ${CMD}"
     if [ -e $t ]; then
-        ${QEMU} ${RISU} $f -t $t
+        ${CMD}
         if [ $? == 0 ]; then
             passed=( "${passed[@]}" $f )
         else
-- 
2.15.1
