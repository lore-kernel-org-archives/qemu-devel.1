Received: from eggs.gnu.org ([2001:4830:134:3::10]:39237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eo5xE-0006YX-Ez
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eo5x9-00074D-Ub
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:19:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eo5x9-00072I-LU
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:19:19 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1KBJ7vo100245
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 06:19:18 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g8hnq2nwj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 06:19:18 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 20 Feb 2018 11:19:16 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20180219174231.10874-1-david@redhat.com>
	<39db6736-b5c5-832f-ffef-1d0a59b85ac2@de.ibm.com>
Date: Tue, 20 Feb 2018 12:19:11 +0100
MIME-Version: 1.0
In-Reply-To: <39db6736-b5c5-832f-ffef-1d0a59b85ac2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a26b3e3c-d4ef-e389-34f8-2c0df754eeb4@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFCv2] s390x/sclp: remove memory hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>



On 02/20/2018 12:18 PM, Christian Borntraeger wrote:
> Given that we have trouble modeling this properly I somewhat like the idea.
> We should have never folded this into the common code memory hotplug 
> infrastructure as it is different. Instead we really should have provided
> a different interface and we should have build it with migration support. 
> 
> If we need it again in the future, we can certainly add it back via an 
> s390 specific interface.
> 
> 
> On 02/19/2018 06:42 PM, David Hildenbrand wrote:
>> From an architecture point of view, nothing can be mapped into the address
>> space on s390x. All there is is memory. Therefore there is also not really
>> an interface to communicate such information to the guest. All we can do is
>> specify the maximum ram address and guests can probe in that range if
>> memory is available and usable (TPROT).
>>
>> Also memory hotplug is strange. The guest can decide at some point in
>> time to add / remove memory in some range. And nobody can really hinder it
>> from doing so. So if we specify right now e.g.
>>     -m 2G,slots=2,maxmem=20G
>> An ordinary fedora guest will happily online (hotplug) all memory,
>> resulting in a guest consuming 20G. So it really behaves rather like
>>     -m 22G
>> There is no way to hotplug memory from the outside like on other
>> architectures. This is of course bad for upper management layers.
>>
>> As the guest can create/delete memory regions while it is running, of
>> course migration support is not available and tricky to implement.
>>
>> With virtualization, it is different. We might want to map something
>> into guest address space (e.g. fake DAX devices) and not detect it
>> automatically as memory. So we really want to use the maxmem and slots
>> parameter just like on all other architectures. Such devices will have
>> to expose the applicable memory range themselves. To finally be able to
>> provide memory hotplug to guests, we will need a new paravirtualized
>> interface to do that (e.g. something into the direction of virtio-mem).
>>
>> This implies, that maxmem cannot be used for s390x memory hotplug
>> anymore and has to go. This simplifies the code quite a bit.
>>
>> As migration support is not working, this change cannot really break
>> migration as guests without slots and maxmem don't see the SCLP
>> features. Also, the ram size calcualtion does not change.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> [...]
> 
> looks mostly sane. Give me some more time to review. 
> 
>> @@ -540,9 +302,6 @@ static void sclp_memory_init(SCLPDevice *sclp)
>>  {
>>      MachineState *machine = MACHINE(qdev_get_machine());
>>      ram_addr_t initial_mem = machine->ram_size;
>> -    ram_addr_t max_mem = machine->maxram_size;
>> -    ram_addr_t standby_mem = max_mem - initial_mem;
>> -    ram_addr_t pad_mem = 0;
>>      int increment_size = 20;
>>
>>      /* The storage increment size is a multiple of 1M and is a power of 2.
>> @@ -552,34 +311,14 @@ static void sclp_memory_init(SCLPDevice *sclp)
>>      while ((initial_mem >> increment_size) > MAX_STORAGE_INCREMENTS) {
>>          increment_size++;
>>      }
> 
> 
> In theory we could now be more fine grained (as we no longer expose the increments)
> but this would break migration so better try now to be clever. (e.g. with
> compat machines)
> 					try NOT of course.
