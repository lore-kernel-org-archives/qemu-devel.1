Received: from eggs.gnu.org ([2001:4830:134:3::10]:37920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dxEKa-0005N6-4u
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:33:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dxEKW-0006xj-0b
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:33:00 -0400
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dxEKV-0006oL-Pj
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 11:32:55 -0400
Received: from player774.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id E07C010C04D
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 17:32:46 +0200 (CEST)
Date: Wed, 27 Sep 2017 17:32:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170927173232.3a305c99@bahia.lan>
In-Reply-To: <20170927141956.1bd6a3bd@nial.brq.redhat.com>
References: <150633285374.14880.11614678065344980502.stgit@bahia.lan>
	<20170925154134.7b4b8cde@nial.brq.redhat.com>
	<20170925174857.6021d0a0@bahia.lan>
	<20170925234730.29b7b919@bahia.lan>
	<20170927141956.1bd6a3bd@nial.brq.redhat.com>
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

On Wed, 27 Sep 2017 14:19:56 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 25 Sep 2017 23:47:30 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Mon, 25 Sep 2017 17:48:57 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >  =20
> > > On Mon, 25 Sep 2017 15:41:34 +0200
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >    =20
> > > > On Mon, 25 Sep 2017 11:47:33 +0200
> > > > Greg Kurz <groug@kaod.org> wrote:
> > > >      =20
> > > > > The CPU core abstraction belongs to the machine code. This also g=
ets
> > > > > rid of some code duplication.
> > > > >=20
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > ---
> > > > >=20
> > > > > hw/ppc/spapr_cpu_core.h is also included elsewhere in target/ppc/=
kvm.c
> > > > > but this is already handled by the following cleanup patch:
> > > > >=20
> > > > > https://patchwork.ozlabs.org/patch/817598/
> > > > > ---
> > > > >  hw/ppc/spapr.c                  |    4 ++++
> > > > >  hw/ppc/spapr_cpu_core.c         |   34 ++++++++++++++++++++++---=
---------
> > > > >  include/hw/ppc/spapr_cpu_core.h |    2 +-
> > > > >  target/ppc/kvm.c                |   12 ------------
> > > > >  4 files changed, 27 insertions(+), 25 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > > index 0ce3ec87ac59..e82c8532ffb0 100644
> > > > > --- a/hw/ppc/spapr.c
> > > > > +++ b/hw/ppc/spapr.c
> > > > > @@ -2349,6 +2349,10 @@ static void ppc_spapr_init(MachineState *m=
achine)
> > > > >      }
> > > > > =20
> > > > >      /* init CPUs */
> > > > > +    if (kvm_enabled()) {
> > > > > +        spapr_cpu_core_register_host_type();
> > > > > +    }       =20
> > > > why don't we create it statically in hw/ppc/spapr_cpu_core.c
> > > > like it's done in x86, i.e.
> > > >=20
> > > >   static void x86_cpu_register_types(void)                         =
               =20
> > > >   {                                                                =
               =20
> > > >   ...                             =20
> > > >   #ifdef CONFIG_KVM                                                =
               =20
> > > >       type_register_static(&host_x86_cpu_type_info);               =
               =20
> > > >   #endif                                                           =
               =20
> > > >   }=20
> > > >   type_init(x86_cpu_register_types)
> > > >=20
> > > > and do the same for host CPU as well?
> > > >      =20
> > >=20
> > > Hi Igor,
> > >=20
> > > Not sure yet why we use dynamic types, but I'd be glad to dig a bit m=
ore.   =20
> >=20
> > So the problem is that it was decided to make the host CPU class a
> > subclass of the host's CPU model, and this requires all the CPU model
> > classes to be registered beforehand.
> >=20
> > commit 5ba4576b858c0d6056f59abb7e17a2b63f7905f3
> > Author: Andreas F=C3=A4rber <afaerber@suse.de>
> > Date:   Sat Feb 23 11:22:12 2013 +0000
> >=20
> >     target-ppc: Make host CPU a subclass of the host's CPU model
> >    =20
> >     This avoids assigning individual class fields and contributors
> >     forgetting to add field assignments in KVM-only code.
> >    =20
> >     ppc_cpu_class_find_by_pvr() requires the CPU model classes to be
> >     registered, so defer host CPU type registration to kvm_arch_init().
> >    =20
> >     Only register the host CPU type if there is a class with matching P=
VR.
> >     This lets us drop error handling from instance_init.
> >    =20
> >     Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> >     Signed-off-by: Alexander Graf <agraf@suse.de>
> >=20
> > I can't think of an alternate way to do this. Any suggestion ? =20
> I don't see from this commit a reason why it can't be done in cpu-models.c
> dependencies here are
>   mfpvr() - which probably should work without KVM

Correct.

>   ppc_cpu_class_by_pvr() - should work fine if 'host' type is being
>                            registered as the last among the other CPU typ=
es

We have:

ppc_cpu_class_by_pvr()
 object_class_get_list()
  object_class_foreach()
   object_class_foreach_tramp()
    type_initialize()
     type_get_parent()

type_initialize() recursively initializes all parent types, and
type_get_parent() aborts if the parent type isn't registered yet,
which may happen as long as all type_init() functions haven't been
called =3D> ppc_cpu_class_by_pvr() cannot be safely called from a
type_init() function.

--
Greg
