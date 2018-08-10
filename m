Received: from eggs.gnu.org ([2001:4830:134:3::10]:55718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fnyij-0000nZ-Rm
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 00:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcfaracco@gmail.com>) id 1fnyii-0002bA-Sy
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 00:08:13 -0400
From: Julio Faracco <jcfaracco@gmail.com>
Date: Fri, 10 Aug 2018 01:07:40 -0300
Message-Id: <20180810040743.25424-2-jcfaracco@gmail.com>
In-Reply-To: <20180810040743.25424-1-jcfaracco@gmail.com>
References: <20180810040743.25424-1-jcfaracco@gmail.com>
Subject: [Qemu-devel] [PATCH 1/4] block: adding lzfse decompressing support
 as a module.
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
 block/dmg-lzfse.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 block/dmg-lzfse.c

diff --git a/block/dmg-lzfse.c b/block/dmg-lzfse.c
new file mode 100644
index 0000000000..d09b544a0a
--- /dev/null
+++ b/block/dmg-lzfse.c
@@ -0,0 +1,54 @@
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
+    void *aux;
+    size_t aux_allocated;
+    size_t out_size;
+
+    aux_allocated = lzfse_decode_scratch_size();
+    aux = g_malloc(aux_allocated);
+
+    if (aux_allocated != 0 && aux == 0) {
+        return -1;
+    }
+
+    out_size = lzfse_decode_buffer((uint8_t *) next_out, avail_out,
+                                   (uint8_t *) next_in, avail_in, aux);
+
+    return out_size;
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
