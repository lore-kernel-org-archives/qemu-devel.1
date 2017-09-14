Received: from eggs.gnu.org ([2001:4830:134:3::10]:60604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dsNFc-0007tM-HO
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 02:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dsNFZ-0000WP-D8
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 02:03:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dsNFZ-0000Vl-4c
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 02:03:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8E61vON129975
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 02:03:43 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cyj72dadd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 02:03:42 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 16:03:39 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170719043250.GW3140@umbus.fritz.box>
References: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
	<20170718044619.GC3140@umbus.fritz.box>
	<877ez6e2tm.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170718065055.GG3140@umbus.fritz.box>
	<87o9shm6eb.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170719043250.GW3140@umbus.fritz.box>
Date: Thu, 14 Sep 2017 11:32:14 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <871sn9stqx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

> On Wed, Jul 19, 2017 at 09:20:52AM +0530, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> > On Tue, Jul 18, 2017 at 10:53:01AM +0530, Nikunj A Dadhania wrote:
>> >> David Gibson <david@gibson.dropbear.id.au> writes:
>> >> 
>> >> > On Mon, Jul 17, 2017 at 09:46:39AM +0530, Nikunj A Dadhania wrote:
>> >> >> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
>> >> >> 
>> >> >> When reset happens, all the CPUs are in halted state. First CPU is brought out
>> >> >> of reset and secondary CPUs would be initialized by the guest kernel using a
>> >> >> rtas call start-cpu.
>> >> >> 
>> >> >> However, in case of TCG, decrementer interrupts keep on coming and waking the
>> >> >> secondary CPUs up.
>> >> >> 
>> >> >> These secondary CPUs would see the decrementer interrupt pending, which makes
>> >> >> cpu::has_work() to bring them out of wait loop and start executing
>> >> >> tcg_exec_cpu().
>> >> >> 
>> >> >> The problem with this is all the CPUs wake up and start booting SLOF image,
>> >> >> causing the following exception(4 CPUs TCG VM):
>> >> >
>> >> > Ok, I'm still trying to understand why the behaviour on reboot is
>> >> > different from the first boot.
>> >> 
>> >> During first boot, the cpu is in the stopped state, so
>> >> cpus.c:cpu_thread_is_idle returns true and CPU remains in halted state
>> >> until rtas start-cpu. Therefore, we never check the cpu_has_work()
>> >> 
>> >> In case of reboot, all CPUs are resumed after reboot. So we check the
>> >> next condition cpu_has_work() in cpu_thread_is_idle(), where we see a
>> >> DECR interrupt and remove the CPU from halted state as the CPU has
>> >> work.
>> >
>> > Ok, so it sounds like we should set stopped on all the secondary CPUs
>> > on reset as well.  What's causing them to be resumed after the reset
>> > at the moment?
>> 
>> That is part of the main loop in vl.c, when reset is requested. All the
>> vcpus are paused (stopped == true) then system reset is issued, and all
>> cpus are resumed (stopped == false). Which is correct.
>
> is it?  Seems we have a different value of 'stopped' on the first boot
> compared to reoboots, which doesn't seem right.

I have checked this with more debugging prints (patch at the end), as
you said, first boot and reboot does not have different value of
cpu::stopped

     cpu_ppc_decr_excp-cpu1: stop 0 stopped 1 halted 0 SPR_LPCR 0
     spapr_cpu_reset-cpu1: stop 0 stopped 1 halted 1 SPR_LPCR 2000
     spapr_cpu_reset-cpu1: stop 0 stopped 1 halted 1 SPR_LPCR 2000
     resume_all_vcpus-cpu0: stop 0 stopped 0 halted 0
     resume_all_vcpus-cpu1: stop 0 stopped 0 halted 1
     
     
     SLOF **********************************************************************
     QEMU Starting
     
     [ boot fine and then we reboot ]


     cpu_ppc_decr_excp-cpu1: stop 0 stopped 0 halted 0 SPR_LPCR 2000
     cpu_ppc_decr_excp-cpu1: stop 0 stopped 0 halted 0 SPR_LPCR 2000
     cpu_ppc_decr_excp-cpu1: stop 0 stopped 0 halted 0 SPR_LPCR 2000
     cpu_ppc_decr_excp-cpu1: stop 0 stopped 0 halted 1 SPR_LPCR 2000
     [   54.044388] reboot: Restarting system
     spapr_cpu_reset-cpu1: stop 0 stopped 1 halted 1 SPR_LPCR 2000
     resume_all_vcpus-cpu0: stop 0 stopped 0 halted 0
     resume_all_vcpus-cpu1: stop 0 stopped 0 halted 1
     cpu_ppc_decr_excp-cpu1: stop 0 stopped 0 halted 1 SPR_LPCR 2000
     
     
     
     
     SSLLOOFF ***[0m **********************************************************************
     QEMU Starting
      Build Date = Aug 16 2017 12:38:57
      FW Version = git-685af54d8a47a42d
     *******************************************************************
     QEMU Starting
      Build Date = Aug 16 2017 12:38:57
      FW Version = git-685af54d8a47a42d
     ERROR: Flatten device tree not available!
     
      SPRG2 = RSPRG3 = 00000000000000000 0 

One difference I see here is, the decr exception is delivered before
reset in case of first boot for secondary cpu, and then I do not see any
decr exception until rtas-start.

In case of a reboot, we are getting decr_exception at some interval,
then there is spapr_cpu_reset, after that the cpus are resumed, the
interrupt gets delivered just after that which brings out the CPU-1 from
halted state. Other thing is, could it be a stale interrupt, delivered
late? As I do not see any such prints after that.

Regards
Nikunj




diff --git a/cpus.c b/cpus.c
index 9bed61e..f6cfe65 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1638,6 +1638,8 @@ void resume_all_vcpus(void)
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
     CPU_FOREACH(cpu) {
         cpu_resume(cpu);
+        fprintf(stderr, "%s-cpu%d: stop %d stopped %d halted %d\n",
+                __func__, cpu->cpu_index, cpu->stop, cpu->stopped, cpu->halted);
     }
 }
 
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 224184d..14823a8 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -702,8 +702,14 @@ uint64_t cpu_ppc_load_purr (CPUPPCState *env)
  */
 static inline void cpu_ppc_decr_excp(PowerPCCPU *cpu)
 {
+    CPUState *cs = CPU(cpu);
+    CPUPPCState *env = &cpu->env;
     /* Raise it */
     LOG_TB("raise decrementer exception\n");
+    if (first_cpu != cs) {
+        fprintf(stderr, "%s-cpu%d: stop %d stopped %d halted %d SPR_LPCR %llx\n",
+                __func__, cs->cpu_index, cs->stop, cs->stopped, cs->halted, (env->spr[SPR_LPCR] & LPCR_P8_PECE3));
+    }
     ppc_set_irq(cpu, PPC_INTERRUPT_DECR, 1);
 }
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ea278ce..5d01081 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -86,6 +86,10 @@ static void spapr_cpu_reset(void *opaque)
     cs->halted = 1;
 
     env->spr[SPR_HIOR] = 0;
+    if (first_cpu != cs) {
+        fprintf(stderr, "%s-cpu%d: stop %d stopped %d halted %d SPR_LPCR %llx\n",
+                __func__, cs->cpu_index, cs->stop, cs->stopped, cs->halted, (env->spr[SPR_LPCR] & LPCR_P8_PECE3));
+    }
 
     /*
      * This is a hack for the benefit of KVM PR - it abuses the SDR1
