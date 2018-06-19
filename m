Received: from eggs.gnu.org ([2001:4830:134:3::10]:60617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fV4Hp-0005LH-Rx
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fV4Ho-0001Rl-Kv
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:14:17 -0400
References: <20180617183515.3982-1-suratiamol@gmail.com>
	<20180617183515.3982-2-suratiamol@gmail.com>
	<20180618180254.GA2441@arch>
From: John Snow <jsnow@redhat.com>
Message-ID: <d02a8fcd-3a5f-7c90-bef0-abf9ee076dd8@redhat.com>
Date: Mon, 18 Jun 2018 20:14:10 -0400
MIME-Version: 1.0
In-Reply-To: <20180618180254.GA2441@arch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/1] ide: bug #1777315: io_buffer_size and
 sg.size can represent partial sector sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amol Surati <suratiamol@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:IDE" <qemu-block@nongnu.org>



On 06/18/2018 02:02 PM, Amol Surati wrote:
> On Mon, Jun 18, 2018 at 12:05:15AM +0530, Amol Surati wrote:
>> This patch fixes the assumption that io_buffer_size is always a perfect
>> multiple of the sector size. The assumption is the cause of the firing
>> of 'assert(n * 512 == s->sg.size);'.
>>
>> Signed-off-by: Amol Surati <suratiamol@gmail.com>
>> ---
> 
> The repository https://github.com/asurati/1777315 contains a module for
> QEMU's 8086:7010 ATA controller, which exercises the code path
> described in [RFC 0/1] of this series.
> 

Thanks, this made it easier to see what was happening. I was able to
write an ide-test test case using this source as a guide, and reproduce
the error.

static void test_bmdma_partial_sector_short_prdt(void)
{
    QPCIDevice *dev;
    QPCIBar bmdma_bar, ide_bar;
    uint8_t status;

    /* Read 2 sectors but only give 1 sector in PRDT */
    PrdtEntry prdt[] = {
        {
            .addr = 0,
            .size = cpu_to_le32(0x200),
        },
        {
            .addr = 512,
            .size = cpu_to_le32(0x44 | PRDT_EOT),
        }
    };

    dev = get_pci_device(&bmdma_bar, &ide_bar);
    status = send_dma_request(CMD_READ_DMA, 0, 2,
                              prdt, ARRAY_SIZE(prdt), NULL);
    g_assert_cmphex(status, ==, 0);
    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
    free_pci_device(dev);
}

> Loading the module reproduces the bug. Tested on the latest master
> branch.
> 
> Steps:
> - Install a Linux distribution as a guest, ensuring that the boot disk
>   resides on non-IDE controllers (such as virtio)
> - Attach another disk as a master device on the primary
>   IDE controller (i.e. attach at -hda.)
> - Blacklist ata_piix, pata_acpi and ata_generic modules, and reboot.
> - Copy the source files into the guest and build the module.
> - Load the module. QEMU process should die with the message:
>   qemu-system-x86_64: hw/ide/core.c:871: ide_dma_cb:
>   Assertion `n * 512 == s->sg.size' failed.
> 
> 
> -Amol
> 

I'm less sure of the fix -- certainly the assert is wrong, but just
incrementing 'n' is wrong too -- we didn't copy (n+1) sectors, we copied
(n) and a few extra bytes.

The sector-based math here would need to be adjusted to be able to cope
with partial sector reads... or we ought to avoid doing any partial
sector transfers.


I'm not sure which is more correct tonight, it depends:

- If it's OK to transfer partial sectors before reporting overflow,
adjusting the command loop to work with partial sectors is OK.

- If it's NOT OK to do partial sector transfer, the sglist preparation
phase needs to produce a truncated SGList that's some multiple of 512
bytes that leaves the excess bytes in a second sglist that we don't
throw away and can use as a basis for building the next sglist. (Or the
DMA helpers need to take a max_bytes parameter and return an sglist
representing unused buffer space if the command underflowed.)



(As an aside to myself here, I'm not sure if there are any cases in
which multiple calls to prepare_buf will ever be productive: I think
both for PCI BMDMA and AHCI we have the entire PRDT if we've made it
this far and won't "find more" space to DMA to. Maybe I can simplify
this loop and make decisions on underflow/overflow after a single call
to prepare_buf.)


I'll try to prepare a patch soon.

--js
