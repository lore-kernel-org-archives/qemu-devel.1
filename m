Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD0C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D446221951
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D446221951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfhD-00073c-2s
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48611)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfh1-0006X0-SB
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hqfgu-0001AP-Q6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hqfgs-00018r-5O; Thu, 25 Jul 2019 11:29:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7666F308FC23;
 Thu, 25 Jul 2019 15:29:57 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F8D319C68;
 Thu, 25 Jul 2019 15:29:55 +0000 (UTC)
Message-ID: <fd130edbd8d3451bf3f168ec3b2a13f7a03d78e1.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 18:29:55 +0300
In-Reply-To: <20190724171239.8764-8-mreitz@redhat.com>
References: <20190724171239.8764-1-mreitz@redhat.com>
 <20190724171239.8764-8-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 25 Jul 2019 15:29:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 07/11] vdi: Fix .bdrv_has_zero_init()
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
> Static VDI images cannot guarantee to be zero-initialized.  If the image
> has been statically allocated, forward the call to the underlying
> storage node.
> 
> Reported-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/vdi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/block/vdi.c b/block/vdi.c
> index b9845a4cbd..0caa3f281d 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -988,6 +988,17 @@ static void vdi_close(BlockDriverState *bs)
>      error_free(s->migration_blocker);
>  }
>  
> +static int vdi_has_zero_init(BlockDriverState *bs)
> +{
> +    BDRVVdiState *s = bs->opaque;
> +
> +    if (s->header.image_type == VDI_TYPE_STATIC) {
> +        return bdrv_has_zero_init(bs->file->bs);
> +    } else {
> +        return 1;
> +    }
> +}
> +
>  static QemuOptsList vdi_create_opts = {
>      .name = "vdi-create-opts",
>      .head = QTAILQ_HEAD_INITIALIZER(vdi_create_opts.head),
> @@ -1028,7 +1039,7 @@ static BlockDriver bdrv_vdi = {
>      .bdrv_child_perm          = bdrv_format_default_perms,
>      .bdrv_co_create      = vdi_co_create,
>      .bdrv_co_create_opts = vdi_co_create_opts,
> -    .bdrv_has_zero_init = bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init  = vdi_has_zero_init,
>      .bdrv_co_block_status = vdi_co_block_status,
>      .bdrv_make_empty = vdi_make_empty,
>  


I am not familiar with VDI format to be honest, but knowing that dynamic format allows for growing
and static are preallocated this makes sense.

I see that the code when it allocates a new block at the end of the file, actually zeroes it out, so most
likely this is right.


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


