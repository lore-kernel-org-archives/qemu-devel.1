Received: from eggs.gnu.org ([2001:4830:134:3::10]:42440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXKUb-0002j4-Pn
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXKUa-0002vh-L3
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:52:17 -0400
Date: Tue, 18 Jul 2017 14:46:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170718044619.GC3140@umbus.fritz.box>
References: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: disable decrementer during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2017 at 09:46:39AM +0530, Nikunj A Dadhania wrote:
> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
>=20
> When reset happens, all the CPUs are in halted state. First CPU is brough=
t out
> of reset and secondary CPUs would be initialized by the guest kernel usin=
g a
> rtas call start-cpu.
>=20
> However, in case of TCG, decrementer interrupts keep on coming and waking=
 the
> secondary CPUs up.
>=20
> These secondary CPUs would see the decrementer interrupt pending, which m=
akes
> cpu::has_work() to bring them out of wait loop and start executing
> tcg_exec_cpu().
>=20
> The problem with this is all the CPUs wake up and start booting SLOF imag=
e,
> causing the following exception(4 CPUs TCG VM):

Ok, I'm still trying to understand why the behaviour on reboot is
different from the first boot.  AFAICT on initial boot, the LPCR will
have DEE / PECE3 enabled.  So why aren't we getting the same problem
then?


>=20
> [   81.440850] reboot: Restarting system
>=20
> SLOF
> S
> SLOF
> SLOFLOF[0[0m ************************************************************=
**********
> QEMU Starting
>  Build Date =3D Mar  3 2017 13:29:19
>  FW Version =3D git-66d250ef0fd06bb8
> [0m **********************************************************************
> QEMU Starting
>  Build Date =3D Mar  3 2017 13:29:19
>  FW Version =3D git-66d250ef0fd06bb8
> [0m *************************************m**********[?25l ***************=
*******************************************************
> QEMU Starting
>  Build Date =3D Mar  3 2017 13:29:19
>  FW Version =3D git-66d250ef0fd06bb8
> ***********************
> QEMU Starting
>  Build Date =3D Mar  3 2017 13:29:19
>  FW Version =3D git-66d250ef0fd06bb8
> ERROR: Flatten device tree not available!
>=20
>  exception 300
> SRR0 =3D 00000000000060e4  SRR1 =3D 800000008000000000000000
> SPRG2 =3D 0000000000400000  SPRG3 =3D 0000000000004bd8
> ERROR: Flatten device tree not available!
>=20
>  exception 300
> SRR0 =3D 00000000000060e4  SRR1 =3D 800000008000000000000000
> SPRG2 =3D 0000000000400000  SPRG3 =3D 0000000000004bd8
>=20
> During reset, disable decrementer interrupt for secondary CPUs and enable=
 them
> when the secondary CPUs are brought online by rtas start-cpu call.
>=20
> Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr_cpu_core.c | 9 +++++++++
>  hw/ppc/spapr_rtas.c     | 8 ++++++++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ea278ce..bbfe8c2 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -87,6 +87,15 @@ static void spapr_cpu_reset(void *opaque)
> =20
>      env->spr[SPR_HIOR] =3D 0;
> =20
> +    /* Disable DECR for secondary cpus */
> +    if (cs !=3D first_cpu) {
> +        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> +            env->spr[SPR_LPCR] &=3D ~LPCR_DEE;
> +        } else {
> +            /* P7 and P8 both have same bit for DECR */
> +            env->spr[SPR_LPCR] &=3D ~LPCR_P8_PECE3;
> +        }
> +    }
>      /*
>       * This is a hack for the benefit of KVM PR - it abuses the SDR1
>       * slot in kvm_sregs to communicate the userspace address of the
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 94a2799..4623d1d 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -174,6 +174,14 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMa=
chineState *spapr,
>          kvm_cpu_synchronize_state(cs);
> =20
>          env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
> +
> +        /* Enable DECR interrupt */
> +        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
> +            env->spr[SPR_LPCR] |=3D LPCR_DEE;
> +        } else {
> +            /* P7 and P8 both have same bit for DECR */
> +            env->spr[SPR_LPCR] |=3D LPCR_P8_PECE3;
> +        }
>          env->nip =3D start;
>          env->gpr[3] =3D r3;
>          cs->halted =3D 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlltkpkACgkQbDjKyiDZ
s5KKww//Rot/e4vuaqxc6yE4hq2HZNn02YK2hvGanVtZOQziumNs0LSOtfdRCtrl
BBJkjgBfnVH0IwAI9qB2rOpBeqhL7FFky5SDhieviL9qaSeSirJHdsWWp4apwP4N
CSAlltgbgXg8OdnLXA8EAzKs9x/w0A473aRWV2yhKzZru51WsLLVqj7qXoLZfuXr
QhqFS9Teq3ow3si5M8RxGTi8pCgdVE3DQONfaNdHwNgLNnUh0+lRioAyOCV7MH73
1G2yNw+0594BNhu6ZZMqNp05zTwLvcg9RWnmpHPoQ4uDE/S900Sy3RE20FhfITBW
wYSzJI8P5dicNzEtKL07Yn1smGSmTGSDYuMuQP7SDMsB7xRoKylZPNMOiEzPJt1r
KPbc/UfTvvuSSyv+BF4PPkFFGNWjkxMsekZu1GwAyN8x9AuI6Foce5u82FEs0Q23
ZEcktHTpvjvbm37VDRA38mjQWgXBnwHe9wiuh078sN1mNJ8pZjYpmLksnn0ATT+0
mXqDGZT3QSDjzC8XkaZoIhm7Ip2Chuxe4G2UNuXu3CzpoI7wsfiQrlchrt0H8VyB
hSbV0FD8DR0ntG3hvtumVBWq6iZZ8MsCvegohmA8pYnxNdoserF7X0/n212+EOj3
OV7A93k6umFYtNf73QYRMrx7FsCP/SxoYCSw+5SITUDutmPPAuw=
=Skib
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--
