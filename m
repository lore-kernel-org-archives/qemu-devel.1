Received: from eggs.gnu.org ([2001:4830:134:3::10]:58544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2CUw-0003xz-V9
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2CUq-0007iQ-Tg
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:36:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2CUq-0007hV-LN
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE60446210
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 08:36:07 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Oct 2017 10:35:56 +0200
Message-Id: <20171011083604.11820-3-kraxel@redhat.com>
In-Reply-To: <20171011083604.11820-1-kraxel@redhat.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] docker: don't rely on submodules existing
 in the main checkout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

When building the tarball to pass into the docker/vm test image,
the code relies on the git submodules being checked out in the
main checkout.

ie if the developer has not run 'git submodule update --init dtc'
many of the docker tests will fail due to the libfdt package not
being present in the test images. Patchew manually checks out the
dtc submodule in the main git checkout, but this is a bad idea.

When running tests we want to have a predictable set of submodules
included in the source that's tested. The build environment is
completely independent of the developers host OS, so the submodules
the developer has checked out should not be considered relevant for
the tests.

This changes the archive-source.sh script so that it clones the
current git checkout into a temporary directory, checks out a
fixed set of submodules, builds the tarball and finally removes
the temporary git clone.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170929101201.21039-3-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 scripts/archive-source.sh | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index c4e7d98f4d..4029de7b20 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -18,15 +18,37 @@ if test $# -lt 1; then
     error "Usage: $0 <output tarball>"
 fi
 
-tar_file="$1"
-list_file="$1.list"
-submodules=$(git submodule foreach --recursive --quiet 'echo $name')
+tar_file=`realpath "$1"`
+list_file="${tar_file}.list"
+vroot_dir="${tar_file}.vroot"
 
-if test $? -ne 0; then
-    error "git submodule command failed"
+# We want a predictable list of submodules for builds, that is
+# independent of what the developer currently has initialized
+# in their checkout, because the build environment is completely
+# different to the host OS.
+submodules="dtc"
+
+trap "status=$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$status" 0 1 2 3 15
+
+if git diff-index --quiet HEAD -- &>/dev/null
+then
+    HEAD=HEAD
+else
+    HEAD=`git stash create`
 fi
+git clone --shared . "$vroot_dir"
+test $? -ne 0 && error "failed to clone into '$vroot_dir'"
 
-trap "status=$?; rm -f \"$list_file\"; exit \$status" 0 1 2 3 15
+cd "$vroot_dir"
+test $? -ne 0 && error "failed to change into '$vroot_dir'"
+
+git checkout $HEAD
+test $? -ne 0 && error "failed to checkout $HEAD revision"
+
+for sm in $submodules; do
+    git submodule update --init $sm
+    test $? -ne 0 && error "failed to init submodule $sm"
+done
 
 if test -n "$submodules"; then
     {
-- 
2.9.3
