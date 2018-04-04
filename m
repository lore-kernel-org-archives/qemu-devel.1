Received: from eggs.gnu.org ([2001:4830:134:3::10]:47314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3YXB-0001V3-EU
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3YX8-0003do-Cu
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:52:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48866 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f3YX8-0003de-7a
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 22:52:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  4 Apr 2018 10:51:59 +0800
Message-Id: <20180404025201.11921-2-famz@redhat.com>
In-Reply-To: <20180404025201.11921-1-famz@redhat.com>
References: <20180404025201.11921-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] archive-source.sh: Drop submodule code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

./configure and make now take care of submodules, we only need to clone
the top tree.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 scripts/archive-source.sh | 47 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 4e63774f9a..d53774d507 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -18,51 +18,12 @@ if test $# -lt 1; then
     error "Usage: $0 <output tarball>"
 fi
 
-tar_file=`realpath "$1"`
-list_file="${tar_file}.list"
-vroot_dir="${tar_file}.vroot"
+tar_file="$1"
+list_file="$1.list"
 
-# We want a predictable list of submodules for builds, that is
-# independent of what the developer currently has initialized
-# in their checkout, because the build environment is completely
-# different to the host OS.
-submodules="dtc ui/keycodemapdb"
+trap "status=$?; rm -f \"$list_file\"; exit \$status" 0 1 2 3 15
 
-trap "status=$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$status" 0 1 2 3 15
-
-if git diff-index --quiet HEAD -- &>/dev/null
-then
-    HEAD=HEAD
-else
-    HEAD=`git stash create`
-fi
-git clone --shared . "$vroot_dir"
-test $? -ne 0 && error "failed to clone into '$vroot_dir'"
-
-cd "$vroot_dir"
-test $? -ne 0 && error "failed to change into '$vroot_dir'"
-
-git checkout $HEAD
-test $? -ne 0 && error "failed to checkout $HEAD revision"
-
-for sm in $submodules; do
-    git submodule update --init $sm
-    test $? -ne 0 && error "failed to init submodule $sm"
-done
-
-if test -n "$submodules"; then
-    {
-        git ls-files || error "git ls-files failed"
-        for sm in $submodules; do
-            (cd $sm; git ls-files) | sed "s:^:$sm/:"
-            if test "${PIPESTATUS[*]}" != "0 0"; then
-                error "git ls-files in submodule $sm failed"
-            fi
-        done
-    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > "$list_file"
-else
-    git ls-files > "$list_file"
-fi
+( git ls-files && echo '.git' ) > "$list_file"
 
 if test $? -ne 0; then
     error "failed to generate list file"
-- 
2.14.3
