Received: from eggs.gnu.org ([2001:4830:134:3::10]:54291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSsx9-00067T-HW
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSsx6-0001zH-C5
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 19:43:55 -0400
Date: Wed, 13 Jun 2018 09:43:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612234318.GL30690@umbus.fritz.box>
References: <20180612101135.23852-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Content-Disposition: inline
In-Reply-To: <20180612101135.23852-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2] xics_kvm: fix a build break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>


--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 12:11:35PM +0200, C=C3=A9dric Le Goater wrote:
> On CentOS 7.5, gcc-4.8.5-28.el7_5.1.ppc64le fails to build QEMU due to :
>=20
>   hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_state=E2=80=99:
>   hw/intc/xics_kvm.c:281:13: error: =E2=80=98ret=E2=80=99 may be used uni=
nitialized in this
>     function [-Werror=3Dmaybe-uninitialized]
>              return ret;
>=20
> Fix the breakage and also remove the extra error reporting as
> kvm_device_access() already provides a substantial error message.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>=20
>  Greg, can you please test ? RHEL7.5 does not catch the issue with the
>  same compiler level :/ I don't understand why.
>=20
>  hw/intc/xics_kvm.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 8bdf6afe82a0..8dba2f84e71e 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -186,8 +186,7 @@ static void ics_get_kvm_state(ICSState *ics)
>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>                            i + ics->offset, &state, false, &local_err);
>          if (local_err) {
> -            error_report("Unable to retrieve KVM interrupt controller st=
ate"
> -                    " for IRQ %d: %s", i + ics->offset, strerror(errno));
> +            error_report_err(local_err);
>              exit(1);
>          }
> =20
> @@ -273,11 +272,10 @@ static int ics_set_kvm_state(ICSState *ics, int ver=
sion_id)
>                  state |=3D KVM_XICS_QUEUED;
>          }
> =20
> -        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> -                          i + ics->offset, &state, true, &local_err);
> +        ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURC=
ES,
> +                                i + ics->offset, &state, true, &local_er=
r);
>          if (local_err) {
> -            error_report("Unable to restore KVM interrupt controller sta=
te"
> -                    " for IRQs %d: %s", i + ics->offset, strerror(errno)=
);
> +            error_report_err(local_err);
>              return ret;
>          }
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgWpYACgkQbDjKyiDZ
s5KctA//R5QaLdR3i78s6oh0ZWArYMEhj8hbje9bZC6L1DlP+dy6heWZIAasVVlU
EKx1BF3tKHBujzQSivjJ6+d+PcLx7R2DxzBJim7ulPf7ZA0/n/rCke+TpW3nW6E2
3qd66unKDd4ka6lR/UE2paHqvDj+Pm6ARmZx2mP0hXE1g3sXsuMex6S9uaLxohnc
OEUXW6OrneGuFzajewv8za6HjTO8+Q/tK5CCmGprlZ4fJKyNF2JoY7nkJ31keDpa
3yK7pCCsLmDcgc+plB6Wzl8SgjJ/mrlOISrR9nM76b9fIkoap5+C+LkgxbwkLwOy
0LMMXr1I9mgQgIcc16WthWeMZyYg6lQHm2xr7HNZj6pbHn/oG1LIyC+U3CJW3rdA
ljOTrNmnhdyami1nOVu6zG+fz2reOHpXVm6SthZGsR6Ylz33jTKyD49lqwJGkqww
waPY1Iy3YvSs9LjmVZByveKeJJ6qCR8PrFj8oOP7vOq0tEqzQzG+N0CbrS6cIVTp
I/XG9n1SsJMXLtiFqBBCQgYQEHKtmjCgq81Z9Sj4o8XIzwO/0kG1oXieCNQAaxBu
KS9PSEhe4MeO97lVGwt8Wms7Y8iNHXnDWCHVyFYflJ/DsLAz3I9DC5pqMY5KB4g8
xPDzZrDPWorMzRvKEhmisWq4/xw+aobzniarB4VcVzdgYezCE5E=
=uM+z
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--
