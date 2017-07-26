Received: from eggs.gnu.org ([2001:4830:134:3::10]:42184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2n-0004wb-UL
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2m-0006fY-58
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:37 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:35230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daU2m-0006fM-0J
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 17:40:36 -0400
Received: by mail-ua0-x243.google.com with SMTP id d29so14016965uai.2
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:40:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 18:40:10 -0300
Message-Id: <20170726214010.420-5-f4bug@amsat.org>
In-Reply-To: <20170726214010.420-1-f4bug@amsat.org>
References: <20170726214010.420-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.10 4/4] fdt: compile dtc submodule to
 check it is up-to-date
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Yongbok Kim <yongbok.kim@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

Reported-by: John Arbuckle <programmingkidx@gmail.com>
Message-Id: <65ED9743-B53C-4E6A-866F-C883650914CE@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 2d803d6a77..386262ec33 100755
--- a/configure
+++ b/configure
@@ -3575,15 +3575,29 @@ EOF
     fdt=yes
   elif test -d ${source_path}/dtc/libfdt ; then
     # have submodule DTC - use it
-    fdt=yes
     dtc_internal="yes"
     mkdir -p dtc
     if [ "$pwd_is_source_path" != "y" ] ; then
-       symlink "$source_path/dtc/Makefile" "dtc/Makefile"
-       symlink "$source_path/dtc/scripts" "dtc/scripts"
+      for f in $(cd $source_path/dtc && ls Makefile* *.?); do
+        symlink "$source_path/dtc/$f" "dtc/$f"
+      done
+      for d in scripts libfdt tests; do
+        symlink "$source_path/dtc/$d" "dtc/$d"
+      done
+      SRC_PATH=$source_path
+    fi
+    make -C dtc 1>/dev/null
+
+    fdt_cflags="-I${source_path}/dtc/libfdt"
+    fdt_libs="-L$(pwd)/dtc/libfdt $fdt_libs"
+    if compile_prog "$fdt_cflags" "$fdt_libs" ; then
+      fdt=yes
+    else
+      error_exit "Your DTC submodule is outdated. Your options:" \
+        "  (1) Preferred: Install the DTC (libfdt) devel package" \
+        "  (2) Update the DTC submodule, using: $git_submodule_path_info" \
+        "      git submodule update --init dtc"
     fi
-    fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
-    fdt_libs="-L\$(BUILD_DIR)/dtc/libfdt $fdt_libs"
   elif test "$fdt" = "yes" ; then
     # have neither and want - prompt for system/submodule install
     error_exit "DTC (libfdt) version >= 1.4.2 not present. Your options:" \
-- 
2.13.3
