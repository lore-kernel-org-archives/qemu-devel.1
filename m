Received: from eggs.gnu.org ([209.51.188.92]:56867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpVX6-0003bW-9T
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpVX0-00062S-VX
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:54:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gpVWy-0005yH-B4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:54:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so5429557wmj.1
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 01:54:34 -0800 (PST)
Date: Fri, 1 Feb 2019 10:54:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190201095430.qemq2viy4enwk62y@steredhat>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-4-sgarzare@redhat.com>
	<20190201045831.GD23131@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201045831.GD23131@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Feb 01, 2019 at 12:58:31PM +0800, Stefan Hajnoczi wrote:
> On Thu, Jan 31, 2019 at 04:19:12PM +0100, Stefano Garzarella wrote:
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 542ec52536..34ee676895 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -147,6 +147,30 @@ out:
> >      aio_context_release(blk_get_aio_context(s->conf.conf.blk));
> >  }
> >  
> > +static void virtio_blk_discard_wzeroes_complete(void *opaque, int ret)
> > +{
> > +    VirtIOBlockReq *req = opaque;
> > +    VirtIOBlock *s = req->dev;
> > +    bool is_wzeroes = (virtio_ldl_p(VIRTIO_DEVICE(req->dev), &req->out.type) &
> 
> s/req->dev/s/
> 
> > +                       ~VIRTIO_BLK_T_BARRIER) == VIRTIO_BLK_T_WRITE_ZEROES;
> > +
> > +    aio_context_acquire(blk_get_aio_context(s->conf.conf.blk));
> > +    if (ret) {
> > +        if (virtio_blk_handle_rw_error(req, -ret, 0, is_wzeroes)) {
> 
> The third argument is bool, please use false instead of 0.
> 
> > +            goto out;
> > +        }
> > +    }
> > +
> > +    virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
> > +    if (is_wzeroes) {
> > +        block_acct_done(blk_get_stats(req->dev->blk), &req->acct);
> 
> s/req->dev->blk/s->blk/
> 
> > +static uint8_t virtio_blk_handle_dwz(VirtIOBlockReq *req, bool is_wzeroes,
> > +    struct virtio_blk_discard_write_zeroes *dwz_hdr)
> > +{
> > +    VirtIOBlock *s = req->dev;
> > +    uint64_t sector;
> > +    uint32_t num_sectors, flags;
> > +    uint8_t err_status;
> > +    int bytes;
> > +
> > +    sector = virtio_ldq_p(VIRTIO_DEVICE(req->dev), &dwz_hdr->sector);
> 
> Here and throughout the rest of the function:
> 
>   VirtIODevice *vdev = VIRTIO_DEVICE(s);
> 
> s/VIRTIO_DEVICE(req->dev)/vdev/
> 
> and then to clean up the remaining instances:
> 
> s/req->dev/s/
> 

Thanks! I'll follow all of these suggestions.

> > +    if (is_wzeroes) { /* VIRTIO_BLK_T_WRITE_ZEROES */
> > +        int blk_aio_flags = 0;
> > +
> > +        if (s->conf.wz_may_unmap &&
> 
> The inconsistent naming is a bit messy and could confuse readers:
> write_zeroes vs wzeroes vs wz
> 
> The VIRTIO spec and QEMU code uses write_zeroes, please stick to that
> even though it is longer.
> 
> s/is_wzeroes/is_write_zeroes/
> s/wz_map_unmap/write_zeroes_may_unmap/
> s/virtio_blk_discard_wzeroes_complete/virtio_blk_discard_write_zeroes_complete/
> 
> This is a question of style and a local dwz_hdr variable does make the
> code easier to read, so I'm not totally against shortening the name, but
> please consistently use the long form in user-visible options, struct
> field names, and function names because these things have a large scope.
> 

Thanks! I'll change all the name.

> > @@ -765,6 +904,22 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
> >      blkcfg.alignment_offset = 0;
> >      blkcfg.wce = blk_enable_write_cache(s->blk);
> >      virtio_stw_p(vdev, &blkcfg.num_queues, s->conf.num_queues);
> > +    if (s->conf.discard_wzeroes) {
> > +        virtio_stl_p(vdev, &blkcfg.max_discard_sectors,
> > +                     s->conf.dwz_max_sectors);
> > +        virtio_stl_p(vdev, &blkcfg.discard_sector_alignment,
> > +                     blk_size >> BDRV_SECTOR_BITS);
> > +        virtio_stl_p(vdev, &blkcfg.max_write_zeroes_sectors,
> > +                     s->conf.dwz_max_sectors);
> > +        blkcfg.write_zeroes_may_unmap = s->conf.wz_may_unmap;
> 
> Does this need to be an option since MAY_UNMAP is advisory anyway?
> 
> Another way of asking: what happens in the worst case if the guest sends
> MAY_UNMAP but the QEMU block device doesn't support unmap?
> 
> Dropping this option would make the user interface simpler (no need to
> worry about the flag) and the implementation too.

Make sense, I'll drop this option.

Only a question about options: I used a single option "dwz_max_sectors"
for both "max_discard_sectors" and "max_write_zeroes_sectors".
Since I'll include two options to enable/disable discard and
write_zeroes features, do you think make sense to split this
configurable option in two?

Thanks,
Stefano
