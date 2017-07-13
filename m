Received: from eggs.gnu.org ([2001:4830:134:3::10]:59010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVXyL-0005R6-Ml
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVXyG-00028f-RQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:51:37 -0400
Received: from 10.mo7.mail-out.ovh.net ([178.33.250.56]:56747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dVXyG-00027Y-L2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:51:32 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id C254061593
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:51:30 +0200 (CEST)
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
	<20170609020141.GB26521@umbus.fritz.box>
	<87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170609102714.GK26521@umbus.fritz.box>
	<87eftlar4a.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<1ec762f9-d8b2-5195-1ffe-f4cde35571fd@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b54ec156-725d-d954-1d05-ade845caa2a2@kaod.org>
Date: Thu, 13 Jul 2017 08:51:18 +0200
MIME-Version: 1.0
In-Reply-To: <1ec762f9-d8b2-5195-1ffe-f4cde35571fd@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
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
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: alex.bennee@linaro.org, bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net

On 07/13/2017 08:43 AM, C=E9dric Le Goater wrote:
> On 07/13/2017 06:38 AM, Nikunj A Dadhania wrote:
>> David Gibson <david@gibson.dropbear.id.au> writes:
>>
>>> On Fri, Jun 09, 2017 at 10:32:25AM +0530, Nikunj A Dadhania wrote:
>>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>>
>>>>> On Thu, Jun 08, 2017 at 12:06:08PM +0530, Nikunj A Dadhania wrote:
>>>>>> Rebooting a SMP TCG guest is broken for both single/multi threaded=
 TCG.
>>>>>
>>>>> Ouch.  When exactly did this happen?
>>>>
>>>> Broken since long
>>>>
>>>>> I know that smp boot used to work under TCG, albeit very slowly.
>>>>
>>>> SMP boot works, its the reboot issued from the guest doesn't boot an=
d
>>>> crashes in SLOF.
>>>
>>> Oh, sorry, I misunderstood.
>>>
>>>>
>>>>>> When reset happens, all the CPUs are in halted state. First CPU is=
 brought out
>>>>>> of reset and secondary CPUs would be initialized by the guest kern=
el using a
>>>>>> rtas call start-cpu.
>>>>>>
>>>>>> However, in case of TCG, decrementer interrupts keep on coming and=
 waking the
>>>>>> secondary CPUs up.
>>>>>
>>>>> Ok.. how is that happening given that the secondary CPUs should hav=
e
>>>>> MSR[EE] =3D=3D 0?
>>>>
>>>> Basically, the CPU is in halted condition and has_work() does not ch=
eck
>>>> for MSR_EE in that case. But I am not sure if checking MSR_EE is
>>>> sufficient, as the CPU does go to halted state (idle) while running =
as
>>>> well.
>>>
>>> Ok, but we definitely should be able to fix this without new
>>> variables.  If we can quiesce the secondary CPUs for the first boot,
>>> we should be able to duplicate that for subsequent boots.
>>
>> How about the following, we do not report work until MSR_EE is disable=
d:
>=20
> With this fix, I could test the XIVE<->XICS transitions at reboot=20
> under TCG. However, the second boot is very slow for some reason.=20

hmm, I am not sure this is related but I just got :=20

[   28.311559] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [mig=
ration/0:10]
[   28.311856] Modules linked in:
[   28.312058] CPU: 0 PID: 10 Comm: migration/0 Not tainted 4.12.0+ #10
[   28.312165] task: c00000007a842c00 task.stack: c00000007a12c000
[   28.312214] NIP: c0000000001bf6b0 LR: c0000000001bf788 CTR: c000000000=
1bf5b0
[   28.312253] REGS: c00000007a12f9d0 TRAP: 0901   Not tainted  (4.12.0+)
[   28.312284] MSR: 8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>
[   28.312399]   CR: 20004202  XER: 20040000
[   28.312457] CFAR: c0000000001bf6c4 SOFTE: 1=20
[   28.312457] GPR00: c0000000001bf9c8 c00000007a12fc50 c00000000147f000 =
0000000000000000=20
[   28.312457] GPR04: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[   28.312457] GPR08: 0000000000000000 0000000000000001 0000000000000001 =
000000000000002b=20
[   28.312457] GPR12: 0000000000000000 c00000000fdc0000=20
[   28.313029] NIP [c0000000001bf6b0] multi_cpu_stop+0x100/0x1f0
[   28.313074] LR [c0000000001bf788] multi_cpu_stop+0x1d8/0x1f0
[   28.313136] Call Trace:
[   28.313334] [c00000007a12fc50] [c00000007a12fd30] 0xc00000007a12fd30 (=
unreliable)
[   28.313428] [c00000007a12fca0] [c0000000001bf9c8] cpu_stopper_thread+0=
xd8/0x220
[   28.313480] [c00000007a12fd60] [c000000000113c10] smpboot_thread_fn+0x=
290/0x2a0
[   28.313571] [c00000007a12fdc0] [c00000000010dc04] kthread+0x164/0x1b0
[   28.313640] [c00000007a12fe30] [c00000000000b268] ret_from_kernel_thre=
ad+0x5c/0x74
[   28.313742] Instruction dump:
[   28.313924] 2fa90000 409e001c 813d0020 815d0010 39290001 915e0000 7c20=
04ac 913d0020=20
[   28.314001] 2b9f0004 419e003c 7fe9fb78 7c210b78 <7c421378> 83fd0020 7f=
89f840 409eff94=20

with 4 cores under mttcg.

Thanks,

C.
