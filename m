Received: from eggs.gnu.org ([2001:4830:134:3::10]:41905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1djpV6-00051Q-Qv
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1djpV3-0006tE-MT
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:24:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43047
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1djpV3-0006t6-Gi
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:24:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7LGJ6os006813
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 12:24:24 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cg1uj5h9b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 12:24:24 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 21 Aug 2017 17:24:23 +0100
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-8-cohuck@redhat.com>
	<0d8dcac1-f536-5d69-0187-23656d003348@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 18:24:15 +0200
MIME-Version: 1.0
In-Reply-To: <0d8dcac1-f536-5d69-0187-23656d003348@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <17cb7925-e4eb-d174-2886-49ab9af0852c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 07/10] s390x/sclp: properly guard
 pci-specific functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 08/21/2017 04:58 PM, Pierre Morel wrote:
> On 21/08/2017 11:16, Cornelia Huck wrote:
>> If we do not provide zpci, pci reconfiguration via sclp is not available
>> either. Don't indicate it in the sclp facilities and return an invalid
>> command if the guest tries to issue pci configure/deconfigure.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   hw/s390x/sclp.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 9253dbbc64..d0104cd784 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -59,6 +59,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>       int rnsize, rnmax;
>>       int slots = MIN(machine->ram_slots, s390_get_memslot_count(kvm_state));
>>       IplParameterBlock *ipib = s390_ipl_get_iplb();
>> +    uint64_t sclp_facilities = SCLP_HAS_CPU_INFO;
>>
>>       CPU_FOREACH(cpu) {
>>           cpu_count++;
>> @@ -79,8 +80,10 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>
>>       prepare_cpu_entries(sclp, read_info->entries, cpu_count);
>>
>> -    read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
>> -                                        SCLP_HAS_PCI_RECONFIG);
>> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
>> +        sclp_facilities |= SCLP_HAS_PCI_RECONFIG;
>> +    }
>> +    read_info->facilities = cpu_to_be64(sclp_facilities);
>>
>>       /* Memory Hotplug is only supported for the ccw machine type */
>>       if (mhd) {
>> @@ -385,10 +388,18 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
>>           sclp_c->unassign_storage(sclp, sccb);
>>           break;
>>       case SCLP_CMDW_CONFIGURE_PCI:
>> -        s390_pci_sclp_configure(sccb);
>> +        if (s390_has_feat(S390_FEAT_ZPCI)) {
>> +            s390_pci_sclp_configure(sccb);
>> +        } else {
>> +            sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
> 
> Hello Conny,
> 
> I find more logical if the response would be 0x06F0 : "Adapter type in SCCB not recognized"
> Since we could have more than one adapter type... someday.
> then the SCLP command would be valid but not the adapter type.

I agree, 01F0 does not seem to be the correct answer, based on
the AR as it seems to be tied to the command code.

Verifying what the machine does would be great though -- frankly
I cant tell with absolute confidence what's the right thing to
do based on my understanding of the AR. 


> 
> However, I will try to find a real hardware to test this since I noticed that my logic sometime... :) .
> 
> Another point is that don't you think that this test on S390_FEAT_ZPCI better belong to the dedicated PCI code inside of the s390_pci_sclp_configure().
>

I'm fine either way. If I imagine having a lots of adapter types, then I
would expect a switch or a jumptable on the type before handling control
to the pci specific function. In this case statically not supported types
would probably get caught by the default branch of the switch and for a
jumptable it could even handle the dynamic case (based on the facilities)
trivially. In short both approaches can make sense.

Regards,
Halil

> best regards,
> 
> Pierre
> 
> 
>> +        }
>>           break;
>>       case SCLP_CMDW_DECONFIGURE_PCI:
>> -        s390_pci_sclp_deconfigure(sccb);
>> +        if (s390_has_feat(S390_FEAT_ZPCI)) {
>> +            s390_pci_sclp_deconfigure(sccb);
>> +        } else {
>> +            sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
>> +        }
>>           break;
>>       default:
>>           efc->command_handler(ef, sccb, code);
>>
> 
> 
