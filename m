Received: from eggs.gnu.org ([2001:4830:134:3::10]:51958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fVRL8-0002yC-GV
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suratiamol@gmail.com>) id 1fVRL5-0001DP-DI
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 20:51:14 -0400
Date: Wed, 20 Jun 2018 06:23:19 +0530
From: Amol Surati <suratiamol@gmail.com>
Message-ID: <20180620005317.GA30916@arch>
References: <20180617183515.3982-1-suratiamol@gmail.com>
	<20180617183515.3982-2-suratiamol@gmail.com>
	<20180618180254.GA2441@arch>
	<d02a8fcd-3a5f-7c90-bef0-abf9ee076dd8@redhat.com>
	<20180619040153.GA8868@arch>
	<20180619085329.GA4292@dhcp-200-186.str.redhat.com>
	<834a13be-0b5c-1249-ad0a-1a1accb3e058@redhat.com>
	<20180619143401.GA27130@arch> <20180619212558.GA29939@arch>
	<d51751ed-3fec-f86b-fba1-737fac0997d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51751ed-3fec-f86b-fba1-737fac0997d4@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC 1/1] ide: bug #1777315:
 io_buffer_size and sg.size can represent partial sector sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Amol Surati <suratiamol@gmail.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>

On Tue, Jun 19, 2018 at 05:43:52PM -0400, John Snow wrote:
> 
> 
> On 06/19/2018 05:26 PM, Amol Surati wrote:
> > On Tue, Jun 19, 2018 at 08:04:03PM +0530, Amol Surati wrote:
> >> On Tue, Jun 19, 2018 at 09:45:15AM -0400, John Snow wrote:
> >>>
> >>>
> >>> On 06/19/2018 04:53 AM, Kevin Wolf wrote:
> >>>> Am 19.06.2018 um 06:01 hat Amol Surati geschrieben:
> >>>>> On Mon, Jun 18, 2018 at 08:14:10PM -0400, John Snow wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 06/18/2018 02:02 PM, Amol Surati wrote:
> >>>>>>> On Mon, Jun 18, 2018 at 12:05:15AM +0530, Amol Surati wrote:
> >>>>>>>> This patch fixes the assumption that io_buffer_size is always a perfect
> >>>>>>>> multiple of the sector size. The assumption is the cause of the firing
> >>>>>>>> of 'assert(n * 512 == s->sg.size);'.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Amol Surati <suratiamol@gmail.com>
> >>>>>>>> ---
> >>>>>>>
> >>>>>>> The repository https://github.com/asurati/1777315 contains a module for
> >>>>>>> QEMU's 8086:7010 ATA controller, which exercises the code path
> >>>>>>> described in [RFC 0/1] of this series.
> >>>>>>>
> >>>>>>
> >>>>>> Thanks, this made it easier to see what was happening. I was able to
> >>>>>> write an ide-test test case using this source as a guide, and reproduce
> >>>>>> the error.
> >>>>>>
> >>>>>> static void test_bmdma_partial_sector_short_prdt(void)
> >>>>>> {
> >>>>>>     QPCIDevice *dev;
> >>>>>>     QPCIBar bmdma_bar, ide_bar;
> >>>>>>     uint8_t status;
> >>>>>>
> >>>>>>     /* Read 2 sectors but only give 1 sector in PRDT */
> >>>>>>     PrdtEntry prdt[] = {
> >>>>>>         {
> >>>>>>             .addr = 0,
> >>>>>>             .size = cpu_to_le32(0x200),
> >>>>>>         },
> >>>>>>         {
> >>>>>>             .addr = 512,
> >>>>>>             .size = cpu_to_le32(0x44 | PRDT_EOT),
> >>>>>>         }
> >>>>>>     };
> >>>>>>
> >>>>>>     dev = get_pci_device(&bmdma_bar, &ide_bar);
> >>>>>>     status = send_dma_request(CMD_READ_DMA, 0, 2,
> >>>>>>                               prdt, ARRAY_SIZE(prdt), NULL);
> >>>>>>     g_assert_cmphex(status, ==, 0);
> >>>>>>     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
> >>>>>>     free_pci_device(dev);
> >>>>>> }
> >>>>>>
> >>>>>>> Loading the module reproduces the bug. Tested on the latest master
> >>>>>>> branch.
> >>>>>>>
> >>>>>>> Steps:
> >>>>>>> - Install a Linux distribution as a guest, ensuring that the boot disk
> >>>>>>>   resides on non-IDE controllers (such as virtio)
> >>>>>>> - Attach another disk as a master device on the primary
> >>>>>>>   IDE controller (i.e. attach at -hda.)
> >>>>>>> - Blacklist ata_piix, pata_acpi and ata_generic modules, and reboot.
> >>>>>>> - Copy the source files into the guest and build the module.
> >>>>>>> - Load the module. QEMU process should die with the message:
> >>>>>>>   qemu-system-x86_64: hw/ide/core.c:871: ide_dma_cb:
> >>>>>>>   Assertion `n * 512 == s->sg.size' failed.
> >>>>>>>
> >>>>>>>
> >>>>>>> -Amol
> >>>>>>>
> >>>>>>
> >>>>>> I'm less sure of the fix -- certainly the assert is wrong, but just
> >>>>>> incrementing 'n' is wrong too -- we didn't copy (n+1) sectors, we copied
> >>>>>> (n) and a few extra bytes.
> >>>>>
> >>>>> That is true.
> >>>>>
> >>>>> There are (at least) two fields that represent the total size of a DMA
> >>>>> transfer -
> >>>>> (1) The size, as requested through the NSECTOR field.
> >>>>> (2) The size, as calculated through the length fields of the PRD entries.
> >>>>>
> >>>>> It makes sense to consider the most restrictive of the sizes, as the factor
> >>>>> which determines both the end of a successful DMA transfer and the
> >>>>> condition to assert.
> >>>>>
> >>>>>>
> >>>>>> The sector-based math here would need to be adjusted to be able to cope
> >>>>>> with partial sector reads... or we ought to avoid doing any partial
> >>>>>> sector transfers.
> >>>>>>
> >>>>>>
> >>>>>> I'm not sure which is more correct tonight, it depends:
> >>>>>>
> >>>>>> - If it's OK to transfer partial sectors before reporting overflow,
> >>>>>> adjusting the command loop to work with partial sectors is OK.
> >>>>>>
> >>>>>> - If it's NOT OK to do partial sector transfer, the sglist preparation
> >>>>>> phase needs to produce a truncated SGList that's some multiple of 512
> >>>>>> bytes that leaves the excess bytes in a second sglist that we don't
> >>>>>> throw away and can use as a basis for building the next sglist. (Or the
> >>>>>> DMA helpers need to take a max_bytes parameter and return an sglist
> >>>>>> representing unused buffer space if the command underflowed.)
> >>>>>
> >>>>> Support for partial sector transfers is built into the DMA interface's PRD
> >>>>> mechanism itself, because an entry is allowed to transfer in the units of
> >>>>> even number of bytes.
> >>>>>
> >>>>> I think the controller's IO process runs in two parts (probably loops over
> >>>>> for a single transfer):
> >>>>>
> >>>>> (1) The controller's disk interface transfers between its internal buffer
> >>>>>     and the disk storage. The transfers are likely to be in the
> >>>>>     multiples of a sector.
> >>>>> (2) The controller's DMA interface transfers between its internal buffer
> >>>>>     and the system memory. The transfers can be sub-sector in size(, and
> >>>>>     are preserving of the areas, of the internal buffer, not subject to a
> >>>>>     write.)
> >>>>
> >>>> The spec isn't clear about this (or at least I can't find anything where
> >>>> the exact behaviour is specified), but I agree that that's my mental
> >>>> model as well. So I would make IDE send a byte-granularity request with
> >>>> the final partial sector to the block layer, so that the data is
> >>>> actually transferred up to that point.
> >>>>
> >>>> In practice it probably doesn't matter much because a too short PRDT
> >>>> means that the request doesn't complete successfully (the condition is
> >>>> indicated by clear Interrupt, Active and Error flags in the BMDMA
> >>>> controller) and I suppose the guest won't actually look at the data
> >>>> then.
> >>>>
> >>>> Providing the data anyway (consistent with our assumption how real
> >>>> hardware works) is erring on the safe side because it doesn't hurt a
> >>>> reasonable guest that did not expect the data to be transferred in this
> >>>> condition.
> >>>>
> >>>> Kevin
> >>>>
> >>>
> >>> Partial transfers it is, since I didn't see anything in AHCI or BMDMA
> >>> that suggested we shouldn't and it seems like the actual easiest fix
> >>> because it avoids having to modify the sglists or the sglist preparation
> >>> functions.
> >>>
> >>> Amol, would you like to author a fix, or would you prefer that I do it?
> >>
> >> Yes, I would like to author it. I assume that the simplification of the
> >> calls to prepare_buf is better kept as a change that is separate from
> >> this fix.
> >>
> >>>
> >>> If you do, please copy my ide-test case above and check it in as patch
> >>> 2/2 to your series as a regression test (tests/ide-test.c). It may need
> >>> some further editing after the command submission to pass; I only made
> >>> sure it crashes QEMU.
> >>
> >> Will do.
> >>
> >> Thanks,
> >> -amol
> >>
> >>>
> >>> Thanks,
> >>> --js
> > 
> > After ide_dma_cb checks the return value from prepare_buf, it comments
> > thus:
> > 
> > "The PRDs were too short. Reset the Active bit, but don't raise an
> > interrupt."
> > 
> > So, QEMU already has a policy in place for short PRDs. I apologize,
> > that I did not notice it earlier.
> > 
> 
> Any sane human would be forgiven for not being able to read this function.

:D

> 
> > It is enforced by the condition:
> > "(s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < 512)".
> > 
> > The definition of short PRDs it uses is: those which result in a
> > "< 512" bytes transfer.
> > 
> > Is there a reason to not define them, as those which result in a
> > "< n * 512" bytes transfer, to begin with (or now)?
> > > (n = s->nsector).
> 
> ide_dma_cb is written to possibly execute more than once per command. It
> tries to gather up what it can from prepare_buf, but as long as it gets
> ENOUGH sglist to transfer "at least one sector" it goes ahead with the
> read, under the idea that maybe when we return to ide_dma_cb, the next
> call to prepare_buf will give it more space to transfer the rest of the
> data to.
> 
> This is why it checks for < 512 instead of < (s->nsectors * 512).
> "As long as I can transfer a sector's worth, I can make progress on the
> command."
> 
> As we now know, this mechanism is faulty because we don't always build
> sglists that are multiples of 512. A way to fix this would be to use
> s->sg.size as an offset when building the next transfer instead of (n *
> 512).

Understood. For legacy or other reasons, QEMU supports piece-wise r/w
cmds, where each piece is assumed to be a multiple of a sector.

That requires maintaining state (such as bm->cur_addr) across multiple
calls to ide_dma_cb (and to prepare_buf) both inside QEMU (that is already
in place for those reasons) and inside the guest. That also requires
providing interrupts to signal state transitions. I am assuming such
transitions, since the design too does in some form.

> 
> However, I am pretty sure that for both pci bmdma and ahci, we are
> guaranteed to have the entire sglist from the guest before reaching
> ide_dma_cb, so we might be able to adjust this loop to understand that
> prepare_buf will never yield further results.
> 
> (...I think. I'm actually not confident, since I never wrote the
> original DMA loop. It looks right, though.)
> 
> In this case, you could just change the overflow condition to check for
> the entire transfer size and declare the overflow sooner instead of later.

To consider "< n * 512" as a fix, it is not necessary to look for the
guarantee of receiving the entire sglist in one go on the first call to
ide_dma_cb.

The legacy reasons are expected to behave consistently,
whether the guest provides one PRD per state transtion (or per call to
prepare_buf), or 2 PRDs per state transition, or all PRDs per state
transition. (I know there might not be such a guest, but QEMU does assume
its existence in its design.)

A guest does not expect differences in outward behaviour regardless
of the way it provides the PRDs.

Consider the example of a command that transfers 5 consecutive sectors.
Each line below represents a call to prepare_buf and its return value,
also indicating the number of PRD entries the call consumed and
their sizes.


E1:
---
512
512
512
128 <--- No interrupt, be inactive, 3 wasted transfers.
512
384


Next,
E2:
---
512+512=1024
512+128=640 <--- no 'short PRD', crash, but the same command as above.
512+384=896


Next,
E3:
---
512+512+512+128+512+384 <--- success, but the same command as above.


The behaviour is indeed guest-visibly inconsistent, but managable.

By fixing using s->sg.size as the offset for the next transfer, we bring
consistency to all 3 cases E1, E2 and E3, but also begin managing
granularity at 2-byte levels, and introduce extensive code changes.


By fixing through "< n * 512", 
- all instances of E2 (of which there has been only one reported) are
  included in the set E1, while
- E3 continues to succeed as before (since "< n * 512" is false for E3),
  and
- E1 continues to fail as before (since anything "< 512" is
  necessarily "< n * 512",assuming n >= 1 and no integer oveflows.)
There were already two types of instances before (E1 and E3); after this
fix, they still remain two in number.

For me, this line of reasoning is sufficient to go with the "< n * 512"
overflow fix. Let me know if there are objections - I am okay writing
either/both of the fixes. Apologies for this turn-about - I might have
spoken too soon in my earlier emails.

> 
> > 
> > If the prepare_buf interface implementation and use, that comment, and the
> > behaviour (drop and goto eot) which that comment points towards, are all
> > consistent with one another, then, the condition "< 512" looks like a bug
> > in itself, solving of which also solves this crash (hopefully, without
> > making any other change.)
> > 
> > Thanks,
> > -amol
> > 
