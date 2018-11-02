Received: from eggs.gnu.org ([2001:4830:134:3::10]:60346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gIY61-0004Gk-Cb
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gIY5x-0007P6-FF
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:58:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gIY5x-0007Or-5A
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 07:58:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  2 Nov 2018 11:52:37 +0000
Message-Id: <20181102115239.22485-3-peter.maydell@linaro.org>
In-Reply-To: <20181102115239.22485-1-peter.maydell@linaro.org>
References: <20181102115239.22485-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for-3.1 2/4] tests: Move
 tests/hex-loader-check-data/ to tests/data/hex-loader/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Currently tests/hex-loader-check-data contains data files used
by the hexloader-test, and configure individually symlinks those
data files into the build directory using a wildcard.

Using a wildcard like this is a bad idea, because if a new
data file is added, nothing causes configure to be rerun,
and so no symlink is added for the new file. This can cause
tests to spuriously fail when they can't find their data.
Instead, it's better to symlink an entire directory of
data files. We already have such a directory: tests/data.

Move the data files from tests/hex-loader-check-data/ to
tests/data/hex-loader/, and remove the unnecessary symlinking.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure                                                 | 4 ----
 tests/hexloader-test.c                                    | 2 +-
 MAINTAINERS                                               | 2 +-
 tests/{hex-loader-check-data => data/hex-loader}/test.hex | 0
 4 files changed, 2 insertions(+), 6 deletions(-)
 rename tests/{hex-loader-check-data => data/hex-loader}/test.hex (100%)

diff --git a/configure b/configure
index 895b7483b8a..bfdca8b814e 100755
--- a/configure
+++ b/configure
@@ -7421,10 +7421,6 @@ for bios_file in \
 do
     FILES="$FILES pc-bios/$(basename $bios_file)"
 done
-for test_file in $(find $source_path/tests/hex-loader-check-data -type f)
-do
-    FILES="$FILES tests/hex-loader-check-data$(echo $test_file | sed -e 's/.*hex-loader-check-data//')"
-done
 mkdir -p $DIRS
 for f in $FILES ; do
     if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" != "y" ]; then
diff --git a/tests/hexloader-test.c b/tests/hexloader-test.c
index b653d44ba10..834ed52c22b 100644
--- a/tests/hexloader-test.c
+++ b/tests/hexloader-test.c
@@ -23,7 +23,7 @@ static void hex_loader_test(void)
     const unsigned int base_addr = 0x00010000;
 
     QTestState *s = qtest_initf(
-        "-M vexpress-a9 -nographic -device loader,file=tests/hex-loader-check-data/test.hex");
+        "-M vexpress-a9 -nographic -device loader,file=tests/data/hex-loader/test.hex");
 
     for (i = 0; i < 256; ++i) {
         uint8_t val = qtest_readb(s, base_addr + i);
diff --git a/MAINTAINERS b/MAINTAINERS
index f2360efe3ed..5c342a670f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1369,7 +1369,7 @@ Intel Hexadecimal Object File Loader
 M: Su Hang <suhang16@mails.ucas.ac.cn>
 S: Maintained
 F: tests/hexloader-test.c
-F: tests/hex-loader-check-data/test.hex
+F: tests/data/hex-loader/test.hex
 
 CHRP NVRAM
 M: Thomas Huth <thuth@redhat.com>
diff --git a/tests/hex-loader-check-data/test.hex b/tests/data/hex-loader/test.hex
similarity index 100%
rename from tests/hex-loader-check-data/test.hex
rename to tests/data/hex-loader/test.hex
-- 
2.19.1
