Received: from eggs.gnu.org ([2001:4830:134:3::10]:53676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9mU-0007bH-FM
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJ9mT-00012z-7f
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 22:36:10 -0400
Date: Fri, 9 Jun 2017 12:01:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609020141.GB26521@umbus.fritz.box>
References: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
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
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net, alex.bennee@linaro.org, bharata@linux.vnet.ibm.com


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 12:06:08PM +0530, Nikunj A Dadhania wrote:
> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.

Ouch.  When exactly did this happen?  I know that smp boot used to
work under TCG, albeit very slowly.

> When reset happens, all the CPUs are in halted state. First CPU is brough=
t out
> of reset and secondary CPUs would be initialized by the guest kernel usin=
g a
> rtas call start-cpu.
>=20
> However, in case of TCG, decrementer interrupts keep on coming and waking=
 the
> secondary CPUs up.

Ok.. how is that happening given that the secondary CPUs should have
MSR[EE] =3D=3D 0?

> These secondary CPUs would see the decrementer interrupt pending, which m=
akes
> cpu::has_work() to bring them out of wait loop and start executing
> tcg_exec_cpu().
>=20
> The problem with this is all the CPUs wake up and start booting SLOF imag=
e,
> causing the following exception(4 CPUs TCG VM):

[snip]
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index d10808d..eb88bcb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1013,6 +1013,13 @@ struct CPUPPCState {
>      int access_type; /* when a memory exception occurs, the access
>                          type is stored here */
> =20
> +    /* CPU in reset, shouldn't process any interrupts.
> +     *
> +     * Decrementer interrupts in TCG can still wake the CPU up. Make sur=
e that
> +     * when this variable is set, cpu_has_work_* should return false.
> +     */
> +    int in_reset;

So I'd really rather not add another flag to the cpu structure,
especially since we'd then need to migrate it as well.

I'm pretty sure there should be a way to inhibit the unwanted
interrupts using existing mechanisms.

> +
>      CPU_COMMON
> =20
>      /* MMU context - only relevant for full system emulation */
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 56a0ab2..64f4348 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8561,6 +8561,9 @@ static bool cpu_has_work_POWER7(CPUState *cs)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (cs->halted) {
> +        if (env->in_reset) {
> +            return false;
> +        }
>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>              return false;
>          }
> @@ -8718,6 +8721,9 @@ static bool cpu_has_work_POWER8(CPUState *cs)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (cs->halted) {
> +        if (env->in_reset) {
> +            return false;
> +        }
>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>              return false;
>          }
> @@ -8899,6 +8905,9 @@ static bool cpu_has_work_POWER9(CPUState *cs)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (cs->halted) {
> +        if (env->in_reset) {
> +            return false;
> +        }
>          if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>              return false;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOgGCAAoJEGw4ysog2bOSyRsQAI/5XRhXouJgHgfKTSoB4jT7
qncUgdaCuoZq/OkA9l3Z0Ab8+SdtNhGhdSi/FAdKkgwpmzIzo/W6i8yDPh48DP18
D44cvvSg6d3CaxNjzyUp3y/Vj+m3RQwNhPZkrCFF87I+S9uNsi3AGZNDOq+1iaty
9fKd4+lsg+2mWYrqjrUjCDtX1wKbyxhcUzIZy8Rb6awcW9u+NtRq/XtHW2cr1wJl
regXzQTI9t9tO1fAmo0Ll4LQbP8AwhXJhA3YgpVfOmXCFvMSVj0QqQaV7MhVGyvK
xO1T8NecHoI/2EpKMUbCufjAJKpq09mih8TrvBgNtRhRgbj97jiK5orGF57uAsL9
IcWQ+mpa611y6gQ6P2LPrP/oJlLjMEgtiaqH9cEg+BDnXY5BIyt3ROwZjlJci0eV
z7Nw98dN6q/FtByLKi8nlFIlYv0xESkyHCkdipgSQKdwMveMGJC7iNtJBXj9/3GL
/gXQFiMG1gVujaQIYTve+vqhL6OEnSKjdfswBiokBtZXCMaKvrHyZD6j6HaGlMPc
NHxvV478sxrkMd6t/KefnIOELXeopgMwEntg4Tfrv1sCTFUygXUaWA8RbmzuL6rZ
5i6PpGetjWgbVmlNa7CTK5/Y4YJI5eUsQ7z1d84n8JHbmz696u/6SCerjMejuEXZ
q5igx7RhSVWyeRY/Tgu0
=Vbjr
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
