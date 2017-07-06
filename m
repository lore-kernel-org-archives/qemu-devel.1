Received: from eggs.gnu.org ([2001:4830:134:3::10]:51435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT8DB-0003Ys-1Q
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT8D7-0008Hb-R0
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:56:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dT8D7-0008HG-Ho
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:56:53 -0400
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
	<CAFEAcA-xkd94VTVOuOvXeowb92TPose4y8LKB5o56UyRMNXsfw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ebbc85e-5b44-1f49-296f-4be51405d521@redhat.com>
Date: Thu, 6 Jul 2017 16:56:41 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-xkd94VTVOuOvXeowb92TPose4y8LKB5o56UyRMNXsfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Add new utility function
 memory_region_allocate_aux_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>



On 06/07/2017 16:52, Peter Maydell wrote:
> On 5 July 2017 at 13:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>
>> On 04/07/2017 19:02, Peter Maydell wrote:
>>> Many board models and several devices need to create auxiliary
>>> regions of RAM (in addition to the main lump of 'system' memory),
>>> to model static RAMs, video memory, ROMs, etc. Currently they do
>>> this with a sequence like:
>>>        memory_region_init_ram(sram, NULL, "sram", 0x10000, &error_fatal);
>>>        vmstate_register_ram_global(sram);
>>
>> Instead of vmstate_register_ram_global, you should use
>>
>>     vmstate_register_ram(mr, owner);
>>
>> You should even do it for all memory regions, probably.
> 
> This sounds like a good thing, but it's awkward for migration
> compatibility, because these callers to memory_region_init_ram()
> don't call vmstate_register_ram():
> 
> hw/arm/highbank.c (a bug)
> hw/mips/mips_malta.c (region is ro)
> hw/net/dp3893x.c (prom, ro, contains mac address)
> hw/pci-host/xilinx-pcie.c (dummy region; migrating wouldn't hurt)
> backends/hostmem-ram.c (bug, or is migration handled elsewhere?)

It's handled by memory_region_allocate_system_memory.

> and if we add an implicit call then we break migration compat
> for those boards/devices.

Forward migration should still work.  The backwards-incompatible part
would be that unused memory backend objects would have to be present on
the destination as well when migrating.  I think it's acceptable.

>> Only memory_region_init_ram_device_ptr (which sets mr->ram_device) must
>> not call vmstate_register_ram.  This is a bit ugly because it requires
>> inlining memory_region_init_ram_ptr into it.
>>
>> memory_region_init_ram_from_fd probably needs to be excluded, as well,
>> based on its sole user.
> 
> Callers of memory_region_init_ram_from_file() which don't
> call vmstate_register_ram():
> backends/hostmem-ram.c

Same as above.

> Callers of memory_region_init_ram_ptr() which don't call
> vmstate_register_ram():
> hw/misc/mmio_interface.c
>  -- seems to be an implementation detail of the exceute-from-device
>     support so maybe it doesn't need migration support ??
I think so...

Paolo
