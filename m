Received: from eggs.gnu.org ([2001:4830:134:3::10]:40278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQmyH-0002Sf-Qe
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQmyE-0004Nc-Tc
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:19:37 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:45177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cQmyE-0004Kv-Eb
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 22:19:34 -0500
Date: Tue, 10 Jan 2017 11:28:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170110002815.GJ12515@umbus.fritz.box>
References: <20170109112338.5629-1-rka@sysgo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j+MD90OnwjQyWNYt"
Content-Disposition: inline
In-Reply-To: <20170109112338.5629-1-rka@sysgo.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: Prevent inifnite loop in decrementer
 auto-reload.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--j+MD90OnwjQyWNYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 12:23:38PM +0100, Roman Kapl wrote:
> If the DECAR register is set to 0, QEMU tries to reload the decrementer w=
ith
> zero in an inifinite loop. According to PPC documentation, the decremente=
r is
> triggered on 1->0 transition, so avoid reloading the decrementer if if is
> already zero.
>=20
> The problem does not manifest under Linux, but it is valid to set DECAR t=
o zero
> (and may make sense as part of decrementer initialization when interrupts=
 are
> disabled).
>=20
> Signed-off-by: Roman Kapl <rka@sysgo.com>

Applied, fixing the coding style nit (no space after if) in the
process.  Please remember to run checkpatch.pl in future.

> ---
>  hw/ppc/ppc_booke.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
> index ab8d026..f8d5c28 100644
> --- a/hw/ppc/ppc_booke.c
> +++ b/hw/ppc/ppc_booke.c
> @@ -198,8 +198,12 @@ static void booke_decr_cb(void *opaque)
>      booke_update_irq(cpu);
> =20
>      if (env->spr[SPR_BOOKE_TCR] & TCR_ARE) {
> -        /* Auto Reload */
> -        cpu_ppc_store_decr(env, env->spr[SPR_BOOKE_DECAR]);
> +        /* Do not reload 0, it is already there. It would just trigger
> +         * the timer again and lead to infinite loop */
> +        if(env->spr[SPR_BOOKE_DECAR] !=3D 0) {
> +            /* Auto Reload */
> +            cpu_ppc_store_decr(env, env->spr[SPR_BOOKE_DECAR]);
> +        }
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--j+MD90OnwjQyWNYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYdCqfAAoJEGw4ysog2bOShvoP/iQY7j5iKlxB/MqSV8mRha8U
u2LCRKadnmzXDDV8jgSy5Vp+Vj/r5jRqz94/aNWjXXVamCvkcGCDwNDiow3k4f8v
GlfgzSD/ccHW+aj87bZCi8JHrOOxo79HggH/59OY6IPTJzBRKS8G9KFrmLyoHhbx
nNV5fM4y6QQcARMcbiZ6CrZ+uzRkZArA9Ca7DLpPP09vU3WLihuFW88axHuC2hDA
uBndhPpoUmO/zsI9V/tPXQyooCnxwd/Zabxl9ACNm2F0ZF3TTCyzy7mEb/LYJq5P
HuB8OsSkhh7/1qEoKbtqnGXBzQ0EITBdhTx6xQQqFrnxEy2/dFXBztZi+oelnl7I
1oeYugRHobWPo3lqsPFXLPqVI/j7ZFWSZQQoAtPH+AwnuEdbOs/banU0Z7BjGH1u
vOTSIx1ZM7SoXbmmxj2SPuLJWLvN2fKD9OZHUpZDhlQjFFoGDDLCuZDTW5i/eitj
sUEslgVAZymsoYr1qDQALVnAq+Gy3jkGrE2y+DezEakmqI2LVdj0g7OeXRUZfjfE
7hIslRizAmGpAKCgB3rH78aVqeV+1zzQXQTqCw/bNYhifWnlbKkcOtqU24tJd0VA
GSi1VfmfPwYllXmBncnZlIjvtgJqm+u5oyexGGAEuU7RxQNe4x9qwTbCcf6/Wg2S
okcCGsYw6Zy4mLbZ6iLF
=l0KH
-----END PGP SIGNATURE-----

--j+MD90OnwjQyWNYt--
