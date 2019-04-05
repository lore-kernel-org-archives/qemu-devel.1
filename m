Received: from eggs.gnu.org ([209.51.188.92]:44049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@linux.ibm.com>) id 1hCH8f-0007o5-32
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@linux.ibm.com>) id 1hCH1u-00016w-VE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:04:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aik@linux.ibm.com>) id 1hCH1u-0000YB-D8
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:04:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x354xY7f048828
	for <qemu-devel@nongnu.org>; Fri, 5 Apr 2019 01:04:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rny4qk01m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 01:04:35 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aik@linux.ibm.com>;
	Fri, 5 Apr 2019 06:04:33 +0100
References: <155323635511.18748.18133954505098138975.stgit@aravinda>
	<155323643836.18748.13006461397179281455.stgit@aravinda>
	<20190325062256.GO29295@umbus>
	<1fdde5df-408a-f81d-d9ac-eb9636324b54@linux.vnet.ibm.com>
	<20190404231707.GB25513@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@linux.ibm.com>
Date: Fri, 5 Apr 2019 16:04:27 +1100
MIME-Version: 1.0
In-Reply-To: <20190404231707.GB25513@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cd08ddbc-d289-04a5-c9ae-d7618fc22308@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 3/6] target/ppc: Handle NMI guest exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org, mahesh@linux.vnet.ibm.com



On 05/04/2019 10:17, David Gibson wrote:
> On Thu, Apr 04, 2019 at 02:40:45PM +0530, Aravinda Prasad wrote:
>>
>>
>> On Monday 25 March 2019 11:52 AM, David Gibson wrote:
>>> On Fri, Mar 22, 2019 at 12:03:58PM +0530, Aravinda Prasad wrote:
>>>> Memory error such as bit flips that cannot be corrected
>>>> by hardware are passed on to the kernel for handling.
>>>> If the memory address in error belongs to guest then
>>>> the guest kernel is responsible for taking suitable action.
>>>> Patch [1] enhances KVM to exit guest with exit reason
>>>> set to KVM_EXIT_NMI in such cases. This patch handles
>>>> KVM_EXIT_NMI exit.
>>>>
>>>> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
>>>>     (e20bbd3d and related commits)
>>>>
>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>> ---
>>>>  hw/ppc/spapr_events.c  |   22 ++++++++++++++++++++++
>>>>  include/hw/ppc/spapr.h |    1 +
>>>>  target/ppc/kvm.c       |   16 ++++++++++++++++
>>>>  target/ppc/kvm_ppc.h   |    2 ++
>>>>  4 files changed, 41 insertions(+)
>>>>
>>
>> [...]
>>
>>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>>>> index 2427c8e..a593448 100644
>>>> --- a/target/ppc/kvm.c
>>>> +++ b/target/ppc/kvm.c
>>>> @@ -1738,6 +1738,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>>>>          ret = 0;
>>>>          break;
>>>>  
>>>> +    case KVM_EXIT_NMI:
>>>> +        DPRINTF("handle NMI exception\n");
>>>
>>> tracepoints are generally preferred to new DPRINTFs.
>>
>> I see DPRINTFs used in all other exit reasons in this function. Do you
>> want me to change this particular exit case to tracepoints? I think it
>> is better to keep this DPRINTF as of now and change all the DPRINTFs to
>> tracepoints in a separate patch set.
> 
> Ah, good point. 

imho not. The kvm.c already knows about traces (there are two) and even
if every other trace in kvm_arch_handle_exit() is DPRINTF (enabled all
at once), having at least one which can be enabled without QEMU
recompile and separately from the others is a small but nice bonus
before someone gets rid of DPRINTF.


> Tracepoints are generally preferred, but since
> DPRINTFs are in use here, stick with that (at some point it would be
> good to change the whole file, but that's out of scope here).


-- 
Alexey Kardashevskiy
IBM OzLabs, LTC Team

e-mail: aik@linux.ibm.com
