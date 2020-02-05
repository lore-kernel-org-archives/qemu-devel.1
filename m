Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF96C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7EF20730
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieoS25+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7EF20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izNW4-00067v-Ni
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 11:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izNVK-0005do-TS
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izNVH-00087k-T2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:26:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39213
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izNVH-00085S-GM
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580919974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zS2EnU1jcU6PL+s0TDuwtuHEDNYjxn7VP+FuIXhAe60=;
 b=ieoS25+aYo8ZiGbT6TwcNBuVqnqxERehbnEU30Eu2aJDKe54AKc0uxPwC6hDD+zkqB+5jw
 D5hMIsE87Yo/Iz2YGi6DSUpT27xvJHjnD8UPUVPoMhr6T7Q8fjR4MTvfa/pxOJ2A/Fngy+
 E9o5Eof6XwSWzuw5DSYJCbCE3EcC7ZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-8jTwX4faP6W5PU7d188SvQ-1; Wed, 05 Feb 2020 11:26:12 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E87D21137856;
 Wed,  5 Feb 2020 16:26:10 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E4F85DA83;
 Wed,  5 Feb 2020 16:26:09 +0000 (UTC)
Subject: Re: [PATCH v2 07/33] block: Pass parent_is_format to
 .inherit_options()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-8-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f1b2b784-f366-f715-2e67-630866e3ee82@redhat.com>
Date: Wed, 5 Feb 2020 10:26:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-8-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8jTwX4faP6W5PU7d188SvQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> We plan to unify the generic .inherit_options() functions.  The
> resulting common function will need to decide whether to force-enable
> format probing, force-disable it, or leave it as-is.  To make this
> decision, it will need to know whether the parent node is a format node
> or not (because we never want format probing if the parent is a format
> node already (except for the backing chain)).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c                   | 37 +++++++++++++++++++++++++++----------
>   block/block-backend.c     |  2 +-
>   block/vvfat.c             |  2 +-
>   include/block/block_int.h |  2 +-
>   4 files changed, 30 insertions(+), 13 deletions(-)
> 

> @@ -2992,8 +2994,22 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
>       bs->explicit_options = qdict_clone_shallow(options);
>   
>       if (child_class) {
> +        bool parent_is_format;
> +
> +        if (parent->drv) {
> +            parent_is_format = parent->drv->is_format;
> +        } else {
> +            /*
> +             * parent->drv is not set yet because this node is opened for
> +             * (potential) format probing.  That means that @parent is going
> +             * to be a format node.
> +             */
> +            parent_is_format = true;
> +        }

Nice comment.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


