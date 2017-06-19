Received: from eggs.gnu.org ([2001:4830:134:3::10]:40668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCQ-0007KX-Jh
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCN-0004qK-IA
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:26 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuCN-0004q7-BP
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:23 -0400
Received: by mail-wr0-x229.google.com with SMTP id r103so69638948wrb.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:46:23 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 19 Jun 2017 11:46:46 +0100
Message-Id: <20170619104655.31104-5-alex.bennee@linaro.org>
In-Reply-To: <20170619104655.31104-1-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v5 04/13] build-all-archs: support
 --static flag
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - swap with docker patch so later can be dropped if not wanted
---
 build-all-archs | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/build-all-archs b/build-all-archs
index 2768727..581a1b4 100755
--- a/build-all-archs
+++ b/build-all-archs
@@ -14,6 +14,38 @@
 # So we notice risugen failing even though it's in a pipeline
 set -o pipefail
 
+# Simple usage
+usage() {
+    cat <<-EOF
+        Usage: $0 [options]
+
+        Options include:
+            --static               build a static binary
+
+EOF
+    exit 1
+}
+
+while [[ "$1" = -* ]]; do
+    opt="$1"; shift
+    arg=
+    if [[ "$opt" = *=* ]]; then
+        arg="${opt#*=}"
+        opt="${opt%%=*}"
+    fi
+    case "$opt" in
+        --static)
+            CONF="--static"
+            ;;
+        --help)
+            usage
+            ;;
+        *)
+            usage
+            ;;
+    esac
+done
+
 # Debian stretch and Ubuntu Xenial have cross compiler packages for
 # all of these:
 # gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu gcc-m68k-linux-gnu
@@ -36,7 +68,7 @@ for triplet in aarch64-linux-gnu arm-linux-gnueabihf m68k-linux-gnu \
     rm -rf build/${triplet}
     mkdir -p build/${triplet}
 
-    (cd build/${triplet} && CROSS_PREFIX="${triplet}-"  ../../configure)
+    (cd build/${triplet} && CROSS_PREFIX="${triplet}-"  ../../configure ${CONF})
     make -C build/${triplet} EXTRA_CFLAGS=-Werror
 
 done
-- 
2.13.0
