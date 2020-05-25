Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD498C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 16:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A097D2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 16:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOUYYzRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A097D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdGCD-0004oO-ID
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 12:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jdGAt-0003rk-Dc
 for qemu-devel@nongnu.org; Mon, 25 May 2020 12:42:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53512
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jdGAs-00011e-IN
 for qemu-devel@nongnu.org; Mon, 25 May 2020 12:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590424921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=heJEOUcJzXhi1J8ZU28yazzfD/jbNYRkqQ0AKy4C6/8=;
 b=hOUYYzRgQAkPLx/qNddT8Dh1zFB3M1UOx9LcvwkfXsUjXXj8ELurn6uKlAqpv+dNql6Rrw
 6EV4l333uXpZpWfA9obdx7xc36qbGLTOmo3CWzsyq4/D13bagvYcTJeurZqTHgCBckirxE
 JDwphe/UrJpzFrGCm1yHvdsZCv2Zp8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-Svkxf6D4OG69YTRSEVNdHA-1; Mon, 25 May 2020 12:41:58 -0400
X-MC-Unique: Svkxf6D4OG69YTRSEVNdHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 987EA100726A;
 Mon, 25 May 2020 16:41:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-91.ams2.redhat.com [10.36.114.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 565FF60BE1;
 Mon, 25 May 2020 16:41:51 +0000 (UTC)
Date: Mon, 25 May 2020 18:41:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Reiter <s.reiter@proxmox.com>
Subject: Re: [RFC PATCH 2/3] block: Allow bdrv_run_co() from different
 AioContext
Message-ID: <20200525164150.GD19863@linux.fritz.box>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <20200512144318.181049-3-kwolf@redhat.com>
 <2ab7bae7-03c3-f269-1db1-202aeb41bdf3@proxmox.com>
MIME-Version: 1.0
In-Reply-To: <2ab7bae7-03c3-f269-1db1-202aeb41bdf3@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:55:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, mreitz@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.05.2020 um 16:18 hat Stefan Reiter geschrieben:
> On 5/12/20 4:43 PM, Kevin Wolf wrote:
> > Coroutine functions that are entered through bdrv_run_co() are already
> > safe to call from synchronous code in a different AioContext because
> > bdrv_coroutine_enter() will schedule them in the context of the node.
> > 
> > However, the coroutine fastpath still requires that we're already in the
> > right AioContext when called in coroutine context.
> > 
> > In order to make the behaviour more consistent and to make life a bit
> > easier for callers, let's check the AioContext and automatically move
> > the current coroutine around if we're not in the right context yet.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/io.c | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/io.c b/block/io.c
> > index c1badaadc9..7808e8bdc0 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -895,8 +895,21 @@ static int bdrv_run_co(BlockDriverState *bs, CoroutineEntry *entry,
> >                          void *opaque, int *ret)
> >   {
> >       if (qemu_in_coroutine()) {
> > -        /* Fast-path if already in coroutine context */
> > +        Coroutine *self = qemu_coroutine_self();
> > +        AioContext *bs_ctx = bdrv_get_aio_context(bs);
> > +        AioContext *co_ctx = qemu_coroutine_get_aio_context(self);
> > +
> > +        if (bs_ctx != co_ctx) {
> > +            /* Move to the iothread of the node */
> > +            aio_co_schedule(bs_ctx, self);
> > +            qemu_coroutine_yield();
> 
> I'm pretty sure this can lead to a race: When the thread we're re-scheduling
> to is faster to schedule us than we can reach qemu_coroutine_yield, then
> we'll get an abort ("Co-routine re-entered recursively"), since co->caller
> is still set.
> 
> I've seen this happen in our code when I try to do the scheduling fandangle
> there.

Ah, crap. I guess letting a coroutine re-schedule itself is only safe
within the same thread then.

> Is there a safer way to have a coroutine reschedule itself? Some lock
> missing?

There is no problem that can't be solved by adding another level of
indirection... We would have to schedule a BH in the original thread
that will only schedule the coroutine in its new thread after it has
yielded.

Maybe we should actually introduce a helper function that moves the
current coroutine to a different AioContext this way.

Kevin


