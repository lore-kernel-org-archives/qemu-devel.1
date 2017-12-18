Received: from eggs.gnu.org ([2001:4830:134:3::10]:48423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eQvtP-0008Vn-2O
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eQvtL-0005jb-Px
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:55:43 -0500
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:34197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eQvtL-0005hC-Et
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:55:39 -0500
Received: by mail-pf0-x232.google.com with SMTP id a90so9713130pfk.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 05:55:39 -0800 (PST)
References: <20171218040852.13478.19208.stgit@gimli.home>
	<20171218050253.13478.49457.stgit@gimli.home>
	<f76b5d78-0107-cca8-5e72-ab9944c8a90b@ozlabs.ru>
	<20171218062822.625b7469@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c472c115-3cfb-7ce0-62f3-13a026ccf02d@ozlabs.ru>
Date: Tue, 19 Dec 2017 00:55:32 +1100
MIME-Version: 1.0
In-Reply-To: <20171218062822.625b7469@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/RFT PATCH 5/5] vfio/pci: Allow relocating
 MSI-X MMIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com

On 19/12/17 00:28, Alex Williamson wrote:
> On Mon, 18 Dec 2017 20:04:23 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 18/12/17 16:02, Alex Williamson wrote:
>>> With recently proposed kernel side vfio-pci changes, the MSI-X vector
>>> table area can be mmap'd from userspace, allowing direct access to
>>> non-MSI-X registers within the host page size of this area.  However,
>>> we only get that direct access if QEMU isn't also emulating MSI-X
>>> within that same page.  For x86/64 host, the system page size is 4K
>>> and the PCI spec recommends a minimum of 4K to 8K alignment to
>>> separate MSI-X from non-MSI-X registers, therefore only devices which
>>> don't honor this recommendation would see any improvement from this
>>> option.  The real targets for this feature are hosts where the page
>>> size exceeds the PCI spec recommended alignment, such as ARM64 systems
>>> with 64K pages.
>>>
>>> This new x-msix-relocation option accepts the following options:
>>>
>>>   off: Disable MSI-X relocation, use native device config (default)
>>>   auto: Automaically relocate MSI-X MMIO to another BAR or offset
>>>        based on minimum additional MMIO requirement
>>>   bar0..bar5: Specify the target BAR, which will either be extended
>>>        if the BAR exists or added if the BAR slot is available.  
>>
>>
>> While I am digesting the patchset, here are some test results.
> 
> Thanks for testing!
> 
>> This is the device:
>>
>> 00:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS3008
>> PCI-Express Fusion-MPT SAS-3 (rev 02)
> 
> BAR1:
> 
>> Memory at 210000000000 (64-bit, non-prefetchable) [size=64K]
> 
> BAR3:
> 
>> Memory at 210000040000 (64-bit, non-prefetchable) [size=256K]
>>
>> Capabilities: [c0] MSI-X: Enable+ Count=96 Masked-
>>         Vector table: BAR=1 offset=0000e000
>>         PBA: BAR=1 offset=0000f000
>>
>>
>> Test #1: x-msix-relocation = "off":
>>
>> FlatView #1
>>  AS "memory", root: system
>>  AS "cpu-memory", root: system
>>  Root memory region: system
>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
>>   0000210000000000-000021000000dfff (prio 0, i/o): 0001:03:00.0 BAR 1
>>   000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
>>   000021000000e600-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
>> @000000000000e600
>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>
>> Ok, works.
>>
>>
>> Test #2: x-msix-relocation = "auto":
>>
>> FlatView #2
>>  AS "memory", root: system
>>  AS "cpu-memory", root: system
>>  Root memory region: system
>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
>>   0000200080000000-00002000800005ff (prio 0, i/o): msix-table
>>   0000200080000600-000020008000ffff (prio 1, i/o): 0001:03:00.0 base BAR 0
>> @0000000000000600
>>   0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>
>>
>> The guest fails probing because the first 64bit BAR is broken.
>>
>> lspci:
>>
>> Region 0: Memory at 200080000000 (32-bit, prefetchable) [size=64K]
>> Region 1: Memory at 210000000000 (64-bit, non-prefetchable) [size=64K]
>> Region 3: Memory at 210000040000 (64-bit, non-prefetchable) [size=256K]
>>
>> Capabilities: [c0] MSI-X: Enable- Count=96 Masked-
>>         Vector table: BAR=0 offset=00000000
>>         PBA: BAR=0 offset=00000600
> 
> Why do you suppose it's broken?  The added BAR0 is 32bit, it cannot be
> 64bit since BAR1 is implemented.  I don't see anything fundamentally
> different between this and the working BAR5 test below.


BAR1 (0x14..0x17) uses BAR0 (0x10..0x13) as upper 32bits when it is 64bit
BAR, no?


> 
>> Test #3: x-msix-relocation = "bar1"
>>
>>
>> FlatView #1
>>  AS "memory", root: system
>>  AS "cpu-memory", root: system
>>  Root memory region: system
>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
>>   0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
>>   0000210000010000-00002100000105ff (prio 0, i/o): msix-table
>>   0000210000010600-000021000001ffff (prio 1, i/o): 0001:03:00.0 base BAR 1
>> @0000000000010600
>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR 3 mmaps[0]
>>
>> Ok, works. BAR1 became 128K. However no part of BAR1 was mapped, i.e.
>> appear as "ramd" in flatview, should it have appeared?
>>
>> This is "mtree":
>>
>> memory-region: pci@800000020000000.mmio
>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio
>>     0000210000000000-000021000001ffff (prio 1, i/o): 0001:03:00.0 base BAR 1
>>       0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
>>       0000210000010000-00002100000105ff (prio 0, i/o): msix-table
>>       0000210000010600-000021000001060f (prio 0, i/o): msix-pba [disabled]
>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 base BAR 3
>>       0000210000040000-000021000007ffff (prio 0, i/o): 0001:03:00.0 BAR 3
>>         0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR
>> 3 mmaps[0]
> 
> Did you disable vfio_pci_fixup_msix_region() as noted in 0/5?  This
> series doesn't do anything about consuming the new MSI-X mappable flag
> that you introduced in the kernel, so vfio_pci_fixup_msix_region() will
> continue to exclude mmap'ing the 64K page overlapping the actual BAR.


Ah, my bad, I've read this but when I got to testing - forgot. Sorry for
the noise, tests 3 and 4 mmap as expected with fixup disabled.



-- 
Alexey
