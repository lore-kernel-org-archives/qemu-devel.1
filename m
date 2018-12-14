Received: from eggs.gnu.org ([2001:4830:134:3::10]:42363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gXjyv-0003Yr-Jb
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gXjyq-0002mn-Di
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:42:05 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gXjyq-0002js-5k
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:42:00 -0500
Received: by mail-wm1-x341.google.com with SMTP id r24so15806188wmh.0
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 01:41:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Dec 2018 10:41:51 +0100
Message-Id: <20181214094151.16996-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] scripts: add script to convert multiline
 comments into 4-line format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, armbru@redhat.com

Since we're adding checkpatch rules to enforce 4-line multiline comment
format, i.e. with lone /* and */, this script can be run on existing
code so that the comment style does not become inconsistent within a
file.

The alternative to awk-in-a-shell-script could be Perl, which also
supports -i directly, but a2p seems to have bitrotten and I didn't quite
feel like writing this twice...

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/fix-multiline-comments.sh | 60 +++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100755 scripts/fix-multiline-comments.sh

diff --git a/scripts/fix-multiline-comments.sh b/scripts/fix-multiline-comments.sh
new file mode 100755
index 0000000000..09ac6803c2
--- /dev/null
+++ b/scripts/fix-multiline-comments.sh
@@ -0,0 +1,60 @@
+#! /bin/sh
+#
+# Fix multiline comments to match CODING_STYLE
+#
+# Copyright (C) 2018 Red Hat, Inc.
+#
+# Author: Paolo Bonzini
+#
+# Usage: scripts/fix-multiline-comments.sh [-i] FILE...
+#
+# -i edits the file in place (requires gawk 4.1.0).
+#
+# Set the AWK environment variable to choose the awk interpreter to use
+# (default 'awk')
+
+if test "$1" = -i; then
+  # gawk extension
+  inplace="-i inplace"
+  shift
+fi
+${AWK-awk} $inplace 'BEGIN { indent = -1 }
+{
+    line = $0
+    # apply a star to the indent on lines after the first
+    if (indent != -1) {
+        if (line == "") {
+            line = sp " *"
+        } else if (substr(line, 1, indent + 2) == sp "  ") {
+            line = sp " *" substr(line, indent + 3)
+        }
+    }
+
+    is_lead = (line ~ /^[ \t]*\/\*/)
+    is_trail = (line ~ /\*\//)
+    if (is_lead && !is_trail) {
+        # grab the indent at the start of a comment, but not for
+        # single-line comments
+        match(line, /^[ \t]*\/\*/)
+        indent = RLENGTH - 2
+        sp = substr(line, 1, indent)
+    }
+
+    # the regular expression filters out lone /*, /**, or */
+    if (indent != -1 && !(line ~ /^[ \t]*(\/\*+|\*\/)[ \t]*$/)) {
+        if (is_lead) {
+            # split the leading /* on a separate line
+            match(line, /^[ \t]*\/\*+[ \t]*/)
+            line = sp "/*\n" sp " *" substr(line, RLENGTH)
+        }
+        if (is_trail) {
+            # split the trailing */ on a separate line
+            match(line, /[ \t]*\*\//)
+            line = substr(line, 1, RSTART - 1) "\n" sp " */"
+        }
+    }
+    if (is_trail) {
+        indent = -1
+    }
+    print line
+}' "$@"
-- 
2.19.2
