Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB43C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FC020674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/yrCAQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FC020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izNOZ-0002h3-M8
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 11:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izNNt-0002BK-5p
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izNNs-0001dl-9B
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:18:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izNNs-0001d9-67
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580919515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHI70g02OHrx/A61qEVe10edEHGSEVPf1ZW87UeKHHc=;
 b=f/yrCAQj7fwFiv78DTbzJ/+PXspH3MSFnjQF1Vwo0mpyOgAOYXZIgdtUFp2gehW2Y0+aEI
 0d8QUzgGmq9djr1DjAnA/e4Ld9DeFNfx4ilu63I9pgT23zL5J0hIA0F85O8ylbK6MBDhrO
 58WehtNyuFK2Y8LLRki649iKLKhpUH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-y63P3DkJMwSFvr3aWfeewg-1; Wed, 05 Feb 2020 11:18:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FB5214E4;
 Wed,  5 Feb 2020 16:18:30 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 570C819C7F;
 Wed,  5 Feb 2020 16:18:27 +0000 (UTC)
Subject: Re: [PATCH v2 06/33] block: Pass BdrvChildRole to .inherit_options()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-7-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <070f9a8e-0947-8e65-36a6-25495aecaa28@redhat.com>
Date: Wed, 5 Feb 2020 10:18:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-7-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: y63P3DkJMwSFvr3aWfeewg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:08 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Another sparse commit message.

> ---
>   block.c                   | 40 +++++++++++++++++++++++----------------
>   block/block-backend.c     |  3 ++-
>   block/vvfat.c             |  3 ++-
>   include/block/block_int.h |  3 ++-
>   4 files changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 7fa7830428..612e86fab9 100644
> --- a/block.c
> +++ b/block.c
> @@ -77,6 +77,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
>                                              QDict *options, int flags,
>                                              BlockDriverState *parent,
>                                              const BdrvChildClass *child_class,
> +                                           BdrvChildRole child_role,

And another question about proper typing.

And another:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


