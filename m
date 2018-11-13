Received: from eggs.gnu.org ([2001:4830:134:3::10]:38772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMdiD-0000VQ-5u
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMdiB-0000Nx-Ih
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:46:57 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMdiB-0000GQ-6i
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:46:55 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 18:46:41 +0000
Message-Id: <20181113184641.4492-3-peter.maydell@linaro.org>
In-Reply-To: <20181113184641.4492-1-peter.maydell@linaro.org>
References: <20181113184641.4492-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] scripts/coverity-scan: Add Docker support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

Add support for running the Coverity Scan tools inside a Docker
container rather than directly on the host system.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/coverity-scan/coverity-scan.docker | 120 +++++++++++++++++++++
 scripts/coverity-scan/run-coverity-scan    |  58 ++++++++++
 2 files changed, 178 insertions(+)
 create mode 100644 scripts/coverity-scan/coverity-scan.docker

diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
new file mode 100644
index 00000000000..81f69459954
--- /dev/null
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -0,0 +1,120 @@
+# syntax=docker/dockerfile:1.0.0-experimental
+#
+# Docker setup for running the "Coverity Scan" tools over the source
+# tree and uploading them to the website, as per
+# https://scan.coverity.com/projects/qemu/builds/new
+# We do this on a fixed config (currently Fedora 28 with a known
+# set of dependencies and a configure command that enables a specific
+# set of options) so that random changes don't result in our accidentally
+# dropping some files from the scan.
+# The work of actually doing the build is handled by the
+# run-coverity-scan script.
+
+
+FROM fedora:28
+ENV PACKAGES \
+    alsa-lib-devel \
+    bc \
+    bison \
+    bluez-libs-devel \
+    brlapi-devel \
+    bzip2 \
+    bzip2-devel \
+    ccache \
+    clang \
+    curl \
+    cyrus-sasl-devel \
+    device-mapper-multipath-devel \
+    findutils \
+    flex \
+    gcc \
+    gcc-c++ \
+    gettext \
+    git \
+    glib2-devel \
+    glusterfs-api-devel \
+    gnutls-devel \
+    gtk3-devel \
+    hostname \
+    libaio-devel \
+    libasan \
+    libattr-devel \
+    libcap-devel \
+    libcap-ng-devel \
+    libcurl-devel \
+    libepoxy-devel \
+    libfdt-devel \
+    libgbm-devel \
+    libiscsi-devel \
+    libjpeg-devel \
+    libnfs-devel \
+    libpng-devel \
+    librbd-devel \
+    libseccomp-devel \
+    libssh2-devel \
+    libubsan \
+    libudev-devel \
+    libusbx-devel \
+    libxml2-devel \
+    llvm \
+    lzo-devel \
+    make \
+    mingw32-bzip2 \
+    mingw32-curl \
+    mingw32-glib2 \
+    mingw32-gmp \
+    mingw32-gnutls \
+    mingw32-gtk3 \
+    mingw32-libjpeg-turbo \
+    mingw32-libpng \
+    mingw32-libssh2 \
+    mingw32-libtasn1 \
+    mingw32-nettle \
+    mingw32-pixman \
+    mingw32-pkg-config \
+    mingw32-SDL2 \
+    mingw64-bzip2 \
+    mingw64-curl \
+    mingw64-glib2 \
+    mingw64-gmp \
+    mingw64-gnutls \
+    mingw64-gtk3 \
+    mingw64-libjpeg-turbo \
+    mingw64-libpng \
+    mingw64-libssh2 \
+    mingw64-libtasn1 \
+    mingw64-nettle \
+    mingw64-pixman \
+    mingw64-pkg-config \
+    mingw64-SDL2 \
+    ncurses-devel \
+    nettle-devel \
+    nss-devel \
+    numactl-devel \
+    perl \
+    pixman-devel \
+    pulseaudio-libs-devel \
+    python3 \
+    PyYAML \
+    rdma-core-devel \
+    SDL2-devel \
+    snappy-devel \
+    sparse \
+    spice-server-devel \
+    systemtap-sdt-devel \
+    tar \
+    usbredir-devel \
+    virglrenderer-devel \
+    vte3-devel \
+    wget \
+    which \
+    xen-devel \
+    xfsprogs-devel \
+    zlib-devel
+ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV COVERITY_TOOL_BASE=/coverity-tools
+COPY run-coverity-scan run-coverity-scan
+RUN --mount=type=secret,id=coverity.token,required ./run-coverity-scan --update-tools-only --tokenfile /run/secrets/coverity.token
diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index 99495b04501..e89316c090d 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -29,6 +29,7 @@
 
 # Command line options:
 #   --dry-run : run the tools, but don't actually do the upload
+#   --docker : create and work inside a docker container
 #   --update-tools-only : update the cached copy of the tools, but don't run them
 #   --tokenfile : file to read Coverity token from
 #   --version ver : specify version being analyzed (default: ask git)
@@ -122,6 +123,7 @@ update_coverity_tools () {
 # Check user-provided environment variables and arguments
 DRYRUN=no
 UPDATE_ONLY=no
+DOCKER=no
 
 while [ "$#" -ge 1 ]; do
     case "$1" in
@@ -169,6 +171,10 @@ while [ "$#" -ge 1 ]; do
             SRCDIR="$1"
             shift
             ;;
+        --docker)
+            DOCKER=yes
+            shift
+            ;;
         *)
             echo "Unexpected argument '$1'"
             exit 1
@@ -199,6 +205,10 @@ PROJTOKEN="$COVERITY_TOKEN"
 PROJNAME=QEMU
 TARBALL=cov-int.tar.xz
 
+if [ "$UPDATE_ONLY" = yes ] && [ "$DOCKER" = yes ]; then
+    echo "Combining --docker and --update-only is not supported"
+    exit 1
+fi
 
 if [ "$UPDATE_ONLY" = yes ]; then
     # Just do the tools update; we don't need to check whether
@@ -229,6 +239,54 @@ if [ -z "$COVERITY_EMAIL" ]; then
     COVERITY_EMAIL="$(git config user.email)"
 fi
 
+# Run ourselves inside docker if that's what the user wants
+if [ "$DOCKER" = yes ]; then
+    # build docker container including the coverity-scan tools
+    # Put the Coverity token into a temporary file that only
+    # we have read access to, and then pass it to docker build
+    # using --secret. This requires at least Docker 18.09.
+    # Mostly what we are trying to do here is ensure we don't leak
+    # the token into the Docker image.
+    umask 077
+    SECRETDIR=$(mktemp -d)
+    if [ -z "$SECRETDIR" ]; then
+        echo "Failed to create temporary directory"
+        exit 1
+    fi
+    trap 'rm -rf "$SECRETDIR"' INT TERM EXIT
+    echo "Created temporary directory $SECRETDIR"
+    SECRET="$SECRETDIR/token"
+    echo "$COVERITY_TOKEN" > "$SECRET"
+    echo "Building docker container..."
+    # TODO: This re-downloads the tools every time, rather than
+    # caching and reusing the image produced with the downloaded tools.
+    # Not sure why.
+    # TODO: how do you get 'docker build' to print the output of the
+    # commands it is running to its stdout? This would be useful for debug.
+    DOCKER_BUILDKIT=1 docker build -t coverity-scanner \
+                   --secret id=coverity.token,src="$SECRET" \
+                   -f scripts/coverity-scan/coverity-scan.docker \
+                   scripts/coverity-scan
+    echo "Archiving sources to be analyzed..."
+    ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"
+    (cd "$SECRETDIR" && mkdir qemu && cd qemu && tar xvf ../qemu-sources.tgz)
+    if [ "$DRYRUN" = yes ]; then
+        DRYRUNARG=--dry-run
+    fi
+    echo "Running scanner..."
+    # Arrange for this docker run to get access to the sources with -v.
+    # We pass through all the configuration from the outer script to the inner.
+    docker run -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
+           -v "$SECRETDIR:/work" coverity-scanner \
+           ./run-coverity-scan --version "$VERSION" \
+           --description "$DESCRIPTION" $DRYRUNARG --tokenfile /work/token \
+           --srcdir /work/qemu
+    echo "Docker work complete."
+    exit 0
+fi
+
+# Otherwise, continue with the full build and upload process.
+
 check_upload_permissions
 
 update_coverity_tools
-- 
2.19.1
