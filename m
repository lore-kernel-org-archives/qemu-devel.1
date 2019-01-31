Received: from eggs.gnu.org ([209.51.188.92]:40779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gpFui-0005nR-8o
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gpFuh-0000s6-CL
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:14:08 -0500
Date: Thu, 31 Jan 2019 12:13:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190131121150-mutt-send-email-mst@kernel.org>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-4-sgarzare@redhat.com>
	<20190131103056-mutt-send-email-mst@kernel.org>
	<20190131170134.gxflj33hyctduzsc@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131170134.gxflj33hyctduzsc@steredhat>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] virtio-blk: add DISCARD and WRITE
 ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org

On Thu, Jan 31, 2019 at 06:01:34PM +0100, Stefano Garzarella wrote:
> On Thu, Jan 31, 2019 at 11:04:10AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Jan 31, 2019 at 04:19:12PM +0100, Stefano Garzarella wrote:
> > > This patch adds the support of DISCARD and WRITE ZEROES commands,
> > > that have been introduced in the virtio-blk protocol to have
> > > better performance when using SSD backend.
> > > 
> > > We support only one segment per request since multiple segments
> > > are not widely used and there are no userspace APIs that allow
> > > applications to submit multiple segments in a single call.
> > > 
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > 
> > This does not seem to match the spec clarifications
> > that Stefan Hajnoczi has posted on
> > the virtio TC.
> > 
> > I think this can go any of the following ways:
> > 
> > - we agree that a request should have at most one segment
> > 	no padding allowed
> > - we agree that a request should have at most one segment
> > 	we require padding to 512 bytes
> > - we agree that a request should have at most one segment
> > 	we also support padding to 512 bytes
> > - we agree that a request should have at most one segment
> > 	we also support arbitrary padding
> > - we agree that a request can have any # of segments
> 
> Hi Michael,
> reading the latest patch [1] sent by Stefan, I supposed that the padding
> is not allowed, but if we need to support it, I'll fix the implementation.
> 
> About the number of segments, I followed the description of
> max_discard_sectors [2] and the implementation provided by SPDK's
> virtio-blk driver and vhost-user-blk device backend. They also only
> support one segment per request, properly setting "max_discard_seg" and
> "max_write_zeroes_seg", so if I understood correctly, the specification
> leave to the device the freedom to support one or more segments.


Oh I missed the fact that you set the config space values to 1.
I confused it with # of sectors.


Now it looks right to me, so pls ignore my comments.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



> > 
> > I would also need your feedback on whether all this
> > is a material change to 1.1 public review according to the oasis definition:
> > 
> > 	"Material Change" is any change to the content of a Work Product that
> > 	that would require a compliant application or implementation to be
> > 	modified or rewritten in order to remain compliant or which adds new
> > 	features or otherwise expands the scope of the work product.
> > 
> 
> IMHO and if I understood correctly, maybe only the second way (require
> padding to 512 bytes) should be a "Material Change" because we need to
> modify all the implementations (Linux driver, SPDK, vhost).
> 
> The other ways should be already supported, because all the
> implementations set the status right behind the last byte (regardless of
> padding).
> 
> 
> #1: https://lists.oasis-open.org/archives/virtio-dev/201901/msg00135.html
> #2: https://github.com/oasis-tcs/virtio-spec/blob/master/content.tex#L3876
> 
> 
> Thanks,
> Stefano
