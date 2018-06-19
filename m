Received: from eggs.gnu.org ([2001:4830:134:3::10]:54522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLfW-0007nW-Sk
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLfW-0000Em-06
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:47:54 -0400
References: <20180619183457.371081-1-vsementsov@virtuozzo.com>
	<20180619183457.371081-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4532790c-1f02-dad8-bc2a-9347a77429c2@redhat.com>
Date: Tue, 19 Jun 2018 13:47:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180619183457.371081-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] block/qcow2-refcount: avoid eating RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On 06/19/2018 01:34 PM, Vladimir Sementsov-Ogievskiy wrote:
> qcow2_inc_refcounts_imrt() (through realloc_refcount_array()) can eat
> unpredicted amount of memory on corrupted table entries, which are

s/unpredicted/an unpredictable/

> referencing regions far beyond the end of file.
> 
> Prevent this, by skipping such regions from further processing.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2-refcount.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index f9d095aa2d..28d21bedc3 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1505,6 +1505,14 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
>           return 0;
>       }
>   
> +    if (offset + size - bdrv_getlength(bs->file->bs) > s->cluster_size) {

bdrv_getlength() can fail (returning a negative value); this needs to be 
refactored so that you aren't performing arithmetic comparisons after 
such a failure (even if that failure is unlikely).

> +        fprintf(stderr, "ERROR: counting reference for region exceeding the "
> +                "end of the file by more than one cluster: offset 0x%" PRIx64
> +                " size 0x%" PRIx64 "\n", offset, size);

Why is this dumping directly to stderr?

/me reads the file

Oh.  We probably ought to fix the code to pass an Error **errp parameter 
through the callstack, but that's a bigger audit (and not the fault of 
your patch for copying existing usage).

> +        res->corruptions++;
> +        return 0;
> +    }
> +
>       start = start_of_cluster(s, offset);
>       last = start_of_cluster(s, offset + size - 1);
>       for(cluster_offset = start; cluster_offset <= last;
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
