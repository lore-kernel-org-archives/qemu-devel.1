Received: from eggs.gnu.org ([2001:4830:134:3::10]:38072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gHTTi-0001Tt-U5
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gHTTh-0001l1-0Z
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:50:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gHTTf-0001A1-0F
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:50:36 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 12:50:03 +0000
Message-Id: <20181030125005.28151-2-peter.maydell@linaro.org>
In-Reply-To: <20181030125005.28151-1-peter.maydell@linaro.org>
References: <20181030125005.28151-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] configure: Rename FILES variable to LINKS
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

The FILES variable is used to accumulate a list of things to symlink
from the source tree into the build tree.  These don't have to be
individual files; symlinking an entire directory of data files is
also fine.  Rename it to something less confusing before we add a few
directories to it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/configure b/configure
index 1c473ce95ba..b7d0167b650 100755
--- a/configure
+++ b/configure
@@ -7366,22 +7366,25 @@ if test "$ccache_cpp2" = "yes"; then
   echo "export CCACHE_CPP2=y" >> $config_host_mak
 fi
 
-# build tree in object directory in case the source is not in the current directory
+# If we're using a separate build tree, set it up now.
+# DIRS are directories which we simply mkdir in the build tree;
+# LINKS are things to symlink back into the source tree
+# (these can be both files and directories).
 DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
 DIRS="$DIRS tests/fp"
 DIRS="$DIRS docs docs/interop fsdev scsi"
 DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
 DIRS="$DIRS roms/seabios roms/vgabios"
-FILES="Makefile tests/tcg/Makefile qdict-test-data.txt"
-FILES="$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
-FILES="$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
-FILES="$FILES tests/fp/Makefile"
-FILES="$FILES pc-bios/optionrom/Makefile pc-bios/keymaps"
-FILES="$FILES pc-bios/spapr-rtas/Makefile"
-FILES="$FILES pc-bios/s390-ccw/Makefile"
-FILES="$FILES roms/seabios/Makefile roms/vgabios/Makefile"
-FILES="$FILES pc-bios/qemu-icon.bmp"
-FILES="$FILES .gdbinit scripts" # scripts needed by relative path in .gdbinit
+LINKS="Makefile tests/tcg/Makefile qdict-test-data.txt"
+LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
+LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
+LINKS="$LINKS tests/fp/Makefile"
+LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
+LINKS="$LINKS pc-bios/spapr-rtas/Makefile"
+LINKS="$LINKS pc-bios/s390-ccw/Makefile"
+LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
+LINKS="$LINKS pc-bios/qemu-icon.bmp"
+LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
 for bios_file in \
     $source_path/pc-bios/*.bin \
     $source_path/pc-bios/*.lid \
@@ -7393,18 +7396,18 @@ for bios_file in \
     $source_path/pc-bios/u-boot.* \
     $source_path/pc-bios/palcode-*
 do
-    FILES="$FILES pc-bios/$(basename $bios_file)"
+    LINKS="$LINKS pc-bios/$(basename $bios_file)"
 done
 for test_file in $(find $source_path/tests/acpi-test-data -type f)
 do
-    FILES="$FILES tests/acpi-test-data$(echo $test_file | sed -e 's/.*acpi-test-data//')"
+    LINKS="$LINKS tests/acpi-test-data$(echo $test_file | sed -e 's/.*acpi-test-data//')"
 done
 for test_file in $(find $source_path/tests/hex-loader-check-data -type f)
 do
-    FILES="$FILES tests/hex-loader-check-data$(echo $test_file | sed -e 's/.*hex-loader-check-data//')"
+    LINKS="$LINKS tests/hex-loader-check-data$(echo $test_file | sed -e 's/.*hex-loader-check-data//')"
 done
 mkdir -p $DIRS
-for f in $FILES ; do
+for f in $LINKS ; do
     if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" != "y" ]; then
         symlink "$source_path/$f" "$f"
     fi
-- 
2.19.1
