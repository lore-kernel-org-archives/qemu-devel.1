Received: from eggs.gnu.org ([2001:4830:134:3::10]:57375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMXXJ-0002WP-Jc
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMXXI-0006ot-Ph
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:06:45 -0500
References: <20171206105309.3468-1-kwolf@redhat.com>
	<20171206105309.3468-6-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c5b6ef18-4f95-d528-4283-6b06341b5122@redhat.com>
Date: Wed, 6 Dec 2017 12:06:29 +0100
MIME-Version: 1.0
In-Reply-To: <20171206105309.3468-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] block: Don't wait for requests in
 bdrv_drain*_end()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On 06/12/2017 11:53, Kevin Wolf wrote:
> The device is drained, so there is no point in waiting for requests at
> the end of the drained section. Remove the bdrv_drain_recurse() calls
> there.
> 
> The bdrv_drain_recurse() calls were introduced in commit 481cad48e5e
> in order to call the the .bdrv_co_drain_end() driver callback. This is
> now done by a separate bdrv_drain_invoke() call.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 390d463c71..5fdb92a15e 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -299,7 +299,6 @@ void bdrv_drained_end(BlockDriverState *bs)
>  
>      bdrv_parent_drained_end(bs);
>      bdrv_drain_invoke(bs, false);
> -    bdrv_drain_recurse(bs);
>      aio_enable_external(bdrv_get_aio_context(bs));
>  }
>  
> @@ -400,7 +399,6 @@ void bdrv_drain_all_end(void)
>          aio_enable_external(aio_context);
>          bdrv_parent_drained_end(bs);
>          bdrv_drain_invoke(bs, false);
> -        bdrv_drain_recurse(bs);
>          aio_context_release(aio_context);
>      }
>  
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
