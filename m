Received: from eggs.gnu.org ([2001:4830:134:3::10]:37511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIybh-0005DL-RT
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIybc-0004JQ-Vm
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:40:17 -0400
References: <20170607083243.8983-1-aik@ozlabs.ru>
	<20170608074250.GE25805@umbus.fritz.box>
	<d414edd8-427e-1065-2e30-79a4e80be395@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34bb0e1c-a184-3a8c-0141-cb51e1b2de69@redhat.com>
Date: Thu, 8 Jun 2017 16:40:05 +0200
MIME-Version: 1.0
In-Reply-To: <d414edd8-427e-1065-2e30-79a4e80be395@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v7] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 08/06/2017 16:28, Alexey Kardashevskiy wrote:
>>> +void memory_region_init_iommu_type(const char *mrtypename,
>>> +                                   IOMMUMemoryRegion *iommu_mr,
>>> +                                   Object *owner,
>>> +                                   const MemoryRegionIOMMUOps *ops,
>>> +                                   const char *name,
>>> +                                   uint64_t size)
>>>  {
>>> -    memory_region_init(mr, owner, name, size);
>>> -    mr->iommu_ops =3D ops,
>>> +    struct MemoryRegion *mr;
>>> +    size_t instance_size =3D object_type_get_instance_size(mrtypenam=
e);
>>> +
>>> +    object_initialize(iommu_mr, instance_size, mrtypename);
>> This looks exceedingly dangerous.  AIUI, the entire purpose of the
>> size parameter to object_initialize() (which can certainly get the
>> instance size from the type, just as you do) is to verify that the
>> buffer you're initializing actually has space for the object type
>> you're putting there.
>>
>> By looking up the instance size yourself and passing it to
>> object_initialize(), you're disabling that check.
>>
>> If someone allocates an array of plain IOMMUMemoryRegion structures,
>> then uses this to initialize a derived IOMMU MR type with more fields,
>> the user will get no warning that something is wrong before the memory
>> corruption starts.
> Hm. How can I fix it then for a generic case? Pass the actual amount of
> bytes occupied by *iommu_mr?

Yes, like object_initialize.

Paolo
