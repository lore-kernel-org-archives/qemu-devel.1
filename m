Received: from eggs.gnu.org ([2001:4830:134:3::10]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAcv-0000ic-1j
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAcu-0001n2-33
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:41 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eRAct-0001ma-Tk
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:40 -0500
Received: by mail-wr0-x244.google.com with SMTP id s66so16983014wrc.9
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 21:39:39 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Dec 2017 21:38:41 -0800
Message-Id: <1513661932-6849-6-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
References: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 05/16] target/xtensa: update import_core.sh
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
Changes v1->v2:
- add sed transformation to target/xtensa/import-core.sh that drops
  #include "ansidecl.h" from imported xtensa-modules.c;

 target/xtensa/import_core.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
index cebb6e9c4c61..32255eea9b1b 100755
--- a/target/xtensa/import_core.sh
+++ b/target/xtensa/import_core.sh
@@ -23,6 +23,17 @@ tar -xf "$OVERLAY" -C "$TARGET" --strip-components=1 \
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
+        -e '/^#include "ansidecl.h"/d' \
+        -e '/^Slot_[a-zA-Z0-9_]\+_decode (const xtensa_insnbuf insn)/,/^}/s/^  return 0;$/  return XTENSA_UNDEFINED;/' \
+    > "$TARGET"/xtensa-modules.c
 
 cat <<EOF > "${TARGET}.c"
 #include "qemu/osdep.h"
@@ -35,6 +46,9 @@ cat <<EOF > "${TARGET}.c"
 #include "core-$NAME/core-isa.h"
 #include "overlay_tool.h"
 
+#define xtensa_modules xtensa_modules_$NAME
+#include "core-$NAME/xtensa-modules.c"
+
 static XtensaConfig $NAME __attribute__((unused)) = {
     .name = "$NAME",
     .gdb_regmap = {
@@ -42,6 +56,7 @@ static XtensaConfig $NAME __attribute__((unused)) = {
 #include "core-$NAME/gdb-config.c"
         }
     },
+    .isa_internal = &xtensa_modules,
     .clock_freq_khz = $FREQ,
     DEFAULT_SECTIONS
 };
-- 
2.1.4
