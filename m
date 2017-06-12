Received: from eggs.gnu.org ([2001:4830:134:3::10]:47031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dKUoI-0000Am-Ui
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dKUoE-0007oK-DU
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:15:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dKUoE-0007o9-5W
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:15:30 -0400
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170612134328.76c5a352@nial.brq.redhat.com>
	<84a176fb-0d57-09f5-15c3-8e2bd4c66f48@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0799bedf-d1af-49e3-4d18-81957b9240c3@redhat.com>
Date: Mon, 12 Jun 2017 21:15:22 +0200
MIME-Version: 1.0
In-Reply-To: <84a176fb-0d57-09f5-15c3-8e2bd4c66f48@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] fw_cfg: move qdev_init_nofail() out
 from fw_cfg_init1() into callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Igor Mammedov <imammedo@redhat.com>
Cc: ehabkost@redhat.com, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>

Adding Peter

On 06/12/17 13:54, Mark Cave-Ayland wrote:
> On 12/06/17 12:43, Igor Mammedov wrote:
> 
>> On Sat, 10 Jun 2017 13:30:17 +0100
>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
>>
>> patch needs a commit message saying why it's needed.
>> maybe add something similar to:
>>
>> qdev_init_nofail() essentially 'realizes' object,
>> taking in account that fw_cfg_init1() will be moved to
>> realize in follow up patches, move qdev_init_nofail() outside of
>> fw_cfg_init1().
> 
> Yes, I can alter the commit message to provide more explanation. For
> some background the use case can be found in my follow-up sun4u patches
> here (i.e. preparation for moving the ebus device behind a PCI bridge):
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg02658.html
> https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg02656.html

I see.

So what you want to replace actually resides in fw_cfg_io_realize(). It
is the following set of function calls:

    sysbus_add_io(sbd, s->iobase, &s->comb_iomem);

        sysbus_add_io(sbd, s->dma_iobase, &FW_CFG(s)->dma_iomem);

which both translate to

    memory_region_add_subregion(get_system_io(), addr, mem);

And you want to replace the first parameter here, namely get_system_io().

I think your use case uncovered an actual QOM bug in
fw_cfg_io_realize(). Compare fw_cfg_mem_realize():

    sysbus_init_mmio(sbd, &s->ctl_iomem);

    sysbus_init_mmio(sbd, &s->data_iomem);

        sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);

But these function calls do not *map* subregions!

Now, I *distinctly* recall that, when we were working on
fw_cfg_mem_realize(), Paolo and Peter pointed out that, while MMIO and
IO region *creation* were "realize business", *mapping* those same
regions to address spaces (or higher level memory regions) was *board*
business... Yes, please see the following messages:

http://lists.nongnu.org/archive/html/qemu-devel/2014-12/msg02839.html
http://lists.nongnu.org/archive/html/qemu-devel/2014-12/msg02849.html

Ultimately, Paolo graciously fixed up this error in my then-v5 patch
(thanks again Paolo!); see:

- http://lists.nongnu.org/archive/html/qemu-devel/2014-12/msg02851.html
- http://lists.nongnu.org/archive/html/qemu-devel/2014-12/msg03254.html
- commit 5712db6ae510 ("fw_cfg: hard separation between the MMIO and
  I/O port mappings", 2014-12-22).

But, we all seem to have missed the exact same error in
fw_cfg_io_realize() at that time.

So here's my suggestion:

(1) Fix the QOM bug -- my mess :) -- at the very first. Move the
sysbus_add_io() calls from fw_cfg_io_realize() to fw_cfg_init_io_dma()
(which is a board helper function, not a realize function), after
fw_cfg_init1().

Notice that in fw_cfg_init_mem_wide(), we have

    fw_cfg_init1(dev);

    sbd = SYS_BUS_DEVICE(dev);
    sysbus_mmio_map(sbd, 0, ctl_addr);
    sysbus_mmio_map(sbd, 1, data_addr);

which is exactly what we should parallel in fw_cfg_init_io_dma().

(2) Once this is done, modify the fw_cfg_init_io_dma() function, so that
it takes a new MemoryRegion* parameter called "parent_io". Update all
current call sites to pass in NULL, and fw_cfg_init_io_dma() should do
something like:

  io = parent_io ? parent_io : get_system_io();
  memory_region_add_subregion(io, s->iobase, &s->comb_iomem);
  if (s->dma_enabled) {
    memory_region_add_subregion(io, s->dma_iobase, s->dma_iomem);
  }


Basically, fix the QOM bug first, by moving the region mapping out of
the realize function, to the board helper function. Then modify the
board helper function so that board code can pass in the parent_io region.

This should be two small patches, and the rest should be possible to
drop, I think.

Then, in your sun4u series, you can simply remove

    fw_cfg = fw_cfg_init_io(BIOS_CFG_IOPORT);

and add

    fw_cfg = fw_cfg_init_io_dma(BIOS_CFG_IOPORT, 0, NULL,
                                pci_address_space_io(ebus));

... Upon re-reading your cover letter:

> As part of some ongoing sun4u work, I need to be able to wire the
> fw_cfg IO interface to a separate IO space by instantiating the qdev
> device instead of calling fw_cfg_init_io(). This patchset brings
> FW_CFG_IO in line with FW_CFG_MEM and tidies up the realize methods
> accordingly.

I agree that fw_cfg_init_io() should be synched with fw_cfg_init_mem(),
in that the region *mapping* should be moved from the realize function
to the board helper function.

Beyond that, I don't think that a whole lot of code movement /
reorganization is necessary. Simply empower the current board helper
function fw_cfg_init_io_dma() to take parent_io, and then use that from
sun4u board code.

Thanks
Laszlo
