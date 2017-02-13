Received: from eggs.gnu.org ([2001:4830:134:3::10]:59720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cd9Vc-0007pB-Qo
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 00:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cd9Vb-0006rV-9v
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 00:49:08 -0500
Date: Mon, 13 Feb 2017 13:48:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170213054857.GB15004@lemon.lan>
References: <1486051604-32310-1-git-send-email-pl@kamp.de>
	<283ed47f-1252-bbde-6c2b-9476adec04a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283ed47f-1252-bbde-6c2b-9476adec04a3@redhat.com>
Subject: Re: [Qemu-devel] [RFC][PATCH] qemu-img: make convert async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

On Sun, 02/12 03:06, Max Reitz wrote:
> On 02.02.2017 17:06, Peter Lieven wrote:
> > this is something I have been thinking about for almost 2 years now.
> > we heavily have the following two use cases when using qemu-img convert.
> > 
> > a) reading from NFS and writing to iSCSI for deploying templates
> > b) reading from iSCSI and writing to NFS for backups
> > 
> > In both processes we use libiscsi and libnfs so we have no kernel pagecache.
> > As qemu-img convert is implemented with sync operations that means we
> > read one buffer and then write it. No parallelism and each sync request
> > takes as long as it takes until it is completed.
> > 
> > What I put together is an approach to use aio routines for the conversion
> > process to have ideally read and write happening in parallel.
> > 
> > The code is far from clean or complete, but I would appreaciate comments
> > and thoughts from you.
> > 
> > So far I have the following runtimes when reading an uncompressed QCOW2 from
> > NFS and writing it to iSCSI (raw):
> > 
> > qemu-img (master)
> >  nfs -> iscsi 33 secs
> >  nfs -> ram   19 secs
> >  ram -> iscsi 14 secs
> > 
> > qemu-img-async
> >  nfs -> iscsi 23 secs
> >  nfs -> ram   17 secs
> >  ram -> iscsi 14 secs
> > 
> > Its visible that on master the runtimes add up as expected. The async branch
> > is faster, but not as fast as I would have expected. I would expect the runtime
> > to be as slow as the slowest of the two involved transfers.
> > 
> > Thank you,
> > Peter
> > 
> > Signed-off-by: Peter Lieven <pl@kamp.de>
> > ---
> >  qemu-img.c | 271 +++++++++++++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 199 insertions(+), 72 deletions(-)
> 
> Asynchronous convert sounds good. But your implementation looks a bit
> weird to me.
> 
> Your implementation has four "slots" which receive work from a central
> work queue that they then process. You can do that, but it looks
> counter-intuitive to me. (Or if you do that, I would do it using
> coroutines: Start up four coroutines that simply submit blk_co_* requests.)
> 
> What I would have done (if using AIO) is the following: Seek through the
> image, finding the next bit of work to do (without having a central work
> queue). Then submit an AIO request with a newly allocated piece of data
> (not using fixed slots). Continue until four requests are in flight,
> then wait until one is settled.
> 
> I think this would simplify the design. Also, it's basically what the
> mirror block job does.
> 
> Which brings me to a totally different point: At some point we intended
> to convert as many qemu-img functions to block jobs as possible.
> Unfortunately, we only ever did one and that's commit. If we were to
> convert convert to mirror, then we'd get async for free.
> 
> But the effort of converting convert to mirror is probably much larger
> than adding async to convert...

My 2 cents.

In the long run it still seems to me as a worthwhile deal. Now we know it will
have a useful advantage by bringing in async, maybe it's a good time to do it!

Related, I have had the feeling that block jobs can be cleaned up too: backup,
commit, stream can all reuse mirror code to achieve the "async" feature that
Vladmir is proposing, in an AIO way which is more resource friendly than
coroutine worker pool.

Fam
