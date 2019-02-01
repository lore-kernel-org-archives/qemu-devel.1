Received: from eggs.gnu.org ([209.51.188.92]:49414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpcO1-00058D-Cq
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:13:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpcO0-0000aF-Ib
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:13:53 -0500
Date: Fri, 1 Feb 2019 18:13:40 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190201171340.GA31750@localhost.localdomain>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-2-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548942405-760115-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v11 1/3] bdrv_query_image_info Error
 parameter added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Am 31.01.2019 um 14:46 hat Andrey Shinkevich geschrieben:
> Inform a user in case qcow2_get_specific_info fails to obtain
> QCOW2 image specific information. This patch is preliminary to
> the print of bitmap information in the 'qemu-img info' output.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/crypto.c b/block/crypto.c
> index f0a5f6b..4ede833 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -594,13 +594,13 @@ static int block_crypto_get_info_luks(BlockDriverState *bs,
>  }
>  
>  static ImageInfoSpecific *
> -block_crypto_get_specific_info_luks(BlockDriverState *bs)
> +block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
>  {
>      BlockCrypto *crypto = bs->opaque;
>      ImageInfoSpecific *spec_info;
>      QCryptoBlockInfo *info;
>  
> -    info = qcrypto_block_get_info(crypto->block, NULL);
> +    info = qcrypto_block_get_info(crypto->block, errp);
>      if (!info) {
>          return NULL;
>      }

In v9 of the series I suggested to have another patch to remove errp
from qcrypto_block_get_info() because it never returns errors anyway.

Don't you think that would be better? But it's your decision, I'm fine
with either way.

> diff --git a/block/qapi.c b/block/qapi.c
> index c66f949..f53f100 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -282,7 +282,12 @@ void bdrv_query_image_info(BlockDriverState *bs,
>          info->dirty_flag = bdi.is_dirty;
>          info->has_dirty_flag = true;
>      }
> -    info->format_specific     = bdrv_get_specific_info(bs);
> +    info->format_specific     = bdrv_get_specific_info(bs, &err);

The spacing looks odd now. I'd either keep the assignment for
info->has_format_specific above the if block so that both are aligned to
the same column, or remove the additional spaces.

With that fixed:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
