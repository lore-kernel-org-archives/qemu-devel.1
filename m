Received: from eggs.gnu.org ([209.51.188.92]:46977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1ZsX-00068X-NR
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1ZsV-0001tv-NL
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:58:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1h1ZsS-0001rY-EP
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:58:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F2F081F18
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 16:58:42 +0000 (UTC)
Date: Wed, 6 Mar 2019 17:58:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190306175835.73cb31ad@Igors-MacBook-Pro.local>
In-Reply-To: <20190306163938.GI20806@redhat.com>
References: <1551889825-227155-1-git-send-email-imammedo@redhat.com>
	<20190306163938.GI20806@redhat.com>
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, libvir-list@redhat.com, eblake@redhat.com

On Wed, 6 Mar 2019 16:39:38 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Mar 06, 2019 at 05:30:25PM +0100, Igor Mammedov wrote:
> > Ammend -numa option docs and print warnings if 'mem' option or default =
RAM
> > splitting between nodes is used. It's intended to discourage users from=
 using
> > configuration that allows only to fake NUMA on guest side while leading
> > to reduced performance of the guest due to inability to properly config=
ure
> > VM's RAM on the host.
> >=20
> > In NUMA case, it's recommended to always explicitly configure guest RAM
> > using -numa node,memdev=3D{backend-id} option.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  numa.c          |  5 +++++
> >  qemu-options.hx | 12 ++++++++----
> >  2 files changed, 13 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/numa.c b/numa.c
> > index 3875e1e..c6c2a6f 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -121,6 +121,8 @@ static void parse_numa_node(MachineState *ms, NumaN=
odeOptions *node,
> > =20
> >      if (node->has_mem) {
> >          numa_info[nodenr].node_mem =3D node->mem;
> > +        warn_report("Parameter -numa node,mem is obsolete,"
> > +                    " use -numa node,memdev instead");
>=20
> I don't think we should do this. Libvirt isn't going to stop using this
> option in the near term. When users see warnings like this in logs
well when it was the only option available libvirt had no other choice,
but since memdev became available libvirt should try to use it whenever
possible.

> they'll often file bugs reports thinking something is broken which is
> not the case here.=20
It's the exact purpose of the warning, to force user asking questions
and fix configuration, since he/she obviously not getting NUMA benefits
and/or performance-wise

I have to disagree here, I don't like ducking our head and ignoring broken
configuration when there is working alternative. As end user I'd hate that
problem was hidden from me.


I'll respin v2 after fixing mistakes Eric pointed out.

>=20
> >      }
> >      if (node->has_memdev) {
> >          Object *o;
> > @@ -407,6 +409,9 @@ void numa_complete_configuration(MachineState *ms)
> >          if (i =3D=3D nb_numa_nodes) {
> >              assert(mc->numa_auto_assign_ram);
> >              mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram=
_size);
> > +            warn_report("Default splitting of RAM between nodes is obs=
olete,"
> > +                        " Use '-numa node,memdev' to explictly define =
RAM"
> > +                        " allocation per node");
>=20
> I think this one is ok as I don't believe libvirt triggers this code path
>=20
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 1cf9aac..033e311 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -206,10 +206,14 @@ For example:
> >  -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D1,socket-id=3D1
> >  @end example
> > =20
> > -@samp{mem} assigns a given RAM amount to a node. @samp{memdev}
> > -assigns RAM from a given memory backend device to a node. If
> > -@samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
> > -split equally between them.
> > +@samp{memdev} assigns RAM from a given memory backend device to a node.
> > +
> > +Legacy options/behaviour: @samp{mem} assigns a given RAM amount to a n=
ode.
> > +If @samp{mem} and @samp{memdev} are omitted in all nodes, RAM is split=
 equally
> > +between them. Option @samp{mem} and default RAM splitting are obsolete=
 as they
> > +do not provide means to manage RAM on host side and only allow QEMU to=
 fake
> > +NUMA support which in practice could degrade VM performance.
> > +It's advised to always explicitly configure NUMA RAM using @samp{memde=
v} option.
> > =20
> >  @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
> >  if one node uses @samp{memdev}, all of them have to use it.
> > --=20
> > 2.7.4
> >=20
>=20
> Regards,
> Daniel
