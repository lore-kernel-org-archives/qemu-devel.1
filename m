Received: from eggs.gnu.org ([2001:4830:134:3::10]:57930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZVWV-0000E9-Os
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZVWU-0005Oj-MC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:03:15 -0400
Date: Mon, 24 Jul 2017 14:36:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724043624.GE17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Content-Disposition: inline
In-Reply-To: <1499274819-15607-9-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] ppc/xive: add flags to the XIVE
 interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 07:13:21PM +0200, C=E9dric Le Goater wrote:
> These flags define some characteristics of the source :
>=20
>  - XIVE_SRC_H_INT_ESB  the Event State Buffer are controlled with a
>                        specific hcall H_INT_ESB

What's the other option?

>  - XIVE_SRC_LSI        LSI or MSI source

Hrm.  This definitely duplicates info that is in the XICS per irq
state which you're re-using (and which you're using in the xive code
at this point).

>  - XIVE_SRC_TRIGGER    the full function page supports trigger
>  - XIVE_SRC_STORE_EOI  EOI can with a store.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xive.c        | 1 +
>  include/hw/ppc/xive.h | 9 +++++++++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 816031b8ac81..8f8bb8b787bd 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -345,6 +345,7 @@ static Property xive_ics_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
>      DEFINE_PROP_UINT32("irq-base", ICSState, offset, 0),
>      DEFINE_PROP_UINT32("shift", XiveICSState, esb_shift, 0),
> +    DEFINE_PROP_UINT64("flags", XiveICSState, flags, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 5303d96f5f59..1178300c9df3 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -30,9 +30,18 @@ typedef struct XiveICSState XiveICSState;
>  #define TYPE_ICS_XIVE "xive-source"
>  #define ICS_XIVE(obj) OBJECT_CHECK(XiveICSState, (obj), TYPE_ICS_XIVE)
> =20
> +/*
> + * XIVE Interrupt source flags
> + */
> +#define XIVE_SRC_H_INT_ESB     (1ull << (63 - 60))
> +#define XIVE_SRC_LSI           (1ull << (63 - 61))
> +#define XIVE_SRC_TRIGGER       (1ull << (63 - 62))
> +#define XIVE_SRC_STORE_EOI     (1ull << (63 - 63))
> +
>  struct XiveICSState {
>      ICSState parent_obj;
> =20
> +    uint64_t     flags;
>      uint32_t     esb_shift;
>      MemoryRegion esb_iomem;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1eUgACgkQbDjKyiDZ
s5Ko+g/6AxWh1FAakHDCbv4XhgLfS5lq/kVgTTHSJ2+rBAk7SGf9mYR8QQ2ZNbbU
Lnau18/dWBeVHj6u0nzCGCtVy9igkr5GrC0fjdcgmDd1EU63yo2VIHdZsmtLbfpO
yvWeO/l9Gfd6C37UrmGdZxCj51zO64NCAALsQLr8iOLjS5ivBbsVYMwZIVEyrRYg
/K8bgyrIg36TVWtQ9BoOOiviLTbcE4JzLCvGNwDDA5uhkTjIh6ZS1RcgGW6gSU7v
A04OQe/eJB1EUEYSO3XVPvkM5jVMESU7FzpoCkek9ovKZeMIlTv1pf+JAtzyzFfl
MeWMUUUVmpYQSoPOHAJXy85COQ+lWGPp/wScCLXV1OHljfLR/bKzy38p5KOdGRYt
twKfcMt703gYd/BbhEUm4owGLjqu1lIBs5kWQidw/8VTzvxApJfl3V/gEVmJRYkS
w0kcCaea18l1HEHCG6ooSOj7BOaXs/6KjyqmxqvBNngVf5WTg6hx8QPZ2ISD2kAd
txVCwu3o94Zncp1qesENePIA/bundjMNKy3RaHUd55Vfm6g+jRSryVbqQNdaqSX4
mkD2JdxBQSaF4xb/Z3Su7J+GOvx3hMiEy6Me3PmldJAcjEUQbUyEsqgtt7yjXTEf
EsOJKiJRC9/6jz5CM+o3rm5YH7gMjZVibJ8PRKNMeR85mQWnatg=
=OgiY
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
