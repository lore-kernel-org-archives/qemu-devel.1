Received: from eggs.gnu.org ([2001:4830:134:3::10]:36704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eig1U-00044B-Vc
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eig1R-0000PS-TO
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 07:37:25 -0500
References: <20180205102935.14736-1-david@redhat.com>
	<8c8fc2e6-24b2-5206-9a75-9d5595623d9a@de.ibm.com>
	<d63f7e05-648a-fb3a-aa9e-0a0dc1925276@redhat.com>
	<20180205132213.1f06d09c.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ee01d23d-5bbc-9b57-d6a5-25ef8d792374@redhat.com>
Date: Mon, 5 Feb 2018 13:37:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180205132213.1f06d09c.cohuck@redhat.com>
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

On 05.02.2018 13:22, Cornelia Huck wrote:
> On Mon, 5 Feb 2018 12:27:33 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 05.02.2018 12:22, Christian Borntraeger wrote:
>>> Looks sane on a z14.
>>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>
>>>
>>> On 02/05/2018 11:29 AM, David Hildenbrand wrote:  
>>>> --- a/target/s390x/kvm.c
>>>> +++ b/target/s390x/kvm.c
>>>> @@ -2221,6 +2221,14 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>>>          return;
>>>>      }
>>>>
>>>> +    /* PTFF subfunctions might be indicated although kernel support missing */
>>>> +    if (!test_bit(S390_FEAT_MULTIPLE_EPOCH, model->features)) {
>>>> +        clear_bit(S390_FEAT_PTFF_QSIE, model->features);
>>>> +        clear_bit(S390_FEAT_PTFF_QTOUE, model->features);
>>>> +        clear_bit(S390_FEAT_PTFF_STOE, model->features);
>>>> +        clear_bit(S390_FEAT_PTFF_STOUE, model->features);
>>>> +    }
>>>> +
>>>>      /* with cpu model support, CMM is only indicated if really available */
>>>>      if (kvm_s390_cmma_available()) {
>>>>          set_bit(S390_FEAT_CMM, model->features);
>>>>  
>>>
>>> Do you also want to add something to check_consistency ?
>>>
>>> Right now the following user error 
>>> -cpu z14,mepoch=off,mepochptff=on
>>> is accepted.
>>> On the other hand we also have no consistency checks for other subfunctions.
>>>   
>>
>> Thought about that, but that implies that a CPU model runable now, will
>> not run without warnings. Especially if migrating. We could add such
>> checks if we would push this into stable.
>>
> 
> So, adding this check for the z14 stuff would work iff pushed into
> stable - but for the other subfunctions the ship has already sailed?
> 

I don't know if we really have problems with other subfunctions. We
could also add consistency checks there (the problem here is that we
actually have to add missing subfunctions). So it is easier to check for
consistency with already existing subfunctions.

-- 

Thanks,

David / dhildenb
