Received: from eggs.gnu.org ([2001:4830:134:3::10]:48894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ePO1e-0004fm-Pv
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 02:33:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ePO1b-0005gB-H1
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 02:33:50 -0500
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
	<20170202051445.5735-96-david@gibson.dropbear.id.au>
	<72cdaa82-8496-1d1d-e7bc-3f962f3853d1@suse.de>
	<819a1e85-f50e-e1b0-55c0-696225b42606@redhat.com>
	<e98bc5f2-3bbf-1915-feac-3e88182e28c7@suse.de>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5fd72611-0d77-a508-0b5f-8fac9a5b0d84@redhat.com>
Date: Thu, 14 Dec 2017 08:33:40 +0100
MIME-Version: 1.0
In-Reply-To: <e98bc5f2-3bbf-1915-feac-3e88182e28c7@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 095/107] spapr: clock should count only if
 vm is running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru

On 13/12/2017 20:59, Alexander Graf wrote:
> 
> 
> On 13.12.17 20:29, Laurent Vivier wrote:
>> On 13/12/2017 20:19, Alexander Graf wrote:
>>>
>>>
>>> On 02.02.17 06:14, David Gibson wrote:
>>>> From: Laurent Vivier <lvivier@redhat.com>
>>>>
>>>> This is a port to ppc of the i386 commit:
>>>>     00f4d64 kvmclock: clock should count only if vm is running
>>>>
>>>> We remove timebase_post_load function, and use the VM state
>>>> change handler to save and restore the guest_timebase (on stop
>>>> and continue).
>>>>
>>>> We keep timebase_pre_save to reduce the clock difference on
>>>> migration like in:
>>>>     6053a86 kvmclock: reduce kvmclock difference on migration
>>>>
>>>> Time base offset has originally been introduced by commit
>>>>     98a8b52 spapr: Add support for time base offset migration
>>>>
>>>> So while VM is paused, the time is stopped. This allows to have
>>>> the same result with date (based on Time Base Register) and
>>>> hwclock (based on "get-time-of-day" RTAS call).
>>>>
>>>> Moreover in TCG mode, the Time Base is always paused, so this
>>>> patch also adjust the behavior between TCG and KVM.
>>>>
>>>> VM state field "time_of_the_day_ns" is now useless but we keep
>>>> it to be able to migrate to older version of the machine.
>>>>
>>>> As vmstate_ppc_timebase structure (with timebase_pre_save() and
>>>> timebase_post_load() functions) was only used by vmstate_spapr,
>>>> we register the VM state change handler only in ppc_spapr_init().
>>>>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>
>>> Just a small heads-up: I've been debugging an OpenQA regression lately
>>> where our automated testing regressed with QEMU 2.9. With stock 2.9.1, I
>>> get a failure rate of "weird" effects (probably TB divergence between
>>> vcpus) of ~30%. With this patch reverted it's back to 0%.
>>>
>>> I *think* something here causes the TB offset of multiple threads (I'm
>>> running -smp 2,threads=2) to diverge.
>>>
>>> I'll keep debugging things tomorrow, but I'll be happy to see anyone
>>> else beat me to analyze what is going wrong ;).
>>
>> Don't know if it can be related, but for migration we need:
> 
> 
> As expected, this did not fix it. I'll keep digging.
> 
> My hunch is that we now set VTB on different cores at different times,
> introducing tiny VTB offsets which can lead to negative TB differences
> inside the guest.
> 
> 
> Alex
> 

I agree.
I'm wondering if something like that can fix it:

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 7ec35de5ae..48737cbe04 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -884,7 +884,6 @@ static void timebase_load(PPCTimebase *tb)
 {
     CPUState *cpu;
     PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
-    int64_t tb_off_adj, tb_off;
     unsigned long freq;

     if (!first_ppc_cpu->env.tb_env) {
@@ -894,16 +893,10 @@ static void timebase_load(PPCTimebase *tb)

     freq = first_ppc_cpu->env.tb_env->tb_freq;

-    tb_off_adj = tb->guest_timebase - cpu_get_host_ticks();
-
-    tb_off = first_ppc_cpu->env.tb_env->tb_offset;
-    trace_ppc_tb_adjust(tb_off, tb_off_adj, tb_off_adj - tb_off,
-                        (tb_off_adj - tb_off) / freq);
-
     /* Set new offset to all CPUs */
     CPU_FOREACH(cpu) {
         PowerPCCPU *pcpu = POWERPC_CPU(cpu);
-        pcpu->env.tb_env->tb_offset = tb_off_adj;
+        pcpu->env.tb_env->tb_offset = tb->guest_timebase -
cpu_get_host_ticks();
 #if defined(CONFIG_KVM)
         kvm_set_one_reg(cpu, KVM_REG_PPC_TB_OFFSET,
                         &pcpu->env.tb_env->tb_offset);
