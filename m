Received: from eggs.gnu.org ([2001:4830:134:3::10]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxRlk-0007Ai-59
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxRlg-0005bX-5U
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:21:40 -0400
Date: Mon, 10 Apr 2017 15:18:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170410051857.GK27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-13-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BFVE2HhgxTpCzM8t"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-13-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 12/21] ppc/pnv: populate device tree for
 RTC devices
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


--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:37PM +0200, C=E9dric Le Goater wrote:
> The code could be common to any ISA device but we are missing the IO
> length.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/pnv.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index a3c8f6594d10..2f9c41e350d4 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -281,6 +281,26 @@ static void powernv_populate_chip(PnvChip *chip, voi=
d *fdt)
>      g_free(typename);
>  }
> =20
> +static void powernv_populate_rtc(ISADevice *d, void *fdt, int lpc_off)
> +{
> +    uint32_t io_base =3D d->ioport_id;
> +    uint32_t io_regs[] =3D {
> +        cpu_to_be32(1),
> +        cpu_to_be32(io_base),
> +        cpu_to_be32(2)
> +    };
> +    char *name;
> +    int node;
> +
> +    name =3D g_strdup_printf("%s@i%x", qdev_fw_name(DEVICE(d)), io_base);
> +    node =3D fdt_add_subnode(fdt, lpc_off, name);
> +    _FDT(node);
> +    g_free(name);
> +
> +    _FDT((fdt_setprop(fdt, node, "reg", io_regs, sizeof(io_regs))));
> +    _FDT((fdt_setprop_string(fdt, node, "compatible", "pnpPNP,b00")));
> +}
> +
>  typedef struct ForeachPopulateArgs {
>      void *fdt;
>      int offset;
> @@ -288,6 +308,16 @@ typedef struct ForeachPopulateArgs {
> =20
>  static int powernv_populate_isa_device(DeviceState *dev, void *opaque)
>  {
> +    ForeachPopulateArgs *args =3D opaque;
> +    ISADevice *d =3D ISA_DEVICE(dev);
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MC146818_RTC)) {
> +        powernv_populate_rtc(d, args->fdt, args->offset);
> +    } else {
> +        error_report("unknown isa device %s@i%x", qdev_fw_name(dev),
> +                     d->ioport_id);
> +    }
> +
>      return 0;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6xXBAAoJEGw4ysog2bOSd4AP/RK1hLBV1AR/gUgetqlPE1pF
7Gsd0sjJ4pKPpPIhLJ3PqGrLot6Gni9Y+A2UfpZid/Ij9vb+VskbYetwTIVMJYEb
DiTbBhgqP9LroErGPwLy7OhXKLc3O1ypO+NefuVxjtWBzxHYYc1aU7iasGvjESkq
12wJQY89Te11Yhtx81kFHws2oInlSvS2cTPl/JsuPaecj+7mPqghjmz9/YBmxc9q
zzoOT+Hb/8ogv/QG4b4x6Ws0fzw/Ci57VsWKnlSGxxe94X2ULoD+cWagcbxVpir9
HI+ox845sJz2axgUg7DmvwYyJN6MayWPDYZtW/ekHOaLmuhDtuyaGkC4xmjUeYvy
HEHHN8ZjStMJniQculYkelQf0A6AYdZXdETLMdf7PihudurDYGw/Foze7r1kUH3R
iZxUSzK6nkn1LUVZgUOTyxyI+8tr4yFUXejdOJI5xl9DLvhJcn3qBwR5WdQtDQvq
vjybKkaU13ItajxOjYAE23WpUJWqhA3lQuIgytsJrbecDlF57zsR3RrtpersYcdz
jd8w5LDSg9bhe7f7M/clfPrAaGYsz2YshyPEfLXZLx2dU9R1EDF0PMMFr+UoVmn4
u/x4QGhvOFkc+4skPrAM7IoKByRF6LpH+yqfrOlJcoKJ28pw+15GxlbDFvNei14G
dlCjTXjwUBR8wWXxOvIq
=GoQ9
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--
