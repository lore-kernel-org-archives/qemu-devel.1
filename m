Received: from eggs.gnu.org ([2001:4830:134:3::10]:40017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxRlk-0007Ah-58
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxRlg-0005bN-5O
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:21:40 -0400
Date: Mon, 10 Apr 2017 15:19:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170410051955.GL27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-14-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-14-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 13/21] ppc/pnv: populate device tree for
 serial devices
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


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:38PM +0200, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/pnv.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 2f9c41e350d4..00e594a0cbe3 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -301,6 +301,37 @@ static void powernv_populate_rtc(ISADevice *d, void =
*fdt, int lpc_off)
>      _FDT((fdt_setprop_string(fdt, node, "compatible", "pnpPNP,b00")));
>  }
> =20
> +static void powernv_populate_serial(ISADevice *d, void *fdt, int lpc_off)
> +{
> +    const char compatible[] =3D "ns16550\0pnpPNP,501";
> +    uint32_t io_base =3D d->ioport_id;
> +    uint32_t io_regs[] =3D {
> +        cpu_to_be32(1),
> +        cpu_to_be32(io_base),
> +        cpu_to_be32(8)
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
> +    _FDT((fdt_setprop(fdt, node, "compatible", compatible,
> +                      sizeof(compatible))));
> +
> +    _FDT((fdt_setprop_cell(fdt, node, "clock-frequency", 1843200)));
> +    _FDT((fdt_setprop_cell(fdt, node, "current-speed", 115200)));
> +    _FDT((fdt_setprop_cell(fdt, node, "interrupts", d->isairq[0])));
> +    _FDT((fdt_setprop_cell(fdt, node, "interrupt-parent",
> +                           fdt_get_phandle(fdt, lpc_off))));
> +
> +    /* This is needed by Linux */
> +    _FDT((fdt_setprop_string(fdt, node, "device_type", "serial")));
> +}
> +
>  typedef struct ForeachPopulateArgs {
>      void *fdt;
>      int offset;
> @@ -313,6 +344,8 @@ static int powernv_populate_isa_device(DeviceState *d=
ev, void *opaque)
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_MC146818_RTC)) {
>          powernv_populate_rtc(d, args->fdt, args->offset);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_ISA_SERIAL)) {
> +        powernv_populate_serial(d, args->fdt, args->offset);
>      } else {
>          error_report("unknown isa device %s@i%x", qdev_fw_name(dev),
>                       d->ioport_id);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6xX7AAoJEGw4ysog2bOSJH4QALjSNGAM+lF93VnDrZIfNF65
xJ4iSlLwnmCxzDmY5WiEr9Y46m77N9C8+z0FhbBwIQFeb3U7SUKb5C8K3tpJpdCw
X85GMSV7uumBjqfx3QjFN1+Vi85pfA/igvxTIHtJgFA1v7yfgXPc15YyOA7Ue2g6
gLh9v4H1s/jdR138Xaq/rm15iHVYiBirmsjnA1VhKLyQLuVvPjMW7iYnvG1/XNrf
nETJwwm1kLGpYBE3T9YjRzx7CvjaFKfhW28ULFu9SInnA/vsCiB0gvg8RRcumkis
/U1THRsBdgdH3Gg2p/4YJIcG1B24EJIZEQwinPZEHH1pQ0gh9dvgwcKs2mFnid68
43OfS7dc36ips7BiAUAUxS58Z5RlZPfTdRJxDZFXabh41frd2FHYGF3ccwKd38tV
SWugdQhzG8EcxvyaMveQ/9old11DaJrA6wu3w2qTkDxRNEiqY5i7y0eXsd7dsi/n
XuODJs19ScgfNhZwdnVBzCu3Yhnd/8+uMsYEZDbRhQVTLyydttpW8MmtOJ6boLcQ
q9Kac8tRMZA1cajh12ODJNUeICIQX40rZs4WpXiQq8BIhsMKBr1SKY/Sb9WlD/sz
YE6TOL/vhmUADTa0CwWcUhIM0tGrRk76ydkYrRkmdAhfs7qyyZ8s3MWHvE11qLo4
WIMCoGTSIa9Cbu7TsdgE
=AVpm
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--
