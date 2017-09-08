Received: from eggs.gnu.org ([2001:4830:134:3::10]:51051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dqEMO-0001kv-Tc
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dqEMJ-0003Nw-SN
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:09:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33621
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dqEMJ-0003NW-MO
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:09:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8889dcN175223
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 04:09:51 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cumuxfnev-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 04:09:47 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 04:09:46 -0400
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287475974.9760.13295593936611613542.stgit@aravinda>
	<20170817015735.GD5509@umbus.fritz.box>
	<f7f837f6-9ce9-3eb3-8083-31878c851267@linux.vnet.ibm.com>
	<20170823083923.GR5379@umbus.fritz.box>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 8 Sep 2017 13:39:37 +0530
MIME-Version: 1.0
In-Reply-To: <20170823083923.GR5379@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <99c1f372-1db0-e89a-423b-63ec113caf37@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 4/5] target/ppc: Handle NMI
 guest exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: benh@au1.ibm.com, mahesh@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@samba.org, sam.bobroff@au1.ibm.com



On Wednesday 23 August 2017 02:09 PM, David Gibson wrote:
> On Mon, Aug 21, 2017 at 06:00:52PM +0530, Aravinda Prasad wrote:
>>
>>
>> On Thursday 17 August 2017 07:27 AM, David Gibson wrote:
>>> On Wed, Aug 16, 2017 at 02:42:39PM +0530, Aravinda Prasad wrote:
>>>> Memory error such as bit flips that cannot be corrected
>>>> by hardware are passed on to the kernel for handling.
>>>> If the memory address in error belongs to guest then
>>>> guest kernel is responsible for taking suitable action.
>>>> Patch [1] enhances KVM to exit guest with exit reason
>>>> set to KVM_EXIT_NMI in such cases.
>>>>
>>>> This patch handles KVM_EXIT_NMI exit. If the guest OS
>>>> has registered the machine check handling routine by
>>>> calling "ibm,nmi-register", then the handler builds
>>>> the error log and invokes the registered handler else
>>>> invokes the handler at 0x200.
>>>>
>>>> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
>>>> 	(e20bbd3d and related commits)
>>>>
>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
>>>> ---
>>>>  hw/ppc/spapr.c       |    4 ++
>>>>  target/ppc/kvm.c     |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  target/ppc/kvm_ppc.h |   81 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 171 insertions(+)
>>>>
>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>> index 0bb2c4a..6cc3f69 100644
>>>> --- a/hw/ppc/spapr.c
>>>> +++ b/hw/ppc/spapr.c
>>>> @@ -2346,6 +2346,10 @@ static void ppc_spapr_init(MachineState *machine)
>>>>          error_report("Could not get size of LPAR rtas '%s'", filename);
>>>>          exit(1);
>>>>      }
>>>> +
>>>> +    /* Resize blob to accommodate error log. */
>>>> +    spapr->rtas_size = RTAS_ERRLOG_OFFSET + sizeof(struct RtasMCELog);
>>>> +
>>>>      spapr->rtas_blob = g_malloc(spapr->rtas_size);
>>>>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size) < 0) {
>>>>          error_report("Could not load LPAR rtas '%s'", filename);
>>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>>>> index 8571379..73f64ed 100644
>>>> --- a/target/ppc/kvm.c
>>>> +++ b/target/ppc/kvm.c
>>>> @@ -1782,6 +1782,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>>>>          ret = 0;
>>>>          break;
>>>>  
>>>> +    case KVM_EXIT_NMI:
>>>> +        DPRINTF("handle NMI exception\n");
>>>> +        ret = kvm_handle_nmi(cpu);
>>>> +        break;
>>>> +
>>>>      default:
>>>>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
>>>>          ret = -1;
>>>> @@ -2704,6 +2709,87 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>>>>      return data & 0xffff;
>>>>  }
>>>>  
>>>> +int kvm_handle_nmi(PowerPCCPU *cpu)
>>>
>>> So you only handle NMIs with KVM.  Wouldn't it make sense to also
>>> handle them for TCG (where they can be triggered with the "nmi"
>>> command on the monitor).
>>
>> For TCG it is already handled in spapr_nmi() which ultimately branches
>> to guest's 0x200 vector. Even with KVM when KVM_CAP_PPC_FWNMI is not
>> enabled we branch to guest's 0x200 vector. Should TCG behave as if
>> KVM_CAP_PPC_FWNMI is not enabled?
> 
> No, we should implement the FWNMI feature for TCG, which means it
> needs to respect the address given by nmi-register.

I have couple of questions regarding supporting NMIs triggered through
"nmi" command from the monitor.

1. The FWNNMI builds an error log upon machine check that includes the
effective address that triggered the machine check and places the error
log in RTAS blob. Hence, we need to build error log for the NMI
triggered via the monitor "nmi" command. What should be the effective
address and the other values of the error log in this case? Should "nmi"
command be enhanced to take these arguments (as of now it does not take
any arguments)?

2. On Power architecture "nmi" monitor command triggers NMI on all the
CPUs, while the NMI due to hardware error is triggered only on the CPU
that accessed the bad memory region. Triggering NMI on all the CPUs
could be a problem as it cause kernel panic if the CPU was in kernel
space at that time or kills the process running on that CPU if it was in
userspace.

-- 
Regards,
Aravinda
