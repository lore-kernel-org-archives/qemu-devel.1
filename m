Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66F7C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A635920665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A635920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAh1P-0003LV-Nq
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 16:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgvJ-0005Lw-95
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgvH-00086H-9U
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:51:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40934)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iAgvB-00082t-He; Wed, 18 Sep 2019 16:51:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DBCB4308219E;
 Wed, 18 Sep 2019 20:51:28 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B80D160920;
 Wed, 18 Sep 2019 20:51:22 +0000 (UTC)
Message-ID: <6863fbab36039167dd7fff3ccba12b52980f7b26.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 23:51:21 +0300
In-Reply-To: <20190918095144.955-6-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
 <20190918095144.955-6-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 18 Sep 2019 20:51:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/8] block: Evaluate @exact in protocol
 drivers
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
> We have two protocol drivers that return success when trying to shrink a
> block device even though they cannot shrink it.  This behavior is now
> only allowed with exact=false, so they should return an error with
> exact=true.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 8 +++++++-
>  block/iscsi.c      | 7 ++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index d8755c5fac..a85f3486d1 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2028,6 +2028,7 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>      }
>  
>      if (S_ISREG(st.st_mode)) {
> +        /* Always resizes to the exact @offset */
>          return raw_regular_truncate(bs, s->fd, offset, prealloc, errp);
>      }
>  
> @@ -2038,7 +2039,12 @@ static int coroutine_fn raw_co_truncate(BlockDriverState *bs, int64_t offset,
>      }
>  
>      if (S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
> -        if (offset > raw_getlength(bs)) {
> +        int64_t cur_length = raw_getlength(bs);
> +
> +        if (offset != cur_length && exact) {
> +            error_setg(errp, "Cannot resize device files");
> +            return -ENOTSUP;
> +        } else if (offset > cur_length) {
>              error_setg(errp, "Cannot grow device files");
>              return -EINVAL;
>          }
> diff --git a/block/iscsi.c b/block/iscsi.c
> index a90426270a..cc2072ff6c 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2126,6 +2126,7 @@ static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t offset,
>                                            Error **errp)
>  {
>      IscsiLun *iscsilun = bs->opaque;
> +    int64_t cur_length;
>      Error *local_err = NULL;
>  
>      if (prealloc != PREALLOC_MODE_OFF) {
> @@ -2145,7 +2146,11 @@ static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t offset,
>          return -EIO;
>      }
>  
> -    if (offset > iscsi_getlength(bs)) {
> +    cur_length = iscsi_getlength(bs);
> +    if (offset != cur_length && exact) {
> +        error_setg(errp, "Cannot resize iSCSI devices");
> +        return -ENOTSUP;
> +    } else if (offset > cur_length) {
>          error_setg(errp, "Cannot grow iSCSI devices");
>          return -EINVAL;
>      }

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky



