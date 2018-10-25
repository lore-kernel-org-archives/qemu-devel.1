Received: from eggs.gnu.org ([2001:4830:134:3::10]:45422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gFmNE-0002ra-GX
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gFmND-0001S3-Eb
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:36:56 -0400
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-12-mark.cave-ayland@ilande.co.uk>
	<dea80569-ff85-7b29-ad49-b1c54aadf003@posteo.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9303f78e-e2d7-a6b2-6ca2-9510bb0ea1fe@ilande.co.uk>
Date: Thu, 25 Oct 2018 21:36:25 +0100
MIME-Version: 1.0
In-Reply-To: <dea80569-ff85-7b29-ad49-b1c54aadf003@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/11] hw/m68k: define Macintosh Quadra
 800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <th.huth@posteo.de>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net, laurent@vivier.eu

On 23/10/2018 12:20, Thomas Huth wrote:

> On 2018-10-18 19:28, Mark Cave-Ayland wrote:
>> From: Laurent Vivier <laurent@vivier.eu>
>>
>> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
> [...]
>> diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
>> index d1f089c08a..18ebf1937a 100644
>> --- a/hw/m68k/Makefile.objs
>> +++ b/hw/m68k/Makefile.objs
>> @@ -1,2 +1,4 @@
>> -obj-y += an5206.o mcf5208.o
>> -obj-y += mcf5206.o mcf_intc.o
>> +obj-$(CONFIG_COLDFIRE) += an5206.o mcf5208.o
>> +obj-$(CONFIG_MAC) += q800.o
>> +
>> +obj-$(CONFIG_COLDFIRE) += mcf5206.o mcf_intc.o
> 
> Cosmetic nit: Keep the coldfire lines together instead of splitting them?

Cosmetic nit fixed in the latest version ;)

>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>> new file mode 100644
>> index 0000000000..bbf34262f0
>> --- /dev/null
>> +++ b/hw/m68k/q800.c
>> @@ -0,0 +1,367 @@
>> +/*
>> + * QEMU Motorla 680x0 Macintosh hardware System Emulator
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this software and associated documentation files (the "Software"), to deal
>> + * in the Software without restriction, including without limitation the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "sysemu/sysemu.h"
>> +#include "cpu.h"
>> +#include "hw/hw.h"
>> +#include "hw/boards.h"
>> +#include "elf.h"
>> +#include "hw/loader.h"
>> +#include "hw/display/framebuffer.h"
>> +#include "ui/console.h"
>> +#include "exec/address-spaces.h"
>> +#include "hw/char/escc.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/scsi/esp.h"
>> +#include "bootinfo.h"
>> +#include "hw/misc/mac_via.h"
>> +#include "hw/input/adb.h"
>> +#include "hw/audio/asc.h"
>> +#include "hw/nubus/mac-nubus-bridge.h"
>> +#include "hw/display/macfb.h"
>> +#include "hw/intc/q800_irq.h"
>> +#include "hw/block/swim.h"
>> +#include "net/net.h"
>> +#include "qapi/error.h"
>> +#include "sysemu/qtest.h"
>> +
>> +#define MACROM_ADDR     0x40000000
>> +#define MACROM_SIZE     0x00100000
>> +
>> +/*
>> + *              .ident          = MAC_MODEL_Q800,
>> + *              .name           = "Quadra 800",
>> + *              .adb_type       = MAC_ADB_II,
>> + *              .via_type       = MAC_VIA_QUADRA,
>> + *              .scsi_type      = MAC_SCSI_QUADRA,
>> + *              .scc_type       = MAC_SCC_QUADRA,
>> + *              .ether_type     = MAC_ETHER_SONIC,
>> + *              .nubus_type     = MAC_NUBUS
>> + */
> 
> Is this comment intentional or left-over code from an older rebase?

I suspect this has come from another Linux file somewhere, but as it's nothing
related to QEMU then I've removed it for now.


ATB,

Mark.
