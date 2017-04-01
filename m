Received: from eggs.gnu.org ([2001:4830:134:3::10]:51644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJOn-0001YQ-TV
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJOl-00019k-Ny
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:49:01 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJOl-000198-HF
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:48:59 -0400
Received: by mail-oi0-x244.google.com with SMTP id b187so13196384oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:48:59 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:48:58 +0300
Message-ID: <CA+KKJYArwiqdP4=nVvbz5z6dGtgDzKgzZ9_hRJbjV-cHz9vOhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 14/43] usb: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com, samuel.thibault@ens-lyon.org

>From 02b1e378eea154c0169a3d16b64ae27c64919c2c Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:28:51 +0300
Subject: [PATCH 14/43] usb: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/usb/dev-serial.c  | 17 +++++++++--------
 hw/usb/dev-storage.c | 17 +++++++++--------
 hw/usb/hcd-ehci.h    | 10 +++++-----
 hw/usb/hcd-xhci.c    | 19 ++++++++++++-------
 4 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 6d51373..739e79b 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -17,14 +17,15 @@
 #include "hw/usb/desc.h"
 #include "sysemu/char.h"

-//#define DEBUG_Serial
-
-#ifdef DEBUG_Serial
-#define DPRINTF(fmt, ...) \
-do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_Serial
+#define DEBUG_Serial 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                              \
+    if (DEBUG_Serial) {                                     \
+        fprintf(stderr, "usb-serial: " fmt,## __VA_ARGS__); \
+    }                                                       \
+} while (0);

 #define RECV_BUF 384

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 8a61ec9..b85c006 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -24,14 +24,15 @@
 #include "qapi/visitor.h"
 #include "qemu/cutils.h"

-//#define DEBUG_MSD
-
-#ifdef DEBUG_MSD
-#define DPRINTF(fmt, ...) \
-do { printf("usb-msd: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_MSD
+#define DEBUG_MSD 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                             \
+    if (DEBUG_MSD) {                                       \
+        fprintf(stderr, "usb-msd: " fmt , ## __VA_ARGS__); \
+    }                                                      \
+} while (0);

 /* USB requests.  */
 #define MassStorageReset  0xff
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
index 938d8aa..ca6094e 100644
--- a/hw/usb/hcd-ehci.h
+++ b/hw/usb/hcd-ehci.h
@@ -30,11 +30,11 @@
 #define EHCI_DEBUG   0
 #endif

-#if EHCI_DEBUG
-#define DPRINTF printf
-#else
-#define DPRINTF(...)
-#endif
+#define DPRINTF(fmt, ...) do {                \
+    if (EHCI_DEBUG) {                         \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define MMIO_SIZE        0x1000
 #define CAPA_SIZE        0x10
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index f0af852..9f5e5b2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -32,11 +32,16 @@
 //#define DEBUG_XHCI
 //#define DEBUG_DATA

-#ifdef DEBUG_XHCI
-#define DPRINTF(...) fprintf(stderr, __VA_ARGS__)
-#else
-#define DPRINTF(...) do {} while (0)
-#endif
+#ifndef DEBUG_XHCI
+#define DEBUG_XHCI 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                 \
+    if (DEBUG_XHCI) {                          \
+        fprintf(stderr, fmt , ## __VA_ARGS__); \
+    }                                          \
+} while (0);
+
 #define FIXME(_msg) do { fprintf(stderr, "FIXME %s:%d %s\n", \
                                  __func__, __LINE__, _msg); abort(); }
while (0)

@@ -1806,7 +1811,7 @@ static int xhci_setup_packet(XHCITransfer *xfer)
         ep = xhci_epid_to_usbep(xfer->epctx);
         if (!ep) {
             DPRINTF("xhci: slot %d has no device\n",
-                    xfer->slotid);
+                    xfer->epctx->slotid);
             return -1;
         }
     }
@@ -1980,7 +1985,7 @@ static int xhci_submit(XHCIState *xhci, XHCITransfer
*xfer, XHCIEPContext *epctx
 {
     uint64_t mfindex;

-    DPRINTF("xhci_submit(slotid=%d,epid=%d)\n", xfer->slotid, xfer->epid);
+    DPRINTF("xhci_submit(slotid=%d,epid=%d)\n", xfer->epctx->slotid,
xfer->epctx->epid);

     xfer->in_xfer = epctx->type>>2;

-- 
2.8.0.rc3
