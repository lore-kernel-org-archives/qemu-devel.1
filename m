Received: from eggs.gnu.org ([2001:4830:134:3::10]:35590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fPwiW-0001IC-E9
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fPwiT-0000Bn-3Q
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:08:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fPwiS-0000Av-QF
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:08:37 -0400
Date: Mon, 4 Jun 2018 18:08:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180604210830.GZ7451@localhost.localdomain>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<20180604125415.GN7451@localhost.localdomain>
	<20180604130129.GG19749@redhat.com>
	<20180604194500-mutt-send-email-mst@kernel.org>
	<20180604165637.GP19749@redhat.com>
	<a339771a-0ad8-c1de-c59d-2b6f0eea92ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a339771a-0ad8-c1de-c59d-2b6f0eea92ec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org

On Mon, Jun 04, 2018 at 09:40:15PM +0300, Marcel Apfelbaum wrote:
>=20
>=20
> On 06/04/2018 07:56 PM, Daniel P. Berrang=E9 wrote:
> > On Mon, Jun 04, 2018 at 07:48:51PM +0300, Michael S. Tsirkin wrote:
> > > On Mon, Jun 04, 2018 at 02:01:29PM +0100, Daniel P. Berrang=E9 wrot=
e:
> > > > On Mon, Jun 04, 2018 at 09:54:15AM -0300, Eduardo Habkost wrote:
> > > > > On Mon, Jun 04, 2018 at 04:38:22AM +0300, Michael S. Tsirkin wr=
ote:
> > > > > > On Sun, Jun 03, 2018 at 12:27:49PM +0300, Marcel Apfelbaum wr=
ote:
> > > > > > > Moving to QEMU 3.0 seems like a good opportunity for such a=
 change.
> > > > > > >=20
> > > > > > > I440FX is really old and does not support modern features l=
ike IOMMU.
> > > > > > > Q35's SATA emulation is faster than pc's IDE, native PCI ex=
press hotplug
> > > > > > > is cleaner than ACPI based one and so on...
> > > > > > >=20
> > > > > > > Also the libvirt guys added very good support for the Q35 m=
achine (thanks!).
> > > > > > >=20
> > > > > > > Management software should always specify the machine type =
and for the
> > > > > > > current setups, adding '-machine pc' to the command line is=
 not such a
> > > > > > > big deal.
> > > > > > >=20
> > > > > > > In time the pc machine will fade out and we will probably s=
top adding
> > > > > > > new versions at some point.
> > > > > > >=20
> > > > > > > Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com=
>
> > > > > > For command line users, I think changing the default isn't ni=
ce.
> > > > > >=20
> > > > > > Yes it's easy to add -machine pc but there's no documentation
> > > > > > that tells you to do so. Add to that shortcuts like -cdrom
> > > > > > stop working, hotplug needs extra bridges to work, and one
> > > > > > can see that while management tool users benefit from q35,
> > > > > > command line users will suffer.
> > > > > >=20
> > > > > > Can't we add a tag for management without changing the comman=
d line
> > > > > > default? How about "management-default"? "recommended"? "late=
st"?
> > > > > We could add new aliases if they are useful for management
> > > > > software, but we would need a well-defined use case and set of
> > > > > requirements+expectations for the new alias.
> > > > I'm not convinced by the idea of adding a distinct default "for m=
gmt". All
> > > > the problems described wrt 'q35' vs 'pc' apply equally to managem=
ent apps
> > > > as they do to humans. It just happens that one common mgmt layer =
(libvirt)
> > > > knows how to handle some of the complexity of q35. Other mgmt app=
s though
> > > > are just as likely to be hurt by the change as humans are. So eff=
ectively
> > > > the proposed "for mgmt" is actually  "for libvirt >=3D some versi=
on", which
> > > > feels like a layering violation to me.
> > > Is libvirt happy to just hard-code q35 for now then?
> > I'm pretty wary of doing that, as I feel 'pc' has broader OS compatib=
ility
> > than 'q35', so we'd be likely to cause breakage for users.
> >=20
> > IMHO, defaults are something better expressed in libosinfo, so if the=
re's
> > guests where we think q35 is a better choice, we can record it there =
and
> > leave everything else on pc to avoid risk of breakage.
>=20
> The only info we need to pass properly to management systems is:
> "Use q35 unless your guests are really old".

Or if your existing disk image contains drivers or other software
that work only with pc.  Or if it's going to trigger Windows
license reactivation on a disk image prepared using pc.

The stack can't change the default without breaking existing
guest images.  Whether it's a reasonable risk or it's
unacceptable depends on what are the intended audience and use
cases of a given management stack.  I don't think QEMU or libvirt
can make that decision for them.

That said, if something is going to break as soon as the default
in QEMU changes, that's a bug in the management stack.
Management stacks should stop assuming the default machine-type
in libvirt+QEMU is never going to change.

--=20
Eduardo
