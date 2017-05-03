Received: from eggs.gnu.org ([2001:4830:134:3::10]:34617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d5j2l-0008B1-Fm
	for qemu-devel@nongnu.org; Tue, 02 May 2017 21:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d5j2i-0000Su-AZ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 21:25:27 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1d5j2i-0000Sj-1j
	for qemu-devel@nongnu.org; Tue, 02 May 2017 21:25:24 -0400
Received: by mail-pf0-x241.google.com with SMTP id g23so1816415pfj.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 18:25:23 -0700 (PDT)
References: <20170429123707.16675-1-aik@ozlabs.ru>
	<20170502182550.5edb9565.cornelia.huck@de.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <e6d90400-3bcd-77c5-dbe6-24dc14d6bcd3@ozlabs.ru>
Date: Wed, 3 May 2017 11:25:16 +1000
MIME-Version: 1.0
In-Reply-To: <20170502182550.5edb9565.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v5] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 03/05/17 02:25, Cornelia Huck wrote:
> On Sat, 29 Apr 2017 22:37:07 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
>> as a parent.
>>
>> This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
>> dymanic QOM casting in fast path (address_space_translate, etc),
>> this adds an @is_iommu boolean flag to MR and provides new helper to
>> do simple cast to IOMMU MR - memory_region_get_iommu. The flag
>> is set in the instance init callback. This defines
>> memory_region_is_iommu as memory_region_get_iommu()!=NULL.
>>
>> This switches MemoryRegion to IOMMUMemoryRegion in most places except
>> the ones where MemoryRegion may be an alias.
>>
>> This defines memory_region_init_iommu_type() to allow creating
>> IOMMUMemoryRegion subclasses. In order to support custom QOM type,
>> this splits memory_region_init() to object_initialize() +
>> memory_region_do_init.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
>>  /**
>> + * memory_region_init_iommu_type: Initialize a memory region of a custom type
>> + * that translates addresses
>> + *
>> + * An IOMMU region translates addresses and forwards accesses to a target
>> + * memory region.
>> + *
>> + * @typename: QOM class name
>> + * @iommumr: the #IOMMUMemoryRegion to be initialized
> 
> <bikeshed>
> I find "iommumr" terribly hard to read. Maybe iommu_mr is better? (Lots
> of times in this patch.)
> </bikeshed>

Terribly? Really? :) Seriously, since linux uses underscores in typenames,
I kind of developed resistance to underscores in variable names which look
like typenames (even though c allows using same token for a type and a
variable). May be just "iommu"? I need one more vote for "iommu" vs.
"iommumr" vs. "iommu_mr" to respin v6 :)


> 
> The s390 parts look fine.
> 


-- 
Alexey
