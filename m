Received: from eggs.gnu.org ([2001:4830:134:3::10]:56418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gOnyO-00036r-1k
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gOnyI-00077q-EM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:08:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gOnyI-000762-4V
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:08:30 -0500
Date: Mon, 19 Nov 2018 13:07:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181119125519-mutt-send-email-mst@kernel.org>
References: <20181114233831.10374-1-ehabkost@redhat.com>
	<c1b4a0ee39dfddeb19f1be46710c10cbefd3f07a.camel@redhat.com>
	<20181116034551.GK3807@habkost.net>
	<20181119114105.4da89f2c.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119114105.4da89f2c.cohuck@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Mon, Nov 19, 2018 at 11:41:05AM +0100, Cornelia Huck wrote:
> On Fri, 16 Nov 2018 01:45:51 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Thu, Nov 15, 2018 at 05:29:24PM +0100, Andrea Bolognani wrote:
>=20
> > > One thing that I'm very much not convinced about is the naming,
> > > specifically leaving the virtio revision out: I get it that we
> > > Should Never Need=E2=84=A2 another major version of the spec, but I=
'm
> > > afraid discounting the possibility outright might prove to be
> > > shortsighted and come back to bite us later, so I'd much rather
> > > keep it.

That's not the claim. In fact the reverse is true - a major revision can
come at any point. The claim is that virtio compatibility is not based
on version numbers.  And another claim is that you can trust the
virtio TC not to overload terminology that it put in the spec. So use
that and you should be fine.  Come up with your own and end up writing
another spec just to document it.

> > >=20
> > > And once that's done, "non-transitional" (while matching the
> > > language of the spec) starts to look a bit unnecessary when you
> > > could simply have
> > >=20
> > >   virtio-*-pci
> > >   virtio-*-pci-1
> > >   virtio-*-pci-1-transitional
> > >=20
> > > instead. But I don't feel as strongly about this as I do about
> > > keeping the virtio revision in the device name :) =20
> >=20
> > I like that suggestion.  Makes the device names more explicit
> > _and_ shorter.  I'll do that in v3.
>=20
> OTOH, that would mean we'd need to introduce new device types if we
> ever start to support a virtio 2.x standard. My understanding was that
> we'll want separate device types for transitional and non-transitional
> for two reasons: the bus which a device can be plugged into, and
> changing ids. Do we really expect huge changes in a possible 2.x
> standard that affect virtio-pci only, and not other virtio transports
> as well?

Yes I think adding a version there is a mistake.
transitional/legacy/non-transitional are spec terms so
they are unlikely to change abruptly. OTOH virtio TC can
just decide next version is 2.0 on a drop of a hat.

And I strongly believe command line users really really do not want all
this mess. Even adding "pci" is the name confuses people (what are the
other options?). For command line model=3Dvirtio is pretty much perfect.
So all these names are there primarily for libvirt's benefit.
And the only input from libvirt devs so far
has been that it's unclear how does cross version
migration work. That needs to be addressed in some way.

So can we maybe start with a libvirt domain xml patch, with an
implementation for existing QEMU, get that acked, and then just map it
back to qemu command line as directly as possible?

--=20
MST
