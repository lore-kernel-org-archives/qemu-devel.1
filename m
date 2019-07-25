Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4780C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7820721951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7820721951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqffb-0001Cx-Pc
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48122)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hqffR-0000kx-Ac
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hqffQ-0000Z3-BV
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:28:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hqffO-0000Wl-7r; Thu, 25 Jul 2019 11:28:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E71F685362;
 Thu, 25 Jul 2019 15:28:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8021B5D71A;
 Thu, 25 Jul 2019 15:28:23 +0000 (UTC)
Message-ID: <b4ca1897b453e06c5e0c92fbb2cebd502b573235.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:28:22 +0300
In-Reply-To: <20190724171239.8764-2-mreitz@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-2-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 25 Jul 2019 15:28:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 01/11] qemu-img: Fix
 bdrv_has_zero_init() use in convert
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-07-24 at 19:12 +0200, Max Reitz wrote:
> bdrv_has_zero_init() only has meaning for newly created images or image
> areas.  If qemu-img convert did not create the image itself, it cannot
> rely on bdrv_has_zero_init()'s result to carry any meaning.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 79983772de..0f4be80c10 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1578,6 +1578,7 @@ typedef struct ImgConvertState {
>      bool has_zero_init;
>      bool compressed;
>      bool unallocated_blocks_are_zero;
> +    bool target_is_new;
>      bool target_has_backing;
>      int64_t target_backing_sectors; /* negative if unknown */
>      bool wr_in_order;
> @@ -1975,9 +1976,11 @@ static int convert_do_copy(ImgConvertState *s)
>      int64_t sector_num = 0;
>  
>      /* Check whether we have zero initialisation or can get it efficiently */
> -    s->has_zero_init = s->min_sparse && !s->target_has_backing
> -                     ? bdrv_has_zero_init(blk_bs(s->target))
> -                     : false;
> +    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
> +        s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
> +    } else {
> +        s->has_zero_init = false;
> +    }
>  
>      if (!s->has_zero_init && !s->target_has_backing &&
>          bdrv_can_write_zeroes_with_unmap(blk_bs(s->target)))
> @@ -2423,6 +2426,8 @@ static int img_convert(int argc, char **argv)
>          }
>      }
>  
> +    s.target_is_new = !skip_create;
> +
>      flags = s.min_sparse ? (BDRV_O_RDWR | BDRV_O_UNMAP) : BDRV_O_RDWR;
>      ret = bdrv_parse_cache_mode(cache, &flags, &writethrough);
>      if (ret < 0) {


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky



