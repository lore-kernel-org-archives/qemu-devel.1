Received: from eggs.gnu.org ([2001:4830:134:3::10]:60356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g85qm-00025P-UD
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g85qm-0006zz-7g
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:47:40 -0400
Date: Thu, 4 Oct 2018 17:47:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181004154723.GI6009@localhost.localdomain>
References: <1534844779-118784-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1534844779-118784-7-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534844779-118784-7-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v4 6/8] scsi: account unmap operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

Am 21.08.2018 um 11:46 hat Anton Nefedov geschrieben:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  hw/scsi/scsi-disk.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 9d10daf..0aac137 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -1664,6 +1664,10 @@ static void scsi_unmap_complete_noio(UnmapCBData *data, int ret)
>              goto done;
>          }
>  
> +        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
> +                         r->sector_count * s->qdev.blocksize,
> +                         BLOCK_ACCT_UNMAP);

If the check just above this (check_lba_range) fails, we should account
for an invalid request.

>          r->req.aiocb = blk_aio_pdiscard(s->qdev.conf.blk,
>                                          r->sector * s->qdev.blocksize,
>                                          r->sector_count * s->qdev.blocksize,
> @@ -1690,10 +1694,11 @@ static void scsi_unmap_complete(void *opaque, int ret)
>      r->req.aiocb = NULL;
>  
>      aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
> -    if (scsi_disk_req_check_error(r, ret, false)) {
> +    if (scsi_disk_req_check_error(r, ret, true)) {
>          scsi_req_unref(&r->req);
>          g_free(data);
>      } else {
> +        block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
>          scsi_unmap_complete_noio(data, ret);
>      }
>      aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
> @@ -1740,10 +1745,12 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
>      return;
>  
>  invalid_param_len:
> +    block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP);
>      scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
>      return;
>  
>  invalid_field:
> +    block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP);
>      scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
>  }

What about the blk_is_read_only() case which directly returns without
jumping to one of the error labels?

Kevin
