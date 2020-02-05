Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38FAC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9074320659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiiR2esy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9074320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izMYh-0005zQ-QG
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 10:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izMXu-00056a-RO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izMXt-0000eu-Ew
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:24:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izMXt-0000YY-AC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580916292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3luZKTz+GXtrf92Y7bP9KUq+bhyzmvAc+UxrWthEpwE=;
 b=AiiR2esyV7/FJG9YVDnOGnw4aZOYgdcP/svVOGlekpVF7O48kkKr4p2B8J1lVNAAnT7D5d
 VyagF9KdpSkA5gkChAnZHONSdmveIehWQoDSmFjITa3xbZm0xrRp76qY4r0pn3cNA+HF0Y
 4/Edzy603Wlak7nDftLMnXnlDJqudTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-k94l2tz7Mi-wXD7OECsvPw-1; Wed, 05 Feb 2020 10:24:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F3C4DBA3;
 Wed,  5 Feb 2020 15:24:47 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A8295D9E2;
 Wed,  5 Feb 2020 15:24:46 +0000 (UTC)
Subject: Re: [PATCH v2 03/33] block: Add BdrvChildRole
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ab321260-f03c-2540-e443-9b1f066f819f@redhat.com>
Date: Wed, 5 Feb 2020 09:24:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-4-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: k94l2tz7Mi-wXD7OECsvPw-1
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
> This enum will supplement BdrvChildClass when it comes to what role (or
> combination of roles) a child takes for its parent.
> 
> Because empty enums are not allowed, let us just start with it filled.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   include/block/block.h | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 38963ef203..0f7e8caa5b 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -279,6 +279,33 @@ enum {
>       DEFAULT_PERM_UNCHANGED      = BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHROUGH,
>   };
>   
> +typedef enum BdrvChildRole {
> +    /* Child stores data */
> +    BDRV_CHILD_DATA         = (1 << 0),
> +
> +    /* Child stores metadata */
> +    BDRV_CHILD_METADATA     = (1 << 1),
> +
> +    /* Filtered child */
> +    BDRV_CHILD_FILTERED     = (1 << 2),

I'm not sure this comment does justice for what the flag represents, but 
am not sure of what longer comment to put in its place.

> +
> +    /* Child to COW from (backing child) */
> +    BDRV_CHILD_COW          = (1 << 3),
> +
> +    /*
> +     * The primary child.  For most drivers, this is the child whose
> +     * filename applies best to the parent node.
> +     * Each parent must give this flag to no more than one child at a
> +     * time.
> +     */
> +    BDRV_CHILD_PRIMARY      = (1 << 4),
> +
> +    /* Useful combination of flags */
> +    BDRV_CHILD_IMAGE        = BDRV_CHILD_DATA
> +                              | BDRV_CHILD_METADATA
> +                              | BDRV_CHILD_PRIMARY,
> +} BdrvChildRole;
> +
>   char *bdrv_perm_names(uint64_t perm);
>   uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm);
>   
> 

Whether or not you can improve the comment, the enum makes sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


