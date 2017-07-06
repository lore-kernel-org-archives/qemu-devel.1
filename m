Received: from eggs.gnu.org ([2001:4830:134:3::10]:50288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dT89T-0001ON-Hb
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dT89S-0005z6-K6
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:53:07 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dT89S-0005yV-CD
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:53:06 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k67so6172819wrc.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 07:53:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2017 15:52:44 +0100
Message-ID: <CAFEAcA-xkd94VTVOuOvXeowb92TPose4y8LKB5o56UyRMNXsfw@mail.gmail.com>
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

On 5 July 2017 at 13:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>
> On 04/07/2017 19:02, Peter Maydell wrote:
>> Many board models and several devices need to create auxiliary
>> regions of RAM (in addition to the main lump of 'system' memory),
>> to model static RAMs, video memory, ROMs, etc. Currently they do
>> this with a sequence like:
>>        memory_region_init_ram(sram, NULL, "sram", 0x10000, &error_fatal);
>>        vmstate_register_ram_global(sram);
>
> Instead of vmstate_register_ram_global, you should use
>
>     vmstate_register_ram(mr, owner);
>
> You should even do it for all memory regions, probably.

This sounds like a good thing, but it's awkward for migration
compatibility, because these callers to memory_region_init_ram()
don't call vmstate_register_ram():

hw/arm/highbank.c (a bug)
hw/mips/mips_malta.c (region is ro)
hw/net/dp3893x.c (prom, ro, contains mac address)
hw/pci-host/xilinx-pcie.c (dummy region; migrating wouldn't hurt)
backends/hostmem-ram.c (bug, or is migration handled elsewhere?)

and if we add an implicit call then we break migration compat
for those boards/devices.

> Only memory_region_init_ram_device_ptr (which sets mr->ram_device) must
> not call vmstate_register_ram.  This is a bit ugly because it requires
> inlining memory_region_init_ram_ptr into it.
>
> memory_region_init_ram_from_fd probably needs to be excluded, as well,
> based on its sole user.

Callers of memory_region_init_ram_from_file() which don't
call vmstate_register_ram():
backends/hostmem-ram.c

Callers of memory_region_init_ram_ptr() which don't call
vmstate_register_ram():
hw/misc/mmio_interface.c
 -- seems to be an implementation detail of the exceute-from-device
    support so maybe it doesn't need migration support ??

thanks
-- PMM
