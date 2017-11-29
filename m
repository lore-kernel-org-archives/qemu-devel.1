Received: from eggs.gnu.org ([2001:4830:134:3::10]:57900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJrAr-0004uM-JF
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJrAq-0005P3-Fz
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:28:29 -0500
Date: Wed, 29 Nov 2017 12:04:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171129010439.GA3023@umbus.fritz.box>
References: <20171128174310.15700-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20171128174310.15700-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] pseries: fix TCG migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 06:43:10PM +0100, Laurent Vivier wrote:
> Migration of pseries is broken with TCG because
> QEMU tries to restore KVM MMU state unconditionally.
>=20
> The result is a SIGSEGV in kvm_vm_ioctl():
>=20
>   #0  kvm_vm_ioctl (s=3D0x0, type=3D-2146390353)
>       at qemu/accel/kvm/kvm-all.c:2032
>   #1  0x00000001003e3e2c in kvmppc_configure_v3_mmu (cpu=3D<optimized out=
>,
>       radix=3D<optimized out>, gtse=3D<optimized out>, proc_tbl=3D<optimi=
zed out>)
>       at qemu/target/ppc/kvm.c:396
>   #2  0x00000001002f8b88 in spapr_post_load (opaque=3D0x1019103c0,
>       version_id=3D<optimized out>) at qemu/hw/ppc/spapr.c:1578
>   #3  0x000000010059e4cc in vmstate_load_state (f=3D0x106230000,
>       vmsd=3D0x1009479e0 <vmstate_spapr>, opaque=3D0x1019103c0,
>       version_id=3D<optimized out>) at qemu/migration/vmstate.c:165
>   #4  0x00000001005987e0 in vmstate_load (f=3D<optimized out>, se=3D<opti=
mized out>)
>       at qemu/migration/savevm.c:748
>=20
> This patch fixes the problem by not calling the KVM function with the
> TCG mode.
>=20
> Fixes: d39c90f5f3 ("spapr: Fix migration of Radix guests")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> v2: fix the comment to keep GDB backtrace lines starting with '#'

Applied to ppc-for-2.11.

>=20
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9efddeaee5..a471de6cab 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1570,7 +1570,7 @@ static int spapr_post_load(void *opaque, int versio=
n_id)
>          err =3D spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
>      }
> =20
> -    if (spapr->patb_entry) {
> +    if (kvm_enabled() && spapr->patb_entry) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
>          bool radix =3D !!(spapr->patb_entry & PATBE1_GR);
>          bool gtse =3D !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloeB6UACgkQbDjKyiDZ
s5IXCQ//WnRUnZMo/LEOE//4IhH0o4lgt/uQumRhzrxwCKzpDFgdzZeay/08fBdU
E06LLx11vTCboqHwacjd5vsE/lF3kVE+ssHMMoonnAL0t31FBcO/EqnEtduvM898
61yjab8HPR7QqBKjWE48EcwvgzmMTaVTRBhI3XYdvTcFvfjBZg+RBUCfjtaOfwNs
6PGUBbf4XCcCL7pPRYJc2PvtW6OFbdoqieeNHkK+wKDBA1sHze5dEIIaZXY8QVpc
sZ87xGM3mjsJ4J33YmyFBhikM5ms5bZlUoYRFf81VfAKu0UAp1Cph3psoNg7BbLa
bhUXVkOjOd+lKyTnjTAHlZv9n+q1zC7lYARMHi/OOzCv9gi2yE4oLnNMvbTQzkGY
8gTRzpcb3nauIDk+MHsZpCV7N/g3t19iVRIushYIhvdAWnKOiONH6nVpncHTn7xQ
vROkephgBVDrIvelGM5IGp6I+3/bPdUgdYO0QRQIfip+klv2+aCf5ROABcxjYknv
sQHdQy1opgdID8BQSpoAg/KElTVfIuIgxtUSJLjxx9S8XujmAtmhBzNWDos9QqKY
/EqeiwHkxaU78unBaIjmbrYvVGMEoJZAfNo2byBKx4pQmvnowjwYiLpp5eWx1K1/
/c42sBBL2THBKDP2xlGuaR81RwyHeBV4mlEckwfsCgk9N+EPzlo=
=D66X
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
