Received: from eggs.gnu.org ([2001:4830:134:3::10]:49854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSWmY-0002B4-Ry
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSWmX-0005Px-ST
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 20:03:30 -0400
Date: Tue, 12 Jun 2018 09:36:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180611233638.GH2737@umbus.fritz.box>
References: <20180611171210.2571-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HuscSE0D68UGttcd"
Content-Disposition: inline
In-Reply-To: <20180611171210.2571-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix LPC HC firmware address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--HuscSE0D68UGttcd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 07:12:10PM +0200, C=E9dric Le Goater wrote:
> A specific MemoryRegion is required for the LPC HC Firmware address
> space.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.0, thanks.

> ---
>  include/hw/ppc/pnv_lpc.h | 1 +
>  hw/ppc/pnv_lpc.c         | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
> index 023b4f0fec86..53fdd5bb6450 100644
> --- a/include/hw/ppc/pnv_lpc.h
> +++ b/include/hw/ppc/pnv_lpc.h
> @@ -38,6 +38,7 @@ typedef struct PnvLpcController {
>      /* ISA IO and Memory space */
>      MemoryRegion isa_io;
>      MemoryRegion isa_mem;
> +    MemoryRegion isa_fw;
> =20
>      /* Windows from OPB to ISA (aliases) */
>      MemoryRegion opb_isa_io;
> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
> index c42b4a8f6c0f..a0dba657ee60 100644
> --- a/hw/ppc/pnv_lpc.c
> +++ b/hw/ppc/pnv_lpc.c
> @@ -79,6 +79,7 @@ enum {
> =20
>  #define ISA_IO_SIZE             0x00010000
>  #define ISA_MEM_SIZE            0x10000000
> +#define ISA_FW_SIZE             0x10000000
>  #define LPC_IO_OPB_ADDR         0xd0010000
>  #define LPC_IO_OPB_SIZE         0x00010000
>  #define LPC_MEM_OPB_ADDR        0xe0010000
> @@ -437,6 +438,7 @@ static void pnv_lpc_realize(DeviceState *dev, Error *=
*errp)
>       */
>      memory_region_init(&lpc->isa_io, OBJECT(dev), "isa-io", ISA_IO_SIZE);
>      memory_region_init(&lpc->isa_mem, OBJECT(dev), "isa-mem", ISA_MEM_SI=
ZE);
> +    memory_region_init(&lpc->isa_fw, OBJECT(dev),  "isa-fw", ISA_FW_SIZE=
);
> =20
>      /* Create windows from the OPB space to the ISA space */
>      memory_region_init_alias(&lpc->opb_isa_io, OBJECT(dev), "lpc-isa-io",
> @@ -448,7 +450,7 @@ static void pnv_lpc_realize(DeviceState *dev, Error *=
*errp)
>      memory_region_add_subregion(&lpc->opb_mr, LPC_MEM_OPB_ADDR,
>                                  &lpc->opb_isa_mem);
>      memory_region_init_alias(&lpc->opb_isa_fw, OBJECT(dev), "lpc-isa-fw",
> -                             &lpc->isa_mem, 0, LPC_FW_OPB_SIZE);
> +                             &lpc->isa_fw, 0, LPC_FW_OPB_SIZE);
>      memory_region_add_subregion(&lpc->opb_mr, LPC_FW_OPB_ADDR,
>                                  &lpc->opb_isa_fw);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HuscSE0D68UGttcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfB4QACgkQbDjKyiDZ
s5Kggw/9HMZKq912gjhLh4JGS9Z1TkdEp4N+Zp5FJwZCLpAFPzDWHYlH1HSxPdIl
uoshHfEccGqtg7+2PJSQy4wJu8NY53uJL226U0o+o4aRwJ7iVPUMEhEu/X2mWDrs
XyYxAK3XpLV5/VEmvyvLZSA6+5JaHZQFvKY7SBrucDxdPjySMOppRclz8rg/Qx8B
IMN22nnW8Gz/rPBH21j+AvQR648yStGiEvovOhQ/iAJqKmaZxJ4cbKSiXqqu8Whq
yup3zUVm1ferAPM2feBM9wxoiNPtiDhvg/CrMOTpQs6d0yGiQ5Sq8TD0s0YTZ3wD
wUV+Z1DwogGcxNO+5WxhiJkdzQetQpF1n0+RYiXXgoY6mCvjhMvtp1FIYe1a4s19
8fz5JUu076S7AIAdJEIbC7rm9G1kec0K0sb9cqJDVH67cbAJ3+FKscI0I49TSfpg
DJUoEHgVBt56hJc3eVY0zp3IcEKtmFcQI2ylG5NVe5J4jJPyjGbFL814JqYml3AG
cHEO+kBMOA9L80QSj1xftAzfpZC14Voas8KmEGj0k6F9zQn1K/lV7Azk6LkQeQ6V
BTrH0WDekEmNvkiHFZDcyHK+ujxsHGunYLtzcQCADw5n8lEPJY7P6sMUtgAZutID
IexbBFXnGqUskXRbaOB2Q3NAnEL71o9yZWIGeV0gKSho4XiBP4A=
=hah9
-----END PGP SIGNATURE-----

--HuscSE0D68UGttcd--
