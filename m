Received: from eggs.gnu.org ([2001:4830:134:3::10]:50040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eR9Jb-0005Ts-Sk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eR9JY-0002w8-E0
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:15:39 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eR9JY-0002uv-3i
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:15:36 -0500
Received: by mail-pf0-x244.google.com with SMTP id y89so10663121pfk.0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 20:15:36 -0800 (PST)
References: <20171218040852.13478.19208.stgit@gimli.home>
	<20171218050229.13478.65667.stgit@gimli.home>
	<d6bf4252-7138-b0cd-cc84-ad05a7ecc5f3@ozlabs.ru>
	<20171218205633.27ed0ee0@w520.home>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <3922d907-d4a3-9332-b69e-e3702a8aa0e6@ozlabs.ru>
Date: Tue, 19 Dec 2017 15:15:31 +1100
MIME-Version: 1.0
In-Reply-To: <20171218205633.27ed0ee0@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/RFT PATCH 2/5] vfio/pci: Add base BAR
 MemoryRegion
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

On 19/12/17 14:56, Alex Williamson wrote:
> On Tue, 19 Dec 2017 14:44:51 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 18/12/17 16:02, Alex Williamson wrote:
>>> Add one more layer to our stack of MemoryRegions, this base region
>>> allows us to register BARs independently of the vfio region or to
>>> extend the size of BARs which do map to a region.  This will be
>>> useful when we want hypervisor defined BARs or sections of BARs,
>>> for purposes such as relocating MSI-X emulation.  We therefore call
>>> msix_init() based on this new base MemoryRegion, while the quirks,
>>> which only modify regions still operate on those sub-MemoryRegions.  
>>
>>
>> Looks ok, one worry though - the default config produces this:
>>
>>
>> memory-region: pci@800000020000000.mmio
>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@800000020000000.mmio
>>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 base BAR 1
>>       0000210000000000-000021000000ffff (prio 0, i/o): 0001:03:00.0 BAR 1
>>       000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
>>       000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [disabled]
>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 base BAR 3
>>       0000210000040000-000021000007ffff (prio 0, i/o): 0001:03:00.0 BAR 3
>>         0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR
>> 3 mmaps[0]
>>
>>
>> Where "BAR 1" and "msix-table" overlap. It resolves correctly:
>>
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
>>
>> but this looks like an accident - should not we raise the msix-table
>> priority or lower the BAR1 priority (to -1)?
> 
> I was worried about this too, but the way I read the code is that the
> last registered subregion with the same priority wins.  Therefore so
> long as msix_init() is called after we layer anything else onto the base
> BAR MemoryRegion that might interfere with it, everything should work
> correctly.  It certainly might make sense for msix_init() to add
> subregions with a higher priority, but then you immediately get into
> the road block of what priority should it use, which is a bit of a rat
> hole since we can make it work as-is with proper ordering.

The order is not obvious from any variant of "info mtree" (I may post a
patch with a "-u" switch to disable sorting).

And docs/devel/memory.txt allows using negative priorities so the "BAR 1"
region could have -1 to make things predictable and more self-documented imho.



>  Thanks,
> 
> Alex
> 


-- 
Alexey
