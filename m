Received: from eggs.gnu.org ([209.51.188.92]:45522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMX1b-0002Yx-0G
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hMX1a-0005am-0M
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:10:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hMX1Z-0005Zt-QM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:10:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id e9so7622120wrc.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:10:45 -0700 (PDT)
Date: Fri, 3 May 2019 14:10:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190503121041.xjmg6yygfujohqod@steredhat>
References: <20190503110206.42811-1-sgarzare@redhat.com>
	<CA+aFP1DBc_NdswPJLGGHq3H-uU+LqXON7SLQ16K3H3jAt_02HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aFP1DBc_NdswPJLGGHq3H-uU+LqXON7SLQ16K3H3jAt_02HQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] block/rbd: implement
 .bdrv_get_allocated_file_size callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dillaman@redhat.com
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, qemu-block <qemu-block@nongnu.org>

On Fri, May 03, 2019 at 07:55:01AM -0400, Jason Dillaman wrote:
> On Fri, May 3, 2019 at 7:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > This patch allows 'qemu-img info' to show the 'disk size' for
> > rbd images. We use the rbd_diff_iterate2() API to calculate the
> > allocated size for the image.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  block/rbd.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 0c549c9935..61447bc0cb 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -1046,6 +1046,38 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
> >      return info.size;
> >  }
> >
> > +static int rbd_allocated_size_cb(uint64_t offset, size_t len, int exists,
> > +                                 void *arg)
> > +{
> > +    int64_t *alloc_size = (int64_t *) arg;
> > +
> > +    if (exists) {
> > +        (*alloc_size) += len;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *bs)
> > +{
> > +    BDRVRBDState *s = bs->opaque;
> > +    int64_t alloc_size = 0;
> > +    int r;
> > +
> > +    /*
> > +     * rbd_diff_iterate2(), if the source snapshot name is NULL, invokes
> > +     * the callback on all allocated regions of the image.
> > +     */
> > +    r = rbd_diff_iterate2(s->image, NULL, 0,
> > +                          bs->total_sectors * BDRV_SECTOR_SIZE, 0, 1,
> > +                          &rbd_allocated_size_cb, &alloc_size);
> 
> Is there any concern that running this on very large images will take
> a very long time since it needs to iterate through each individual
> 4MiB (by default) backing object in the image? In libvirt, it only
> attempts to calculate the actual usage if the fast-diff feature is
> enabled, and recently it also got a new control to optionally disable
> the functionality entirely since even with fast-diff it's can be very
> slow to compute over hundreds of images in a libvirt storage pool.
> 

Thank you for pointing that out to me. I'll add check on fast-diff feature
on v2.
Since we only have one image here, do you think it would be reasonable to add
this feature or is it useless?

Thanks,
Stefano
