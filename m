Received: from eggs.gnu.org ([2001:4830:134:3::10]:59464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg4Mk-0003fB-GX
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dg4Mj-0002Xi-BL
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:28:18 -0400
Date: Fri, 11 Aug 2017 15:28:06 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170811072806.GA27391@lemon.lan>
References: <20170810080108.31047-1-famz@redhat.com>
	<f587d8ac-476d-e285-6579-3a8188de1790@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f587d8ac-476d-e285-6579-3a8188de1790@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10?] file-posix: Clear out first
 sector in hdev_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, 08/10 08:58, Eric Blake wrote:
> On 08/10/2017 03:01 AM, Fam Zheng wrote:
> > People get surprised when, after "qemu-imc create -f raw /dev/sdX", they
> > still see qcow2 with "qemu-img info", if previously the bdev had a qcow2
> > header. While this is natural because raw doesn't need to write any
> > magic bytes during creation, hdev_create is free to clear out the first
> > sector to make sure the stale qcow2 header doesn't cause such a
> > confusion.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/file-posix.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index f4de022ae0..1d8ef6f873 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -2703,6 +2703,17 @@ static int hdev_create(const char *filename, QemuOpts *opts,
> >          ret = -ENOSPC;
> >      }
> >  
> > +    if (total_size) {
> > +        int64_t zero_size = MIN(BDRV_SECTOR_SIZE, total_size);
> > +        uint8_t *buf;
> 
> Since BDRV_SECTOR_SIZE is small enough to stack-allocate, you could skip
> the malloc by doing:
> 
> uint8_t buf[BDRV_SECTOR_SIZE] = "";
> 
> > +        if (lseek(fd, 0, SEEK_SET) == -1) {
> > +            ret = -errno;
> > +        } else {
> > +            buf = g_malloc0(zero_size);
> > +            ret = qemu_write_full(fd, buf, zero_size);
> 
> Instead of doing lseek + qemu_write_full, can we just use
> qemu_pwritev(fd, &iov, 1, 0) with an iov set up to point to the
> appropriate amount of buf?

Neat, will update.

> 
> At any rate, my ideas are micro-optimizations, so I can also live with
> how you wrote it.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Are you arguing that this is a bug-fix worthy of inclusion in 2.10,
> because it helps avoid user confusion? Or are you delaying it to 2.11,
> because we've had the existing behavior for longer than one release, so
> one release more won't hurt?

IMO no need to rush for 2.10, it can wait for 2.11.

Thanks!

Fam
