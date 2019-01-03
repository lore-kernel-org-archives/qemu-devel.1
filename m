Received: from eggs.gnu.org ([208.118.235.92]:38379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZn-0002h6-1p
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZg-00059P-F5
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:37 -0500
Date: Thu, 3 Jan 2019 13:00:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103020058.GK10853@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535259259.862554.5658306444032609904.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NhBACjNc9vV+/oop"
Content-Disposition: inline
In-Reply-To: <154535259259.862554.5658306444032609904.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 06/15] spapr: enable PHB hotplug for
 default pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>


--NhBACjNc9vV+/oop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 01:36:32AM +0100, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> The 'dr_phb_enabled' field of that class can be set as part of
> machine-specific init code. It will be used to conditionally
> enable creation of DRC objects and device-tree description to
> facilitate hotplug of PHBs.
>=20
> Since we can't migrate this state to older machine types,
> default the option to true and disable it for older machine
> types.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Although it makes sense to have this function first while
developing, it's usually best to have it last when you push, so you
don't have a potential bisection breakage where the support is
advertised but not fully working.

> ---
>  hw/ppc/spapr.c         |    2 ++
>  include/hw/ppc/spapr.h |    1 +
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1f17b5d01f4f..621006eaa862 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4011,6 +4011,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_xics;
> +    smc->dr_phb_enabled =3D true;
>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> @@ -4079,6 +4080,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      smc->update_dt_enabled =3D false;
> +    smc->dr_phb_enabled =3D false;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 36033b89d31a..e96deefa30de 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -104,6 +104,7 @@ struct sPAPRMachineClass {
>      /*< public >*/
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
>      bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
> +    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHB=
s */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
>      bool pre_2_10_has_unused_icps;
>      bool legacy_irq_allocation;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NhBACjNc9vV+/oop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwtbNoACgkQbDjKyiDZ
s5KOuBAAvqDY7WaZo6cJfsAtV95twZAPqlTadpBB47CdL+rn2HEv6eyaZ8W+l5ec
ExqQJU4cbuIzO5xVk7ZCcwGwMG+NaHCh0LINJ8MJt0HI9TpbxcKrOLmT3BZ8pDe3
oMF8x2vdt4LUH5vbg26MfkrHv7Az76quqKHtd4VAJDsz/HqHHp2l0JA1O+mZEnHL
Y0DfK7rwRxKoZ8sNMmuEy4shcDuSyNlDf4OQ326gDOSxqeKTHr8dQuKv/E5IYpM/
lbwNzBFC0cXWQfydEFW92pdGUztNKFzPjY57lGXvIVa0BHTIpet2NaqasqGxKsFG
U93iHpf4D50fZHl83DvXLFKOdi9jcZP5f1TVpbPEgYJgI7ileZKbKhI1a3AsejpF
DZzKVwVDuKha1IgJ2u2Huv4d26L744ImHXrb8K+/N7m0S69BjYnDkCFJs34PDszg
evMkFRVjVcMcm63qyPLDRjBHwtEGiZXnmrMl9CWIiVfbAQObBqAGJyTtsFFSs8be
bj+dR/F1xS2XP7E3AIcxG/ZYAl227I7ffajScPx954smDQ3pNjB/zOOHzHHH6tqy
7cQJbz9KtpTGPWxCTV1A7c9w5VBmd8hrYRrAyEpQK1gCYyHWvX7p/h9X1XHSZSqr
KynVKQgkh4M/vi0zx88+ndTjkcHbaXI1GbcGND24WvvmF4o0MJA=
=AD+m
-----END PGP SIGNATURE-----

--NhBACjNc9vV+/oop--
