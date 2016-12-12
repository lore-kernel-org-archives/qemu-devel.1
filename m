Received: from eggs.gnu.org ([2001:4830:134:3::10]:43169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cGPQw-0008LF-Gt
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cGPQv-0006EJ-C1
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:10:18 -0500
Date: Mon, 12 Dec 2016 13:10:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161212121004.GA8868@noname.redhat.com>
References: <cover.1481290956.git.berto@igalia.com>
	<20161209141823.GC3992@noname.redhat.com>
	<w51fulxw3k1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51fulxw3k1.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/1] Allow storing the qcow2 L2 cache
 in disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 09.12.2016 um 16:00 hat Alberto Garcia geschrieben:
> On Fri 09 Dec 2016 03:18:23 PM CET, Kevin Wolf wrote:
> >> I have been making some tests with exactly that scenario and the
> >> results look good: storing the cache in disk gives roughly the same
> >> performance as storing it in memory.
> >> 
> >> |---------------------+------------+------+------------+--------|
> >> |                     | Random 4k reads   | Sequential 4k reads |
> >> |                     | Throughput | IOPS | Throughput |  IOPS  |
> >> |---------------------+------------+------+------------+--------|
> >> | Cache in memory/SSD | 406 KB/s   |   99 | 84 MB/s    |  21000 |
> >> | Default cache (1MB) | 200 KB/s   |   60 | 83 MB/s    |  21000 |
> >> | No cache            | 200 KB/s   |   49 | 56 MB/s    |  14000 |
> >> |---------------------+------------+------+------------+--------|
> >> 
> >> I'm including the patch that I used to get these results. This is the
> >> simplest approach that I could think of.
> >> 
> >> Opinions, questions?
> >
> > I suppose you used the fact that the cache is now on disk to increase
> > the cache size so that it covers the whole image?
> 
> Right, the wording on the table is not clear, but that's what I did. I
> also don't think this makes much sense if the cache is not big enough to
> cover the whole image.
> 
> > If so, are you sure that you aren't just testing that accessing memory
> > in the kernel page cache is just as fast as accessing memory in qemu's
> > own cache? It seems this would just bypass the cache size limit given
> > to qemu by instead leaving things cached in the kernel where the limit
> > doesn't apply.
> 
> Fair question: what I checked is that the PSS/RSS values match the
> expected values (i.e, they don't grow as you read from the disk
> image). If the kernel is caching those pages so accessing them after
> MADV_DONTNEED does not require going to disk again is a possibility that
> I haven't ruled out.

This is what the man page says:

    Note that, when applied to shared mappings, MADV_DONTNEED might not
    lead to immediate freeing of the pages in the range.  The kernel is
    free to delay freeing the pages until an appropriate moment.  The
    resident set size (RSS) of the calling process will be immediately
    reduced however.

I think it makes sense that this is what is happening in your case. Your
patch uses MADV_DONTNEED after every single access, so even if you're
using an SSD, accessing it should be slower than accessing memory. This
means that at least for sequential I/O where cached tables are reused
all the time, your patch would have to be considerably slower than the
default cache.

Maybe try putting the image on some storage where you definitely notice
whether the kernel accesses it or not. Using a floppy should be fun, but
an NBD device connected to qemu-nbd with enabled throttling or tracing
could do the job as well.

Kevin
