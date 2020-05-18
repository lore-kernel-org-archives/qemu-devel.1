Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475EEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C43A20643
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZ56gCM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C43A20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jamWW-0005gC-7C
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jamVl-0004Ti-Va
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:37:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31986
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jamVk-0002Ko-Uf
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589834239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bv9a5nv2VScOzikNZp/eGZXOvmHk4zuclKmCxheRxGo=;
 b=aZ56gCM0ccrzCkgHWe+Q1hjyhmJZd7og6yot1hLSHGYhfhNUHJwoezFB/qghfeonPUfpNk
 qKkgleacxF28QJXZH2dFJos/j7Y8IgqYtoop10rwEGSnb/oJb22lfgkM2tdzmkvT/7Tjt2
 LkC8Sa+mDoZK70rcPv/8wL5TTxfTd28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-b1d0buN6Py6WmO-eABvkwA-1; Mon, 18 May 2020 16:37:06 -0400
X-MC-Unique: b1d0buN6Py6WmO-eABvkwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB43780058A;
 Mon, 18 May 2020 20:37:04 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF4FC19634;
 Mon, 18 May 2020 20:37:00 +0000 (UTC)
Subject: Re: [PATCH v3 4/7] migration/block-dirty-bitmap: fix bitmaps
 pre-blockdev migration during mirror job
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200515124024.3491-1-vsementsov@virtuozzo.com>
 <20200515124024.3491-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5cd24411-55bf-92c9-b5fe-2030c2915d1a@redhat.com>
Date: Mon, 18 May 2020 15:36:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515124024.3491-5-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 16:37:19
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
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 7:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> Important thing for bitmap migration is to select destination block
> node to obtain the migrated bitmap.
> 
> Prepatch, on source we use bdrv_get_device_or_node_name() to identify
> the node, and on target we do bdrv_lookup_bs.
> bdrv_get_device_or_node_name() returns blk name only for direct
> children of blk. So, bitmaps of direct children of blks are migrated by
> blk name and others - by node name.
> 
> Old libvirt is unprepared to bitmap migration by node-name,
> node-names are mostly auto-generated. So actually only migration by blk
> name works for it.
> 
> Newer libvirt will use new interface (which will be added soon) to
> specify node-mapping for bitmaps migration explicitly. Still, let's
> improve the current behavior a bit.
> 
> Now, consider classic libvirt migrations assisted by mirror block job:
> mirror block job inserts filter, so our source is not a direct child of
> blk, and bitmaps are migrated by node-names. And this just don't work

either "won't" or "doesn't"

> with auto-generated node names

trailing '.'

> 
> Let's fix it by allowing use blk-name even if some implicit filters are
> inserted.

s/allowing use/using/

> 
> Note2: we, of course, can't skip filters and use blk name to migrate
> bitmaps in filtered node by blk name for this blk if these filters have
> named bitmaps which should be migrated.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1652424
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 39 +++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 7e93718086..5d3a7d2b07 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -319,14 +319,48 @@ static int init_dirty_bitmap_migration(void)
>   {
>       BlockDriverState *bs;
>       DirtyBitmapMigBitmapState *dbms;
> +    GHashTable *handled_by_blk = g_hash_table_new(NULL, NULL);
> +    BlockBackend *blk;
>   
>       dirty_bitmap_mig_state.bulk_completed = false;
>       dirty_bitmap_mig_state.prev_bs = NULL;
>       dirty_bitmap_mig_state.prev_bitmap = NULL;
>       dirty_bitmap_mig_state.no_bitmaps = false;
>   
> +    /*
> +     * Use blockdevice name for direct (or filtered) children of named block
> +     * backends.
> +     */
> +    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
> +        const char *name = blk_name(blk);
> +
> +        if (!name || strcmp(name, "") == 0) {
> +            continue;
> +        }
> +
> +        bs = blk_bs(blk);
> +
> +        /* Skip filters without bitmaos */
> +        while (bs && bs->drv && bs->drv->is_filter &&
> +               !bdrv_has_named_bitmaps(bs))
> +        {
> +            bs = bs->backing->bs ?: bs->file->bs;

Is this correct, or should it be:

bs = bs->backing ? bs->backing->bs : bs->file->bs;

Otherwise looks reasonable, but I'm hesitant to include it in today's 
bitmap pull request in order to give it more review/testing time.  It 
should be ready for a pull request next week, though.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


