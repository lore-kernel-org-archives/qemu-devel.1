Received: from eggs.gnu.org ([209.51.188.92]:36145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1guUKp-0008U6-K5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:38:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1guUKD-0001y6-L5
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:38:07 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1guUKC-0001oS-5f
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:38:04 -0500
Received: by mail-pf1-x441.google.com with SMTP id b7so4150082pfi.8
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 19:38:03 -0800 (PST)
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214052144.59541-3-aik@ozlabs.ru>
	<20190215033202.GH4573@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <50c941bc-8705-2519-737b-b688edfde395@ozlabs.ru>
Date: Fri, 15 Feb 2019 14:37:55 +1100
MIME-Version: 1.0
In-Reply-To: <20190215033202.GH4573@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2 2/4] vfio/spapr: Rename local
 systempagesize variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>



On 15/02/2019 14:32, David Gibson wrote:
> On Thu, Feb 14, 2019 at 04:21:42PM +1100, Alexey Kardashevskiy wrote:
>> The "systempagesize" name suggests that it is the host system page size
>> while it is the smallest page size of memory backing the guest RAM so
>> let's rename it to stop confusion. This should cause no behavioral change.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  hw/vfio/spapr.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
>> index 302d6b0..1498fee 100644
>> --- a/hw/vfio/spapr.c
>> +++ b/hw/vfio/spapr.c
>> @@ -148,14 +148,14 @@ int vfio_spapr_create_window(VFIOContainer *container,
>>      uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
>>      unsigned entries, bits_total, bits_per_level, max_levels;
>>      struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
>> -    long systempagesize = qemu_getrampagesize();
>> +    long minpagesize = qemu_getrampagesize();
> 
> I'd prefer "rampagesize" or "minrampagesize" here.  "minpagesize"
> doesn't make it clear what it's the minimum of, whereas rampagesize at
> least makes it clear it's the same thing that qemu_getrampagesize() is
> working with.

In my mind "ram" in this context is a guest RAM but here is it not (is
is backend) so I just avoided using any specifics in the name (system,
ram) to make the reader of this code look around where the value comes
from which is the qemu_getrampagesize() helper (more descriptive name).



> 
>>      /*
>>       * The host might not support the guest supported IOMMU page size,
>>       * so we will use smaller physical IOMMU pages to back them.
>>       */
>> -    if (pagesize > systempagesize) {
>> -        pagesize = systempagesize;
>> +    if (pagesize > minpagesize) {
>> +        pagesize = minpagesize;
>>      }
>>      pagesize = 1ULL << (63 - clz64(container->pgsizes &
>>                                     (pagesize | (pagesize - 1))));
> 

-- 
Alexey
