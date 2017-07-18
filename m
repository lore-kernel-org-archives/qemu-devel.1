Received: from eggs.gnu.org ([2001:4830:134:3::10]:50157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dXL3G-0006dv-Dy
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dXL3D-000898-7f
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:28:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49082
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dXL3D-00087U-1H
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:28:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I5Nsko020725
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:28:01 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bsbdesstg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:28:01 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 15:27:58 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20170718044619.GC3140@umbus.fritz.box>
References: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
	<20170718044619.GC3140@umbus.fritz.box>
Date: Tue, 18 Jul 2017 10:47:44 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tjme32f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

> On Mon, Jul 17, 2017 at 09:46:39AM +0530, Nikunj A Dadhania wrote:
>> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
>> 
>> When reset happens, all the CPUs are in halted state. First CPU is brought out
>> of reset and secondary CPUs would be initialized by the guest kernel using a
>> rtas call start-cpu.
>> 
>> However, in case of TCG, decrementer interrupts keep on coming and waking the
>> secondary CPUs up.
>> 
>> These secondary CPUs would see the decrementer interrupt pending, which makes
>> cpu::has_work() to bring them out of wait loop and start executing
>> tcg_exec_cpu().
>> 
>> The problem with this is all the CPUs wake up and start booting SLOF image,
>> causing the following exception(4 CPUs TCG VM):
>
> Ok, I'm still trying to understand why the behaviour on reboot is
> different from the first boot.

During first boot, the cpu is in the stopped state, so
cpus.c:cpu_thread_is_idle returns true and CPU remains in halted state
until rtas start-cpu. Therefore, we never check the cpu_has_work()

In case of reboot, all CPUs are resumed after reboot. So we check the
next condition cpu_has_work() in cpu_thread_is_idle(), where we see a
DECR interrupt and remove the CPU from halted state as the CPU has work.

> AFAICT on initial boot, the LPCR will
> have DEE / PECE3 enabled.  So why aren't we getting the same problem
> then?

Regards
Nikunj
