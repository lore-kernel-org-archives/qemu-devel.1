Received: from eggs.gnu.org ([2001:4830:134:3::10]:49096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marko.klopcic@isystem.si>) id 1fs4yt-0000LI-UD
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marko.klopcic@isystem.si>) id 1fs4yp-0001mP-Rl
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:37:51 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:55720)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marko.klopcic@isystem.si>)
	id 1fs4yp-0001l7-E5
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:37:47 -0400
Received: by mail-wm0-x244.google.com with SMTP id f21-v6so2588443wmc.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 04:37:46 -0700 (PDT)
References: <2edf4dc3-5cc2-c3f3-fd40-7901e2c06413@isystem.si>
	<CAFEAcA-gbG0xF3faXZYpkg_OyOyNcPyviDBhytzi1AkUj3FL4w@mail.gmail.com>
From: Marko Klopcic <marko.klopcic@isystem.si>
Message-ID: <5adf2f78-0e4f-7c02-a5df-a2770ab4920d@isystem.si>
Date: Tue, 21 Aug 2018 13:37:43 +0200
In-Reply-To: <CAFEAcA-gbG0xF3faXZYpkg_OyOyNcPyviDBhytzi1AkUj3FL4w@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] arm: fix reset operation on
 netduino2 board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>

   Thanks for the review. I agree that this fix is more a workaround, but
   it is local to
   the only currently existing board with STM32 (AFAIK), so I couldn't
   break other targets.
   I'll try to implement one of your proposals.
   Marko

   On 2018-08-20 2:33 PM, Peter Maydell wrote:

On 20 August 2018 at 12:10, Marko Klopcic [1]<marko.klopcic@isystem.si> wrote:

Because roms are located on aliased addresses on netduino2 (Cortex M3,
STM32F205), PC and SP are not read from loaded kernel, which means
that the first reset fails. This fix adds additional call to reset.
See more details in code comment below.

Signed-off-by: Marko Klopcic [2]<marko.klopcic@isystem.si>

---
 hw/arm/netduino2.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index f936017d4a..a2f102b14b 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
+#include "hw/loader.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/arm/arm.h"
@@ -39,6 +40,32 @@ static void netduino2_init(MachineState *machine)

     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
                        FLASH_SIZE);
+
+    /*
+      The following two calls are a workaround for problem with rom on
aliased
+      addresses on STM32.
+      Kernel is loaded into Rom objects, which are stored in loader.c. Roms
+      are copied to memory in:
+
+      void rom_reset() {
+        ...
+         cpu_physical_memory_write_rom(rom->as, rom->addr, rom->data,
+                                       rom->datasize);
+        ...
+      }
+
+      However, since CPU reset is registered BEFORE
+      rom_reset(), SP and PC are read from memory BEFORE roms are copied to
+      memory. CPU reset also checks Roms for data, so this is normally not
a
+      problem, but in STM32 PC and SP are read from aliased memory, and
these
+      memory addresses are not mapped to Roms. Since ROMs are private in
+      loader.c the only option to copy Roms to memory is through reset. So
we
+      first have to register Roms for reset, and then trigger system reset,
which
+      copies Roms to mem, so that reset vectors are in memory, when
+      qemu_system_reset() is called again from main().
+     */
+    rom_check_and_register_reset();
+    qemu_system_reset(SHUTDOWN_CAUSE_NONE);
 }

I agree that this is a bug, but I think this is not the right way
to fix it, as it is not specific to this particular board. We need
to either somehow ensure the reset order between the rom code
and the Arm CPU reset is enforced, or change how we do the SP/PC
load on reset of an M-profile core.

thanks
-- PMM

References

   1. mailto:marko.klopcic@isystem.si
   2. mailto:marko.klopcic@isystem.si
