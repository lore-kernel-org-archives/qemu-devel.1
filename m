Received: from eggs.gnu.org ([2001:4830:134:3::10]:33646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dNOlE-000471-5h
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 15:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dNOl7-0006fP-9l
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 15:24:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51685
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dNOl7-0006fI-2s
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 15:24:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5KJO9lN090939
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 15:24:16 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b6mknxa9v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 15:24:15 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 20 Jun 2017 15:24:15 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170620185145.2673e759@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20170620015332.13874-1-david@gibson.dropbear.id.au>
	<20170620015332.13874-4-david@gibson.dropbear.id.au>
	<20170620185145.2673e759@bahia.lab.toulouse-stg.fr.ibm.com>
Date: Tue, 20 Jun 2017 14:24:08 -0500
Message-Id: <149798664805.10485.16662705281385907661@loki>
Subject: Re: [Qemu-devel] [PATCH 3/5] spapr: Add DRC release method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Quoting Greg Kurz (2017-06-20 11:51:45)
> On Tue, 20 Jun 2017 09:53:30 +0800
> David Gibson <david@gibson.dropbear.id.au> wrote:
> =

> > At the moment, spapr_drc_release() has an ugly switch on the DRC type to
> > call the right, device-specific release function.  This cleans it up by
> > doing that via a proper QOM method.
> > =

> > It's still arguably an abstraction violation for the DRC code to call i=
nto
> > the specific device code, but one mess at a time.
> > =

> =

> Maybe a second step would be to move DRC subclasses to spapr.c (CPU, LMB)=
 and
> spapr_pci.c (PCI) ? This would allow each device-specific release functio=
n to
> have local scope at least.

I kind of prefer the proposed approach of registering a callback
function via drc_new(). This would make it easier to implement
unit tests without needing to rely on stub functions, and keeps the
type-specific handling constrained to matters relating to the DRC
itself and not the resources associated with them.

> =

> Reviewed-by: Greg Kurz <groug@kaod.org>
> =

> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_drc.c         | 22 ++++++----------------
> >  include/hw/ppc/spapr_drc.h |  1 +
> >  2 files changed, 7 insertions(+), 16 deletions(-)
> > =

> > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > index e5dff16..32e39f2 100644
> > --- a/hw/ppc/spapr_drc.c
> > +++ b/hw/ppc/spapr_drc.c
> > @@ -370,22 +370,9 @@ void spapr_drc_attach(sPAPRDRConnector *drc, Devic=
eState *d, void *fdt,
> >  =

> >  static void spapr_drc_release(sPAPRDRConnector *drc)
> >  {
> > -    /* Calling release callbacks based on spapr_drc_type(drc). */
> > -    switch (spapr_drc_type(drc)) {
> > -    case SPAPR_DR_CONNECTOR_TYPE_CPU:
> > -        spapr_core_release(drc->dev);
> > -        break;
> > -    case SPAPR_DR_CONNECTOR_TYPE_PCI:
> > -        spapr_phb_remove_pci_device_cb(drc->dev);
> > -        break;
> > -    case SPAPR_DR_CONNECTOR_TYPE_LMB:
> > -        spapr_lmb_release(drc->dev);
> > -        break;
> > -    case SPAPR_DR_CONNECTOR_TYPE_PHB:
> > -    case SPAPR_DR_CONNECTOR_TYPE_VIO:
> > -    default:
> > -        g_assert(false);
> > -    }
> > +    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> > +
> > +    drck->release(drc->dev);
> >  =

> >      drc->awaiting_release =3D false;
> >      g_free(drc->fdt);
> > @@ -629,6 +616,7 @@ static void spapr_drc_cpu_class_init(ObjectClass *k=
, void *data)
> >      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_CPU;
> >      drck->typename =3D "CPU";
> >      drck->drc_name_prefix =3D "CPU ";
> > +    drck->release =3D spapr_core_release;
> >  }
> >  =

> >  static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
> > @@ -638,6 +626,7 @@ static void spapr_drc_pci_class_init(ObjectClass *k=
, void *data)
> >      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI;
> >      drck->typename =3D "28";
> >      drck->drc_name_prefix =3D "C";
> > +    drck->release =3D spapr_phb_remove_pci_device_cb;
> >  }
> >  =

> >  static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
> > @@ -647,6 +636,7 @@ static void spapr_drc_lmb_class_init(ObjectClass *k=
, void *data)
> >      drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB;
> >      drck->typename =3D "MEM";
> >      drck->drc_name_prefix =3D "LMB ";
> > +    drck->release =3D spapr_lmb_release;
> >  }
> >  =

> >  static const TypeInfo spapr_dr_connector_info =3D {
> > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > index d9cacb3..6fd84d1 100644
> > --- a/include/hw/ppc/spapr_drc.h
> > +++ b/include/hw/ppc/spapr_drc.h
> > @@ -217,6 +217,7 @@ typedef struct sPAPRDRConnectorClass {
> >      sPAPRDREntitySense (*dr_entity_sense)(sPAPRDRConnector *drc);
> >      uint32_t (*isolate)(sPAPRDRConnector *drc);
> >      uint32_t (*unisolate)(sPAPRDRConnector *drc);
> > +    void (*release)(DeviceState *dev);
> >  =

> >      /* QEMU interfaces for managing hotplug operations */
> >      bool (*release_pending)(sPAPRDRConnector *drc);
>=20
