Received: from eggs.gnu.org ([209.51.188.92]:36720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC3-0001Jn-Kc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1yC2-0002T4-K7
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:35 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1yC2-0002Rl-D0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:56:34 -0500
Received: by mail-pf1-x444.google.com with SMTP id n74so12130371pfi.9
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:56:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 10:56:17 -0800
Message-Id: <20190307185622.29026-8-richard.henderson@linaro.org>
In-Reply-To: <20190307185622.29026-1-richard.henderson@linaro.org>
References: <20190307185622.29026-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 07/12] test/decode: Add tests for
 PatternGroups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

This adds one test that supposed to succeed to test deep nesting
of pattern groups which is rarely exercised by targets using decode
tree. The remaining tests exercise various fail conditions.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-Id: <20190227120217.20794-1-kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
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
2.17.2
