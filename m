Received: from eggs.gnu.org ([2001:4830:134:3::10]:56574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fVGwz-0006U9-Vg
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fVGwv-00070T-D4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:45:37 -0400
References: <20180617183515.3982-1-suratiamol@gmail.com>
	<20180617183515.3982-2-suratiamol@gmail.com>
	<20180618180254.GA2441@arch>
	<d02a8fcd-3a5f-7c90-bef0-abf9ee076dd8@redhat.com>
	<20180619040153.GA8868@arch>
	<20180619085329.GA4292@dhcp-200-186.str.redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <834a13be-0b5c-1249-ad0a-1a1accb3e058@redhat.com>
Date: Tue, 19 Jun 2018 09:45:15 -0400
MIME-Version: 1.0
In-Reply-To: <20180619085329.GA4292@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Kevin Wolf <kwolf@redhat.com>, Amol Surati <suratiamol@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>



On 06/19/2018 04:53 AM, Kevin Wolf wrote:
> Am 19.06.2018 um 06:01 hat Amol Surati geschrieben:
>> On Mon, Jun 18, 2018 at 08:14:10PM -0400, John Snow wrote:
>>>
>>>
>>> On 06/18/2018 02:02 PM, Amol Surati wrote:
>>>> On Mon, Jun 18, 2018 at 12:05:15AM +0530, Amol Surati wrote:
>>>>> This patch fixes the assumption that io_buffer_size is always a perfect
>>>>> multiple of the sector size. The assumption is the cause of the firing
>>>>> of 'assert(n * 512 == s->sg.size);'.
>>>>>
>>>>> Signed-off-by: Amol Surati <suratiamol@gmail.com>
>>>>> ---
>>>>
>>>> The repository https://github.com/asurati/1777315 contains a module for
>>>> QEMU's 8086:7010 ATA controller, which exercises the code path
>>>> described in [RFC 0/1] of this series.
>>>>
>>>
>>> Thanks, this made it easier to see what was happening. I was able to
>>> write an ide-test test case using this source as a guide, and reproduce
>>> the error.
>>>
>>> static void test_bmdma_partial_sector_short_prdt(void)
>>> {
>>>     QPCIDevice *dev;
>>>     QPCIBar bmdma_bar, ide_bar;
>>>     uint8_t status;
>>>
>>>     /* Read 2 sectors but only give 1 sector in PRDT */
>>>     PrdtEntry prdt[] = {
>>>         {
>>>             .addr = 0,
>>>             .size = cpu_to_le32(0x200),
>>>         },
>>>         {
>>>             .addr = 512,
>>>             .size = cpu_to_le32(0x44 | PRDT_EOT),
>>>         }
>>>     };
>>>
>>>     dev = get_pci_device(&bmdma_bar, &ide_bar);
>>>     status = send_dma_request(CMD_READ_DMA, 0, 2,
>>>                               prdt, ARRAY_SIZE(prdt), NULL);
>>>     g_assert_cmphex(status, ==, 0);
>>>     assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
>>>     free_pci_device(dev);
>>> }
>>>
>>>> Loading the module reproduces the bug. Tested on the latest master
>>>> branch.
>>>>
>>>> Steps:
>>>> - Install a Linux distribution as a guest, ensuring that the boot disk
>>>>   resides on non-IDE controllers (such as virtio)
>>>> - Attach another disk as a master device on the primary
>>>>   IDE controller (i.e. attach at -hda.)
>>>> - Blacklist ata_piix, pata_acpi and ata_generic modules, and reboot.
>>>> - Copy the source files into the guest and build the module.
>>>> - Load the module. QEMU process should die with the message:
>>>>   qemu-system-x86_64: hw/ide/core.c:871: ide_dma_cb:
>>>>   Assertion `n * 512 == s->sg.size' failed.
>>>>
>>>>
>>>> -Amol
>>>>
>>>
>>> I'm less sure of the fix -- certainly the assert is wrong, but just
>>> incrementing 'n' is wrong too -- we didn't copy (n+1) sectors, we copied
>>> (n) and a few extra bytes.
>>
>> That is true.
>>
>> There are (at least) two fields that represent the total size of a DMA
>> transfer -
>> (1) The size, as requested through the NSECTOR field.
>> (2) The size, as calculated through the length fields of the PRD entries.
>>
>> It makes sense to consider the most restrictive of the sizes, as the factor
>> which determines both the end of a successful DMA transfer and the
>> condition to assert.
>>
>>>
>>> The sector-based math here would need to be adjusted to be able to cope
>>> with partial sector reads... or we ought to avoid doing any partial
>>> sector transfers.
>>>
>>>
>>> I'm not sure which is more correct tonight, it depends:
>>>
>>> - If it's OK to transfer partial sectors before reporting overflow,
>>> adjusting the command loop to work with partial sectors is OK.
>>>
>>> - If it's NOT OK to do partial sector transfer, the sglist preparation
>>> phase needs to produce a truncated SGList that's some multiple of 512
>>> bytes that leaves the excess bytes in a second sglist that we don't
>>> throw away and can use as a basis for building the next sglist. (Or the
>>> DMA helpers need to take a max_bytes parameter and return an sglist
>>> representing unused buffer space if the command underflowed.)
>>
>> Support for partial sector transfers is built into the DMA interface's PRD
>> mechanism itself, because an entry is allowed to transfer in the units of
>> even number of bytes.
>>
>> I think the controller's IO process runs in two parts (probably loops over
>> for a single transfer):
>>
>> (1) The controller's disk interface transfers between its internal buffer
>>     and the disk storage. The transfers are likely to be in the
>>     multiples of a sector.
>> (2) The controller's DMA interface transfers between its internal buffer
>>     and the system memory. The transfers can be sub-sector in size(, and
>>     are preserving of the areas, of the internal buffer, not subject to a
>>     write.)
> 
> The spec isn't clear about this (or at least I can't find anything where
> the exact behaviour is specified), but I agree that that's my mental
> model as well. So I would make IDE send a byte-granularity request with
> the final partial sector to the block layer, so that the data is
> actually transferred up to that point.
> 
> In practice it probably doesn't matter much because a too short PRDT
> means that the request doesn't complete successfully (the condition is
> indicated by clear Interrupt, Active and Error flags in the BMDMA
> controller) and I suppose the guest won't actually look at the data
> then.
> 
> Providing the data anyway (consistent with our assumption how real
> hardware works) is erring on the safe side because it doesn't hurt a
> reasonable guest that did not expect the data to be transferred in this
> condition.
> 
> Kevin
> 

Partial transfers it is, since I didn't see anything in AHCI or BMDMA
that suggested we shouldn't and it seems like the actual easiest fix
because it avoids having to modify the sglists or the sglist preparation
functions.

Amol, would you like to author a fix, or would you prefer that I do it?

If you do, please copy my ide-test case above and check it in as patch
2/2 to your series as a regression test (tests/ide-test.c). It may need
some further editing after the command submission to pass; I only made
sure it crashes QEMU.

Thanks,
--js
