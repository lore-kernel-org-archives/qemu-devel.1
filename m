Received: from eggs.gnu.org ([208.118.235.92]:39904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1ehLGa-0000of-Bq
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1ehLCR-0000Jc-Ds
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:15:28 -0500
Received: from mout.gmx.net ([212.227.15.15]:63112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1ehLCQ-0000I0-TT
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:11:11 -0500
Date: Thu, 1 Feb 2018 21:11:01 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20180201201101.GA31191@ls3530.fritz.box>
References: <20180130044621.10464-1-richard.henderson@linaro.org>
	<20180130044621.10464-2-richard.henderson@linaro.org>
	<90f0c9fa-ee0b-29d3-e39a-fc7391179e3d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f0c9fa-ee0b-29d3-e39a-fc7391179e3d@redhat.com>
Subject: Re: [Qemu-devel] [PULL v5 39/43] hw/hppa: Implement DINO system
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Helge Deller <deller@gmx.de>

* Thomas Huth <thuth@redhat.com>:
> First kudos for the new hppa-softmmu target!

Thanks Thomas!

> But these debug messages now pop up during "make check-qtest":
> 
> Serial port created at 0xfff83800
> Firmware loaded at 0xf0000000-0xf0023f29, entry at 0xf0000084.
> 
> That's a little bit annoying. Could you please either remove them or
> silence them in qtest mode by adding a check for !qtest_enabled() ?

The patch below fixes it.
Richard, can you apply it?

Helge

-------

target/hppa: Silence debug messages in qtest mode

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index afd3867313..338aa87724 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -12,6 +12,7 @@
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/ide.h"
 #include "hw/timer/i8254.h"
@@ -111,7 +112,9 @@ static void machine_hppa_init(MachineState *machine)
         uint32_t addr = DINO_UART_HPA + 0x800;
         serial_mm_init(addr_space, addr, 0, serial_irq,
                        115200, serial_hds[0], DEVICE_BIG_ENDIAN);
-        fprintf(stderr, "Serial port created at 0x%x\n", addr);
+        if (!qtest_enabled()) {
+            fprintf(stderr, "Serial port created at 0x%x\n", addr);
+        }
     }
 
     /* SCSI disk setup. */
@@ -146,9 +149,11 @@ static void machine_hppa_init(MachineState *machine)
         error_report("could not load firmware '%s'", firmware_filename);
         exit(1);
     }
-    fprintf(stderr, "Firmware loaded at 0x%08" PRIx64 "-0x%08" PRIx64
+    if (!qtest_enabled()) {
+        fprintf(stderr, "Firmware loaded at 0x%08" PRIx64 "-0x%08" PRIx64
             ", entry at 0x%08" PRIx64 ".\n",
             firmware_low, firmware_high, firmware_entry);
+    }
     if (firmware_low < ram_size || firmware_high >= FIRMWARE_END) {
         error_report("Firmware overlaps with memory or IO space");
         exit(1);
