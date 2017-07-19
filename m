Received: from eggs.gnu.org ([2001:4830:134:3::10]:58980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dXg1F-0008PW-18
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dXg1B-0003g2-Tn
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:51:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dXg1B-0003fj-Jr
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:51:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J3nk7J139160
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 23:51:19 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bspj7d3ex-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 23:51:19 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Wed, 19 Jul 2017 13:51:17 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170718065055.GG3140@umbus.fritz.box>
References: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
	<20170718044619.GC3140@umbus.fritz.box>
	<877ez6e2tm.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170718065055.GG3140@umbus.fritz.box>
Date: Wed, 19 Jul 2017 09:20:52 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87o9shm6eb.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: disable decrementer during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org

David Gibson <david@gibson.dropbear.id.au> writes:

> On Tue, Jul 18, 2017 at 10:53:01AM +0530, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> > On Mon, Jul 17, 2017 at 09:46:39AM +0530, Nikunj A Dadhania wrote:
>> >> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
>> >> 
>> >> When reset happens, all the CPUs are in halted state. First CPU is brought out
>> >> of reset and secondary CPUs would be initialized by the guest kernel using a
>> >> rtas call start-cpu.
>> >> 
>> >> However, in case of TCG, decrementer interrupts keep on coming and waking the
>> >> secondary CPUs up.
>> >> 
>> >> These secondary CPUs would see the decrementer interrupt pending, which makes
>> >> cpu::has_work() to bring them out of wait loop and start executing
>> >> tcg_exec_cpu().
>> >> 
>> >> The problem with this is all the CPUs wake up and start booting SLOF image,
>> >> causing the following exception(4 CPUs TCG VM):
>> >
>> > Ok, I'm still trying to understand why the behaviour on reboot is
>> > different from the first boot.
>> 
>> During first boot, the cpu is in the stopped state, so
>> cpus.c:cpu_thread_is_idle returns true and CPU remains in halted state
>> until rtas start-cpu. Therefore, we never check the cpu_has_work()
>> 
>> In case of reboot, all CPUs are resumed after reboot. So we check the
>> next condition cpu_has_work() in cpu_thread_is_idle(), where we see a
>> DECR interrupt and remove the CPU from halted state as the CPU has
>> work.
>
> Ok, so it sounds like we should set stopped on all the secondary CPUs
> on reset as well.  What's causing them to be resumed after the reset
> at the moment?

That is part of the main loop in vl.c, when reset is requested. All the
vcpus are paused (stopped == true) then system reset is issued, and all
cpus are resumed (stopped == false). Which is correct.

static bool main_loop_should_exit(void)
{
[...]
    request = qemu_reset_requested();
    if (request) {
        pause_all_vcpus();
        qemu_system_reset(request);
        resume_all_vcpus();
        if (!runstate_check(RUN_STATE_RUNNING) &&
                !runstate_check(RUN_STATE_INMIGRATE)) {
            runstate_set(RUN_STATE_PRELAUNCH);
        }
    }
[...]
}

The CPUs are in halted state, i.e. cpu::halted = 1. We have set
cpu::halted = 0 for the primary CPU, aka first_cpu, in
spapr.c::ppc_spapr_reset()

In case of TCG, we have a decr callback (per CPU) scheduled once the
machine is started which keeps on running and interrupting irrespective
of the state of the machine.

tb_env->decr_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &cpu_ppc_decr_cb, cpu);

Which keeps on queueing the interrupt to the CPUs. All the other CPUs
are in a tight loop checking cpu_thread_is_idle(), which returns false
when it sees the decrementer interrupt, the cpu starts executing:

cpu_exec()
  -> cpu_handle_halt()
     -> sees cpu_has_work() and sets cpu->halted = 0

And the execution resumes, when it shouldnt have. Ideally, for secondary
CPUs, cpu::halted flag is cleared in rtas start-cpu call.

Initially, I thought we should not have interrupt during reset state.
That was the reason of ignoring decr interrupt when msr_ee was disabled
in my previous patch. BenH suggested that it is wrong from HW
perspective.

Regards,
Nikunj
