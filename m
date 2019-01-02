Received: from eggs.gnu.org ([208.118.235.92]:57745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK2-0001hr-Ax
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK1-0007o6-5J
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:02 -0500
Date: Wed, 2 Jan 2019 15:15:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102041507.GN27457@umbus.fritz.box>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<16d6e1b4987d30c11ace0211e9d6a57303784467.1546394798.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Content-Disposition: inline
In-Reply-To: <16d6e1b4987d30c11ace0211e9d6a57303784467.1546394798.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 4/8] ppc4xx: Use ram_addr_t in
 ppc4xx_sdram_adjust()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
> To avoid overflow if larger values are added later use ram_addr_t for
> the sdram_bank_sizes parameter to match ram_size to which it is
> compared.

So, technically I think these should be 'hwaddr' (which represents a
guest physical address) rather tham ram_addr_t which
represents... something subtley different I've never properly
understood.

>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/ppc440_bamboo.c  | 2 +-
>  hw/ppc/ppc4xx_devs.c    | 4 ++--
>  hw/ppc/sam460ex.c       | 2 +-
>  include/hw/ppc/ppc4xx.h | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index b8aa55d526..8277c0f784 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -49,7 +49,7 @@
> =20
>  #define PPC440EP_SDRAM_NR_BANKS 4
> =20
> -static const unsigned int ppc440ep_sdram_bank_sizes[] =3D {
> +static const ram_addr_t ppc440ep_sdram_bank_sizes[] =3D {
>      256 * MiB, 128 * MiB, 64 * MiB, 32 * MiB, 16 * MiB, 8 * MiB, 0
>  };
> =20
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index 9b6e4c60fa..9418478575 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -679,12 +679,12 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size,=
 int nr_banks,
>                                 MemoryRegion ram_memories[],
>                                 hwaddr ram_bases[],
>                                 hwaddr ram_sizes[],
> -                               const unsigned int sdram_bank_sizes[])
> +                               const ram_addr_t sdram_bank_sizes[])
>  {
>      MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
>      ram_addr_t size_left =3D ram_size;
>      ram_addr_t base =3D 0;
> -    unsigned int bank_size;
> +    ram_addr_t bank_size;
>      int i;
>      int j;
> =20
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 2bb91ed21b..7cbd2f54c6 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -77,7 +77,7 @@
>  #define SDRAM_NR_BANKS 4
> =20
>  /* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
> -static const unsigned int ppc460ex_sdram_bank_sizes[] =3D {
> +static const ram_addr_t ppc460ex_sdram_bank_sizes[] =3D {
>      1 * GiB, 512 * MiB, 256 * MiB, 128 * MiB, 64 * MiB, 32 * MiB, 0
>  };
> =20
> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
> index 3a2a04c8ce..39a7ba1ce6 100644
> --- a/include/hw/ppc/ppc4xx.h
> +++ b/include/hw/ppc/ppc4xx.h
> @@ -43,7 +43,7 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int=
 nr_banks,
>                                 MemoryRegion ram_memories[],
>                                 hwaddr ram_bases[],
>                                 hwaddr ram_sizes[],
> -                               const unsigned int sdram_bank_sizes[]);
> +                               const ram_addr_t sdram_bank_sizes[]);
> =20
>  void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
>                          MemoryRegion ram_memories[],

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsOssACgkQbDjKyiDZ
s5JNuBAAoqupT+Yma8+zldny3MqLxSJ5Y2YNL0ZVnxoSjLTSAlxJ4+0MmKzarwbD
bDLCxMP69T1H2C+52uHNJdktYA2qCejPw5/McW67kJiifQQhb1x/rtqa4aNKZxTX
XuUp4JcJNO0ejgHWNSIqIXfyz9LYLq8yScaIdJP375L29VpJ/JnkWg8eNPbTfc1U
CJVTeo2VM9PVh4lxRfa6KMECdC9cAb05+O5d6e3co/7Im091MBv3BivTWXatNVuS
GyY9H3hD8nZO06KFvczAZxGuPk2MNw4EbTNQqmpXUxGUZ4VYmPVhXuQlFPRei2n6
8rYtyExpewUl1FdkBB6O840ikgO++hYM7evXZEgqFnz0ygSzD5bBT8orNZZuZ9wK
WLaSTR1gPLmvpYkFX463c7RdVnacFWJvs9vn6v/yKDbWXhIUVrkVP6tXk3kh1BYN
NVk2YGqVfTa8rJQXxPVIfH0FmDXkZ2zW4N6qpy3wQAuvL3Zz05HgGcyVKpHyR1CT
V9G5N3veIuQguaVN2XyVmRoCUY7y1p9AfP7y29sg62srAdZ3IJYHOUhR5u5m4BY3
BF1xUddkIK072rxC3IkSos79iET0k3CyTKicflK77RMe8tqMRI3x1TrbXNqa338y
42yRt41oARyF36z0RvFEhXkK01BBopJSwSYyFDYe8SV4XGhmf3Q=
=XrNr
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--
