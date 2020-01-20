Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80B9C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 20:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E78217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 20:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkFudYCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E78217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itdcY-0008KL-Bp
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 15:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41776)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1itdaW-0007Tf-Rh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 15:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1itdaV-0005vs-SB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 15:23:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44702
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1itdaV-0005tN-Or
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 15:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579551832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew1K2K/uwjemn3o/wl67Hy2HoUsD1xctAnrGS6Kpd74=;
 b=RkFudYCinj1rfSwN6GqooqL3hJxuR/yFYRZC/H4wLmaGzXOMkclTf8KthXnKJKnkFomo5c
 0toMeWNJaa/HFjbOXEn0+BwiT827bSS9JLgUn1DW0eLXS/YkfFJzWWFzHEdFKR9UZ2LvbM
 EcFdFszjMHDd9sdFvOxE9LIqkg5h4qE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-06jZZBHLMSKWd34onwVPKw-1; Mon, 20 Jan 2020 15:23:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E115C18B6383;
 Mon, 20 Jan 2020 20:23:47 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDF9319756;
 Mon, 20 Jan 2020 20:23:44 +0000 (UTC)
Subject: Re: [PATCH v3 09/10] nbd/server: use bdrv_dirty_bitmap_next_dirty_area
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-10-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <40a75014-efb5-a6a8-c83d-4a67ef3cdaf3@redhat.com>
Date: Mon, 20 Jan 2020 14:23:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191219100348.24827-10-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 06jZZBHLMSKWd34onwVPKw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 4:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use bdrv_dirty_bitmap_next_dirty_area for bitmap_to_extents. Since
> bdrv_dirty_bitmap_next_dirty_area is very accurate in its interface,
> we'll never exceed requested region with last chunk. So, we don't need
> dont_fragment, and bitmap_to_extents() interface becomes clean enough
> to not require any comment.

Not exceeding the requested region means we are giving the client less 
information than what we already have freely available.  I don't know if 
that will (slightly) pessimize any client that would have otherwise been 
able to handle the fact that we reported beyond the request (only 
matters for clients which do not use NBD_CMD_FLAG_REQ_ONE).

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

But since I've already reviewed it, my R-b still stands.

> ---
>   nbd/server.c | 59 +++++++++++++++++-----------------------------------
>   1 file changed, 19 insertions(+), 40 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


