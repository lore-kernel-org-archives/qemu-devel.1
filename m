Received: from eggs.gnu.org ([2001:4830:134:3::10]:60292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr7-0002VW-9H
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daDr6-0005lR-85
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:23:29 -0400
Date: Wed, 26 Jul 2017 14:04:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726040459.GT8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100557147.27487.5031800506520955290.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h1wVxq8aeHrvhZJz"
Content-Disposition: inline
In-Reply-To: <150100557147.27487.5031800506520955290.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 07/26] spapr_drc: fix realize and
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--h1wVxq8aeHrvhZJz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 07:59:31PM +0200, Greg Kurz wrote:
> If object_property_add_alias() returns an error in realize(), we should
> propagate it to the caller and certainly not unref the DRC.
>=20
> Same thing goes for unrealize(). Since object_property_del() is the last
> call, we can even get rid of the intermediate Error *.
>=20
> And finally, unrealize() should undo all registrations performed by
> realize().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I've applied this to ppc-for-2.11, but this looks like it could be a
real bug fix.  So I'm wondering if I should push it for 2.10 (we're in
hard freeze, but bugfixes can still be applied).

> ---
>  hw/ppc/spapr_drc.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index e4e8383ec7b5..d72453bcb42f 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -506,12 +506,12 @@ static void realize(DeviceState *d, Error **errp)
>      trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
>      object_property_add_alias(root_container, link_name,
>                                drc->owner, child_name, &err);
> +    g_free(child_name);
>      g_free(link_name);
>      if (err) {
> -        error_report_err(err);
> -        object_unref(OBJECT(drc));
> +        error_propagate(errp, err);
> +        return;
>      }
> -    g_free(child_name);
>      vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_d=
rc,
>                       drc);
>      qemu_register_reset(drc_reset, drc);
> @@ -523,17 +523,14 @@ static void unrealize(DeviceState *d, Error **errp)
>      sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
>      Object *root_container;
>      gchar *name;
> -    Error *err =3D NULL;
> =20
>      trace_spapr_drc_unrealize(spapr_drc_index(drc));
> +    qemu_unregister_reset(drc_reset, drc);
> +    vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
>      root_container =3D container_get(object_get_root(), DRC_CONTAINER_PA=
TH);
>      name =3D g_strdup_printf("%x", spapr_drc_index(drc));
> -    object_property_del(root_container, name, &err);
> +    object_property_del(root_container, name, errp);
>      g_free(name);
> -    if (err) {
> -        error_report_err(err);
> -        object_unref(OBJECT(drc));
> -    }
>  }
> =20
>  sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h1wVxq8aeHrvhZJz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4FOsACgkQbDjKyiDZ
s5KA5xAApFYJIQDziZWw9h0ORci+/vGNlFwz5nKBJRzViLFhZbVpWbh/Ggg7u3E0
/fbud3iik7jXDbMZX4FsmSqVSlKNedUuDQfUikRgQkr40aTScHzlcvK2Ek81hVAa
qw+M5FRgdujK1PpVRGP71IYqrRA5GcqjAAjZLFXf7hh6n2xBx5TVy+ioEi7dTkpP
Gkm9+Hrwsbxx2Pg7OUAuklDP4xl/0wIQNvPvXhPzdWrq8G/ViU0nJOKQ5ga5oFG2
vnnLPn/LCkOIOnCFXcrFax8Jwa1JXoj447ejRnHRduCuNKyhwr0ahU0hchkKLdfS
DElOGStdk4SUZE+XBxX/1lIVGYdLEUKWvLtW1x1HE2CQPKA1JMKVlskjIse45yu/
tS9mnxPrKJK6SEpvl8a3QuQn1JQBrtuOyXYcojWpTBwYbYy+7rEqf59Fws93YsCD
BpQc3dhiYmw4sk3CB4yyf3qGnQ71WQw3Ndi8D1Coya0rd71SfOndVOjkf3vTAvrV
kChXaHI7ILh417M+FCs2IOrTpRUk1KMZC7UkZ3DobrHdQOMcJUcYRbCzCnj1COyc
PZClZgx2Znv9p4zeADndmWF66aZGFRLCm7+Sq+QCfobqlPQMq5Tkn9C+0+O6RR/a
YYS+rmObxUTvPxSO70tqZI+Zx6UEXY7U861tpetEAF1YG414fKA=
=r4sk
-----END PGP SIGNATURE-----

--h1wVxq8aeHrvhZJz--
