Received: from eggs.gnu.org ([2001:4830:134:3::10]:54472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4gKy-0001a9-4u
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4gKv-0007rs-37
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:52:12 -0400
Date: Wed, 18 Oct 2017 15:23:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171018042314.GQ2776@umbus.fritz.box>
References: <150826975484.20019.5107463804719679762.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2mNuWrpDTYoom6W8"
Content-Disposition: inline
In-Reply-To: <150826975484.20019.5107463804719679762.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] ppc: fix setting of compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--2mNuWrpDTYoom6W8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2017 at 09:49:14PM +0200, Greg Kurz wrote:
> While trying to make KVM PR usable again, commit 5dfaa532ae introduced a
> regression: the current compat_pvr value is passed to KVM instead of the
> new one. This means that we always pass 0 instead of the max-cpu-compat
> PVR during the initial machine reset. And at CAS time, we either pass
> the PVR from the command line or even don't call kvmppc_set_compat() at
> all, ie, the PCR will not be set as expected.
>=20
> For example if we start a big endian fedora26 guest in power7 compat
> mode on a POWER8 host, we get this in the guest:
>=20
> $ cat /proc/cpuinfo
> processor       : 0
> cpu             : POWER7 (architected), altivec supported
> clock           : 4024.000000MHz
> revision        : 2.0 (pvr 004d 0200)
>=20
> timebase        : 512000000
> platform        : pSeries
> model           : IBM pSeries (emulated by qemu)
> machine         : CHRP IBM pSeries (emulated by qemu)
> MMU             : Hash
>=20
> but the guest can still execute POWER8 instructions, and the following
> program succeeds:
>=20
> int main()
> {
>         asm("vncipher 0,0,0"); // ISA 2.07 instruction
> }
>=20
> Let's pass the new compat_pvr to kvmppc_set_compat() and the program fails
> with SIGILL as expected.
>=20
> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Nice catch.  Applied to ppc-for-2.11.

> ---
>=20
> Cc'ing qemu-stable because the regression is present in 2.10.1... :-\
> ---
>  target/ppc/compat.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index f8729fe46d61..ad8f93c0644e 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -141,7 +141,7 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_=
pvr, Error **errp)
>      cpu_synchronize_state(CPU(cpu));
> =20
>      if (kvm_enabled() && cpu->compat_pvr !=3D compat_pvr) {
> -        int ret =3D kvmppc_set_compat(cpu, cpu->compat_pvr);
> +        int ret =3D kvmppc_set_compat(cpu, compat_pvr);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret,
>                               "Unable to set CPU compatibility mode in KV=
M");
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2mNuWrpDTYoom6W8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnm1zIACgkQbDjKyiDZ
s5JvzxAAxuE7PwZRB9aJZuV6Hv2QBfk/HrJp8PUtxu3x4w9QyZHzK9gD8zBpxsv0
NWqa9sIMZfCBXn+9n92dIlH4L3kbr44HUygJQ5Hh95mLZXzj5BgH//sFm2vZCdCo
a0DJAbBc8vWAvnP9ZwGzHmNwRXE6vYhzQkAeqL33r5nudi+4unIZPrHfWYMxhEjr
SrmIXtXXwA/XIl0SMufNgCK0F1jqB8OnEhOkMXA54uNnjCseibpfxchPK0OA1exP
woZdpHdYfy5i2DkxUnFDczYd20f1MG2rgrF92PXJCBHspi6Vei6QP8Spgexh4hQV
bXAQjtZ0i70C9j7OrJee623L+1tLPZjX3Q1EaC724995X7x4awh16pspZmZxzQ4v
LFL6H+4F6KyxeDzJ4pNffWwGPCLHRne2MXVVdSgA8XbfQWZuMeAFTu2Ydf+GtuwU
JF7tYIsP9WBHawURsKFrOA0Ekobw0PNdulAsA9jIl7trqCA6026Pngp3s+dk5g14
JVAAdFsYCkIHmH6Gqf9IUjb3LAltJ88UWXLIP7JdRNDRVvndVUV0Ylh4ADY8TBRs
NWJ2opezLbfRL5ZKfNNGfCC6QHVI4B7NN0tZq5Ffs/tEzi0ESqe5HjIJ8N1LJc82
bA3OEwWQawfmNz9mMQ9aJAjuxgypmIGlLJlHu/y58AyIJJC0yjI=
=/qNb
-----END PGP SIGNATURE-----

--2mNuWrpDTYoom6W8--
