Received: from eggs.gnu.org ([2001:4830:134:3::10]:40694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCR-0007Ki-AH
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuCQ-0004rw-65
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:27 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuCP-0004r2-W4
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:46:26 -0400
Received: by mail-wr0-x234.google.com with SMTP id y25so30273710wrd.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:46:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 19 Jun 2017 11:46:47 +0100
Message-Id: <20170619104655.31104-6-alex.bennee@linaro.org>
In-Reply-To: <20170619104655.31104-1-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v5 05/13] build-all-archs: support cross
 building via docker
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

If we want to link to any other libraries we might find using simple
cross toolchains doesn't work so well. One way around this is to use a
dockerised cross-toolchain which then won't clash with your host
system. If the user specifies --use-docker the obvious will be done.

By default we use the QEMU projects qemu:debian-FOO-cross images as
RISU hackers are likely to be QEMU developers too. However any docker
tag can be passed on the command line.

If none of the docker images have usable compilers we fall back to
checking the host path.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - swapped with --static patch so this can be dropped if desired
---
 build-all-archs | 46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/build-all-archs b/build-all-archs
index 581a1b4..63918e5 100755
--- a/build-all-archs
+++ b/build-all-archs
@@ -11,9 +11,6 @@
 # Contributors:
 #     Peter Maydell (Linaro) - initial implementation
 
-# So we notice risugen failing even though it's in a pipeline
-set -o pipefail
-
 # Simple usage
 usage() {
     cat <<-EOF
@@ -21,7 +18,10 @@ usage() {
 
         Options include:
             --static               build a static binary
+            --use-docker[=tags]    use docker cross compile
 
+        If specifying docker the default will be to use the any
+        qemu:debian-FOO-cross targets available on your system.
 EOF
     exit 1
 }
@@ -37,6 +37,14 @@ while [[ "$1" = -* ]]; do
         --static)
             CONF="--static"
             ;;
+        --use-docker)
+            if [ -z "$arg" ]; then
+                default_tags=$(docker images qemu --format "{{.Repository}}:{{.Tag}}" | grep "\(arm\|power\).*cross$")
+                docker_tags=$(echo $default_tags | sed 's/\n/\s/g' )
+            else
+                docker_tags="$arg"
+            fi
+            ;;
         --help)
             usage
             ;;
@@ -48,10 +56,24 @@ done
 
 # Debian stretch and Ubuntu Xenial have cross compiler packages for
 # all of these:
-# gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu gcc-m68k-linux-gnu
-# gcc-powerpc64le-linux-gnu gcc-powerpc64-linux-gnu
+#   gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu gcc-m68k-linux-gnu
+#   gcc-powerpc64le-linux-gnu gcc-powerpc64-linux-gnu
+# If docker is enabled we just brute force the various images until we
+# can set the one that has a workable cross compiler.
+
+DOCKER_RUN="docker run --rm -t -u $(id -u) -v $(pwd):$(pwd) -w $(pwd)"
 
 program_exists() {
+    if [ ! -z "$docker_tags" ]; then
+        use_docker_tag=""
+        for tag in $docker_tags; do
+            if ${DOCKER_RUN} ${tag} /bin/bash -c "command -v $1 >/dev/null"; then
+                use_docker_tag=$tag
+                return
+            fi
+        done
+    fi
+
     command -v "$1" >/dev/null 2>&1
 }
 
@@ -62,19 +84,29 @@ for triplet in aarch64-linux-gnu arm-linux-gnueabihf m68k-linux-gnu \
     if ! program_exists "${triplet}-gcc"; then
         echo "Skipping ${triplet}: no compiler found"
         continue
+    else
+        echo "Building ${triplet} on ${use_docker_tag:-host}..."
     fi
 
     # Do a complete rebuild from scratch, because it's cheap enough.
     rm -rf build/${triplet}
     mkdir -p build/${triplet}
 
-    (cd build/${triplet} && CROSS_PREFIX="${triplet}-"  ../../configure ${CONF})
-    make -C build/${triplet} EXTRA_CFLAGS=-Werror
+    CONFIGURE="cd build/${triplet} && CROSS_PREFIX="${triplet}-"  ../../configure ${CONF}"
+    MAKE="make -C build/${triplet} EXTRA_CFLAGS=-Werror"
 
+    if [ -z "$use_docker_tag" ]; then
+        /bin/bash -c "${CONFIGURE}"
+        ${MAKE}
+    else
+        ${DOCKER_RUN} $use_docker_tag /bin/bash -c "${CONFIGURE}"
+        ${DOCKER_RUN} $use_docker_tag /bin/bash -c "${MAKE}"
+    fi
 done
 
 # Now run risugen for all architectures
 mkdir -p build/risuout
+set -o pipefail # detect failures in pipeline
 
 for f in *.risu; do
     echo "Running risugen on $f..."
-- 
2.13.0
