Received: from eggs.gnu.org ([2001:4830:134:3::10]:40933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiE76-0006bp-I9
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 01:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiE71-0003jb-Sv
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 01:49:20 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:41853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiE71-0003iF-Lk
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 01:49:15 -0500
Received: by mail-pl0-x242.google.com with SMTP id k8so7309369pli.8
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 22:49:15 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	c1sm10622114pfa.119.2018.02.03.22.49.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 03 Feb 2018 22:49:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 22:49:10 -0800
Message-Id: <20180204064911.9828-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] hw/hppa: Use qemu_log_mask instead of
 fprintf to stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index afd3867313..19033e268d 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -19,6 +19,7 @@
 #include "hw/hppa/hppa_sys.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 
 #define MAX_IDE_BUS 2
 
@@ -111,7 +112,6 @@ static void machine_hppa_init(MachineState *machine)
         uint32_t addr = DINO_UART_HPA + 0x800;
         serial_mm_init(addr_space, addr, 0, serial_irq,
                        115200, serial_hds[0], DEVICE_BIG_ENDIAN);
-        fprintf(stderr, "Serial port created at 0x%x\n", addr);
     }
 
     /* SCSI disk setup. */
@@ -146,9 +146,9 @@ static void machine_hppa_init(MachineState *machine)
         error_report("could not load firmware '%s'", firmware_filename);
         exit(1);
     }
-    fprintf(stderr, "Firmware loaded at 0x%08" PRIx64 "-0x%08" PRIx64
-            ", entry at 0x%08" PRIx64 ".\n",
-            firmware_low, firmware_high, firmware_entry);
+    qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
+                  "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
+                  firmware_low, firmware_high, firmware_entry);
     if (firmware_low < ram_size || firmware_high >= FIRMWARE_END) {
         error_report("Firmware overlaps with memory or IO space");
         exit(1);
@@ -163,7 +163,6 @@ static void machine_hppa_init(MachineState *machine)
 
     /* Load kernel */
     if (kernel_filename) {
-        fprintf(stderr, "LOADING kernel '%s'\n", kernel_filename);
         size = load_elf(kernel_filename, &cpu_hppa_to_phys,
                         NULL, &kernel_entry, &kernel_low, &kernel_high,
                         true, EM_PARISC, 0, 0);
@@ -177,10 +176,10 @@ static void machine_hppa_init(MachineState *machine)
             error_report("could not load kernel '%s'", kernel_filename);
             exit(1);
         }
-
-        fprintf(stderr, "Kernel loaded at 0x%08" PRIx64 "-0x%08" PRIx64
-                ", entry at 0x%08" PRIx64 ", size %ld kB.\n",
-                kernel_low, kernel_high, kernel_entry, size / 1024);
+        qemu_log_mask(CPU_LOG_PAGE, "Kernel loaded at 0x%08" PRIx64
+                      "-0x%08" PRIx64 ", entry at 0x%08" PRIx64
+                      ", size %ld kB.\n",
+                      kernel_low, kernel_high, kernel_entry, size / 1024);
 
         if (kernel_cmdline) {
             cpu[0]->env.gr[24] = 0x4000;
-- 
2.14.3
