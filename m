Received: from eggs.gnu.org ([2001:4830:134:3::10]:37980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0VWO-0000aC-V8
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d0VWK-0008PC-2E
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:58:29 -0400
From: Max Reitz <mreitz@redhat.com>
Message-Id: <20170401155751.14322-5-mreitz@redhat.com>
In-Reply-To: <20170401155751.14322-1-mreitz@redhat.com>
References: <20170401155751.14322-1-mreitz@redhat.com>
Subject: [Qemu-devel] [RFC for-3.0 4/4] block/qcow2-rust: Register block
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Tue, 18 Apr 2017 15:58:30 -0000
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

The rust qcow2 driver is now actually MUCH BETTER than the LEGACY
CROOKED qcow2 driver, so let's not beat around the bush and just
register it as a block driver. Has always been my opinion, never said
anything different. The QEMU project will deal with the C issue in a
decisive way. Q.M.U.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/Makefile.objs |  1 +
 block/qcow2-rust.c  | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 block/qcow2-rust.c

diff --git a/block/Makefile.objs b/block/Makefile.objs
index de96f8ee80..4802946e4e 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -24,6 +24,7 @@ block-obj-y += accounting.o dirty-bitmap.o
 block-obj-y += write-threshold.o
 block-obj-y += backup.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
+block-obj-y += qcow2-rust.o
 
 block-obj-y += crypto.o
 
diff --git a/block/qcow2-rust.c b/block/qcow2-rust.c
new file mode 100644
index 0000000000..1465fa9fe1
--- /dev/null
+++ b/block/qcow2-rust.c
@@ -0,0 +1,38 @@
+/* C basis of the Rust qcow2 block driver
+ *
+ * Copyright (C) 2017 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block_int.h"
+#include "qapi/error.h"
+#include "qemu/option.h"
+
+
+/* This is just for the module loading system to detect this driver */
+static BlockDriver _ __attribute__((used)) = {
+    .format_name = "qcow2-rust",
+};
+
+
+extern void bdrv_qcow2_rust_init(void);
+
+block_init(bdrv_qcow2_rust_init);
-- 
2.12.2
