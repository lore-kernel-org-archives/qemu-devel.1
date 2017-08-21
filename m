Received: from eggs.gnu.org ([2001:4830:134:3::10]:46884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1djjEn-0004Vb-Ha
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1djjEj-0006fd-Mc
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:43:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1djjEj-0006f9-EH
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:43:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7L9cwVe135990
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 05:43:08 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cfnkkbyua-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 05:43:08 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 21 Aug 2017 03:43:06 -0600
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287473305.9760.9007559736340136424.stgit@aravinda>
	<20170817013426.GB5509@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 15:12:49 +0530
MIME-Version: 1.0
In-Reply-To: <20170817013426.GB5509@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <60f3692d-f56a-7183-7b52-3581ec881f8c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] ppc: spapr: Register and handle
 HCALL to receive updated RTAS region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, "Nikunj A. Dadhania" <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com



On Thursday 17 August 2017 07:04 AM, David Gibson wrote:
> On Wed, Aug 16, 2017 at 02:42:13PM +0530, Aravinda Prasad wrote:
>> Receive updates from SLOF about the updated rtas-base.
>> A separate patch for SLOF [1] adds functionality to invoke
>> a private HCALL whenever OS issues instantiate-rtas with
>> a new rtas-base.
>>
>> This is required as QEMU needs to know the updated rtas-base
>> as it allocates error reporting structure in RTAS space upon
>> a machine check exception.
>>
>> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120386.html
>>
>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Actually, I take back this R-b, see below.
> 
> In any case I'm not willing to apply the patches which depend on this
> until the corresponding SLOF update is merged as well.

As Nikunj mentioned, SLOF updates are already merged.

> 
>> ---
>>  hw/ppc/spapr_hcall.c   |    8 ++++++++
>>  include/hw/ppc/spapr.h |    4 +++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 72ea5a8..e66c72e 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1062,6 +1062,13 @@ static target_ulong h_rtas(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>>                             nret, rtas_r3 + 12 + 4*nargs);
>>  }
>>  
>> +static target_ulong h_rtas_update(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>> +                                  target_ulong opcode, target_ulong *args)
>> +{
>> +    spapr->rtas_addr = args[0];
>> +    return 0;
>> +}
>> +
>>  static target_ulong h_logical_load(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>>                                     target_ulong opcode, target_ulong *args)
>>  {
>> @@ -1717,6 +1724,7 @@ static void hypercall_register_types(void)
>>  
>>      /* qemu/KVM-PPC specific hcalls */
>>      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
>> +    spapr_register_hypercall(KVMPPC_H_RTAS_UPDATE, h_rtas_update);
>>  
>>      /* ibm,client-architecture-support support */
>>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 2a303a7..46012b3 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -90,6 +90,7 @@ struct sPAPRMachineState {
>>  
>>      hwaddr rma_size;
>>      int vrma_adjust;
>> +    hwaddr rtas_addr;
> 
> This can now change at runtime, which means it needs to be migrated -
> that's not happening in your patches yet.

Yes. Need a bit of help in understanding the migration process.

As rtas_addr is updated by SLOF, I think we need to modify SLOF to issue
KVMPPC_H_RTAS_UPDATE HCALL with the new rtas_addr during migration. But
I am not sure if SLOF is notified of migrations.

Regards,
Aravinda

> 
>>      ssize_t rtas_size;
>>      void *rtas_blob;
>>      long kernel_size;
>> @@ -399,7 +400,8 @@ struct sPAPRMachineState {
>>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>>  /* Client Architecture support */
>>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
>> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
>> +#define KVMPPC_H_RTAS_UPDATE    (KVMPPC_HCALL_BASE + 0x3)
>> +#define KVMPPC_HCALL_MAX        KVMPPC_H_RTAS_UPDATE
>>  
>>  typedef struct sPAPRDeviceTreeUpdateHeader {
>>      uint32_t version_id;
>>
> 

-- 
Regards,
Aravinda
