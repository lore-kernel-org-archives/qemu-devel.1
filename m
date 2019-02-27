Received: from eggs.gnu.org ([209.51.188.92]:44491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gyz9Y-00075f-FS
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1gyz9X-00084v-Ap
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:21:40 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:48350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1gyz9W-000836-Ep
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:21:39 -0500
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Date: Wed, 27 Feb 2019 13:02:17 +0100
Message-Id: <20190227120217.20794-1-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20190223232954.7185-6-richard.henderson@linaro.org>
References: <20190223232954.7185-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] test/decode: Add tests for PatternGroups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: f4bug@amsat.org, qemu-devel@nongnu.org

this adds one test that supposed to succeed to test deep nesting
of pattern groups which is rarely exercised by targets using decode
tree. The remaining tests exercise various fail conditions.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
These are the tests that came to my mind. It's not complete,but a
start.

 tests/decode/check.sh                        |  6 ++++++
 tests/decode/err_pattern_group_empty.decode  |  6 ++++++
 tests/decode/err_pattern_group_ident1.decode | 10 +++++++++
 tests/decode/err_pattern_group_ident2.decode | 11 ++++++++++
 tests/decode/err_pattern_group_nest1.decode  | 13 ++++++++++++
 tests/decode/succ_pattern_group_nest1.decode | 22 ++++++++++++++++++++
 6 files changed, 68 insertions(+)
 create mode 100644 tests/decode/err_pattern_group_empty.decode
 create mode 100644 tests/decode/err_pattern_group_ident1.decode
 create mode 100644 tests/decode/err_pattern_group_ident2.decode
 create mode 100644 tests/decode/err_pattern_group_nest1.decode
 create mode 100644 tests/decode/succ_pattern_group_nest1.decode

diff --git a/tests/decode/check.sh b/tests/decode/check.sh
index 79a06c37cd..95445a0115 100755
--- a/tests/decode/check.sh
+++ b/tests/decode/check.sh
@@ -15,4 +15,10 @@ for i in err_*.decode; do
     fi
 done
 
+for i in succ_*.decode; do
+    if ! $PYTHON $DECODETREE $i > /dev/null 2> /dev/null; then
+        echo FAIL:$i 1>&2
+    fi
+done
+
 exit $E
diff --git a/tests/decode/err_pattern_group_empty.decode b/tests/decode/err_pattern_group_empty.decode
new file mode 100644
index 0000000000..abbff6b528
--- /dev/null
+++ b/tests/decode/err_pattern_group_empty.decode
@@ -0,0 +1,6 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+# empty groups are not allowed
+{
+}
diff --git a/tests/decode/err_pattern_group_ident1.decode b/tests/decode/err_pattern_group_ident1.decode
new file mode 100644
index 0000000000..3e65fab2f9
--- /dev/null
+++ b/tests/decode/err_pattern_group_ident1.decode
@@ -0,0 +1,10 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+%sub1 0:8
+
+# Make sure that indentation is enforced
+{
+    top      00000000 00000000 00000000 00000000
+    sub1     00000000 00000000 00000000 ........ %sub1
+}
diff --git a/tests/decode/err_pattern_group_ident2.decode b/tests/decode/err_pattern_group_ident2.decode
new file mode 100644
index 0000000000..bc859233b1
--- /dev/null
+++ b/tests/decode/err_pattern_group_ident2.decode
@@ -0,0 +1,11 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+%sub1 0:8
+
+# Make sure that indentation is enforced
+{
+  top      00000000 00000000 00000000 00000000
+  sub1     00000000 00000000 00000000 ........ %sub1
+# comments are suposed to be indented
+}
diff --git a/tests/decode/err_pattern_group_nest1.decode b/tests/decode/err_pattern_group_nest1.decode
new file mode 100644
index 0000000000..92e971c3c5
--- /dev/null
+++ b/tests/decode/err_pattern_group_nest1.decode
@@ -0,0 +1,13 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+%sub1 0:8
+%sub2 8:8
+%sub3 16:8
+%sub4 24:8
+
+# Groups with no overlap are supposed to fail
+{
+  top  00000000 00000000 00000000 00000000
+  sub4 ........ ........ ........ ........ %sub1 %sub2 %sub3 %sub4
+}
diff --git a/tests/decode/succ_pattern_group_nest1.decode b/tests/decode/succ_pattern_group_nest1.decode
new file mode 100644
index 0000000000..77b0f48b49
--- /dev/null
+++ b/tests/decode/succ_pattern_group_nest1.decode
@@ -0,0 +1,22 @@
+# This work is licensed under the terms of the GNU LGPL, version 2 or later.
+# See the COPYING.LIB file in the top-level directory.
+
+%sub1 0:8
+%sub2 8:8
+%sub3 16:8
+%sub4 24:7
+
+# Make sure deep netsting works, as few targets will actually exercise it
+{
+  top        00000000 00000000 00000000 00000000
+  {
+    sub1     00000000 00000000 00000000 ........ %sub1
+    {
+      sub2   00000000 00000000 ........ ........ %sub1 %sub2
+      {
+        sub3 00000000 ........ ........ ........ %sub1 %sub2 %sub3
+        sub4 0....... ........ ........ ........ %sub1 %sub2 %sub3 %sub4
+      }
+    }
+  }
+}
-- 
2.21.0
