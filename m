Received: from eggs.gnu.org ([2001:4830:134:3::10]:43830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cOKtC-0005Bb-Rt
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 03:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cOKt7-00013s-Qj
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 03:56:14 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cOKt7-00013f-Jx
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 03:56:09 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so85506702wmu.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 00:56:07 -0800 (PST)
References: <b0619e40-daca-9b28-2c78-1e2709d9f0ad@tuxfamily.org>
	<80f9cbae-8548-4d5e-2543-1d95020eddb1@vivier.eu>
	<20161227145805.5a19af6b@thl530>
	<2a409041-eac6-07bd-00ed-0d3e74733045@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <0f9b68f4-a549-2700-17f9-387e97b86ad4@tuxfamily.org>
Date: Tue, 3 Jan 2017 09:56:04 +0100
MIME-Version: 1.0
In-Reply-To: <2a409041-eac6-07bd-00ed-0d3e74733045@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] m68k: Remove dummy machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 02.01.2017 11:54, Laurent Vivier wrote:
> Le 27/12/2016 à 14:58, Thomas Huth a écrit :
>> Am Tue, 27 Dec 2016 12:52:30 +0100
>> schrieb Laurent Vivier <laurent@vivier.eu>:
>>
>>> Le 20/12/2016 à 15:32, Thomas Huth a écrit :
>>>> You can get an empty machine with "-M none" nowadays, so the
>>>> m68k dummy board (introduced in 2007) seems to be pretty
>>>> redundant since the "none" machine has been added in 2012.
>>>>
>>>> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
>>>> ---
>>>>  MAINTAINERS           |  4 ---
>>>>  hw/m68k/Makefile.objs |  2 --
>>>>  hw/m68k/dummy_m68k.c  | 84
>>>> --------------------------------------------------- 3 files
>>>> changed, 90 deletions(-) delete mode 100644 hw/m68k/dummy_m68k.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 4a60579..88ee8cd 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -552,10 +552,6 @@ S: Orphan
>>>>  F: hw/m68k/an5206.c
>>>>  F: hw/m68k/mcf5206.c
>>>>  
>>>> -dummy_m68k
>>>> -S: Orphan
>>>> -F: hw/m68k/dummy_m68k.c
>>>> -
>>>>  mcf5208
>>>>  S: Orphan
>>>>  F: hw/m68k/mcf5208.c
>>>> diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
>>>> index c4352e7..d1f089c 100644
>>>> --- a/hw/m68k/Makefile.objs
>>>> +++ b/hw/m68k/Makefile.objs
>>>> @@ -1,4 +1,2 @@
>>>>  obj-y += an5206.o mcf5208.o
>>>> -obj-y += dummy_m68k.o
>>>> -
>>>>  obj-y += mcf5206.o mcf_intc.o
>>>> diff --git a/hw/m68k/dummy_m68k.c b/hw/m68k/dummy_m68k.c
>>>> deleted file mode 100644
>>>> index 0b11d20..0000000
>>>> --- a/hw/m68k/dummy_m68k.c
>>>> +++ /dev/null
>>>> @@ -1,84 +0,0 @@
>>>> -/*
>>>> - * Dummy board with just RAM and CPU for use as an ISS.
>>>> - *
>>>> - * Copyright (c) 2007 CodeSourcery.
>>>> - *
>>>> - * This code is licensed under the GPL
>>>> - */
>>>> -
>>>> -#include "qemu/osdep.h"
>>>> -#include "qemu-common.h"
>>>> -#include "cpu.h"
>>>> -#include "hw/hw.h"
>>>> -#include "hw/boards.h"
>>>> -#include "hw/loader.h"
>>>> -#include "elf.h"
>>>> -#include "exec/address-spaces.h"
>>>> -
>>>> -#define KERNEL_LOAD_ADDR 0x10000
>>>> -
>>>> -/* Board init.  */
>>>> -
>>>> -static void dummy_m68k_init(MachineState *machine)
>>>> -{
>>>> -    ram_addr_t ram_size = machine->ram_size;
>>>> -    const char *cpu_model = machine->cpu_model;
>>>> -    const char *kernel_filename = machine->kernel_filename;
>>>> -    M68kCPU *cpu;
>>>> -    CPUM68KState *env;
>>>> -    MemoryRegion *address_space_mem =  get_system_memory();
>>>> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>>>> -    int kernel_size;
>>>> -    uint64_t elf_entry;
>>>> -    hwaddr entry;
>>>> -
>>>> -    if (!cpu_model)
>>>> -        cpu_model = "cfv4e";
>>>> -    cpu = cpu_m68k_init(cpu_model);
>>>> -    if (!cpu) {
>>>> -        fprintf(stderr, "Unable to find m68k CPU definition\n");
>>>> -        exit(1);
>>>> -    }
>>>> -    env = &cpu->env;
>>>> -
>>>> -    /* Initialize CPU registers.  */
>>>> -    env->vbr = 0;
>>>> -
>>>> -    /* RAM at address zero */
>>>> -    memory_region_allocate_system_memory(ram, NULL,
>>>> "dummy_m68k.ram",
>>>> -                                         ram_size);
>>>> -    memory_region_add_subregion(address_space_mem, 0, ram);
>>>> -
>>>> -    /* Load kernel.  */
>>>> -    if (kernel_filename) {
>>>> -        kernel_size = load_elf(kernel_filename, NULL, NULL,
>>>> &elf_entry,
>>>> -                               NULL, NULL, 1, EM_68K, 0, 0);
>>>> -        entry = elf_entry;
>>>> -        if (kernel_size < 0) {
>>>> -            kernel_size = load_uimage(kernel_filename, &entry,
>>>> NULL, NULL,
>>>> -                                      NULL, NULL);
>>>> -        }
>>>> -        if (kernel_size < 0) {
>>>> -            kernel_size = load_image_targphys(kernel_filename,
>>>> -                                              KERNEL_LOAD_ADDR,
>>>> -                                              ram_size -
>>>> KERNEL_LOAD_ADDR);
>>>> -            entry = KERNEL_LOAD_ADDR;
>>>> -        }
>>>> -        if (kernel_size < 0) {
>>>> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
>>>> -                    kernel_filename);
>>>> -            exit(1);
>>>> -        }
>>>> -    } else {
>>>> -        entry = 0;
>>>> -    }
>>>> -    env->pc = entry;
>>>> -}
>>>> -
>>>> -static void dummy_m68k_machine_init(MachineClass *mc)
>>>> -{
>>>> -    mc->desc = "Dummy board";
>>>> -    mc->init = dummy_m68k_init;
>>>> -}
>>>> -
>>>> -DEFINE_MACHINE("dummy", dummy_m68k_machine_init)
>>>>
>>>
>>> I'm not sure the "none" machine can replace the "dummy" machine as the
>>> "dummy" machine can load a kernel whereas it seems the "none" one
>>> can't.
>>
>> Oh, that's true ... I did not notice it 'cause there was no error
>> message when I tried to start the "none" machine with "-kernel". But
>> looking at the code in hw/core/null-machine.c, it really seems that
>> there is nothing in here :-( So never mind, please forget about this
>> patch. (but now I wonder whether the "none" machine could be improved to
>> provide the features of the "dummy" machine, too?)
> 
> The "none" machine is defined to be be filled with QMP commands, perhaps
> the generic-loader object can replace the "-kernel" parameters?

As far as I can see, there is even more to be done here: The "none"
machine apparently does not instantiate any CPUs yet, so we would need
to add the possibility to add a CPU to the empty here, too...

 Thomas
