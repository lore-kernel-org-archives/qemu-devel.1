Received: from eggs.gnu.org ([2001:4830:134:3::10]:35729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dVVth-0008Kw-NY
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 00:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dVVtd-0006Qh-90
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 00:38:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46550
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dVVtd-0006PI-3U
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 00:38:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D4YCq8069261
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 00:38:35 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bnt3pxwb4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 00:38:34 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 14:38:31 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170609102714.GK26521@umbus.fritz.box>
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
	<20170609020141.GB26521@umbus.fritz.box>
	<87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170609102714.GK26521@umbus.fritz.box>
Date: Thu, 13 Jul 2017 10:08:13 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87eftlar4a.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

> On Fri, Jun 09, 2017 at 10:32:25AM +0530, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>> 
>> > On Thu, Jun 08, 2017 at 12:06:08PM +0530, Nikunj A Dadhania wrote:
>> >> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
>> >
>> > Ouch.  When exactly did this happen?
>> 
>> Broken since long
>> 
>> > I know that smp boot used to work under TCG, albeit very slowly.
>> 
>> SMP boot works, its the reboot issued from the guest doesn't boot and
>> crashes in SLOF.
>
> Oh, sorry, I misunderstood.
>
>> 
>> >> When reset happens, all the CPUs are in halted state. First CPU is brought out
>> >> of reset and secondary CPUs would be initialized by the guest kernel using a
>> >> rtas call start-cpu.
>> >> 
>> >> However, in case of TCG, decrementer interrupts keep on coming and waking the
>> >> secondary CPUs up.
>> >
>> > Ok.. how is that happening given that the secondary CPUs should have
>> > MSR[EE] == 0?
>> 
>> Basically, the CPU is in halted condition and has_work() does not check
>> for MSR_EE in that case. But I am not sure if checking MSR_EE is
>> sufficient, as the CPU does go to halted state (idle) while running as
>> well.
>
> Ok, but we definitely should be able to fix this without new
> variables.  If we can quiesce the secondary CPUs for the first boot,
> we should be able to duplicate that for subsequent boots.

How about the following, we do not report work until MSR_EE is disabled:

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 783bf98..2cac98a 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8527,6 +8527,9 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cs->halted) {
+        if (!msr_ee) {
+            return false;
+        }
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
@@ -8684,6 +8687,9 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cs->halted) {
+        if (!msr_ee) {
+            return false;
+        }
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
@@ -8865,6 +8871,9 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cs->halted) {
+        if (!msr_ee) {
+            return false;
+        }
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }

Regards
Nikunj
