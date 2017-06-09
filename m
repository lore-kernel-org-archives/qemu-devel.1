Received: from eggs.gnu.org ([2001:4830:134:3::10]:43473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dJC4L-00057z-O1
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dJC4G-0006aq-RK
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:02:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dJC4G-0006aX-HO
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:02:40 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v594x8Gt004056
	for <qemu-devel@nongnu.org>; Fri, 9 Jun 2017 01:02:38 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aygma9edj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Jun 2017 01:02:38 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 9 Jun 2017 15:02:35 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170609020141.GB26521@umbus.fritz.box>
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
	<20170609020141.GB26521@umbus.fritz.box>
Date: Fri, 09 Jun 2017 10:32:25 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH RFC] spapr: ignore interrupts during reset
 state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net, alex.bennee@linaro.org, bharata@linux.vnet.ibm.com

David Gibson <david@gibson.dropbear.id.au> writes:

> On Thu, Jun 08, 2017 at 12:06:08PM +0530, Nikunj A Dadhania wrote:
>> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
>
> Ouch.  When exactly did this happen?

Broken since long

> I know that smp boot used to work under TCG, albeit very slowly.

SMP boot works, its the reboot issued from the guest doesn't boot and
crashes in SLOF.

>> When reset happens, all the CPUs are in halted state. First CPU is brought out
>> of reset and secondary CPUs would be initialized by the guest kernel using a
>> rtas call start-cpu.
>> 
>> However, in case of TCG, decrementer interrupts keep on coming and waking the
>> secondary CPUs up.
>
> Ok.. how is that happening given that the secondary CPUs should have
> MSR[EE] == 0?

Basically, the CPU is in halted condition and has_work() does not check
for MSR_EE in that case. But I am not sure if checking MSR_EE is
sufficient, as the CPU does go to halted state (idle) while running as
well.

static bool cpu_has_work_POWER8(CPUState *cs)
{
    PowerPCCPU *cpu = POWERPC_CPU(cs);
    CPUPPCState *env = &cpu->env;

    if (cs->halted) {
       [ SNIP ]
       /* Does not check for msr_ee */
    } else {
        return msr_ee && (cs->interrupt_request & CPU_INTERRUPT_HARD);
    }
}

>
>> These secondary CPUs would see the decrementer interrupt pending, which makes
>> cpu::has_work() to bring them out of wait loop and start executing
>> tcg_exec_cpu().
>> 
>> The problem with this is all the CPUs wake up and start booting SLOF image,
>> causing the following exception(4 CPUs TCG VM):
>
> [snip]
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index d10808d..eb88bcb 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1013,6 +1013,13 @@ struct CPUPPCState {
>>      int access_type; /* when a memory exception occurs, the access
>>                          type is stored here */
>>  
>> +    /* CPU in reset, shouldn't process any interrupts.
>> +     *
>> +     * Decrementer interrupts in TCG can still wake the CPU up. Make sure that
>> +     * when this variable is set, cpu_has_work_* should return false.
>> +     */
>> +    int in_reset;
>
> So I'd really rather not add another flag to the cpu structure,
> especially since we'd then need to migrate it as well.

I agree, Bharata and I did discuss about the migrate case. This patch
was to highlight the exact issue.

> I'm pretty sure there should be a way to inhibit the unwanted
> interrupts using existing mechanisms.

One of the thing that I had observed was msr had just MSR_SF bit set
during the reset case, we can test for that maybe.

The below works as well:

+        if ((env->msr & ~(1ull << MSR_SF)) == 0) {
+            return false;
+        }

>> +
>>      CPU_COMMON
>>  
>>      /* MMU context - only relevant for full system emulation */
>> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
>> index 56a0ab2..64f4348 100644
>> --- a/target/ppc/translate_init.c
>> +++ b/target/ppc/translate_init.c
>> @@ -8561,6 +8561,9 @@ static bool cpu_has_work_POWER7(CPUState *cs)
>>      CPUPPCState *env = &cpu->env;
>>  
>>      if (cs->halted) {
>> +        if (env->in_reset) {
>> +            return false;
>> +        }
>>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>>              return false;
>>          }
>> @@ -8718,6 +8721,9 @@ static bool cpu_has_work_POWER8(CPUState *cs)
>>      CPUPPCState *env = &cpu->env;
>>  
>>      if (cs->halted) {
>> +        if (env->in_reset) {
>> +            return false;
>> +        }
>>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>>              return false;
>>          }
>> @@ -8899,6 +8905,9 @@ static bool cpu_has_work_POWER9(CPUState *cs)
>>      CPUPPCState *env = &cpu->env;
>>  
>>      if (cs->halted) {
>> +        if (env->in_reset) {
>> +            return false;
>> +        }
>>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>>              return false;
>>          }

Regards
Nikunj
