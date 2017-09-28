Received: from eggs.gnu.org ([2001:4830:134:3::10]:42027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxRc0-0007kT-1j
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 01:43:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dxRby-0000Xa-9L
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 01:43:52 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45857)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dxRbx-0000Wq-C7
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 01:43:50 -0400
Date: Thu, 28 Sep 2017 14:22:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170928042256.GE12504@umbus>
References: <20170927062143.GN12504@umbus>
	<1506512957-196068-1-git-send-email-imammedo@redhat.com>
	<20170927181834.76c5d2ef@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+GiWpZ/vZzfY9+ZQ"
Content-Disposition: inline
In-Reply-To: <20170927181834.76c5d2ef@bahia.lan>
Subject: Re: [Qemu-devel] [RFC] ppc: define spapr core types statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org


--+GiWpZ/vZzfY9+ZQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2017 at 06:18:34PM +0200, Greg Kurz wrote:
> On Wed, 27 Sep 2017 13:49:17 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
>=20
> This looks nice indeed (just one remark, see below).
>=20
> Will you re-post as a patch series or do you prefer I do it ?

Looks good to me as well.

>=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/ppc/spapr_cpu_core.h |  5 ++-
> >  hw/ppc/spapr.c                  |  6 +--
> >  hw/ppc/spapr_cpu_core.c         | 93 ++++++++++++++++-----------------=
--------
> >  target/ppc/kvm.c                | 11 -----
> >  4 files changed, 41 insertions(+), 74 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu=
_core.h
> > index 93051e9..42765de 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -21,6 +21,8 @@
> >  #define SPAPR_CPU_CORE_GET_CLASS(obj) \
> >       OBJECT_GET_CLASS(sPAPRCPUCoreClass, (obj), TYPE_SPAPR_CPU_CORE)
> > =20
> > +#define SPAPR_CPU_CORE_TYPE_NAME(model) model "-" TYPE_SPAPR_CPU_CORE
> > +
> >  typedef struct sPAPRCPUCore {
> >      /*< private >*/
> >      CPUCore parent_obj;
> > @@ -32,9 +34,8 @@ typedef struct sPAPRCPUCore {
> > =20
> >  typedef struct sPAPRCPUCoreClass {
> >      DeviceClass parent_class;
> > -    ObjectClass *cpu_class;
> > +    const char *cpu_type;
> >  } sPAPRCPUCoreClass;
> > =20
> >  char *spapr_get_cpu_core_type(const char *model);
> > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
> >  #endif
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 8c1a437..00cfe9a 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3125,8 +3125,7 @@ void spapr_core_release(DeviceState *dev)
> >      if (smc->pre_2_10_has_unused_icps) {
> >          sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> >          sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc)=
);
> > -        const char *typename =3D object_class_get_name(scc->cpu_class);
> > -        size_t size =3D object_type_get_instance_size(typename);
> > +        size_t size =3D object_type_get_instance_size(scc->cpu_type);
> >          int i;
> > =20
> >          for (i =3D 0; i < cc->nr_threads; i++) {
> > @@ -3222,8 +3221,7 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
> > =20
> >      if (smc->pre_2_10_has_unused_icps) {
> >          sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(cc)=
);
> > -        const char *typename =3D object_class_get_name(scc->cpu_class);
> > -        size_t size =3D object_type_get_instance_size(typename);
> > +        size_t size =3D object_type_get_instance_size(scc->cpu_type);
> >          int i;
> > =20
> >          for (i =3D 0; i < cc->nr_threads; i++) {
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 5bea4c9..8a18eaf 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -104,8 +104,7 @@ static void spapr_cpu_core_unrealizefn(DeviceState =
*dev, Error **errp)
> >  {
> >      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> > -    const char *typename =3D object_class_get_name(scc->cpu_class);
> > -    size_t size =3D object_type_get_instance_size(typename);
> > +    size_t size =3D object_type_get_instance_size(scc->cpu_type);
> >      CPUCore *cc =3D CPU_CORE(dev);
> >      int i;
> > =20
> > @@ -166,8 +165,7 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> >      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> >      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> > -    const char *typename =3D object_class_get_name(scc->cpu_class);
> > -    size_t size =3D object_type_get_instance_size(typename);
> > +    size_t size =3D object_type_get_instance_size(scc->cpu_type);
> >      Error *local_err =3D NULL;
> >      void *obj;
> >      int i, j;
> > @@ -186,7 +184,7 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> > =20
> >          obj =3D sc->threads + i * size;
> > =20
> > -        object_initialize(obj, size, typename);
> > +        object_initialize(obj, size, scc->cpu_type);
> >          cs =3D CPU(obj);
> >          cpu =3D POWERPC_CPU(cs);
> >          cs->cpu_index =3D cc->core_id + i;
> > @@ -231,42 +229,12 @@ err:
> >      error_propagate(errp, local_err);
> >  }
> > =20
> > -static const char *spapr_core_models[] =3D {
> > -    /* 970 */
> > -    "970_v2.2",
> > -
> > -    /* 970MP variants */
> > -    "970mp_v1.0",
> > -    "970mp_v1.1",
> > -
> > -    /* POWER5+ */
> > -    "power5+_v2.1",
> > -
> > -    /* POWER7 */
> > -    "power7_v2.3",
> > -
> > -    /* POWER7+ */
> > -    "power7+_v2.1",
> > -
> > -    /* POWER8 */
> > -    "power8_v2.0",
> > -
> > -    /* POWER8E */
> > -    "power8e_v2.1",
> > -
> > -    /* POWER8NVL */
> > -    "power8nvl_v1.0",
> > -
> > -    /* POWER9 */
> > -    "power9_v1.0",
> > -};
> > -
> >  static Property spapr_cpu_core_properties[] =3D {
> >      DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA=
_NODE_ID),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> > =20
> > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(oc);
> >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_CLASS(oc);
> > @@ -274,36 +242,47 @@ void spapr_cpu_core_class_init(ObjectClass *oc, v=
oid *data)
> >      dc->realize =3D spapr_cpu_core_realize;
> >      dc->unrealize =3D spapr_cpu_core_unrealizefn;
> >      dc->props =3D spapr_cpu_core_properties;
> > -    scc->cpu_class =3D cpu_class_by_name(TYPE_POWERPC_CPU, data);
> > -    g_assert(scc->cpu_class);
> > +    scc->cpu_type =3D data;
>=20
> Maybe assert data isn't NULL ?
>=20
> >  }
> > =20
> > -static const TypeInfo spapr_cpu_core_type_info =3D {
> > -    .name =3D TYPE_SPAPR_CPU_CORE,
> > -    .parent =3D TYPE_CPU_CORE,
> > -    .abstract =3D true,
> > -    .instance_size =3D sizeof(sPAPRCPUCore),
> > -    .class_size =3D sizeof(sPAPRCPUCoreClass),
> > +#define DEFINE_SPAPR_CPU_CORE_TYPE(cpu_model) \
> > +    {                                                   \
> > +        .parent =3D TYPE_SPAPR_CPU_CORE,                  \
> > +        .class_data =3D (void *) POWERPC_CPU_TYPE_NAME(cpu_model), \
> > +        .class_init =3D spapr_cpu_core_class_init,        \
> > +        .name =3D SPAPR_CPU_CORE_TYPE_NAME(cpu_model),    \
> > +    }
> > +
> > +static const TypeInfo spapr_cpu_core_type_infos[] =3D {
> > +    {
> > +        .name =3D TYPE_SPAPR_CPU_CORE,
> > +        .parent =3D TYPE_CPU_CORE,
> > +        .abstract =3D true,
> > +        .instance_size =3D sizeof(sPAPRCPUCore),
> > +        .class_size =3D sizeof(sPAPRCPUCoreClass),
> > +    },
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
> > +#ifdef CONFIG_KVM
> > +    DEFINE_SPAPR_CPU_CORE_TYPE("host"),
> > +#endif
> >  };
> > =20
> >  static void spapr_cpu_core_register_types(void)
> >  {
> >      int i;
> > =20
> > -    type_register_static(&spapr_cpu_core_type_info);
> > -
> > -    for (i =3D 0; i < ARRAY_SIZE(spapr_core_models); i++) {
> > -        TypeInfo type_info =3D {
> > -            .parent =3D TYPE_SPAPR_CPU_CORE,
> > -            .instance_size =3D sizeof(sPAPRCPUCore),
> > -            .class_init =3D spapr_cpu_core_class_init,
> > -            .class_data =3D (void *) spapr_core_models[i],
> > -        };
> > =20
> > -        type_info.name =3D g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE,
> > -                                         spapr_core_models[i]);
> > -        type_register(&type_info);
> > -        g_free((void *)type_info.name);
> > +    for (i =3D 0; i < ARRAY_SIZE(spapr_cpu_core_type_infos); i++) {
> > +        type_register_static(&spapr_cpu_core_type_infos[i]);
> >      }
> >  }
> > =20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 1deaf10..7e5c041 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2507,17 +2507,6 @@ static int kvm_ppc_register_host_cpu_type(void)
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
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+GiWpZ/vZzfY9+ZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnMeSAACgkQbDjKyiDZ
s5JQkRAAofR6F5o6bx8O1Mcd3tBOkoSXZ6nJqa+92t0YPLzfoFOL34ItRmnwgXKr
QmO6MEha3F6I0KAThSwJfKCkfe96E2CXx9NVXKIBEbKozsOX0DL07DfHn1GTGIG5
VMrrrBzz/FDkK13NZYgWTn6chqDG3H3YLTbOOrI5XLkS9k2Omb5qFZt1Sf7s3E6C
Gms4CsqLWfGy2ZXl2Kg6wNxnNdBJcQ2mLkj1j1FN+AXQvh9KRcnmYOoFOrpFYyO7
YwwcTvV8HpYtxQ/wPwNURtonbhNkgsc/a61+4BUPdvy7mUfZUU8cbC4TqijlRpZ3
yaqDVOIsZUY1u7K0URchKRQvXyDvuIIEXzug4OL9NQ3LHOKqQ91rurID9xZrpHl6
tr8a/gyNSlKk/JizToIqQVhtq2BNiMzqRyXveowtJ0S/wt3X1pWahU5sPS1rUWks
eV1xgenuhVRQCQWVoSmBtox9if1KYzEJE8Zm9+25jwPEnU2DOkKvNoxTTuxjm5wv
NNv8I1ccjkYVnae7CAeTWbJg8Psl0KQVFLmezwEsFPDFp8xhobNDaoCwXWHyfEgv
tlegNVbE+X5s0QJMu1EwJnqT6JVA5IqA/oEQiYJIpcz3WGkhAqUhPSc+PT7SHh8X
gBfW/alxbxunxKyJBD2XXGu3LFI/tCb/X2os0/3OKTmN3BqUozE=
=AIjt
-----END PGP SIGNATURE-----

--+GiWpZ/vZzfY9+ZQ--
