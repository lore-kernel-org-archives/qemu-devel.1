Received: from eggs.gnu.org ([2001:4830:134:3::10]:44296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX8so-0003Vh-Jj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX8sn-00006F-Cz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:28:30 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX8sn-00005b-4Z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:28:29 -0400
Received: by mail-wm0-x22e.google.com with SMTP id b134so53681783wma.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 09:28:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8ebbc85e-5b44-1f49-296f-4be51405d521@redhat.com>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
	<CAFEAcA-xkd94VTVOuOvXeowb92TPose4y8LKB5o56UyRMNXsfw@mail.gmail.com>
	<8ebbc85e-5b44-1f49-296f-4be51405d521@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 17:28:07 +0100
Message-ID: <CAFEAcA_XnK62m9bSm8FOOfAgd+SrKT7nw9y3EAVEzYTg4WWAkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 6 July 2017 at 15:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 06/07/2017 16:52, Peter Maydell wrote:
>> On 5 July 2017 at 13:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>>
>>> On 04/07/2017 19:02, Peter Maydell wrote:
>>>> Many board models and several devices need to create auxiliary
>>>> regions of RAM (in addition to the main lump of 'system' memory),
>>>> to model static RAMs, video memory, ROMs, etc. Currently they do
>>>> this with a sequence like:
>>>>        memory_region_init_ram(sram, NULL, "sram", 0x10000, &error_fatal);
>>>>        vmstate_register_ram_global(sram);
>>>
>>> Instead of vmstate_register_ram_global, you should use
>>>
>>>     vmstate_register_ram(mr, owner);
>>>
>>> You should even do it for all memory regions, probably.
>>
>> This sounds like a good thing, but it's awkward for migration
>> compatibility, because these callers to memory_region_init_ram()
>> don't call vmstate_register_ram():
>>
>> hw/arm/highbank.c (a bug)
>> hw/mips/mips_malta.c (region is ro)
>> hw/net/dp3893x.c (prom, ro, contains mac address)
>> hw/pci-host/xilinx-pcie.c (dummy region; migrating wouldn't hurt)
>> backends/hostmem-ram.c (bug, or is migration handled elsewhere?)
>
> It's handled by memory_region_allocate_system_memory.
>
>> and if we add an implicit call then we break migration compat
>> for those boards/devices.
>
> Forward migration should still work.  The backwards-incompatible part
> would be that unused memory backend objects would have to be present on
> the destination as well when migrating.  I think it's acceptable.

Migration compatibility turns out not to be quite this simple.
What seems to happen is that the migration code migrates *all*
RAMBlocks, named or otherwise, and fails migration if it
can't match up the names. So you can have one (1) region for
which you forgot to call vmstate_register_ram(), and that will
work (it gets the "" empty string name). If you have more than
one then they'll get confused, especially if they have different
sizes, and loading the VM state will fail.

>>> Only memory_region_init_ram_device_ptr (which sets mr->ram_device) must
>>> not call vmstate_register_ram.  This is a bit ugly because it requires
>>> inlining memory_region_init_ram_ptr into it.
>>>
>>> memory_region_init_ram_from_fd probably needs to be excluded, as well,
>>> based on its sole user.

Note that the above means that since these do create RAMBlocks
their contents *will* be getting migrated.

>> Callers of memory_region_init_ram_ptr() which don't call
>> vmstate_register_ram():
>> hw/misc/mmio_interface.c
>>  -- seems to be an implementation detail of the exceute-from-device
>>     support so maybe it doesn't need migration support ??
> I think so...

I think we need to look rather more closely at how this code
works with migration...

thanks
-- PMM
