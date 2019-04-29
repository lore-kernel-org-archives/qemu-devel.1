Received: from eggs.gnu.org ([209.51.188.92]:39150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL6tV-0001VK-BW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL6tU-0000kQ-23
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hL6tT-0000jB-RF
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:04:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so16210064wra.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:04:31 -0700 (PDT)
Date: Mon, 29 Apr 2019 16:04:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190429140427.6tfpvdzza3io46g5@steredhat>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<20190429102510.GD8492@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429102510.GD8492@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block/rbd: increase dynamically
 the image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Josh Durgin <jdurgin@redhat.com>

On Mon, Apr 29, 2019 at 12:25:10PM +0200, Kevin Wolf wrote:
> Am 11.04.2019 um 12:50 hat Stefano Garzarella geschrieben:
> > RBD APIs don't allow us to write more than the size set with rbd_create()
> > or rbd_resize().
> > In order to support growing images (eg. qcow2), we resize the image
> > before RW operations that exceed the current size.
> > 
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1171007
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  block/rbd.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 0c549c9935..228658e20a 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -102,6 +102,7 @@ typedef struct BDRVRBDState {
> >      rbd_image_t image;
> >      char *image_name;
> >      char *snap;
> > +    uint64_t image_size;
> >  } BDRVRBDState;
> 
> Can't we use bs->total_sectors instead of adding a new image_size field?

I'm not sure we can use bs->total_sectors. IIUC, for example, it doesn't
take care of bytes used by QCOW2 metadata.

> 
> >  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> > @@ -777,6 +778,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
> >          goto failed_open;
> >      }
> >  
> > +    r = rbd_get_size(s->image, &s->image_size);
> > +    if (r < 0) {
> > +        error_setg_errno(errp, -r, "error reading image size from %s",
> > +                         s->image_name);
> > +        rbd_close(s->image);
> > +        goto failed_open;
> > +    }
> > +
> >      /* If we are using an rbd snapshot, we must be r/o, otherwise
> >       * leave as-is */
> >      if (s->snap != NULL) {
> > @@ -921,6 +930,20 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
> >          rcb->buf = acb->bounce;
> >      }
> >  
> > +    /*
> > +     * RBD APIs don't allow us to write more than actual size, so in order
> > +     * to support growing images, we resize the image before RW operations
> > +     * that exceed the current size.
> > +     */
> > +    if (s->image_size < off + size) {
> > +        r = rbd_resize(s->image, off + size);
> > +        if (r < 0) {
> > +            goto failed;
> > +        }
> > +
> > +        s->image_size = off + size;
> > +    }
> 
> This doesn't check the request type, so it's actually not limited to RW
> operations, but even reads will try to resize the image. This is at
> least surprising. For regular files, file-posix extends the file for
> write requests, but for reads it returns a zeroed buffer without
> actually changing the file size.

Yes, I'll change the behaviour in the v2.

I did some tries (i.e. using qemu-io and reading more than bytes used) and
the RBD driver didn't receive 'read' requests that exceed the current
size, maybe because it is managed in the QCOW2 protocol, but of course
I'll handle also in the RBD driver.

Thanks,
Stefano
