Received: from eggs.gnu.org ([209.51.188.92]:39120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1bah-0005mv-Uv
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1bah-0003mq-0P
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:48:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1h1bag-0003kW-NY
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:48:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AB24308339E
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 18:48:30 +0000 (UTC)
Date: Wed, 6 Mar 2019 19:48:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190306194822.32254962@Igors-MacBook-Pro.local>
In-Reply-To: <20190306171037.GJ20806@redhat.com>
References: <1551889825-227155-1-git-send-email-imammedo@redhat.com>
	<20190306163938.GI20806@redhat.com>
	<20190306175835.73cb31ad@Igors-MacBook-Pro.local>
	<20190306171037.GJ20806@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: "Daniel P. =?UTF-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, libvir-list@redhat.com, eblake@redhat.com, Markus Armbruster <armbru@redhat.com>

On Wed, 6 Mar 2019 17:10:37 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Mar 06, 2019 at 05:58:35PM +0100, Igor Mammedov wrote:
> > On Wed, 6 Mar 2019 16:39:38 +0000
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >=20
> > > On Wed, Mar 06, 2019 at 05:30:25PM +0100, Igor Mammedov wrote:
> > > > Ammend -numa option docs and print warnings if 'mem' option or defa=
ult RAM
> > > > splitting between nodes is used. It's intended to discourage users =
from using
> > > > configuration that allows only to fake NUMA on guest side while lea=
ding
> > > > to reduced performance of the guest due to inability to properly co=
nfigure
> > > > VM's RAM on the host.
> > > >=20
> > > > In NUMA case, it's recommended to always explicitly configure guest=
 RAM
> > > > using -numa node,memdev=3D{backend-id} option.
> > > >=20
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > >  numa.c          |  5 +++++
> > > >  qemu-options.hx | 12 ++++++++----
> > > >  2 files changed, 13 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/numa.c b/numa.c
> > > > index 3875e1e..c6c2a6f 100644
> > > > --- a/numa.c
> > > > +++ b/numa.c
> > > > @@ -121,6 +121,8 @@ static void parse_numa_node(MachineState *ms, N=
umaNodeOptions *node,
> > > > =20
> > > >      if (node->has_mem) {
> > > >          numa_info[nodenr].node_mem =3D node->mem;
> > > > +        warn_report("Parameter -numa node,mem is obsolete,"
> > > > +                    " use -numa node,memdev instead");
> > >=20
> > > I don't think we should do this. Libvirt isn't going to stop using th=
is
> > > option in the near term. When users see warnings like this in logs
> > well when it was the only option available libvirt had no other choice,
> > but since memdev became available libvirt should try to use it whenever
> > possible.
>=20
> As we previously discussed, it is not possible for libvirt to use it
> in all cases.
>=20
> >=20
> > > they'll often file bugs reports thinking something is broken which is
> > > not the case here.=20
> > It's the exact purpose of the warning, to force user asking questions
> > and fix configuration, since he/she obviously not getting NUMA benefits
> > and/or performance-wise
>=20
> That's only useful if it is possible to do something about the problem.
> Libvirt wants to use the new option but it can't due to the live migration
> problems. So this simply leads to bug reports that will end up marked
> as CANTFIX.
The problem could be solved by user though, by reconfiguring and restarting
domain since it's impossible to (at least as it stands now wrt migration).

> I don't believe libvirt actually  suffers from the performance problem
> you describe wrt lack of pinning.   When we attempt to pin guest NUMA
> nodes to host NUMA nodes, libvirt *will* use "memdev". IIUC, we
> use "mem" in the case where there /no/ requested pinning of guest
> NUMA nodes, and so we're not suffering from the limitations of "mem"
> in that case.
What would be the use-case for not pinning numa nodes?
If user isn't asking for pinning, VM would run with degraded performance and
it would be better of being non-numa.

Even if user doesn't ask for pinning, non-pinned memdev (for new VMs where
available) could be used as well. Users of 'mem' with new QEMU will see the=
 warning
and probably think about if they are configured VM correctly.

Desire to deprecate 'mem' at least for new machines is to be able to preven=
t user
from creating broken configs and manage all RAM in the same manner (fronten=
d/backend).
(I can't do it for old machine types but for new it is possible).


> > I have to disagree here, I don't like ducking our head and ignoring bro=
ken
> > configuration when there is working alternative. As end user I'd hate t=
hat
> > problem was hidden from me.
>=20
>=20
>=20
> Regards,
> Daniel
