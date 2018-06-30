Received: from eggs.gnu.org ([2001:4830:134:3::10]:38138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96R-0004Wz-DM
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ96Q-0002o0-AU
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:23 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ96Q-0002l6-3u
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:22 -0400
Received: by mail-wr0-x233.google.com with SMTP id a12-v6so10656795wro.1
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:30 +0200
Message-Id: <20180630061040.6018-38-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 37/47] hw/sd: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180625124238.25339-37-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/sd/sd.c    | 4 ++--
 hw/sd/sdhci.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9a16b76..d4356e9 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -31,6 +31,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/qdev.h"
 #include "hw/hw.h"
 #include "hw/registerfields.h"
@@ -38,7 +39,6 @@
 #include "hw/sd/sd.h"
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
-#include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
@@ -403,7 +403,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
             ((HWBLOCK_SHIFT << 6) & 0xc0);
         sd->csd[14] = 0x00;	/* File format group */
     } else {			/* SDHC */
-        size /= 512 * 1024;
+        size /= 512 * KiB;
         size -= 1;
         sd->csd[0] = 0x40;
         sd->csd[1] = 0x0e;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index a11e802..643b39d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
@@ -32,7 +33,6 @@
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
 #include "qemu/log.h"
-#include "qemu/cutils.h"
 #include "trace.h"
 
 #define TYPE_SDHCI_BUS "sdhci-bus"
@@ -742,7 +742,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         if ((dscr->attr & SDHC_ADMA_ATTR_ACT_MASK) == SDHC_ADMA_ATTR_SET_LEN) {
             dscr->length = (uint16_t)extract32(adma1, 12, 16);
         } else {
-            dscr->length = 4096;
+            dscr->length = 4 * KiB;
         }
         break;
     case SDHC_CTRL_ADMA2_64:
@@ -790,7 +790,7 @@ static void sdhci_do_adma(SDHCIState *s)
             return;
         }
 
-        length = dscr.length ? dscr.length : 65536;
+        length = dscr.length ? dscr.length : 64 * KiB;
 
         switch (dscr.attr & SDHC_ADMA_ATTR_ACT_MASK) {
         case SDHC_ADMA_ATTR_ACT_TRAN:  /* data transfer */
-- 
1.8.3.1
