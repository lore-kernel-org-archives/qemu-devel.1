Received: from eggs.gnu.org ([209.51.188.92]:60791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hKhp0-0003AA-Ok
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 07:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hKhc1-00021B-CY
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 07:04:50 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hKhc0-0001yN-Ra
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 07:04:49 -0400
Received: by mail-pl1-x644.google.com with SMTP id y3so2873739plp.0
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 04:04:47 -0700 (PDT)
From: Boxuan Li <liboxuan@connect.hku.hk>
Date: Sun, 28 Apr 2019 19:02:58 +0800
Message-Id: <20190428110258.86681-1-liboxuan@connect.hku.hk>
Subject: [Qemu-devel] [PATCH] virtio-mmio: Always compile debug prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, eblake@redhat.com, Boxuan Li <liboxuan@connect.hku.hk>

Wrap printf calls inside debug macros (DPRINTF) in `if` statement, and
change output to stderr as well. This will ensure that printf function
will always compile and prevent bitrot of the format strings.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
 hw/virtio/virtio-mmio.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa87fe..693b3c9eb4 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -28,15 +28,14 @@
 #include "hw/virtio/virtio-bus.h"
 #include "qemu/error-report.h"
 
-/* #define DEBUG_VIRTIO_MMIO */
-
-#ifdef DEBUG_VIRTIO_MMIO
-
-#define DPRINTF(fmt, ...) \
-do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#define DEBUG_VIRTIO_MMIO 0
+
+#define DPRINTF(fmt, ...)                                            \
+    do {                                                             \
+        if (DEBUG_VIRTIO_MMIO) {                                     \
+            fprintf(stderr, "virtio_mmio: " fmt , ## __VA_ARGS__);   \
+        }                                                            \
+    } while (0)
 
 /* QOM macros */
 /* virtio-mmio-bus */
-- 
2.13.2
