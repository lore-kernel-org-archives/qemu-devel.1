Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78526C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461DA20882
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 20:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461DA20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAgv7-0004n1-AX
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 16:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgta-0003hN-Lg
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iAgtZ-00073v-L6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 16:49:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iAgtV-00072Q-Uc; Wed, 18 Sep 2019 16:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8EAB780038D;
 Wed, 18 Sep 2019 20:49:44 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D5CF60C05;
 Wed, 18 Sep 2019 20:49:40 +0000 (UTC)
Message-ID: <b3fe9d8f513ae1bf7312f1024b72e1fd83403ac8.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 23:49:39 +0300
In-Reply-To: <20190918095144.955-2-mreitz@redhat.com>
References: <20190918095144.955-1-mreitz@redhat.com>
 <20190918095144.955-2-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 18 Sep 2019 20:49:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/8] block: Handle filter truncation like
 native impl.
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
> Make the filter truncation (passing it through to bs->file) a
> first-class citizen and handle it exactly as if it was the filter
> driver's native implementation of .bdrv_co_truncate().
> 
> I do not see a reason not to, it makes the code a bit shorter, and may
> be even more correct because this gets us to finish the write_req that
> we prepared before (may be important to e.g. bring dirty bitmaps to the
> correct size).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/io.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index f8c3596131..723655c792 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3299,20 +3299,19 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
>          goto out;
>      }
>  
> -    if (!drv->bdrv_co_truncate) {
> -        if (bs->file && drv->is_filter) {
> -            ret = bdrv_co_truncate(bs->file, offset, prealloc, errp);
> -            goto out;
> -        }
> +    if (drv->bdrv_co_truncate) {
> +        ret = drv->bdrv_co_truncate(bs, offset, prealloc, errp);
> +    } else if (bs->file && drv->is_filter) {
> +        ret = bdrv_co_truncate(bs->file, offset, prealloc, errp);
> +    } else {
>          error_setg(errp, "Image format driver does not support resize");
>          ret = -ENOTSUP;
>          goto out;
>      }
> -
> -    ret = drv->bdrv_co_truncate(bs, offset, prealloc, errp);
>      if (ret < 0) {
>          goto out;
>      }
> +
> 
I would say that those are unrelated whitespace changes, but I myself
don't mind this :-)


>      ret = refresh_total_sectors(bs, offset >> BDRV_SECTOR_BITS);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Could not refresh total sector count");

Looks all right to me, although I don't know the block filters well yet.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



