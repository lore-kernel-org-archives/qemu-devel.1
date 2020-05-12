Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D566CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD319206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dt6Zs1cB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD319206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYX2L-0002Zm-V3
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYWyt-0006vR-7t
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:38:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jYWyr-0003xW-HN
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589297883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVLsXBWDPY60bAVIu6cBZzSs4s0TYkcGDmNPvLvc/A0=;
 b=dt6Zs1cBYsTDIfftuwMSl3krcFZDIIrAE7Fw61ji3u7JKiwCRzktRbKzvxcruaahwB51hg
 jXSY74Dpg2Y8ZfJXRtIH4f2012oU082KGEAxGn0JexQZUqjqq1HauVntv1BfOVL9ZU/TL5
 itu5zJmDMRxYcMWvVyDnZYXJwZI9UKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-mcRKwMi1N_2ZocxxxGm8IQ-1; Tue, 12 May 2020 11:37:57 -0400
X-MC-Unique: mcRKwMi1N_2ZocxxxGm8IQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6F491B2C9A9;
 Tue, 12 May 2020 15:37:56 +0000 (UTC)
Received: from [10.3.116.145] (ovpn-116-145.phx2.redhat.com [10.3.116.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFDDB341EC;
 Tue, 12 May 2020 15:37:52 +0000 (UTC)
Subject: Re: [RFC PATCH 1/3] block: Factor out bdrv_run_co()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200512144318.181049-1-kwolf@redhat.com>
 <20200512144318.181049-2-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5f019ab2-076f-4537-9138-9ed93484a727@redhat.com>
Date: Tue, 12 May 2020 10:37:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512144318.181049-2-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, armbru@redhat.com,
 s.reiter@proxmox.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 9:43 AM, Kevin Wolf wrote:
> We have a few bdrv_*() functions that can either spawn a new coroutine
> and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
> alreeady running in a coroutine. All of them duplicate basically the

already

> same code.
> 
> Factor the common code into a new function bdrv_run_co().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/io.c | 104 +++++++++++++++--------------------------------------
>   1 file changed, 28 insertions(+), 76 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 7d30e61edc..c1badaadc9 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -891,6 +891,22 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
>       return 0;
>   }
>   
> +static int bdrv_run_co(BlockDriverState *bs, CoroutineEntry *entry,
> +                       void *opaque, int *ret)
> +{
> +    if (qemu_in_coroutine()) {
> +        /* Fast-path if already in coroutine context */
> +        entry(opaque);
> +    } else {
> +        Coroutine *co = qemu_coroutine_create(entry, opaque);
> +        *ret = NOT_DONE;
> +        bdrv_coroutine_enter(bs, co);
> +        BDRV_POLL_WHILE(bs, *ret == NOT_DONE);

For my reference, NOT_DONE is defined as INT_MAX, which does not seem to 
be used as a return value in other situations.

> @@ -923,25 +939,15 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
>                           QEMUIOVector *qiov, bool is_write,
>                           BdrvRequestFlags flags)
>   {
> -    Coroutine *co;
>       RwCo rwco = {
>           .child = child,
>           .offset = offset,
>           .qiov = qiov,
>           .is_write = is_write,
> -        .ret = NOT_DONE,
>           .flags = flags,
>       };
>   
> -    if (qemu_in_coroutine()) {
> -        /* Fast-path if already in coroutine context */
> -        bdrv_rw_co_entry(&rwco);
> -    } else {
> -        co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
> -        bdrv_coroutine_enter(child->bs, co);
> -        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
> -    }
> -    return rwco.ret;
> +    return bdrv_run_co(child->bs, bdrv_rw_co_entry, &rwco, &rwco.ret);

So code that previously looped on NOT_DONE is obviously safe, while...

>   }
>   
>   int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
> @@ -2230,7 +2236,6 @@ typedef struct BdrvCoBlockStatusData {
>       int64_t *map;
>       BlockDriverState **file;
>       int ret;
> -    bool done;
>   } BdrvCoBlockStatusData;
>   
>   int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
> @@ -2492,7 +2497,6 @@ static void coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
>                                              data->want_zero,
>                                              data->offset, data->bytes,
>                                              data->pnum, data->map, data->file);
> -    data->done = true;
>       aio_wait_kick();

...code that looped on something else now has to be checked that 
data->ret is still being set to something useful.  Fortunately that is 
true here.

> @@ -2669,22 +2663,13 @@ static inline int
>   bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>                   bool is_read)
>   {
> -    if (qemu_in_coroutine()) {
> -        return bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
> -    } else {
> -        BdrvVmstateCo data = {
> -            .bs         = bs,
> -            .qiov       = qiov,
> -            .pos        = pos,
> -            .is_read    = is_read,
> -            .ret        = -EINPROGRESS,
> -        };
> -        Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
> -
> -        bdrv_coroutine_enter(bs, co);
> -        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
> -        return data.ret;

It's a little harder to see whether -EINPROGRESS might ever be returned 
by a driver, but again this looks safe.

Here, it's a little less obvious whether any driver might return 
-EINPROGRESS, but it looks like if they did that,

Reviewed-by: Eric Blake <eblake@redhat.com>

Conflicts with Vladimir's patches which try to add more coroutine 
wrappers (but those need a rebase anyway):
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04559.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


