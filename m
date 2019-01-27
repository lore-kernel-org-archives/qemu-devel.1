Received: from eggs.gnu.org ([209.51.188.92]:34534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gnpSL-0007nq-Rg
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gnpNm-0003vN-VC
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 13:42:15 -0500
Date: Sun, 27 Jan 2019 13:42:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190127133215-mutt-send-email-mst@kernel.org>
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-3-sgarzare@redhat.com>
	<5b3c3076-8f0e-c6a2-b6d1-707db2ae3a66@redhat.com>
	<962ebaff-23ce-57ff-3387-9017c2ccd14a@redhat.com>
	<20190125081615.2cevf7cy7bcnxqwh@steredhat>
	<d4aa8b25-f0ad-1444-587c-3d90a8ddc74a@redhat.com>
	<20190125151245.GD28305@stefanha-x1.localdomain>
	<20190125141502-mutt-send-email-mst@kernel.org>
	<20190127125720.GC13784@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190127125720.GC13784@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, virtio-comment@lists.oasis-open.org

On Sun, Jan 27, 2019 at 12:57:20PM +0000, Stefan Hajnoczi wrote:
> On Fri, Jan 25, 2019 at 02:17:01PM -0500, Michael S. Tsirkin wrote:
> > On Fri, Jan 25, 2019 at 03:12:45PM +0000, Stefan Hajnoczi wrote:
> > > Based on the Linux guest driver code and the lack of more evidence in
> > > the spec, I'm pretty sure data[] doesn't need to be padded to 512 bytes
> > > for discard/write zero requests.
> > 
> > OK. Must devices support such padding?
> 
> I see no reason to require padding.  Host APIs and physical storage
> controllers do not require it.

I'm not talking about requiring padding I'm talking about
supporting padding on device side.

One reason would be ease of extending the spec for guest.

E.g. imagine adding more fields to the command.
With suppport for padding guest simply adds fields
to its structure, and the unused ones are ignored
by device. Without support for padding you need two
versions of the structure.

Another reason would be compatibility.  For better or worse the spec
does make it look like 512 padding is present. This patch was merged very
recently so I agree it's not too late to clarify it that it's not
required, but it seems a bit too much to disallow that completely.
Let's assume for a minute a device turns up that already
implemented the 512 byte assumption? If padding is allowed then we can
write a driver that works with both devices.


> > > > Looking at the QEMU sources, it seems like it can deal with both and
> > > > always sets the status right behind the last byte:
> > > > 
> > > >     req->in = (void *)in_iov[in_num - 1].iov_base
> > > >               + in_iov[in_num - 1].iov_len
> > > >               - sizeof(struct virtio_blk_inhdr);
> > > > 
> > > > Anyway, I think the virtio spec should be clearer here to avoid bad
> > > > implementations in the future, so maybe Changpeng or Michael could
> > > > update the spec here a little bit?
> > > 
> > > Yep, good point.  VIRTIO 1.1 is available for public comments, so I've
> > > CCed the list.
> > > 
> > > Stefan
> > 
> > Thanks!
> > Care creating a github issue? And maybe proposing a spec patch.
> 
> Okay.  I will do this on Wednesday 30th of January.
> 
> Stefan
