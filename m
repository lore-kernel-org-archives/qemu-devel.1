Received: from eggs.gnu.org ([2001:4830:134:3::10]:36746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKSSS-0001st-U0
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKSNh-0002Qy-1l
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 13:16:45 -0500
Date: Wed, 7 Nov 2018 19:16:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181107181631.GC4721@linux.fritz.box>
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-4-vsementsov@virtuozzo.com>
	<6e19aaeb-8acc-beb9-5ece-9ae6101637a9@redhat.com>
	<9aa2ee7b-2dcb-be00-5501-c616f5c5fda0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9aa2ee7b-2dcb-be00-5501-c616f5c5fda0@virtuozzo.com>
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

(Broken quoting in text/plain again)

Am 01.11.2018 um 13:17 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 27.09.2018 20:35, Max Reitz wrote:
> 
>     On 07.08.18 19:43, Vladimir Sementsov-Ogievskiy wrote:
> 
>         Memory allocation may become less efficient for encrypted case. It's a
>         payment for further asynchronous scheme.
> 
>         Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>         ---
>          block/qcow2.c | 114 ++++++++++++++++++++++++++++++++--------------------------
>          1 file changed, 64 insertions(+), 50 deletions(-)
> 
>         diff --git a/block/qcow2.c b/block/qcow2.c
>         index 65e3ca00e2..5e7f2ee318 100644
>         --- a/block/qcow2.c
>         +++ b/block/qcow2.c
>         @@ -1808,6 +1808,67 @@ out:
>              return ret;
>          }
> 
>         +static coroutine_fn int qcow2_co_preadv_normal(BlockDriverState *bs,
>         +                                               uint64_t file_cluster_offset,
>         +                                               uint64_t offset,
>         +                                               uint64_t bytes,
>         +                                               QEMUIOVector *qiov,
>         +                                               uint64_t qiov_offset)
>         +{
>         +    int ret;
>         +    BDRVQcow2State *s = bs->opaque;
>         +    void *crypt_buf = NULL;
>         +    QEMUIOVector hd_qiov;
>         +    int offset_in_cluster = offset_into_cluster(s, offset);
>         +
>         +    if ((file_cluster_offset & 511) != 0) {
>         +        return -EIO;
>         +    }
>         +
>         +    qemu_iovec_init(&hd_qiov, qiov->niov);
> 
>     So you're not just re-allocating the bounce buffer for every single
>     call, but also this I/O vector.  Hm.

And this one is actually at least a little more serious, I think.

Decryption and decompression (including copying between the original
qiov and the bounce buffer) are already very slow, so allocating a
bounce buffer or not shouldn't make any noticable difference.

But I'd like to keep allocations out of the fast path as much as we can.

>         +    if (bs->encrypted) {
>         +        assert(s->crypto);
>         +        assert(bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
>         +
>         +        crypt_buf = qemu_try_blockalign(bs->file->bs, bytes);
> 
>     1. Why did you remove the comment?
> 
>     2. The check for whether crypt_buf was successfully allocated is missing.
> 
>     3. Do you have any benchmarks for encrypted images?  Having to allocate
>     the bounce buffer for potentially every single cluster sounds rather bad
>     to me.

Actually, benchmarks for normal, fully allocated images would be a
little more interesting. Though I'm not sure if qcow2 actually performs
well enough that we'll see any difference even there (when we measured
memory allocation overhead etc. for raw images in the context of
comparing coroutines to AIO callback styes, the difference was already
hard to see).

Kevin
