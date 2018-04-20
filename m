Received: from eggs.gnu.org ([2001:4830:134:3::10]:52711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f9QF9-0000St-9U
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f9QF6-000630-95
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:14:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60090
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f9QF6-000625-25
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:14:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3K75ciH100191
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 03:13:59 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hf8g2euug-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 03:13:58 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 20 Apr 2018 08:13:56 +0100
References: <20180419072123.682-1-david@gibson.dropbear.id.au>
	<20180419143318.4e24edaf@redhat.com>
	<20180419145840.324602ff.cohuck@redhat.com>
	<77d0717b-6eba-8b20-6691-c3085937604b@de.ibm.com>
	<065165b5-3ab4-ae1a-f72c-c04f911656c3@redhat.com>
	<20180419180851.461a0db3@bahia.lan>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 20 Apr 2018 09:13:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180419180851.461a0db3@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4256dc8e-7f9d-1ba6-ea82-b04c8095f801@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-2.13] Clear mem_path if we
 fall back to anonymous RAM allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, pbonzini@redhat.com



On 04/19/2018 06:08 PM, Greg Kurz wrote:
> On Thu, 19 Apr 2018 16:11:37 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 19.04.2018 15:34, Christian Borntraeger wrote:
>>>
>>>
>>> On 04/19/2018 02:58 PM, Cornelia Huck wrote:  
>>>> On Thu, 19 Apr 2018 14:33:18 +0200
>>>> Igor Mammedov <imammedo@redhat.com> wrote:
>>>>  
>>>>> On Thu, 19 Apr 2018 17:21:23 +1000
>>>>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>>>>  
>>>>>> If the -mem-path option is set, we attempt to map the guest's RAM from a
>>>>>> file in the given path; it's usually used to back guest RAM with hugepages.
>>>>>> If we're unable to (e.g. not enough free hugepages) then we fall back to
>>>>>> allocating normal anonymous pages.  This behaviour can be surprising, but a
>>>>>> comment in allocate_system_memory_nonnuma() suggests it's legacy behaviour
>>>>>> we can't change.
>>>>>>
>>>>>> What really isn't ok, though, is that in this case we leave mem_path set.
>>>>>> That means functions which attempt to determine the pagesize of main RAM
>>>>>> can erroneously think it is hugepage based on the requested path, even
>>>>>> though it's not.
>>>>>>
>>>>>> This is particular bad for the pseries machine type.  KVM HV limitations
>>>>>> mean the guest can't use pagesizes larger than the host page size used to
>>>>>> back RAM.  That means that such a fallback, rather than merely giving
>>>>>> poorer performance that expected will cause the guest to freeze up early in
>>>>>> boot as it attempts to use large page mappings that can't work.
>>>>>>
>>>>>> This patch addresses the problem by clearing the mem_path variable when we
>>>>>> fall back to anonymous pages, meaning that subsequent attempts to
>>>>>> determine the RAM page size will get an accurate result.
>>>>>>
>>>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>>>> ---
>>>>>>  numa.c | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> Paolo et al, as with my earlier patches adding some extensions to the
>>>>>> helpers for determining backing page sizes, if there are no objections
>>>>>> can I get an ack to merge this via my ppc tree?
>>>>>>
>>>>>> diff --git a/numa.c b/numa.c
>>>>>> index 1116c90af9..78a869e598 100644
>>>>>> --- a/numa.c
>>>>>> +++ b/numa.c
>>>>>> @@ -469,6 +469,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>>>>>>              /* Legacy behavior: if allocation failed, fall back to
>>>>>>               * regular RAM allocation.
>>>>>>               */
>>>>>> +            mem_path = NULL;
>>>>>>              memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error_fatal);
>>>>>>          }
>>>>>>  #else    
>>>>>
>>>>> mem_path is also used by kvm_s390_apply_cpu_model(),
>>>>> and in ccw_init() memory is initialized before CPUs are
> 
> Something similar happens with spapr: kvm_fixup_page_sizes() calls
> qemu_getrampagesize() during CPU start, which happens before the machine
> init calls allocate_system_memory_nonnuma(). Shouldn't we allocate memory
> before calling spapr_init_cpus() in spapr_machine_init() then ?
> 
>>>>> so if QEM was started with -mem-path, then before patch
>>>>> created CPU won't have CMM enabled and print warning:
>>>>>   
>>>>>  "CMM will not be enabled because it is not compatible with hugetlbfs."
>>>>>
>>>>> and after patch it might enable CMM if we clear mem_path.
>>>>> So question is do we care about this?  
>>>>
>>>> I don't quite remember the cmm semantics here -- Christian?  
>>>
>>> The CMMA interface does not work on large pages. I think the kernel will react
>>> with EFAULT in some cases (cmma migration and others) so qemu will probably fail
>>> unexpectedly. 
>>>
>>> But this patch seems to only clear mem-path if we do not allocate at all from
>>> hugetlbfs. So things should be ok, no?
>>>
>>>   
>>
>> This even looks like the right thing to me, as hugetlbfs was never
>> supported.
>>
> 
> Unrelated to this patch, -mem-path can be passed something that doesn't sit
> in a hugetlbfs, in which case we use getpagesize()... is there a reason for
> kvm_s390_enable_cmma() to filter out this case as well ? Or should we rather
> check mem_path isn't NULL and points to a hugetlbfs ?

cmm is somewhat special, so I prefer to have it only for non-mem-path memory
since I know that it works for anonymous pages. I would rather white list other
mechanisms if necessary in the future.
backings
