Received: from eggs.gnu.org ([2001:4830:134:3::10]:57915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eP3uo-0004kv-KI
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eP3ui-0000Cp-Ho
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:05:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eP3ui-0000Bo-8D
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:05:20 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBDA4n9Z042340
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 05:05:18 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2etyk76wd1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 05:05:18 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 13 Dec 2017 10:05:15 -0000
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-7-david@redhat.com>
	<20171212144944.09860296.cohuck@redhat.com>
	<0aa794ee-c781-0cc4-3c0a-5f49ae495c63@de.ibm.com>
	<20171212152959.1ff2b7d5.cohuck@redhat.com>
	<835bc109-bc80-5405-2c5c-2eb9142550ac@redhat.com>
	<20171212162839.64ab2207.cohuck@redhat.com>
	<370f9234-81d0-e02d-da41-fc7fefef9736@de.ibm.com>
	<627be0b5-d2f8-e151-5498-7cd512ce0500@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 13 Dec 2017 11:05:10 +0100
MIME-Version: 1.0
In-Reply-To: <627be0b5-d2f8-e151-5498-7cd512ce0500@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8c0d080c-bd15-3c88-f659-9e8ba8299bbf@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 06/15] s390x/flic: factor out
 injection of floating interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>



On 12/13/2017 10:31 AM, David Hildenbrand wrote:
> On 13.12.2017 10:16, Christian Borntraeger wrote:
>>
>>
>> On 12/12/2017 04:28 PM, Cornelia Huck wrote:
>>> On Tue, 12 Dec 2017 16:17:17 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> On 12.12.2017 15:29, Cornelia Huck wrote:
>>>>> On Tue, 12 Dec 2017 15:13:46 +0100
>>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>>   
>>>>>> On 12/12/2017 02:49 PM, Cornelia Huck wrote:  
>>>>>   
>>>>>>> One thing I noticed: You removed the caching of the flic (in the old
>>>>>>> kvm inject routine), and you generally do more qom invocations (first,
>>>>>>> to find the common flic; then, to translate to the qemu or kvm flic).
>>>>>>> Not sure if this might be a problem (probably not).    
>>>>>>
>>>>>> Is any of these calls on a potential fast path (e.g. guest without adapter
>>>>>> interrupts)? If yes, then QOM is a no-go since it is really slow.  
>>>>>
>>>>> At least the new airq interface was using QOM without caching before.
>>>>>
>>>>> It's basically about any interrupt; but otoh we are (for kvm) in
>>>>> userspace already. Caching the flic and just keeping the casting to the
>>>>> specialized flic might be ok (I'd guess that the lookup is the slowest
>>>>> path.)
>>>>>   
>>>>
>>>> Please note that the lookup is already cached in s390_get_flic(); That
>>>> should be sufficient, as it does the expensive lookup. One cache should
>>>> be enough, no?
>>>
>>> Ah, missed that. So the old code actually did double caching...
>>>
>>>>
>>>> The other conversions should be cheap (and already were in place in a
>>>> couple of places before).
>>>
>>> Yes, object_resolve_path() is probably the most expensive one.
>>>
>>> Did anyone ever check if the (existing) conversions are actually
>>> measurable?
>>
>> Did some quick measurement.
>> the initial object resolve takes about 20000ns, the cached ones then is 2-5ns.
>> (measuring s390_get_flic function).
>>
>>
>> The other conversions (S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);)
>> takes about 15-25ns (up to 100 cycles). 
>> For irqfd users this does not matter, but things like plan9fs might benefit
>> if we speedup this lookup as well?
> 
> Did you also measure the state conversion like QEMU_S390_FLIC() or
> KVM_S390_FLIC() ?

somewhat between 4 and 39 ns.
