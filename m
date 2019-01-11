Received: from eggs.gnu.org ([209.51.188.92]:48780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghs5O-00072n-14
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghs5M-0002Xq-VR
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:22:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ghs5H-0002LH-Qz
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:22:34 -0500
Date: Fri, 11 Jan 2019 09:22:12 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190111092212.6eee4d09.cohuck@redhat.com>
In-Reply-To: <CAJ+F1CJrJ6W7TLc3vOk9sNZKEY5q_89FiDr-iPRt-W8_0cht6g@mail.gmail.com>
References: <20190110020259.8492-1-ehabkost@redhat.com>
	<20190110020259.8492-4-ehabkost@redhat.com>
	<CAJ+F1C+cADS2WKysnEzH-ZD=C3uj5wymQFXtd4L9BOO2cjbjvA@mail.gmail.com>
	<20190110133123.GF4500@habkost.net>
	<20190110091140-mutt-send-email-mst@kernel.org>
	<20190110150125.GF2589@work-vm> <20190110180749.GH4500@habkost.net>
	<CAJ+F1CJrJ6W7TLc3vOk9sNZKEY5q_89FiDr-iPRt-W8_0cht6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Fri, 11 Jan 2019 01:06:45 +0400
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> On Thu, Jan 10, 2019 at 10:07 PM Eduardo Habkost <ehabkost@redhat.com> wr=
ote:
> >
> > On Thu, Jan 10, 2019 at 03:01:25PM +0000, Dr. David Alan Gilbert wrote:=
 =20
> > > * Michael S. Tsirkin (mst@redhat.com) wrote: =20
> > > > On Thu, Jan 10, 2019 at 11:31:23AM -0200, Eduardo Habkost wrote: =20
> > > > > On Thu, Jan 10, 2019 at 12:35:26PM +0400, Marc-Andr=C3=A9 Lureau =
wrote: =20
> > > > > > Hi
> > > > > >
> > > > > > On Thu, Jan 10, 2019 at 6:05 AM Eduardo Habkost <ehabkost@redha=
t.com> wrote: =20
> > > > > > >
> > > > > > > The disable-legacy and disable-modern properties apply only to
> > > > > > > some virtio-pci devices.  Make those properties optional.
> > > > > > >
> > > > > > > This fixes the crash introduced by commit f6e501a28ef9 ("virt=
io: Provide
> > > > > > > version-specific variants of virtio PCI devices"):
> > > > > > >
> > > > > > >   $ qemu-system-x86_64 -machine pc-i440fx-2.6 \
> > > > > > >     -device virtio-net-pci-non-transitional
> > > > > > >   Unexpected error in object_property_find() at qom/object.c:=
1092:
> > > > > > >   qemu-system-x86_64: -device virtio-net-pci-non-transitional=
: can't apply \
> > > > > > >   global virtio-pci.disable-modern=3Don: Property '.disable-m=
odern' not found
> > > > > > >   Aborted (core dumped)
> > > > > > >
> > > > > > > Reported-by: Thomas Huth <thuth@redhat.com>
> > > > > > > Fixes: f6e501a28ef9 ("virtio: Provide version-specific varian=
ts of virtio PCI devices")
> > > > > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > > > > ---
> > > > > > >  hw/core/machine.c | 5 +++--
> > > > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > > > index 5530b71981..a19143aa44 100644
> > > > > > > --- a/hw/core/machine.c
> > > > > > > +++ b/hw/core/machine.c
> > > > > > > @@ -91,8 +91,9 @@ const size_t hw_compat_2_7_len =3D G_N_ELEM=
ENTS(hw_compat_2_7);
> > > > > > >
> > > > > > >  GlobalProperty hw_compat_2_6[] =3D {
> > > > > > >      { "virtio-mmio", "format_transport_address", "off" },
> > > > > > > -    { "virtio-pci", "disable-modern", "on" },
> > > > > > > -    { "virtio-pci", "disable-legacy", "off" },
> > > > > > > +    /* Optional because not all virtio-pci devices support l=
egacy mode */
> > > > > > > +    { "virtio-pci", "disable-modern", "on",  .optional =3D t=
rue },
> > > > > > > +    { "virtio-pci", "disable-legacy", "off", .optional =3D t=
rue }, =20
> > > > > >
> > > > > > Could the generic devices implement a specific interface instea=
d?
> > > > > > virtio-pci-generic? =20
> > > > >
> > > > > This is the kind of complexity I wanted to avoid.  We already
> > > > > have too many interface names for subsets of PCI and virtio
> > > > > devices.
> > > > > =20
> > > > > >
> > > > > > Adding "optional" handling looks like it may hide some other er=
rors. =20
> > > > >
> > > > > What if we just make "optional" mean "skip if the property
> > > > > doesn't exist", as suggested by Cornelia and Dave? =20
> > > >
> > > > That's the more standard meaning of the word optional, isn't it? =20
> > >
> > > Well the word is a separate issue; 'optional' is probably a bad choice
> > > but that's less important than what it actually does.
> > > I'd go for skip_if_missing  which is explicit. =20
> >
> > I'm unsure about that.  To me "optional" means "it can be
> > missing" and carries the same information as "skip if missing".
> >
> > What do others think? =20
>=20
> skip_if_missing is more explicit.

I'd slightly prefer optional, but skip_if_missing is fine.
