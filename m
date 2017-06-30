Received: from eggs.gnu.org ([2001:4830:134:3::10]:33324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR2st-0005Ma-C6
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 16:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dR2sr-0006aO-Rs
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 16:51:23 -0400
Date: Fri, 30 Jun 2017 16:51:11 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170630205111.GI4997@localhost.localdomain>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-10-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-10-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/20] mirror: Update signature of
 mirror_clip_sectors()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, jsnow@redhat.com, Max Reitz <mreitz@redhat.com>

On Tue, Jun 27, 2017 at 02:24:47PM -0500, Eric Blake wrote:
> Rather than having a void function that modifies its input
> in-place as the output, change the signature to reduce a layer
> of indirection and return the result.
> 
> Suggested-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
> v2: new patch
> ---
>  block/mirror.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index af27bcc..1a43304 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -176,12 +176,12 @@ static void mirror_read_complete(void *opaque, int ret)
>      aio_context_release(blk_get_aio_context(s->common.blk));
>  }
> 
> -static inline void mirror_clip_sectors(MirrorBlockJob *s,
> -                                       int64_t sector_num,
> -                                       int *nb_sectors)
> +static inline int mirror_clip_sectors(MirrorBlockJob *s,
> +                                      int64_t sector_num,
> +                                      int nb_sectors)
>  {
> -    *nb_sectors = MIN(*nb_sectors,
> -                      s->bdev_length / BDRV_SECTOR_SIZE - sector_num);
> +    return MIN(nb_sectors,
> +               s->bdev_length / BDRV_SECTOR_SIZE - sector_num);
>  }
> 
>  /* Round sector_num and/or nb_sectors to target cluster if COW is needed, and
> @@ -216,7 +216,8 @@ static int mirror_cow_align(MirrorBlockJob *s,
>      }
>      /* Clipping may result in align_nb_sectors unaligned to chunk boundary, but
>       * that doesn't matter because it's already the end of source image. */
> -    mirror_clip_sectors(s, align_sector_num, &align_nb_sectors);
> +    align_nb_sectors = mirror_clip_sectors(s, align_sector_num,
> +                                           align_nb_sectors);
> 
>      ret = align_sector_num + align_nb_sectors - (*sector_num + *nb_sectors);
>      *sector_num = align_sector_num;
> @@ -445,7 +446,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
>              return 0;
>          }
> 
> -        mirror_clip_sectors(s, sector_num, &io_sectors);
> +        io_sectors = mirror_clip_sectors(s, sector_num, io_sectors);
>          switch (mirror_method) {
>          case MIRROR_METHOD_COPY:
>              io_sectors = mirror_do_read(s, sector_num, io_sectors);
> -- 
> 2.9.4
> 
