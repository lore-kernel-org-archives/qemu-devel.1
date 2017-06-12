Received: from eggs.gnu.org ([2001:4830:134:3::10]:42956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKLry-0006ju-ET
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKLrx-0006Ei-K8
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:42:46 -0400
Date: Mon, 12 Jun 2017 17:18:36 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170612091836.GF18542@umbus>
References: <1497245555-32472-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1497245555-32472-3-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Content-Disposition: inline
In-Reply-To: <1497245555-32472-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] spapr: Fix migration of Radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2017 at 11:02:35AM +0530, Bharata B Rao wrote:
> Fix migration of radix guests by ensuring that we issue
> KVM_PPC_CONFIGURE_V3_MMU for radix case post migration.
>=20
> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

I believe we shouldn't assume a particular existing state on the
destination when processing an incoming stream (it's normally done
immediatley after startup, but I'm not sure it has to be).

So, we shouldn't only call configure_v3_mmu when patb_entry !=3D 0.  For
the case of an incoming hash guest, I believe we should explicitly
configure KVM to HPT mode, rather than assume it's there already.

> ---
>  hw/ppc/spapr.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c425499..b2217f3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1443,6 +1443,18 @@ static int spapr_post_load(void *opaque, int versi=
on_id)
>          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
>      }
> =20
> +    if (spapr->patb_entry) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +        bool radix =3D !!(spapr->patb_entry & PATBE1_GR);
> +        bool gtse =3D !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);
> +
> +        err =3D kvmppc_configure_v3_mmu(cpu, radix, gtse, spapr->patb_en=
try);
> +        if (err) {
> +            error_report("Process table config unsupported by the host");
> +            return -EINVAL;
> +        }
> +    }
> +
>      return err;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPlxsAAoJEGw4ysog2bOS7IAQALdYlRj7Q1NkwpsyyO1y/fJV
fMUjQyU6pDmL0JjlLb3vdOCqUVv7jZyvC1/orPwV+KQ6Idzy0tN1v0cjUburVhHO
Xzblx2N92OCb+1ecL4sIsTPyaQ93BuOoBco3FZX3Futx7K7hYn7i/Sgjk0APilzE
pUtCBe4WyfPeQnaxmp86Q6JjQPp4OloW3v/Bh66pQplI4e2dkmu/72ZQd58PIXaZ
jjc5OdGTn2eDztr+wdu5z0ujk6VT+CoJ5gnTYbrGWSgS87pn9qCN9m7sNVG+f4Iy
Uxfjj/0iwtDykSsu1kptfdMFpVeGMslaNYQsIBDGtCWE5hMGhaib6xZfzv+hSwKW
AYauZDDgAJIk87Ewkq9A0UoGlP7w7lG8Tn40Gsk6ifFZhsklayn3zXWaWlbQN2Rm
+pdSV6bpRkwNWM6q0AUQAhbbnf4dsX8tg8ASHU0qBrKPdr3heoLLRRx0k0bF6B7G
Kp10U0uFgfizGp2JyGn4yJnUiH3usgIUpq0grjo9Pl8mWVXrR9czdTrRivh4dU7w
PHoUIyXxLsFBVZD4RY944J09eVz8Zm3HGXGDC9osiyzMaHZNdBDjK9k83sCvTcf2
ZsTEhvVw20BNJoDgzx6nYatCCZ0yEKrYT8BadoxHCaQb/SxQc78XI40hXMikoAUP
dMs9aWEMFFcD/iz39cTd
=lhbm
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
