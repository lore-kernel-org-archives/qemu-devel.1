Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B0FC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D452070A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlCa+3+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D452070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopSh-0000wu-JL
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jopRQ-00080H-TO
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:34:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jopRO-0005YU-QU
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593182093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TLD6AvWEM8BgU7QIHSuZb9g2i6j8DgTLgkkhv02194=;
 b=QlCa+3+81mqAxpLBxysBQNqBidR5cnoTarzpAQJxEri/4L2pXId7Tje3f2DD8dw1Ehtxl5
 Lo5covzKRVmLyiDfSHOAm131a90s7jViKxSLGMEKEDUNnyBSoSJep1bFjBHM8+jZrm4N06
 2v4vrTXiefob5Tday7YslYFRBGPBCxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63--rianGpjNwWscTy_cOvIJA-1; Fri, 26 Jun 2020 10:34:51 -0400
X-MC-Unique: -rianGpjNwWscTy_cOvIJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BA57805EE3;
 Fri, 26 Jun 2020 14:34:50 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FCEE8FF83;
 Fri, 26 Jun 2020 14:34:47 +0000 (UTC)
Subject: Re: [PATCH] migration/block-dirty-bitmap: fix add_bitmaps_to_list
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200626130658.76498-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <20eed09c-f667-ab71-9d1a-a08c0c9d6a65@redhat.com>
Date: Fri, 26 Jun 2020 09:34:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626130658.76498-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 8:06 AM, Vladimir Sementsov-Ogievskiy wrote:
> We shouldn't fail, if found unnamed bitmap in a unnamed node or node

We shouldn't fail when finding an unnamed

> with auto-generated node name, as bitmap migration ignores such bitmaps
> at all.

such bitmaps in the first place.

> 
> Fixes: 82640edb88faa
> Fixes: 4ff5cc121b089
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

Will queue through the bitmaps tree.

Is this easy enough to reproduce that it would be worth having iotest 
coverage?

> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 47bc0f650c..b0dbf9eeed 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -274,7 +274,11 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
>       DirtyBitmapMigBitmapState *dbms;
>       Error *local_err = NULL;
>   
> -    bitmap = bdrv_dirty_bitmap_first(bs);
> +    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
> +        if (bdrv_dirty_bitmap_name(bitmap)) {
> +            break;
> +        }
> +    }
>       if (!bitmap) {
>           return 0;
>       }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


