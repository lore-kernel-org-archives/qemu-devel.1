Received: from eggs.gnu.org ([2001:4830:134:3::10]:48314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marko.klopcic@isystem.si>) id 1fri5M-0007Cq-3z
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marko.klopcic@isystem.si>) id 1fri5I-0001AG-UW
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:11:00 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marko.klopcic@isystem.si>)
	id 1fri5I-00019j-Ju
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 07:10:56 -0400
Received: by mail-wm0-x244.google.com with SMTP id c14-v6so13877369wmb.4
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 04:10:56 -0700 (PDT)
From: Marko Klopcic <marko.klopcic@isystem.si>
Message-ID: <2edf4dc3-5cc2-c3f3-fd40-7901e2c06413@isystem.si>
Date: Mon, 20 Aug 2018 13:10:53 +0200
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [Qemu-devel] [PATCH] arm: fix reset operation on netduino2 board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, mjt@tls.msk.ru

   Because roms are located on aliased addresses on netduino2 (Cortex M3,
   STM32F205), PC and SP are not read from loaded kernel, which means
   that the first reset fails. This fix adds additional call to reset.
   See more details in code comment below.
   Signed-off-by: Marko Klopcic [1]<marko.klopcic@isystem.si>
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
   +      Kernel is loaded into Rom objects, which are stored in loader.c.
   Roms
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
   +      rom_reset(), SP and PC are read from memory BEFORE roms are
   copied to
   +      memory. CPU reset also checks Roms for data, so this is normally
   not a
   +      problem, but in STM32 PC and SP are read from aliased memory,
   and these
   +      memory addresses are not mapped to Roms. Since ROMs are private
   in
   +      loader.c the only option to copy Roms to memory is through
   reset. So we
   +      first have to register Roms for reset, and then trigger system
   reset, which
   +      copies Roms to mem, so that reset vectors are in memory, when
   +      qemu_system_reset() is called again from main().
   +     */
   +    rom_check_and_register_reset();
   +    qemu_system_reset(SHUTDOWN_CAUSE_NONE);
    }

    static void netduino2_machine_init(MachineClass *mc)
   --
   2.14.1

References

   1. mailto:marko.klopcic@isystem.si
