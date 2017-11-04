Received: from eggs.gnu.org ([2001:4830:134:3::10]:44867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPI-0005yl-Hh
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPH-0000Zh-Dt
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:04 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:49624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eApPH-0000Z9-63
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:03 -0400
Received: by mail-lf0-x241.google.com with SMTP id w21so5156808lfc.6
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 20:46:03 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri,  3 Nov 2017 20:45:10 -0700
Message-Id: <1509767121-26925-6-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 05/16] target/xtensa: update import_core.sh
 script for libisa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

Extract xtensa-modules.c from the overlay, fix up known issues, include
it into the core-$NAME.c.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/import_core.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
index cebb6e9c4c61..62d3243c1445 100755
--- a/target/xtensa/import_core.sh
+++ b/target/xtensa/import_core.sh
@@ -23,6 +23,16 @@ tar -xf "$OVERLAY" -C "$TARGET" --strip-components=1 \
     --xform='s/core/core-isa/' config/core.h
 tar -xf "$OVERLAY" -O gdb/xtensa-config.c | \
     sed -n '1,/*\//p;/XTREG/,/XTREG_END/p' > "$TARGET"/gdb-config.c
+#
+# Fix up known issues in the xtensa-modules.c
+#
+tar -xf "$OVERLAY" -O binutils/xtensa-modules.c | \
+    sed -e 's/\(xtensa_opcode_encode_fn.*\[\] =\)/static \1/' \
+        -e '/^int num_bypass_groups()/,/}/d' \
+        -e '/^int num_bypass_group_chunks()/,/}/d' \
+        -e '/^uint32 \*bypass_entry(int i)/,/}/d' \
+        -e '/^Slot_[a-zA-Z0-9_]\+_decode (const xtensa_insnbuf insn)/,/^}/s/^  return 0;$/  return XTENSA_UNDEFINED;/' \
+    > "$TARGET"/xtensa-modules.c
 
 cat <<EOF > "${TARGET}.c"
 #include "qemu/osdep.h"
@@ -35,6 +45,9 @@ cat <<EOF > "${TARGET}.c"
 #include "core-$NAME/core-isa.h"
 #include "overlay_tool.h"
 
+#define xtensa_modules xtensa_modules_$NAME
+#include "core-$NAME/xtensa-modules.c"
+
 static XtensaConfig $NAME __attribute__((unused)) = {
     .name = "$NAME",
     .gdb_regmap = {
@@ -42,6 +55,7 @@ static XtensaConfig $NAME __attribute__((unused)) = {
 #include "core-$NAME/gdb-config.c"
         }
     },
+    .isa_internal = &xtensa_modules,
     .clock_freq_khz = $FREQ,
     DEFAULT_SECTIONS
 };
-- 
2.1.4
