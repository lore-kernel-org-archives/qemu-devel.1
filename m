Received: from eggs.gnu.org ([2001:4830:134:3::10]:42623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVdT5-0001tW-Pr
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVdT2-0006LA-KV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:43:43 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVdT2-0006Kr-E1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:43:40 -0400
Received: by mail-wm0-f53.google.com with SMTP id f67so24664923wmh.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 05:43:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499949463-22531-1-git-send-email-kwolf@redhat.com>
References: <1499949463-22531-1-git-send-email-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 13:42:18 +0100
Message-ID: <CAFEAcA9dFNhaWqv2SAmtUHm5XN+Ar_kGg1EAcqkhwtrTvSBAqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vpc: Remove useless parameters in
 get_sector_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 13 July 2017 at 13:37, Kevin Wolf <kwolf@redhat.com> wrote:
> All callers of get_sector_offset() pass write=false and err=NULL. Remove
> the parameters.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
> Based on my block branch, specifically Peter's 'block/vpc.c: Handle write
> failures in get_image_offset()'
>
>  block/vpc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/block/vpc.c b/block/vpc.c
> index bccc981..471f9ab 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -508,10 +508,9 @@ static inline int64_t get_image_offset(BlockDriverState *bs, uint64_t offset,
>  }
>
>  static inline int64_t get_sector_offset(BlockDriverState *bs,
> -                                        int64_t sector_num, bool write,
> -                                        int *err)
> +                                        int64_t sector_num)
>  {
> -    return get_image_offset(bs, sector_num * BDRV_SECTOR_SIZE, write, err);
> +    return get_image_offset(bs, sector_num * BDRV_SECTOR_SIZE, false, NULL);
>  }
>
>  /*
> @@ -721,7 +720,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
>                 (sector_num << BDRV_SECTOR_BITS);
>      }
>
> -    offset = get_sector_offset(bs, sector_num, false, NULL);
> +    offset = get_sector_offset(bs, sector_num);
>      start = offset;
>      allocated = (offset != -1);
>      *pnum = 0;
> @@ -744,7 +743,7 @@ static int64_t coroutine_fn vpc_co_get_block_status(BlockDriverState *bs,
>          if (nb_sectors == 0) {
>              break;
>          }
> -        offset = get_sector_offset(bs, sector_num, false, NULL);
> +        offset = get_sector_offset(bs, sector_num);
>      } while (offset == -1);
>
>      return 0;

Just to copy my remark over from the other thread:
this turns a function that could be used for writes into a function
that doesn't look like it cares whether it's used for reads or
writes but which will actually silently cause disk image
corruption if you do ever use it in a write codepath. That's
a bit of a bear trap as API design goes, which is why I opted
to add the 'err' argument to get_image_offset() rather than
just removing the 'write' argument.

thanks
-- PMM
