Received: from eggs.gnu.org ([209.51.188.92]:51034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gokmg-0007lz-V1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gokmf-0000Ql-PL
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:59:46 -0500
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Wed, 30 Jan 2019 07:59:16 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B7B1A7A@SHSMSX103.ccr.corp.intel.com>
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
	<20190130073949.GB5832@stefanha-x1.localdomain>
In-Reply-To: <20190130073949.GB5832@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Wednesday, January 30, 2019 3:40 PM
> To: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>; Thomas Huth <thuth@redhat.com>;
> Stefano Garzarella <sgarzare@redhat.com>; Liu, Changpeng
> <changpeng.liu@intel.com>; Laurent Vivier <lvivier@redhat.com>; Kevin Wol=
f
> <kwolf@redhat.com>; qemu-block@nongnu.org; qemu-devel@nongnu.org; Max
> Reitz <mreitz@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; virtio-
> comment@lists.oasis-open.org
> Subject: Re: [Qemu-devel] [PATCH RFC 2/2] tests/virtio-blk: add test for
> WRITE_ZEROES command
>=20
> On Sun, Jan 27, 2019 at 01:42:03PM -0500, Michael S. Tsirkin wrote:
> > On Sun, Jan 27, 2019 at 12:57:20PM +0000, Stefan Hajnoczi wrote:
> > > On Fri, Jan 25, 2019 at 02:17:01PM -0500, Michael S. Tsirkin wrote:
> > > > On Fri, Jan 25, 2019 at 03:12:45PM +0000, Stefan Hajnoczi wrote:
> > > > > Based on the Linux guest driver code and the lack of more evidenc=
e in
> > > > > the spec, I'm pretty sure data[] doesn't need to be padded to 512=
 bytes
> > > > > for discard/write zero requests.
> > > >
> > > > OK. Must devices support such padding?
> > >
> > > I see no reason to require padding.  Host APIs and physical storage
> > > controllers do not require it.
> >
> > I'm not talking about requiring padding I'm talking about
> > supporting padding on device side.
> >
> > One reason would be ease of extending the spec for guest.
> >
> > E.g. imagine adding more fields to the command.
> > With suppport for padding guest simply adds fields
> > to its structure, and the unused ones are ignored
> > by device. Without support for padding you need two
> > versions of the structure.
>=20
> The simplest way is to say each struct virtio_blk_discard_write_zeroes
> (currently 16 bytes long) is padded to 512 bytes, but this wastes a lot
> of memory.
>=20
> Stefano and I looked at the status of multiple segment discard/write
> zeroes in Linux: only the NVMe driver supports multiple segments.  Even
> SCSI sd doesn't support multiple segments.
>=20
> Userspace APIs do not offer a way for applications to submit multiple
> segments in a single call.  Only the block I/O scheduler creates
> requests with multiple segments.
>=20
> SPDK's virtio-blk driver and vhost-user-blk device backend also only
> support 1 segment per request.
>=20
> Given this situation, I'm not sure it's worth the complexity to spec out
> a fancy padding scheme that no one will implement.  Wasting 512 - 16
> bytes per segment also seems unattractive.  IMO it's acceptable to
> introduce a feature bit if struct virtio_blk_discard_write_zeroes needs
> extension in the future.
>=20
> > Another reason would be compatibility.  For better or worse the spec
> > does make it look like 512 padding is present. This patch was merged ve=
ry
> > recently so I agree it's not too late to clarify it that it's not
> > required, but it seems a bit too much to disallow that completely.
> > Let's assume for a minute a device turns up that already
> > implemented the 512 byte assumption? If padding is allowed then we can
> > write a driver that works with both devices.
>=20
> The Linux guest driver doesn't honor 512 byte padding, so device
> backends would already need to make an exception if we spec 512 byte
> padding.
>=20
> Let's begin VIRTIO 1.1 with the state of real-world implementations:
> data[] must be a multiple of sizeof(struct
> virtio_blk_discard_write_zeroes).
Actually that's the purpose at the first beginning, padding to 512 bytes wi=
ll waste some memory space,=20
it's nice to have an exception other Read/Write commands.=20
>=20
> I'll send a patch to the virtio TC and we can discuss further in that
> thread.
>=20
> Stefan
