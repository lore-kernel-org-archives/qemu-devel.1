Received: from eggs.gnu.org ([2001:4830:134:3::10]:44419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ej6xK-0008Va-V1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ej6xG-0004mA-1N
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:22:54 -0500
References: <20180205102935.14736-1-david@redhat.com>
	<8c8fc2e6-24b2-5206-9a75-9d5595623d9a@de.ibm.com>
	<d63f7e05-648a-fb3a-aa9e-0a0dc1925276@redhat.com>
	<20180205132213.1f06d09c.cohuck@redhat.com>
	<ee01d23d-5bbc-9b57-d6a5-25ef8d792374@redhat.com>
	<20180206181907.577e9b3f.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3af37ba2-af07-5c23-52a5-cad92091c34d@redhat.com>
Date: Tue, 6 Feb 2018 18:22:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180206181907.577e9b3f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpumodel: model PTFF subfunctions
 for Multiple-epoch facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 06.02.2018 18:19, Cornelia Huck wrote:
> On Mon, 5 Feb 2018 13:37:17 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 05.02.2018 13:22, Cornelia Huck wrote:
>>> On Mon, 5 Feb 2018 12:27:33 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>   
>>>> On 05.02.2018 12:22, Christian Borntraeger wrote:  
>>>>> Looks sane on a z14.
>>>>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>>
>>>>>
>>>>> On 02/05/2018 11:29 AM, David Hildenbrand wrote:    
>>>>>> --- a/target/s390x/kvm.c
>>>>>> +++ b/target/s390x/kvm.c
>>>>>> @@ -2221,6 +2221,14 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>>>>>          return;
>>>>>>      }
>>>>>>
>>>>>> +    /* PTFF subfunctions might be indicated although kernel support missing */
>>>>>> +    if (!test_bit(S390_FEAT_MULTIPLE_EPOCH, model->features)) {
>>>>>> +        clear_bit(S390_FEAT_PTFF_QSIE, model->features);
>>>>>> +        clear_bit(S390_FEAT_PTFF_QTOUE, model->features);
>>>>>> +        clear_bit(S390_FEAT_PTFF_STOE, model->features);
>>>>>> +        clear_bit(S390_FEAT_PTFF_STOUE, model->features);
>>>>>> +    }
>>>>>> +
>>>>>>      /* with cpu model support, CMM is only indicated if really available */
>>>>>>      if (kvm_s390_cmma_available()) {
>>>>>>          set_bit(S390_FEAT_CMM, model->features);
>>>>>>    
>>>>>
>>>>> Do you also want to add something to check_consistency ?
>>>>>
>>>>> Right now the following user error 
>>>>> -cpu z14,mepoch=off,mepochptff=on
>>>>> is accepted.
>>>>> On the other hand we also have no consistency checks for other subfunctions.
>>>>>     
>>>>
>>>> Thought about that, but that implies that a CPU model runable now, will
>>>> not run without warnings. Especially if migrating. We could add such
>>>> checks if we would push this into stable.
> 
> I'm currently wondering whether this change would actually be
> applicable and useful for stable. Given the way stable is usually used,
> probably not.
> 
>>>>  
>>>
>>> So, adding this check for the z14 stuff would work iff pushed into
>>> stable - but for the other subfunctions the ship has already sailed?
>>>   
>>
>> I don't know if we really have problems with other subfunctions. We
>> could also add consistency checks there (the problem here is that we
>> actually have to add missing subfunctions). So it is easier to check for
>> consistency with already existing subfunctions.
> 
> Hm, so not really worth the hassle, just keep this as-is (and apply
> this patch as-is)?
> 

Think this would be best. (if we would have considered this earlier, we
would now have "mepoch-base" (now "mepoch") and "mepoch" as
"mepoch-base,ptff-stoe,ptff-stoue..."), just as e.g. handled for the
tod-clock-steering features. But unfortunately we missed that.

Such bugs happen as the features are merged before there is chance to
rewiew documentation (before an updated PoP is out). It is what it is.

-- 

Thanks,

David / dhildenb
