Received: from eggs.gnu.org ([2001:4830:134:3::10]:53908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUY-00023H-V1
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUX-0004Ez-Ot
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:34 -0400
Date: Fri, 4 May 2018 10:12:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504001223.GI13229@umbus.fritz.box>
References: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
	<152538218900.223014.9011319433623501285.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sh9dYexoRflRb0jn"
Content-Disposition: inline
In-Reply-To: <152538218900.223014.9011319433623501285.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/3] target/ppc: always set PPC_MEM_TLBIE
 in pre 2.8 migration hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--Sh9dYexoRflRb0jn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 11:16:29PM +0200, Greg Kurz wrote:
> The pseries-2.7 and older machine types require CPUPPCState::insns_flags
> to be strictly equal between source and destination. This checking is
> abusive and breaks migration of KVM guests when the host CPU models
> are different, even if they are compatible enough to allow the guest
> to run transparently. This buggy behaviour was fixed for pseries-2.8
> and we added some hacks to allow backward migration of older machine
> types. These hacks assume that the CPU belongs to the POWER8 family,
> which was true for most KVM based setup we cared about at the time.
> But now POWER9 systems are coming, and backward migration of pre 2.8
> guests running in POWER8 architected mode from a POWER9 host to a
> POWER8 host is broken:
>=20
> qemu-system-ppc64: error while loading state for instance 0x0 of device
>  'cpu'
> qemu-system-ppc64: load of migration failed: Invalid argument
>=20
> This happens because POWER9 doesn't set PPC_MEM_TLBIE in insns_flags,
> while POWER8 does. Let's force PPC_MEM_TLBIE in the migration hack to
> fix the issue. This is an acceptable hack because these old machine
> types only support CPU models that do set PPC_MEM_TLBIE.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/ppc/machine.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 3d6434a006fa..ba1b9e531f97 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -212,6 +212,11 @@ static int cpu_pre_save(void *opaque)
>              ;
>          cpu->mig_msr_mask =3D env->msr_mask & ~metamask;
>          cpu->mig_insns_flags =3D env->insns_flags & insns_compat_mask;
> +        /* CPU models supported by old machines all have PPC_MEM_TLBIE,
> +         * so we set it unconditionally to allow backward migration from
> +         * a POWER9 host to a POWER8 host.

So.. the comment's slightly misleading.  This code is common to all
cpus, not just those used on pseries, so across that set it's not
really accurate.  But pseries is the only machine we support migration
to/from old versions with so it doesn't really matter.

> +         */
> +        cpu->mig_insns_flags |=3D PPC_MEM_TLBIE;
>          cpu->mig_insns_flags2 =3D env->insns_flags2 & insns_compat_mask2;
>          cpu->mig_nb_BATs =3D env->nb_BATs;
>      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Sh9dYexoRflRb0jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrrpWcACgkQbDjKyiDZ
s5JGNBAAlRD7Y6kKWViTESGymWg7dnXFi1KU/QjAMt4Ie4cJqmfVMxf/+4md1oy7
5MYQnGPTOO9aYXb6rtcPwlac2mun+7+1lskRxrKErUsVAkvle71Ad2OWZWT+eCIs
oNbQZ+XbopA61kLOzbEUJvLkKcrqslxlFDEf494WnLJvG8+Ey9hWG/t5vndvp9vY
pWFmmssqY78bCJ/bhqcqM46urcb5ZkpL5SaOaZ5UMxVJHNgkaz7ha3IQwuvJ9M/n
s1xXtU0fyJI3WdUnZHl8wusyx8WDr5s2C+9lrnSLERS6lRlAsgUqKCp5F3zbGE9i
9G2I7y7XgMoCRco5FP9NP2HlGiLqz38b5NDgh3pHeg0U1A3R8Eij0hs38U4BD1tT
eK+wtjPi2DgZMPyQ9fA9hE47qVXa8psQKF2S/986iaOqKVYiDWwhm7M0J5SagrKT
OTZNM9bqkxipKjUDvLjZubP5mzo4gB1c37EsdSjxwm57LTIE2sliEgaAsoRBQLG3
qCfgvJUiZOH8MRJFh5UhGwEEQIS4AWmn2riZbX4cfg74Obka3YPjocAu2Dx8tAHg
a9or+f3MiAWqSDy44hMmkprJfR+6VYg+lqVHrK1ECk+6VXoL6HoZmN3EW8bPJNhI
CnyjbG+24C2smnQcN0Y0PSCsv8JR+fvS1DvuPCOcvlwvmKwMSDk=
=5/+O
-----END PGP SIGNATURE-----

--Sh9dYexoRflRb0jn--
