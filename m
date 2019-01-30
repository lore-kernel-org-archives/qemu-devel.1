Received: from eggs.gnu.org ([209.51.188.92]:46716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gokTX-0000aL-IV
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gokTW-0000kF-K7
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:39:59 -0500
Date: Wed, 30 Jan 2019 15:39:49 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190130073949.GB5832@stefanha-x1.localdomain>
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-3-sgarzare@redhat.com>
	<5b3c3076-8f0e-c6a2-b6d1-707db2ae3a66@redhat.com>
	<962ebaff-23ce-57ff-3387-9017c2ccd14a@redhat.com>
	<20190125081615.2cevf7cy7bcnxqwh@steredhat>
	<d4aa8b25-f0ad-1444-587c-3d90a8ddc74a@redhat.com>
	<20190125151245.GD28305@stefanha-x1.localdomain>
	<20190125141502-mutt-send-email-mst@kernel.org>
	<20190127125720.GC13784@stefanha-x1.localdomain>
	<20190127133215-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20190127133215-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] tests/virtio-blk: add test for
 WRITE_ZEROES command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, virtio-comment@lists.oasis-open.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 01:42:03PM -0500, Michael S. Tsirkin wrote:
> On Sun, Jan 27, 2019 at 12:57:20PM +0000, Stefan Hajnoczi wrote:
> > On Fri, Jan 25, 2019 at 02:17:01PM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Jan 25, 2019 at 03:12:45PM +0000, Stefan Hajnoczi wrote:
> > > > Based on the Linux guest driver code and the lack of more evidence =
in
> > > > the spec, I'm pretty sure data[] doesn't need to be padded to 512 b=
ytes
> > > > for discard/write zero requests.
> > >=20
> > > OK. Must devices support such padding?
> >=20
> > I see no reason to require padding.  Host APIs and physical storage
> > controllers do not require it.
>=20
> I'm not talking about requiring padding I'm talking about
> supporting padding on device side.
>=20
> One reason would be ease of extending the spec for guest.
>=20
> E.g. imagine adding more fields to the command.
> With suppport for padding guest simply adds fields
> to its structure, and the unused ones are ignored
> by device. Without support for padding you need two
> versions of the structure.

The simplest way is to say each struct virtio_blk_discard_write_zeroes
(currently 16 bytes long) is padded to 512 bytes, but this wastes a lot
of memory.

Stefano and I looked at the status of multiple segment discard/write
zeroes in Linux: only the NVMe driver supports multiple segments.  Even
SCSI sd doesn't support multiple segments.

Userspace APIs do not offer a way for applications to submit multiple
segments in a single call.  Only the block I/O scheduler creates
requests with multiple segments.

SPDK's virtio-blk driver and vhost-user-blk device backend also only
support 1 segment per request.

Given this situation, I'm not sure it's worth the complexity to spec out
a fancy padding scheme that no one will implement.  Wasting 512 - 16
bytes per segment also seems unattractive.  IMO it's acceptable to
introduce a feature bit if struct virtio_blk_discard_write_zeroes needs
extension in the future.

> Another reason would be compatibility.  For better or worse the spec
> does make it look like 512 padding is present. This patch was merged very
> recently so I agree it's not too late to clarify it that it's not
> required, but it seems a bit too much to disallow that completely.
> Let's assume for a minute a device turns up that already
> implemented the 512 byte assumption? If padding is allowed then we can
> write a driver that works with both devices.

The Linux guest driver doesn't honor 512 byte padding, so device
backends would already need to make an exception if we spec 512 byte
padding.

Let's begin VIRTIO 1.1 with the state of real-world implementations:
data[] must be a multiple of sizeof(struct
virtio_blk_discard_write_zeroes).

I'll send a patch to the virtio TC and we can discuss further in that
thread.

Stefan

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcUVTFAAoJEJykq7OBq3PIZN4H/ityOO5lHFS/93Ow1ZCCuBYd
+YnLwCJWnGCLw4V8xMrb5eX0XB6WIZdhe17egQAHfooM8bJCuNIe+5w+gzAXTCZp
FTZqTjslKNf6Ge35/SVlleYj3pgv14o1DKAGiAajJi1zgs8c/YPrki8SOAU5GTSm
axdU2NZpW/XxhRUtZHxvD3FAh7FVyfPsFihqkW87rD/enBs/l/73TiVAgFlKzXJL
dUJ+0iI+Y4Cu3Rzl2bQ7+6eAsjJKEoaYH63VqCA40yI/MUoSdzwgrMvROanDrxIJ
XT8q75oLQQuSK67MHLKjESAMJgnJ41iM4f+/5wq/3PxYV4aVmfMupfZDTQcOTqw=
=08VH
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
