Received: from eggs.gnu.org ([2001:4830:134:3::10]:60784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr72n-0000uU-HJ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr72m-0002Z5-Kp
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 14:01:05 -0400
Date: Thu, 23 Mar 2017 19:00:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170323180054.GD5344@noname.redhat.com>
References: <20170308191434.2413-1-mreitz@redhat.com>
	<20170308191544.3025-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308191544.3025-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 3/4] block: Add errp to
 BD.bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Am 08.03.2017 um 20:15 hat Max Reitz geschrieben:
> Add an Error parameter to the block drivers' bdrv_truncate() interface.
> If a block driver does not set this in case of an error, the generic
> bdrv_truncate() implementation will do so.
> 
> Where it is obvious, this patch also makes some block drivers set this
> value.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> diff --git a/block/iscsi.c b/block/iscsi.c
> index 75d890538e..ab559a6f71 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2060,7 +2060,7 @@ static void iscsi_reopen_commit(BDRVReopenState *reopen_state)
>      }
>  }
>  
> -static int iscsi_truncate(BlockDriverState *bs, int64_t offset)
> +static int iscsi_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
>  {
>      IscsiLun *iscsilun = bs->opaque;
>      Error *local_err = NULL;
> @@ -2071,7 +2071,7 @@ static int iscsi_truncate(BlockDriverState *bs, int64_t offset)
>  
>      iscsi_readcapacity_sync(iscsilun, &local_err);
>      if (local_err != NULL) {
> -        error_free(local_err);
> +        error_propagate(errp, local_err);
>          return -EIO;
>      }

I think this function contains a few more cases for patch 4.

Kevin
