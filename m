Received: from eggs.gnu.org ([2001:4830:134:3::10]:33095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eoooi-00044u-U0
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eooof-0007IT-NG
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:13:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eooof-0007Hs-Ev
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 06:13:33 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1MBB34D079512
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:13:32 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g9u2u4hwf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 06:13:31 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 22 Feb 2018 11:13:28 -0000
References: <20180219174231.10874-1-david@redhat.com>
	<493dbfb3-086b-cc89-2d8d-4298345c6bb2@de.ibm.com>
	<ef55dc18-971f-b012-40cc-0c32f24664cf@redhat.com>
	<20180220155759.17dfd955.cohuck@redhat.com>
	<aeb36cb1-aadf-6146-9e59-549998538db1@redhat.com>
	<20180221183918.7cc4fad1.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 22 Feb 2018 12:13:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180221183918.7cc4fad1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <635dc4c5-8b54-9903-334c-d07cbc0d27f6@de.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>



On 02/21/2018 06:39 PM, Cornelia Huck wrote:
> On Tue, 20 Feb 2018 16:05:54 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 20.02.2018 15:57, Cornelia Huck wrote:
>>> On Tue, 20 Feb 2018 13:16:37 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> On 20.02.2018 13:05, Christian Borntraeger wrote:  
>>>>>
>>>>>
>>>>> On 02/19/2018 06:42 PM, David Hildenbrand wrote:    
>>>>>> From an architecture point of view, nothing can be mapped into the address
>>>>>> space on s390x. All there is is memory. Therefore there is also not really
>>>>>> an interface to communicate such information to the guest. All we can do is
>>>>>> specify the maximum ram address and guests can probe in that range if
>>>>>> memory is available and usable (TPROT).    
>>>>>
>>>>> In fact there is an interface in SCLP that describes the memory sizes (maximum in 
>>>>> read scp info) and the details (read_storage_element0_info).  I am asking myself
>>>>> if we should re-introduce read_storage_element_info and use that to avoid tprot    
>>>>
>>>> Yes, we could do that (basically V1 of this patch) but have to glue it
>>>> to the a compatibility machine then.  
>>>
>>> Actually, this makes quite a bit of sense (introduce the interface for
>>> everyone in 2.12 and turn it off in compat machines).  
>>
>> Jup, either 2.12 or 2.13, no need to hurry.
>>
>>>
>>> Does real hardware have configurations where you can get the memory
>>> sizes, but not the attach/deattach support? (Hardware with the feature,
>>> but no standby memory defined?)  

We have different sclp facilities for attach/detach and information, so
we can implement that. 


>>
>> I would guess that "0" for standby memory is valid but only people with
>> access to documentation can answer that :)
> 
> So, should we go with this patch now and re-introduce the read
> functions if the above is indeed true?

Yes, go with this patch. Right now Linux guests will not make use of that, so
we can re-add that if it turns out to be useful for future guests.



Matt, last chance to complain with reasons why we want to keep the current standby memory
solution in its current form. (Or please ack the patch if you agree)
