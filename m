Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1F2C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 23:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D2120730
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 23:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbuGybzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D2120730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izThw-0003Q2-AP
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 18:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izTh8-0002uj-GJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 18:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izTh7-0000Xy-6N
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 18:02:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60417
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izTh7-0000XE-2p
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 18:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580943772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9wHK+tIZxvXyZzdz/SJyEkqNQIUDTe6aepjPhAh0eg=;
 b=HbuGybzKHgXV9LUWqWX/1BaYoa4QjDGZVXzcKCcCab1HrNQP3rWdEcO6aSQ9CrvcNlvxPx
 L9a6riFKMwNdaK9mE9+ES5VFlytmJPNfs0/THJEAptv5fp+AXArp3r6kNHw/P8Nf3t/NPR
 v6vx+yJ6iFFTX+b3nMHN1qJfV7aEcqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-q4_PLpwQOu2gUoZnGIYJ2A-1; Wed, 05 Feb 2020 18:02:48 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE20A108838E;
 Wed,  5 Feb 2020 23:02:46 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8722F1A7E3;
 Wed,  5 Feb 2020 23:02:46 +0000 (UTC)
Subject: Re: [PATCH v2 25/33] block: Make filter drivers use child_of_bds
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-26-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0b6353ad-629c-ab82-ef8c-798910e028c2@redhat.com>
Date: Wed, 5 Feb 2020 17:02:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-26-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: q4_PLpwQOu2gUoZnGIYJ2A-1
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
> Note that some filters have secondary children, namely blkverify (the
> image to be verified) and blklogwrites (the log).  This patch does not
> touch those children.

I would have guessed blkdebug; but I guess that's not quite a filter for 
other reasons, so it gets covered in a later patch.

> 
> Note that for blkverify, the filtered child should not be format-probed.
> While there is nothing enforcing this here, in practice, it will not be:
> blkverify implements .bdrv_file_open.  The block layer ensures (and in
> fact, asserts) that BDRV_O_PROTOCOL is set for every BDS whose driver
> implements .bdrv_file_open.  This flag will then be bequeathed to
> blkverify's children, and they will thus (by default) not be probed
> either.
> 
> ("By default" refers to the fact that blkverify's other child (the
> non-filtered one) will have BDRV_O_PROTOCOL force-unset, because that is
> what happens for all non-filtered children of non-format drivers.)
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/blkdebug.c        | 4 +++-
>   block/blklogwrites.c    | 3 ++-
>   block/blkverify.c       | 4 +++-
>   block/copy-on-read.c    | 5 +++--
>   block/filter-compress.c | 5 +++--
>   block/replication.c     | 3 ++-
>   block/throttle.c        | 5 +++--
>   7 files changed, 19 insertions(+), 10 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


