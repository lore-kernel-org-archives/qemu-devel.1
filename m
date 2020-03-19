Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C7C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664AD20739
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZRPhr5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664AD20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0zY-0001ll-Dq
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0vB-0004Nj-Ek
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jF0v7-00064Y-Vh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:37 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jF0v7-00061G-O9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:33:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h9so4623828wrc.8
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 12:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SF8R5D5p5UyH4Z2/xaugTdMkdjsfKFt6GxrCOXYQG78=;
 b=jZRPhr5KVfSmJhz+ndRsRgeXlFpnzHf2zU5seVrih4C0XoqHyolvrEsVTkU/ItB4VT
 YjX2pW1K66uieHOsAFRpLST27jixROhJHLYFIXwEK/Ax+UfmuSlMSgR9CuFk5QrOpggw
 Zz/C644E+odemwOiAMrKUqkAMs7OITPcHrZb6j16PGmxPw/WgXofSRHn9E6XxSSeI/SQ
 nUwBB4Zk2HFlYfrqWSOwD1m/jmHo1dExAMNa6uXSo5d+2+Msh/vG3w9VzVYjCtXiLQyz
 tNLYOzhWsjR/ScfK4W9mQDcsvDOiIgpNQ+v6UDIfVTBTLTiAPT9yThrVGNmO+2w6P8TP
 49ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SF8R5D5p5UyH4Z2/xaugTdMkdjsfKFt6GxrCOXYQG78=;
 b=k/RiulOsLzb7ldeuTsKiNMAxJWCxsJJkFdVWninPWI45XDjA9/Rr/Eqrls0URZ760Z
 11PAkkMUDmtbh+zGwdm8e//JKuMthejlmGxM1LVXU3V1QEvqWKD85mTy2hWflt9UryET
 T+zlfR+lu2jD6eSXWXew0+arI78Dqqs/fqHahOag4jt6WMQ5gLbvK02CdOTomPcxNp0s
 cAiGYY2ymRsHDoXodYn9FOYKUvtgPSXBVxa1TOEY+RIuDs2e8izdtEFUbXwZ2zA58U/x
 AH5yTWtT7w6xUFPgd2zciH6/AzwjJakxz65QUNYi4dUpXBG2uPsXHmAMppREjffo3ZJC
 B7Zw==
X-Gm-Message-State: ANhLgQ3rgswtutsWfwoKeVpueAn6I+jsraFwcBYcbqNPIgrZVoEss+sw
 /R+zQB/YuUKiDFBddC1kFesdSf3fCuLL9w==
X-Google-Smtp-Source: ADFU+vsQK53ghDw6BgKLPx/mukwtubdY+ak8tIByLYJbF0HYSYthMHCXFHm0KuUkRxXIz5AcYD1KWw==
X-Received: by 2002:adf:83c4:: with SMTP id 62mr6574854wre.105.1584646412099; 
 Thu, 19 Mar 2020 12:33:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm4984794wrw.20.2020.03.19.12.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2020 12:33:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] scripts/coverity-scan: Add Docker support
Date: Thu, 19 Mar 2020 19:33:23 +0000
Message-Id: <20200319193323.2038-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200319193323.2038-1-peter.maydell@linaro.org>
References: <20200319193323.2038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for running the Coverity Scan tools inside a Docker
container rather than directly on the host system.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2:
 * various bug fixes
 * added --src-tarball rather than putting the whole source
   tree in the 'secrets' directory
 * docker file package list updated
---
 scripts/coverity-scan/coverity-scan.docker | 131 +++++++++++++++++++++
 scripts/coverity-scan/run-coverity-scan    |  90 ++++++++++++++
 2 files changed, 221 insertions(+)
 create mode 100644 scripts/coverity-scan/coverity-scan.docker

diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
new file mode 100644
index 00000000000..a4f64d12834
--- /dev/null
+++ b/scripts/coverity-scan/coverity-scan.docker
@@ -0,0 +1,131 @@
+# syntax=docker/dockerfile:1.0.0-experimental
+#
+# Docker setup for running the "Coverity Scan" tools over the source
+# tree and uploading them to the website, as per
+# https://scan.coverity.com/projects/qemu/builds/new
+# We do this on a fixed config (currently Fedora 30 with a known
+# set of dependencies and a configure command that enables a specific
+# set of options) so that random changes don't result in our accidentally
+# dropping some files from the scan.
+#
+# We don't build on top of the fedora.docker file because we don't
+# want to accidentally change or break the scan config when that
+# is updated.
+
+# The work of actually doing the build is handled by the
+# run-coverity-scan script.
+
+FROM fedora:30
+ENV PACKAGES \
+    alsa-lib-devel \
+    bc \
+    bison \
+    brlapi-devel \
+    bzip2 \
+    bzip2-devel \
+    ccache \
+    clang \
+    curl \
+    cyrus-sasl-devel \
+    dbus-daemon \
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
+    libblockdev-mpath-devel \
+    libcap-devel \
+    libcap-ng-devel \
+    libcurl-devel \
+    libepoxy-devel \
+    libfdt-devel \
+    libgbm-devel \
+    libiscsi-devel \
+    libjpeg-devel \
+    libpmem-devel \
+    libnfs-devel \
+    libpng-devel \
+    librbd-devel \
+    libseccomp-devel \
+    libssh-devel \
+    libubsan \
+    libudev-devel \
+    libusbx-devel \
+    libxml2-devel \
+    libzstd-devel \
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
+    mingw32-libtasn1 \
+    mingw32-nettle \
+    mingw32-nsis \
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
+    perl-Test-Harness \
+    pixman-devel \
+    pulseaudio-libs-devel \
+    python3 \
+    python3-sphinx \
+    PyYAML \
+    rdma-core-devel \
+    SDL2-devel \
+    snappy-devel \
+    sparse \
+    spice-server-devel \
+    systemd-devel \
+    systemtap-sdt-devel \
+    tar \
+    texinfo \
+    usbredir-devel \
+    virglrenderer-devel \
+    vte291-devel \
+    wget \
+    which \
+    xen-devel \
+    xfsprogs-devel \
+    zlib-devel
+ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
+
+RUN dnf install -y $PACKAGES
+RUN rpm -q $PACKAGES | sort > /packages.txt
+ENV PATH $PATH:/usr/libexec/python3-sphinx/
+ENV COVERITY_TOOL_BASE=/coverity-tools
+COPY run-coverity-scan run-coverity-scan
+RUN --mount=type=secret,id=coverity.token,required ./run-coverity-scan --update-tools-only --tokenfile /run/secrets/coverity.token
diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index d40b51969fa..2e067ef5cfc 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -29,6 +29,7 @@
 
 # Command line options:
 #   --dry-run : run the tools, but don't actually do the upload
+#   --docker : create and work inside a docker container
 #   --update-tools-only : update the cached copy of the tools, but don't run them
 #   --tokenfile : file to read Coverity token from
 #   --version ver : specify version being analyzed (default: ask git)
@@ -36,6 +37,8 @@
 #   --srcdir : QEMU source tree to analyze (default: current working dir)
 #   --results-tarball : path to copy the results tarball to (default: don't
 #                       copy it anywhere, just upload it)
+#   --src-tarball : tarball to untar into src dir (default: none); this
+#                   is intended mainly for internal use by the Docker support
 #
 # User-specifiable environment variables:
 #  COVERITY_TOKEN -- Coverity token
@@ -125,6 +128,7 @@ update_coverity_tools () {
 # Check user-provided environment variables and arguments
 DRYRUN=no
 UPDATE_ONLY=no
+DOCKER=no
 
 while [ "$#" -ge 1 ]; do
     case "$1" in
@@ -181,6 +185,19 @@ while [ "$#" -ge 1 ]; do
             RESULTSTARBALL="$1"
             shift
             ;;
+        --src-tarball)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--src-tarball needs an argument"
+                exit 1
+            fi
+            SRCTARBALL="$1"
+            shift
+            ;;
+        --docker)
+            DOCKER=yes
+            shift
+            ;;
         *)
             echo "Unexpected argument '$1'"
             exit 1
@@ -212,6 +229,10 @@ PROJTOKEN="$COVERITY_TOKEN"
 PROJNAME=QEMU
 TARBALL=cov-int.tar.xz
 
+if [ "$UPDATE_ONLY" = yes ] && [ "$DOCKER" = yes ]; then
+    echo "Combining --docker and --update-only is not supported"
+    exit 1
+fi
 
 if [ "$UPDATE_ONLY" = yes ]; then
     # Just do the tools update; we don't need to check whether
@@ -221,8 +242,17 @@ if [ "$UPDATE_ONLY" = yes ]; then
     exit 0
 fi
 
+if [ ! -e "$SRCDIR" ]; then
+    mkdir "$SRCDIR"
+fi
+
 cd "$SRCDIR"
 
+if [ ! -z "$SRCTARBALL" ]; then
+    echo "Untarring source tarball into $SRCDIR..."
+    tar xvf "$SRCTARBALL"
+fi
+
 echo "Checking this is a QEMU source tree..."
 if ! [ -e "$SRCDIR/VERSION" ]; then
     echo "Not in a QEMU source tree?"
@@ -242,6 +272,66 @@ if [ -z "$COVERITY_EMAIL" ]; then
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
+    if [ "$DRYRUN" = yes ]; then
+        DRYRUNARG=--dry-run
+    fi
+    echo "Running scanner..."
+    # If we need to capture the output tarball, get the inner run to
+    # save it to the secrets directory so we can copy it out before the
+    # directory is cleaned up.
+    if [ ! -z "$RESULTSTARBALL" ]; then
+        RTARGS="--results-tarball /work/cov-int.tar.xz"
+    else
+        RTARGS=""
+    fi
+    # Arrange for this docker run to get access to the sources with -v.
+    # We pass through all the configuration from the outer script to the inner.
+    export COVERITY_EMAIL COVERITY_BUILD_CMD
+    docker run -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
+           -v "$SECRETDIR:/work" coverity-scanner \
+           ./run-coverity-scan --version "$VERSION" \
+           --description "$DESCRIPTION" $DRYRUNARG --tokenfile /work/token \
+           --srcdir /qemu --src-tarball /work/qemu-sources.tgz $RTARGS
+    if [ ! -z "$RESULTSTARBALL" ]; then
+        echo "Copying results tarball to $RESULTSTARBALL..."
+        cp "$SECRETDIR/cov-int.tar.xz" "$RESULTSTARBALL"
+    fi
+    echo "Docker work complete."
+    exit 0
+fi
+
+# Otherwise, continue with the full build and upload process.
+
 check_upload_permissions
 
 update_coverity_tools
-- 
2.20.1


