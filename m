Received: from eggs.gnu.org ([2001:4830:134:3::10]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxS5N-00026o-KH
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxS5K-0002Os-GG
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:41:57 -0400
Date: Mon, 10 Apr 2017 15:23:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170410052354.GM27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-15-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-15-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 14/21] ppc/pnv: populate device tree for
 IPMI BT devices
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


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:39PM +0200, C=E9dric Le Goater wrote:
> When an ipmi-bt device [1] is defined on the ISA bus, we need to
> populate the device tree with the object properties. Such devices are
> created with the command line options :
>=20
>    -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg03168.html
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 00e594a0cbe3..dfa1cf849b35 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -332,6 +332,39 @@ static void powernv_populate_serial(ISADevice *d, vo=
id *fdt, int lpc_off)
>      _FDT((fdt_setprop_string(fdt, node, "device_type", "serial")));
>  }
> =20
> +static void powernv_populate_ipmi_bt(ISADevice *d, void *fdt, int lpc_of=
f)
> +{
> +    const char compatible[] =3D "bt\0ipmi-bt";
> +    uint32_t io_base =3D 0x0;
> +    uint32_t io_regs[] =3D {
> +        cpu_to_be32(1),
> +        cpu_to_be32(io_base),

Best not to include this part of the initializer, since you have to
overwrite it later anyway.  Either just use 0 with a /*placeholder */
comment, or use designated array initializers.

> +        cpu_to_be32(3)
> +    };
> +    uint32_t irq;
> +    char *name;
> +    int node;
> +
> +    io_base =3D object_property_get_int(OBJECT(d), "ioport", &error_fata=
l);
> +    io_regs[1] =3D cpu_to_be32(io_base);
> +
> +    irq =3D object_property_get_int(OBJECT(d), "irq", &error_fatal);
> +
> +    name =3D g_strdup_printf("%s@i%x", qdev_fw_name(DEVICE(d)), io_base);
> +    node =3D fdt_add_subnode(fdt, lpc_off, name);
> +    _FDT(node);
> +    g_free(name);
> +
> +    fdt_setprop(fdt, node, "reg", io_regs, sizeof(io_regs));
> +    fdt_setprop(fdt, node, "compatible", compatible, sizeof(compatible));
> +
> +    /* Mark it as reserved to avoid Linux trying to claim it */
> +    _FDT((fdt_setprop_string(fdt, node, "status", "reserved")));
> +    _FDT((fdt_setprop_cell(fdt, node, "interrupts", irq)));
> +    _FDT((fdt_setprop_cell(fdt, node, "interrupt-parent",
> +                           fdt_get_phandle(fdt, lpc_off))));
> +}
> +
>  typedef struct ForeachPopulateArgs {
>      void *fdt;
>      int offset;
> @@ -346,6 +379,8 @@ static int powernv_populate_isa_device(DeviceState *d=
ev, void *opaque)
>          powernv_populate_rtc(d, args->fdt, args->offset);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_ISA_SERIAL)) {
>          powernv_populate_serial(d, args->fdt, args->offset);
> +    } else if (object_dynamic_cast(OBJECT(dev), "isa-ipmi-bt")) {
> +        powernv_populate_ipmi_bt(d, args->fdt, args->offset);
>      } else {
>          error_report("unknown isa device %s@i%x", qdev_fw_name(dev),
>                       d->ioport_id);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6xbpAAoJEGw4ysog2bOS2QcP+QEOkf3pBwnhjxUn5gsUrFxn
4Pzapag74a2QAW7wvdTD7oOrv8gU7P6/vWVW9nYPZiO7jmnfZc+pyKJrj91r0uHj
sAFGav3jWbLtVZDcdpOiB/zQCKA1gfw5C3pflyU0zUyNAMEvxwVrxykLu56Rgukx
tzVGm3CGodMLr1zt4zoHfPuquBbW+ISZbUepglrpWsuv2MoxnA/Xo6hAtJR7EIP5
viOxu3WRVjlT/CXqLeHp2nNw4cWvvZTr9bcknZLGbltHC1yaIvtoYiICrmDtgXE1
xC8VYQ9ffy+OC4Sv6CCy8coMYML2Kr1SoHBhizZNz5TIdEtrvju9NWtDAUiDWiKA
y5fenVBuKLYdOKz1IvpcUr2pkXWEeinviF8fmDDLoUNrpTblKnajaY9wm1kxsGIY
pWLzOyB802b34AGEG3CSyfx/5KRXn68jjxqL0coBbBDcqbe7Nks/B9kZfLtydHk3
64B+MhwxlJmlCHF+LEFfXGtfrwY+sntbS1P+pRSuYYIhrH+0SXEXIif8ss6WLUGQ
/e1LsMcleGUaPwSUn7bKs54BNOSc5sDq4kCWIIeBciUPGTLyM+9NJBFIH7kSZLpb
wXevYHBJ8OuEjC3bHvT3aEeoLfyDbPvUy2KAOnK2vNRyjfQXAOSk3pa/S8KKBiBT
XXOWiCofKl+HGtHRtdR1
=vN6x
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--
