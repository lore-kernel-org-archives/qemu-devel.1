Received: from eggs.gnu.org ([2001:4830:134:3::10]:36536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0Lu1-0004VN-33
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1e0Ltx-0006Fm-Tt
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:14:29 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:54694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1e0Ltx-0006Em-Lo
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 02:14:25 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 70A93133A22
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 08:14:23 +0200 (CEST)
References: <20171005164959.26024-1-clg@kaod.org>
	<87poa0g62t.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0759d1ad-577e-060a-6c1d-6273cb6684ea@kaod.org>
Date: Fri, 6 Oct 2017 08:14:13 +0200
MIME-Version: 1.0
In-Reply-To: <87poa0g62t.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] disable the decrementer interrupt when
 a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>

On 10/06/2017 08:10 AM, Nikunj A Dadhania wrote:
> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>=20
>> Hello,
>>
>> When a CPU is stopped with the 'stop-self' RTAS call, its state
>> 'halted' is switched to 1 and, in this case, the MSR is not taken into
>> account anymore in the cpu_has_work() routine. Only the pending
>> hardware interrupts are checked with their LPCR:PECE* enablement bit.
>>
>> If the DECR timer fires after 'stop-self' is called and before the CPU
>> 'stop' state is reached, the nearly-dead CPU will have some work to do
>> and the guest will crash. This case happens very frequently with the
>> not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
>> occasionally fired but after 'stop' state, so no work is to be done
>> and the guest survives.
>>
>> I suspect there is a race between the QEMU mainloop triggering the
>> timers and the TCG CPU thread but I could not quite identify the root
>> cause. To be safe, let's disable the decrementer interrupt in the LPCR
>> when the CPU is halted and reenable it when the CPU is restarted.
>=20
> Moreover, disabling the DECR in the reset path solves the TCG multi cpu
> reboot case, as reboot path does not call stop-cpu rtas call.

yes. I was going to restart the thread on the topic.=20

Let's how these two little patches are discussed. Then we/you can=20
resend the missing hunk in reset which is needed to perform a TCG=20
reboot.

Thanks, =20

C.


> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 3e20b1d886..c5150ee590 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -86,6 +86,15 @@ static void spapr_cpu_reset(void *opaque)
>      cs->halted =3D 1;
> =20
>      env->spr[SPR_HIOR] =3D 0;
> +    /* Disable DECR for secondary cpus */
> +    if (cs !=3D first_cpu) {
> +        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> +            env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
> +        } else {
> +            /* P7 and P8 both have same bit for DECR */
> +            env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
> +        }
> +    }
>  }
> =20
>  static void spapr_cpu_destroy(PowerPCCPU *cpu)
>=20
>=20
> Regards
> Nikunj
>=20
