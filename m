Received: from eggs.gnu.org ([2001:4830:134:3::10]:37965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fqInj-0006AQ-QH
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fqIng-0000E0-5q
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:58:58 -0400
From: Julio Faracco <jcfaracco@gmail.com>
Date: Thu, 16 Aug 2018 10:58:34 -0300
Message-Id: <20180816135837.13149-2-jcfaracco@gmail.com>
In-Reply-To: <20180816135837.13149-1-jcfaracco@gmail.com>
References: <20180816135837.13149-1-jcfaracco@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/4] block: adding lzfse decompressing
 support as a module.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

QEMU dmg support includes zlib and bzip2, but it does not contains lzfse
support. This commit adds the source file to extend compression support
for new DMGs.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 block/dmg-lzfse.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 block/dmg-lzfse.c

diff --git a/block/dmg-lzfse.c b/block/dmg-lzfse.c
new file mode 100644
index 0000000000..19d25bc646
--- /dev/null
+++ b/block/dmg-lzfse.c
@@ -0,0 +1,49 @@
+/*
+ * DMG lzfse uncompression
+ *
+ * Copyright (c) 2018 Julio Cesar Faracco
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "dmg.h"
+#include <lzfse.h>
+
+static int dmg_uncompress_lzfse_do(char *next_in, unsigned int avail_in,
+                                   char *next_out, unsigned int avail_out)
+{
+    size_t out_size = lzfse_decode_buffer((uint8_t *) next_out, avail_out,
+                                          (uint8_t *) next_in, avail_in,
+                                          NULL);
+
+    /* We need to decode the single chunk only. */
+    /* So, out_size == avail_out is not an error here. */
+    if (out_size > 0) {
+        return out_size;
+    }
+    return -1;
+}
+
+__attribute__((constructor))
+static void dmg_lzfse_init(void)
+{
+    assert(!dmg_uncompress_lzfse);
+    dmg_uncompress_lzfse = dmg_uncompress_lzfse_do;
+}
-- 
2.17.1
