Received: from eggs.gnu.org ([2001:4830:134:3::10]:53037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ej7Y6-0004U8-EH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ej7Y5-0006DQ-HX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:00:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ej7Y5-0006D5-8A
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:00:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16I07kR129922
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 13:00:51 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyf63eaex-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 13:00:51 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Feb 2018 18:00:46 -0000
References: <20180205102935.14736-1-david@redhat.com>
	<8c8fc2e6-24b2-5206-9a75-9d5595623d9a@de.ibm.com>
	<d63f7e05-648a-fb3a-aa9e-0a0dc1925276@redhat.com>
	<20180205132213.1f06d09c.cohuck@redhat.com>
	<ee01d23d-5bbc-9b57-d6a5-25ef8d792374@redhat.com>
	<20180206181907.577e9b3f.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Feb 2018 19:00:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180206181907.577e9b3f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d5a57d08-0a2e-28b1-8784-f683950998fb@de.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>



On 02/06/2018 06:19 PM, Cornelia Huck wrote:
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

I think its not necessary right now.
Currently we do not handle the subfunction in the kernel (we still rely on
the IBC) and I think we really do not want to go down that path unless really
necessary.
