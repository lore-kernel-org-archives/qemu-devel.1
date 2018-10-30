Received: from eggs.gnu.org ([2001:4830:134:3::10]:38040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gHTTb-0001NA-IU
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gHTTL-0001F7-BG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:50:19 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gHTTJ-0001A1-9z
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:50:15 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 12:50:04 +0000
Message-Id: <20181030125005.28151-3-peter.maydell@linaro.org>
In-Reply-To: <20181030125005.28151-1-peter.maydell@linaro.org>
References: <20181030125005.28151-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/3] configure: Symlink entire test directories
 rather than individual files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>

Instead of symlinking every individual file inside the data
directories used by some tests, just symlink the entire
directory. This avoids a problem where if a new data file
is added to the source tree, nothing results in configure
being rerun to create the symlink, and so test runs in the
build tree fail to find the file.

Add a comment noting why adding wildcards to FILES is
a bad idea. (Yes, we still do this for various files in pc-bios/;
we get away with this because we don't in practice add new
BIOS images often and if we do there's also usually a change
that means configure is rerun anyway. We can't just symlink
all of pc-bios into the build tree because it contains other
things than just generated binaries.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index b7d0167b650..acb9a4d39e5 100755
--- a/configure
+++ b/configure
@@ -7370,6 +7370,12 @@ fi
 # DIRS are directories which we simply mkdir in the build tree;
 # LINKS are things to symlink back into the source tree
 # (these can be both files and directories).
+# Caution: do not add files or directories here using wildcards. This
+# will result in problems later if a new file matching the wildcard is
+# added to the source tree -- nothing will cause configure to be rerun
+# so the build tree will be missing the link back to the new file, and
+# tests might fail. Prefer to keep the relevant files in their own
+# directory and symlink the directory instead.
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
 DIRS="$DIRS tests/fp"
 DIRS="$DIRS docs docs/interop fsdev scsi"
@@ -7385,6 +7391,7 @@ LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
 LINKS="$LINKS pc-bios/qemu-icon.bmp"
 LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
+LINKS="$LINKS tests/acpi-test-data tests/hex-loader-check-data"
 for bios_file in \
     $source_path/pc-bios/*.bin \
     $source_path/pc-bios/*.lid \
@@ -7398,14 +7405,6 @@ for bios_file in \
 do
     LINKS="$LINKS pc-bios/$(basename $bios_file)"
 done
-for test_file in $(find $source_path/tests/acpi-test-data -type f)
-do
-    LINKS="$LINKS tests/acpi-test-data$(echo $test_file | sed -e 's/.*acpi-test-data//')"
-done
-for test_file in $(find $source_path/tests/hex-loader-check-data -type f)
-do
-    LINKS="$LINKS tests/hex-loader-check-data$(echo $test_file | sed -e 's/.*hex-loader-check-data//')"
-done
 mkdir -p $DIRS
 for f in $LINKS ; do
     if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" != "y" ]; then
-- 
2.19.1
