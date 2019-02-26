Received: from eggs.gnu.org ([209.51.188.92]:46029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyiUh-00022u-D5
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:34:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyiUf-000655-Bv
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:34:22 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 26 Feb 2019 20:34:00 +0100
Message-Id: <20190226193408.23862-4-armbru@redhat.com>
In-Reply-To: <20190226193408.23862-1-armbru@redhat.com>
References: <20190226193408.23862-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/11] pflash_cfi01: Log use of flawed
 "write to buffer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org

Our implementation of "write to buffer" (command 0xE8) is flawed.
LOG_UNIMP its use, and add some FIXME comments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/block/pflash_cfi01.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index e6d933a06d..d381f14e3c 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -502,6 +502,10 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             break;
         case 0xe8: /* Write to buffer */
             DPRINTF("%s: Write to buffer\n", __func__);
+            /* FIXME should save @offset, @width for case 1+ */
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: Write to buffer emulation is flawed\n",
+                          __func__);
             pfl->status |= 0x80; /* Ready! */
             break;
         case 0xf0: /* Probe for AMD flash */
@@ -545,6 +549,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
             /* Mask writeblock size based on device width, or bank width if
              * device width not specified.
              */
+            /* FIXME check @offset, @width */
             if (pfl->device_width) {
                 value = extract32(value, 0, pfl->device_width * 8);
             } else {
@@ -582,7 +587,13 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
     case 2:
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
+            /* FIXME check @offset, @width */
             if (!pfl->ro) {
+                /*
+                 * FIXME writing straight to memory is *wrong*.  We
+                 * should write to a buffer, and flush it to memory
+                 * only on confirm command (see below).
+                 */
                 pflash_data_write(pfl, offset, value, width, be);
             } else {
                 pfl->status |= 0x10; /* Programming error */
@@ -598,6 +609,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
                 pfl->wcycle++;
                 if (!pfl->ro) {
                     /* Flush the entire write buffer onto backing storage.  */
+                    /* FIXME premature! */
                     pflash_update(pfl, offset & mask, pfl->writeblock_size);
                 } else {
                     pfl->status |= 0x10; /* Programming error */
@@ -614,6 +626,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
             if (cmd == 0xd0) {
+                /* FIXME this is where we should write out the buffer */
                 pfl->wcycle = 0;
                 pfl->status |= 0x80;
             } else {
-- 
2.17.2
