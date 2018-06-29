Received: from eggs.gnu.org ([2001:4830:134:3::10]:47893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYu2j-0000us-1i
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYu2e-00046W-28
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:06:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYu2d-00043P-85
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:06:27 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B8E55636D
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 14:06:25 +0000 (UTC)
Date: Fri, 29 Jun 2018 11:06:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629140620.GL7451@localhost.localdomain>
References: <20180628154502.GO3513@redhat.com>
	<20180628195227.GH7451@localhost.localdomain>
	<20180629101417.GB27016@redhat.com>
	<20180629121251.GB5072@orkuz.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

On Fri, Jun 29, 2018 at 02:12:51PM +0200, Jiri Denemark wrote:
> On Fri, Jun 29, 2018 at 11:14:17 +0100, Daniel P. Berrang=E9 wrote:
> > On Thu, Jun 28, 2018 at 04:52:27PM -0300, Eduardo Habkost wrote:
> > > On Thu, Jun 28, 2018 at 04:45:02PM +0100, Daniel P. Berrang=E9 wrot=
e:
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

That's a nice idea.  The only problem I see is that this:

  -> query-cpu-model-expansion type=3Dstatic model=3DHaswell
  <- { model: { name: "Haswell-2.12.0" } }

is returning a static CPU model ("Haswell-2.12.0") on
`model.name`, which matches the documentation for type=3Dstatic.
But this:

  -> query-cpu-model-expansion type=3Dstatic model=3DHaswell
  <- { model: { name: "Haswell", version=3D"2.12.0" } }

is returning a non-static CPU model name ("Haswell") on
`model.name`, which breaks the existing documentation of
type=3Dstatic ("Expand to a static CPU model, a combination of a
static base model name and property delta changes").

Maybe this would work:

  -> query-cpu-model-expansion type=3Dstatic model=3DHaswell
  <- { model: { name: "Haswell-base", version=3D"2.12.0" } }

"Haswell-base" would be a static CPU model.  "Haswell" would be a
non-static but migration-safe CPU model (which is already the
case today).

Having a "Haswell-2.12.0" alias (that looks like a regular CPU
model) for legacy management management software would be
possible too.

--=20
Eduardo
