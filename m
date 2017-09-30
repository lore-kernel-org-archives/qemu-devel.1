Received: from eggs.gnu.org ([2001:4830:134:3::10]:60008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5V5-0003nS-7h
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dy5V1-0004J4-Ss
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:19:23 -0400
Received: from mail-by2nam03on0079.outbound.protection.outlook.com
	([104.47.42.79]:31088
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dy5V1-0004IA-H0
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:19:19 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 29 Sep 2017 17:15:25 -0700
Message-ID: <f402d9e631e0f8fe04cdad03027c20cd27dc928e.1506730372.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506730372.git.alistair.francis@xilinx.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 08/47] hw/char: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

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

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
V2:
 - Split hw patch into individual directories

 hw/char/exynos4210_uart.c | 6 +++---
 hw/char/mcf_uart.c        | 5 +++--
 hw/char/sh_serial.c       | 9 +++++----
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 3957e78abf..a388f01a23 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -296,7 +296,7 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
         qemu_irq_raise(s->irq);
 
 #if DEBUG_IRQ
-        fprintf(stderr, "UART%d: IRQ has been raised: %08x\n",
+        error_report("UART%d: IRQ has been raised: %08x",
                 s->channel, s->reg[I_(UINTP)]);
 #endif
 
@@ -388,7 +388,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
              * qemu_chr_fe_write and background I/O callbacks */
             qemu_chr_fe_write_all(&s->chr, &ch, 1);
 #if DEBUG_Tx_DATA
-            fprintf(stderr, "%c", ch);
+            error_report("%c", ch);
 #endif
             s->reg[I_(UTRSTAT)] |= UTRSTAT_TRANSMITTER_EMPTY |
                     UTRSTAT_Tx_BUFFER_EMPTY;
@@ -400,7 +400,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
     case UINTP:
         s->reg[I_(UINTP)] &= ~val;
         s->reg[I_(UINTSP)] &= ~val;
-        PRINT_DEBUG("UART%d: UINTP [%04x] have been cleared: %08x\n",
+        PRINT_DEBUG("UART%d: UINTP [%04x] have been cleared: %08x",
                     s->channel, offset, s->reg[I_(UINTP)]);
         exynos4210_uart_update_irq(s);
         break;
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 56fa402b58..14cb051be9 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -6,6 +6,7 @@
  * This code is licensed under the GPL
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
@@ -174,7 +175,7 @@ static void mcf_do_command(mcf_uart_state *s, uint8_t cmd)
         mcf_uart_do_tx(s);
         break;
     case 3: /* Reserved.  */
-        fprintf(stderr, "mcf_uart: Bad TX command\n");
+        error_report("mcf_uart: Bad TX command");
         break;
     }
 
@@ -189,7 +190,7 @@ static void mcf_do_command(mcf_uart_state *s, uint8_t cmd)
         s->rx_enabled = 0;
         break;
     case 3: /* Reserved.  */
-        fprintf(stderr, "mcf_uart: Bad RX command\n");
+        error_report("mcf_uart: Bad RX command");
         break;
     }
 }
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 835b5378a0..7bb3f3c70b 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "chardev/char-fe.h"
@@ -190,8 +191,8 @@ static void sh_serial_write(void *opaque, hwaddr offs,
         }
     }
 
-    fprintf(stderr, "sh_serial: unsupported write to 0x%02"
-            HWADDR_PRIx "\n", offs);
+    error_report("sh_serial: unsupported write to 0x%02"
+                 HWADDR_PRIx "", offs);
     abort();
 }
 
@@ -290,8 +291,8 @@ static uint64_t sh_serial_read(void *opaque, hwaddr offs,
 #endif
 
     if (ret & ~((1 << 16) - 1)) {
-        fprintf(stderr, "sh_serial: unsupported read from 0x%02"
-                HWADDR_PRIx "\n", offs);
+        error_report("sh_serial: unsupported read from 0x%02"
+                     HWADDR_PRIx "", offs);
         abort();
     }
 
-- 
2.11.0
