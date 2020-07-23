Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E576C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 21:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2459F20768
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 21:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfeGUoSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2459F20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyiou-0004yb-Cj
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 17:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyio3-0004T3-Oh
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 17:31:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60627
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jyio2-0001bt-7Q
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 17:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595539868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PmehygAMDF+s0JYUCPuj+2ROEaApNsKNsTpSr2ca05U=;
 b=MfeGUoShcwWspj5smVK2FxUGoCNcFwJ9GfV3AbCHF3FwTiL5OYStT7BT4nVAFtBD5TInnJ
 8GyHc4syHzm356fDaqEZQuKX6F+HOsdmfHyCnfxkAHTslpQyKGrAIAcIlPDiMbVyZk5WcZ
 kXWlYH50Vd2GQbcFFepuGXaDa02MPVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-BbBMUvv5NZezBS23RPmnkA-1; Thu, 23 Jul 2020 17:31:01 -0400
X-MC-Unique: BbBMUvv5NZezBS23RPmnkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AEFB80183C;
 Thu, 23 Jul 2020 21:31:00 +0000 (UTC)
Received: from [10.3.112.189] (ovpn-112-189.phx2.redhat.com [10.3.112.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C872F8BEF6;
 Thu, 23 Jul 2020 21:30:54 +0000 (UTC)
Subject: Re: [PATCH v2 08/22] migration/block-dirty-bitmap: keep bitmap state
 for all bitmaps
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bcc6b129-d63f-3e0c-ec01-65bff4c2c03d@redhat.com>
Date: Thu, 23 Jul 2020 16:30:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200217150246.29180-9-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:02 AM, Vladimir Sementsov-Ogievskiy wrote:
> Keep bitmap state for disabled bitmaps too. Keep the state until the
> end of the process. It's needed for the following commit to implement
> bitmap postcopy canceling.
> 
> To clean-up the new list the following logic is used:
> We need two events to consider bitmap migration finished:
> 1. chunk with DIRTY_BITMAP_MIG_FLAG_COMPLETE flag should be received
> 2. dirty_bitmap_mig_before_vm_start should be called
> These two events may come in any order, so we understand which one is
> last, and on the last of them we remove bitmap migration state from the
> list.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 64 +++++++++++++++++++++++-----------
>   1 file changed, 43 insertions(+), 21 deletions(-)

> @@ -484,45 +488,59 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
>   
>       bdrv_disable_dirty_bitmap(s->bitmap);
>       if (flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED) {
> -        LoadBitmapState *b;
> -
>           bdrv_dirty_bitmap_create_successor(s->bitmap, &local_err);
>           if (local_err) {
>               error_report_err(local_err);
>               return -EINVAL;
>           }
> -
> -        b = g_new(LoadBitmapState, 1);
> -        b->bs = s->bs;
> -        b->bitmap = s->bitmap;
> -        b->migrated = false;
> -        s->enabled_bitmaps = g_slist_prepend(s->enabled_bitmaps, b);
>       }
>   
> +    b = g_new(LoadBitmapState, 1);
> +    b->bs = s->bs;
> +    b->bitmap = s->bitmap;
> +    b->migrated = false;
> +    b->enabled = flags & DIRTY_BITMAP_MIG_START_FLAG_ENABLED,
> +
> +    s->bitmaps = g_slist_prepend(s->bitmaps, b);

Did you really mean to use a comma operator there, or should that be ';'?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


