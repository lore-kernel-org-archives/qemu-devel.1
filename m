Received: from eggs.gnu.org ([2001:4830:134:3::10]:54602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJWf-00060S-2u
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJWd-0004Cy-VM
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:57:09 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJWd-0004Ct-P4
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:57:07 -0400
Received: by mail-oi0-x244.google.com with SMTP id b187so13214927oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:57:07 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:57:06 +0300
Message-ID: <CA+KKJYAtoZAtQ2v7mPX=S3Vkto0QoWJEZuBdc+YNeP0CSyicOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 22/43] virtio: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From 2e5d92b2d1955b3e85f1e93ad98469d00c47a658 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:33:29 +0300
Subject: [PATCH 22/43] virtio: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/virtio/virtio-bus.c  | 15 ++++++++++-----
 hw/virtio/virtio-mmio.c | 17 ++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 3042232..35cfef5 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -31,15 +31,20 @@
 #include "hw/virtio/virtio.h"
 #include "exec/address-spaces.h"

+
 /* #define DEBUG_VIRTIO_BUS */

-#ifdef DEBUG_VIRTIO_BUS
-#define DPRINTF(fmt, ...) \
-do { printf("virtio_bus: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
+#ifndef DEBUG_VIRTIO_BUS
+#define DEBUG_VIRTIO_BUS 0
 #endif

+#define DPRINTF(fmt, ...)                                        \
+    do {                                                         \
+        if (DEBUG_VIRTIO_BUS) {                                  \
+            fprintf(stderr, "virtio_bus: " fmt, ## __VA_ARGS__); \
+        }                                                        \
+    } while (0)
+
 /* A VirtIODevice is being plugged */
 void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
 {
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa8..31e3094 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -30,13 +30,16 @@

 /* #define DEBUG_VIRTIO_MMIO */

-#ifdef DEBUG_VIRTIO_MMIO
-
-#define DPRINTF(fmt, ...) \
-do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#ifndef DEBUG_VIRTIO_MMIO
+#define DEBUG_VIRTIO_MMIO  0
+#endif
+
+#define DPRINTF(fmt, ...)                                         \
+    do {                                                          \
+        if (DEBUG_VIRTIO_MMIO) {                                  \
+            fprintf(stderr, "virtio_mmio: " fmt, ## __VA_ARGS__); \
+        }                                                         \
+    } while (0)

 /* QOM macros */
 /* virtio-mmio-bus */
-- 
2.8.0.rc3
