Received: from eggs.gnu.org ([2001:4830:134:3::10]:41027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ddTRK-0002Os-Om
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 23:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ddTRJ-0001yn-IX
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 23:38:18 -0400
Date: Fri, 4 Aug 2017 13:10:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170804031019.GG6553@umbus.fritz.box>
References: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
	<696b158f34bcf950f95709927f7496b5a4426229.1501740002.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Content-Disposition: inline
In-Reply-To: <696b158f34bcf950f95709927f7496b5a4426229.1501740002.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] ppc: spapr: Make VCPU ID handling
 private to SPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 04:28:52PM +1000, Sam Bobroff wrote:
> The concept of a VCPU ID that differs from the CPU's index
> (cpu->cpu_index) exists only within SPAPR machines so, move the
> functions ppc_get_vcpu_id() and ppc_get_cpu_by_vcpu_id() into spapr.c
> and rename them appropriately.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Mostly good, but...

[snip]
> +int spapr_vcpu_id(PowerPCCPU *cpu)
> +{
> +    return cpu->vcpu_id;
> +}
> +
> +PowerPCCPU *spapr_find_cpu(int vcpu_id)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        if (cpu->vcpu_id =3D=3D vcpu_id) {
> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}

[...]
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7ccb350c5f..2bf2727860 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -512,7 +512,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *o=
bj_path)
> =20
>  unsigned long kvm_arch_vcpu_id(CPUState *cpu)
>  {
> -    return ppc_get_vcpu_id(POWERPC_CPU(cpu));
> +    return spapr_vcpu_id(POWERPC_CPU(cpu));
>  }

Here you've replaced an implicit dependency on spapr details in the
generic code with an explicit dependency on spapr details.  That's the
wrong direction.

Instead _this_ one should directly reference vcpu_id, the spapr one
should be something like:

	if (kvm)
		return kvm_arch_vcpu_id(...)
	else
		return cpu_index;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmD5ZkACgkQbDjKyiDZ
s5Iziw//YzneYGFfCqZ0eJLoPBsXGlVpOu8y8dDp50LjPT2tg3tzR6xZGwJsIYx8
mFTL62Si/8nzHhWT7v97INFWwcsVKV8alBFhhY6PHbNWiYCNLiovKqHwJjwoW24a
lywQ1oZk4YNh4iuRkRjltAjMQruWRffoX6xCO6WzUssBbLbGXCvIL+Xa9YkLDQCG
nX1AGfJHnjnL3derBV7ZPl9QZ7aKp/Fi1c9n8ThO0sCgRnSz+hsF72BE3wpuM9Qs
xTbE7c+6Mrfz6bbDqSW24kkHb9LqrDysiouoLhoJtxTo8jz2WJPgjXKWATD0X/pa
pJgxMk64wznNe6Pprk5sYc5MEZmgM/Zld++jh5q6KTItN09P43xVwMBaNZ4A6lCO
bgmk81t0cALvRcGRE2DkDYn6r+eE4bLCoRr3t2zwMCkLt48EYwSPi3PA24hQ3Y2N
g/0Z6BKxHKLGP9DQkwucQIR7/0JYOmoTBz6Oa1Zr5dTX4zxXIrdjBvGTRpWUOXXl
l9wqnCKfI76vssJ1bOsy2HmHyGOdn4edJd99PdUNcBI/McHb2foFnnjEv8BVzbyD
zao9tRf1ksqKBRBK6+5AL6cl2m0c2M+hke60qV8zWCtijxOdarIT0GlcKeT8Z3N5
dE6Y0l7ze6DQRH+uS3EXF+/dmhM72cKKaRsch04d809NfGL/m4A=
=QLAP
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--
