Received: from eggs.gnu.org ([2001:4830:134:3::10]:36637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnPDV-00022t-Jx
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fnPDR-0007Mq-K2
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:13:37 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180808071051.30628-4-lbloch@janustech.com>
References: <20180808071051.30628-1-lbloch@janustech.com>
	<20180808071051.30628-4-lbloch@janustech.com>
Date: Wed, 08 Aug 2018 16:13:29 +0200
Message-ID: <w514lg5t08m.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/5] qcow2: Resize the cache upon image
 resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed 08 Aug 2018 09:10:49 AM CEST, Leonid Bloch wrote:
> The caches are now recalculated upon image resizing. This is done
> because the new default behavior of assigning a sufficient L2 cache to
> cover the entire image implies that the cache will still be sufficient
> after an image resizing.

This is related to what I mentioned in the previous patch. The default
behavior doesn't make the cache try to cover the entire image (or at
least it doesn't *extend* the cache, which is what I understand from
this paragraph). What it does is *reduce* the cache if the smaller
version is enough for the entire image.

> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>  block/qcow2.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 98cb96aaca..f60cb92169 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3639,6 +3639,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>          }
>      }
>  
> +    bs->total_sectors = offset / BDRV_SECTOR_SIZE;
> +
>      /* write updated header.size */
>      offset = cpu_to_be64(offset);
>      ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
> @@ -3649,6 +3651,12 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>      }
>  
>      s->l1_vm_state_index = new_l1_size;

You could add an empty line here for readability.

> +    /* Update cache sizes */
> +    QDict *options = qdict_clone_shallow(bs->options);

C99 allows variable declarations in the middle of a block, but we're
still doing it at the beginning (I don't know if there's a good reason
for this?).

Otherwise the patch looks good to me. Thanks!

Berto
