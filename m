Received: from eggs.gnu.org ([2001:4830:134:3::10]:35056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxlnd-0006r4-AW
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxlna-0008Ca-8J
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:44:57 -0400
Date: Tue, 11 Apr 2017 12:43:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170411024325.GX27571@umbus>
References: <1491832618-27536-1-git-send-email-clg@kaod.org>
	<1491832618-27536-7-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8D1TCnBmjJJF2KCx"
Content-Disposition: inline
In-Reply-To: <1491832618-27536-7-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 6/8] ppc/pnv: populate device tree for
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


--8D1TCnBmjJJF2KCx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 03:56:56PM +0200, C=E9dric Le Goater wrote:
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
>=20
>  Changes sinve v1:
>=20
>  - reworked the assignement of the ISA IO base in the 'reg' array
>    property
> =20
>  hw/ppc/pnv.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7f2f9897f146..ec5d62a479b3 100644
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

Remove the initializer here.  It's always set below, and having the
initializer could suppress a useful warning if the code below was
rearranged.

> +    uint32_t io_regs[] =3D {
> +        cpu_to_be32(1),
> +        0, /* 'io_base' retrieved from the 'ioport' property of 'isa-ipm=
i-bt' */
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

--8D1TCnBmjJJF2KCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7ELNAAoJEGw4ysog2bOSPLkQAJd22isTV4booEiTPYTGWKwn
+JkTEI2drufjq5dqaeSpyc1hrdKH8436pceoIo5bHc+rJ4qX0v5yyBM2emCpNC44
TrCx5a4nRNNfHCx/EjDnIqX2Qu6/u68taklsKZN15R22rkDuXRH3Goi4LO9GxcDD
/9GRD7CGQhNtxyO781P7eBbndPYPljLcJaUeZ+HmVNQ9vy1WWh8TA08KdL99rN+8
YQDuqsnVUZdxP7rj7ejAYCN6UHZctzFbC4YsIs+XRAoVyDt+kLJNaq9S8w/7JqV1
TBtXGwqn8dDhXh0jr8R3rGOsewYhEtXoDIyYtjH7cMZv1paXP+x7bWKHqM0IPRyq
n0jBJkKoHZqbOgV4cOzAUbT3CQqSeyzSGw1XvLxdqXv4HQsnv3NABJc4gsxfp8XY
Gk9H7IYH2LPw011TN+BPJbR+gCpbcGpKe/ButJ2p+zUik2ttGxeBDqCk2msk++xc
IpnmdfmLqu9c1L801RYIrc8Bw/vg3vSNs+RiF3ie57L2oosFkDnghgtNGHwDNQn6
/H2WBXAzdcBTIufgHerp+SIVk2N4MsRjV1TYiPCniD8I98nMXFThLvyvy4a/tLXw
7xt2oUP6YxTpK7eucLRxHXQlAqf4Pu0PC0n/sGdCVhem1YnZp9svnZDZwamNZWOc
tiMxo2HGhcYbX5kCu6pV
=ogZK
-----END PGP SIGNATURE-----

--8D1TCnBmjJJF2KCx--
