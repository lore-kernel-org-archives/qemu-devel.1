Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0209C2BB54
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88510206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLJrM4TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88510206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkqw-0001Wm-Hh
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLkqH-0000tp-Vp
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLkqG-0001Mc-Vc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:48:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLkqG-0001ML-S9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586252904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UvXLeebXthRjhz/u39d0nit40slD7qH+coES7W1ViCk=;
 b=JLJrM4TErHjJMmyfImLLCQ6Wz6JIKVfrs8iA5J0XbdrxwMgKcANlQt9ixxXiKE+Rk0KO3d
 8ZWFPvcY4FJOOmMyG739PXogzmbgzTY0Lgtqw2omR9S5Vn5BEBIZBRWW/7k8Mf5BQS7bru
 cHC/Eb9zj805Brday3TfvrgESZ2exjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-pmBM88qwN3ek3R93vWdTJw-1; Tue, 07 Apr 2020 05:48:22 -0400
X-MC-Unique: pmBM88qwN3ek3R93vWdTJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41A66107ACC9;
 Tue,  7 Apr 2020 09:48:21 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-253.ams2.redhat.com [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82EEC9D376;
 Tue,  7 Apr 2020 09:48:16 +0000 (UTC)
Date: Tue, 7 Apr 2020 11:48:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH for-5.0 v2 2/3] block: Increase BB.in_flight for
 coroutine interfaces
Message-ID: <20200407094814.GC7695@linux.fritz.box>
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-3-kwolf@redhat.com>
 <9d0aa9cc-61a1-fd14-357e-6fb0ba2742dd@virtuozzo.com>
 <20200407085216.GA7695@linux.fritz.box>
 <b1a2cb59-7969-5bb7-f5ce-ec4ab51199cb@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <b1a2cb59-7969-5bb7-f5ce-ec4ab51199cb@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 dietmar@proxmox.com, stefanha@redhat.com, mreitz@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.04.2020 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 07.04.2020 11:52, Kevin Wolf wrote:
> > Am 07.04.2020 um 08:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > 06.04.2020 20:14, Kevin Wolf wrote:
> > > > External callers of blk_co_*() don't currently increase the
> > > > BlockBackend.in_flight counter, but calls from blk_aio_*() do, so t=
here
> > > > is an inconsistency whether the counter has been increased or not.
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
> > >=20
> > > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > >=20
> > > Still, did you consider instead just move inc/dec to _co_ functions, =
like
> > > [...]
> > > (and same for write, ioctl, flush, discard). It seems more
> > > consistent.. Should it work?
> >=20
> > No, it would be wrong because it would be too late. The main purpose of
> > blk_inc_in_flight() is to keep the request covered during the first and
> > the last phase outside of blk_co_*(), which can potentially involve BHs
> > like blk_aio_complete_bh().
>=20
> OK, thanks, I see now, we want to caver possible completion BH.
> Hmm, not too late but too early (for decrement).. As nothing interesting
> happening between increment in blk_aio_prwv and entering the coroutine wi=
th
> _do_ function.

Basically it covers everything that isn't yet covered by
bdrv_inc/dec_in_flight() on the node level, but completion is probably
the most important part.

Start, too, because actually something very interesting is happening
between blk_aio_prwv() and blk_do_*(): It uses bdrv_coroutine_enter(),
which in some circumstances may end up only scheduling the coroutine
instead of immediately entering it.

Kevin


