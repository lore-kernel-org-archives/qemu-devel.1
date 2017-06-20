Received: from eggs.gnu.org ([2001:4830:134:3::10]:42761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNJzx-0003Zw-An
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dNJzt-0002OZ-3x
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:19:17 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:54861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dNJzs-0002O9-Sd
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:19:13 -0400
Received: from player789.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id EB1815ED5E
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 16:19:09 +0200 (CEST)
Date: Tue, 20 Jun 2017 16:19:01 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170620161901.50113a5d@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <3f9a94c6-6391-d45e-fbd9-32a8e1e8504f@redhat.com>
References: <149789192064.8356.6383758991647148922.stgit@bahia.lan>
	<3f9a94c6-6391-d45e-fbd9-32a8e1e8504f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/cUDDiRniJUGlFC9sDPJaeUq";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr/ppc: fix backward
 migration to QEMU 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/cUDDiRniJUGlFC9sDPJaeUq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2017 15:08:47 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 19/06/2017 19:05, Greg Kurz wrote:
> > Commit c783b0012708 ("ppc: Rework CPU compatibility testing across
> > migration") added a subsection to the vmstate description of CPUs.
> > This subsection is sent when the CPU compat_pvr field is non-zero,
> > which is likely to happen after CAS negociation (since QEMU 2.9) or
> > even before CAS negociation if the user explicitely asked for compat
> > mode.
> >=20
> > This breaks backward migration of existing pseries-2.9 machine types
> > since they don't know about this "compat" subsection:
> >=20
> > qemu-system-ppc64: error while loading state for instance 0x0 of
> >  device 'cpu'
> >=20
> > This patch reverts to the behavior of simply ignoring the PVR when
> > migrating older machines (ie, let the migration succeed if the user
> > is sure that the CPU on the destination is close enough to work).
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>=20
> but I think it should be merged with patch ("ppc: Rework CPU
> compatibility testing across migration") that is not merged and in the
> maintainer tree.
>=20

I agree this would be better for bisect.

Cheers,

--
Greg

> thanks,
> Laurent
>=20
> > ---
> >  hw/ppc/spapr.c              |    7 ++++++-
> >  target/ppc/cpu.h            |    1 +
> >  target/ppc/machine.c        |    2 +-
> >  target/ppc/translate_init.c |    2 ++
> >  4 files changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d4d781876b27..265d49bbcd7f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3474,7 +3474,12 @@ DEFINE_SPAPR_MACHINE(2_10, "2.10", true);
> >   * pseries-2.9
> >   */
> >  #define SPAPR_COMPAT_2_9                                              =
 \
> > -    HW_COMPAT_2_9
> > +    HW_COMPAT_2_9                                                     =
 \
> > +    {                                                                 =
 \
> > +        .driver =3D TYPE_POWERPC_CPU,                                 =
   \
> > +        .property =3D "pre-2.10-migration",                           =
   \
> > +        .value    =3D "on",                                           =
   \
> > +    },                                                                =
 \
> > =20
> >  static void spapr_machine_2_9_instance_options(MachineState *machine)
> >  {
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 09393e601fd9..6ee2a26a963d 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1211,6 +1211,7 @@ struct PowerPCCPU {
> >      uint64_t mig_insns_flags;
> >      uint64_t mig_insns_flags2;
> >      uint32_t mig_nb_BATs;
> > +    bool pre_2_10_migration;
> >  };
> > =20
> >  static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCState *env)
> > diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> > index a29aabe8f079..1b7aede579ea 100644
> > --- a/target/ppc/machine.c
> > +++ b/target/ppc/machine.c
> > @@ -608,7 +608,7 @@ static bool compat_needed(void *opaque)
> >      PowerPCCPU *cpu =3D opaque;
> > =20
> >      assert(!(cpu->compat_pvr && !cpu->vhyp));
> > -    return (cpu->compat_pvr !=3D 0);
> > +    return !cpu->pre_2_10_migration && cpu->compat_pvr !=3D 0;
> >  }
> > =20
> >  static const VMStateDescription vmstate_compat =3D {
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index 53aff5a7b734..783bf98217cc 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -10610,6 +10610,8 @@ static gchar *ppc_gdb_arch_name(CPUState *cs)
> > =20
> >  static Property ppc_cpu_properties[] =3D {
> >      DEFINE_PROP_BOOL("pre-2.8-migration", PowerPCCPU, pre_2_8_migratio=
n, false),
> > +    DEFINE_PROP_BOOL("pre-2.10-migration", PowerPCCPU, pre_2_10_migrat=
ion,
> > +                     false),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> > =20
> >=20
> >  =20
>=20


--Sig_/cUDDiRniJUGlFC9sDPJaeUq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllJLtYACgkQAvw66wEB28KlZACfaQSEq4tp00hs841ch8RMmsBB
JAsAn0ZOC/vblEYOFdPyQz56nnDoJ88e
=xL5s
-----END PGP SIGNATURE-----

--Sig_/cUDDiRniJUGlFC9sDPJaeUq--
