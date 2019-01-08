Received: from eggs.gnu.org ([209.51.188.92]:60908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ggo7C-00038H-HZ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ggo76-0005fV-Ss
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:56:06 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:54009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ggo75-0005aa-SP
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:56:00 -0500
Received: from player792.ha.ovh.net (unknown [10.109.159.157])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id CF5A139959
	for <qemu-devel@nongnu.org>; Tue,  8 Jan 2019 10:55:56 +0100 (CET)
Date: Tue, 8 Jan 2019 10:55:32 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190108105532.260e4548@bahia.lan>
In-Reply-To: <20190103020058.GK10853@umbus.fritz.box>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535259259.862554.5658306444032609904.stgit@bahia.lan>
	<20190103020058.GK10853@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/eIwgy81Da1D5+sueqfSOZWY";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

--Sig_/eIwgy81Da1D5+sueqfSOZWY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Jan 2019 13:00:58 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Dec 21, 2018 at 01:36:32AM +0100, Greg Kurz wrote:
> > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> >=20
> > The 'dr_phb_enabled' field of that class can be set as part of
> > machine-specific init code. It will be used to conditionally
> > enable creation of DRC objects and device-tree description to
> > facilitate hotplug of PHBs.
> >=20
> > Since we can't migrate this state to older machine types,
> > default the option to true and disable it for older machine
> > types.
> >=20
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Although it makes sense to have this function first while
> developing, it's usually best to have it last when you push, so you
> don't have a potential bisection breakage where the support is
> advertised but not fully working.
>=20

Yes you're right. I've done so for v2.

> > ---
> >  hw/ppc/spapr.c         |    2 ++
> >  include/hw/ppc/spapr.h |    1 +
> >  2 files changed, 3 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 1f17b5d01f4f..621006eaa862 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -4011,6 +4011,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> >      spapr_caps_add_properties(smc, &error_abort);
> >      smc->irq =3D &spapr_irq_xics;
> > +    smc->dr_phb_enabled =3D true;
> >  }
> > =20
> >  static const TypeInfo spapr_machine_info =3D {
> > @@ -4079,6 +4080,7 @@ static void spapr_machine_3_1_class_options(Machi=
neClass *mc)
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
> >      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
> >      smc->update_dt_enabled =3D false;
> > +    smc->dr_phb_enabled =3D false;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 36033b89d31a..e96deefa30de 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -104,6 +104,7 @@ struct sPAPRMachineClass {
> >      /*< public >*/
> >      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of L=
MBs */
> >      bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
> > +    bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of P=
HBs */
> >      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> >      bool pre_2_10_has_unused_icps;
> >      bool legacy_irq_allocation;
> >  =20
>=20


--Sig_/eIwgy81Da1D5+sueqfSOZWY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlw0c5QACgkQcdTV5YIv
c9byKhAAmUblfWtro/qrq8TuadyONrWzeoH3R9UlVuC0/kO5/gzy6ntGVwSkBYkb
b5GamiHwpJDlmTBBkiBCt7bE5RevckQs1h4Jj5+A8dlI0f2gQaR83QAanFrabF7O
PkOBV3jNz5KM8e55F5m7uDv1eAiN9g5lnEXIxCJ0dPZjWDmJ1gaAXbBPqqn9/x2u
0LD3cxpxSPUyBPIN0T2grf/9IBs07YbdsoHENKpabFE19+5TAqQG5ELlbzGavqgo
wvO9N2XqV0JdLIZxVvayBGe8RD+ofJJi414x9ccj0Og2hwkgyHMR2YwswDdfqCqo
AasPC0uouIoM0qFimq78QlptF3pvwvX6flJuC5sJLQE7WDGXJx6DQ+lf+lSgc8kF
WVy64uollEIOS7l3G0VU+moHorFKVCtUTE0TRUbRjLjfajlyxVz/QEIVajmHcoOy
0/Q78FpNbAPktQ5yF+G4aUeXOc6rT9d1c8SliBqSyx5KXkUTo+HZudEYfhGfFOmb
hGGipucg8N3md2xf1KEDl+4V1CfBxvGtWLokOy4Px6LfPvbfk2O77VKvXifwoYyR
WAgDyIVm3q+ytGC+Xs6k1wvQS0+N92uJK6WGAxPDDlEKf0DahlU/PyhsTXYYQ0vN
xusJ475TLCLhU4SlBA5I+7+R/la6+fF3i2NiT91VvoaXxq83Gnc=
=pNqm
-----END PGP SIGNATURE-----

--Sig_/eIwgy81Da1D5+sueqfSOZWY--
