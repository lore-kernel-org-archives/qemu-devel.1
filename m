Received: from eggs.gnu.org ([2001:4830:134:3::10]:58335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJcbt-00014J-Ov
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJcbs-0003ei-Hj
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:55:25 -0500
Date: Tue, 28 Nov 2017 17:40:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171128064034.GQ11775@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tV/+6PImfyFtriLg"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-12-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 11/25] spapr: describe the XIVE interrupt
 source flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--tV/+6PImfyFtriLg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:41PM +0100, C=E9dric Le Goater wrote:
> The XIVE interrupt sources can have different characteristics depending
> on their nature and the HW level in use. The sPAPR specs provide a set of
> flags to describe them :
>=20
>  - XIVE_SRC_H_INT_ESB  the Event State Buffers are controlled with a
>                        specific hcall H_INT_ESB and not with MMIO
>  - XIVE_SRC_LSI        LSI or MSI source (ICSIRQState level)
>  - XIVE_SRC_TRIGGER    the full function page supports trigger
>  - XIVE_SRC_STORE_EOI  EOI can be done with a store.
>=20
> Our QEMU emulation of XIVE for the sPAPR machine gathers all sources under
> a same model and provides a common source with the XIVE_SRC_TRIGGER type.
> So, the above list is mostly informative apart from the XIVE_SRC_LSI flag
> which will be deduced from the XIVE_STATUS_LSI flag.
>=20
> The OS retrieves this information on the source with the
> H_INT_GET_SOURCE_INFO hcall.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c        | 4 ++++
>  include/hw/ppc/spapr_xive.h | 7 +++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index f45f50fd017e..b1e3f8710cff 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -368,6 +368,10 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
>      /* Allocate the IVT (Interrupt Virtualization Table) */
>      xive->ivt =3D g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
> =20
> +    /* All sources are emulated under the XIVE object and share the
> +     * same characteristic */
> +    xive->flags =3D XIVE_SRC_TRIGGER;

You never actually use this field.  And since it always has the same
value, is there a point to storing it?

> +
>      /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte */
>      xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
>      xive->sbe =3D g_malloc0(xive->sbe_size);
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 84c910e62e56..7a308fb4db2b 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -40,6 +40,13 @@ struct sPAPRXive {
>  #define XIVE_STATUS_SENT               0x4
>      uint8_t      *status;
> =20
> +    /* Interrupt source flags */
> +#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
> +#define XIVE_SRC_LSI           (1ull << (63 - 61))
> +#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
> +#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
> +    uint32_t     flags;
> +
>      /* XIVE internal tables */
>      XiveIVE      *ivt;
>      uint8_t      *sbe;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tV/+6PImfyFtriLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlodBOIACgkQbDjKyiDZ
s5IaLA/7BBP2cRgOjKiQAA9Emdl84GcCWSAgA1W+QLw5e4pH6dXUTQiBgDa3GpZb
sj7QzH0XEcd5mGb1AdbBHcrEC7DLZs+cCE7eCpSzcs0WQoWE4/mi74Dy4y8lckow
slEHT+/SHwjNvjrd8PYdLPruQhvXKVm/moENQ8N1OjrIc2f4kRrzjNRnkj/tidbw
/o1sYEY4WYYJ5yX59vIpeXtA26f4yteMN3dRUll/mKC+xOC7hprLJgwuO1o0O1bC
lhNjAGYP+H+KSS+TiuUvP5kornwX6Cqhs8tM5Mpos4+vnLQRQH/67/CHegI7Ckjt
BoZBOKBVthbPP8OhRU+58kdqZDafymMfIPJK5rCfs9WvI19Al4kOgOVLS1ipDz6o
WZ2agbct20AAZ2BmOnunhU73ZOZciLx6ltRLsV+Zh1Rv+z3sXnThYEOpEWK0B6O7
6hceDm7j8ImtgE943UcneLF91hfLu8LXEybUr1tssOZNwVDAuI0LoLDiVBkT0PjM
9GgG7kfzw3atEiqiCHudtIVIciVeU89B+TkA4XmK5dztgrJYfhmeV/a0rf5JvRUK
K0aAt/Uk9scGfSxU9h2ehkLyqf/5Uv0pW1osJOYpzbj00NZgPJRp29NgPwJO0xF9
1xB9zC2EB5G1kkRBJfVBNzKeEe+cOnWE/nQ54JWnoTCl8BORNe4=
=5Zy0
-----END PGP SIGNATURE-----

--tV/+6PImfyFtriLg--
