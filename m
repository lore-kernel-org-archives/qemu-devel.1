Received: from eggs.gnu.org ([2001:4830:134:3::10]:39865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dk8LD-0002ZW-Rr
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dk8L9-0001zm-Sa
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:31:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38618
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dk8L9-0001zQ-Mg
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 08:31:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7MCSwFZ001047
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 08:31:27 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cgk0qyw8v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 08:31:26 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 22 Aug 2017 06:31:25 -0600
References: <20170822042416.26758-1-david@gibson.dropbear.id.au>
	<CAFEAcA-iuizr9eh3=ZkPPT+YxfWzvUFzbWB-aA_Mo5BiDkrzQQ@mail.gmail.com>
	<b1167424-0f05-aad7-f456-22ca0aee2000@redhat.com>
	<CAFEAcA8dJe5uB-tUoeF=dE_q8HG_LLAmLUHdfR0XZihGN5JFXA@mail.gmail.com>
	<329bff28-5804-2d39-7bd8-9336eaaf9d26@redhat.com>
	<CAFEAcA9LUgCEAnMxuk_4Pdn9_rUuzTdyqH66Sp-VZy9K0gz-_g@mail.gmail.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 22 Aug 2017 09:31:14 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9LUgCEAnMxuk_4Pdn9_rUuzTdyqH66Sp-VZy9K0gz-_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <6afa5050-90e6-ae5b-d8ea-1e3141a59b26@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/7] ppc-for-2.10 queue 20170822
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>



On 08/22/2017 07:52 AM, Peter Maydell wrote:
> On 22 August 2017 at 11:41, Laurent Vivier <lvivier@redhat.com> wrote:
>> On 22/08/2017 11:53, Peter Maydell wrote:
>>> On 22 August 2017 at 10:43, Laurent Vivier <lvivier@redhat.com> wrote:
>>>> On 22/08/2017 11:34, Peter Maydell wrote:
>>>>> I get a make check failure on ppc64 Linux:
>>>>>
>>>>> TEST: tests/postcopy-test... (pid=12468)
>>>>>    /ppc64/postcopy:
>>>>> Broken pipe
>>>>> qemu-system-ppc64: RP: Received invalid message 0x0000 length 0x0000
>>>>> FAIL
>>>>> GTester: last random seed: R02Se5468e06f561627824306d95b0566d2b
>>>>> (pid=13011)
>>>>> FAIL: tests/postcopy-test
>> The problem is in:
>>
>> bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
>> {
>>      CPUState *cs = CPU(cpu);
>>
>>      if (cap_ppc_pvr_compat) {
>>          return false;
>>      }
>>
>>      return !kvmppc_is_pr(cs->kvm_state);
>> }
>>
>> It guesses !kvm pr means kvm_hv. That is not true, it can be TCG.
>>
>> This fixes the problem for me:
>> --- a/target/ppc/kvm.c
>> +++ b/target/ppc/kvm.c
>> @@ -2817,5 +2817,5 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
>>           return false;
>>       }
>>
>> -    return !kvmppc_is_pr(cs->kvm_state);
>> +    return kvm_enabled() && !kvmppc_is_pr(cs->kvm_state);
>>   }

Good catch. I forgot to cover/test TCG scenarios with this patch and 
this bug
flew under the radar completely :(

> Yep, fixes the failure for me too. David, can you respin your
> pull request, please?

I've send a v2 of the patch including Laurent's fix too. Feel free to 
use the v2 or
amend it on top of the existing v1, whatever is easier.


Thanks,

Daniel

>
> thanks
> -- PMM
>
