Received: from eggs.gnu.org ([209.51.188.92]:35706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kfF-0007iP-7l
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1kfE-00066z-Ai
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 23:29:49 -0500
Date: Thu, 7 Mar 2019 15:28:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307042835.GO7722@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-23-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c2gYorpyS4gG0T74"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-23-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 22/27] ppc/pnv: extend XSCOM core support
 for POWER9
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


--c2gYorpyS4gG0T74
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:27AM +0100, C=E9dric Le Goater wrote:
> Add a couple of XSCOM addresses controlling the power management
> states of the core.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv_core.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 38179cdc53dc..c3d6350dc90a 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -60,6 +60,12 @@ static void pnv_cpu_reset(void *opaque)
>  #define PNV_XSCOM_EX_DTS_RESULT0     0x50000
>  #define PNV_XSCOM_EX_DTS_RESULT1     0x50001
> =20
> +/*
> + * POWER9 core controls
> + */
> +#define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP 0xf010d
> +#define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR 0xf010a
> +
>  static uint64_t pnv_core_xscom_read(void *opaque, hwaddr addr,
>                                      unsigned int width)
>  {
> @@ -74,6 +80,10 @@ static uint64_t pnv_core_xscom_read(void *opaque, hwad=
dr addr,
>      case PNV_XSCOM_EX_DTS_RESULT1:
>          val =3D 0x24f000000000000ull;
>          break;

Shouldn't this be in a p9 specific read/write routine?

> +    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP:
> +    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
> +        val =3D 0x0;
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "Warning: reading reg=3D0x%" HWADDR_PRI=
x "\n",
>                    addr);
> @@ -85,8 +95,16 @@ static uint64_t pnv_core_xscom_read(void *opaque, hwad=
dr addr,
>  static void pnv_core_xscom_write(void *opaque, hwaddr addr, uint64_t val,
>                                   unsigned int width)
>  {
> -    qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=3D0x%" HWADDR_PRIx=
 "\n",
> -                  addr);
> +    uint32_t offset =3D addr >> 3;
> +
> +    switch (offset) {
> +    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP:
> +    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=3D0x%" HWADDR_=
PRIx "\n",
> +                      addr);
> +    }
>  }
> =20
>  static const MemoryRegionOps pnv_core_xscom_ops =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c2gYorpyS4gG0T74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAnfMACgkQbDjKyiDZ
s5IXVg//VBrPcFMt3Ykh9RMW0Mi70Z+hMaEx3B/TWMykFWtm2Zm5IO7FkIzqWX89
Qn/DK5W+us0HlkkvJde8L8AWtw7H0XUEr/qEEssRVUfqZSCINRCg+Fawy4S+GGuy
pi3DnByn9oZUZEPnhZIPr+m9vZuBdQI1+LJu78LN/EeVOmMEWKgh2WdOuXDJQEmg
N7S9+6doMqlp7gIAaseJCWQuM3TsqGfaO4rkLCAa3EH6YLQGQekEyo2MpEYI+LcD
lsnlxioOBj4eFUkcrisX7Ge0OrwGckkjMkr24UKirloQp2HLQQx8O9jLQSdNd6Gn
j97qOKwyP+yJFB9HZ0lPcV+ln9OajaLN17aBy2+vOBYwzHaEXMer4yqyFzYKwhz2
HIfbt6Jl60slAmNbDc2nxbO5A9qsqVGz7SUkvQDcjGxMY6MySxUUURe2VG5E6imJ
sMnMjsd6oOpki3ey4b+iAxuj4GahAa1NBDATk/iQ9IF9Pf2N+FG7eKDHaP8BM2SM
3kBe+WSXQ4LGAWs08nPjVAzvGgt32bZfS1MOgKLtETpECxFyHxRFiu8N1h/EP6Jq
v5/60stJ6JM6bwHnrEAkinEFgrJkOMEmduj/4JR/6+WaNamcQ2pVek6PcekVGZbO
1GtD1QMlW/QcFGGWO6hvK0O8Elb58QEHXBJkvvnNtTgo7K8epKY=
=wKPG
-----END PGP SIGNATURE-----

--c2gYorpyS4gG0T74--
