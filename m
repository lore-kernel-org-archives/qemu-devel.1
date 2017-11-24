Received: from eggs.gnu.org ([2001:4830:134:3::10]:36080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIAiI-0006du-6s
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIAiC-0004yk-Pl
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:56:02 -0500
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:47390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eIAiC-0004xe-H2
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:55:56 -0500
Received: from player758.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id CD9FC170D20
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 10:55:54 +0100 (CET)
Date: Fri, 24 Nov 2017 10:55:47 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171124105547.4234dc14@bahia.lan>
In-Reply-To: <20171124025100.GA28000@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-2-clg@kaod.org>
	<20171124025100.GA28000@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/azfFk.ws.oxG0F7+3LCYd1A";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 01/25] ppc/xics: introduce an
 icp_create() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/azfFk.ws.oxG0F7+3LCYd1A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Nov 2017 13:51:00 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Nov 23, 2017 at 02:29:31PM +0100, C=C3=A9dric Le Goater wrote:
> > The sPAPR and the PowerNV core objects create the interrupt presenter
> > object of the CPUs in a very similar way. Let's provide a common
> > routine in which we use the presenter 'type' as a child identifier.
> >=20
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org> =20
>=20
> One tiny nit.., apart from that
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> > ---
> >  hw/intc/xics.c          | 22 ++++++++++++++++++++++
> >  hw/ppc/pnv_core.c       | 10 +---------
> >  hw/ppc/spapr_cpu_core.c | 13 ++-----------
> >  include/hw/ppc/xics.h   |  3 +++
> >  4 files changed, 28 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index a1cc0e420c98..e4ccdff8f577 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -384,6 +384,28 @@ static const TypeInfo icp_info =3D {
> >      .class_size =3D sizeof(ICPStateClass),
> >  };
> > =20
> > +Object *icp_create(CPUState *cs, const char *type, XICSFabric *xi, Err=
or **errp)
> > +{
> > +    Object *child =3D OBJECT(cs); =20
>=20
> In the original context 'child' made sense, since it was the child
> object of the core.  Here, it's misleading, since it's the parent of
> the xics link.  It's only used in a couple of places, so I suggest you

Oops yes :)

> just opencode OBJECT(cs) in each place.
>=20

or rename child to owner, as it is done with DRCs and TCE tables.

> > +    Error *local_err =3D NULL;
> > +    Object *obj;
> > +
> > +    obj =3D object_new(type);
> > +    object_property_add_child(child, type, obj, &error_abort);
> > +    object_unref(obj);
> > +    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
> > +                                   &error_abort);
> > +    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_ab=
ort);
> > +    object_property_set_bool(obj, true, "realized", &local_err);
> > +    if (local_err) {
> > +        object_unparent(obj);
> > +        error_propagate(errp, local_err);
> > +        obj =3D NULL;
> > +    }
> > +
> > +    return obj;
> > +}
> > +
> >  /*
> >   * ICS: Source layer
> >   */
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index 82ff440b3334..a066736846f8 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -126,7 +126,6 @@ static void pnv_core_realize_child(Object *child, X=
ICSFabric *xi, Error **errp)
> >      Error *local_err =3D NULL;
> >      CPUState *cs =3D CPU(child);
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -    Object *obj;
> > =20
> >      object_property_set_bool(child, true, "realized", &local_err);
> >      if (local_err) {
> > @@ -134,13 +133,7 @@ static void pnv_core_realize_child(Object *child, =
XICSFabric *xi, Error **errp)
> >          return;
> >      }
> > =20
> > -    obj =3D object_new(TYPE_PNV_ICP);
> > -    object_property_add_child(child, "icp", obj, NULL);
> > -    object_unref(obj);
> > -    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
> > -                                   &error_abort);
> > -    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_ab=
ort);
> > -    object_property_set_bool(obj, true, "realized", &local_err);
> > +    icp_create(cs, TYPE_PNV_ICP, xi, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          return;
> > @@ -148,7 +141,6 @@ static void pnv_core_realize_child(Object *child, X=
ICSFabric *xi, Error **errp)
> > =20
> >      powernv_cpu_init(cpu, &local_err);
> >      if (local_err) {
> > -        object_unparent(obj);
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 4ba8563d49e4..f8a520a2fa2d 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -111,7 +111,6 @@ static void spapr_cpu_core_realize_child(Object *ch=
ild,
> >      Error *local_err =3D NULL;
> >      CPUState *cs =3D CPU(child);
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> > -    Object *obj;
> > =20
> >      object_property_set_bool(child, true, "realized", &local_err);
> >      if (local_err) {
> > @@ -123,21 +122,13 @@ static void spapr_cpu_core_realize_child(Object *=
child,
> >          goto error;
> >      }
> > =20
> > -    obj =3D object_new(spapr->icp_type);
> > -    object_property_add_child(child, "icp", obj, &error_abort);
> > -    object_unref(obj);
> > -    object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(spapr),
> > -                                   &error_abort);
> > -    object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_ab=
ort);
> > -    object_property_set_bool(obj, true, "realized", &local_err);
> > +    icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &local_err);
> >      if (local_err) {
> > -        goto free_icp;
> > +        goto error;
> >      }
> > =20
> >      return;
> > =20
> > -free_icp:
> > -    object_unparent(obj);
> >  error:
> >      error_propagate(errp, local_err);
> >  }
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 2df99be111ce..126b47dec38b 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -212,4 +212,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
> >  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> >  void xics_spapr_init(sPAPRMachineState *spapr);
> > =20
> > +Object *icp_create(CPUState *cs, const char *type, XICSFabric *xi,
> > +                   Error **errp);
> > +
> >  #endif /* XICS_H */ =20
>=20


--Sig_/azfFk.ws.oxG0F7+3LCYd1A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAloX7KMACgkQcdTV5YIv
c9YM/RAAk92DAdl/8Vo6JnRbmFUS3Quls66JARe5TmCBNyL5fywYcWcddaM+zgOL
vGSR0Lz1jyCLFX9t6BupHr86bpHoNWT2k5BhY0YB+S0GjUsKddtzQzMzE5VZeWx8
udYvo7rfhnpD4pT7RcZFoN6ypzpyJo5s1d4/COQPBPeqfvgeSGL+3waXnwxl4AK4
LHzPKevYhwHs82Lx2S5hwh/Nze42SQJzRPNeWJ/0khbIM5je0N6+tIuLByB+mF/9
oA8KTjesTDflQD/y9ncqaHZYiNgBpnv01DVM0C7CgC4gHHhg3cZta7RpLxz7fEB5
cfXIgBrGOKKjI1PdL1Fr51epIaQ1hsfvbW8mWXTTGfhgqztrnHpS2RwyCD9xfzF0
4y7VToG8a5VKbewtjhU7zZGocyeTr3+QKcmiOnKo9UcYp8yGu9TgXhzlsaf8TmmQ
0oxgjkL8ALY50/+rAXTJ6f1/g/h5RD+gCN+UahC725fBeLqHXQd2wc77E3J8Ql1+
iNCFqaE0opoP097fSCPUIGao8Y/WSj4aHL0DjUlBRyMhu85wEMHNkxoajOLocIvg
GHEUYrtba6z2QG+IikiCKUVupiO1czIg9k9IAKfDrEAPvGmulOKGx8J906yt0k0b
WeuvnVreZN1N7IL8LRVHjPDm0wW50oT81fIuxfPN3dgqQbMleVs=
=wLMd
-----END PGP SIGNATURE-----

--Sig_/azfFk.ws.oxG0F7+3LCYd1A--
