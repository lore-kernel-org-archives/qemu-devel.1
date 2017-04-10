Received: from eggs.gnu.org ([2001:4830:134:3::10]:40016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxRlk-0007Ag-50
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxRlg-0005bS-5P
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 01:21:40 -0400
Date: Mon, 10 Apr 2017 15:17:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170410051738.GJ27571@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-12-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-12-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 11/21] ppc/pnv: scan ISA bus to populate
 device tree
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


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:36PM +0200, C=E9dric Le Goater wrote:
> This is an empty shell that we will use to include nodes in the device
> tree for ISA devices. We expect RTC, UART and IPMI BT devices.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This is so simple, I'd probably fold it into the next patch.  But
apart from that.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6xVvAAoJEGw4ysog2bOS25YP/RmADoyr0rhkPZv6iEUgbVIC
cmNEtd8cxj2k+vguCq3ZJZ68HY/3XeplB1TzlVWYlcju1fqhoYa4uEAc05aWzq9a
QJAwU42sdDwoHB/qZwhXnaPCI+G+m+HL4gKgNVH0LiGp/QNNX/xkF4nZwJ1VnmwP
cAJNk6fHfaRXjx83WpMu+U6IS7mcTtgGs5eFBpX0ULiwzQmBkZMJEr3bNGs/YtAE
OOWpBCzDtBV4Yt+rpW9nnz1Ng7DB5IFwD0IeHwkO5xYmU4jGl9Yl7v9ELOVZIEYy
nr7Ff8GVJGnpCg3ljuJoHRJUG3+7j95mcfN9YYfzwle/Zk4fB8RM0To/I8H1NARs
xBOOuajKehoFkbQKEeEMRlFFnHhTcil+ZXwRv/0uVjO0wLk28ROYf+pV+de3J6/F
axzwPiADYzjSFE8/6HzEnQEXviQvJ6q6iOxwRCapESv5GYcPnZCz3m/5zXFCVD9d
vTVZCOmkm4kPhWXh2wFzrwFB3Vk0YdBYpq3Pk4NOUqigmVLsc1FtyJVOtF57VDJM
0TMNEUbCMXb30E78kQ4NfKCjpGClEyByrZ6v+hQXvHkSQslI5777/Wcck9yTyFuW
7L1j9+T+/ExQ9vq1gZkqTqNDvR2KxNi/rp+JsknwTkn/AVeaxtYiQ4dSrgBoXk5h
X1gBHEanblm+u33Lj+1a
=sXFT
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
