Received: from eggs.gnu.org ([2001:4830:134:3::10]:46178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1degut-0003XK-4g
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1deguo-0008UA-6Q
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:13:51 -0400
Date: Mon, 7 Aug 2017 08:13:33 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170807121333.GE1525@localhost.localdomain>
References: <cover.1502075213.git.jcody@redhat.com>
	<403586fbd705655c9e861b9e57648b598b651896.1502075213.git.jcody@redhat.com>
	<06087502-7d53-bc88-59a4-3a5f49426367@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06087502-7d53-bc88-59a4-3a5f49426367@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] block/vhdx: check for offset overflow
 to bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org

On Mon, Aug 07, 2017 at 06:24:30AM -0500, Eric Blake wrote:
> On 08/06/2017 10:08 PM, Jeff Cody wrote:
> > VHDX uses uint64_t types for most offsets, following the VHDX spec.
> > However, bdrv_truncate() takes an int64_t value for the truncating
> > offset.  Check for overflow before calling bdrv_truncate().
> > 
> > N.B.: For a compliant image this is not an issue, as the maximum VHDX
> > image size is defined per the spec to be 64TB.
> > 
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  block/vhdx-log.c | 4 ++++
> >  block/vhdx.c     | 3 +++
> >  2 files changed, 7 insertions(+)
> > 
> > diff --git a/block/vhdx-log.c b/block/vhdx-log.c
> > index fd4e7af..3b74e5d 100644
> > --- a/block/vhdx-log.c
> > +++ b/block/vhdx-log.c
> > @@ -554,6 +554,10 @@ static int vhdx_log_flush(BlockDriverState *bs, BDRVVHDXState *s,
> >              if (new_file_size % (1024*1024)) {
> >                  /* round up to nearest 1MB boundary */
> >                  new_file_size = ((new_file_size >> 20) + 1) << 20;
> 
> Since you're touching here, can you fix this to use QEMU_ALIGN_UP instead?
> 

Good idea, yes.

> > +                if (new_file_size > INT64_MAX) {
> > +                    ret = -EINVAL;
> > +                    goto exit;
> > +                }
> >                  bdrv_truncate(bs->file, new_file_size, PREALLOC_MODE_OFF, NULL);
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
