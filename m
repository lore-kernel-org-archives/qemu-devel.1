Received: from eggs.gnu.org ([2001:4830:134:3::10]:54742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHKt-0004aS-Tf
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZHKt-0001dM-0W
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:26:35 -0500
References: <1515425247-21730-1-git-send-email-pl@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bc20ba7f-49e7-97a2-60b5-7394664c6cd1@redhat.com>
Date: Wed, 10 Jan 2018 15:26:04 +0100
MIME-Version: 1.0
In-Reply-To: <1515425247-21730-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/iscsi: fix initialization of iTask
 in iscsi_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, ronniesahlberg@gmail.com, famz@redhat.com, eblake@redhat.com, qemu-stable@nongnu.org

On 08/01/2018 16:27, Peter Lieven wrote:
> in case of unaligned requests or on a target that does not support
> block provisioning we leave iTask uninitialized and check iTask.task
> for NULL later.
> 
> Fixes: e38bc23454ef763deb4405ebdee6a1081aa00bc8
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/iscsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 5c0a9e5..6a1c537 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -658,6 +658,8 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
>      uint64_t lba;
>      int64_t ret;
>  
> +    iscsi_co_init_iscsitask(iscsilun, &iTask);
> +
>      if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
>          ret = -EINVAL;
>          goto out;
> @@ -675,7 +677,6 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
>  
>      lba = sector_qemu2lun(sector_num, iscsilun);
>  
> -    iscsi_co_init_iscsitask(iscsilun, &iTask);
>      qemu_mutex_lock(&iscsilun->mutex);
>  retry:
>      if (iscsi_get_lba_status_task(iscsilun->iscsi, iscsilun->lun,
> 

Queued (removing Cc qemu-stable), thanks.

Paolo
