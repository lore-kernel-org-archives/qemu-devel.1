Received: from eggs.gnu.org ([2001:4830:134:3::10]:33606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlp1-0007d6-S0
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlp1-0002XT-04
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dxlp0-0002Ww-Qt
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:38 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 29 Sep 2017 11:18:28 +0800
Message-Id: <20170929031831.10179-3-famz@redhat.com>
In-Reply-To: <20170929031831.10179-1-famz@redhat.com>
References: <20170929031831.10179-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] docker: Fix test-mingw
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
List-ID: <qemu-devel.nongnu.org>

Feature "dtc" is explicitly required by test-mingw, but is not detected
by the run script since we switched to archive-source.sh in b7f404201e4.
Since it isn't available in the Fedora image which runs this test on
patchew, the way we get dtc is still from submodule.

archive-source.sh takes care of bundling the submodule files already, so
what we need to do is just checking if files are there. Makefile is
chosen because it is one that is unlikely to get renamed in the future.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170925082913.22089-1-famz@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
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
