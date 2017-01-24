Received: from eggs.gnu.org ([2001:4830:134:3::10]:42416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxem-00021K-Ja
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxei-0002co-Kc
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:44:52 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:32 +0300
Message-Id: <8c171da885807f7b534bdcde6757cd35b2969816.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 28/31] gdbstub.c: fix GDB connection segfault
 caused by empty machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ziyue Yang <yzylivezh@hotmail.com>, qemu-trivial@nongnu.org, Ziyue Yang <skiver.cloud.yzy@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>

From: Ziyue Yang <yzylivezh@hotmail.com>

This patch is to fix the segmentation fault caused by attaching
GDB to a QEMU instance initialized with "-M none" option.

The bug can be reproduced by

> ./qemu-system-x86_64 -M none -nographic -S -s

and attach a GDB to it by

> gdb -ex 'target remote :1234

The segmentation fault was originally caused by trying to read
the information about CPU when communicating with GDB. However,
it's impossible for any control flow to exist on an empty machine,
nor can CPU's be hot plugged to an empty machine later by QOM
commands. So I think simply disabling GDB connections on empty
machines makes sense.

Signed-off-by: Ziyue Yang <skiver.cloud.yzy@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 gdbstub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index de9b62b..27e0923 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "cpu.h"
 #ifdef CONFIG_USER_ONLY
@@ -1732,6 +1733,12 @@ int gdbserver_start(const char *device)
     CharDriverState *mon_chr;
     ChardevCommon common = { 0 };
 
+    if (!first_cpu) {
+        error_report("gdbstub: meaningless to attach gdb to a "
+                     "machine without any CPU.");
+        return -1;
+    }
+
     if (!device)
         return -1;
     if (strcmp(device, "none") != 0) {
-- 
2.1.4
