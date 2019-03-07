Received: from eggs.gnu.org ([209.51.188.92]:43936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1pvk-0003ze-DY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1pvj-0007Rs-Iq
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1pvj-0007RX-9d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 908B2307E07A
	for <qemu-devel@nongnu.org>; Thu,  7 Mar 2019 10:07:10 +0000 (UTC)
Date: Thu, 7 Mar 2019 10:07:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190307100705.GH32268@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1551893605-236413-1-git-send-email-imammedo@redhat.com>
	<20190306181608.GL20806@redhat.com>
	<20190306195417.02ea9a4c@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306195417.02ea9a4c@Igors-MacBook-Pro.local>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] numa: warn if numa 'mem' option or
 default RAM splitting between nodes is used.
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

On Wed, Mar 06, 2019 at 07:54:17PM +0100, Igor Mammedov wrote:
> On Wed, 6 Mar 2019 18:16:08 +0000
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>=20
> > On Wed, Mar 06, 2019 at 06:33:25PM +0100, Igor Mammedov wrote:
> > > Amend -numa option docs and print warnings if 'mem' option or defau=
lt RAM
> > > splitting between nodes is used. It's intended to discourage users =
from using
> > > configuration that allows only to fake NUMA on guest side while lea=
ding
> > > to reduced performance of the guest due to inability to properly co=
nfigure
> > > VM's RAM on the host.
> > >=20
> > > In NUMA case, it's recommended to always explicitly configure guest=
 RAM
> > > using -numa node,memdev=3D{backend-id} option.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  numa.c          |  5 +++++
> > >  qemu-options.hx | 12 ++++++++----
> > >  2 files changed, 13 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/numa.c b/numa.c
> > > index 3875e1e..42838f9 100644
> > > --- a/numa.c
> > > +++ b/numa.c
> > > @@ -121,6 +121,8 @@ static void parse_numa_node(MachineState *ms, N=
umaNodeOptions *node,
> > > =20
> > >      if (node->has_mem) {
> > >          numa_info[nodenr].node_mem =3D node->mem;
> > > +        warn_report("Parameter -numa node,mem is obsolete,"
> > > +                    " use -numa node,memdev instead");
> >=20
> > My comments from v1 still apply. We must not do this as long as
> > libvirt has no choice but to continue using this feature.
> It has a choice to use 'memdev' whenever creating a new VM and continue
> using 'mem' with exiting VMs.

Unfortunately we don't have such a choice. Libvirt has no concept of the
distinction between an 'existing' and 'new' VM. It just receives an XML
file from the mgmt application and with transient guests, we have no
persistent configuration record of the VM. So we've no way of knowing
whether this VM was previously running on this same host, or another
host, or is completely new.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
