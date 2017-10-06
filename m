Received: from eggs.gnu.org ([2001:4830:134:3::10]:53829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1e0NLb-0006My-I8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1e0NLV-0001IP-K9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:47:03 -0400
Message-ID: <1507275993.25065.142.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 06 Oct 2017 09:46:33 +0200
In-Reply-To: <87poa0g62t.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
References: <20171005164959.26024-1-clg@kaod.org>
	<87poa0g62t.fsf@localhost.localdomain.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Fri, 2017-10-06 at 11:40 +0530, Nikunj A Dadhania wrote:
> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>=20
> > Hello,
> >=20
> > When a CPU is stopped with the 'stop-self' RTAS call, its state
> > 'halted' is switched to 1 and, in this case, the MSR is not taken int=
o
> > account anymore in the cpu_has_work() routine. Only the pending
> > hardware interrupts are checked with their LPCR:PECE* enablement bit.
> >=20
> > If the DECR timer fires after 'stop-self' is called and before the CP=
U
> > 'stop' state is reached, the nearly-dead CPU will have some work to d=
o
> > and the guest will crash. This case happens very frequently with the
> > not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
> > occasionally fired but after 'stop' state, so no work is to be done
> > and the guest survives.
> >=20
> > I suspect there is a race between the QEMU mainloop triggering the
> > timers and the TCG CPU thread but I could not quite identify the root
> > cause. To be safe, let's disable the decrementer interrupt in the LPC=
R
> > when the CPU is halted and reenable it when the CPU is restarted.
>=20
> Moreover, disabling the DECR in the reset path solves the TCG multi cpu
> reboot case, as reboot path does not call stop-cpu rtas call.

SHouldn't we do it in set_papr too and only turn it on for the boot CPU
and in start-cpu RTAS call ? Same with the other PECEs in fact...

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
