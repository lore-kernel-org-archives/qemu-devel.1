Received: from eggs.gnu.org ([209.51.188.92]:56291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0msS-0007iJ-Ud
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0msO-0000ul-2B
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:39:26 -0500
Date: Mon, 4 Mar 2019 12:39:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190304123908.GK4239@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<87va0zcdse.fsf@dusky.pond.sub.org>
	<20190304132507.39273826@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190304132507.39273826@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au, mprivozn@redhat.com

On Mon, Mar 04, 2019 at 01:25:07PM +0100, Igor Mammedov wrote:
> On Mon, 04 Mar 2019 08:13:53 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>=20
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >=20
> > > On Fri, Mar 01, 2019 at 06:33:28PM +0100, Igor Mammedov wrote: =20
> > >> On Fri, 1 Mar 2019 15:49:47 +0000
> > >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > >>  =20
> > >> > On Fri, Mar 01, 2019 at 04:42:15PM +0100, Igor Mammedov wrote: =20
> > >> > > The parameter allows to configure fake NUMA topology where gue=
st
> > >> > > VM simulates NUMA topology but not actually getting a performa=
nce
> > >> > > benefits from it. The same or better results could be achieved
> > >> > > using 'memdev' parameter. In light of that any VM that uses NU=
MA
> > >> > > to get its benefits should use 'memdev' and to allow transitio=
n
> > >> > > initial RAM to device based model, deprecate 'mem' parameter a=
s
> > >> > > its ad-hoc partitioning of initial RAM MemoryRegion can't be
> > >> > > translated to memdev based backend transparently to users and =
in
> > >> > > compatible manner (migration wise).
> > >> > >=20
> > >> > > That will also allow to clean up a bit our numa code, leaving =
only
> > >> > > 'memdev' impl. in place and several boards that use node_mem
> > >> > > to generate FDT/ACPI description from it.   =20
> > >> >=20
> > >> > Can you confirm that the  'mem' and 'memdev' parameters to -numa
> > >> > are 100% live migration compatible in both directions ?  Libvirt
> > >> > would need this to be the case in order to use the 'memdev' synt=
ax
> > >> > instead. =20
> > >> Unfortunately they are not migration compatible in any direction,
> > >> if it where possible to translate them to each other I'd alias 'me=
m'
> > >> to 'memdev' without deprecation. The former sends over only one
> > >> MemoryRegion to target, while the later sends over several (one pe=
r
> > >> memdev). =20
> > >
> > > If we can't migration from one to the other, then we can not deprec=
ate
> > > the existing 'mem' syntax. Even if libvirt were to provide a config
> > > option to let apps opt-in to the new syntax, we need to be able to
> > > support live migration of existing running VMs indefinitely. Effect=
ively
> > > this means we need the to keep 'mem' support forever, or at least s=
uch
> > > a long time that it effectively means forever.
> > >
> > > So I think this patch has to be dropped & replaced with one that
> > > simply documents that memdev syntax is preferred. =20
> >=20
> > We have this habit of postulating absolutes like "can not deprecate"
> > instead of engaging with the tradeoffs.  We need to kick it.
> >=20
> > So let's have an actual look at the tradeoffs.
> >=20
> > We don't actually "support live migration of existing running VMs
> > indefinitely".
> >=20
> > We support live migration to any newer version of QEMU that still
> > supports the machine type.
> >=20
> > We support live migration to any older version of QEMU that already
> > supports the machine type and all the devices the machine uses.
> >=20
> > Aside: "support" is really an honest best effort here.  If you rely o=
n
> > it, use a downstream that puts in the (substantial!) QA work real
> > support takes.
> >=20
> > Feature deprecation is not a contract to drop the feature after two
> > releases, or even five.  It's a formal notice that users of the featu=
re
> > should transition to its replacement in an orderly manner.
> >=20
> > If I understand Igor correctly, all users should transition away from
> > outdated NUMA configurations at least for new VMs in an orderly manne=
r.
> Yes, we can postpone removing options until there are machines type
> versions that were capable to use it (unfortunate but probably=20
> unavoidable unless there is a migration trick to make transition
> transparent) but that should not stop us from disabling broken
> options on new machine types at least.
>=20
> This series can serve as formal notice with follow up disabling of
> deprecated options for new machine types. (As Thomas noted, just warnin=
gs
> do not work and users continue to use broken features regardless whethe=
r
> they are don't know about issues or aware of it [*])
>=20
> Hence suggested deprecation approach and enforced rejection of legacy
> numa options for new machine types in 2 releases so users would stop
> using them eventually.

When we deprecate something, we need to have a way for apps to use the
new alternative approach *at the same time*.  So even if we only want to
deprecate for new machine types, we still have to first solve the problem
of how mgmt apps will introspect QEMU to learn which machine types expect
the new options.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
