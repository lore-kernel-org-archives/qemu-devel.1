Received: from eggs.gnu.org ([2001:4830:134:3::10]:34065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLL-0007l5-HE
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLI-000360-CI
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:11 -0500
Received: from mail-sn1nam01on0052.outbound.protection.outlook.com
	([104.47.32.52]:53831
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZLI-00035a-4j
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:08 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:56:49 -0800
Message-ID: <d5b93f1f9af54490c624b9db766d0afa8540793b.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 08/45] hw/char: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines were then manually tweaked to pass checkpatch.

Some lines were manually converted to qemu_log_mask(LOG_UNIMP, and two
abort()'s were removed

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
V4:
 - Remove abort()s from guest accessible code
 - Use qemu_log_mask(LOG_UNIMP,
V2:
 - Split hw patch into individual directories

 hw/char/mcf_uart.c  |  5 +++--
 hw/char/sh_serial.c | 11 +++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 56fa402b58..1861c9733e 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -6,6 +6,7 @@
  * This code is licensed under the GPL
  */
 #include "qemu/osdep.h"
+#include "include/qemu/log.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
@@ -174,7 +175,7 @@ static void mcf_do_command(mcf_uart_state *s, uint8_t cmd)
         mcf_uart_do_tx(s);
         break;
     case 3: /* Reserved.  */
-        fprintf(stderr, "mcf_uart: Bad TX command\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "mcf_uart: Bad TX command");
         break;
     }
 
@@ -189,7 +190,7 @@ static void mcf_do_command(mcf_uart_state *s, uint8_t cmd)
         s->rx_enabled = 0;
         break;
     case 3: /* Reserved.  */
-        fprintf(stderr, "mcf_uart: Bad RX command\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "mcf_uart: Bad RX command");
         break;
     }
 }
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 835b5378a0..fae2d31b4e 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "include/qemu/log.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "chardev/char-fe.h"
@@ -190,9 +191,8 @@ static void sh_serial_write(void *opaque, hwaddr offs,
         }
     }
 
-    fprintf(stderr, "sh_serial: unsupported write to 0x%02"
-            HWADDR_PRIx "\n", offs);
-    abort();
+    qemu_log_mask(LOG_UNIMP, "sh_serial: unsupported write to 0x%02"
+                  HWADDR_PRIx "", offs);
 }
 
 static uint64_t sh_serial_read(void *opaque, hwaddr offs,
@@ -290,9 +290,8 @@ static uint64_t sh_serial_read(void *opaque, hwaddr offs,
 #endif
 
     if (ret & ~((1 << 16) - 1)) {
-        fprintf(stderr, "sh_serial: unsupported read from 0x%02"
-                HWADDR_PRIx "\n", offs);
-        abort();
+        qemu_log_mask(LOG_UNIMP, "sh_serial: unsupported read from 0x%02"
+                      HWADDR_PRIx "", offs);
     }
 
     return ret;
-- 
2.14.1
