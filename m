Received: from eggs.gnu.org ([2001:4830:134:3::10]:46313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwOlY-00050T-08
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwOlT-0007iB-Sj
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:29:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dwOlT-0007hy-Ne
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:29:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 25 Sep 2017 16:29:13 +0800
Message-Id: <20170925082913.22089-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] docker: Fix test-mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Feature "dtc" is explicitly required by test-mingw, but is not detected
by the run script since we switched to archive-source.sh in b7f404201e4.
Since it isn't available in the Fedora image which runs this test on
patchew, the way we get dtc is still from submodule.

archive-source.sh takes care of bundling the submodule files already, so
what we need to do is just checking if files are there. Makefile is
chosen because it is one that is unlikely to get renamed in the future.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/run | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/docker/run b/tests/docker/run
index c8f940de15..0fd2f358ce 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -31,6 +31,9 @@ mkdir -p $TEST_DIR/{src,build,install}
 
 # Extract the source tarballs
 tar -C $TEST_DIR/src -xf $BASE/qemu.tar || prep_fail "Failed to untar source"
+if test -f $TEST_DIR/src/Makefile; then
+    export FEATURES="$FEATURES dtc"
+fi
 
 if test -n "$SHOW_ENV"; then
     if test -f /packages.txt; then
-- 
2.13.5
