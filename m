Received: from eggs.gnu.org ([2001:4830:134:3::10]:50750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZdfC-0005Ng-80
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZdf9-0007wK-3U
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:17:02 -0500
Date: Fri, 12 Jan 2018 01:16:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180111141622.GI24770@umbus.fritz.box>
References: <20180106004722.1152-1-joserz@linux.vnet.ibm.com>
	<20180106004722.1152-2-joserz@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r4QXMf6/kyF/FvJJ"
Content-Disposition: inline
In-Reply-To: <20180106004722.1152-2-joserz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] spapr: Check SMT based on
 KVM_CAP_PPC_SMT_POSSIBLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--r4QXMf6/kyF/FvJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2018 at 10:47:22PM -0200, Jose Ricardo Ziviani wrote:
> Power9 supports 4 HW threads/core but it's possible to emulate
> doorbells to implement virtual SMT. KVM has the KVM_CAP_PPC_SMT_POSSIBLE
> which returns a bitmap with all SMT modes supported by the host.
>=20
> Today, QEMU forces the SMT mode based on PVR compat table, this is
> silently done in spapr_fixup_cpu_dt. Then, if user passes thread=3D8 the
> guest will end up with 4 threads/core without any feedback to the user.
> It is confusing and will crash QEMU if a cpu is hotplugged in that
> guest.
>=20
> This patch makes use of KVM_CAP_PPC_SMT_POSSIBLE to check if the host
> supports the SMT mode so it allows Power9 guests to have 8 threads/core
> if desired.
>=20
> Reported-by: Satheesh Rajendran <satheera@in.ibm.com>
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
> ---
>  hw/ppc/spapr.c       | 14 +++++++++++++-
>  hw/ppc/trace-events  |  1 +
>  target/ppc/kvm.c     |  5 +++++
>  target/ppc/kvm_ppc.h |  6 ++++++
>  4 files changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d1acfe8858..ea2503cd2f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -345,7 +345,19 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachin=
eState *spapr)
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
>          int index =3D spapr_vcpu_id(cpu);
> -        int compat_smt =3D MIN(smp_threads, ppc_compat_max_threads(cpu));
> +
> +        /* set smt to maximum for this current pvr if the number
> +         * passed is higher than defined by PVR compat mode AND
> +         * if KVM cannot emulate it.*/
> +        int compat_smt =3D smp_threads;
> +        if ((kvmppc_cap_smt_possible() & smp_threads) !=3D smp_threads &&
> +                smp_threads > ppc_compat_max_threads(cpu)) {
> +            compat_smt =3D ppc_compat_max_threads(cpu);

I don't think this is the right approach.  We've been trying to remove
places where host properties (such as those read from KVM
capabilities) affect guest visible properties of the VM - like vsmt.
Places like that break migration and often libvirt expectations as
well.

This is putting one back in, and so a step in the wrong direction.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r4QXMf6/kyF/FvJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpXcbMACgkQbDjKyiDZ
s5K5AhAAo8lpUJNA79k+1tyeI2ex8/CbS7OUWrpH+aVGkryiAv153dDBvpwDHaTX
DcQuA0tI4y2whrP8nGzATD/AHqUcoHmO7Gd6W9N+pb7nh/pah6rPWcxJLupMZ+iy
0HCC6lIgMPBYFzBgeb25LFCeboSMJ3E6lx1I9mYn5RjDJVVSvl8i0Ku6Oo1wFrBa
EHWwi6aWD7sCC9IxC4Ij/1fZvzI0Q2i6qfz04bSiJYfB20V/Ji0EqM2tnyPEdm2A
T5co3UeSGtxwekSO3WpKP/TzITEe1qoY3gR0u6Cgq61Qg8CIYx7YBeIto5p+KvfN
DUUk6b+8TSzrA+BUqNEsWl4+hQ2qz7Jh33jxAgCJL25zl7bzFGW69snGdME2D7Ci
NoS2uZrj1RBzlr3KyBQlKrFuhSFPFdFlioXAcFB0eHHxkWVkq9uOl31QPNjM6EBY
5Vo/dIFSfFaw6SEMxQi1tR6s7yHspg2u8dFLmSTb2HWlywBj6BgfAOauCmoZawEf
XKLHb6Ohf6qbdQFMe37nIm0pKFo7rx45Y5TpYxR3WbjFke/z5wU7JiDHBp9Mvzn4
G/WseoHjGbrXXhgPPAgEDvEabj+mXnS60av2BjfJTv+JHtO/jOho2A8zzOW0RP2W
XEpmqD0bU9R6KGGuV1Ud2IMnG9kMNrvDzrK72lGyw/csTgyDaN0=
=ra7u
-----END PGP SIGNATURE-----

--r4QXMf6/kyF/FvJJ--
