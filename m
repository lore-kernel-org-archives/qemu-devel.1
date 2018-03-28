Received: from eggs.gnu.org ([2001:4830:134:3::10]:55771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1EwH-000050-5a
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f1EwE-0003x2-H8
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:45872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1f1EwE-0003wL-88
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:32:42 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 28 Mar 2018 20:32:37 +0300
Message-Id: <20180328173238.507470-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180328173238.507470-1-vsementsov@virtuozzo.com>
References: <20180328173238.507470-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 3/4] scripts/qemugdb: add coredump.py for
 coredump patching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

The main function is write_regs_to_coredump, which opens coredump
file, searches for 'CORE' sign. The first one should correspond
to PRSTATUS note for first thread. Patch register values in
elf_prstatus structure, going after header with 'CORE' sign.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/qemugdb/coredump.py | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 scripts/qemugdb/coredump.py

diff --git a/scripts/qemugdb/coredump.py b/scripts/qemugdb/coredump.py
new file mode 100644
index 0000000000..8915461886
--- /dev/null
+++ b/scripts/qemugdb/coredump.py
@@ -0,0 +1,51 @@
+# Coredump patching
+#
+# Copyright (c) 2018 Virtuozzo International GmbH. All rights reserved.
+#
+# Authors:
+#  Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import struct
+import shutil
+
+def write_regs_to_coredump(fname, set_regs):
+    # asm/ptrace.h
+    pt_regs = ['r15', 'r14', 'r13', 'r12', 'rbp', 'rbx', 'r11', 'r10',
+               'r9', 'r8', 'rax', 'rcx', 'rdx', 'rsi', 'rdi', 'orig_rax',
+               'rip', 'cs', 'eflags', 'rsp', 'ss']
+
+    with open(fname, 'r+b') as f:
+        print 'patching core file "%s"' % fname
+
+        while f.read(4) != 'CORE':
+            pass
+
+        print 'found "CORE" at 0x%x' % f.tell()
+        f.seek(4, 1) # go to elf_prstatus
+        f.seek(112, 1) # offsetof(struct elf_prstatus, pr_reg)
+
+        print 'assume pt_regs at 0x%x' % f.tell()
+        for reg in pt_regs:
+            if reg in set_regs:
+                print 'write %s at 0x%x' % (reg, f.tell())
+                f.write(struct.pack('q', set_regs[reg]))
+            else:
+                f.seek(8, 1)
+
+def clone_coredump(source, target, set_regs):
+    shutil.copyfile(source, target)
+    write_regs_to_coredump(target, set_regs)
-- 
2.11.1
