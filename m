Received: from eggs.gnu.org ([209.51.188.92]:48726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyp3-0003CO-JU
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqyp2-0006Bp-P0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:23:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqyp2-0006BR-HW
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 06:23:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03C13C034DE1
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 11:23:23 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  5 Feb 2019 12:23:15 +0100
Message-Id: <20190205112315.23454-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v4] scripts: use git archive in archive-source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

Use git archive to create tarballs of qemu and submodules instead of
cloning the repository and the submodules.  This is a order of magnitude
faster because it doesn't fetch the submodules from the internet each
time the script runs.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 scripts/archive-source.sh | 67 ++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 6eed2a29bd..a4ea98ded4 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -19,16 +19,25 @@ if test $# -lt 1; then
 fi
 
 tar_file=$(realpath "$1")
-list_file="${tar_file}.list"
-vroot_dir="${tar_file}.vroot"
+sub_tdir=$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")
+sub_file="${sub_tdir}/submodule.tar"
 
 # We want a predictable list of submodules for builds, that is
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
 submodules="dtc ui/keycodemapdb tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
+sub_deinit=""
 
-trap "status=$?; rm -rf \"$list_file\" \"$vroot_dir\"; exit \$status" 0 1 2 3 15
+function cleanup() {
+    local status=$?
+    rm -rf "$sub_tdir"
+    if test "$sub_deinit" != ""; then
+	git submodule deinit $sub_deinit
+    fi
+    exit $status
+}
+trap "cleanup" 0 1 2 3 15
 
 if git diff-index --quiet HEAD -- &>/dev/null
 then
@@ -36,38 +45,24 @@ then
 else
     HEAD=$(git stash create)
 fi
-git clone --shared . "$vroot_dir"
-test $? -ne 0 && error "failed to clone into '$vroot_dir'"
-
-cd "$vroot_dir"
-test $? -ne 0 && error "failed to change into '$vroot_dir'"
-
-git checkout $HEAD
-test $? -ne 0 && error "failed to checkout $HEAD revision"
-
+git archive --format tar $HEAD > "$tar_file"
+test $? -ne 0 && error "failed to archive qemu"
 for sm in $submodules; do
-    git submodule update --init $sm
-    test $? -ne 0 && error "failed to init submodule $sm"
+    status="$(git submodule status "$sm")"
+    smhash="${status#[ +-]}"
+    smhash="${smhash%% *}"
+    case "$status" in
+	-*)
+	    sub_deinit="$sub_deinit $sm"
+	    git submodule update --init "$sm"
+	    test $? -ne 0 && error "failed to update submodule $sm"
+	    ;;
+	+*)
+	    echo "WARNING: submodule $sm is out of sync"
+	    ;;
+    esac
+    (cd $sm; git archive --format tar --prefix "$sm/" $smhash) > "$sub_file"
+    test $? -ne 0 && error "failed to archive submodule $sm ($smhash)"
+    tar --concatenate --file "$tar_file" "$sub_file"
+    test $? -ne 0 && error "failed append submodule $sm to $tar_file"
 done
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
-
-if test $? -ne 0; then
-    error "failed to generate list file"
-fi
-
-tar -cf "$tar_file" -T "$list_file" || error "failed to create tar file"
-
-exit 0
-- 
2.9.3
