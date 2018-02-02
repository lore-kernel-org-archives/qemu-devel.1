Received: from eggs.gnu.org ([2001:4830:134:3::10]:43891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ehd9y-0008MI-0G
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ehd8t-0006Hi-Uu
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:21:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34252
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ehd8t-0006GK-Eq
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:20:43 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12BBOZ2134216
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 06:18:10 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvns0ud4m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 06:18:10 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 2 Feb 2018 04:18:09 -0700
References: <151751446151.11348.15065690714406381610.stgit@bahia.lan>
	<5f7250a8-6169-0afc-6ee9-fe1576aef9c7@linux.vnet.ibm.com>
	<20180202110007.039a451a@bahia.lan>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 2 Feb 2018 09:18:04 -0200
MIME-Version: 1.0
In-Reply-To: <20180202110007.039a451a@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <259a6ae5-7ff9-6a40-2a26-5345914d4b55@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: add missing break in
 h_get_cpu_characteristics()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>



On 02/02/2018 08:00 AM, Greg Kurz wrote:
> On Fri, 2 Feb 2018 07:11:08 -0200
> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
>
>> On 02/01/2018 05:47 PM, Greg Kurz wrote:
>>> Detected by Coverity (CID 1385702). This fixes the recently added hypercall
>>> to let guests properly apply Spectre and Meltdown workarounds.
>> Paolo Bonzini reported this error in a reply to the pull request that
>> added the patch:
>>
>> "Re: [Qemu-ppc] [Qemu-devel] [PULL 12/12] target/ppc/spapr: Add H-Call
>> H_GET_CPU_CHARACTERISTICS
>>
>> On 28/01/2018 22:28, David Gibson wrote:
>>
>>> +    switch (safe_indirect_branch) {
>>> +    case SPAPR_CAP_FIXED:
>>> +        characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;
>> Missing "break;" here.
>>
>> Paolo
>>
>> "
>>
>> I think it is nice to mention in the commit msg that Paolo also detected
>> this same error,
>> specially given that his email was sent before this patch.
>>
> Heh, Paolo's mail landed in the pull req thread in my mail client and I saw
> it after sending the patch :P ... also I'm pretty sure Paolo was made aware
> of this issue by Coverity, just as I was :)
>
> From: scan-admin@coverity.com
> To: groug@kaod.org
> Subject: New Defects reported by Coverity Scan for QEMU
> Date: Thu, 01 Feb 2018 18:11:33 +0000 (UTC)
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to QEMU found with
> Coverity Scan.
>
> ...
>
> *** CID 1385702:  Control flow issues  (MISSING_BREAK)
> /hw/ppc/spapr_hcall.c: 1700 in h_get_cpu_characteristics()
> 1694             break;
> 1695         }
> 1696
> 1697         switch (safe_indirect_branch) {
> 1698         case SPAPR_CAP_FIXED:
> 1699             characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;
>>>>      CID 1385702:  Control flow issues  (MISSING_BREAK)
>>>>      The above case falls through to this one.
> 1700         default: /* broken */
> 1701             assert(safe_indirect_branch == SPAPR_CAP_BROKEN);
> 1702             break;
> 1703         }
> 1704
> 1705         args[0] = characteristics;
>
>
> No big deal I guess :)

Roger that!

>
>> Thanks,
>>
>>
>> Daniel
>>
>>
>>> Fixes: c59704b25473 "target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS"
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>>    hw/ppc/spapr_hcall.c |    1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>>> index 4d0e6eb0cf1d..596f58378a40 100644
>>> --- a/hw/ppc/spapr_hcall.c
>>> +++ b/hw/ppc/spapr_hcall.c
>>> @@ -1697,6 +1697,7 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>>>        switch (safe_indirect_branch) {
>>>        case SPAPR_CAP_FIXED:
>>>            characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;
>>> +        break;
>>>        default: /* broken */
>>>            assert(safe_indirect_branch == SPAPR_CAP_BROKEN);
>>>            break;
>>>
>>>   
