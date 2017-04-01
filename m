Received: from eggs.gnu.org ([2001:4830:134:3::10]:53830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJSM-0003Kl-5k
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJSJ-0002Nb-1o
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:52:42 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJSI-0002NM-QN
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:52:38 -0400
Received: by mail-oi0-x241.google.com with SMTP id d2so5864131oig.2
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:52:38 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:52:37 +0300
Message-ID: <CA+KKJYCUmxtb7o7Fg-DLFaEqhjZk5MhfBjSMt6L146PYmnGWxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 17/43] net: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, huth@tuxfamily.org, peter.maydell@linaro.org

>From d01cd76d0b20ee8fa67c07da64b0e2301e510247 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:30:42 +0300
Subject: [PATCH 17/43] net: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/net/dp8393x.c        | 15 ++++++++++-----
 hw/net/lan9118.c        | 20 ++++++++++++++------
 hw/net/mcf_fec.c        | 18 +++++++++++-------
 hw/net/stellaris_enet.c | 28 ++++++++++++++++++----------
 4 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index efa33ad..1236990 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -25,13 +25,13 @@
 #include "qemu/timer.h"
 #include <zlib.h>

-//#define DEBUG_SONIC
+#ifndef DEBUG_SONIC
+#define DEBUG_SONIC  0
+#endif

 #define SONIC_PROM_SIZE 0x1000

 #ifdef DEBUG_SONIC
-#define DPRINTF(fmt, ...) \
-do { printf("sonic: " fmt , ##  __VA_ARGS__); } while (0)
 static const char* reg_names[] = {
     "CR", "DCR", "RCR", "TCR", "IMR", "ISR", "UTDA", "CTDA",
     "TPS", "TFC", "TSA0", "TSA1", "TFS", "URDA", "CRDA", "CRBA0",
@@ -41,10 +41,15 @@ static const char* reg_names[] = {
     "SR", "WT0", "WT1", "RSC", "CRCT", "FAET", "MPT", "MDT",
     "0x30", "0x31", "0x32", "0x33", "0x34", "0x35", "0x36", "0x37",
     "0x38", "0x39", "0x3a", "0x3b", "0x3c", "0x3d", "0x3e", "DCR2" };
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
 #endif

+#define DPRINTF(fmt, ...)                                   \
+    do {                                                    \
+        if (DEBUG_SONIC) {                                  \
+            fprintf(stderr, "sonic: " fmt, ## __VA_ARGS__); \
+        }                                                   \
+    } while (0)
+
 #define SONIC_ERROR(fmt, ...) \
 do { printf("sonic ERROR: %s: " fmt, __func__ , ## __VA_ARGS__); } while
(0)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 3db8937..427160a 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -22,17 +22,25 @@

 //#define DEBUG_LAN9118

+#ifndef DEBUG_LAN9118
+#define DEBUG_LAN9118 0
+#endif
+
 #ifdef DEBUG_LAN9118
-#define DPRINTF(fmt, ...) \
-do { printf("lan9118: " fmt , ## __VA_ARGS__); } while (0)
 #define BADF(fmt, ...) \
 do { hw_error("lan9118: error: " fmt , ## __VA_ARGS__);} while (0)
 #else
-#define DPRINTF(fmt, ...) do {} while(0)
 #define BADF(fmt, ...) \
 do { fprintf(stderr, "lan9118: error: " fmt , ## __VA_ARGS__);} while (0)
 #endif

+#define DPRINTF(fmt, ...)                                     \
+    do {                                                      \
+        if (DEBUG_LAN9118) {                                  \
+            fprintf(stderr, "lan9118: " fmt, ## __VA_ARGS__); \
+        }                                                     \
+    } while (0)
+
 #define CSR_ID_REV      0x50
 #define CSR_IRQ_CFG     0x54
 #define CSR_INT_STS     0x58
@@ -1033,7 +1041,7 @@ static void lan9118_writel(void *opaque, hwaddr
offset,
         s->int_sts |= val & SW_INT;
         break;
     case CSR_FIFO_INT:
-        DPRINTF("FIFO INT levels %08x\n", val);
+        DPRINTF("FIFO INT levels %08x\n", (int)val);
         s->fifo_int = val;
         break;
     case CSR_RX_CFG:
@@ -1114,9 +1122,9 @@ static void lan9118_writel(void *opaque, hwaddr
offset,
         if (val & 0x80000000) {
             if (val & 0x40000000) {
                 s->mac_data = do_mac_read(s, val & 0xf);
-                DPRINTF("MAC read %d = 0x%08x\n", val & 0xf, s->mac_data);
+                DPRINTF("MAC read %lx = 0x%08x\n", val & 0xf, s->mac_data);
             } else {
-                DPRINTF("MAC write %d = 0x%08x\n", val & 0xf, s->mac_data);
+                DPRINTF("MAC write %lx = 0x%08x\n", val & 0xf,
s->mac_data);
                 do_mac_write(s, val & 0xf, s->mac_data);
             }
         }
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index bfa6b4b..b1430ee 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -18,12 +18,16 @@

 //#define DEBUG_FEC 1

-#ifdef DEBUG_FEC
-#define DPRINTF(fmt, ...) \
-do { printf("mcf_fec: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
+#ifndef DEBUG_FEC
+#define DEBUG_FEC 0
+#endif
+
+#define DPRINTF(fmt, ...)                                     \
+    do {                                                      \
+        if (DEBUG_FEC) {                                      \
+            fprintf(stderr, "mcf_fec: " fmt, ## __VA_ARGS__); \
+        }                                                     \
+    } while (0)

 #define FEC_MAX_DESC 1024
 #define FEC_MAX_FRAME_SIZE 2032
@@ -557,7 +561,7 @@ static ssize_t mcf_fec_receive(NetClientState *nc,
const uint8_t *buf, size_t si
     unsigned int buf_len;
     size_t retsize;

-    DPRINTF("do_rx len %d\n", size);
+    DPRINTF("do_rx len %lx\n", size);
     if (!s->rx_enabled) {
         return -1;
     }
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 04bd10a..e6f5e28 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -13,16 +13,24 @@

 //#define DEBUG_STELLARIS_ENET 1

-#ifdef DEBUG_STELLARIS_ENET
-#define DPRINTF(fmt, ...) \
-do { printf("stellaris_enet: " fmt , ## __VA_ARGS__); } while (0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "stellaris_enet: error: " fmt , ## __VA_ARGS__);
exit(1);} while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#define BADF(fmt, ...) \
-do { fprintf(stderr, "stellaris_enet: error: " fmt , ## __VA_ARGS__);}
while (0)
-#endif
+#ifndef DEBUG_STELLARIS_ENET
+#define DEBUG_STELLARIS_ENET 0
+#endif
+
+#define DPRINTF(fmt, ...)                                            \
+    do {                                                             \
+        if (DEBUG_STELLARIS_ENET) {                                  \
+            fprintf(stderr, "stellaris_enet: " fmt, ## __VA_ARGS__); \
+        }                                                            \
+    } while (0)
+
+#define BADF(fmt, ...)                                                   \
+    do {                                                                 \
+        fprintf(stderr, "stellaris_enet: error: " fmt , ## __VA_ARGS__); \
+        if (DEBUG_STELLARIS_ENET) {                                      \
+            exit(1);                                                     \
+        }                                                                \
+    } while (0)

 #define SE_INT_RX       0x01
 #define SE_INT_TXER     0x02
-- 
2.8.0.rc3
