Received: from eggs.gnu.org ([2001:4830:134:3::10]:53024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYqQ7-0003fR-TN
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYqQ4-0002Ih-LB
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:14:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYqQ4-0002IE-Cz
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:14:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F36608151D6F
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 10:14:23 +0000 (UTC)
Date: Fri, 29 Jun 2018 11:14:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629101417.GB27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180628154502.GO3513@redhat.com>
	<20180628195227.GH7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628195227.GH7451@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] CPU model versioning separate from machine type
 versioning ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com

On Thu, Jun 28, 2018 at 04:52:27PM -0300, Eduardo Habkost wrote:
> On Thu, Jun 28, 2018 at 04:45:02PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> [...]
> > What if we can borrow the concept of versioning from machine types an=
d apply
> > it to CPU models directly. For example, considering the history of "H=
aswell"
> > in QEMU, if we had versioned things, we would by now have:
> >=20
> >      Haswell-1.3.0 - first version (37507094f350b75c62dc059f998e7185d=
e3ab60a)
> >      Haswell-2.2.0 - added 'rdrand' (78a611f1936b3eac8ed78a2be2146a74=
2a85212c_
> >      Haswell-2.3.0 - removed 'hle' & 'rtm' (a356850b80b3d13b2ef737dad=
2acb05e6da03753)
> >      Haswell-2.5.0 - added 'abm' (becb66673ec30cb604926d247ab9449a60a=
d8b11
> >      Haswell-2.12.0 - added 'spec-ctrl' (ac96c41354b7e4c70b756342d9b6=
86e31ab87458)
> >      Haswell-3.0.0  - added 'ssbd' (never done)
> >=20
> > If we followed the machine type approach, then a bare "Haswell" would
> > statically resolve at build time to the most recent Haswell-X.X.X ver=
sion
> > associated with the QEMU release. This is unhelpful as we have a dire=
ct
> > dependancy on the host hardware features. Better would be for a bare
> > "Haswell" to be dynamically resolved at runtime, picking the most rec=
ent
> > version that is capable of launching given the current hardware, KVM/=
TCG impl
> > and QEMU version.
> >=20
> >   ie -cpu  Haswell
> >=20
> > should use Haswell-2.5.0  if on silicon with the TSX errata applied,
> > but use Haswell-2.12.0 if the Spectre errata is applied in microcode,
> > and use Haswell-3.0.0 once Intel finally releases SSBD microcode erra=
ta.
>=20
> Doing this unconditionally would make
> "-machine pc-q35-3.1 -cpu Haswell" unsafe for live migration, and
> break existing usage.  But this behavior could be enabled
> explicitly somehow.

True, for full back compat with existing libvirt we would probably
want to opt-in to it.

eg  -cpu Haswell could pick a fixed Haswell--XXX version according
to the machine type.  -cpu Haswell,best=3Don  could pick best version
for the host with the caveat about migration between heterogenous
hosts.

> > Versioning of CPU models as opposed to using arbitrary string suffixe=
s
> > (-noTSX, -IBRS) has a number of usability improvements that we would
> > gain with versioned machine types, while avoiding exploding the machi=
ne
> > type matrix. With versioned CPU models we can
> >=20
> >  - Automatically tailor the best model based on hardware support
> >=20
> >  - Users always get the best model if they use the bare CPU name
> >=20
> >  - It is obvious to users which is the "best" / "newest" CPU model
> >=20
> >  - Avoid combinatorial expansion of machines since same CPU model
> >    version can be added to all releases without adding machine types.
> >=20
> >  - Users can still force a specific downgraded model by using the
> >    fully versioned name.
> >=20
> > Such versioning of CPU models would largely "just work" with existing
> > libvirt versions, but to libvirt would really want to expand the bare
> > CPU name to a versioned CPU name when recording new guest XML, so the
> > ABI is preserved long term.
> >=20
> > An application like virt-manager which wants a simple UI can forever =
be
> > happy simply giving users a list of bare CPU model names, and allowin=
g
> > libvirt / QEMU to automatically expand to the best versioned model fo=
r
> > their host.
> >=20
> > An application like oVirt/OpenStack which wants direct control can al=
low
> > the admin to choice if a bare name, or explicitly picking a versioned=
 name
> > if they need to cope with possibility of outdated hosts.
> >=20
>=20
> The proposal makes sense, and I think most of it can be already
> implemented on top of existing query-cpu-model-* commands.
> query-cpu-model-expansion type=3Dstatic can expand to a versioned
> CPU model.
>=20
> We will probably need to make query-cpu-model-expansion accept a
> machine-type name as input, and/or add a new flag meaning "please
> give me the best CPU version you have, not the one defined by the
> current machine-type".
>=20
> I'm not sure what would be the best way to encode two types of
> information, though:
>=20
> * Fallback/alternatives info, e.g.: "It makes sense to use
>   Haswell-{3.0,2.12,2.5,...} if Haswell-3.1 is not runnable and the
>   user asked for Haswell".
>=20
> * Ordering/preference info, e.g.: "Haswell-3.1 is better than
>   Haswell-3.0, prefer the latter"

The version number of course gives an ordering, but we generally
tell people not to assume version is numeric.  We could report
an explicit "priority" in some manner against each.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
