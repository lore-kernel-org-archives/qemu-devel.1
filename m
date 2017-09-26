Received: from eggs.gnu.org ([2001:4830:134:3::10]:48832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dwk9e-0008G6-2i
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dwk9a-00063G-SY
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:19:42 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:46405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dwk9a-000613-J9
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:19:38 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id B730272B31
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:19:36 +0200 (CEST)
Date: Tue, 26 Sep 2017 09:19:28 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170926091928.50e115ff@bahia.lan>
In-Reply-To: <20170926025739.GF12504@umbus>
References: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
	<20170926025739.GF12504@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_//V1e5kKcsliR4=WvSdai1gB";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr: move registration of "host" CPU
 core type to machine code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>

--Sig_//V1e5kKcsliR4=WvSdai1gB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Sep 2017 12:57:39 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Sep 25, 2017 at 11:47:33AM +0200, Greg Kurz wrote:
> > The CPU core abstraction belongs to the machine code. This also gets
> > rid of some code duplication.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >=20
> > hw/ppc/spapr_cpu_core.h is also included elsewhere in target/ppc/kvm.c
> > but this is already handled by the following cleanup patch: =20
>=20
> I don't really see what the advantage of this is.  As others have
> pointed out it leads to the host type being registered very late,
> which could cause problems.
>=20

Well, the goal was to consolidate the code to register sPAPRCPUCore types in
the spapr code, instead of open-coding it in spapr_cpu_core.c and kvm.c...=
=20

But now I realize that delaying the registration even more is a bad idea. A=
nd,
the other way round, registering a static type earlier as asked by Igor wou=
ld
require all parent types to be already registered, which seems to be imposs=
ible
to guarantee with the current code.

Maybe we could at least have kvm_ppc_register_host_cpu_type() to call a
function in spapr_cpu_core.c instead of duplicating the registration code ?

> >=20
> > https://patchwork.ozlabs.org/patch/817598/
> > ---
> >  hw/ppc/spapr.c                  |    4 ++++
> >  hw/ppc/spapr_cpu_core.c         |   34 ++++++++++++++++++++++---------=
---
> >  include/hw/ppc/spapr_cpu_core.h |    2 +-
> >  target/ppc/kvm.c                |   12 ------------
> >  4 files changed, 27 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 0ce3ec87ac59..e82c8532ffb0 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2349,6 +2349,10 @@ static void ppc_spapr_init(MachineState *machine)
> >      }
> > =20
> >      /* init CPUs */
> > +    if (kvm_enabled()) {
> > +        spapr_cpu_core_register_host_type();
> > +    }
> > +
> >      if (machine->cpu_model =3D=3D NULL) {
> >          machine->cpu_model =3D kvm_enabled() ? "host" : smc->tcg_defau=
lt_cpu;
> >      }
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index c08ee7571a50..6e224ba029ec 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -317,7 +317,7 @@ static Property spapr_cpu_core_properties[] =3D {
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> > =20
> > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(oc);
> >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_CLASS(oc);
> > @@ -337,6 +337,20 @@ static const TypeInfo spapr_cpu_core_type_info =3D=
 {
> >      .class_size =3D sizeof(sPAPRCPUCoreClass),
> >  };
> > =20
> > +static void spapr_cpu_core_register_type(const char *model_name)
> > +{
> > +    TypeInfo type_info =3D {
> > +        .parent =3D TYPE_SPAPR_CPU_CORE,
> > +        .instance_size =3D sizeof(sPAPRCPUCore),
> > +        .class_init =3D spapr_cpu_core_class_init,
> > +        .class_data =3D (void *) model_name,
> > +    };
> > +
> > +    type_info.name =3D g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, model=
_name);
> > +    type_register(&type_info);
> > +    g_free((void *)type_info.name);
> > +}
> > +
> >  static void spapr_cpu_core_register_types(void)
> >  {
> >      int i;
> > @@ -344,18 +358,14 @@ static void spapr_cpu_core_register_types(void)
> >      type_register_static(&spapr_cpu_core_type_info);
> > =20
> >      for (i =3D 0; i < ARRAY_SIZE(spapr_core_models); i++) {
> > -        TypeInfo type_info =3D {
> > -            .parent =3D TYPE_SPAPR_CPU_CORE,
> > -            .instance_size =3D sizeof(sPAPRCPUCore),
> > -            .class_init =3D spapr_cpu_core_class_init,
> > -            .class_data =3D (void *) spapr_core_models[i],
> > -        };
> > -
> > -        type_info.name =3D g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE,
> > -                                         spapr_core_models[i]);
> > -        type_register(&type_info);
> > -        g_free((void *)type_info.name);
> > +        spapr_cpu_core_register_type(spapr_core_models[i]);
> >      }
> > +
> > +}
> > +
> > +void spapr_cpu_core_register_host_type(void)
> > +{
> > +    spapr_cpu_core_register_type("host");
> >  }
> > =20
> >  type_init(spapr_cpu_core_register_types)
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu=
_core.h
> > index 93051e9ecf56..e3e906343048 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -36,5 +36,5 @@ typedef struct sPAPRCPUCoreClass {
> >  } sPAPRCPUCoreClass;
> > =20
> >  char *spapr_get_cpu_core_type(const char *model);
> > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
> > +void spapr_cpu_core_register_host_type(void);
> >  #endif
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 5b281b2f1b6d..8dd80993ec9e 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -37,7 +37,6 @@
> >  #include "hw/sysbus.h"
> >  #include "hw/ppc/spapr.h"
> >  #include "hw/ppc/spapr_vio.h"
> > -#include "hw/ppc/spapr_cpu_core.h"
> >  #include "hw/ppc/ppc.h"
> >  #include "sysemu/watchdog.h"
> >  #include "trace.h"
> > @@ -2502,17 +2501,6 @@ static int kvm_ppc_register_host_cpu_type(void)
> >      oc =3D object_class_by_name(type_info.name);
> >      g_assert(oc);
> > =20
> > -#if defined(TARGET_PPC64)
> > -    type_info.name =3D g_strdup_printf("%s-"TYPE_SPAPR_CPU_CORE, "host=
");
> > -    type_info.parent =3D TYPE_SPAPR_CPU_CORE,
> > -    type_info.instance_size =3D sizeof(sPAPRCPUCore);
> > -    type_info.instance_init =3D NULL;
> > -    type_info.class_init =3D spapr_cpu_core_class_init;
> > -    type_info.class_data =3D (void *) "host";
> > -    type_register(&type_info);
> > -    g_free((void *)type_info.name);
> > -#endif
> > -
> >      /*
> >       * Update generic CPU family class alias (e.g. on a POWER8NVL host,
> >       * we want "POWER8" to be a "family" alias that points to the curr=
ent
> >  =20
>=20



--=20
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/LTC                      http://www.ibm.com
Tel 33-5-6218-1607

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.

--Sig_//V1e5kKcsliR4=WvSdai1gB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWcn/gQAKCRAC/DrrAQHb
wsiCAJsGMz1am9/hI5rOITEygRlBEzTL9ACfY1oevEx6eFMtC4opQw+B+wCM5os=
=IZbF
-----END PGP SIGNATURE-----

--Sig_//V1e5kKcsliR4=WvSdai1gB--
