Received: from eggs.gnu.org ([2001:4830:134:3::10]:45799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dwbE9-0004by-5U
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dwbE5-0001j7-O8
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:47:45 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:37994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dwbE5-0001ib-En
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:47:41 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 0ED5677680
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 23:47:39 +0200 (CEST)
Date: Mon, 25 Sep 2017 23:47:30 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170925234730.29b7b919@bahia.lan>
In-Reply-To: <20170925174857.6021d0a0@bahia.lan>
References: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
	<20170925154134.7b4b8cde@nial.brq.redhat.com>
	<20170925174857.6021d0a0@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: move registration of
 "host" CPU core type to machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

On Mon, 25 Sep 2017 17:48:57 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Mon, 25 Sep 2017 15:41:34 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > On Mon, 25 Sep 2017 11:47:33 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >  =20
> > > The CPU core abstraction belongs to the machine code. This also gets
> > > rid of some code duplication.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >=20
> > > hw/ppc/spapr_cpu_core.h is also included elsewhere in target/ppc/kvm.c
> > > but this is already handled by the following cleanup patch:
> > >=20
> > > https://patchwork.ozlabs.org/patch/817598/
> > > ---
> > >  hw/ppc/spapr.c                  |    4 ++++
> > >  hw/ppc/spapr_cpu_core.c         |   34 ++++++++++++++++++++++-------=
-----
> > >  include/hw/ppc/spapr_cpu_core.h |    2 +-
> > >  target/ppc/kvm.c                |   12 ------------
> > >  4 files changed, 27 insertions(+), 25 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 0ce3ec87ac59..e82c8532ffb0 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2349,6 +2349,10 @@ static void ppc_spapr_init(MachineState *machi=
ne)
> > >      }
> > > =20
> > >      /* init CPUs */
> > > +    if (kvm_enabled()) {
> > > +        spapr_cpu_core_register_host_type();
> > > +    }   =20
> > why don't we create it statically in hw/ppc/spapr_cpu_core.c
> > like it's done in x86, i.e.
> >=20
> >   static void x86_cpu_register_types(void)                             =
           =20
> >   {                                                                    =
           =20
> >   ...                             =20
> >   #ifdef CONFIG_KVM                                                    =
           =20
> >       type_register_static(&host_x86_cpu_type_info);                   =
           =20
> >   #endif                                                               =
           =20
> >   }=20
> >   type_init(x86_cpu_register_types)
> >=20
> > and do the same for host CPU as well?
> >  =20
>=20
> Hi Igor,
>=20
> Not sure yet why we use dynamic types, but I'd be glad to dig a bit more.

So the problem is that it was decided to make the host CPU class a
subclass of the host's CPU model, and this requires all the CPU model
classes to be registered beforehand.

commit 5ba4576b858c0d6056f59abb7e17a2b63f7905f3
Author: Andreas F=C3=A4rber <afaerber@suse.de>
Date:   Sat Feb 23 11:22:12 2013 +0000

    target-ppc: Make host CPU a subclass of the host's CPU model
   =20
    This avoids assigning individual class fields and contributors
    forgetting to add field assignments in KVM-only code.
   =20
    ppc_cpu_class_find_by_pvr() requires the CPU model classes to be
    registered, so defer host CPU type registration to kvm_arch_init().
   =20
    Only register the host CPU type if there is a class with matching PVR.
    This lets us drop error handling from instance_init.
   =20
    Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
    Signed-off-by: Alexander Graf <agraf@suse.de>

I can't think of an alternate way to do this. Any suggestion ?

> Maybe I'll do this in a followup patch though, since the present patch
> is mostly about not referencing sPAPRCPUCore from the KVM code anymore.
>=20
> > my gripe with 'dynamic' types is that it creates problems
> > if one needs to access type information before type is created.
> > In my use-case it's before machine_init() is called but
> > after kvm is initialized, so I was sort of 'fine' with way
> > it's currently handled /i.e. still too much convoluted with
> > aliases redefinition and all but sort of 'manageable' /.
> >=20
> > However I'd very much prefer static type info so it
> > could be used regardless of place/time it's accessed.
> >  =20
>=20
> I agree that it would be better.
>=20
> > I can add a couple patches to that effect into upcomming
> > cpu_model removal series, if that's ok for PPC folks.
> >  =20
>=20
> Oh, and can you share an url to see how it looks like ?
>=20
> Cheers,
>=20
> --
> Greg
>=20
> >  =20
> > > +
> > >      if (machine->cpu_model =3D=3D NULL) {
> > >          machine->cpu_model =3D kvm_enabled() ? "host" : smc->tcg_def=
ault_cpu;
> > >      }
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index c08ee7571a50..6e224ba029ec 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -317,7 +317,7 @@ static Property spapr_cpu_core_properties[] =3D {
> > >      DEFINE_PROP_END_OF_LIST()
> > >  };
> > > =20
> > > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > > +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > >  {
> > >      DeviceClass *dc =3D DEVICE_CLASS(oc);
> > >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_CLASS(oc);
> > > @@ -337,6 +337,20 @@ static const TypeInfo spapr_cpu_core_type_info =
=3D {
> > >      .class_size =3D sizeof(sPAPRCPUCoreClass),
> > >  };
> > > =20
> > > +static void spapr_cpu_core_register_type(const char *model_name)
> > > +{
> > > +    TypeInfo type_info =3D {
> > > +        .parent =3D TYPE_SPAPR_CPU_CORE,
> > > +        .instance_size =3D sizeof(sPAPRCPUCore),
> > > +        .class_init =3D spapr_cpu_core_class_init,
> > > +        .class_data =3D (void *) model_name,
> > > +    };
> > > +
> > > +    type_info.name =3D g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, mod=
el_name);
> > > +    type_register(&type_info);
> > > +    g_free((void *)type_info.name);
> > > +}
> > > +
> > >  static void spapr_cpu_core_register_types(void)
> > >  {
> > >      int i;
> > > @@ -344,18 +358,14 @@ static void spapr_cpu_core_register_types(void)
> > >      type_register_static(&spapr_cpu_core_type_info);
> > > =20
> > >      for (i =3D 0; i < ARRAY_SIZE(spapr_core_models); i++) {
> > > -        TypeInfo type_info =3D {
> > > -            .parent =3D TYPE_SPAPR_CPU_CORE,
> > > -            .instance_size =3D sizeof(sPAPRCPUCore),
> > > -            .class_init =3D spapr_cpu_core_class_init,
> > > -            .class_data =3D (void *) spapr_core_models[i],
> > > -        };
> > > -
> > > -        type_info.name =3D g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE,
> > > -                                         spapr_core_models[i]);
> > > -        type_register(&type_info);
> > > -        g_free((void *)type_info.name);
> > > +        spapr_cpu_core_register_type(spapr_core_models[i]);
> > >      }
> > > +
> > > +}
> > > +
> > > +void spapr_cpu_core_register_host_type(void)
> > > +{
> > > +    spapr_cpu_core_register_type("host");
> > >  }
> > > =20
> > >  type_init(spapr_cpu_core_register_types)
> > > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_c=
pu_core.h
> > > index 93051e9ecf56..e3e906343048 100644
> > > --- a/include/hw/ppc/spapr_cpu_core.h
> > > +++ b/include/hw/ppc/spapr_cpu_core.h
> > > @@ -36,5 +36,5 @@ typedef struct sPAPRCPUCoreClass {
> > >  } sPAPRCPUCoreClass;
> > > =20
> > >  char *spapr_get_cpu_core_type(const char *model);
> > > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
> > > +void spapr_cpu_core_register_host_type(void);
> > >  #endif
> > > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > > index 5b281b2f1b6d..8dd80993ec9e 100644
> > > --- a/target/ppc/kvm.c
> > > +++ b/target/ppc/kvm.c
> > > @@ -37,7 +37,6 @@
> > >  #include "hw/sysbus.h"
> > >  #include "hw/ppc/spapr.h"
> > >  #include "hw/ppc/spapr_vio.h"
> > > -#include "hw/ppc/spapr_cpu_core.h"
> > >  #include "hw/ppc/ppc.h"
> > >  #include "sysemu/watchdog.h"
> > >  #include "trace.h"
> > > @@ -2502,17 +2501,6 @@ static int kvm_ppc_register_host_cpu_type(void)
> > >      oc =3D object_class_by_name(type_info.name);
> > >      g_assert(oc);
> > > =20
> > > -#if defined(TARGET_PPC64)
> > > -    type_info.name =3D g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "ho=
st");
> > > -    type_info.parent =3D TYPE_SPAPR_CPU_CORE,
> > > -    type_info.instance_size =3D sizeof(sPAPRCPUCore);
> > > -    type_info.instance_init =3D NULL;
> > > -    type_info.class_init =3D spapr_cpu_core_class_init;
> > > -    type_info.class_data =3D (void *) "host";
> > > -    type_register(&type_info);
> > > -    g_free((void *)type_info.name);
> > > -#endif
> > > -
> > >      /*
> > >       * Update generic CPU family class alias (e.g. on a POWER8NVL ho=
st,
> > >       * we want "POWER8" to be a "family" alias that points to the cu=
rrent
> > >=20
> > >    =20
> >  =20
>=20
>=20
>=20



--=20
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/LTC                      http://www.ibm.com
Tel 33-5-6218-1607

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.
