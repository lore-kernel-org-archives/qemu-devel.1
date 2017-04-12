Received: from eggs.gnu.org ([2001:4830:134:3::10]:60848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyR0X-0003up-TJ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 18:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyR0W-0002mu-Sg
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 18:45:01 -0400
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-3-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a0162246-0285-c90c-71be-0e9c8ee28d15@redhat.com>
Date: Wed, 12 Apr 2017 18:44:50 -0400
MIME-Version: 1.0
In-Reply-To: <20170412174920.8744-3-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/12] migration: Don't lose errno across
 aio context changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 04/12/2017 01:49 PM, Eric Blake wrote:
> set_drity_tracking() was assuming that the errno value set by

*cough*

> bdrv_create_dirty_bitmap() would not be corrupted by either
> blk_get_aio_context() or aio_context_release().  Rather than
> audit whether this assumption is safe, rewrite the code to just
> grab the value of errno sooner.
> 
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  migration/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/block.c b/migration/block.c
> index 18d50ff..9a9c214 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -350,9 +350,9 @@ static int set_dirty_tracking(void)
>          aio_context_acquire(blk_get_aio_context(bmds->blk));
>          bmds->dirty_bitmap = bdrv_create_dirty_bitmap(blk_bs(bmds->blk),
>                                                        BLOCK_SIZE, NULL, NULL);
> +        ret = -errno;
>          aio_context_release(blk_get_aio_context(bmds->blk));
>          if (!bmds->dirty_bitmap) {
> -            ret = -errno;
>              goto fail;
>          }
>      }
> 

Reviewed-by: John Snow <jsnow@redhat.com>
