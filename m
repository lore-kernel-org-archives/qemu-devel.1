Received: from eggs.gnu.org ([209.51.188.92]:39955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL6xl-00047f-Ba
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL6xk-0005Hy-3M
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:08:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hL6xj-0005Gl-R1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 10:08:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id c5so16248862wrs.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 07:08:55 -0700 (PDT)
Date: Mon, 29 Apr 2019 16:08:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190429140851.pgzieu4jr3jgdd4e@steredhat>
References: <20190427113625.46594-1-sgarzare@redhat.com>
	<CA+aFP1BtbjrzitLz7PW_b-kuYU7WSOiMs5jVfUBC=M3zEuBcew@mail.gmail.com>
	<20190429124712.mmxnpdkkbzhlbmxm@steredhat>
	<CA+aFP1Cmc+3TcYJr73jYRmtCWNTAWBcjEtn+Afe7DKZqUYp7=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aFP1Cmc+3TcYJr73jYRmtCWNTAWBcjEtn+Afe7DKZqUYp7=g@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/rbd: add preallocation
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dillaman@redhat.com
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Apr 29, 2019 at 09:00:26AM -0400, Jason Dillaman wrote:
> On Mon, Apr 29, 2019 at 8:47 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Sat, Apr 27, 2019 at 08:43:26AM -0400, Jason Dillaman wrote:
> > > On Sat, Apr 27, 2019 at 7:37 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > >
> > > > This patch adds the support of preallocation (off/full) for the RBD
> > > > block driver.
> > > > If available, we use rbd_writesame() to quickly fill the image when
> > > > full preallocation is required.
> > > >
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > >  block/rbd.c          | 149 ++++++++++++++++++++++++++++++++++++++-----
> > > >  qapi/block-core.json |   4 +-
> > > >  2 files changed, 136 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/block/rbd.c b/block/rbd.c
> > > > index 0c549c9935..29dd1bb040 100644
> > > > --- a/block/rbd.c
> > > > +++ b/block/rbd.c
> > > > @@ -13,6 +13,7 @@
> > > >
> > > >  #include "qemu/osdep.h"
> > > >
> > > > +#include "qemu/units.h"
> > > >  #include <rbd/librbd.h>
> > > >  #include "qapi/error.h"
> > > >  #include "qemu/error-report.h"
> > > > @@ -331,6 +332,110 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
> > > >      }
> > > >  }
> > > >
> > > > +static int qemu_rbd_do_truncate(rbd_image_t image, int64_t offset,
> > > > +                                PreallocMode prealloc, Error **errp)
> > > > +{
> > > > +    uint64_t current_length;
> > > > +    char *buf = NULL;
> > > > +    int ret;
> > > > +
> > > > +    ret = rbd_get_size(image, &current_length);
> > > > +    if (ret < 0) {
> > > > +        error_setg_errno(errp, -ret, "Failed to get file length");
> > > > +        goto out;
> > > > +    }
> > > > +
> > > > +    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
> > > > +        error_setg(errp, "Cannot use preallocation for shrinking files");
> > > > +        ret = -ENOTSUP;
> > > > +        goto out;
> > > > +    }
> > > > +
> > > > +    switch (prealloc) {
> > > > +    case PREALLOC_MODE_FULL: {
> > > > +        uint64_t current_offset = current_length;
> > > > +        int buf_size = 64 * KiB;
> > >
> > > This should probably be 512B or 4KiB (which is the smallest striped
> > > unit size). Not only will this avoid sending unnecessary zeroes to the
> > > backing cluster, writesame silently turns into a standard write if
> > > your buffer isn't properly aligned with the min(object size, stripe
> > > unit size).
> > >
> >
> > Okay, I'll change it on v2.
> > Should we query about the "stripe_unit" size or we simply use the
> > smallest allowed?
> 
> Technically we don't prevent a user from choosing terrible stripe unit
> sizes (e.g. 1 byte), so you are probably safe to just use 4KiB.
> 
> > > > +        ssize_t bytes;
> > > > +
> > > > +        buf = g_malloc(buf_size);
> > > > +        /*
> > > > +         * Some versions of rbd_writesame() discards writes of buffers with
> > > > +         * all zeroes. In order to avoid this behaviour, we set the first byte
> > > > +         * to one.
> > > > +         */
> > > > +        buf[0] = 1;
> > >
> > > You could also use "rados_conf_set(cluster,
> > > "rbd_discard_on_zeroed_write_same", "false").
> > >
> >
> > I tried it, but it is not supported on all versions. (eg. I have Ceph
> > v12.2.11 on my Fedora 29 and it is not supported, but rbd_writesame() is
> > available)
> >
> > Maybe we can use both: "rbd_discard_on_zeroed_write_same = false" and
> > "buf[0] = 1"
> 
> Probably not worth the effort if it's not supported across all releases.
> 
> > > > +        ret = rbd_resize(image, offset);
> > > > +        if (ret < 0) {
> > > > +            error_setg_errno(errp, -ret, "Failed to resize file");
> > > > +            goto out;
> > > > +        }
> > > > +
> > > > +#ifdef LIBRBD_SUPPORTS_WRITESAME
> > > > +        while (offset - current_offset > buf_size) {
> > > > +            /*
> > > > +             * rbd_writesame() supports only request where the size of the
> > > > +             * operation is multiple of buffer size and it must be less or
> > > > +             * equal to INT_MAX.
> > > > +             */
> > > > +            bytes = MIN(offset - current_offset, INT_MAX);
> > > > +            bytes -= bytes % buf_size;
> > >
> > > Using the default object size of 4MiB, this write size would result in
> > > up to 512 concurrent ops to the backing cluster. Perhaps the size
> > > should be bounded such that only a dozen or so concurrent requests are
> > > issued per write, always rounded next largest object / stripe period
> > > size. librbd and the rbd CLI usually try to bound themselves to the
> > > value in the "rbd_concurrent_management_ops" configuration setting
> > > (currently defaults to 10).
> > >
> >
> > Do you suggest to use "rbd_concurrent_management_ops" to limit
> > concurrent requests or use a new QEMU parameters for the RBD driver?
> 
> I think it would be nicer to just query the
> "rbd_concurrent_management_ops" limit to derive your writesame size
> since the Ceph cluster admin can globally set that option to match the
> available parallelism of the cluster.
> 

Thanks for the details, I'll send a v2 following yuor comments!

Stefano
