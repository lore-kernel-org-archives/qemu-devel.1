Received: from eggs.gnu.org ([2001:4830:134:3::10]:35741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dgKsf-0000TF-7h
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 21:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dgKsd-0005Jl-Vo
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 21:06:21 -0400
Date: Sat, 12 Aug 2017 09:06:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170812010609.GA13394@lemon.lan>
References: <20170811080939.22304-1-famz@redhat.com>
	<f508bf20-c60d-6947-eb54-727d9fa8d686@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f508bf20-c60d-6947-eb54-727d9fa8d686@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2] file-posix: Clear out first
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Fri, 08/11 09:42, Eric Blake wrote:
> On 08/11/2017 03:09 AM, Fam Zheng wrote:
> > People get surprised when, after "qemu-img create -f raw /dev/sdX", they
> > still see qcow2 with "qemu-img info", if previously the bdev had a qcow2
> > header. While this is natural because raw doesn't need to write any
> > magic bytes during creation, hdev_create is free to clear out the first
> > sector to make sure the stale qcow2 header doesn't cause such confusion.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > 
> > ---
> > 
> > v2: Use stack allocated buffer. [Eric]
> >     Fix return value.
> >     (Keep qemu_write_full instead of switching to qemu_pwritev because
> >     the former handles short writes.)
> >     Fix typo "qemu-img". [Changlong]
> > ---
> >  block/file-posix.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index f4de022ae0..a63bbf2b90 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -2703,6 +2703,16 @@ static int hdev_create(const char *filename, QemuOpts *opts,
> >          ret = -ENOSPC;
> >      }
> >  
> > +    if (total_size) {
> > +        uint8_t buf[BDRV_SECTOR_SIZE] = { 0 };
> > +        int64_t zero_size = MIN(BDRV_SECTOR_SIZE, total_size);
> > +        if (lseek(fd, 0, SEEK_SET) == -1) {
> > +            ret = -errno;
> > +        } else {
> > +            ret = qemu_write_full(fd, buf, zero_size);
> > +            ret = ret == zero_size ? 0 : -errno;
> > +        }
> > +    }
> 
> Question: are we ever constrained by O_DIRECT where writing only 512
> bytes would be too small for a block device that mandates 4k alignment?
> If so, then we need MAX(minimum write size, MIN(BDRV_SECTOR_SIZE,
> total_size)) - it would also mean we can't stack-allocate any more, but
> that we have to do an aligned buffer allocation (where g_malloc is not
> necessarily suitably aligned).
> 
> If O_DIRECT is not a problem, then this is okay:

A few lines above:


    fd = qemu_open(filename, O_WRONLY | O_BINARY);

so there is no O_DIRECT issue.

Fam
