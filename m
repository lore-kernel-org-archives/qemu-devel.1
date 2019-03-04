Received: from eggs.gnu.org ([209.51.188.92]:54720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h0p7l-0007me-Cz
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:03:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h0p7k-0005XN-5l
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:03:25 -0500
Date: Mon, 4 Mar 2019 16:03:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190304160313.5a639a9e@redhat.com>
In-Reply-To: <96d58188-65f8-6a39-4ce2-9fe88b89f228@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<87va0zcdse.fsf@dusky.pond.sub.org>
	<20190304101911.GE4239@redhat.com>
	<96d58188-65f8-6a39-4ce2-9fe88b89f228@redhat.com>
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
To: Michal Privoznik <mprivozn@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, 4 Mar 2019 15:24:28 +0100
Michal Privoznik <mprivozn@redhat.com> wrote:

> [Thanks Igor for bringing this onto my radar. I don't follow qemu-devel=20
> that close]
>=20
> On 3/4/19 11:19 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Mar 04, 2019 at 08:13:53AM +0100, Markus Armbruster wrote: =20
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >> =20
> >>> On Fri, Mar 01, 2019 at 06:33:28PM +0100, Igor Mammedov wrote: =20
> >>>> On Fri, 1 Mar 2019 15:49:47 +0000
> >>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >>>> =20
> >>>>> On Fri, Mar 01, 2019 at 04:42:15PM +0100, Igor Mammedov wrote: =20
> >>>>>> The parameter allows to configure fake NUMA topology where guest
> >>>>>> VM simulates NUMA topology but not actually getting a performance
> >>>>>> benefits from it. The same or better results could be achieved
> >>>>>> using 'memdev' parameter. In light of that any VM that uses NUMA
> >>>>>> to get its benefits should use 'memdev' and to allow transition
> >>>>>> initial RAM to device based model, deprecate 'mem' parameter as
> >>>>>> its ad-hoc partitioning of initial RAM MemoryRegion can't be
> >>>>>> translated to memdev based backend transparently to users and in
> >>>>>> compatible manner (migration wise).
> >>>>>>
> >>>>>> That will also allow to clean up a bit our numa code, leaving only
> >>>>>> 'memdev' impl. in place and several boards that use node_mem
> >>>>>> to generate FDT/ACPI description from it. =20
> >>>>>
> >>>>> Can you confirm that the  'mem' and 'memdev' parameters to -numa
> >>>>> are 100% live migration compatible in both directions ?  Libvirt
> >>>>> would need this to be the case in order to use the 'memdev' syntax
> >>>>> instead. =20
> >>>> Unfortunately they are not migration compatible in any direction,
> >>>> if it where possible to translate them to each other I'd alias 'mem'
> >>>> to 'memdev' without deprecation. The former sends over only one
> >>>> MemoryRegion to target, while the later sends over several (one per
> >>>> memdev). =20
> >>>
> >>> If we can't migration from one to the other, then we can not deprecate
> >>> the existing 'mem' syntax. Even if libvirt were to provide a config
> >>> option to let apps opt-in to the new syntax, we need to be able to
> >>> support live migration of existing running VMs indefinitely. Effectiv=
ely
> >>> this means we need the to keep 'mem' support forever, or at least such
> >>> a long time that it effectively means forever. =20
>=20
> I'm with Daniel on this. The reason why libvirt still defaults to '-numa=
=20
> node,mem=3D' is exactly because of backward compatibility. Since a machin=
e=20
> can't be migrated from '-numa node,mem=3D' to '-numa node,memdev=3D +=20
> -object memory-backend-*' libvirt hast to play it safe and chose a=20
> combination that is acessible the widest.
>=20
> If you remove this, how would you expect older machines to migrate to=20
> newer cmd line?
>=20
> I'm all for deprecating old stuff. In fact, I've suggested that in=20
> libvirt(!) here and there, but I'm afraid we can't just remove=20
> functionatlity unless we give users a way to migrate to the one we=20
> prefer now.
Agreed, it's clear now that I can't remove just 'mem' for OLD machine
types (even if this safe variant is broken and doesn't actually do
what it should). Libvirt should use 'memdev' for new VMs for them
to actually benefit from NUMA configuration.

Currently we are talking about disabling 'mem' for new machine types
only (pity that I have to keep around legacy code but at least we would
be able to move on to normal device modeling for initial memory on
new machines).

> And if libvirt doesn't follow qemu's warnings then it definitely should.=
=20
> It's a libvirt bug if it doesn't follow the best practicies (well, if can=
).
>=20
> Michal
