Received: from eggs.gnu.org ([2001:4830:134:3::10]:53883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJSx-0003hA-4q
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJSt-0002fb-MU
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:53:19 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJSt-0002fP-Eb
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:53:15 -0400
Received: by mail-oi0-x241.google.com with SMTP id b187so13206148oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:53:15 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:53:14 +0300
Message-ID: <CA+KKJYDPawGWJ8DZBZcK0pWdNLm5yoayvMggdHEncA6XT-0zFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 18/43] pci-host: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, agraf@suse.de

>From b5c0463a6d755be8bfcf4402390e877abcf606c6 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:31:07 +0300
Subject: [PATCH 18/43] pci-host: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/pci-host/apb.c      | 16 ++++++++++------
 hw/pci-host/bonito.c   | 19 ++++++++++++-------
 hw/pci-host/grackle.c  | 16 ++++++++++------
 hw/pci-host/uninorth.c | 16 ++++++++++------
 4 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 653e711..e1ef3db 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -41,12 +41,16 @@
 /* debug APB */
 //#define DEBUG_APB

-#ifdef DEBUG_APB
-#define APB_DPRINTF(fmt, ...) \
-do { printf("APB: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define APB_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_APB
+#define DEBUG_APB 0
+#endif
+
+#define APB_DPRINTF(fmt, ...)                             \
+    do {                                                  \
+        if (DEBUG_APB) {                                  \
+            fprintf(stderr, "APB: " fmt, ## __VA_ARGS__); \
+        }                                                 \
+    } while (0)

 /* debug IOMMU */
 //#define DEBUG_IOMMU
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 1999ece..49a28de 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -49,11 +49,16 @@

 //#define DEBUG_BONITO

-#ifdef DEBUG_BONITO
-#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__,
##__VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_BONITO
+#define DEBUG_BONITO 0
+#endif
+
+#define DPRINTF(fmt, ...)                                             \
+    do {                                                              \
+        if (DEBUG_BONITO) {                                           \
+            fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__); \
+        }                                                             \
+    } while (0)

 /* from linux soure code. include/asm-mips/mips-boards/bonito64.h*/
 #define BONITO_BOOT_BASE        0x1fc00000
@@ -236,7 +241,7 @@ static void bonito_writel(void *opaque, hwaddr addr,

     saddr = addr >> 2;

-    DPRINTF("bonito_writel "TARGET_FMT_plx" val %x saddr %x\n", addr, val,
saddr);
+    DPRINTF("bonito_writel "TARGET_FMT_plx" val %lx saddr %x\n", addr,
val, saddr);
     switch (saddr) {
     case BONITO_BONPONCFG:
     case BONITO_IODEVCFG:
@@ -323,7 +328,7 @@ static void bonito_pciconf_writel(void *opaque, hwaddr
addr,
     PCIBonitoState *s = opaque;
     PCIDevice *d = PCI_DEVICE(s);

-    DPRINTF("bonito_pciconf_writel "TARGET_FMT_plx" val %x\n", addr, val);
+    DPRINTF("bonito_pciconf_writel "TARGET_FMT_plx" val %lx\n", addr, val);
     d->config_write(d, addr, val, 4);
 }

diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 2c8acda..129929c 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -31,12 +31,16 @@
 /* debug Grackle */
 //#define DEBUG_GRACKLE

-#ifdef DEBUG_GRACKLE
-#define GRACKLE_DPRINTF(fmt, ...)                               \
-    do { printf("GRACKLE: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define GRACKLE_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_GRACKLE
+#define DEBUG_GRACKLE 0
+#endif
+
+#define GRACKLE_DPRINTF(fmt, ...)                             \
+    do {                                                      \
+        if (DEBUG_GRACKLE) {                                  \
+            fprintf(stderr, "GRACKLE: " fmt, ## __VA_ARGS__); \
+        }                                                     \
+    } while (0)

 #define GRACKLE_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(GrackleState, (obj), TYPE_GRACKLE_PCI_HOST_BRIDGE)
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index df342ac..408b29f 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -30,12 +30,16 @@
 /* debug UniNorth */
 //#define DEBUG_UNIN

-#ifdef DEBUG_UNIN
-#define UNIN_DPRINTF(fmt, ...)                                  \
-    do { printf("UNIN: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define UNIN_DPRINTF(fmt, ...)
-#endif
+#ifndef DEBUG_UNIN
+#define DEBUG_UNIN 0
+#endif
+
+#define UNIN_DPRINTF(fmt, ...)                             \
+    do {                                                   \
+        if (DEBUG_UNIN) {                                  \
+            fprintf(stderr, "UNIN: " fmt, ## __VA_ARGS__); \
+        }                                                  \
+    } while (0)

 static const int unin_irq_line[] = { 0x1b, 0x1c, 0x1d, 0x1e };

-- 
2.8.0.rc3
