Received: from eggs.gnu.org ([209.51.188.92]:55296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gpEkm-0005gI-Dh
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gpEkl-0006mW-Gd
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:59:48 -0500
Date: Thu, 31 Jan 2019 15:59:17 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190131155916.GI2870@work-vm>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-3-sgarzare@redhat.com>
	<20190131154038.GH2870@work-vm>
	<20190131155046.djju3av73ufzfj6p@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131155046.djju3av73ufzfj6p@steredhat>
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

* Stefano Garzarella (sgarzare@redhat.com) wrote:
> On Thu, Jan 31, 2019 at 03:40:38PM +0000, Dr. David Alan Gilbert wrote:
> > * Stefano Garzarella (sgarzare@redhat.com) wrote:
> > > In order to avoid migration issues, we enable DISCARD and
> > > WRITE ZEROES features only for machine type >= 4.0
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
> > > @@ -1026,6 +1026,8 @@ static Property virtio_blk_properties[] = {
> > >      DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
> > >      DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
> > >                       IOThread *),
> > > +    DEFINE_PROP_BIT("discard-wzeroes", VirtIOBlock, conf.discard_wzeroes, 0,
> > > +                     true),
> > 
> > I think that's OK, but do you really want a DEFINE_PROP_BOOL and
> > a bool discard_wzeroes?
> > I think DEFINE_PROP_BIT is mostly used for a flag word where each
> > property is one more bit in the field.
> > 
> > Dave
> > 
> 
> Hi Dave,
> I was in doubt if to use DEFINE_PROP_BIT or DEFINE_PROP_BOOL, but
> looking in the virtio-blk.c, I found that also other boolean like
> "config-wce", "scsi", and "request-merging" was defined with
> DEFINE_PROP_BIT, so I followed this trand.

Oh odd, I don't see why it's done like that - unless that's visible to
the guest somehow directly.  The _BIT version is more commonly used
when you have a flag word that's got multiple bits defined in it.

> But I agree with you, DEFINE_PROP_BOOL should be better, so I will change it!

Thanks!

Dave

> Thanks,
> Stefano
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
