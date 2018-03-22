Received: from eggs.gnu.org ([2001:4830:134:3::10]:51096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez4f9-0001bf-IR
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ez4f8-0002hE-Nz
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:07 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:32986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ez4f8-0002gT-GF
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:10:06 -0400
Received: by mail-lf0-x243.google.com with SMTP id x205-v6so14559040lfa.0
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 11:10:06 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 22 Mar 2018 11:09:39 -0700
Message-Id: <20180322180940.8253-3-jcmvbkbc@gmail.com>
In-Reply-To: <20180322180940.8253-1-jcmvbkbc@gmail.com>
References: <20180322180940.8253-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] target/xtensa/import_core.sh: fix names of
 non-top level files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Add .inc. to the names of files imported from configuration overlay in
the import_core.sh script to follow the rule of naming non-top level
source files.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/import_core.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
index 32255eea9b1b..58a42987d853 100755
--- a/target/xtensa/import_core.sh
+++ b/target/xtensa/import_core.sh
@@ -22,7 +22,7 @@ mkdir -p "$TARGET"
 tar -xf "$OVERLAY" -C "$TARGET" --strip-components=1 \
     --xform='s/core/core-isa/' config/core.h
 tar -xf "$OVERLAY" -O gdb/xtensa-config.c | \
-    sed -n '1,/*\//p;/XTREG/,/XTREG_END/p' > "$TARGET"/gdb-config.c
+    sed -n '1,/*\//p;/XTREG/,/XTREG_END/p' > "$TARGET"/gdb-config.inc.c
 #
 # Fix up known issues in the xtensa-modules.c
 #
@@ -33,7 +33,7 @@ tar -xf "$OVERLAY" -O binutils/xtensa-modules.c | \
         -e '/^uint32 \*bypass_entry(int i)/,/}/d' \
         -e '/^#include "ansidecl.h"/d' \
         -e '/^Slot_[a-zA-Z0-9_]\+_decode (const xtensa_insnbuf insn)/,/^}/s/^  return 0;$/  return XTENSA_UNDEFINED;/' \
-    > "$TARGET"/xtensa-modules.c
+    > "$TARGET"/xtensa-modules.inc.c
 
 cat <<EOF > "${TARGET}.c"
 #include "qemu/osdep.h"
@@ -47,13 +47,13 @@ cat <<EOF > "${TARGET}.c"
 #include "overlay_tool.h"
 
 #define xtensa_modules xtensa_modules_$NAME
-#include "core-$NAME/xtensa-modules.c"
+#include "core-$NAME/xtensa-modules.inc.c"
 
 static XtensaConfig $NAME __attribute__((unused)) = {
     .name = "$NAME",
     .gdb_regmap = {
         .reg = {
-#include "core-$NAME/gdb-config.c"
+#include "core-$NAME/gdb-config.inc.c"
         }
     },
     .isa_internal = &xtensa_modules,
-- 
2.11.0
