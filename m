Received: from eggs.gnu.org ([209.51.188.92]:48991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gqV0a-000167-5x
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 22:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gqV0Z-0000Mr-6H
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 22:33:19 -0500
Date: Mon, 4 Feb 2019 11:33:07 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190204033307.GC29523@stefanha-x1.localdomain>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-3-sgarzare@redhat.com>
	<20190201101604-mutt-send-email-mst@kernel.org>
	<CAGxU2F50t=OeuoJMn7q7iDYyy+mc=3vz7V8dVe77KtOu1hKHyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <CAGxU2F50t=OeuoJMn7q7iDYyy+mc=3vz7V8dVe77KtOu1hKHyw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] virtio-blk: add "discard-wzeroes"
 boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 06:18:52PM +0100, Stefano Garzarella wrote:
> On Fri, Feb 1, 2019 at 4:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Thu, Jan 31, 2019 at 04:19:11PM +0100, Stefano Garzarella wrote:
> > > In order to avoid migration issues, we enable DISCARD and
> > > WRITE ZEROES features only for machine type >=3D 4.0
> > >
> > > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  hw/block/virtio-blk.c          | 2 ++
> > >  hw/core/machine.c              | 1 +
> > >  include/hw/virtio/virtio-blk.h | 1 +
> > >  3 files changed, 4 insertions(+)
> > >
> > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > index 8a6754d9a2..542ec52536 100644
> > > --- a/hw/block/virtio-blk.c
> > > +++ b/hw/block/virtio-blk.c
> > > @@ -1026,6 +1026,8 @@ static Property virtio_blk_properties[] =3D {
> > >      DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 1=
28),
> > >      DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IO=
THREAD,
> > >                       IOThread *),
> > > +    DEFINE_PROP_BIT("discard-wzeroes", VirtIOBlock, conf.discard_wze=
roes, 0,
> > > +                     true),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >
> >
> > Thinking about it, are there security implications for discard?
> > Should we make it default false?
>=20
> Hi Michael,
>=20
> I'm not completely sure but if the guest can write on a specific sector,
> discard or write_zeroes operations should not have a security implication.
>=20
> Do I miss something?

Recently page cache attacks have been discussed in the Linux community:
https://arxiv.org/pdf/1901.01161.pdf

I guess the scenario Michael is thinking about involves either -drive
cache.direct=3Doff (including cache=3Dwriteback or cache=3Dwritethrough) or
maybe a timing side-channel in the storage appliance.

The discard operation may allow a guest to evict the cache, an important
primitive for page cache attacks.

Most of the time disk images are not shared between guests at all.
Therefore the discard operation cannot be used to learn information
about other guests.

Let's focus on shared disk images: shared disk images are either
read-only (then discard isn't allowed anyway) or they are shared
writable (but this already implies a trust relationship between the
guests).

My opinion is that discard is safe because virtualization use cases are
quite different from the attacks possible with shared library files
between userspace processes.  I'm curious if anyone has figured out a
realistic scenario where it does matter though...

Stefan

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcV7JzAAoJEJykq7OBq3PIszEIAIDANcGz7A6wQ8KMDBKapdas
eWaZWHVNIh0s9V6lh/NhTl7b99/OZbwlTBqFYM7oj5LhRHsb4qH1vGGe36JfAu5Q
xoWDdS4IjpoBKPilA7vPkzwJ+VMoHzEhOWJ0k0HJPHR7hd0tarnPJsDlLtQkuM+n
ShTmZt3froJWQFhBhtkaUJkHch+t/nsQ+ZwgYduYbAdQPG9n4Xmh0G12KthwWjUR
LoyEyOe2d/OL1HnVc5B7DFOzRQqFuWNqQQHuK5lNQxlfj42XFieV5yosJyc2EI/e
YMhEm36AWYBPQTNYKQRTlrUjmy7yQixOAJTXlPW5KPvQwEFhwVUSRFHrhg+utfY=
=LQI2
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
