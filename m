Received: from eggs.gnu.org ([2001:4830:134:3::10]:56079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e5Da5-0005rI-GP
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1e5Da2-000257-6u
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:22:01 -0400
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com
	([104.47.38.80]:9280
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1e5Da2-000251-0n
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:21:58 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 19 Oct 2017 09:17:56 -0700
Message-ID: <388233ed6156d0e80674d1f477772dc260776144.1508390588.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1508390588.git.alistair.francis@xilinx.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 35/46] hw/sh4: Replace fprintf(stderr,
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

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
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
V2:
 - Split hw patch into individual directories

 hw/sh4/r2d.c    |  9 ++++----
 hw/sh4/sh7750.c | 64 +++++++++++++++++++++++++++++----------------------------
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 16b9ed2db2..127b510b6d 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -319,8 +320,8 @@ static void r2d_init(MachineState *machine)
                                           SDRAM_BASE + LINUX_LOAD_OFFSET,
                                           INITRD_LOAD_OFFSET - LINUX_LOAD_OFFSET);
         if (kernel_size < 0) {
-          fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_filename);
-          exit(1);
+            error_report("could not load kernel '%s'", kernel_filename);
+            exit(1);
         }
 
         /* initialization which should be done by firmware */
@@ -339,8 +340,8 @@ static void r2d_init(MachineState *machine)
                                           SDRAM_SIZE - INITRD_LOAD_OFFSET);
 
         if (initrd_size < 0) {
-          fprintf(stderr, "qemu: could not load initrd '%s'\n", initrd_filename);
-          exit(1);
+            error_report("could not load initrd '%s'", initrd_filename);
+            exit(1);
         }
 
         /* initialization which should be done by firmware */
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 166e4bd947..64ffc4c1d2 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -23,6 +23,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/sh4/sh.h"
 #include "sysemu/sysemu.h"
@@ -147,9 +148,9 @@ static void porta_changed(SH7750State * s, uint16_t prev)
     int i, r = 0;
 
 #if 0
-    fprintf(stderr, "porta changed from 0x%04x to 0x%04x\n",
+    error_report("porta changed from 0x%04x to 0x%04x",
 	    prev, porta_lines(s));
-    fprintf(stderr, "pdtra=0x%04x, pctra=0x%08x\n", s->pdtra, s->pctra);
+    error_report("pdtra=0x%04x, pctra=0x%08x", s->pdtra, s->pctra);
 #endif
     currenta = porta_lines(s);
     if (currenta == prev)
@@ -200,13 +201,13 @@ static void portb_changed(SH7750State * s, uint16_t prev)
 
 static void error_access(const char *kind, hwaddr addr)
 {
-    fprintf(stderr, "%s to %s (0x" TARGET_FMT_plx ") not supported\n",
+    error_report("%s to %s (0x" TARGET_FMT_plx ") not supported",
 	    kind, regname(addr), addr);
 }
 
 static void ignore_access(const char *kind, hwaddr addr)
 {
-    fprintf(stderr, "%s to %s (0x" TARGET_FMT_plx ") ignored\n",
+    error_report("%s to %s (0x" TARGET_FMT_plx ") ignored",
 	    kind, regname(addr), addr);
 }
 
@@ -326,47 +327,48 @@ static void sh7750_mem_writew(void *opaque, hwaddr addr,
     uint16_t temp;
 
     switch (addr) {
-	/* SDRAM controller */
+    /* SDRAM controller */
     case SH7750_BCR2_A7:
         s->bcr2 = mem_value;
         return;
     case SH7750_BCR3_A7:
-	if(!has_bcr3_and_bcr4(s))
-	    error_access("word write", addr);
-	s->bcr3 = mem_value;
-	return;
+        if (!has_bcr3_and_bcr4(s)) {
+            error_access("word write", addr);
+        }
+        s->bcr3 = mem_value;
+        return;
     case SH7750_PCR_A7:
-	s->pcr = mem_value;
-	return;
+        s->pcr = mem_value;
+        return;
     case SH7750_RTCNT_A7:
     case SH7750_RTCOR_A7:
     case SH7750_RTCSR_A7:
-	ignore_access("word write", addr);
-	return;
-	/* IO ports */
+        ignore_access("word write", addr);
+        return;
+        /* IO ports */
     case SH7750_PDTRA_A7:
-	temp = porta_lines(s);
-	s->pdtra = mem_value;
-	porta_changed(s, temp);
-	return;
+        temp = porta_lines(s);
+        s->pdtra = mem_value;
+        porta_changed(s, temp);
+        return;
     case SH7750_PDTRB_A7:
-	temp = portb_lines(s);
-	s->pdtrb = mem_value;
-	portb_changed(s, temp);
-	return;
+        temp = portb_lines(s);
+        s->pdtrb = mem_value;
+        portb_changed(s, temp);
+        return;
     case SH7750_RFCR_A7:
-	fprintf(stderr, "Write access to refresh count register\n");
-	s->rfcr = mem_value;
-	return;
+        error_report("Write access to refresh count register");
+        s->rfcr = mem_value;
+        return;
     case SH7750_GPIOIC_A7:
-	s->gpioic = mem_value;
-	if (mem_value != 0) {
-	    fprintf(stderr, "I/O interrupts not implemented\n");
+        s->gpioic = mem_value;
+        if (mem_value != 0) {
+            error_report("I/O interrupts not implemented");
             abort();
-	}
-	return;
+        }
+        return;
     default:
-	error_access("word write", addr);
+        error_access("word write", addr);
         abort();
     }
 }
-- 
2.11.0
