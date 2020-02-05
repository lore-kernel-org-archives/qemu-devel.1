Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE8CC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8941F20702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCHdwTW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8941F20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izNra-0006jc-NR
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 11:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izNqw-0006Fa-Fi
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izNqt-0007gr-S8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:48:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35042
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izNqt-0007cz-Mn
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580921314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yK0HSOecBk6WK2sRkPWimI+Z9fOMB71Ut7lTViBjgYI=;
 b=UCHdwTW2UpD3Acb/l5+nM1b6BHcnA6QeaOGV5Jvs3um65cWL2jCgrTs/I5F6iuvQ1TIkPg
 8skBjIs27Bmk/DqzpycD2K+PCs94RS1U7ajD7yv+V/W6jlgXgOdzI1C75f85y4HkMj7ro0
 ycHkvPh+cXbaDqu82s7yWdqOUgEynHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-KiX8QpoCPAeAEK3b1VE3dw-1; Wed, 05 Feb 2020 11:48:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE1F48010E6;
 Wed,  5 Feb 2020 16:48:28 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24E9486C4A;
 Wed,  5 Feb 2020 16:48:27 +0000 (UTC)
Subject: Re: [PATCH v2 09/33] block: Add generic bdrv_inherited_options()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-10-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <87197a53-64e5-ec56-acff-13288256dee0@redhat.com>
Date: Wed, 5 Feb 2020 10:48:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-10-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: KiX8QpoCPAeAEK3b1VE3dw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:08 AM, Max Reitz wrote:
> After the series this patch belongs to, we want to have a common
> BdrvChildClass that encompasses all of child_file, child_format, and
> child_backing.  Such a single class needs a single .inherit_options()
> implementation, and this patch introduces it.
> 
> The next patch will show how the existing implementations can fall back
> to it just by passing appropriate BdrvChildRole and parent_is_format
> values.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 84 insertions(+)
> 

No impact until the next patch, but the division of patches was wise.


> +    /*
> +     * First, decide whether to set, clear, or leave BDRV_O_PROTOCOL.
> +     * Generally, the question to answer is: Should this child be
> +     * format-probed by default?
> +     */
> +
> +    /*
> +     * Pure and non-filtered data children of non-format nodes should
> +     * be probed by default (even when the node itself has BDRV_O_PROTOCOL
> +     * set).  This only affects a very limited set of drivers (namely
> +     * quorum and blkverify when this comment was written).
> +     * Force-clear BDRV_O_PROTOCOL then.
> +     */
> +    if (!parent_is_format &&
> +        (role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
> +                 BDRV_CHILD_FILTERED)) ==
> +            BDRV_CHILD_DATA)
> +    {
> +        flags &= ~BDRV_O_PROTOCOL;
> +    }
> +
> +    /*
> +     * All children of format nodes (except for COW children) and all
> +     * metadata children in general should never be format-probed.
> +     * Force-set BDRV_O_PROTOCOL then.
> +     */
> +    if ((parent_is_format && !(role & BDRV_CHILD_COW)) ||
> +        (role & BDRV_CHILD_METADATA))

Should this use 'else if', to make it obvious that we never have a path 
that both force-clears and force-sets BDRV_O_PROTOCOL?  But a careful 
reading shows that the two 'if' are mutually exclusive, even without the 
second using 'else if'.

> +    {
> +        flags |= BDRV_O_PROTOCOL;
> +    }
> +

Looks good!  Lots of decision trees, but also lots of good comments 
backing up that complexity.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


