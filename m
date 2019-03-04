Received: from eggs.gnu.org ([209.51.188.92]:40884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h0o2A-00083B-R9
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h0o29-0007yM-Gg
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:53:34 -0500
Date: Mon, 4 Mar 2019 14:52:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190304145230.4435c998@redhat.com>
In-Reply-To: <20190301180151.GE2851@work-vm>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301180151.GE2851@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 1/2] numa: deprecate 'mem'
 parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Fri, 1 Mar 2019 18:01:52 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Igor Mammedov (imammedo@redhat.com) wrote:
> > On Fri, 1 Mar 2019 15:49:47 +0000
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Fri, Mar 01, 2019 at 04:42:15PM +0100, Igor Mammedov wrote: =20
> > > > The parameter allows to configure fake NUMA topology where guest
> > > > VM simulates NUMA topology but not actually getting a performance
> > > > benefits from it. The same or better results could be achieved
> > > > using 'memdev' parameter. In light of that any VM that uses NUMA
> > > > to get its benefits should use 'memdev' and to allow transition
> > > > initial RAM to device based model, deprecate 'mem' parameter as
> > > > its ad-hoc partitioning of initial RAM MemoryRegion can't be
> > > > translated to memdev based backend transparently to users and in
> > > > compatible manner (migration wise).
> > > >=20
> > > > That will also allow to clean up a bit our numa code, leaving only
> > > > 'memdev' impl. in place and several boards that use node_mem
> > > > to generate FDT/ACPI description from it.   =20
> > >=20
> > > Can you confirm that the  'mem' and 'memdev' parameters to -numa
> > > are 100% live migration compatible in both directions ?  Libvirt
> > > would need this to be the case in order to use the 'memdev' syntax
> > > instead. =20
> > Unfortunately they are not migration compatible in any direction,
> > if it where possible to translate them to each other I'd alias 'mem'
> > to 'memdev' without deprecation. The former sends over only one
> > MemoryRegion to target, while the later sends over several (one per
> > memdev).
> >=20
> > Mixed memory issue[1] first came from libvirt side RHBZ1624223,
> > back then it was resolved on libvirt side in favor of migration
> > compatibility vs correctness (i.e. bind policy doesn't work as expected=
).
> > What worse that it was made default and affects all new machines,
> > as I understood it.
> >=20
> > In case of -mem-path + -mem-prealloc (with 1 numa node or numa less)
> > it's possible on QEMU side to make conversion to memdev in migration
> > compatible way (that's what stopped Michal from memdev approach).
> > But it's hard to do so in multi-nodes case as amount of MemoryRegions
> > is different.
> >=20
> > Point is to consider 'mem' as mis-configuration error, as the user
> > in the first place using broken numa configuration
> > (i.e. fake numa configuration doesn't actually improve performance).
> >=20
> > CCed David, maybe he could offer a way to do 1:n migration and other
> > way around. =20
>=20
> I can't see a trivial way.
> About the easiest I can think of is if you had a way to create a memdev
> that was an alias to pc.ram (of a particular size and offset).
If I get you right that's what I was planning to do for numa-less machines
that use -mem-path/prealloc options, where it's possible to replace
an initial RAM MemoryRegion with a correspondingly named memdev and its
backing MemoryRegion.

But I don't see how it could work in case of legacy NUMA 'mem' options
where initial RAM is 1 MemoryRegion (it's a fake numa after all) and how to
translate that into several MemoryRegions (one per node/memdev).

> Dave
>=20
> >  =20
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > >  numa.c               |  2 ++
> > > >  qemu-deprecated.texi | 14 ++++++++++++++
> > > >  2 files changed, 16 insertions(+)
> > > >=20
> > > > diff --git a/numa.c b/numa.c
> > > > index 3875e1e..2205773 100644
> > > > --- a/numa.c
> > > > +++ b/numa.c
> > > > @@ -121,6 +121,8 @@ static void parse_numa_node(MachineState *ms, N=
umaNodeOptions *node,
> > > > =20
> > > >      if (node->has_mem) {
> > > >          numa_info[nodenr].node_mem =3D node->mem;
> > > > +        warn_report("Parameter -numa node,mem is deprecated,"
> > > > +                    " use -numa node,memdev instead");
> > > >      }
> > > >      if (node->has_memdev) {
> > > >          Object *o;
> > > > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> > > > index 45c5795..73f99d4 100644
> > > > --- a/qemu-deprecated.texi
> > > > +++ b/qemu-deprecated.texi
> > > > @@ -60,6 +60,20 @@ Support for invalid topologies will be removed, =
the user must ensure
> > > >  topologies described with -smp include all possible cpus, i.e.
> > > >    @math{@var{sockets} * @var{cores} * @var{threads} =3D @var{maxcp=
us}}.
> > > > =20
> > > > +@subsection -numa node,mem=3D@var{size} (since 4.0)
> > > > +
> > > > +The parameter @option{mem} of @option{-numa node} is used to assig=
n a part of
> > > > +guest RAM to a NUMA node. But when using it, it's impossible to ma=
nage specified
> > > > +size on the host side (like bind it to a host node, setting bind p=
olicy, ...),
> > > > +so guest end-ups with the fake NUMA configuration with suboptiomal=
 performance.
> > > > +However since 2014 there is an alternative way to assign RAM to a =
NUMA node
> > > > +using parameter @option{memdev}, which does the same as @option{me=
m} and has
> > > > +an ability to actualy manage node RAM on the host side. Use parame=
ter
> > > > +@option{memdev} with @var{memory-backend-ram} backend as an replac=
ement for
> > > > +parameter @option{mem} to achieve the same fake NUMA effect or a p=
roperly
> > > > +configured @var{memory-backend-file} backend to actually benefit f=
rom NUMA
> > > > +configuration.
> > > > +
> > > >  @section QEMU Machine Protocol (QMP) commands
> > > > =20
> > > >  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.1=
2.0)
> > > > --=20
> > > > 2.7.4
> > > >=20
> > > > --
> > > > libvir-list mailing list
> > > > libvir-list@redhat.com
> > > > https://www.redhat.com/mailman/listinfo/libvir-list   =20
> > >=20
> > > Regards,
> > > Daniel =20
> >  =20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
