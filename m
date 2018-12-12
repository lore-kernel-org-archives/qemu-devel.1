Received: from eggs.gnu.org ([2001:4830:134:3::10]:46210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gX61C-0001bf-5K
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gX615-0002Fy-8M
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:01:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gX611-0002D4-D0
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:01:38 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBCErddB082504
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:01:31 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pb3mhbcfc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:01:24 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 12 Dec 2018 15:01:23 -0000
References: <1544135058-21380-1-git-send-email-walling@linux.ibm.com>
	<1544135058-21380-3-git-send-email-walling@linux.ibm.com>
	<20181207130853.20506345.cohuck@redhat.com>
	<dbabb43d-01e7-d221-a761-ad5a53fd8f94@linux.ibm.com>
	<aff40d67-9fcb-43fb-beeb-1dbe7a1e22f3@linux.ibm.com>
	<5c491972-5210-5ac6-6023-7365fb24dc3f@redhat.com>
	<20181212144132.41a1409d.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 12 Dec 2018 10:01:18 -0500
MIME-Version: 1.0
In-Reply-To: <20181212144132.41a1409d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9259bc67-2598-560b-8143-39fd9d3391ab@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/3] s390: cpu feature for
 diagnose 318 andlimit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: thuth@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On 12/12/18 8:41 AM, Cornelia Huck wrote:
> On Wed, 12 Dec 2018 12:20:08 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 11.12.18 22:12, Collin Walling wrote:
>>> On 12/11/18 11:47 AM, Collin Walling wrote:  
>>>> On 12/7/18 7:08 AM, Cornelia Huck wrote:  
>>>>> On Thu,  6 Dec 2018 17:24:17 -0500
>>>>> Collin Walling <walling@linux.ibm.com> wrote:
>>>>>  
>>>>>> Diagnose 318 is a new z14.2 CPU feature. Since we are able to emulate
>>>>>> it entirely via KVM, we can add guest support for earlier models. A
>>>>>> new CPU feature for diagnose 318 (shortened to diag318) will be made
>>>>>> available to guests starting with the zEC12-full CPU model.
>>>>>>
>>>>>> The z14.2 adds a new read SCP info byte (let's call it byte 134) to
>>>>>> detect the availability of diag318. Because of this, we have room for
>>>>>> one less VCPU and thus limit the max VPUs supported in a configuration
>>>>>> to 247 (down from 248).
>>>>>>
>>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>.
>>>>>> ---
>>>>>>  hw/s390x/sclp.c                 | 2 ++
>>>>>>  include/hw/s390x/sclp.h         | 2 ++
>>>>>>  target/s390x/cpu.h              | 2 +-
>>>>>>  target/s390x/cpu_features.c     | 3 +++
>>>>>>  target/s390x/cpu_features.h     | 1 +
>>>>>>  target/s390x/cpu_features_def.h | 3 +++
>>>>>>  target/s390x/gen-features.c     | 1 +
>>>>>>  target/s390x/kvm.c              | 1 +
>>>>>>  8 files changed, 14 insertions(+), 1 deletion(-)
>>>>>>  
>>>>>  
>>>>>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>>>>>> index 8c2320e..594b4a4 100644
>>>>>> --- a/target/s390x/cpu.h
>>>>>> +++ b/target/s390x/cpu.h
>>>>>> @@ -52,7 +52,7 @@
>>>>>>  
>>>>>>  #define MMU_USER_IDX 0
>>>>>>  
>>>>>> -#define S390_MAX_CPUS 248
>>>>>> +#define S390_MAX_CPUS 247  
>>>>>
>>>>> Isn't that already problematic if you try to migrate from an older QEMU
>>>>> with all possible vcpus defined? IOW, don't you really need a way that
>>>>> older machines can still run with one more vcpu?
>>>>>  
>>>>
>>>> Good call. I'll run some tests on this and see what happens. I'll report
>>>> here on those results.
>>>>  
>>>
>>> Migrating to a machine that supports less vCPUs will report
>>>
>>> error: unsupported configuration: Maximum CPUs greater than specified machine type limit
>>>
>>> I revisited the code to see if there's a way to dynamically set the max vcpu count based 
>>> on the read scp info size, but it gets really tricky and code looks very complicated.
>>> (Having a packed struct contain the CPU entries whose maximum is determined by hardware
>>> limitations makes things difficult -- but who said s390 is easy? :) )
>>>
>>> In reality, do we often have guests running with 248 or even 247 vcpus? If so, I imagine
>>> the performance isn't too significant?  
>> Gluing CPU feature availability to machines is plain ugly. This sounds
>> like going back to pre-cpu model times ;)
>>
>> There are two alternatives:
>>
>> a) Don't model it as a CPU feature in QEMU. Glue it completely to the
>> QEMU machine. This goes hand-in-hand with the proposal I made in the KVM
>> thread, that diag318 is to be handled completely in QEMU, always. The
>> KVM setting part is optional (if KVM + HW support it).
>>
>> Then we can have two different max_cpus/ReadInfo layouts based on the
>> machine type. No need to worry about QEMU cpu features.
>>
>> Once we have other SCLP features (eventually requiring KVM/HW support)
>> announced in the same feature block, things might get more involved, but
>> I guess we could handle it somehow.
> 
> Perhaps via a capability to be enabled?
> 
>>
>>
>> b) Glue the ReadInfo layout to the CPU feature, we would have to
>> default-disable the CPU feature for legacy machines. And bail out if
>> more CPUs are used when the feature is enabled. Hairy.
>>
>>
>> I guess a) would be the best thing to do. After all this really does not
>> sound like a CPU feature but more like a machine feature. But there is
>> usually a fine line between them.
> 
> a) sounds like the better option to me as well.
> 

I think this makes sense as well. A CPU feat really doesn't make sense if we 
just want to enable this "always" so-to-speak. I'll get cracking on a rework
of this patch series. It'll take me some time.

In the mean time, I'll return the favor and take a look at the PCI stuff you
guys have posted ;)

-- 
Respectfully,
- Collin Walling
