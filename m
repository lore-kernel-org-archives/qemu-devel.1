Received: from eggs.gnu.org ([2001:4830:134:3::10]:43530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBSc-0006A0-JO
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSBSb-0003eT-Cn
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:17:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Jun 2018 22:14:56 -0300
Message-Id: <20180611011501.10235-36-f4bug@amsat.org>
In-Reply-To: <20180611011501.10235-1-f4bug@amsat.org>
References: <20180611011501.10235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 35/40] hw/usb: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/usb/ccid-card-passthru.c   | 5 +++--
 hw/usb/combined-packet.c      | 3 ++-
 hw/usb/dev-smartcard-reader.c | 3 ++-
 hw/usb/redirect.c             | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 25fb19b0d7..e6c73116cc 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include <libcacard.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
@@ -40,7 +41,7 @@ static const uint8_t DEFAULT_ATR[] = {
  0x13, 0x08
 };
 
-#define VSCARD_IN_SIZE 65536
+#define VSCARD_IN_SIZE      (64 * KiB)
 
 /* maximum size of ATR - from 7816-3 */
 #define MAX_ATR_SIZE        40
@@ -276,7 +277,7 @@ static void ccid_card_vscard_read(void *opaque, const uint8_t *buf, int size)
 
     if (card->vscard_in_pos + size > VSCARD_IN_SIZE) {
         error_report(
-            "no room for data: pos %d +  size %d > %d. dropping connection.",
+            "no room for data: pos %d +  size %d > %llu. dropping connection.",
             card->vscard_in_pos, size, VSCARD_IN_SIZE);
         ccid_card_vscard_drop_connection(card);
         return;
diff --git a/hw/usb/combined-packet.c b/hw/usb/combined-packet.c
index 48cac87f6a..01a7ed0848 100644
--- a/hw/usb/combined-packet.c
+++ b/hw/usb/combined-packet.c
@@ -20,6 +20,7 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu-common.h"
 #include "hw/usb.h"
 #include "qemu/iov.h"
@@ -171,7 +172,7 @@ void usb_ep_combine_input_packets(USBEndpoint *ep)
         if ((p->iov.size % ep->max_packet_size) != 0 || !p->short_not_ok ||
                 next == NULL ||
                 /* Work around for Linux usbfs bulk splitting + migration */
-                (totalsize == 16348 && p->int_req)) {
+                (totalsize == (16 * KiB - 36) && p->int_req)) {
             usb_device_handle_data(ep->dev, first);
             assert(first->status == USB_RET_ASYNC);
             if (first->combined) {
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 2131e33d27..ec862c2082 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -35,6 +35,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/error-report.h"
@@ -63,7 +64,7 @@ do { \
  * or handle the migration complexity - VMState doesn't handle this case.
  * sizes are expected never to be exceeded, unless guest misbehaves.
  */
-#define BULK_OUT_DATA_SIZE 65536
+#define BULK_OUT_DATA_SIZE  (64 * KiB)
 #define PENDING_ANSWERS_NUM 128
 
 #define BULK_IN_BUF_SIZE 384
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 65a9196c1a..8580c08dbd 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
@@ -1298,7 +1299,7 @@ static int usbredir_chardev_can_read(void *opaque)
     }
 
     /* usbredir_parser_do_read will consume *all* data we give it */
-    return 1024 * 1024;
+    return 1 * MiB;
 }
 
 static void usbredir_chardev_read(void *opaque, const uint8_t *buf, int size)
-- 
2.17.1
