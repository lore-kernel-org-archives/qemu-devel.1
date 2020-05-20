Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEE420709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 16:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Msio1QOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEE420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbRcg-0006mC-Ar
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 12:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbRbn-0005fP-Qx
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:30:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55541
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbRbm-0001a6-Vq
 for qemu-devel@nongnu.org; Wed, 20 May 2020 12:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589992218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMCRjoXAOjFMmqwUNfnBOl1VpuAA+GBSX0Qyep9NEoU=;
 b=Msio1QOJWPhDhh/ACxvX3j/BP0YTlNKCTVbjQVR9ivIn/PG3rnEMEY5yvXmd/i1Ws7jVEg
 KdNJs/XHgQ89DqAT4UF1DvCJ8PriMORN+ElUGo6bDLJnkwlBeU5Vm8QRFsB1Oyb+w1WHcg
 bZkbITIF7N3pfZzesrGeXXPf96N87UQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-80QqP2iqMqi4wI6w3zLETA-1; Wed, 20 May 2020 12:30:16 -0400
X-MC-Unique: 80QqP2iqMqi4wI6w3zLETA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 194F8872FE0;
 Wed, 20 May 2020 16:30:15 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B19993420E;
 Wed, 20 May 2020 16:30:11 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] block/io: bdrv_common_block_status_above: support
 bs == base
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200520083520.25793-1-vsementsov@virtuozzo.com>
 <20200520083520.25793-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <94424e32-30d9-7d61-4723-c351fdaca942@redhat.com>
Date: Wed, 20 May 2020 11:30:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520083520.25793-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 3:35 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are going to reuse bdrv_common_block_status_above in
> bdrv_is_allocated_above. bdrv_is_allocated_above may be called with
> include_base == false and still bs == base (for ex. from img_rebase()).
> 
> So, support this corner case.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/io.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/block/io.c b/block/io.c
> index ae1c806720..6f90b322f4 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2458,7 +2458,11 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
>       int ret = 0;
>       bool first = true;
>   
> -    assert(include_base || bs != base);
> +    if (!include_base && bs == base) {
> +        *pnum = bytes;
> +        return 0;
> +    }
> +
>       for (p = bs; include_base || p != base; p = backing_bs(p)) {
>           ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
>                                      file);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


