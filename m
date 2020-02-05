Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E82C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F7521741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A28OZKWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F7521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOJB-00084T-Dc
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izOFy-00041N-UD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izOFw-0005Cn-PH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:14:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izOFw-00058r-HD
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580922866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nuauJBDGKPZGZiSEz5rZKsAlRwvYx8N1fUspHI2QmE=;
 b=A28OZKWVLW/HQFNWOZQwrnQu5y10bJlc4z8JAjjcCCTBz9Y7hu2JYLWvlBoz0ep0S86Jyk
 2jvwIWqvzzfadB2NLrsm9/GjB0LZVnr+iMKIxzfZosRW/jLkcPqcOxg17u2uQZbVaq5bm+
 0nEeoicyWZZLy0pqBKzpT6gFKP1EKJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-5t5H9mJJPA2wto0SeP0FTw-1; Wed, 05 Feb 2020 12:14:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CC46189F763;
 Wed,  5 Feb 2020 17:14:09 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE53D89E81;
 Wed,  5 Feb 2020 17:14:08 +0000 (UTC)
Subject: Re: [PATCH v2 10/33] block: Use bdrv_inherited_options()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-11-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <61a0a25c-f726-c410-eddf-d47f9a93f7a3@redhat.com>
Date: Wed, 5 Feb 2020 11:14:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-11-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 5t5H9mJJPA2wto0SeP0FTw-1
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
> Let child_file's, child_format's, and child_backing's .inherit_options()
> implementations fall back to bdrv_inherited_options() to show that it
> would really work for all of these cases, if only the parents passed the
> appropriate BdrvChildRole and parent_is_format values.
> 
> (Also, make bdrv_open_inherit(), the only place to explicitly call
> bdrv_backing_options(), call bdrv_inherited_options() instead.)
> 
> This patch should incur only two visible changes, both for child_format
> children, both of which are effectively bug fixes:
> 
> First, they no longer have discard=unmap set by default.  This reason it
> was set is because bdrv_inherited_fmt_options() fell through to
> bdrv_protocol_options(), and that set it because "format drivers take
> care to send flushes and respect unmap policy".  None of the drivers
> that use child_format for their children (quorum and blkverify) are
> format drivers, though, so this reasoning does not apply here.
> 
> Second, they no longer have BDRV_O_NO_IO force-cleared.  child_format
> was used solely for children that do not store any metadata and as such
> will not be accessed by their parents as long as those parents do not
> receive I/O themselves.  Thus, such children should inherit
> BDRV_O_NO_IO.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c | 66 ++++++++++++---------------------------------------------
>   1 file changed, 14 insertions(+), 52 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


