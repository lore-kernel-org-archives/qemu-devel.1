Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9E3CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286EA20731
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtcL2BsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286EA20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYabo-0006jl-Nc
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYab8-0006IO-Py
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:29:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54168
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYab7-0000Tq-9z
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589311787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gmNWDb62fuyfkGKWf0p60j1p/gC3dNJPII2irB8HB4U=;
 b=HtcL2BsFySsfC4Y8tdcRKcyaHsi0LeTaBIRFb5rAN0i/hv9L2+iNOeL9rFKZJD/ElIaXcA
 gpTBGrdmdkItlZBZMTXiiDlvDiqyV4Yus/ufFnHLt0Ss/fNLX+bV+26GZADTvQU/1A+psL
 hWw5MrXV2h30jDQwRiapJ+KwnzcCOSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-iT1BZAoEMB-QZCzR2zPbdA-1; Tue, 12 May 2020 15:29:44 -0400
X-MC-Unique: iT1BZAoEMB-QZCzR2zPbdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EC10800688;
 Tue, 12 May 2020 19:29:43 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-74.ams2.redhat.com [10.36.114.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A98DA1CC;
 Tue, 12 May 2020 19:29:38 +0000 (UTC)
Date: Tue, 12 May 2020 21:29:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [RFC PATCH 2/3] block: Allow bdrv_run_co() from different
 AioContext
Message-ID: <20200512192936.GM5951@linux.fritz.box>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <20200512144318.181049-3-kwolf@redhat.com>
 <47293da5-b5e5-e61f-753d-4d16712f6d12@proxmox.com>
MIME-Version: 1.0
In-Reply-To: <47293da5-b5e5-e61f-753d-4d16712f6d12@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.05.2020 um 18:02 hat Thomas Lamprecht geschrieben:
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
> >  block/io.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/io.c b/block/io.c
> > index c1badaadc9..7808e8bdc0 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -895,8 +895,21 @@ static int bdrv_run_co(BlockDriverState *bs, CoroutineEntry *entry,
> >                         void *opaque, int *ret)
> >  {
> >      if (qemu_in_coroutine()) {
> > -        /* Fast-path if already in coroutine context */
> > +        Coroutine *self = qemu_coroutine_self();
> > +        AioContext *bs_ctx = bdrv_get_aio_context(bs);
> > +        AioContext *co_ctx = qemu_coroutine_get_aio_context(self);
> > +
> > +        if (bs_ctx != co_ctx) {
> > +            /* Move to the iothread of the node */
> > +            aio_co_schedule(bs_ctx, self);
> > +            qemu_coroutine_yield();
> > +        }
> >          entry(opaque);
> > +        if (bs_ctx != co_ctx) {
> > +            /* Move back to the original AioContext */
> > +            aio_co_schedule(bs_ctx, self);
> 
> shouldn't it use co_ctx here, as else it's just scheduled again on the
> one from bs?

Oops, you're right, of course.

> Looks OK for me besides that.

Thanks!

Kevin


