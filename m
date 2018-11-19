Received: from eggs.gnu.org ([2001:4830:134:3::10]:37286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gOcTk-0003rg-BS
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 00:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gOcTg-000275-AQ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 00:52:12 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gOcTf-00023Y-Rv
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 00:52:08 -0500
Received: by mail-pl1-x641.google.com with SMTP id b22-v6so8584531pls.7
	for <qemu-devel@nongnu.org>; Sun, 18 Nov 2018 21:52:04 -0800 (PST)
References: <20181113083104.2692-1-aik@ozlabs.ru>
	<20181113083104.2692-2-aik@ozlabs.ru> <20181119014513.GC23503@umbus>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <88143ae6-3d62-5ee4-96a7-e383bfe42859@ozlabs.ru>
Date: Mon, 19 Nov 2018 16:51:57 +1100
MIME-Version: 1.0
In-Reply-To: <20181119014513.GC23503@umbus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu RFC 1/7] vfio/spapr: Fix indirect
 levels calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alistair Popple <alistair@popple.id.au>, Reza Arbab <arbab@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, Oliver O'Halloran <oohall@gmail.com>



On 19/11/2018 12:45, David Gibson wrote:
> On Tue, Nov 13, 2018 at 07:30:58PM +1100, Alexey Kardashevskiy wrote:
>> The current code assumes that we can address more bits on a PCI bus
>> for DMA than we really can. Limit to the known tested maximum of 55 bits
>> and assume 64K IOMMU pages.
> 
> This doesn't make much sense to me.  It looks nothing like the
> calculation it's replacing, and not just for extreme values.  For
> example the new calculation doesn't depend on the size of the window
> at all, whereas the previous one did.

Uff. Yes, this is confusing. There are a typical 64k IOMMU page size and
a typical 64k system page size...

For the window as big as 0x200.0000.0000 and 64k pages (actual working
example), 33554432 entries are needed, or 256MB of space. The existing
code calculates it as 25/6+1=5 levels. Which the hardware can do.

But:
1. all TCE levels are the same size and
2. for the minimum size of the level I take a system page size which is 64k.

So with 5 levels 16bit each (and this is without counting IOMMU page
size, which is plus extra 16 bits) the table is huuuge.

And I know from tests that 55 bits is the maximum the hardware can
handle, and I have this limit in the powernv code so VFIO ioctl to
create a window will fail. If I do not have a check in powernv, than
things silently do not work (no EEH though).


> You say you're assuming 64k
> IOMMU pages, but create.page_shift (the actual IOMMU page size) is in
> there. 

It is a radix tree basically. Out of 64bits available, I cannot use bits
56..63 (hardware does not work) and 0..12/15/21 (IOMMU page size), so I
have bits 13/16/22..55 which I need to split equally between levels,
each of which is 64k (system page size).


> Nor is it clear to me why the maximum PCI address is relevant
> to the number of levels in the first place.


The window can only as big as the PHB hardware supports, this is why
maximum PCI address.


> 
> In addition, AFAICT the new calculation gives the answer '2' for all
> likely IOMMU page sizes (4k, 64k, 2M)

Hm, I did not realize that :) Instead of using 64k as a default level
size, I could use some idea of what CONFIG_FORCE_MAX_ZONEORDER could be.

Currently it is:

arch/powerpc/Kconfig
config FORCE_MAX_ZONEORDER
        int "Maximum zone order"
        range 8 9 if PPC64 && PPC_64K_PAGES
        default "9" if PPC64 && PPC_64K_PAGES
        range 13 13 if PPC64 && !PPC_64K_PAGES
        default "13" if PPC64 && !PPC_64K_PAGES
        range 9 64 if PPC32 && PPC_16K_PAGES
        default "9" if PPC32 && PPC_16K_PAGES
        range 7 64 if PPC32 && PPC_64K_PAGES
        default "7" if PPC32 && PPC_64K_PAGES
        range 5 64 if PPC32 && PPC_256K_PAGES
        default "5" if PPC32 && PPC_256K_PAGES
        range 11 64
        default "11"

So assuming that "8" is the absolute minimum, I could try levels as big
as 1<<(16+8-1) and if this fails, then increase the number of levels
till a window is created or it is too many levels. Or there is some
obviously better solution to the problem?





> 
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  hw/vfio/spapr.c      | 3 ++-
>>  hw/vfio/trace-events | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>> index becf71a..f5fdc53 100644
>> --- a/hw/vfio/spapr.c
>> +++ b/hw/vfio/spapr.c
>> @@ -183,7 +183,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>>      entries = create.window_size >> create.page_shift;
>>      pages = MAX((entries * sizeof(uint64_t)) / getpagesize(), 1);
>>      pages = MAX(pow2ceil(pages), 1); /* Round up */
>> -    create.levels = ctz64(pages) / 6 + 1;
>> +    create.levels = MAX(1, (55 - create.page_shift) / 16);
>>  
>>      ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
>>      if (ret) {
>> @@ -200,6 +200,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>>          return -EINVAL;
>>      }
>>      trace_vfio_spapr_create_window(create.page_shift,
>> +                                   create.levels,
>>                                     create.window_size,
>>                                     create.start_addr);
>>      *pgsize = pagesize;
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index a85e866..db730f3 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -128,6 +128,6 @@ vfio_prereg_listener_region_add_skip(uint64_t start, uint64_t end) "0x%"PRIx64"
>>  vfio_prereg_listener_region_del_skip(uint64_t start, uint64_t end) "0x%"PRIx64" - 0x%"PRIx64
>>  vfio_prereg_register(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
>>  vfio_prereg_unregister(uint64_t va, uint64_t size, int ret) "va=0x%"PRIx64" size=0x%"PRIx64" ret=%d"
>> -vfio_spapr_create_window(int ps, uint64_t ws, uint64_t off) "pageshift=0x%x winsize=0x%"PRIx64" offset=0x%"PRIx64
>> +vfio_spapr_create_window(int ps, unsigned int levels, uint64_t ws, uint64_t off) "pageshift=0x%x levels=%u winsize=0x%"PRIx64" offset=0x%"PRIx64
>>  vfio_spapr_remove_window(uint64_t off) "offset=0x%"PRIx64
>>  vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
> 

-- 
Alexey
