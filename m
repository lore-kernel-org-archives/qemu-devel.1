Received: from eggs.gnu.org ([2001:4830:134:3::10]:42452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL8bC-0001CM-4J
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gL8b8-0002yM-Pr
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:29 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gL8b6-0002pn-VD
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 10:21:25 -0500
Received: by mail-wm1-x343.google.com with SMTP id s10-v6so2363853wmc.5
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 07:21:24 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  9 Nov 2018 15:21:17 +0000
Message-Id: <20181109152119.9242-6-alex.bennee@linaro.org>
In-Reply-To: <20181109152119.9242-1-alex.bennee@linaro.org>
References: <20181109152119.9242-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 5/7] tests/guest-debug: don't use symbol
 resolution for PC checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

It turns out symbol resolution isn't enough as modern kernels are
often padded with check code at the start of functions. GDB seems to
put the breakpoint at the first non-check instruction which causes
comparisons with the symbol resolution to fail.

For normal breakpoints we can detect the hit just by checking
hit_count instead. For hardware breakpoints we fish the breakpoint
address out of what gdb.execute() reported it was set at.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/test-gdbstub.py | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tests/guest-debug/test-gdbstub.py b/tests/guest-debug/test-gdbstub.py
index c7e3986a24..3de174b74b 100644
--- a/tests/guest-debug/test-gdbstub.py
+++ b/tests/guest-debug/test-gdbstub.py
@@ -6,9 +6,10 @@ from __future__ import print_function
 # gdb ${KERNEL}.vmlinux -x ${QEMU_SRC}/tests/guest-debug/test-gdbstub.py
 
 import gdb
+import re
 
 failcount = 0
-
+addr_match = re.compile("(0x[0-9a-f]{4,16})")
 
 def report(cond, msg):
     "Report success/fail of test"
@@ -37,26 +38,30 @@ def check_break(sym_name):
     gdb.execute("c")
 
     # hopefully we came back
-    end_pc = gdb.parse_and_eval('$pc')
-    print ("%s == %s %d" % (end_pc, sym.value(), bp.hit_count))
+    hit = bp.hit_count
     bp.delete()
 
-    # can we test we hit bp?
-    return end_pc == sym.value()
+    # did we hit bp?
+    return hit > 0
 
 
 # We need to do hbreak manually as the python interface doesn't export it
+# As the resolution of sym_name might not exactly match where the
+# breakpoint actually ends up we need to fish it out from result of
+# gdb.execute.
 def check_hbreak(sym_name):
     "Setup hardware breakpoint, continue and check we stopped."
-    sym, ok = gdb.lookup_symbol(sym_name)
-    gdb.execute("hbreak %s" % (sym_name))
+    result = gdb.execute("hbreak %s" % (sym_name), to_string=True)
+    addr_txt = addr_match.search(result).group()
+    addr = int(addr_txt, 16)
+
     gdb.execute("c")
 
     # hopefully we came back
     end_pc = gdb.parse_and_eval('$pc')
-    print ("%s == %s" % (end_pc, sym.value()))
+    print ("%s == %s" % (end_pc, addr))
 
-    if end_pc == sym.value():
+    if end_pc == addr:
         gdb.execute("d 1")
         return True
     else:
-- 
2.17.1
