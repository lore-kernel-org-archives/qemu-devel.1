Received: from eggs.gnu.org ([2001:4830:134:3::10]:40984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0rpU-0006Ca-Vh
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g0rpU-0003Ju-1i
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 13:24:28 -0400
References: <20180914165116.23182-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05b6e954-744f-d52c-1f5e-51d52062e195@redhat.com>
Date: Fri, 14 Sep 2018 12:24:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180914165116.23182-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: fix bitmap export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>

On 9/14/18 11:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> bitmap_to_extents function is broken: it switches dirty variable after
> every iteration, however it can process only part of dirty (or zero)
> area during one iteration in case when this area is too large for one
> extent.
> 
> Fortunately, the bug don't produce wrong extents: it just inserts
> zero-length extents between sequential extents representing large dirty
> (or zero) area. However, zero-length extents are abandoned by NBD

s/abandoned by/forbidden by the/

> protocol. So, careful client should consider such replay as server

s/replay/reply/

> fault and not-careful will likely ignore zero-length extents.

Which camp is qemu 3.0 as client in? Does it tolerate the zero-length 
extent, and still manage to see correct information overall, or does it 
crash?

Hmm - I think we're "safe" with qemu as client - right now, the only way 
qemu 3.0 accesses the qemu dirty bitmap over NBD is with my 
x-dirty-bitmap hack (commit 216ee3657), which uses 
block/nbd-client.c:nbd_client_co_block_status() to read the bitmap, and 
that always passes NBD_CMD_FLAG_REQ_ONE.  qemu will assert() if 
nbd_client_co_block_status() doesn't make any progress, but from what 
I'm reading of your bug report, qemu as client never permits the server 
to answer with more than one extent, and the bug of a zero-length extent 
is triggered only after the first extent has been sent.

Thus, the primary reason to accept this patch is not because of qemu 3.0 
as client, but for interoperability with other clients.  I'm planning on 
updating the commit message to add these additional details.

> 
> Fix this by more careful handling of dirty variable.
> 
> Bug was introduced in 3d068aff16
>   "nbd/server: implement dirty bitmap export", with the whole function.
> and presents in v3.0.0 release.

s/presents/present/

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

CC: qemu-stable@nongnu.org

> ---
>   nbd/server.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index ea5fe0eb33..12f721482d 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1951,6 +1951,8 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>   
>       assert(begin < overall_end && nb_extents);
>       while (begin < overall_end && i < nb_extents) {
> +        bool next_dirty = !dirty;
> +
>           if (dirty) {
>               end = bdrv_dirty_bitmap_next_zero(bitmap, begin);
>           } else {
> @@ -1962,6 +1964,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>               end = MIN(bdrv_dirty_bitmap_size(bitmap),
>                         begin + UINT32_MAX + 1 -
>                         bdrv_dirty_bitmap_granularity(bitmap));
> +            next_dirty = dirty;
>           }

Rather than introducing next_dirty, couldn't you just make this:

if (end == -1 || end - begin > UINT32_MAX) {
     /* Cap ... */
     end = MIN(...);
} else {
     dirty = !dirty;
}

>           if (dont_fragment && end > overall_end) {
>               end = overall_end;
> @@ -1971,7 +1974,7 @@ static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>           extents[i].flags = cpu_to_be32(dirty ? NBD_STATE_DIRTY : 0);
>           i++;
>           begin = end;
> -        dirty = !dirty;
> +        dirty = next_dirty;
>       }

and then you merely delete the assignment to 'dirty' here.

>   
>       bdrv_dirty_iter_free(it);
> 

At any rate, the fix makes sense to me.  Should I go ahead and 
incorporate the changes I've suggested and turn it into a pull request 
through my NBD tree, or would you like to send a v2?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
