Received: from eggs.gnu.org ([2001:4830:134:3::10]:50977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dVYz0-00048Y-41
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dVYyx-0001GQ-3C
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:56:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dVYyw-0001F7-PF
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 03:56:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6D7rbQg036588
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:56:17 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3r4nd4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:56:17 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 13 Jul 2017 17:56:14 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <b54ec156-725d-d954-1d05-ade845caa2a2@kaod.org>
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
	<20170609020141.GB26521@umbus.fritz.box>
	<87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170609102714.GK26521@umbus.fritz.box>
	<87eftlar4a.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<1ec762f9-d8b2-5195-1ffe-f4cde35571fd@kaod.org>
	<b54ec156-725d-d954-1d05-ade845caa2a2@kaod.org>
Date: Thu, 13 Jul 2017 13:25:59 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <878tjsbwj4.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC] spapr: ignore interrupts
 during reset state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: alex.bennee@linaro.org, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net

C=C3=A9dric Le Goater <clg@kaod.org> writes:

>>> How about the following, we do not report work until MSR_EE is disabled:
>>=20
>> With this fix, I could test the XIVE<->XICS transitions at reboot=20
>> under TCG. However, the second boot is very slow for some reason.=20
>
> hmm, I am not sure this is related but I just got :=20

Havent seen in my setup after around 10 reboot cycles, I was using 2
cores pseries setup. Lets give it some more testing. When did this
happen, during boot ?

>
> [   28.311559] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [mig=
ration/0:10]
> [   28.311856] Modules linked in:
> [   28.312058] CPU: 0 PID: 10 Comm: migration/0 Not tainted 4.12.0+ #10
> [   28.312165] task: c00000007a842c00 task.stack: c00000007a12c000
> [   28.312214] NIP: c0000000001bf6b0 LR: c0000000001bf788 CTR: c000000000=
1bf5b0
> [   28.312253] REGS: c00000007a12f9d0 TRAP: 0901   Not tainted  (4.12.0+)
> [   28.312284] MSR: 8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>

EE is enabled, so chances of interrupts getting ignored isnt there. More
over the code will trigger only when cs->halted is true.

> [   28.312399]   CR: 20004202  XER: 20040000
> [   28.312457] CFAR: c0000000001bf6c4 SOFTE: 1=20
> [   28.312457] GPR00: c0000000001bf9c8 c00000007a12fc50 c00000000147f000 =
0000000000000000=20
> [   28.312457] GPR04: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
> [   28.312457] GPR08: 0000000000000000 0000000000000001 0000000000000001 =
000000000000002b=20
> [   28.312457] GPR12: 0000000000000000 c00000000fdc0000=20
> [   28.313029] NIP [c0000000001bf6b0] multi_cpu_stop+0x100/0x1f0
> [   28.313074] LR [c0000000001bf788] multi_cpu_stop+0x1d8/0x1f0
> [   28.313136] Call Trace:
> [   28.313334] [c00000007a12fc50] [c00000007a12fd30] 0xc00000007a12fd30 (=
unreliable)
> [   28.313428] [c00000007a12fca0] [c0000000001bf9c8] cpu_stopper_thread+0=
xd8/0x220
> [   28.313480] [c00000007a12fd60] [c000000000113c10] smpboot_thread_fn+0x=
290/0x2a0
> [   28.313571] [c00000007a12fdc0] [c00000000010dc04] kthread+0x164/0x1b0
> [   28.313640] [c00000007a12fe30] [c00000000000b268] ret_from_kernel_thre=
ad+0x5c/0x74
> [   28.313742] Instruction dump:
> [   28.313924] 2fa90000 409e001c 813d0020 815d0010 39290001 915e0000 7c20=
04ac 913d0020=20
> [   28.314001] 2b9f0004 419e003c 7fe9fb78 7c210b78 <7c421378> 83fd0020 7f=
89f840 409eff94=20
>
> with 4 cores under mttcg.

Regards
Nikunj
