Received: from eggs.gnu.org ([2001:4830:134:3::10]:36059)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1eYXLY-0000Lf-99
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1eYXLU-0001F0-3s
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:20:12 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:51801 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1eYXLT-0001E7-Qb
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 08:20:08 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Mon, 8 Jan 2018 14:20:01 +0100
References: <20180108030946.14991-1-famz@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <30369c9b-974f-67d4-322f-00d30a25519a@kamp.de>
Date: Mon, 8 Jan 2018 14:20:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180108030946.14991-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't check uninitialized local
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

Am 08.01.2018 um 04:09 schrieb Fam Zheng:
> After the out label there is a check on iTask.task but it is not
> initialized yet.
>
> Fixes: e38bc23454ef763deb4405ebdee6a1081aa00bc8
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   block/iscsi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/block/iscsi.c b/block/iscsi.c
> index 5c0a9e55b6..1cb8cc93c5 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -659,8 +659,7 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
>       int64_t ret;
>   
>       if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
> -        ret = -EINVAL;
> -        goto out;
> +        return -EINVAL;
>       }
>   
>       /* default to all sectors allocated */

If lbpme is 0 we run into the same error. And this is even more likely than an unaligned request.

I think the right patch is to move the init of iTask up again where it was:


diff --git a/block/iscsi.c b/block/iscsi.c
index 5c0a9e5..6a1c537 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -658,6 +658,8 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,
      uint64_t lba;
      int64_t ret;

+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+
      if (!is_sector_request_lun_aligned(sector_num, nb_sectors, iscsilun)) {
          ret = -EINVAL;
          goto out;
@@ -675,7 +677,6 @@ static int64_t coroutine_fn iscsi_co_get_block_status(BlockDriverState *bs,

      lba = sector_qemu2lun(sector_num, iscsilun);

-    iscsi_co_init_iscsitask(iscsilun, &iTask);
      qemu_mutex_lock(&iscsilun->mutex);
  retry:
      if (iscsi_get_lba_status_task(iscsilun->iscsi, iscsilun->lun,


Peter




-- 

Mit freundlichen Grüßen

Peter Lieven

...........................................................

   KAMP Netzwerkdienste GmbH
   Vestische Str. 89-91 | 46117 Oberhausen
   Tel: +49 (0) 208.89 402-50 | Fax: +49 (0) 208.89 402-40
   pl@kamp.de | http://www.kamp.de

   Geschäftsführer: Heiner Lante | Michael Lante
   Amtsgericht Duisburg | HRB Nr. 12154
   USt-Id-Nr.: DE 120607556

...........................................................
