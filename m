Received: from eggs.gnu.org ([209.51.188.92]:44794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gm1mq-0007Uh-Hs
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gm1mV-0006sD-0Z
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:32:20 -0500
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:58684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gm1mU-0006pM-M8
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:32:18 -0500
Received: from player157.ha.ovh.net (unknown [10.109.159.20])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 3BC3AE743A
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:32:23 +0100 (CET)
Date: Tue, 22 Jan 2019 14:32:02 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190122143202.7cb3a540@bahia.lan>
In-Reply-To: <93efc5e4-26e2-b917-dbe5-0ae819b376d9@kaod.org>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774537811.1208625.5130988447516010112.stgit@bahia.lan>
	<93efc5e4-26e2-b917-dbe5-0ae819b376d9@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 17/19] spapr_irq: Expose the phandle of
 the interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On Fri, 18 Jan 2019 14:46:42 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 1/17/19 6:16 PM, Greg Kurz wrote:
> > This will be used by PHB hotplug in order to create the "interrupt-map"
> > property of the PHB node.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_irq.c         |   44 ++++++++++++++++++++++++++++++++++++=
+++++++-
> >  include/hw/ppc/spapr_irq.h |    3 +++
> >  2 files changed, 46 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index b3e0713428ed..93243cfd0644 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -243,6 +243,11 @@ static void spapr_irq_reset_xics(sPAPRMachineState=
 *spapr, Error **errp)
> >      /* TODO: create the KVM XICS device */
> >  }
> > =20
> > +static const char *spapr_irq_get_nodename_xics(sPAPRMachineState *spap=
r)
> > +{
> > +    return xics_spapr_get_nodename(); =20
>=20
> can't we just return XICS_NODENAME ?
>=20

Sure.

> > +}
> > +
> >  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
> >  #define SPAPR_IRQ_XICS_NR_MSIS     \
> >      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> > @@ -263,6 +268,7 @@ sPAPRIrq spapr_irq_xics =3D {
> >      .post_load   =3D spapr_irq_post_load_xics,
> >      .reset       =3D spapr_irq_reset_xics,
> >      .set_irq     =3D spapr_irq_set_irq_xics,
> > +    .get_nodename =3D spapr_irq_get_nodename_xics,
> >  };
> > =20
> >  /*
> > @@ -401,6 +407,11 @@ static void spapr_irq_set_irq_xive(void *opaque, i=
nt srcno, int val)
> >      xive_source_set_irq(&spapr->xive->source, srcno, val);
> >  }
> > =20
> > +static const char *spapr_irq_get_nodename_xive(sPAPRMachineState *spap=
r)
> > +{
> > +    return spapr_xive_get_nodename(spapr->xive);
> > +}
> > +
> >  /*
> >   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
> >   * with XICS.
> > @@ -425,6 +436,7 @@ sPAPRIrq spapr_irq_xive =3D {
> >      .post_load   =3D spapr_irq_post_load_xive,
> >      .reset       =3D spapr_irq_reset_xive,
> >      .set_irq     =3D spapr_irq_set_irq_xive,
> > +    .get_nodename =3D spapr_irq_get_nodename_xive,
> >  };
> > =20
> >  /*
> > @@ -588,6 +600,11 @@ static void spapr_irq_set_irq_dual(void *opaque, i=
nt srcno, int val)
> >      spapr_irq_current(spapr)->set_irq(spapr, srcno, val);
> >  }
> > =20
> > +static const char *spapr_irq_get_nodename_dual(sPAPRMachineState *spap=
r)
> > +{
> > +    return spapr_irq_current(spapr)->get_nodename(spapr);
> > +}
> > +
> >  /*
> >   * Define values in sync with the XIVE and XICS backend
> >   */
> > @@ -609,7 +626,8 @@ sPAPRIrq spapr_irq_dual =3D {
> >      .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
> >      .post_load   =3D spapr_irq_post_load_dual,
> >      .reset       =3D spapr_irq_reset_dual,
> > -    .set_irq     =3D spapr_irq_set_irq_dual
> > +    .set_irq     =3D spapr_irq_set_irq_dual,
> > +    .get_nodename =3D spapr_irq_get_nodename_dual,
> >  };
> > =20
> >  /*
> > @@ -680,6 +698,29 @@ void spapr_irq_dt_populate(sPAPRMachineState *spap=
r, uint32_t nr_servers,
> >      _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> >  }
> > =20
> > +uint32_t spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt,
> > +                               Error **errp)
> > +{
> > +    const char *nodename =3D spapr->irq->get_nodename(spapr);
> > +    int phandle, offset;
> > +
> > +    offset =3D fdt_subnode_offset(fdt, 0, nodename); =20
>=20
> if I am correct, you changed dt_populate() to return the same offset.
>=20
> > +    if (offset < 0) {
> > +        error_setg(errp, "Can't find node \"%s\": %s", nodename,
> > +                   fdt_strerror(offset));
> > +        return -1;
> > +    }
> > +
> > +    phandle =3D fdt_get_phandle(fdt, offset); =20
>=20
> if we stored the phandle when spapr_irq_dt_populate() is called, I think
> things would be easier. May be under the backend ?=20
>=20

Yes we can do that but SLOF may now update the fdt, so we need
to be able to update the phandle if it got changed. I'll look
how to do that cleanly in v4.

> C.
>=20
>=20
> > +    if (phandle < 0) {
> > +        error_setg(errp, "Can't get phandle of node \"%s\": %s",
> > +                   nodename, fdt_strerror(phandle));
> > +        return -1;
> > +    }
> > +
> > +    return phandle;
> > +}
> > +
> >  /*
> >   * XICS legacy routines - to deprecate one day
> >   */
> > @@ -752,4 +793,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
> >      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
> >      .post_load   =3D spapr_irq_post_load_xics,
> >      .set_irq     =3D spapr_irq_set_irq_xics,
> > +    .get_nodename =3D spapr_irq_get_nodename_xics,
> >  };
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index dfed6b7e9976..d44d659231a6 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -48,6 +48,7 @@ typedef struct sPAPRIrq {
> >      int (*post_load)(sPAPRMachineState *spapr, int version_id);
> >      void (*reset)(sPAPRMachineState *spapr, Error **errp);
> >      void (*set_irq)(void *opaque, int srcno, int val);
> > +    const char *(*get_nodename)(sPAPRMachineState *spapr);
> >  } sPAPRIrq;
> > =20
> >  extern sPAPRIrq spapr_irq_xics;
> > @@ -65,6 +66,8 @@ int spapr_irq_post_load(sPAPRMachineState *spapr, int=
 version_id);
> >  void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
> >  void spapr_irq_dt_populate(sPAPRMachineState *spapr, uint32_t nr_serve=
rs,
> >                             void *fdt, uint32_t phandle);
> > +uint32_t spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt,
> > +                               Error **errp);
> > =20
> >  /*
> >   * XICS legacy routines
> >  =20
>=20
