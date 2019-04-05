Received: from eggs.gnu.org ([209.51.188.92]:46128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hCXsL-0007kA-Q3
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hCXf3-0007Kb-8m
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 18:50:14 -0400
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ad53e61a-a911-c019-3f68-2bd05b7be944@redhat.com>
Date: Fri, 5 Apr 2019 18:50:03 -0400
MIME-Version: 1.0
In-Reply-To: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/io.c: fix for the
 allocation failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org



On 4/5/19 10:24 AM, Andrey Shinkevich wrote:
> On a file system used by the customer, fallocate() returns an error
> if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
> fails. We can handle that case the same way as it is done for the
> unsupported cases, namely, call to bdrv_driver_pwritev() that writes
> zeroes to an image for the unaligned chunk of the block.
> 
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/io.c b/block/io.c
> index dfc153b..0412a51 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1516,7 +1516,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>              assert(!bs->supported_zero_flags);
>          }
>  
> -        if (ret == -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
> +        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
>              /* Fall back to bounce buffer if write zeroes is unsupported */
>              BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
>  
> 

I suppose that if fallocate fails for any reason and we're allowing
fallback, we're either going to succeed ... or fail again very soon
thereafter.

Are there any cases where it is vital to not ignore the first fallocate
failure? I'm a little wary of ignoring the return code from
bdrv_co_pwrite_zeroes, but I am assuming that if there is a "real"
failure here that the following bounce writes will also fail "safely."

I'm not completely confident, but I have no tangible objections:
Reviewed-by: John Snow <jsnow@redhat.com>
