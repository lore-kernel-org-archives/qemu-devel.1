Received: from eggs.gnu.org ([2001:4830:134:3::10]:43390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHIZ1-0001Pk-Fw
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 19:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHIYy-0004aO-AH
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 19:06:51 -0500
Date: Wed, 22 Nov 2017 10:07:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171121230714.GB2380@umbus.fritz.box>
References: <20171121201643.29638-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20171121201643.29638-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: fix VTB migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2017 at 09:16:43PM +0100, Laurent Vivier wrote:
> Migration of a system under stress (for example, with
> "stress-ng --numa 2") triggers on the destination
> some kernel watchdog messages like:
>=20
> NMI watchdog: BUG: soft lockup - CPU#0 stuck for 3489660870s!
> NMI watchdog: BUG: soft lockup - CPU#1 stuck for 3489660884s!
>=20
> This problem appears with the changes introduced by
>     42043e4 spapr: clock should count only if vm is running
>=20
> I think this commit only triggers the problem.
>=20
> Kernel computes the soft lockup duration using the
> Virtual Timebase register (VTB), not using the Timebase
> Register (TBR, the one 42043e4 stops).
>=20
> It appears VTB is not migrated, so this patch adds it in
> the list of the SPRs to migrate, and fixes the problem.
>=20
> For the migration, I've tested a migration from qemu-2.8.0 and
> pseries-2.8.0 to a patched master (qemu-2.11.0-rc1). The received
> VTB is 0 (as is it not initialized by qemu-2.8.0), but the value
> seems to be ignored by KVM and a non zero VTB is used by the kernel.
> I have no explanation for that, but as the original problem appears
> only with SMP system under stress I suspect some problems in KVM
> (I think because VTB is shared by all threads of a core).
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-2.11, thanks.

> ---
>  target/ppc/translate_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index b9c49c22f2..4e11e6f489 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8081,10 +8081,10 @@ static void gen_spr_power8_ebb(CPUPPCState *env)
>  /* Virtual Time Base */
>  static void gen_spr_vtb(CPUPPCState *env)
>  {
> -    spr_register(env, SPR_VTB, "VTB",
> +    spr_register_kvm(env, SPR_VTB, "VTB",
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   &spr_read_tbl, SPR_NOACCESS,
> -                 0x00000000);
> +                 KVM_REG_PPC_VTB, 0x00000000);
>  }
> =20
>  static void gen_spr_power8_fscr(CPUPPCState *env)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloUsaIACgkQbDjKyiDZ
s5Kflg/5AV9gQbSmRSKByFoYpq2G3bCORh6tXbK8X1zn98cen7DBaAE0RihUFRYw
zOP3ZikZ2dbeMFABLZzKtvOtcMG3J8wTu2Lic3FWZVxipgRdcMuj4gz00RYsA/7O
Cx5W5zThf1/vZSK+dlItTDvb1oTADTnuw930nP2NX0p/4zhgZP9qMHtUmvEV4BSS
yiM2IjB5SDlVmu1ntztgk2CjtuT+79E9JUtSN1JabVijsWtWlCOETzKxt82KNGXW
gSgcxE5i02VcF9/qV+XK1OyNkooacwhvcM60hOvhIOJxj42grsCgxRr1K0HG7eN6
8AzGEhSB77BAHeaL1umwONGbgcTDmZl7v/jlkCFgukqULSZEVolYGfxrvkdOv19n
yDoxr1h4QPNGuvNPIX0J+b7sdhFzkoeMtEVcKnqUEWnOe8pplDrauXLnJ9NguWLy
zIw00HS8lYwuH74G2pXAPrkXILCHpWEf8z+uElgKfM9jFaIdHTIu7FbbdNROs0up
3acaRZd32VjRGGotOGl0VjFiq+WPIZOZZPQX34xWHsJ1SGzrsJl2unCe0a4/OPzx
JB2CPXVr4yMhPspdZTDT3BDvOTypMT8WmWYr3yQ4lhQEETzz/nrkvn7413hzdEAN
N6wxszhhhKFoAVF2wonTDxg4qUzDwVJbOV0tZQ5tCqydFux//ec=
=iTwW
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
