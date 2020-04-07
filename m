Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15640C2BB55
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BD7206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwypuMZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BD7206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLr5w-0005ox-18
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 12:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLr5B-0005GF-Sq
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLr5A-000751-D5
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:28:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39632
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLr5A-00073H-7z
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586276891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmbuCIN2ZHy3uroK5ZmOjgsKaSXYDPx2XmRfg8WlTrI=;
 b=OwypuMZRqMHvf5oT/XLh7daXF+KwpxhQNPeephZNNVbTuDI/8lDP2ePu+tOtd58kvRHaCS
 UZ2/xkdqK5FN1PLyz63Sy1CzYlChIF/PzTmI9wh3nuAYqsJb3ysDfJRceYYhC+kbY8uCSS
 09kRAvgVCpHoXMmax+k89bUsfvA5EQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-ZUDeKshYML28SQpt1sh8jg-1; Tue, 07 Apr 2020 12:28:09 -0400
X-MC-Unique: ZUDeKshYML28SQpt1sh8jg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 074F01005514;
 Tue,  7 Apr 2020 16:28:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-253.ams2.redhat.com [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C0A73AC;
 Tue,  7 Apr 2020 16:28:01 +0000 (UTC)
Date: Tue, 7 Apr 2020 18:27:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH for-5.0 v3 2/3] block: Increase BB.in_flight for
 coroutine and sync interfaces
Message-ID: <20200407162759.GH7695@linux.fritz.box>
References: <20200407121259.21350-1-kwolf@redhat.com>
 <20200407121259.21350-3-kwolf@redhat.com>
 <2a1985c1-5d36-6537-86f5-e95baaca7416@virtuozzo.com>
 <20200407144212.GG7695@linux.fritz.box>
 <399cb66a-528e-b92b-546f-a712608bcc14@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <399cb66a-528e-b92b-546f-a712608bcc14@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 dietmar@proxmox.com, stefanha@redhat.com, mreitz@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.04.2020 um 16:56 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 07.04.2020 17:42, Kevin Wolf wrote:
> > Am 07.04.2020 um 16:22 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > 07.04.2020 15:12, Kevin Wolf wrote:
> > > > External callers of blk_co_*() and of the synchronous blk_*() funct=
ions
> > > > don't currently increase the BlockBackend.in_flight counter, but ca=
lls
> > > > from blk_aio_*() do, so there is an inconsistency whether the count=
er
> > > > has been increased or not.
> > > >=20
> > > > This patch moves the actual operations to static functions that can
> > > > later know they will always be called with in_flight increased exac=
tly
> > > > once, even for external callers using the blk_co_*() coroutine
> > > > interfaces.
> > > >=20
> > > > If the public blk_co_*() interface is unused, remove it.
> > > >=20
> > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > >=20
> > > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > >=20
> > > side question:
> > >=20
> > > Should we inc/dec in blk_make_zero, blk_truncate?
> >=20
> > I don't think it's necessary. They call into their bdrv_* counterpart
> > immediately, so the node-level counter should be enough.
> >=20
>=20
> bdrv_make_zero is not one request, it does block_status/pwrite_zeroes
> in a loop. So drained section may occur during bdrv_make_zero.
> Possibly, nothing bad in it?

It would potentially be a problem if it were called in coroutine
context. But it's a synchronous function that must be called in the main
thread (and also only used in qemu-img), so I don't see how drain could
happen while it runs.

If we did want to make it safe for use in coroutine context, it would be
by using bdrv_inc/dec_in_flight() in bdrv_make_zero().

> blk_truncate may do coroutine_enter before incrementing node-level
> counter, which may only schedule it..

This is bdrv_truncate(), not blk_truncate(). If you address it in
blk_truncate(), you miss the direct callers of bdrv_truncate().

But you're right that it could potentially be a problem. Not sure if it
really is, but maybe better safe than sorry, so if you want to send a
patch, go ahead.

Kevin


