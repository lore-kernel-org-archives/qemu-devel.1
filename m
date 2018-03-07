Received: from eggs.gnu.org ([2001:4830:134:3::10]:38179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etilh-0008V3-LM
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 18:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etilc-0006To-On
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 18:46:45 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1etilc-0006TU-EU
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 18:46:40 -0500
Received: by mail-wr0-x234.google.com with SMTP id v18so3912854wrv.0
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 15:46:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180305211928.466-1-f4bug@amsat.org>
	<f185bbb8-e7cd-b90a-da57-9dcbabecb1f2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <59483c6f-fbb7-3eae-95aa-c583f7104fac@amsat.org>
Date: Wed, 7 Mar 2018 20:46:37 -0300
MIME-Version: 1.0
In-Reply-To: <f185bbb8-e7cd-b90a-da57-9dcbabecb1f2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/22] remove i386/pc dependency:
 generic SuperIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

Hi Paolo,

On 03/07/2018 01:52 PM, Paolo Bonzini wrote:
> On 05/03/2018 22:19, Philippe Mathieu-Daudé wrote:
>> Since v1:
>> - complete rewrite, split out the PIIX devices for another series
>>
>> In this rewrite I extract the common SuperIO code from pc87312.c; use it in
>> few MIPS boards; then as example, easily add a new SuperIO chipset (SMC37C669)
>> to the dp264 machine.
>>
>> More devices are being converted but I'm running out of time for the soft
>> freeze (mips_r4k, hppa_dino, and the PC ones).
>>
>> This series could be the 'part 2' of my previous "remove i386/pc dependency
>> from non-PC world" I started around 2.9.
>>
>> Philippe Mathieu-Daudé (22):
>>   hw/isa: Move parallel_hds_isa_init() to hw/char/parallel-isa.c
>>   hw/dma/i8257: Rename DMA_init() to i8257_dma_init()
>>   hw/input/i8042: Extract declarations from i386/pc.h into input/i8042.h
>>   hw/isa/pc87312: Rename the device type as TYPE_PC87312_SUPERIO
>>   hw/isa/pc87312: Use uint16_t for the ISA I/O base address
>>   hw/isa/pc87312: Use 'unsigned int' for the irq value
>>   hw/isa/superio: Add a Super I/O template based on the PC87312 device
>>   hw/isa/pc87312: Inherit from the abstract TYPE_ISA_SUPERIO
>>   hw/isa/superio: Factor out the parallel code from pc87312.c
>>   hw/isa/superio: Factor out the serial code from pc87312.c
>>   hw/isa/superio: Factor out the floppy disc controller code from pc87312.c
>>   hw/isa/superio: Add a keyboard/mouse controller (8042)
>>   hw/isa/superio: Factor out the IDE code from pc87312.c
>>   hw/mips/malta: Code movement
>>   hw/isa/superio: Factor out the FDC37M817 Super I/O from mips_malta.c
>>   hw/mips/mips_fulong2e: Factor out vt82c686b_southbridge_init()
>>   hw/isa/vt82c686: Rename vt82c686b_init() -> vt82c686b_isa_init()
>>   hw/isa/vt82c686: Add the TYPE_VT82C686B_SUPERIO
>>   hw/isa/superio: Add the SMC FDC37C669 Super I/O
>>   hw/alpha/dp264: Add the ISA DMA controller
>>   hw/alpha/dp264: Use the TYPE_SMC37C669_SUPERIO
>>   hw/i386/pc: Factor out the superio code
>>
>>  default-configs/alpha-softmmu.mak |   5 +
>>  include/hw/char/parallel.h        |  14 +++
>>  include/hw/{isa => dma}/i8257.h   |   6 ++
>>  include/hw/i386/pc.h              |  17 ---
>>  include/hw/input/i8042.h          |  24 +++++
>>  include/hw/isa/isa.h              |   2 -
>>  include/hw/isa/pc87312.h          |  24 ++---
>>  include/hw/isa/superio.h          |  60 +++++++++++
>>  include/hw/isa/vt82c686.h         |   4 +-
>>  hw/alpha/dp264.c                  |  13 ++-
>>  hw/char/parallel-isa.c            |  36 +++++++
>>  hw/char/parallel.c                |   2 +-
>>  hw/dma/i82374.c                   |   3 +-
>>  hw/dma/i8257.c                    |   4 +-
>>  hw/i386/pc.c                      |  77 ++++++++------
>>  hw/i386/vmmouse.c                 |   1 +
>>  hw/i386/vmport.c                  |   1 +
>>  hw/input/pckbd.c                  |   2 +-
>>  hw/isa/isa-bus.c                  |  26 -----
>>  hw/isa/isa-superio.c              | 210 ++++++++++++++++++++++++++++++++++++++
>>  hw/isa/pc87312.c                  | 178 ++++++++++++++------------------
>>  hw/isa/smc37c669-superio.c        | 115 +++++++++++++++++++++
>>  hw/isa/vt82c686.c                 |  22 +++-
>>  hw/mips/mips_fulong2e.c           |  85 +++++++--------
>>  hw/mips/mips_jazz.c               |   5 +-
>>  hw/mips/mips_malta.c              |  48 ++++-----
>>  hw/mips/mips_r4k.c                |   3 +-
>>  hw/ppc/prep.c                     |   6 +-
>>  hw/sparc/sun4m.c                  |   4 -
>>  hw/sparc64/sun4u.c                |   6 +-
>>  hw/unicore32/puv3.c               |   1 +
>>  hw/char/Makefile.objs             |   1 +
>>  hw/isa/Makefile.objs              |   1 +
>>  hw/isa/trace-events               |  10 +-
>>  MAINTAINERS                       |   6 +-
>>  35 files changed, 721 insertions(+), 301 deletions(-)
>>  create mode 100644 include/hw/char/parallel.h
>>  rename include/hw/{isa => dma}/i8257.h (86%)
>>  create mode 100644 include/hw/input/i8042.h
>>  create mode 100644 include/hw/isa/superio.h
>>  create mode 100644 hw/char/parallel-isa.c
>>  create mode 100644 hw/isa/isa-superio.c
>>  create mode 100644 hw/isa/smc37c669-superio.c
>>
> 
> Queued, thanks.

Thanks for your trust, but this series is not ready yet :|

It touches various archs/machines and I couldn't test all images yet.

I posted it to get feedback and see if this superio refactor is useful
or not, makes sens. I understand you queuing it means somehow "yes" so
I'll continue to work on it, for now not adding more code but testing it
deeper and fixing few bugs :)

Thanks!

Phil.
