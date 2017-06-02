Received: from eggs.gnu.org ([2001:4830:134:3::10]:43104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGuZu-0007PF-7j
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGuZt-0006we-BU
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:57:54 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-13-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a57dbc46-f13a-3a75-8390-67bf8af5c9fe@redhat.com>
Date: Fri, 2 Jun 2017 17:57:40 -0400
MIME-Version: 1.0
In-Reply-To: <20170602112158.232757-13-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v20 12/30] block: refactor
 bdrv_reopen_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 06/02/2017 07:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add bs local variable to simplify code.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 50ba264143..04af7697dc 100644
> --- a/block.c
> +++ b/block.c
> @@ -2945,9 +2945,11 @@ error:
>  void bdrv_reopen_commit(BDRVReopenState *reopen_state)
>  {
>      BlockDriver *drv;
> +    BlockDriverState *bs;
>  
>      assert(reopen_state != NULL);
> -    drv = reopen_state->bs->drv;
> +    bs = reopen_state->bs;
> +    drv = bs->drv;
>      assert(drv != NULL);
>  
>      /* If there are any driver level actions to take */
> @@ -2956,13 +2958,13 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_state)
>      }
>  
>      /* set BDS specific flags now */
> -    QDECREF(reopen_state->bs->explicit_options);
> +    QDECREF(bs->explicit_options);
>  
> -    reopen_state->bs->explicit_options   = reopen_state->explicit_options;
> -    reopen_state->bs->open_flags         = reopen_state->flags;
> -    reopen_state->bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
> +    bs->explicit_options   = reopen_state->explicit_options;
> +    bs->open_flags         = reopen_state->flags;
> +    bs->read_only = !(reopen_state->flags & BDRV_O_RDWR);
>  
> -    bdrv_refresh_limits(reopen_state->bs, NULL);
> +    bdrv_refresh_limits(bs, NULL);
>  }
>  
>  /*
> 

It's not immediately obvious that this is safe (can reopen_commit change
reopen_state->bs ?) -- but it doesn't, so:

Reviewed-by: John Snow <jsnow@redhat.com>
