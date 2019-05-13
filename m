Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09A6C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60232070D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60232070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55465 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ9EC-00063F-2t
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:34:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hQ98Z-000250-S0
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hQ8tj-0003aZ-Kl
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:13:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hQ8tg-0003Z9-Pp; Mon, 13 May 2019 07:13:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4E24308FC22;
	Mon, 13 May 2019 11:13:31 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-130.ams2.redhat.com [10.36.117.130])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B4B363BAD;
	Mon, 13 May 2019 11:13:27 +0000 (UTC)
Date: Mon, 13 May 2019 13:13:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190513111321.GB19114@linux.fritz.box>
References: <20190510215212.8413-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510215212.8413-1-jsnow@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 13 May 2019 11:13:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] blockdev: fix missed target unref for
 drive-backup
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Max Reitz <mreitz@redhat.com>, aihua liang <aliang@redhat.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.05.2019 um 23:52 hat John Snow geschrieben:
> If the bitmap can't be used for whatever reason, we skip putting down
> the reference. Fix that.
> 
> In practice, this means that if you attempt to gracefully exit QEMU
> after a backup command being rejected, bdrv_close_all will fail and
> tell you some unpleasant things via assert().
> 
> Reported-by: aihua liang <aliang@redhat.com>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1703916
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 79fbac8450..278ecdd122 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3525,8 +3525,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
>      if (set_backing_hd) {
>          bdrv_set_backing_hd(target_bs, source, &local_err);
>          if (local_err) {
> -            bdrv_unref(target_bs);
> -            goto out;
> +            goto unref;
>          }
>      }
>  
> @@ -3534,11 +3533,10 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
>          bmap = bdrv_find_dirty_bitmap(bs, backup->bitmap);
>          if (!bmap) {
>              error_setg(errp, "Bitmap '%s' could not be found", backup->bitmap);
> -            bdrv_unref(target_bs);
> -            goto out;
> +            goto unref;
>          }
>          if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
> -            goto out;
> +            goto unref;
>          }
>      }
>      if (!backup->auto_finalize) {
> @@ -3552,12 +3550,12 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
>                              backup->sync, bmap, backup->compress,
>                              backup->on_source_error, backup->on_target_error,
>                              job_flags, NULL, NULL, txn, &local_err);
> -    bdrv_unref(target_bs);
>      if (local_err != NULL) {
>          error_propagate(errp, local_err);
> -        goto out;

Please leave a 'goto unref' here so we can later add more code without
modifying unrelated error paths (or, more likely, forgetting to modify
them).

>      }
>  
> +unref:
> +    bdrv_unref(target_bs);
>  out:
>      aio_context_release(aio_context);
>      return job;

With this fixed:
Reviewed-by: Kevin Wolf <kwolf@redhat.com>

