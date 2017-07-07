Received: from eggs.gnu.org ([2001:4830:134:3::10]:54944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTT9a-0004f5-Bw
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTT9Z-0005Pp-Ag
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:18:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dTT9Z-0005Pb-27
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:18:37 -0400
Date: Fri, 7 Jul 2017 15:18:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170707151829.017c9eb2@nial.brq.redhat.com>
In-Reply-To: <CAFEAcA-G6=FfgXrHVE+eUP0YLd9Bp0b26n_0pTiW-joF++BcBg@mail.gmail.com>
References: <1499187763-8211-1-git-send-email-peter.maydell@linaro.org>
	<3c48839d-063b-36f6-1620-16042a1b451d@redhat.com>
	<CAFEAcA-xkd94VTVOuOvXeowb92TPose4y8LKB5o56UyRMNXsfw@mail.gmail.com>
	<8ebbc85e-5b44-1f49-296f-4be51405d521@redhat.com>
	<CAFEAcA-G6=FfgXrHVE+eUP0YLd9Bp0b26n_0pTiW-joF++BcBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Thu, 6 Jul 2017 17:26:10 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 6 July 2017 at 15:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> >
> > On 06/07/2017 16:52, Peter Maydell wrote:  
> >> On 5 July 2017 at 13:21, Paolo Bonzini <pbonzini@redhat.com> wrote:  
> >>>
> >>>
> >>> On 04/07/2017 19:02, Peter Maydell wrote:  
> >>>> Many board models and several devices need to create auxiliary
> >>>> regions of RAM (in addition to the main lump of 'system' memory),
> >>>> to model static RAMs, video memory, ROMs, etc. Currently they do
> >>>> this with a sequence like:
> >>>>        memory_region_init_ram(sram, NULL, "sram", 0x10000, &error_fatal);
> >>>>        vmstate_register_ram_global(sram);  
> >>>
> >>> Instead of vmstate_register_ram_global, you should use
> >>>
> >>>     vmstate_register_ram(mr, owner);
> >>>
> >>> You should even do it for all memory regions, probably.  
> >>
> >> This sounds like a good thing, but it's awkward for migration
> >> compatibility, because these callers to memory_region_init_ram()
> >> don't call vmstate_register_ram():
> >>
> >> hw/arm/highbank.c (a bug)
> >> hw/mips/mips_malta.c (region is ro)
> >> hw/net/dp3893x.c (prom, ro, contains mac address)
> >> hw/pci-host/xilinx-pcie.c (dummy region; migrating wouldn't hurt)
> >> backends/hostmem-ram.c (bug, or is migration handled elsewhere?)  
> >
> > It's handled by memory_region_allocate_system_memory.  
> 
> OK. To sum up an IRC conversation...
> 
> I think that to avoid getting tangled up in trying to fix
> or deal with these handful of oddball cases at the same time
> as doing a global change to the easy cases, we should:
> 
>  * globally rename memory_region_init_ram to memory_region_init_ram_nomigrate
>    (and document that it is the caller's job to arrange to migrate the RAM)
it would be a bit weird when MR created as _nomigrate()
is then registered with vmstate_register_ram() and being migrated.

maybe other way around, places that don't wanna to use explicit
vmstate_register_ram() could replace 2 calls with helper memory_region_init_ram_automigrate()


>  * add new memory_region_init_ram which does memory_region_init_ram_nomigrate
>    + vmstate_register_ram
>  * coccinelle patch to switch to using that new function where possible
>  * get that lot committed, because it touches so many files and
>    is a recipe for conflicts
>  * look at the remaining handful of _nomigrate calls and perhaps
>    switch them where that would be a bug fix
> 
> Q: should we have _nomigrate versions of any of the other
> memory_region_init_ram* functions? I think it makes sense
> for only the basic _init_ram to do the migration for you,
> because that's the only case where the memory system is
> creating the backing storage for the caller, rather than the
> caller passing in the backing storage. "Be consistent for
> the full set of functions" would be the other obvious approach;
> I don't think I care too much either way.
I 'd keep current way where memory_region and vmstate APIs are split
and consistent in what they are doing instead of making Frankenstein
from memory_region API.

> thanks
> -- PMM
> 
