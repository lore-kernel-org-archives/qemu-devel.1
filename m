Received: from eggs.gnu.org ([2001:4830:134:3::10]:47062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.ibm.com>) id 1fx7V1-0003j6-Hw
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.ibm.com>) id 1fx7Ux-00035I-Kd
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:19:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.ibm.com>)
	id 1fx7Ux-000356-CC
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 05:19:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w849JA6P110178
	for <qemu-devel@nongnu.org>; Tue, 4 Sep 2018 05:19:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m9m1tggtr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 05:19:45 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.ibm.com>;
	Tue, 4 Sep 2018 10:19:43 +0100
From: Nikunj A Dadhania <nikunj@linux.ibm.com>
In-Reply-To: <20180904055705.GH2679@umbus.fritz.box>
References: <20180904053039.19543-1-nikunj@linux.ibm.com>
	<20180904055705.GH2679@umbus.fritz.box>
Date: Tue, 04 Sep 2018 14:49:31 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lg8hr55o.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc/kvm: set vcpu as
 online/offline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@samba.org

David Gibson <david@gibson.dropbear.id.au> writes:

> On Tue, Sep 04, 2018 at 11:00:39AM +0530, Nikunj A Dadhania wrote:
>> Set the newly added register(KVM_REG_PPC_ONLINE) to indicate if the vcpu is
>> online(1) or offline(0)
>> 
>> KVM will use this information to set the RWMR register, which controls the PURR
>> and SPURR accumulation.
>> 
>> CC: paulus@samba.org
>> Signed-off-by: Nikunj A Dadhania <nikunj@linux.ibm.com>
>> ---
>>  hw/ppc/spapr_cpu_core.c | 1 +
>>  hw/ppc/spapr_rtas.c     | 3 +++
>>  target/ppc/kvm.c        | 9 +++++++++
>>  target/ppc/kvm_ppc.h    | 6 ++++++
>>  4 files changed, 19 insertions(+)
>> 
>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>> index 876f0b3d9d..9863221756 100644
>> --- a/hw/ppc/spapr_cpu_core.c
>> +++ b/hw/ppc/spapr_cpu_core.c
>> @@ -90,6 +90,7 @@ void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target_ulong r
>>  
>>      env->nip = nip;
>>      env->gpr[3] = r3;
>> +    kvmppc_set_reg_ppc_online(cpu, 1);
>>      CPU(cpu)->halted = 0;
>>      /* Enable Power-saving mode Exit Cause exceptions */
>>      ppc_store_lpcr(cpu, env->spr[SPR_LPCR] | pcc->lpcr_pm);
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index 4ac96bc94b..ce8072689b 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -33,6 +33,7 @@
>>  #include "sysemu/device_tree.h"
>>  #include "sysemu/cpus.h"
>>  #include "sysemu/hw_accel.h"
>> +#include "kvm_ppc.h"
>>  
>>  #include "hw/ppc/spapr.h"
>>  #include "hw/ppc/spapr_vio.h"
>> @@ -187,6 +188,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spapr,
>>      newcpu->env.tb_env->tb_offset = callcpu->env.tb_env->tb_offset;
>>  
>>      spapr_cpu_set_entry_state(newcpu, start, r3);
>> +    kvmppc_set_reg_ppc_online(newcpu, 1);
>
> You're setting online in spapr_cpu_set_entry_state() called
> immediately above, so you don't need it here as well.

Ah right, I missed it. Will send a respin.

Regards
Nikunj
