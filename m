Received: from eggs.gnu.org ([2001:4830:134:3::10]:58813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxZBX-0003As-G1
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cxZBT-0003SR-6R
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:16:47 -0400
Received: from 3.mo68.mail-out.ovh.net ([46.105.58.60]:49471)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cxZBS-0003QW-Vb
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:16:43 -0400
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 56C2A4AFB3
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 15:16:40 +0200 (CEST)
Date: Mon, 10 Apr 2017 15:16:34 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170410151634.538043c8@bahia.lan>
In-Reply-To: <1491396106-26376-12-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-12-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/LTiHxhlKNhkecQx/Y.x.rwL";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 11/21] ppc/pnv: scan ISA bus to
 populate device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/LTiHxhlKNhkecQx/Y.x.rwL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  5 Apr 2017 14:41:36 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> This is an empty shell that we will use to include nodes in the device
> tree for ISA devices. We expect RTC, UART and IPMI BT devices.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 493c7eed7980..a3c8f6594d10 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -281,6 +281,36 @@ static void powernv_populate_chip(PnvChip *chip, voi=
d *fdt)
>      g_free(typename);
>  }
> =20
> +typedef struct ForeachPopulateArgs {
> +    void *fdt;
> +    int offset;
> +} ForeachPopulateArgs;
> +
> +static int powernv_populate_isa_device(DeviceState *dev, void *opaque)
> +{
> +    return 0;
> +}
> +
> +static void powernv_populate_isa(ISABus *bus, void *fdt)
> +{
> +    int lpc_offset;
> +    ForeachPopulateArgs args;
> +
> +    lpc_offset =3D fdt_node_offset_by_compatible(fdt, -1, "ibm,lpc");
> +    if (lpc_offset < 0) {
> +        error_report("Could find the lpc node !?");

s/Could find/Could not find ?

> +        return;
> +    }
> +
> +    args.fdt =3D fdt;
> +    args.offset =3D lpc_offset;
> +
> +    /* ISA devices are not necessarily parented to the ISA bus so we
> +     * can not use object_child_foreach() */
> +    qbus_walk_children(BUS(bus), powernv_populate_isa_device,
> +                       NULL, NULL, NULL, &args);
> +}
> +
>  static void *powernv_create_fdt(MachineState *machine)
>  {
>      const char plat_compat[] =3D "qemu,powernv\0ibm,powernv";
> @@ -328,6 +358,8 @@ static void *powernv_create_fdt(MachineState *machine)
>      for (i =3D 0; i < pnv->num_chips; i++) {
>          powernv_populate_chip(pnv->chips[i], fdt);
>      }
> +
> +    powernv_populate_isa(pnv->isa_bus, fdt);
>      return fdt;
>  }
> =20


--Sig_/LTiHxhlKNhkecQx/Y.x.rwL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljrhbIACgkQAvw66wEB28KdqgCgmuxyudTV6nSAmMhU3/vaqFvP
UscAn0dcfJKXwX70LDyoKhrSsTKfyi0i
=uro6
-----END PGP SIGNATURE-----

--Sig_/LTiHxhlKNhkecQx/Y.x.rwL--
