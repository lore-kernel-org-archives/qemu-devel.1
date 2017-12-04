Received: from eggs.gnu.org ([2001:4830:134:3::10]:55887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eLkJX-0007iY-Qa
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 01:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s1seetee@linux.vnet.ibm.com>) id 1eLkJU-0003jk-Lp
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 01:33:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53274
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s1seetee@linux.vnet.ibm.com>)
	id 1eLkJU-0003jZ-G4
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 01:33:12 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB46StIg011642
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 01:33:11 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2emwmb08tn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 01:33:11 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <s1seetee@linux.vnet.ibm.com>;
	Mon, 4 Dec 2017 01:33:10 -0500
References: <1512127449-11114-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<20171201123713.GA2130@umbus.fritz.box>
From: seeteena <s1seetee@linux.vnet.ibm.com>
Date: Mon, 4 Dec 2017 12:03:03 +0530
MIME-Version: 1.0
In-Reply-To: <20171201123713.GA2130@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <1854d711-d19d-343e-91d0-832f44d9c905@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] spapr.c: Update qemu's maxcpus for
 pseries machine.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Thanks David for the explanation.

I thought the changes been into upstream code for pseries to limit

maxcpus to 240 instead of 1024.



On 12/01/2017 06:07 PM, David Gibson wrote:
> On Fri, Dec 01, 2017 at 04:54:09PM +0530, Seeteena Thoufeek wrote:
>> Need to adjust the max cpus supported number from error message since
>> it was conflicting with KVM's.
>>
>> Steps to Reproduce:
>> 1.boot up with
>> "-smp 64,maxcpus=102464,cores=8,threads=1,sockets=8"
>>
>> qemu-kvm: Number of SMP CPUs requested (102464) exceeds max CPUs
>> supported by machine 'pseries-rhel7.4.0alt' (1024)
>>
>> 2. On KVM machine it shows
>>
>> boot up with
>> "-m 6G,maxmem=300G,slots=256 -smp 64,maxcpus=1024,cores=8,threads=1
>> ,sockets=128"
>>
>> Number of hotpluggable cpus requested (1024) exceeds the maximum cpus
>>   supported by KVM (240)
>>
>> It seemed that 1024 was useless since KVM only support 240 so far.
>> Hence,we need to adjust it to an reasonable value 240.
>>
>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> This has been written without adequate thought and investigation.
>
> First, in upstream code there's nothing wrong with having different
> limits in qemu and kernel - the can both vary depending on various
> factors.  Secondly, the 240 limit doesn't come from the kernel
> upstream - only in RHEL.
>
> Third, it doesn't even come from the kernel in RHEL - the downstream
> qemu lies about the kernel limit.
>
> I'm in the process of fixing this correctly, I expect to have
> something on Monday.
>
>> ---
>>   hw/ppc/spapr.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 9efddea..c753254 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -3691,6 +3691,7 @@ static const TypeInfo spapr_machine_info = {
>>           if (latest) {                                                \
>>               mc->alias = "pseries";                                   \
>>               mc->is_default = 1;                                      \
>> +            mc->max_cpus = 240;                                      \
>>           }                                                            \
>>       }                                                                \
>>       static void spapr_machine_##suffix##_instance_init(Object *obj)  \
