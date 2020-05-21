Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E12CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C0420759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 21:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mgt/Chuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C0420759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbsSc-0001Pm-Ig
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 17:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbsRs-0000m5-FJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:09:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43225
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbsRo-0005ju-5u
 for qemu-devel@nongnu.org; Thu, 21 May 2020 17:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590095386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LnfrAb5BxF2wxu5wJynTOm9j/vKRNiz5wVgCk02A2V0=;
 b=Mgt/ChucvHR8AR+YM6jk2FZj+WKfrIbSpfBNGM3MNam0Uq+1ir5Am8RGHqOqnT2bH5gwk7
 nfEW8jfLnqj/E3AxALAU/+Cy14ZTKL9SP5LYCX061VVkIt4l/lx49Edd33q7r/35GrYwE2
 Kp/sbgS664gSgL1g6xftMsOLg1Baeeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-rATEH_a0MO6Hov_2ljVMwg-1; Thu, 21 May 2020 17:09:42 -0400
X-MC-Unique: rATEH_a0MO6Hov_2ljVMwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16A97107ACCA;
 Thu, 21 May 2020 21:09:41 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BBF8779D4;
 Thu, 21 May 2020 21:09:37 +0000 (UTC)
Subject: Re: [PATCH v3 6/7] migration/block-dirty-bitmap: add_bitmaps_to_list:
 check disk name once
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
 <20200515124024.3491-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a840be30-5af8-481a-fe00-e8a7f587400a@redhat.com>
Date: Thu, 21 May 2020 16:09:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515124024.3491-7-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, fam@euphon.net, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 mreitz@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 7:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 5d3a7d2b07..e0e081ce60 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -274,17 +274,22 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
>       DirtyBitmapMigBitmapState *dbms;
>       Error *local_err = NULL;
>   
> +    bitmap = bdrv_dirty_bitmap_first(bs);
> +    if (!bitmap) {
> +        return 0;
> +    }
> +
> +    if (!bs_name || strcmp(bs_name, "") == 0) {
> +        error_report("Found bitmap '%s' in unnamed node %p. It can't "
> +                     "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);

The %p is unusual; it does not help the end user, but only a developer 
with gdb access.

Maybe we could compress to:

"Bitmap '%s' in unnamed node can't be migrated"

> +        return -1;
> +    }
> +
>       FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
>           if (!bdrv_dirty_bitmap_name(bitmap)) {
>               continue;
>           }
>   
> -        if (!bs_name || strcmp(bs_name, "") == 0) {
> -            error_report("Found bitmap '%s' in unnamed node %p. It can't "
> -                         "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
> -            return -1;
> -        }
> -

But since this is just code motion (hoisting an check outside of a loop, 
for fewer executions of something that does not change within the loop), 
it doesn't matter whether this patch goes in as-is or if you also tweak 
the error message.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


