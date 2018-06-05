Received: from eggs.gnu.org ([2001:4830:134:3::10]:37038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fQCac-0003Ml-LH
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fQCaX-0004lo-Ss
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:05:34 -0400
Date: Tue, 5 Jun 2018 22:05:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180605140510.GH8708@lemon.usersys.redhat.com>
References: <20180605080710.27035-1-famz@redhat.com>
	<20180605080710.27035-3-famz@redhat.com>
	<20180605122229.GD13288@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605122229.GD13288@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] backup: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

On Tue, 06/05 13:22, Stefan Hajnoczi wrote:
> On Tue, Jun 05, 2018 at 04:07:10PM +0800, Fam Zheng wrote:
> > The implementation is similar to the 'qemu-img convert'. In the
> > beginning of the job, offloaded copy is attempted. If it fails, further
> > I/O will go through the existing bounce buffer code path.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Nice, this has become much more readable.
> 
> > +/* Copy range to target and return the bytes copied. If error occured, return a
> > + * negative error number. */
> > +static int backup_cow_with_offload(BackupBlockJob *job,
> 
> coroutine_fn

Will try to remember this better. :)

> 
> > +                                   int64_t start,
> > +                                   int64_t end,
> > +                                   bool is_write_notifier)
> > +{
> > +    int ret;
> > +    int nr_clusters;
> > +    BlockBackend *blk = job->common.blk;
> > +    int nbytes;
> > +
> > +    assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
> > +    nbytes = MIN(job->copy_range_size, end - start);
> > +    nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);
> > +    hbitmap_reset(job->copy_bitmap, start / job->cluster_size,
> > +                  nr_clusters);
> > +    ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
> > +                            is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
> > +    if (ret < 0) {
> > +        job->use_copy_range = false;
> 
> This is not necessary since backup_do_cow() also sets it to false.  This
> function doesn't need to know about job->use_copy_range.

Yes, will fix.

Fam
