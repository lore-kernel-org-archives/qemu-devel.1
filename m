Received: from eggs.gnu.org ([2001:4830:134:3::10]:49209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxyZ-0005T1-O9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxyZ-000545-4Z
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:38:15 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:34004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daxyZ-00053U-0U
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:38:15 -0400
Received: by mail-qk0-x233.google.com with SMTP id u139so52205371qka.1
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 22:38:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 28 Jul 2017 02:36:10 -0300
Message-Id: <20170728053610.15770-48-f4bug@amsat.org>
In-Reply-To: <20170728053610.15770-1-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 47/47] script to find outdated entry in
 MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/check_maintainer.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 scripts/check_maintainer.sh

diff --git a/scripts/check_maintainer.sh b/scripts/check_maintainer.sh
new file mode 100755
index 0000000000..074a6acf69
--- /dev/null
+++ b/scripts/check_maintainer.sh
@@ -0,0 +1,21 @@
+#! /bin/bash
+#
+# This script checks MAINTAINERS consistency
+#
+# Copyright (C) 2017 Philippe Mathieu-Daudé. GPLv2+.
+#
+# Usage:
+# ./scripts/check_maintainer.sh | tee MAINTAINERS.missing
+
+echo "Incorrect MAINTAINERS paths:" 1>&2
+egrep ^F: MAINTAINERS | cut -d\  -f2 | while read p; do
+    ls -ld $p 1>/dev/null
+done
+
+echo "No maintainers found for:" 1>&2
+git ls-files|while read f; do
+    OUT=$(./scripts/get_maintainer.pl -f $f 2>&1)
+    if [[ "$OUT" == *"No maintainers found"* ]]; then
+        echo $f
+    fi
+done
-- 
2.13.3
