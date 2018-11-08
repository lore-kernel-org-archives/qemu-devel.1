Received: from eggs.gnu.org ([2001:4830:134:3::10]:44069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKhdD-0004wV-GC
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKhdC-0000oW-Db
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:33:47 -0500
Date: Thu, 8 Nov 2018 11:33:34 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181108103334.GB6006@linux.fritz.box>
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-4-vsementsov@virtuozzo.com>
	<6e19aaeb-8acc-beb9-5ece-9ae6101637a9@redhat.com>
	<9aa2ee7b-2dcb-be00-5501-c616f5c5fda0@virtuozzo.com>
	<20181107181631.GC4721@linux.fritz.box>
	<df8e5a97-c79c-c8c2-6dd4-7373239d6601@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df8e5a97-c79c-c8c2-6dd4-7373239d6601@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow2: split out reading normal
 clusters from qcow2_co_preadv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Denis Lunev <den@virtuozzo.com>

Am 08.11.2018 um 11:02 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 07.11.2018 21:16, Kevin Wolf wrote:
> > (Broken quoting in text/plain again)
> >
> > Am 01.11.2018 um 13:17 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 27.09.2018 20:35, Max Reitz wrote:
> >>
> >>      On 07.08.18 19:43, Vladimir Sementsov-Ogievskiy wrote:
> >>
> >>          Memory allocation may become less efficient for encrypted case. It's a
> >>          payment for further asynchronous scheme.
> >>
> >>          Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>          ---
> >>           block/qcow2.c | 114 ++++++++++++++++++++++++++++++++--------------------------
> >>           1 file changed, 64 insertions(+), 50 deletions(-)
> >>
> >>          diff --git a/block/qcow2.c b/block/qcow2.c
> >>          index 65e3ca00e2..5e7f2ee318 100644
> >>          --- a/block/qcow2.c
> >>          +++ b/block/qcow2.c
> >>          @@ -1808,6 +1808,67 @@ out:
> >>               return ret;
> >>           }
> >>
> >>          +static coroutine_fn int qcow2_co_preadv_normal(BlockDriverState *bs,
> >>          +                                               uint64_t file_cluster_offset,
> >>          +                                               uint64_t offset,
> >>          +                                               uint64_t bytes,
> >>          +                                               QEMUIOVector *qiov,
> >>          +                                               uint64_t qiov_offset)
> >>          +{
> >>          +    int ret;
> >>          +    BDRVQcow2State *s = bs->opaque;
> >>          +    void *crypt_buf = NULL;
> >>          +    QEMUIOVector hd_qiov;
> >>          +    int offset_in_cluster = offset_into_cluster(s, offset);
> >>          +
> >>          +    if ((file_cluster_offset & 511) != 0) {
> >>          +        return -EIO;
> >>          +    }
> >>          +
> >>          +    qemu_iovec_init(&hd_qiov, qiov->niov);
> >>
> >>      So you're not just re-allocating the bounce buffer for every single
> >>      call, but also this I/O vector.  Hm.
> > And this one is actually at least a little more serious, I think.
> >
> > Decryption and decompression (including copying between the original
> > qiov and the bounce buffer) are already very slow, so allocating a
> > bounce buffer or not shouldn't make any noticable difference.
> >
> > But I'd like to keep allocations out of the fast path as much as we can.
> >
> >>          +    if (bs->encrypted) {
> >>          +        assert(s->crypto);
> >>          +        assert(bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
> >>          +
> >>          +        crypt_buf = qemu_try_blockalign(bs->file->bs, bytes);
> >>
> >>      1. Why did you remove the comment?
> >>
> >>      2. The check for whether crypt_buf was successfully allocated is missing.
> >>
> >>      3. Do you have any benchmarks for encrypted images?  Having to allocate
> >>      the bounce buffer for potentially every single cluster sounds rather bad
> >>      to me.
> > Actually, benchmarks for normal, fully allocated images would be a
> > little more interesting. Though I'm not sure if qcow2 actually performs
> > well enough that we'll see any difference even there (when we measured
> > memory allocation overhead etc. for raw images in the context of
> > comparing coroutines to AIO callback styes, the difference was already
> > hard to see).
> 
> Ok, I'll benchmark it and/or improve fast path (you mean code path, 
> where we skip coroutines creation, to handle the whole request at once, 
> yes?).

I had less the specific code path in mind, but the case of reading
unallocated clusters or reading/writing an already allocated area of
normal or zero clusters (no compression, no encrpytion, no other fancy
stuff). These are the cases that qcow2 images will hit the most in
practice.

> Hmm, all this staff with hd_qiov's in many places is due to we don't
> have qiov_offset parameter in .bdrv_co_preadv.. Is it a bad idea to
> add it?

I actually thought the same yesterday, though I'm not completely sure
yet about it. It makes the interfaces a bit uglier, but it could indeed
save us some work in the I/O path, so unless we find bigger reasons
against it, maybe we should do that.

> Anyway, I now think, it's better to start with decompress-threads 
> series, as compress-threads are already merged, then bring encryption to 
> threads too, and then return to these series. This way will remove some 
> questions about allocation, and may be it would be simpler and more 
> consistent to bring more things to coroutines, not only normal clusters.

Okay, we can do that.

Kevin
