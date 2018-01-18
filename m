Received: from eggs.gnu.org ([2001:4830:134:3::10]:50517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2ft-0005wM-Fr
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec2fs-0001DU-Bh
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:23:41 -0500
Date: Thu, 18 Jan 2018 16:07:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118050754.GN30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-3-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QUAc4O4i7jPlU8jt"
Content-Disposition: inline
In-Reply-To: <20180115063235.7518-3-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 2/6] target/ppc/spapr_caps:
 Add support for tristate spapr_capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org


--QUAc4O4i7jPlU8jt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 05:32:31PM +1100, Suraj Jitindar Singh wrote:
> spapr_caps are used to represent the level of support for various
> capabilities related to the spapr machine type. Currently there is
> only support for boolean capabilities.
>=20
> Add support for tristate capabilities by implementing their get/set
> functions. These capabilities can have the values 0, 1 or 2
> corresponding to broken, workaround and fixed.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to ppc-for-2.12.

> ---
>  hw/ppc/spapr_caps.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |  4 ++++
>  2 files changed, 64 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index d5c9ce774a..436250d77b 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -73,6 +73,66 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v=
, const char *name,
>      spapr->eff.caps[cap->index] =3D value ? SPAPR_CAP_ON : SPAPR_CAP_OFF;
>  }
> =20
> +static void spapr_cap_get_tristate(Object *obj, Visitor *v, const char *=
name,
> +                                   void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    char *val =3D NULL;
> +    uint8_t value =3D spapr_get_cap(spapr, cap->index);
> +
> +    switch (value) {
> +    case SPAPR_CAP_BROKEN:
> +        val =3D g_strdup("broken");
> +        break;
> +    case SPAPR_CAP_WORKAROUND:
> +        val =3D g_strdup("workaround");
> +        break;
> +    case SPAPR_CAP_FIXED:
> +        val =3D g_strdup("fixed");
> +        break;
> +    default:
> +        error_setg(errp, "Invalid value (%d) for cap-%s", value, cap->na=
me);
> +        return;
> +    }
> +
> +    visit_type_str(v, name, &val, errp);
> +    g_free(val);
> +}
> +
> +static void spapr_cap_set_tristate(Object *obj, Visitor *v, const char *=
name,
> +                                   void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    char *val;
> +    Error *local_err =3D NULL;
> +    uint8_t value;
> +
> +    visit_type_str(v, name, &val, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    if (!strcasecmp(val, "broken")) {
> +        value =3D SPAPR_CAP_BROKEN;
> +    } else if (!strcasecmp(val, "workaround")) {
> +        value =3D SPAPR_CAP_WORKAROUND;
> +    } else if (!strcasecmp(val, "fixed")) {
> +        value =3D SPAPR_CAP_FIXED;
> +    } else {
> +        error_setg(errp, "Invalid capability mode \"%s\" for cap-%s", va=
l,
> +                   cap->name);
> +        goto out;
> +    }
> +
> +    spapr->cmd_line_caps[cap->index] =3D true;
> +    spapr->eff.caps[cap->index] =3D value;
> +out:
> +    g_free(val);
> +}
> +
>  static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error *=
*errp)
>  {
>      if (!val) {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index eded0ea57d..61bb3632c4 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -69,6 +69,10 @@ typedef enum {
>  /* Bool Caps */
>  #define SPAPR_CAP_OFF                   0x00
>  #define SPAPR_CAP_ON                    0x01
> +/* Broken | Workaround | Fixed Caps */
> +#define SPAPR_CAP_BROKEN                0x00
> +#define SPAPR_CAP_WORKAROUND            0x01
> +#define SPAPR_CAP_FIXED                 0x02
> =20
>  typedef struct sPAPRCapabilities sPAPRCapabilities;
>  struct sPAPRCapabilities {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QUAc4O4i7jPlU8jt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpgK6oACgkQbDjKyiDZ
s5JF7BAAxptMr/Ud8SLCBtxvEFyptjd5aGI5NlzuWSAVbUBh4dXvLGgXGONPDAC3
KKbXkanmbnieKfKsc5jmKL+SFxCpDs/GW55D8UtG9WLNDK+ptDylxwKvpfOtAr9m
reLK+Z8orNfVxh8zUDt4gcgv1CPY6USm4NyRHdfSYm5L1k4Q2LtaHtb8wM1KneC1
+C6jqGw+cM2Y45wMavcu6bitc5caM/cChXBAJJ5AldMU4+NZQN1ZoBhTj7msUJls
FyUcI1c5Gse88IyS467fn9dCAJYPGvQNYDtVz6BbzsxSrLbdudgo74pjuUxgtVuV
NO2d0hTR7crAOuoJHVt2ZA+YW+xKdXkIDXmniXK4kIG6yPffFzPy1I+IVePoB9/V
u+/m46YCcdJifoW1eghrOm0MD+81HwOeKfzLPeTqUsa6Is2GpHb2NpenqZotNj9t
x9QkHmn2IIbpLGFOZSrcmuTkiE882M19Nfb5q7TQZDitXVaskhxgfSVcHlBQ1cF/
Fs/4V9OVhilrQ3iPs56s2qQXJ1wcChyWVIo7spbyxwe0R3mUEcGZaQH0SSY+Fgc+
t0YJNbUD8c9sbkDq0L40ezbc8IJJcRCBVn27JMW32xmyRu+0wdqTlffhxy8qIAOG
nBZ1Hs5UUOVPQAyY2Fo/pJNz73LFql4ntbe6AEjWtjP7P+egzJo=
=cmvc
-----END PGP SIGNATURE-----

--QUAc4O4i7jPlU8jt--
