Received: from eggs.gnu.org ([2001:4830:134:3::10]:46625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Oi2-0006KH-KA
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Oi1-0000LI-DM
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:14:18 -0400
Date: Fri, 6 Oct 2017 20:13:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006091351.GH10961@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-16-git-send-email-imammedo@redhat.com>
	<20171006044104.GT3260@umbus.fritz.box>
	<20171006110714.4f9d21ab@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="17/8oYur5Y32USnW"
Content-Disposition: inline
In-Reply-To: <20171006110714.4f9d21ab@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/23] ppc: spapr: register 'host' core
 type along with the rest of core types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "open list:ppce500" <qemu-ppc@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--17/8oYur5Y32USnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 11:07:14AM +0200, Igor Mammedov wrote:
> On Fri, 6 Oct 2017 15:41:04 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Oct 05, 2017 at 06:24:42PM +0200, Igor Mammedov wrote:
> > > consolidate 'host' core type registration by moving it from
> > > KVM specific code into spapr_cpu_core.c, similar like it's
> > > done in x86 target.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
> >=20
> > IIUC this will change behaviour slightly: with this patch the 'host'
> > core type will show up whenever CONFIG_KVM is set, even if the KVM
> > accelerator is disabled on the command line.  Previously it would not.
> >=20
> > Is this change intentional?
> yep, we do the same on x86

Ok.  In that case.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> >=20
> > > ---
> > >  include/hw/ppc/spapr_cpu_core.h |  1 -
> > >  hw/ppc/spapr_cpu_core.c         |  5 ++++-
> > >  target/ppc/kvm.c                | 11 -----------
> > >  3 files changed, 4 insertions(+), 13 deletions(-)
> > >=20
> > > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_c=
pu_core.h
> > > index 264ce68..42765de 100644
> > > --- a/include/hw/ppc/spapr_cpu_core.h
> > > +++ b/include/hw/ppc/spapr_cpu_core.h
> > > @@ -38,5 +38,4 @@ typedef struct sPAPRCPUCoreClass {
> > >  } sPAPRCPUCoreClass;
> > > =20
> > >  char *spapr_get_cpu_core_type(const char *model);
> > > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data);
> > >  #endif
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index 8e13e52..f2da4be 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -220,7 +220,7 @@ static Property spapr_cpu_core_properties[] =3D {
> > >      DEFINE_PROP_END_OF_LIST()
> > >  };
> > > =20
> > > -void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > > +static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > >  {
> > >      DeviceClass *dc =3D DEVICE_CLASS(oc);
> > >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_CLASS(oc);
> > > @@ -257,6 +257,9 @@ static const TypeInfo spapr_cpu_core_type_infos[]=
 =3D {
> > >      DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
> > >      DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
> > >      DEFINE_SPAPR_CPU_CORE_TYPE("power9_v1.0"),
> > > +#ifdef CONFIG_KVM
> > > +    DEFINE_SPAPR_CPU_CORE_TYPE("host"),
> > > +#endif
> > >  };
> > > =20
> > >  DEFINE_TYPES(spapr_cpu_core_type_infos)
> > > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > > index c2152ed..cb5777a 100644
> > > --- a/target/ppc/kvm.c
> > > +++ b/target/ppc/kvm.c
> > > @@ -2508,17 +2508,6 @@ static int kvm_ppc_register_host_cpu_type(void)
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
> > > -    type_info.class_data =3D (void *) POWERPC_CPU_TYPE_NAME("host");
> > > -    type_register(&type_info);
> > > -    g_free((void *)type_info.name);
> > > -#endif
> > > -
> > >      /*
> > >       * Update generic CPU family class alias (e.g. on a POWER8NVL ho=
st,
> > >       * we want "POWER8" to be a "family" alias that points to the cu=
rrent =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--17/8oYur5Y32USnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXSU8ACgkQbDjKyiDZ
s5KAbg/+N7fpFzGoe6mPdxlXW6YrpVSQvm8Y9VIPnBv7JogL/CHXoTa+fDlJeKL0
DVwOVDV6KhiiVZwzoZsptu9VQk9cIX6AX24/CpBNeRajklsnyPOeU+nlzpGAh6zf
sqKxSVcE1yPs4A9ItLkeKKKPauyTmwA4N0ulfNklx3IZTMq/O0f27ymrXpVtst5b
NMP0wI5mGa9UcadPSkHKPP+IKYdgZJc9lmELVR89ldqqq/zRUF2p2oMn6k8THPWb
Ll7D7Q6r0Pu8EfglKGLPGc+2US2zwfbOfzJV+kOQkOL2Q+NsK2QeH3Ddilvg3FK2
yZ88e+Iccn2iZSxMp9yYpvY49rGz5lMml62q3ESisoE0UXIWHWwc+Mb/Q64WiHri
yzIuavalik9Op7QsqFIImGrHenqik9ANaG1pfNGS0dBx8ce0Ej8WekJLsTMNkgUf
XfyVDkbCvyDt8zsxQ+6jXEJcdHsIc9GDg9O7aV0EFd9KRzunMKYq5YqG1KrUeckE
gwDGCxvQScUe1ohvDOlf5wYiQ86WcT1CZl1171fuqsoAUZ0wFa/eNNfwK+Xbw5Ut
djLvEWa42QE/FMvwRq4bRIiUEYHRJ94XiZaGuwy2yfbQBhV3z0+dyqqsnhaz9auc
OUP/2QOJdLwlx4IodisgRWVLNfmKYZUXwT6er+MTcYkyeJBp5jk=
=J5zw
-----END PGP SIGNATURE-----

--17/8oYur5Y32USnW--
