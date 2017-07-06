Received: from eggs.gnu.org ([2001:4830:134:3::10]:56731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dT9bu-0002GP-Py
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dT9bt-000530-Sb
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:26:34 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:36610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dT9bt-00050i-LB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:26:33 -0400
Received: by mail-wr0-x22f.google.com with SMTP id c11so9690583wrc.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 09:26:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8ebbc85e-5b44-1f49-296f-4be51405d521@redhat.com>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
	<CAFEAcA-xkd94VTVOuOvXeowb92TPose4y8LKB5o56UyRMNXsfw@mail.gmail.com>
	<8ebbc85e-5b44-1f49-296f-4be51405d521@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2017 17:26:10 +0100
Message-ID: <CAFEAcA-G6=FfgXrHVE+eUP0YLd9Bp0b26n_0pTiW-joF++BcBg@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

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

OK. To sum up an IRC conversation...

I think that to avoid getting tangled up in trying to fix
or deal with these handful of oddball cases at the same time
as doing a global change to the easy cases, we should:

 * globally rename memory_region_init_ram to memory_region_init_ram_nomigrate
   (and document that it is the caller's job to arrange to migrate the RAM)
 * add new memory_region_init_ram which does memory_region_init_ram_nomigrate
   + vmstate_register_ram
 * coccinelle patch to switch to using that new function where possible
 * get that lot committed, because it touches so many files and
   is a recipe for conflicts
 * look at the remaining handful of _nomigrate calls and perhaps
   switch them where that would be a bug fix

Q: should we have _nomigrate versions of any of the other
memory_region_init_ram* functions? I think it makes sense
for only the basic _init_ram to do the migration for you,
because that's the only case where the memory system is
creating the backing storage for the caller, rather than the
caller passing in the backing storage. "Be consistent for
the full set of functions" would be the other obvious approach;
I don't think I care too much either way.

thanks
-- PMM
