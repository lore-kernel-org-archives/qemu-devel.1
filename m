Received: from eggs.gnu.org ([2001:4830:134:3::10]:35128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfIOW-0002Dg-0O
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 00:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfIOU-0005fN-JO
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 00:14:55 -0400
Date: Wed, 9 Aug 2017 14:05:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170809040546.GF13670@umbus.fritz.box>
References: <20170808175936.28793-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <20170808175936.28793-1-npiggin@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ppc/spapr: fix unicast H_SIGNAL_SYS_RESET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 03:59:36AM +1000, Nicholas Piggin wrote:
> Unicast H_SIGNAL_SYS_RESET does not find the target CPU if it
> is not the current CPU.
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>=20
> Unfortunately this slipped through without my noticing because the
> Linux driver for NMI IPIs has a fallback to using regular IPIs, and
> because Linux did not make much use of unicasts. A new watchdog
> has started using them. After this patch, this function works
> properly:

In fact this bug was already fixed in the for-2.11 branch.  If you've
hit this for real, I guess it's more important than I realized, so
I'll pull it into 2.10 instead.

>=20
> Watchdog CPU:0 detected Hard LOCKUP other CPUS:3
> *** Unicast NMI IPI is sent here ***
> Watchdog CPU:3 Hard LOCKUP
> Modules linked in:
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.13.0-rc3-00305-ge84cf82ae73a-=
dirty #1191
> task: c00000001e440000 task.stack: c00000001e480000
> NIP: c000000000023800 LR: c00000000000da28 CTR: c000000000626db0
> REGS: c00000001ff97d80 TRAP: 0100   Not tainted  (4.13.0-rc3-00305-ge84cf=
82ae73a-dirty)
> MSR: 8000000002001033 <SF,VEC,ME,IR,DR,RI,LE>
>   CR: 48000224  XER: 20000000
> CFAR: c00000000002380c SOFTE: 0=20
> GPR00: c00000000000d9cc c00000001e483dc0 c000000000ebd900 000000000007d00=
0=20
> GPR04: f000000000078680 c00000001e1a0048 c00000001e1a0048 000000000000000=
1=20
> GPR08: 0000000000000000 0000000000075036 00000003d5f633c2 000000000000002=
0=20
> GPR12: 0000000000000000 c00000000fd80f00 c00000000000d988 000000000000000=
0=20
> GPR16: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
> GPR20: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
> GPR24: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0=20
> GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000b6=
0=20
> NIP [c000000000023800] udelay+0x40/0x60
> LR [c00000000000da28] kernel_init+0xa8/0x1b0
> Call Trace:
> [c00000001e483dc0] [c00000000000d9cc] kernel_init+0x4c/0x1b0 (unreliable)
> [c00000001e483e30] [c00000000000bb1c] ret_from_kernel_thread+0x5c/0xc0
> Instruction dump:
> 7c6349d2 7c210b78 7d4c42a6 7d2c42a6 7d2a4850 7fa34840 409d0028 48000014=
=20
> 60000000 60000000 60000000 60420000 <7d2c42a6> 7d2a4850 7fa34840 419dfff4=
=20
>=20
>  hw/ppc/spapr_hcall.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 72ea5a8247..f50e979b43 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1432,7 +1432,9 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *=
cpu,
>      } else {
>          /* Unicast */
>          CPU_FOREACH(cs) {
> -            if (cpu->cpu_dt_id =3D=3D target) {
> +            PowerPCCPU *c =3D POWERPC_CPU(cs);
> +
> +            if (c->cpu_dt_id =3D=3D target) {
>                  run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_=
NULL);
>                  return H_SUCCESS;
>              }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKihkACgkQbDjKyiDZ
s5JIuw/8Dz059u0jLNGUm0CSaY1sVGOALj7+hT6iJQkGzelDJzOx6DsMT3xEplh0
no6+buF2Y1fUQH6soQdc7I9vNVzbZi5dVPvPRuThlVMbcSDvAwFrpZQ6edwzcxjQ
mVUINv4jpaUskY9iEXRHvO3Hn+BMbjm4uBKXsbLwQ8Oyh5JnN4nn9LrV1sLADvn+
xcRDgOwKUVWQAWGSZ9fUEFKhu40TTZh+A/8HErL1SKmD9eis1EkWVN9DPMM12FKG
2xkh5eovNLCBsNOMQcIjqL7MqCxvYXe9YkbXQubf/e20buE69yrFZ83eFGkIwAmG
ZWnm3mKdukKzEe/FWXFl5WOtjsHP/DV5DX457A6igJ8x2S7xXhs7iUJ97eaGfipE
Ok9HYvlygmc7HUPnIwfUUXxUDvEqDefT+i0ABPAFAGOpozMi+MwC4jQyN/IyeizQ
7ZQJOLrZ991kxVYgY9y7Yy6d8USbhKMtlkDMJK0dd0nNdyGAl7apqo4j9nxyU3Ap
I+TkixqqT4bmztyvIu+jM0P0lj4vQF1LkwUphsMiOgmpw26/qVJqQEEu5RAcwVJY
RarVlSa0JZoB/a/Wh1ukdxwCxYPsDJggYWaKF3q0CnmIUponh+fa9fvxe0buerPr
UnlLVi1H5b8NbRXZJy9AXsKhdVe2Def+lbrBDYNrhgbl5JGiHsA=
=5wOq
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
