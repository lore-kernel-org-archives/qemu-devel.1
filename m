Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE65C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 21:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197E020665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 21:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197E020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAh3q-00063R-9O
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 17:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgw0-0006HI-M3
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgvz-0008N9-9F
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iAgvw-0008Lu-4U; Wed, 18 Sep 2019 16:52:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 713E23082E55;
 Wed, 18 Sep 2019 20:52:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5195B1001281;
 Wed, 18 Sep 2019 20:52:11 +0000 (UTC)
Message-ID: <0cda25dcff5e74358c304111fd31e3c9859d1a52.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 23:52:09 +0300
In-Reply-To: <20190918095144.955-8-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
 <20190918095144.955-8-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 18 Sep 2019 20:52:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 7/8] block: Pass truncate exact=true where
 reasonable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-09-18 at 11:51 +0200, Max Reitz wrote:
> This is a change in behavior, so all instances need a good
> justification.  The comments added here should explain my reasoning.
> 
> qed already had a comment that suggests it always expected
> bdrv_truncate()/blk_truncate() to behave as if exact=true were passed
> (c743849bee7 came eight months before 55b949c8476), so it was simply
> broken until now.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/parallels.c | 11 +++++++++--
>  block/qcow2.c     |  6 +++++-
>  block/qed.c       |  2 +-
>  qemu-img.c        |  7 ++++++-
>  qemu-io-cmds.c    |  7 ++++++-
>  5 files changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index a1a92c97a4..603211f83c 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -487,7 +487,12 @@ static int coroutine_fn parallels_co_check(BlockDriverState *bs,
>          res->leaks += count;
>          if (fix & BDRV_FIX_LEAKS) {
>              Error *local_err = NULL;
> -            ret = bdrv_truncate(bs->file, res->image_end_offset, false,
> +
> +            /*
> +             * In order to really repair the image, we must shrink it.
> +             * That means we have to pass exact=true.
> +             */
> +            ret = bdrv_truncate(bs->file, res->image_end_offset, true,
>                                  PREALLOC_MODE_OFF, &local_err);

I am not familiar with the parallels format, but in theory,
a partial fix is better that nothing.

>              if (ret < 0) {
>                  error_report_err(local_err);
> @@ -880,7 +885,9 @@ static void parallels_close(BlockDriverState *bs)
>      if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
>          s->header->inuse = 0;
>          parallels_update_header(bs);
> -        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, false,
> +
> +        /* errors are ignored, so we might as well pass exact=true */
> +        bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
>                        PREALLOC_MODE_OFF, NULL);
Fair enough.

>      }
>  
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 4ef19dd29a..eba165de7f 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5057,7 +5057,11 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
>              return ret;
>          }
>  
> -        ret = blk_truncate(blk, new_size, false, PREALLOC_MODE_OFF, errp);
> +        /*
> +         * Amending image options should ensure that the image has
> +         * exactly the given new values, so pass exact=true here.
> +         */
Agree.

> +        ret = blk_truncate(blk, new_size, true, PREALLOC_MODE_OFF, errp);
>          blk_unref(blk);
>          if (ret < 0) {
>              return ret;
> diff --git a/block/qed.c b/block/qed.c
> index 7c2a65af40..8005cfc305 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -674,7 +674,7 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCreateOptions *opts,
>      l1_size = header.cluster_size * header.table_size;
>  
>      /* File must start empty and grow, check truncate is supported */
I would update the above comment, with something like

"QED format requires the underlying file to have the exact expected length,
which is 0 on creation"
Or something similar.

> -    ret = blk_truncate(blk, 0, false, PREALLOC_MODE_OFF, errp);
> +    ret = blk_truncate(blk, 0, true, PREALLOC_MODE_OFF, errp);
>      if (ret < 0) {
>          goto out;
>      }
> diff --git a/qemu-img.c b/qemu-img.c
> index f8694f4f72..a3169b6113 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3823,7 +3823,12 @@ static int img_resize(int argc, char **argv)
>          }
>      }
>  
> -    ret = blk_truncate(blk, total_size, false, prealloc, &err);
> +    /*
> +     * The user expects the image to have the desired size after
> +     * resizing, so pass @exact=true.  It is of no use to report
> +     * success when the image has not actually been resized.
> +     */
Agree.

> +    ret = blk_truncate(blk, total_size, true, prealloc, &err);
>      if (ret < 0) {
>          error_report_err(err);
>          goto out;
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 5e9017c979..1b7e700020 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -1710,7 +1710,12 @@ static int truncate_f(BlockBackend *blk, int argc, char **argv)
>          return offset;
>      }
>  
> -    ret = blk_truncate(blk, offset, false, PREALLOC_MODE_OFF, &local_err);
> +    /*
> +     * qemu-io is a debugging tool, so let us be strict here and pass
> +     * exact=true.  It is better to err on the "emit more errors" side
> +     * than to be overly permissive.
> +     */
Also agree.

> +    ret = blk_truncate(blk, offset, true, PREALLOC_MODE_OFF, &local_err);
>      if (ret < 0) {
>          error_report_err(local_err);
>          return ret;


Other than few nitpicks which probably aren't important,
Reviewed-by: Maxim Levitsky <mlevitsky@redhat.com>

Best regards,
	Maxim Levitsky


