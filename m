Received: from eggs.gnu.org ([209.51.188.92]:57997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ghb4F-0005zL-1Z
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ghb46-0001F9-5d
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:12:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ghb45-0001Dm-Tq
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:12:10 -0500
Date: Thu, 10 Jan 2019 09:12:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190110091140-mutt-send-email-mst@kernel.org>
References: <20190110020259.8492-1-ehabkost@redhat.com>
	<20190110020259.8492-4-ehabkost@redhat.com>
	<CAJ+F1C+cADS2WKysnEzH-ZD=C3uj5wymQFXtd4L9BOO2cjbjvA@mail.gmail.com>
	<20190110133123.GF4500@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190110133123.GF4500@habkost.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] virtio: Make
 disable-legacy/disable-modern compat properties optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jan 10, 2019 at 11:31:23AM -0200, Eduardo Habkost wrote:
> On Thu, Jan 10, 2019 at 12:35:26PM +0400, Marc-Andr=E9 Lureau wrote:
> > Hi
> >=20
> > On Thu, Jan 10, 2019 at 6:05 AM Eduardo Habkost <ehabkost@redhat.com>=
 wrote:
> > >
> > > The disable-legacy and disable-modern properties apply only to
> > > some virtio-pci devices.  Make those properties optional.
> > >
> > > This fixes the crash introduced by commit f6e501a28ef9 ("virtio: Pr=
ovide
> > > version-specific variants of virtio PCI devices"):
> > >
> > >   $ qemu-system-x86_64 -machine pc-i440fx-2.6 \
> > >     -device virtio-net-pci-non-transitional
> > >   Unexpected error in object_property_find() at qom/object.c:1092:
> > >   qemu-system-x86_64: -device virtio-net-pci-non-transitional: can'=
t apply \
> > >   global virtio-pci.disable-modern=3Don: Property '.disable-modern'=
 not found
> > >   Aborted (core dumped)
> > >
> > > Reported-by: Thomas Huth <thuth@redhat.com>
> > > Fixes: f6e501a28ef9 ("virtio: Provide version-specific variants of =
virtio PCI devices")
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  hw/core/machine.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > index 5530b71981..a19143aa44 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -91,8 +91,9 @@ const size_t hw_compat_2_7_len =3D G_N_ELEMENTS(h=
w_compat_2_7);
> > >
> > >  GlobalProperty hw_compat_2_6[] =3D {
> > >      { "virtio-mmio", "format_transport_address", "off" },
> > > -    { "virtio-pci", "disable-modern", "on" },
> > > -    { "virtio-pci", "disable-legacy", "off" },
> > > +    /* Optional because not all virtio-pci devices support legacy =
mode */
> > > +    { "virtio-pci", "disable-modern", "on",  .optional =3D true },
> > > +    { "virtio-pci", "disable-legacy", "off", .optional =3D true },
> >=20
> > Could the generic devices implement a specific interface instead?
> > virtio-pci-generic?
>=20
> This is the kind of complexity I wanted to avoid.  We already
> have too many interface names for subsets of PCI and virtio
> devices.
>=20
> >=20
> > Adding "optional" handling looks like it may hide some other errors.
>=20
> What if we just make "optional" mean "skip if the property
> doesn't exist", as suggested by Cornelia and Dave?

That's the more standard meaning of the word optional, isn't it?

> --=20
> Eduardo
