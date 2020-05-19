Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E0EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12162207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 11:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0/lkN1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12162207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb03S-0004mS-6r
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 07:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jb02j-0003yU-Cz
 for qemu-devel@nongnu.org; Tue, 19 May 2020 07:04:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jb02i-00023H-0f
 for qemu-devel@nongnu.org; Tue, 19 May 2020 07:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589886255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yyk9gfzglKxJxElBm7+9uaBQmCFacGswpx+6/y3X8Dc=;
 b=Q0/lkN1KoWflMNLJIsC0yMV1tvoqVEv3JRw7GOXpt/DiWMg/SEtiFK3ZtOl4O5VW95v0Ik
 inZQhwaDOid/HJaU4LJzE0RtVr5mQr5HPF1WY8l9PLwnDrc9FwtJrHTFAGqek9JvhPpjmB
 Hrh8ZHpbWQ13PSaf+9nX+dJ/QrxBQds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-V8Lfrp1gOnKwTK_Zg9RzQQ-1; Tue, 19 May 2020 07:04:13 -0400
X-MC-Unique: V8Lfrp1gOnKwTK_Zg9RzQQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D63281E22C;
 Tue, 19 May 2020 11:04:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-199.ams2.redhat.com [10.36.113.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9487019C4F;
 Tue, 19 May 2020 11:04:02 +0000 (UTC)
Date: Tue, 19 May 2020 13:04:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 5/9] block/io: expand in_flight inc/dec section:
 simple cases
Message-ID: <20200519110401.GJ7652@linux.fritz.box>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
 <20200427143907.5710-6-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200427143907.5710-6-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:56:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.04.2020 um 16:39 hat Vladimir Sementsov-Ogievskiy geschrieben:
> It's safer to expand in_flight request to start before enter to
> coroutine in synchronous wrappers, due to the following (theoretical)
> problem:
> 
> Consider write.
> It's possible, that qemu_coroutine_enter only schedules execution,
> assume such case.
> 
> Then we may possibly have the following:
> 
> 1. Somehow check that we are not in drained section in outer code.
> 
> 2. Call bdrv_pwritev(), assuming that it will increase in_flight, which
> will protect us from starting drained section.
> 
> 3. It calls bdrv_prwv_co() -> bdrv_coroutine_enter() (not yet increased
> in_flight).
> 
> 4. Assume coroutine not yet actually entered, only scheduled, and we go
> to some code, which starts drained section (as in_flight is zero).
> 
> 5. Scheduled coroutine starts, and blindly increases in_flight, and we
> are in drained section with in_flight request.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> diff --git a/block/io.c b/block/io.c
> index 061f3f2590..a91d8c1e21 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1511,7 +1511,8 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
>      return bdrv_co_preadv_part(child, offset, bytes, qiov, 0, flags);
>  }
>  
> -int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
> +/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */

You have lots of comments like this one. Isn't this condition too
strict, though?

In the BlockBackend layer, it needs to be true because
blk_wait_while_drained() decreases in_flight only once (which is an ugly
hack, honestly, but it works...). It's comparable to how
AIO_WAIT_WHILE() relies on having locked the context exactly once even
though it is a recursive lock, because it wants to drop the lock
temporarily.

I don't think the same reasoning applies to BDS in_flight, does it?

We can potentially simplify the code if we don't have to fulfill the
condition.

Kevin


