Received: from eggs.gnu.org ([209.51.188.92]:43468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1ptn-0002im-Kh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1ptg-0006Xz-0A
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:05:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1ptf-0006WM-I9
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:05:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8DEA1E6A9B
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 10:05:02 +0000 (UTC)
Date: Thu, 7 Mar 2019 10:04:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307100456.GG32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1551889825-227155-1-git-send-email-imammedo@redhat.com>
	<20190306163938.GI20806@redhat.com>
	<20190306175835.73cb31ad@Igors-MacBook-Pro.local>
	<20190306171037.GJ20806@redhat.com>
	<20190306194822.32254962@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306194822.32254962@Igors-MacBook-Pro.local>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] numa: warn if numa 'mem' option or default
 RAM splitting between nodes is used.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, libvir-list@redhat.com, eblake@redhat.com, Markus Armbruster <armbru@redhat.com>

On Wed, Mar 06, 2019 at 07:48:22PM +0100, Igor Mammedov wrote:
> On Wed, 6 Mar 2019 17:10:37 +0000
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>=20
> > On Wed, Mar 06, 2019 at 05:58:35PM +0100, Igor Mammedov wrote:
> > > On Wed, 6 Mar 2019 16:39:38 +0000
> > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > >=20
> > > > On Wed, Mar 06, 2019 at 05:30:25PM +0100, Igor Mammedov wrote:
> > > > > Ammend -numa option docs and print warnings if 'mem' option or =
default RAM
> > > > > splitting between nodes is used. It's intended to discourage us=
ers from using
> > > > > configuration that allows only to fake NUMA on guest side while=
 leading
> > > > > to reduced performance of the guest due to inability to properl=
y configure
> > > > > VM's RAM on the host.
> > > > >=20
> > > > > In NUMA case, it's recommended to always explicitly configure g=
uest RAM
> > > > > using -numa node,memdev=3D{backend-id} option.
> > > > >=20
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > > ---
> > > > >  numa.c          |  5 +++++
> > > > >  qemu-options.hx | 12 ++++++++----
> > > > >  2 files changed, 13 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/numa.c b/numa.c
> > > > > index 3875e1e..c6c2a6f 100644
> > > > > --- a/numa.c
> > > > > +++ b/numa.c
> > > > > @@ -121,6 +121,8 @@ static void parse_numa_node(MachineState *m=
s, NumaNodeOptions *node,
> > > > > =20
> > > > >      if (node->has_mem) {
> > > > >          numa_info[nodenr].node_mem =3D node->mem;
> > > > > +        warn_report("Parameter -numa node,mem is obsolete,"
> > > > > +                    " use -numa node,memdev instead");
> > > >=20
> > > > I don't think we should do this. Libvirt isn't going to stop usin=
g this
> > > > option in the near term. When users see warnings like this in log=
s
> > > well when it was the only option available libvirt had no other cho=
ice,
> > > but since memdev became available libvirt should try to use it when=
ever
> > > possible.
> >=20
> > As we previously discussed, it is not possible for libvirt to use it
> > in all cases.
> >=20
> > >=20
> > > > they'll often file bugs reports thinking something is broken whic=
h is
> > > > not the case here.=20
> > > It's the exact purpose of the warning, to force user asking questio=
ns
> > > and fix configuration, since he/she obviously not getting NUMA bene=
fits
> > > and/or performance-wise
> >=20
> > That's only useful if it is possible to do something about the proble=
m.
> > Libvirt wants to use the new option but it can't due to the live migr=
ation
> > problems. So this simply leads to bug reports that will end up marked
> > as CANTFIX.
> The problem could be solved by user though, by reconfiguring and restar=
ting
> domain since it's impossible to (at least as it stands now wrt migratio=
n).
>=20
> > I don't believe libvirt actually  suffers from the performance proble=
m
> > you describe wrt lack of pinning.   When we attempt to pin guest NUMA
> > nodes to host NUMA nodes, libvirt *will* use "memdev". IIUC, we
> > use "mem" in the case where there /no/ requested pinning of guest
> > NUMA nodes, and so we're not suffering from the limitations of "mem"
> > in that case.
> What would be the use-case for not pinning numa nodes?
> If user isn't asking for pinning, VM would run with degraded performanc=
e and
> it would be better of being non-numa.

The guest could have been originally booted on a host which has 2 NUMA
nodes and have been migrated to a host with 1 NUMA node, in which case
pinnning is not relevant.

For CI purposes too it is reasonable to create guests with NUMA configura=
tions
that bear no resemblance to the host NUMA configuration. This allows for =
testing
the operation of guest applications. This is something that is relevant t=
o
OpenStack for testnig Nova's handling of NUMA placement logic, since almo=
st
all their testing is in VMs not bare metal.

Not pinning isn't common, but it is reasonable to do it.

> Even if user doesn't ask for pinning, non-pinned memdev (for new VMs wh=
ere
> available) could be used as well. Users of 'mem' with new QEMU will see=
 the warning
> and probably think about if they are configured VM correctly.

We can't change to memdev due to migration problems. Since there is no
functional problem with using 'mem' in this scenario there's no pressing
reason to stop using 'mem'.

> Desire to deprecate 'mem' at least for new machines is to be able to pr=
event user
> from creating broken configs and manage all RAM in the same manner (fro=
ntend/backend).
> (I can't do it for old machine types but for new it is possible).

As before libvirt can't make its CLI config dependant on machine type
version as that breaks live migration to old libvirt versions.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
