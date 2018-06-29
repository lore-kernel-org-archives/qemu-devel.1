Received: from eggs.gnu.org ([2001:4830:134:3::10]:50169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYsK0-0005XX-84
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYsJw-00039f-6i
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:16:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYsJv-00038g-Vw
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:16:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FC187A7E5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 12:16:11 +0000 (UTC)
Date: Fri, 29 Jun 2018 13:16:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629121604.GS27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180628154502.GO3513@redhat.com>
	<20180628195227.GH7451@localhost.localdomain>
	<20180629101417.GB27016@redhat.com>
	<20180629121251.GB5072@orkuz.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180629121251.GB5072@orkuz.home>
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
To: Jiri Denemark <jdenemar@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

On Fri, Jun 29, 2018 at 02:12:51PM +0200, Jiri Denemark wrote:
> On Fri, Jun 29, 2018 at 11:14:17 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Jun 28, 2018 at 04:52:27PM -0300, Eduardo Habkost wrote:
> > > On Thu, Jun 28, 2018 at 04:45:02PM +0100, Daniel P. Berrang=C3=A9 w=
rote:
> > > [...]
> > > > What if we can borrow the concept of versioning from machine type=
s and apply
> > > > it to CPU models directly. For example, considering the history o=
f "Haswell"
> > > > in QEMU, if we had versioned things, we would by now have:
> > > >=20
> > > >      Haswell-1.3.0 - first version (37507094f350b75c62dc059f998e7=
185de3ab60a)
> > > >      Haswell-2.2.0 - added 'rdrand' (78a611f1936b3eac8ed78a2be214=
6a742a85212c_
> > > >      Haswell-2.3.0 - removed 'hle' & 'rtm' (a356850b80b3d13b2ef73=
7dad2acb05e6da03753)
> > > >      Haswell-2.5.0 - added 'abm' (becb66673ec30cb604926d247ab9449=
a60ad8b11
> > > >      Haswell-2.12.0 - added 'spec-ctrl' (ac96c41354b7e4c70b756342=
d9b686e31ab87458)
> > > >      Haswell-3.0.0  - added 'ssbd' (never done)
> > > >=20
> > > > If we followed the machine type approach, then a bare "Haswell" w=
ould
> > > > statically resolve at build time to the most recent Haswell-X.X.X=
 version
> > > > associated with the QEMU release. This is unhelpful as we have a =
direct
> > > > dependancy on the host hardware features. Better would be for a b=
are
> > > > "Haswell" to be dynamically resolved at runtime, picking the most=
 recent
> > > > version that is capable of launching given the current hardware, =
KVM/TCG impl
> > > > and QEMU version.
> > > >=20
> > > >   ie -cpu  Haswell
> > > >=20
> > > > should use Haswell-2.5.0  if on silicon with the TSX errata appli=
ed,
> > > > but use Haswell-2.12.0 if the Spectre errata is applied in microc=
ode,
> > > > and use Haswell-3.0.0 once Intel finally releases SSBD microcode =
errata.
> > >=20
> > > Doing this unconditionally would make
> > > "-machine pc-q35-3.1 -cpu Haswell" unsafe for live migration, and
> > > break existing usage.  But this behavior could be enabled
> > > explicitly somehow.
> >=20
> > True, for full back compat with existing libvirt we would probably
> > want to opt-in to it.
> >=20
> > eg  -cpu Haswell could pick a fixed Haswell--XXX version according
> > to the machine type.  -cpu Haswell,best=3Don  could pick best version
> > for the host with the caveat about migration between heterogenous
> > hosts.
>=20
> I was thinking we could even separate the CPU model version from the
> name itself:
>=20
>     -cpu Haswell                    (the old, compatible way)
>     -cpu Haswell,version=3Dbest
>     -cpu Haswell,version=3D2.12.0
>=20
> It would be slightly more work for the upper management layers, but IMH=
O
> it would make more sense.
>=20
> In any case, we have to think about keeping guest ABI stable.
>=20
> I hope the automatic version selection would not cause any problems for
> subsequent cold starts (such as Windows activation issues). It should b=
e
> very similar to updating CPU microcode which the guest OS is already
> supposed to deal with in real hardware. However, in the past QEMU
> changed CPU signature (family, model, stepping) for new machine types
> and it is likely to happen with separately versioned CPU models too. I
> believe CPU microcode updates do not touch these values. On the other
> hand, it's similar to host-model and the user can always specify exact
> version to avoid this slight change should it be a problem.
>=20
> Once the domain starts, we need to keep stable ABI across migrations,
> save/restores, or snapshots. Libvirt already does so by talking to QEMU
> before starting vCPUs and checking for disabled/enabled features. Then
> we store this information in the active domain XML to make sure we can
> enforce the same CPU later. This concept would need to be enhanced to
> include the CPU model version which QEMU would need to be able to
> report.
>=20
> A significantly more fun would result from letting libvirt use the
> versioned CPU model stuff by default without an explicit knob in the
> XML. But I guess you don't want to go that direction, do you?

>From libvirt POV I think we have to always fully expand the version
at time of define, in the same way we expand the machine type. Nothing
else can guarantee ABI.

So once you do have a guest and you want to update it to use a newer
version, you'd have to explicitly delete the version from the XML and
let libvirt update it again, similar to how you update existing guest
to new machine type.

We could perhaps make this easier - eg  VIR_DOMAIN_XML_UPDATE_CPU
flag for virDomainDefine/virDomainCreateXML  or similar.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
