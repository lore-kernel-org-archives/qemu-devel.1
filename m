Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092AFC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75A12075A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 21:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0cGUBW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75A12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWRYR-0001Kn-VT
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 17:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWRXh-0000pN-2P
 for qemu-devel@nongnu.org; Wed, 06 May 2020 17:25:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22419
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWRXg-0006QW-3r
 for qemu-devel@nongnu.org; Wed, 06 May 2020 17:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588800323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/w4ZgOI/n39n2thxXaous+q8tI3SysUxsKk/BlOg46Y=;
 b=d0cGUBW/AGmbcmpy1HoCU1Trp2iFlsyxixoQSu5kVi1NiiNn16THgRQACNV2JT6C/1eKMo
 bwid/IHrlCS3ZHBI79m0j56QhcrKgKtfdHjpPRQwu1E4ZLAgtPutXsyLoi912PYhL/Slas
 3dl1iEiPWp8skJlb/NHByG1scCVBkcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-svpZcXpMNF-rsZdjbT1bFw-1; Wed, 06 May 2020 17:25:19 -0400
X-MC-Unique: svpZcXpMNF-rsZdjbT1bFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED94B1800D4A;
 Wed,  6 May 2020 21:25:17 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E0D4579A5;
 Wed,  6 May 2020 21:25:13 +0000 (UTC)
Subject: Re: [PATCH 4/8] block/iscsi: drop unallocated_blocks_are_zero
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7e9264f2-1ba7-e522-4333-c39e486872fa@redhat.com>
Date: Wed, 6 May 2020 16:25:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506092513.20904-5-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com,
 codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 4:25 AM, Vladimir Sementsov-Ogievskiy wrote:
> We set bdi->unallocated_blocks_are_zero = iscsilun->lbprz, but
> iscsi_co_block_status doesn't return 0 in case of iscsilun->lbprz, it
> returns ZERO when appropriate. So actually unallocated_blocks_are_zero
> is useless. Drop it now.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/iscsi.c | 1 -
>   1 file changed, 1 deletion(-)

This one is easier to justify after removing the 2 clients.  But it's 
simpler than patch 1 in that because block_status never returned 0, this 
has no visible impact to 'qemu-io -c map' or similar, so it doesn't need 
the commit message justification about any change in behavior like patch 
1 needed.

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/iscsi.c b/block/iscsi.c
> index a8b76979d8..767e3e75fd 100644
> --- a/block/iscsi.c
> +++ b/block/iscsi.c
> @@ -2163,7 +2163,6 @@ static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t offset,
>   static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>   {
>       IscsiLun *iscsilun = bs->opaque;
> -    bdi->unallocated_blocks_are_zero = iscsilun->lbprz;
>       bdi->cluster_size = iscsilun->cluster_size;
>       return 0;
>   }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


