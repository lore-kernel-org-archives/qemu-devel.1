Received: from eggs.gnu.org ([2001:4830:134:3::10]:47162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1efQRA-0001Wk-Bx
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 08:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1efQR7-0001kj-05
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 08:22:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:49837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1efQR6-0001ja-MB
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 08:22:24 -0500
References: <20180124232625.30105-1-richard.henderson@linaro.org>
	<20180124232625.30105-42-richard.henderson@linaro.org>
	<7003731d-9ae3-408d-4d3a-a3510c9f2d0a@amsat.org>
From: Helge Deller <deller@gmx.de>
Message-ID: <8ef4cc5f-d907-9ddf-e620-d3ba0c3623e4@gmx.de>
Date: Sat, 27 Jan 2018 14:22:18 +0100
MIME-Version: 1.0
In-Reply-To: <7003731d-9ae3-408d-4d3a-a3510c9f2d0a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 41/45] hw/hppa: Implement DINO system
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

Hi Philipppe,

On 25.01.2018 12:22, Philippe Mathieu-Daudé wrote:
> Hi Richard, Helge,
> 
> On 01/24/2018 08:26 PM, Richard Henderson wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Now that we have the prerequisites in target/hppa/,
>> implement the hardware for a PA7100LC.
>>
>> This also enables build for hppa-softmmu.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> [rth: Since it is all new code, squashed all branch development
>> withing hw/hppa/ to a single patch.]
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  Makefile.objs                    |   1 +
>>  hw/hppa/hppa_hardware.h          |  40 +++
>>  hw/hppa/hppa_sys.h               |  24 ++
>>  hw/hppa/dino.c                   | 518 +++++++++++++++++++++++++++++++++++++++
>>  hw/hppa/machine.c                | 246 ++++++++++++++++++-
>>  hw/hppa/pci.c                    |  90 +++++++
>>  default-configs/hppa-softmmu.mak |  14 ++
>>  hw/hppa/Makefile.objs            |   2 +-
>>  hw/hppa/trace-events             |   4 +
>>  9 files changed, 937 insertions(+), 2 deletions(-)
>>  create mode 100644 hw/hppa/hppa_hardware.h
>>  create mode 100644 hw/hppa/hppa_sys.h
>>  create mode 100644 hw/hppa/dino.c
>>  create mode 100644 hw/hppa/pci.c
>>  create mode 100644 default-configs/hppa-softmmu.mak
>>  create mode 100644 hw/hppa/trace-events
...
>> +static ISABus *hppa_isa_bus(void)
>> +{
>> +    ISABus *isa_bus;
>> +    qemu_irq *isa_irqs;
>> +    MemoryRegion *isa_region;
>> +
>> +    isa_region = g_new(MemoryRegion, 1);
>> +    memory_region_init_io(isa_region, NULL, &hppa_pci_ignore_ops,
>> +                          NULL, "isa-io", 0x800);
>> +    memory_region_add_subregion(get_system_memory(), IDE_HPA,
>> +                                isa_region);
>> +
>> +    isa_bus = isa_bus_new(NULL, get_system_memory(), isa_region,
>> +                          &error_abort);
>> +    isa_irqs = i8259_init(isa_bus,
>> +                          /* qemu_allocate_irq(dino_set_isa_irq, s, 0)); */
> 
> What is that commented? circular dependency problem?

No actual problem.
It's a left-over from copy&pasting during the development phase.
We don't use and need ISA irqs yet. 
I left it in in case I'm going to expand it, but basically it can go.

Helge

 
>> +                          NULL);
>> +    isa_bus_irqs(isa_bus, isa_irqs);
>> +
>> +    return isa_bus;
>> +}
