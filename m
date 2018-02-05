Received: from eggs.gnu.org ([2001:4830:134:3::10]:52187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eih4m-000078-HP
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eih4h-0002Wg-SG
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:44:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eih4h-0002Tn-Ji
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:44:47 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w15DiUP2037065
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 08:44:46 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxquchj6y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 08:44:44 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Feb 2018 13:44:41 -0000
References: <20180202143746.204851-1-borntraeger@de.ibm.com>
	<20180202143746.204851-2-borntraeger@de.ibm.com>
	<20180205130427.4b6612d4.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Feb 2018 14:44:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180205130427.4b6612d4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9ec94463-8ce0-65de-ad58-597be5f15605@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>



On 02/05/2018 01:04 PM, Cornelia Huck wrote:

> You're doing the crash_reason -> reason mapping here and also below.
> Maybe introduce a helper for it?
> 
[....]
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 8736001156..c6a23262a8 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -1568,15 +1568,32 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
>>      return r;
>>  }
>>  
>> -static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
>> +static void unmanageable_intercept(S390CPU *cpu, enum crash_reasons reason,
>> +                                   int pswoffset)
>>  {
>>      CPUState *cs = CPU(cpu);
>> +    const char *str;
>>  
>> +    switch (reason) {
>> +    case CRASH_REASON_PGM:
>> +        str = "program interrupt loop";
>> +        break;
>> +    case CRASH_REASON_EXT:
>> +        str = "external interrupt loop";
>> +        break;
>> +    case CRASH_REASON_OPEREXC:
>> +        str = "operation exception loop";
>> +        break;
>> +    default:
>> +        str = "unknown crash reason";
>> +        break;
>> +    }
>>      error_report("Unmanageable %s! CPU%i new PSW: 0x%016lx:%016lx",
> 
> "Unmanageable unknown crash reason!" looks a bit odd. In this case,
> "Unmanageable intercept!" would actually look a bit saner (but you
> would not be able to use a common converter in that case). We can also
> just simply keep it :)

We could maybe just drop this print in kvm.c. qemu_system_guest_panicked below will
trigger some logging as well (if enabled) and it will also notify libvirt about
that. a future libvirt code will print something like
panic s390: psw-mask='0x0000000000000000', psw-addr='0x0000000000000002', crash reason: operation exception loop
anyway in the log file.

That would also address your concern from above.
