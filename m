Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C246C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47ED2053B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvuBbFz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47ED2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUR0G-0004vm-Qw
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kUQym-0003nw-V2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kUQyi-0004cO-8x
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 04:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603097834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A3lSPw/+2Qy1MXUftU1N8RdMG5oRHb0X9pYa67FC3Yg=;
 b=QvuBbFz1Bf10HhXGNhPAxDL4k9aKdF2iciwmhjAuP3oZTxagxO5OU24JFJWS0yklsfhUiL
 6eo6OKCMMtNc15svvaz4LCxHqSx216PT4dL6hiWe05qGuiw9C1TobdMqjeK/RPP831XEZ2
 qVQQmDukVQhvUQ34A3rNR+mnCdykmOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-J0ejQnfJNAO984SSMx-kSg-1; Mon, 19 Oct 2020 04:57:13 -0400
X-MC-Unique: J0ejQnfJNAO984SSMx-kSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 008608030A3;
 Mon, 19 Oct 2020 08:57:12 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-121.ams2.redhat.com [10.36.114.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11C3455781;
 Mon, 19 Oct 2020 08:57:07 +0000 (UTC)
Date: Mon, 19 Oct 2020 10:57:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PULL 09/14] qmp: Move dispatcher to a coroutine
Message-ID: <20201019085706.GA6508@merkur.fritz.box>
References: <20201009063432.303441-1-armbru@redhat.com>
 <20201009063432.303441-10-armbru@redhat.com>
 <b4a717b6-a709-f6a7-c992-3dca13fe792e@t-online.de>
MIME-Version: 1.0
In-Reply-To: <b4a717b6-a709-f6a7-c992-3dca13fe792e@t-online.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.10.2020 um 10:15 hat Volker Rümelin geschrieben:
> > From: Kevin Wolf <kwolf@redhat.com>
> >
> > This moves the QMP dispatcher to a coroutine and runs all QMP command
> > handlers that declare 'coroutine': true in coroutine context so they
> > can avoid blocking the main loop while doing I/O or waiting for other
> > events.
> >
> > For commands that are not declared safe to run in a coroutine, the
> > dispatcher drops out of coroutine context by calling the QMP command
> > handler from a bottom half.
> 
> Hi Kevin,
> 
> since commit 9ce44e2ce2 "qmp: Move dispatcher to a coroutine" I see
> the following error on Windows whenever I close the QEMU window or
> shut down the guest.
> 
> $ ./qemu-system-x86_64.exe -machine pc,accel=tcg -display gtk
> **
> ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion failed: (in_aio_context_home_thread(ctx))
> Bail out! ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion failed: (in_aio_context_home_thread(ctx))
> 
> I wonder if you forgot to apply the changes to util/aio-posix.c to
> util/aio-win32.c too? This solves the problem on my Windows host. But
> I have to admit I don't know the code here.

Hi Volker,

yes, you're right. The assertion in the Windows code was added only in
commit 5710a3e09f9 after I had posted some versions of the patch series,
so while I did check this initially, I missed during the rebase for
later versions of the series that I would have to update the patches for
Windows.

Would you like to send a patch for this? I could send one myself if you
prefer, but I can only compile-test Windows patches, so I'd have to rely
on your testing anyway.

Kevin

> > diff --git a/util/aio-posix.c b/util/aio-posix.c
> > index 280f27bb99..30f5354b1e 100644
> > --- a/util/aio-posix.c
> > +++ b/util/aio-posix.c
> > @@ -15,6 +15,7 @@
> >  
> >  #include "qemu/osdep.h"
> >  #include "block/block.h"
> > +#include "qemu/main-loop.h"
> >  #include "qemu/rcu.h"
> >  #include "qemu/rcu_queue.h"
> >  #include "qemu/sockets.h"
> > @@ -558,8 +559,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
> >       * There cannot be two concurrent aio_poll calls for the same AioContext (or
> >       * an aio_poll concurrent with a GSource prepare/check/dispatch callback).
> >       * We rely on this below to avoid slow locked accesses to ctx->notify_me.
> > +     *
> > +     * aio_poll() may only be called in the AioContext's thread. iohandler_ctx
> > +     * is special in that it runs in the main thread, but that thread's context
> > +     * is qemu_aio_context.
> >       */
> > -    assert(in_aio_context_home_thread(ctx));
> > +    assert(in_aio_context_home_thread(ctx == iohandler_get_aio_context() ?
> > +                                      qemu_get_aio_context() : ctx));
> >  
> >      qemu_lockcnt_inc(&ctx->list_lock);
> >  
> 


