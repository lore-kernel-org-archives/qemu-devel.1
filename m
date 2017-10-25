Received: from eggs.gnu.org ([2001:4830:134:3::10]:43775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7O62-0000Ur-46
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1e7O61-00075r-6x
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:58 -0400
Received: from chuckie.co.uk ([82.165.15.123]:58410
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1e7O61-00074n-01
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 11:59:57 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 25 Oct 2017 16:59:23 +0100
Message-Id: <1508947167-5304-10-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv4 09/13] lance: move TYPE_LANCE and
 SysBusPCNetState from lance.c to lance.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>

This enables them to be used outside of lance.c.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Jason Wang <jasowang@redhat.com>
---
 hw/net/lance.c         |   11 +----------
 include/hw/net/lance.h |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 10 deletions(-)
 create mode 100644 include/hw/net/lance.h

diff --git a/hw/net/lance.c b/hw/net/lance.c
index 92b0c68..23929fd 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -41,19 +41,10 @@
 #include "qemu/timer.h"
 #include "qemu/sockets.h"
 #include "hw/sparc/sun4m.h"
-#include "pcnet.h"
+#include "hw/net/lance.h"
 #include "trace.h"
 #include "sysemu/sysemu.h"
 
-#define TYPE_LANCE "lance"
-#define SYSBUS_PCNET(obj) \
-    OBJECT_CHECK(SysBusPCNetState, (obj), TYPE_LANCE)
-
-typedef struct {
-    SysBusDevice parent_obj;
-
-    PCNetState state;
-} SysBusPCNetState;
 
 static void parent_lance_reset(void *opaque, int irq, int level)
 {
diff --git a/include/hw/net/lance.h b/include/hw/net/lance.h
new file mode 100644
index 0000000..c112fbc
--- /dev/null
+++ b/include/hw/net/lance.h
@@ -0,0 +1,41 @@
+/*
+ * QEMU AMD PC-Net II (Am79C970A) emulation
+ *
+ * Copyright (c) 2004 Antony T Curtis
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
+
+#ifndef LANCE_H
+#define LANCE_H
+
+#include "net/net.h"
+#include "hw/net/pcnet.h"
+
+#define TYPE_LANCE "lance"
+#define SYSBUS_PCNET(obj) \
+    OBJECT_CHECK(SysBusPCNetState, (obj), TYPE_LANCE)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    PCNetState state;
+} SysBusPCNetState;
+
+#endif
-- 
1.7.10.4
