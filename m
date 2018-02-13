Received: from eggs.gnu.org ([2001:4830:134:3::10]:44383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elk8y-00025T-7W
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 18:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elk8u-0005ST-RW
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 18:37:48 -0500
Date: Wed, 14 Feb 2018 10:29:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180213232935.GA3437@umbus.fritz.box>
References: <20180213173716.21358-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20180213173716.21358-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/ppc/spapr_hcall: set htab_shift
 after kvmppc_resize_hpt_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 03:37:16PM -0200, Daniel Henrique Barboza wrote:
1;5002;0c> Newer kernels have a htab resize capability when adding or remove
> memory. At these situations, the guest kernel might reallocate its
> htab to a more suitable size based on the resulting memory.
>=20
> However, we're not setting the new value back into the machine state
> when a KVM guest resizes its htab. At first this doesn't seem harmful,
> but when migrating or saving the guest state (via virsh managedsave,
> for instance) this mismatch between the htab size of QEMU and the
> kernel makes the guest hangs when trying to load its state.
>=20
> Inside h_resize_hpt_commit, the hypercall that commits the hash page
> resize changes, let's set spapr->htab_shift to the new value if we're
> sure that kvmppc_resize_hpt_commit were successful.
>=20
> While we're here, add a "not RADIX" sanity check as it is already done
> in the related hypercall h_resize_hpt_prepare.
>=20
> Fixes: https://github.com/open-power-host-os/qemu/issues/28
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Ouch.  Good catch.  I'm kind of astonished this didn't break even
worse than it did.  Applied.

> ---
>  hw/ppc/spapr_hcall.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 76422cfac1..1986560480 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -731,11 +731,21 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU =
*cpu,
>          return H_AUTHORITY;
>      }
> =20
> +    if (!spapr->htab_shift) {
> +        /* Radix guest, no HPT */
> +        return H_NOT_AVAILABLE;
> +    }
> +
>      trace_spapr_h_resize_hpt_commit(flags, shift);
> =20
>      rc =3D kvmppc_resize_hpt_commit(cpu, flags, shift);
>      if (rc !=3D -ENOSYS) {
> -        return resize_hpt_convert_rc(rc);
> +        rc =3D resize_hpt_convert_rc(rc);
> +        if (rc =3D=3D H_SUCCESS) {
> +            /* Need to set the new htab_shift in the machine state */
> +            spapr->htab_shift =3D shift;
> +        }
> +        return rc;
>      }
> =20
>      if (flags !=3D 0) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqDdNwACgkQbDjKyiDZ
s5LEiQ/+In1R5DpkhSKb86mE0US4FKP5pcW+zVdWSI+/Ey4bs09MND5NdigUlGaq
xLB9zrtYjPQR9XS+RVp45MS3kn3Sh56GIYCTnUcKutAnCqc7hCDPFgCQOZmwG16k
xqQgnRxwuEqQ+2AZIVDPKClE6LSGviAFw5zkYed0XltleO0AONSonJ7Eu8OsCoIo
I/EgPwZ0rE+yaPbMkfJVbExqTnMzuRIyE0LH5q12ZmxEkArMt80ATYmhkQzMNYyH
trZodZkfRZLsjCsZp283iB+OybMNblDHcvAmzFwxOzJzTcmiG0AjgBT9TNia6Boj
N9u1vG9a0Bj4Ovq/hCQENEd1SJxL+H/ZQkWwkUAqcRI8PXVZX0o0Y0dlcBAKII1G
07szIMiqSJ+A3fMYXY8oAlVc0zOLSKww269pYs/KK9KgUb0ZjS+/3XSw6ueOcEiM
1UQH5dRdPPqmwaCWCW/gvHk/sCZW5aGdjnzC3ADpKZgAbRBr4OiAcIQOADqsOAh5
tsjH1DLAXB2HJuBu8te67FdkNm0CKC24ETm845iPOwLl7NOL6np3tpqdxaiar3xh
sPr2/ajyh3+6XFzewyNO3AUqvZCadeZkDKYRJl5pJF0xLMedLLFxdlnVe7GLFpg6
8Zu21xcrQ64d7IYtsT5kDMtCd/PEpBkDHGMG0/etNuN4DZ71+c0=
=kVwY
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
