Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B20BC4725C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2492166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 21:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXJKYWBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2492166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUdUj-00026Z-VS
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 17:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUdTT-0001Jh-9M
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jUdRn-0005SX-Ic
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:45:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60290
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jUdRn-0005PV-2E
 for qemu-devel@nongnu.org; Fri, 01 May 2020 17:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588369429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vb/BKquY5vimluXDfauFth2E5YJ9456fEVkxwA4y3Q=;
 b=PXJKYWBkkvpcHZ5iIxRrnVy3hbYHDzlyVq+R+2HMAVR65TgzaLQYyx42/k4DMm0BKNYbfw
 J5BoMbnut7bKr4g0IQSmkeVZtzkyOWfVSAMN9GKIytDyibvvzYg/fSiQSvSv2tjU8o2w3K
 I+wruM0Q1lMwcv+7FHJ0DrWDfS9jfwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-edNbGkBFN5WDFHaqaN_AnA-1; Fri, 01 May 2020 17:43:45 -0400
X-MC-Unique: edNbGkBFN5WDFHaqaN_AnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DC0D80183C;
 Fri,  1 May 2020 21:43:44 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF0FC60BE1;
 Fri,  1 May 2020 21:43:40 +0000 (UTC)
Subject: Re: [PATCH v2 5/9] block/io: expand in_flight inc/dec section: simple
 cases
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
 <20200427143907.5710-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cdd167a9-62a7-fb02-70a2-766b811cef07@redhat.com>
Date: Fri, 1 May 2020 16:43:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427143907.5710-6-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 17:43:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 9:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> It's safer to expand in_flight request to start before enter to
> coroutine in synchronous wrappers, due to the following (theoretical)
> problem:
> 
> Consider write.
> It's possible, that qemu_coroutine_enter only schedules execution,
> assume such case.
> 
> Then we may possibly have the following:
> 
> 1. Somehow check that we are not in drained section in outer code.
> 
> 2. Call bdrv_pwritev(), assuming that it will increase in_flight, which
> will protect us from starting drained section.
> 
> 3. It calls bdrv_prwv_co() -> bdrv_coroutine_enter() (not yet increased
> in_flight).
> 
> 4. Assume coroutine not yet actually entered, only scheduled, and we go
> to some code, which starts drained section (as in_flight is zero).
> 
> 5. Scheduled coroutine starts, and blindly increases in_flight, and we
> are in drained section with in_flight request.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 161 +++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 124 insertions(+), 37 deletions(-)

>   
> +int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
> +    int64_t offset, unsigned int bytes,
> +    QEMUIOVector *qiov, size_t qiov_offset,
> +    BdrvRequestFlags flags)
> +{

Doesn't seem to be the usual indentation in this file.

> @@ -1922,7 +1934,8 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
>       return bdrv_co_pwritev_part(child, offset, bytes, qiov, 0, flags);
>   }
>   
> -int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
> +/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
> +static int coroutine_fn bdrv_do_pwritev_part(BdrvChild *child,
>       int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
>       BdrvRequestFlags flags)
>   {

then again, it was in use here, and saves reindenting the remaining 
lines.  I'll let the maintainer decide which style is preferred.

> @@ -2014,17 +2038,18 @@ typedef struct RwCo {
>       BdrvRequestFlags flags;
>   } RwCo;
>   
> +/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
>   static void coroutine_fn bdrv_rw_co_entry(void *opaque)
>   {
>       RwCo *rwco = opaque;
>   
>       if (!rwco->is_write) {
> -        rwco->ret = bdrv_co_preadv(rwco->child, rwco->offset,
> -                                   rwco->qiov->size, rwco->qiov,
> +        rwco->ret = bdrv_do_preadv_part(rwco->child, rwco->offset,
> +                                   rwco->qiov->size, rwco->qiov, 0,
>                                      rwco->flags);

Indentation is now off.

>       } else {
> -        rwco->ret = bdrv_co_pwritev(rwco->child, rwco->offset,
> -                                    rwco->qiov->size, rwco->qiov,
> +        rwco->ret = bdrv_do_pwritev_part(rwco->child, rwco->offset,
> +                                    rwco->qiov->size, rwco->qiov, 0,
>                                       rwco->flags);

and again

> @@ -3411,9 +3478,12 @@ static void bdrv_parent_cb_resize(BlockDriverState *bs)
>    * If 'exact' is true, the file must be resized to exactly the given
>    * 'offset'.  Otherwise, it is sufficient for the node to be at least
>    * 'offset' bytes in length.
> + *
> + * To be called between exactly one pair of bdrv_inc/dec_in_flight()
>    */
> -int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
> -                                  PreallocMode prealloc, Error **errp)
> +static int coroutine_fn bdrv_do_truncate(BdrvChild *child,
> +                                         int64_t offset, bool exact,
> +                                         PreallocMode prealloc, Error **errp)

Needs to be rebased, now that master has Kevin's patches addeing a 
'BdrvRequestFlags flags' parameter.  But the rebase should be obvious.

Otherwise looks sane to me, but I may be missing one of the finer points 
on which functions should be decorated with 'coroutine_fn'.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


