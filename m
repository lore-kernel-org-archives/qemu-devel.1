Received: from eggs.gnu.org ([2001:4830:134:3::10]:38749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMdiC-0000VB-7Q
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMdiA-0000Mo-EL
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:46:56 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMdiA-0000GQ-3z
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:46:54 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 18:46:40 +0000
Message-Id: <20181113184641.4492-2-peter.maydell@linaro.org>
In-Reply-To: <20181113184641.4492-1-peter.maydell@linaro.org>
References: <20181113184641.4492-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] scripts/run-coverity-scan: Script to run
 Coverity Scan build
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

Add a new script to automate the process of running the Coverity
Scan build tools and uploading the resulting tarball to the
website.

This is intended eventually to be driven from Travis,
but it can be run locally, if you are a maintainer of the
QEMU project on the Coverity Scan website and have the secret
upload token.

The script must be run directly on a Fedora 28 system.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                             |   5 +
 scripts/coverity-scan/run-coverity-scan | 292 ++++++++++++++++++++++++
 2 files changed, 297 insertions(+)
 create mode 100755 scripts/coverity-scan/run-coverity-scan

diff --git a/MAINTAINERS b/MAINTAINERS
index 126fe0be7eb..5f107d99061 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1553,6 +1553,11 @@ M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: scripts/coverity-model.c
 
+Coverity Scan integration
+M: Peter Maydell <peter.maydell@linaro.org>
+S: Maintained
+F: scripts/coverity-scan/
+
 CPU
 L: qemu-devel@nongnu.org
 S: Supported
diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
new file mode 100755
index 00000000000..99495b04501
--- /dev/null
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -0,0 +1,292 @@
+#!/bin/sh -e
+
+# Upload a created tarball to Coverity Scan, as per
+# https://scan.coverity.com/projects/qemu/builds/new
+
+# This work is licensed under the terms of the GNU GPL version 2,
+# or (at your option) any later version.
+# See the COPYING file in the top-level directory.
+#
+# Copyright (c) 2017, 2018 Linaro Limited
+# Written by Peter Maydell
+
+# Note that this script will automatically download and
+# run the (closed-source) coverity build tools, so don't
+# use it if you don't trust them!
+
+# This script assumes that you're running it from a QEMU source
+# tree, and that tree is a fresh clean one, because we do an in-tree
+# build. (This is necessary so that the filenames that the Coverity
+# Scan server sees are relative paths that match up with the component
+# regular expressions it uses; an out-of-tree build won't work for this.)
+# The host machine should have as many of QEMU's dependencies
+# installed as possible, for maximum coverity coverage.
+
+# To do an upload you need to be a maintainer in the Coverity online
+# service, and you will need to know the "Coverity token", which is a
+# secret 8 digit hex string. You can find that from the web UI in the
+# project settings, if you have maintainer access there.
+
+# Command line options:
+#   --dry-run : run the tools, but don't actually do the upload
+#   --update-tools-only : update the cached copy of the tools, but don't run them
+#   --tokenfile : file to read Coverity token from
+#   --version ver : specify version being analyzed (default: ask git)
+#   --description desc : specify description of this version (default: ask git)
+#   --srcdir : QEMU source tree to analyze (default: current working dir)
+#
+# User-specifiable environment variables:
+#  COVERITY_TOKEN -- Coverity token
+#  COVERITY_EMAIL -- the email address to use for uploads (default:
+#                    looks at your git user.email config)
+#  COVERITY_BUILD_CMD -- make command (default: 'make -j8')
+#  COVERITY_TOOL_BASE -- set to directory to put coverity tools
+#                        (default: /tmp/coverity-tools)
+#
+# You must specify the token, either by environment variable or by
+# putting it in a file and using --tokenfile. Everything else has
+# a reasonable default if this is run from a git tree.
+
+check_upload_permissions() {
+    # Check whether we can do an upload to the server; will exit the script
+    # with status 1 if the check failed (usually a bad token);
+    # will exit the script with status 0 if the check indicated that we
+    # can't upload yet (ie we are at quota)
+    # Assumes that PROJTOKEN, PROJNAME and DRYRUN have been initialized.
+
+    echo "Checking upload permissions..."
+
+    if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted --post-data "token=$PROJTOKEN&project=$PROJNAME" -q -O -)"; then
+        echo "Coverity Scan API access denied: bad token?"
+        exit 1
+    fi
+
+    # Really up_perm is a JSON response with either
+    # {upload_permitted:true} or {next_upload_permitted_at:<date>}
+    # We do some hacky string parsing instead of properly parsing it.
+    case "$up_perm" in
+        *upload_permitted*true*)
+            echo "Coverity Scan: upload permitted"
+            ;;
+        *next_upload_permitted_at*)
+            if [ "$DRYRUN" = yes ]; then
+                echo "Coverity Scan: upload quota reached; stopping here"
+                # Exit success as this isn't a build error.
+                exit 0
+            else
+                echo "Coverity Scan: upload quota reached, continuing dry run"
+            fi
+            ;;
+        *)
+            echo "Coverity Scan upload check: unexpected result $up_perm"
+            exit 1
+            ;;
+    esac
+}
+
+
+update_coverity_tools () {
+    # Check for whether we need to download the Coverity tools
+    # (either because we don't have a copy, or because it's out of date)
+    # Assumes that COVERITY_TOOL_BASE, PROJTOKEN and PROJNAME are set.
+
+    mkdir -p "$COVERITY_TOOL_BASE"
+    cd "$COVERITY_TOOL_BASE"
+
+    echo "Checking for new version of coverity build tools..."
+    wget https://scan.coverity.com/download/linux64 --post-data "token=$PROJTOKEN&project=$PROJNAME&md5=1" -O coverity_tool.md5.new
+
+    if ! cmp -s coverity_tool.md5 coverity_tool.md5.new; then
+        # out of date md5 or no md5: download new build tool
+        # blow away the old build tool
+        echo "Downloading coverity build tools..."
+        rm -rf coverity_tool coverity_tool.tgz
+        wget https://scan.coverity.com/download/linux64 --post-data "token=$PROJTOKEN&project=$PROJNAME" -O coverity_tool.tgz
+        if ! (cat coverity_tool.md5.new; echo "  coverity_tool.tgz") | md5sum -c --status; then
+            echo "Downloaded tarball didn't match md5sum!"
+            exit 1
+        fi
+        # extract the new one, keeping it corralled in a 'coverity_tool' directory
+        echo "Unpacking coverity build tools..."
+        mkdir -p coverity_tool
+        cd coverity_tool
+        tar xf ../coverity_tool.tgz
+        cd ..
+        mv coverity_tool.md5.new coverity_tool.md5
+    fi
+
+    rm -f coverity_tool.md5.new
+}
+
+
+# Check user-provided environment variables and arguments
+DRYRUN=no
+UPDATE_ONLY=no
+
+while [ "$#" -ge 1 ]; do
+    case "$1" in
+        --dry-run)
+            shift
+            DRYRUN=yes
+            ;;
+        --update-tools-only)
+            shift
+            UPDATE_ONLY=yes
+            ;;
+        --version)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--version needs an argument"
+                exit 1
+            fi
+            VERSION="$1"
+            shift
+            ;;
+        --description)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--description needs an argument"
+                exit 1
+            fi
+            DESCRIPTION="$1"
+            shift
+            ;;
+        --tokenfile)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--tokenfile needs an argument"
+                exit 1
+            fi
+            COVERITY_TOKEN="$(cat "$1")"
+            shift
+            ;;
+        --srcdir)
+            shift
+            if [ $# -eq 0 ]; then
+                echo "--srcdir needs an argument"
+                exit 1
+            fi
+            SRCDIR="$1"
+            shift
+            ;;
+        *)
+            echo "Unexpected argument '$1'"
+            exit 1
+            ;;
+    esac
+done
+
+if [ -z "$COVERITY_TOKEN" ]; then
+    echo "COVERITY_TOKEN environment variable not set"
+    exit 1
+fi
+
+if [ -z "$COVERITY_BUILD_CMD" ]; then
+    echo "COVERITY_BUILD_CMD: using default 'make -j8'"
+    COVERITY_BUILD_CMD="make -j8"
+fi
+
+if [ -z "$COVERITY_TOOL_BASE" ]; then
+    echo "COVERITY_TOOL_BASE: using default /tmp/coverity-tools"
+    COVERITY_TOOL_BASE=/tmp/coverity-tools
+fi
+
+if [ -z "$SRCDIR" ]; then
+    SRCDIR="$(pwd)"
+fi
+
+PROJTOKEN="$COVERITY_TOKEN"
+PROJNAME=QEMU
+TARBALL=cov-int.tar.xz
+
+
+if [ "$UPDATE_ONLY" = yes ]; then
+    # Just do the tools update; we don't need to check whether
+    # we are in a source tree or have upload rights for this,
+    # so do it before some of the command line and source tree checks.
+    update_coverity_tools
+    exit 0
+fi
+
+cd "$SRCDIR"
+
+echo "Checking this is a QEMU source tree..."
+if ! [ -e "$SRCDIR/VERSION" ]; then
+    echo "Not in a QEMU source tree?"
+    exit 1
+fi
+
+# Fill in defaults used by the non-update-only process
+if [ -z "$VERSION" ]; then
+    VERSION="$(git describe --always HEAD)"
+fi
+
+if [ -z "$DESCRIPTION" ]; then
+    DESCRIPTION="$(git rev-parse HEAD)"
+fi
+
+if [ -z "$COVERITY_EMAIL" ]; then
+    COVERITY_EMAIL="$(git config user.email)"
+fi
+
+check_upload_permissions
+
+update_coverity_tools
+
+TOOLBIN="$(cd "$COVERITY_TOOL_BASE" && echo $(pwd)/coverity_tool/cov-analysis-*/bin)"
+
+if ! test -x "$TOOLBIN/cov-build"; then
+    echo "Couldn't find cov-build in the coverity build-tool directory??"
+    exit 1
+fi
+
+export PATH="$TOOLBIN:$PATH"
+
+cd "$SRCDIR"
+
+echo "Doing make distclean..."
+make distclean
+
+echo "Configuring..."
+# We configure with a fixed set of enables here to ensure that we don't
+# accidentally reduce the scope of the analysis by doing the build on
+# the system that's missing a dependency that we need to build part of
+# the codebase.
+./configure --disable-modules --enable-sdl --with-sdlabi=2.0 --enable-gtk \
+    --enable-opengl --enable-vte --enable-gnutls \
+    --enable-nettle --enable-curses --enable-curl \
+    --audio-drv-list=oss,alsa,sdl,pa --enable-virtfs \
+    --enable-vnc --enable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png \
+    --enable-xen --enable-brlapi --enable-bluez \
+    --disable-vde --enable-linux-aio --enable-attr \
+    --enable-cap-ng --enable-trace-backends=log --enable-spice --enable-rbd \
+    --enable-xfsctl --enable-libusb --enable-usb-redir \
+    --enable-libiscsi --enable-libnfs --enable-seccomp \
+    --enable-tpm --enable-libssh2 --enable-lzo --enable-snappy --enable-bzip2 \
+    --enable-numa --enable-rdma --enable-smartcard --enable-virglrenderer \
+    --enable-mpath --enable-libxml2 --enable-glusterfs
+
+echo "Making libqemustub.a..."
+make libqemustub.a
+
+echo "Running cov-build..."
+rm -rf cov-int
+mkdir cov-int
+cov-build --dir cov-int $COVERITY_BUILD_CMD
+
+echo "Creating results tarball..."
+tar cvf - cov-int | xz > "$TARBALL"
+
+echo "Uploading results tarball..."
+
+if [ "$DRYRUN" = yes ]; then
+    echo "Dry run only, not uploading $TARBALL"
+    exit 0
+fi
+
+curl --form token="$PROJTOKEN" --form email="$COVERITY_EMAIL" \
+     --form file=@"$TARBALL" --form version="$VERSION" \
+     --form description="$DESCRIPTION" \
+     https://scan.coverity.com/builds?project="$PROJNAME"
+
+echo "Done."
-- 
2.19.1
