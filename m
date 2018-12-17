Received: from eggs.gnu.org ([2001:4830:134:3::10]:43679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29T-0001K4-Fw
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ29S-00056H-M9
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ29S-00055j-GL
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:18:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F7FE5D608
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:18:17 +0000 (UTC)
Received: from donizetti.redhat.com (unknown [10.36.112.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EDD985D9C5
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:18:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:58 +0100
Message-Id: <20181217231700.24482-34-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 33/35] scripts: add script to convert multiline
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

Since we're adding checkpatch rules to enforce 4-line multiline comment
format, i.e. with lone /* and */, this script can be run on existing
code so that the comment style does not become inconsistent within a
file.

The alternative to awk-in-a-shell-script could be Perl, which also
supports -i directly, but a2p seems to have bitrotten and I didn't quite
feel like writing this twice...

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/fix-multiline-comments.sh | 62 +++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100755 scripts/fix-multiline-comments.sh

diff --git a/scripts/fix-multiline-comments.sh b/scripts/fix-multiline-co=
mments.sh
new file mode 100755
index 0000000000..93f9b10669
--- /dev/null
+++ b/scripts/fix-multiline-comments.sh
@@ -0,0 +1,62 @@
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
+if test "$1" =3D -i; then
+  # gawk extension
+  inplace=3D"-i inplace"
+  shift
+fi
+${AWK-awk} $inplace 'BEGIN { indent =3D -1 }
+{
+    line =3D $0
+    # apply a star to the indent on lines after the first
+    if (indent !=3D -1) {
+        if (line =3D=3D "") {
+            line =3D sp " *"
+        } else if (substr(line, 1, indent + 2) =3D=3D sp "  ") {
+            line =3D sp " *" substr(line, indent + 3)
+        }
+    }
+
+    is_lead =3D (line ~ /^[ \t]*\/\*/)
+    is_trail =3D (line ~ /\*\//)
+    if (is_lead && !is_trail) {
+        # grab the indent at the start of a comment, but not for
+        # single-line comments
+        match(line, /^[ \t]*\/\*/)
+        indent =3D RLENGTH - 2
+        sp =3D substr(line, 1, indent)
+    }
+
+    # the regular expression filters out lone /*, /**, or */
+    if (indent !=3D -1 && !(line ~ /^[ \t]*(\/\*+|\*\/)[ \t]*$/)) {
+        if (is_lead) {
+            # split the leading /* or /** on a separate line
+            match(line, /^[ \t]*\/\*+/)
+            lead =3D substr(line, 1, RLENGTH)
+            match(line, /^[ \t]*\/\*+[ \t]*/)
+            line =3D lead "\n" sp " *" substr(line, RLENGTH)
+        }
+        if (is_trail) {
+            # split the trailing */ on a separate line
+            match(line, /[ \t]*\*\//)
+            line =3D substr(line, 1, RSTART - 1) "\n" sp " */"
+        }
+    }
+    if (is_trail) {
+        indent =3D -1
+    }
+    print line
+}' "$@"
--=20
2.20.1
