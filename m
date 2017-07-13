Received: from eggs.gnu.org ([2001:4830:134:3::10]:55205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVXqg-0002wZ-Pn
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dVXqb-00064k-Ts
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:43:42 -0400
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:59009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dVXqb-00063s-MS
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 02:43:37 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 3143B61580
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:43:35 +0200 (CEST)
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
	<20170609020141.GB26521@umbus.fritz.box>
	<87mv9heota.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170609102714.GK26521@umbus.fritz.box>
	<87eftlar4a.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1ec762f9-d8b2-5195-1ffe-f4cde35571fd@kaod.org>
Date: Thu, 13 Jul 2017 08:43:26 +0200
MIME-Version: 1.0
In-Reply-To: <87eftlar4a.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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

On 07/13/2017 06:38 AM, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
>> On Fri, Jun 09, 2017 at 10:32:25AM +0530, Nikunj A Dadhania wrote:
>>> David Gibson <david@gibson.dropbear.id.au> writes:
>>>
>>>> On Thu, Jun 08, 2017 at 12:06:08PM +0530, Nikunj A Dadhania wrote:
>>>>> Rebooting a SMP TCG guest is broken for both single/multi threaded =
TCG.
>>>>
>>>> Ouch.  When exactly did this happen?
>>>
>>> Broken since long
>>>
>>>> I know that smp boot used to work under TCG, albeit very slowly.
>>>
>>> SMP boot works, its the reboot issued from the guest doesn't boot and
>>> crashes in SLOF.
>>
>> Oh, sorry, I misunderstood.
>>
>>>
>>>>> When reset happens, all the CPUs are in halted state. First CPU is =
brought out
>>>>> of reset and secondary CPUs would be initialized by the guest kerne=
l using a
>>>>> rtas call start-cpu.
>>>>>
>>>>> However, in case of TCG, decrementer interrupts keep on coming and =
waking the
>>>>> secondary CPUs up.
>>>>
>>>> Ok.. how is that happening given that the secondary CPUs should have
>>>> MSR[EE] =3D=3D 0?
>>>
>>> Basically, the CPU is in halted condition and has_work() does not che=
ck
>>> for MSR_EE in that case. But I am not sure if checking MSR_EE is
>>> sufficient, as the CPU does go to halted state (idle) while running a=
s
>>> well.
>>
>> Ok, but we definitely should be able to fix this without new
>> variables.  If we can quiesce the secondary CPUs for the first boot,
>> we should be able to duplicate that for subsequent boots.
>=20
> How about the following, we do not report work until MSR_EE is disabled=
:

With this fix, I could test the XIVE<->XICS transitions at reboot=20
under TCG. However, the second boot is very slow for some reason.=20

Tested-by: C=E9dric Le Goater <clg@kaod.org>

Thanks,

C.=20

> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 783bf98..2cac98a 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8527,6 +8527,9 @@ static bool cpu_has_work_POWER7(CPUState *cs)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (cs->halted) {
> +        if (!msr_ee) {
> +            return false;
> +        }
>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>              return false;
>          }
> @@ -8684,6 +8687,9 @@ static bool cpu_has_work_POWER8(CPUState *cs)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (cs->halted) {
> +        if (!msr_ee) {
> +            return false;
> +        }
>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>              return false;
>          }
> @@ -8865,6 +8871,9 @@ static bool cpu_has_work_POWER9(CPUState *cs)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (cs->halted) {
> +        if (!msr_ee) {
> +            return false;
> +        }
>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>              return false;
>          }
>=20
> Regards
> Nikunj
>=20
>=20
