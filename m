Received: from eggs.gnu.org ([2001:4830:134:3::10]:57678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJdm-0003G5-6k
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJdk-0008Dh-TU
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:04:30 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJdk-0008DL-NE
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 10:04:28 -0400
Received: by mail-oi0-x244.google.com with SMTP id b187so13234552oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 07:04:28 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 17:04:27 +0300
Message-ID: <CA+KKJYDZoSYa+AgvrzrQg_-46VW=6taBJ=oC4COvv05=5=Fnfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 34/43] isa: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From 2b9e98a4f5a7235bfef9dac5d0c94e5ecaeb1981 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:40:57 +0300
Subject: [PATCH 34/43] isa: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 hw/isa/apm.c      | 14 ++++++++------
 hw/isa/vt82c686.c | 18 ++++++++++--------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/hw/isa/apm.c b/hw/isa/apm.c
index e232b0d..c481e22 100644
--- a/hw/isa/apm.c
+++ b/hw/isa/apm.c
@@ -25,13 +25,15 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"

-//#define DEBUG
+#ifndef DEBUG
+#define DEBUG 0
+#endif

-#ifdef DEBUG
-# define APM_DPRINTF(format, ...)       printf(format, ## __VA_ARGS__)
-#else
-# define APM_DPRINTF(format, ...)       do { } while (0)
-#endif
+#define APM_DPRINTF(fmt, ...) do {             \
+    if (DEBUG) {                               \
+        fprintf(stderr, fmt , ## __VA_ARGS__); \
+    }                                          \
+} while (0);

 /* fixed I/O location */
 #define APM_CNT_IOPORT  0xb2
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 41d5254..f427e5a 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -27,13 +27,15 @@
 #include "qemu/timer.h"
 #include "exec/address-spaces.h"

-//#define DEBUG_VT82C686B
+#ifndef DEBUG_VT82C686B
+#define DEBUG_VT82C686B 0
+#endif

-#ifdef DEBUG_VT82C686B
-#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __FUNCTION__,
##__VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#define DPRINTF(fmt, ...) do {                                    \
+    if (DEBUG_VT82C686B) {                                        \
+        fprintf(stderr, "%s: " fmt, __FUNCTION__, ##__VA_ARGS__); \
+    }                                                             \
+} while (0);

 typedef struct SuperIOConfig
 {
@@ -57,7 +59,7 @@ static void superio_ioport_writeb(void *opaque, hwaddr
addr, uint64_t data,
 {
     SuperIOConfig *superio_conf = opaque;

-    DPRINTF("superio_ioport_writeb  address 0x%x  val 0x%x\n", addr, data);
+    DPRINTF("superio_ioport_writeb  address 0x%lx  val 0x%lx\n", addr,
data);
     if (addr == 0x3f0) {
         superio_conf->index = data & 0xff;
     } else {
@@ -101,7 +103,7 @@ static uint64_t superio_ioport_readb(void *opaque,
hwaddr addr, unsigned size)
 {
     SuperIOConfig *superio_conf = opaque;

-    DPRINTF("superio_ioport_readb  address 0x%x\n", addr);
+    DPRINTF("superio_ioport_readb  address 0x%lx\n", addr);
     return (superio_conf->config[superio_conf->index]);
 }

-- 
2.8.0.rc3
