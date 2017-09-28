Received: from eggs.gnu.org ([2001:4830:134:3::10]:52371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxUR6-0005Se-QX
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxUR5-0005sI-Cd
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxUR5-0005qZ-5q
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:44:47 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 28 Sep 2017 09:44:26 +0100
Message-Id: <20170928084430.17059-3-berrange@redhat.com>
In-Reply-To: <20170928084430.17059-1-berrange@redhat.com>
References: <20170928084430.17059-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/6] docker: don't rely on submodules
 existing in the main checkout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

When building the tarball to pass into the docker/vm test image,
the code relies on the git submodules being checked out in the
main checkout.

ie if the developer has not run 'git submodule update --init dtc'
most (all?) of the docker tests will fail due to the missing dtc
package in the test images. Patchew manually checks out the dtc
submodule in the main git checkout, but this is a bad idea. The
docker tests should never mess around with the developer's main
GIT checkout.

When running tests we want to have a predictable set of submodules
included in the source that's tested. The build environment is
completely independant of the developers host OS, so the submodules
the developer has checked out should not be considered relevant for
the tests.

This changes the archive-source.sh script so that it clones the
current git checkout into a temporary directory, checks out a
fixed set of submodules, builds the tarball and finally removes
the temporary git clone.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/archive-source.sh | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index c4e7d98f4d..0d2046a80e 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -18,9 +18,15 @@ if test $# -lt 1; then
     error "Usage: $0 <output tarball>"
 fi
 
-tar_file="$1"
-list_file="$1.list"
-submodules=$(git submodule foreach --recursive --quiet 'echo $name')
+tar_file=`realpath "$1"`
+list_file="${tar_file}.list"
+vroot_dir="${tar_file}.vroot"
+
+# We want a predictable list of submodules for builds, that is
+# independant of what the developer currently has initialized
+# in their checkout, because the build environment is completely
+# different to the host OS.
+submodules="dtc"
 
 if test $? -ne 0; then
     error "git submodule command failed"
@@ -28,6 +34,14 @@ fi
 
 trap "status=$?; rm -f \"$list_file\"; exit \$status" 0 1 2 3 15
 
+git clone --shared . "$vroot_dir"
+here=`pwd`
+cd "$vroot_dir"
+
+for sm in $submodules; do
+    git submodule update --init $sm
+done
+
 if test -n "$submodules"; then
     {
         git ls-files || error "git ls-files failed"
@@ -48,4 +62,7 @@ fi
 
 tar -cf "$tar_file" -T "$list_file" || error "failed to create tar file"
 
+cd "$here"
+rm -rf "$vroot_dir"
+
 exit 0
-- 
2.13.5
