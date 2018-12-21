Received: from eggs.gnu.org ([2001:4830:134:3::10]:53785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gaHUu-0002xX-3B
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gaHUq-0006c2-Qq
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:53:35 -0500
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:33391)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gaHUq-0006b5-KF
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:53:32 -0500
Received: from player698.ha.ovh.net (unknown [10.109.160.39])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 02A6810ED09
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 10:53:30 +0100 (CET)
Date: Fri, 21 Dec 2018 10:53:13 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181221105313.119c021a@bahia.lan>
In-Reply-To: <285a22ed-c71b-b9de-e01a-f0ada3ca6ae4@kaod.org>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154537411408.891668.13796612948399384908.stgit@bahia.lan>
	<285a22ed-c71b-b9de-e01a-f0ada3ca6ae4@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/15] spapr: Expose the name of the
 interrupt controller node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

On Fri, 21 Dec 2018 09:12:24 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 12/21/18 7:35 AM, Greg Kurz wrote:
> > This will be needed by PHB hotplug in order to access the phandle prope=
rty.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> I would have used the prefix 'spapr_dt_', but it's minor.
>=20

I guess there might be a v2. I'll do the change.

> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20

Thanks!

> Thanks,
>=20
> C.
>=20
> > ---
> >  hw/intc/spapr_xive.c        |    9 +++++++--
> >  hw/intc/xics_spapr.c        |    9 ++++++++-
> >  hw/ppc/spapr_irq.c          |    3 +++
> >  include/hw/ppc/spapr_irq.h  |    1 +
> >  include/hw/ppc/spapr_xive.h |    1 +
> >  include/hw/ppc/xics.h       |    1 +
> >  6 files changed, 21 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> > index 87424de26c1c..0540aac88d2a 100644
> > --- a/hw/intc/spapr_xive.c
> > +++ b/hw/intc/spapr_xive.c
> > @@ -1410,6 +1410,12 @@ void spapr_xive_hcall_init(sPAPRMachineState *sp=
apr)
> >      spapr_register_hypercall(H_INT_RESET, h_int_reset);
> >  }
> > =20
> > +gchar *spapr_xive_get_nodename(sPAPRMachineState *spapr)
> > +{
> > +    return g_strdup_printf("interrupt-controller@%" PRIx64,
> > +                    spapr->xive->tm_base + XIVE_TM_USER_PAGE * (1 << T=
M_SHIFT));
> > +}
> > +
> >  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> >                     uint32_t phandle)
> >  {
> > @@ -1444,8 +1450,7 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint=
32_t nr_servers, void *fdt,
> >                             XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
> >      timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
> > =20
> > -    nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64,
> > -                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << T=
M_SHIFT));
> > +    nodename =3D spapr_xive_get_nodename(spapr);
> >      _FDT(node =3D fdt_add_subnode(fdt, 0, nodename));
> >      g_free(nodename);
> > =20
> > diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > index f67d3c80bf3a..75d40daf518d 100644
> > --- a/hw/intc/xics_spapr.c
> > +++ b/hw/intc/xics_spapr.c
> > @@ -244,6 +244,13 @@ void xics_spapr_init(sPAPRMachineState *spapr)
> >      spapr_register_hypercall(H_IPOLL, h_ipoll);
> >  }
> > =20
> > +#define NODENAME "interrupt-controller"
> > +
> > +gchar *spapr_xics_get_nodename(sPAPRMachineState *spapr)
> > +{
> > +    return g_strdup(NODENAME);
> > +}
> > +
> >  void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> >                     uint32_t phandle)
> >  {
> > @@ -252,7 +259,7 @@ void spapr_dt_xics(sPAPRMachineState *spapr, uint32=
_t nr_servers, void *fdt,
> >      };
> >      int node;
> > =20
> > -    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
> > +    _FDT(node =3D fdt_add_subnode(fdt, 0, NODENAME));
> > =20
> >      _FDT(fdt_setprop_string(fdt, node, "device_type",
> >                              "PowerPC-External-Interrupt-Presentation")=
);
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index 0999a2b2d69c..703c3a3c20d5 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -223,6 +223,7 @@ sPAPRIrq spapr_irq_xics =3D {
> >      .qirq        =3D spapr_qirq_xics,
> >      .print_info  =3D spapr_irq_print_info_xics,
> >      .dt_populate =3D spapr_dt_xics,
> > +    .get_nodename =3D spapr_xics_get_nodename,
> >      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
> >      .post_load   =3D spapr_irq_post_load_xics,
> >  };
> > @@ -349,6 +350,7 @@ sPAPRIrq spapr_irq_xive =3D {
> >      .qirq        =3D spapr_qirq_xive,
> >      .print_info  =3D spapr_irq_print_info_xive,
> >      .dt_populate =3D spapr_dt_xive,
> > +    .get_nodename =3D spapr_xive_get_nodename,
> >      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xive,
> >      .post_load   =3D spapr_irq_post_load_xive,
> >      .reset       =3D spapr_irq_reset_xive,
> > @@ -462,6 +464,7 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
> >      .qirq        =3D spapr_qirq_xics,
> >      .print_info  =3D spapr_irq_print_info_xics,
> >      .dt_populate =3D spapr_dt_xics,
> > +    .get_nodename =3D spapr_xics_get_nodename,
> >      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
> >      .post_load   =3D spapr_irq_post_load_xics,
> >  };
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index b34d5a00381b..59a1cf8bbc1d 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -42,6 +42,7 @@ typedef struct sPAPRIrq {
> >      void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
> >      void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
> >                          void *fdt, uint32_t phandle);
> > +    gchar *(*get_nodename)(sPAPRMachineState *spapr);
> >      Object *(*cpu_intc_create)(sPAPRMachineState *spapr, Object *cpu,
> >                                 Error **errp);
> >      int (*post_load)(sPAPRMachineState *spapr, int version_id);
> > diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> > index 728735dbcfbe..d280310ed587 100644
> > --- a/include/hw/ppc/spapr_xive.h
> > +++ b/include/hw/ppc/spapr_xive.h
> > @@ -47,6 +47,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
> >  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
> >  void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> >                     uint32_t phandle);
> > +gchar *spapr_xive_get_nodename(sPAPRMachineState *spapr);
> >  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
> > =20
> >  #endif /* PPC_SPAPR_XIVE_H */
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 14afda198cdb..eafb6428787f 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -204,6 +204,7 @@ typedef struct sPAPRMachineState sPAPRMachineState;
> > =20
> >  void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> >                     uint32_t phandle);
> > +gchar *spapr_xics_get_nodename(sPAPRMachineState *spapr);
> >  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> >  void xics_spapr_init(sPAPRMachineState *spapr);
> > =20
> >  =20
>=20
