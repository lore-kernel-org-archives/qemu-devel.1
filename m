Received: from eggs.gnu.org ([209.51.188.92]:58595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h0pNb-0008LE-WE
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h0pNa-0008PP-M9
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:19:47 -0500
Date: Mon, 4 Mar 2019 16:19:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190304161932.0438c880@redhat.com>
In-Reply-To: <20190304142432.GM4239@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<87va0zcdse.fsf@dusky.pond.sub.org>
	<20190304132507.39273826@redhat.com>
	<20190304123908.GK4239@redhat.com>
	<20190304151641.3deefc3b@redhat.com>
	<20190304142432.GM4239@redhat.com>
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
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, mprivozn@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, david@gibson.dropbear.id.au

On Mon, 4 Mar 2019 14:24:32 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Mar 04, 2019 at 03:16:41PM +0100, Igor Mammedov wrote:
> > On Mon, 4 Mar 2019 12:39:08 +0000
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Mon, Mar 04, 2019 at 01:25:07PM +0100, Igor Mammedov wrote: =20
> > > > On Mon, 04 Mar 2019 08:13:53 +0100
> > > > Markus Armbruster <armbru@redhat.com> wrote:
> > > >    =20
> > > > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> > > > >    =20
> > > > > > On Fri, Mar 01, 2019 at 06:33:28PM +0100, Igor Mammedov wrote: =
    =20
> > > > > >> On Fri, 1 Mar 2019 15:49:47 +0000
> > > > > >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > > > > >>      =20
> > > > > >> > On Fri, Mar 01, 2019 at 04:42:15PM +0100, Igor Mammedov wrot=
e:     =20
> > > > > >> > > The parameter allows to configure fake NUMA topology where=
 guest
> > > > > >> > > VM simulates NUMA topology but not actually getting a perf=
ormance
> > > > > >> > > benefits from it. The same or better results could be achi=
eved
> > > > > >> > > using 'memdev' parameter. In light of that any VM that use=
s NUMA
> > > > > >> > > to get its benefits should use 'memdev' and to allow trans=
ition
> > > > > >> > > initial RAM to device based model, deprecate 'mem' paramet=
er as
> > > > > >> > > its ad-hoc partitioning of initial RAM MemoryRegion can't =
be
> > > > > >> > > translated to memdev based backend transparently to users =
and in
> > > > > >> > > compatible manner (migration wise).
> > > > > >> > >=20
> > > > > >> > > That will also allow to clean up a bit our numa code, leav=
ing only
> > > > > >> > > 'memdev' impl. in place and several boards that use node_m=
em
> > > > > >> > > to generate FDT/ACPI description from it.       =20
> > > > > >> >=20
> > > > > >> > Can you confirm that the  'mem' and 'memdev' parameters to -=
numa
> > > > > >> > are 100% live migration compatible in both directions ?  Lib=
virt
> > > > > >> > would need this to be the case in order to use the 'memdev' =
syntax
> > > > > >> > instead.     =20
> > > > > >> Unfortunately they are not migration compatible in any directi=
on,
> > > > > >> if it where possible to translate them to each other I'd alias=
 'mem'
> > > > > >> to 'memdev' without deprecation. The former sends over only one
> > > > > >> MemoryRegion to target, while the later sends over several (on=
e per
> > > > > >> memdev).     =20
> > > > > >
> > > > > > If we can't migration from one to the other, then we can not de=
precate
> > > > > > the existing 'mem' syntax. Even if libvirt were to provide a co=
nfig
> > > > > > option to let apps opt-in to the new syntax, we need to be able=
 to
> > > > > > support live migration of existing running VMs indefinitely. Ef=
fectively
> > > > > > this means we need the to keep 'mem' support forever, or at lea=
st such
> > > > > > a long time that it effectively means forever.
> > > > > >
> > > > > > So I think this patch has to be dropped & replaced with one that
> > > > > > simply documents that memdev syntax is preferred.     =20
> > > > >=20
> > > > > We have this habit of postulating absolutes like "can not depreca=
te"
> > > > > instead of engaging with the tradeoffs.  We need to kick it.
> > > > >=20
> > > > > So let's have an actual look at the tradeoffs.
> > > > >=20
> > > > > We don't actually "support live migration of existing running VMs
> > > > > indefinitely".
> > > > >=20
> > > > > We support live migration to any newer version of QEMU that still
> > > > > supports the machine type.
> > > > >=20
> > > > > We support live migration to any older version of QEMU that alrea=
dy
> > > > > supports the machine type and all the devices the machine uses.
> > > > >=20
> > > > > Aside: "support" is really an honest best effort here.  If you re=
ly on
> > > > > it, use a downstream that puts in the (substantial!) QA work real
> > > > > support takes.
> > > > >=20
> > > > > Feature deprecation is not a contract to drop the feature after t=
wo
> > > > > releases, or even five.  It's a formal notice that users of the f=
eature
> > > > > should transition to its replacement in an orderly manner.
> > > > >=20
> > > > > If I understand Igor correctly, all users should transition away =
from
> > > > > outdated NUMA configurations at least for new VMs in an orderly m=
anner.   =20
> > > > Yes, we can postpone removing options until there are machines type
> > > > versions that were capable to use it (unfortunate but probably=20
> > > > unavoidable unless there is a migration trick to make transition
> > > > transparent) but that should not stop us from disabling broken
> > > > options on new machine types at least.
> > > >=20
> > > > This series can serve as formal notice with follow up disabling of
> > > > deprecated options for new machine types. (As Thomas noted, just wa=
rnings
> > > > do not work and users continue to use broken features regardless wh=
ether
> > > > they are don't know about issues or aware of it [*])
> > > >=20
> > > > Hence suggested deprecation approach and enforced rejection of lega=
cy
> > > > numa options for new machine types in 2 releases so users would stop
> > > > using them eventually.   =20
> > >=20
> > > When we deprecate something, we need to have a way for apps to use the
> > > new alternative approach *at the same time*.  So even if we only want=
 to
> > > deprecate for new machine types, we still have to first solve the pro=
blem
> > > of how mgmt apps will introspect QEMU to learn which machine types ex=
pect
> > > the new options. =20
> > I'm not aware any mechanism to introspect machine type options (existing
> > or something being developed). Are/were there any ideas about it that w=
ere
> > discussed in the past?
> >=20
> > Aside from developing a new mechanism what are alternative approaches?
> > I mean when we delete deprecated CLI option, how it's solved on libvirt
> > side currently?
> >=20
> > For example I don't see anything introspection related when we have been
> > removing deprecated options recently. =20
>=20
> Right, with other stuff we deprecate we've had a simpler time, as it
> either didn't affect migration at all, or the new replacement stuff
> was fully compatible with the migration data stream. IOW, libvirt
> could unconditionally use the new feature as soon as it saw that it
> exists in QEMU. We didn't have any machine type dependancy to deal
> with before now.
Any suggestions what direction we should proceed?
(I'm really not keen to develop a new introspection feature but if that
the only way to move forward ...)

> > More exact question specific to this series usecase,
> > how libvirt decides when to use -numa node,memdev or not currently? =20
>=20
> It is pretty hard to follow the code, but IIUC we only use memdev when
> stting up NVDIMMs, or for guests configured to have the "shared" flag
> on the memory region.
Then I'd guess that most VMs end up with default '-numa node,mem'=20
which by design can produce only fake NUMA without ability to manage
guest RAM on host side. So such VMs aren't getting performance benefits
or worse run with performance regression (due to wrong sched/mm decisions
as guest kernel assumes NUMA topology is valid one).
=20
> Regards,
> Daniel
