Received: from eggs.gnu.org ([2001:4830:134:3::10]:37761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4cAL-0000ol-Dx
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 20:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4cAK-00080U-3u
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 20:57:13 -0400
Date: Sat, 7 Apr 2018 10:56:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180407005656.GF3212@umbus.fritz.box>
References: <20180405230258.680CB7456D6@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
In-Reply-To: <20180405230258.680CB7456D6@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH for-2.12] sam460ex: Fix timer frequency and
 clock multipliers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2018 at 12:42:48AM +0200, BALATON Zoltan wrote:
> We only emulate timer running at CPU frequency which is what most
> guests expect so set the frequency to match real hardware. This also
> allows setting clock multipliers which caused slowdown previously due
> to wrong timer frequency.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-2.12.

> ---
>  hw/ppc/ppc440_uc.c | 3 +--
>  hw/ppc/sam460ex.c  | 7 ++++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index 976ab2b..e312fdb 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -392,8 +392,7 @@ static uint32_t dcr_read_sdr(void *opaque, int dcrn)
>      case SDR0_CFGDATA:
>          switch (sdr->addr) {
>          case SDR0_STRP0:
> -            /* FIXME: Is this correct? This breaks timing in U-Boot */
> -            ret =3D 0; /*(0xb5 << 8) | (1 << 4) | 9 */
> +            ret =3D (0xb5 << 8) | (1 << 4) | 9;
>              break;
>          case SDR0_STRP1:
>              ret =3D (5 << 29) | (2 << 26) | (1 << 24);
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 70b8e76..dfff262 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -67,6 +67,7 @@
>     IRQ12 =3D SM502_INT
>  */
> =20
> +#define CPU_FREQ 1150000000
>  #define SDRAM_NR_BANKS 4
> =20
>  /* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
> @@ -253,8 +254,8 @@ static int sam460ex_load_device_tree(hwaddr addr,
>      char *filename;
>      int fdt_size;
>      void *fdt;
> -    uint32_t tb_freq =3D 50000000;
> -    uint32_t clock_freq =3D 50000000;
> +    uint32_t tb_freq =3D CPU_FREQ;
> +    uint32_t clock_freq =3D CPU_FREQ;
> =20
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_=
FILE);
>      if (!filename) {
> @@ -416,7 +417,7 @@ static void sam460ex_init(MachineState *machine)
>      boot_info =3D g_malloc0(sizeof(*boot_info));
>      env->load_info =3D boot_info;
> =20
> -    ppc_booke_timers_init(cpu, 50000000, 0);
> +    ppc_booke_timers_init(cpu, CPU_FREQ, 0);
>      ppc_dcr_init(env, NULL, NULL);
> =20
>      /* PLB arbitrer */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrIF1gACgkQbDjKyiDZ
s5LQhBAAxDiUtwmaZMICKL0p+UQXkXD/GXcuUKsqsNTpVjxWGhS7lP00NTDnNauw
Rzb48vY2UnkdCZBukxFVfm9AfebZOausc5MG2yAw9IU8f5HaQn1QjVPLQS8voEu7
vVjUJBYcshR2ytjIG5Spb8mAv2On4l6FDpAQISo0kSkFub1LRZR2edCZbm2f/JUl
yL06i+KaSdBVnj7zP2NjXRtnYny7RTqzdoURHL/a6wl5JpB3Vikbwe6zbrpmYzV6
J22JcgOlR/kNCWQeZ+grgFncloY46uReLSlPTwOKQ4lBfcSz1wQcq2Ad26FFwCWC
GOSuuaaNW8WdSR3Arcy5AXv+nCNAkGMrx1n0f5pbXoeWQH1e1QmVlkQMj9eWzJ4y
L0tqPFEO6HQFHoEjs6vWG3dCT59qJRs0B+ohhT+4dExJxhrxSshFC8ynlMYBqwZY
aCHrpactoQEa5BYZ8D6ZMdk0YeW/jpgMvfxusNyPT4rePfZ4VpRsyRo0v/4fPsPi
bKerBpCKvwjflJ/HBlxly8o/n+ty1Av9/x+qIRpD0nzZcFQW+nr1v11hIUZy/x43
OXqWzPUiYgJAKB3bzsv33HEPTp1Pe/seMpjh2FjLrMh6vmjdn2kv7Uq8ZK09VYR2
+w9H0EIaYvngFF5VxyuFYA+tZxlquoRWDx5p2kjt/6QF01XuwkU=
=2J7G
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
