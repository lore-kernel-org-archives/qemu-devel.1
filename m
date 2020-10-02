Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2512AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE15A206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RaRk+z4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE15A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOG1N-0005Hd-Q1
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOG0M-00048U-6v
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:01:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOG0K-0007L6-FD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601625683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=irB7e1cOWifyKCzC0f8Oh3RLfWvZPJeP2aD7JY60XMo=;
 b=RaRk+z4T4s9ynufkv8zxH+SUQj+NzNjx9TFaOTdOBoU8kZ7DrUL6Oydf5ZZxYeInaVpYA1
 CzKHjWR9LyAnFRuLpnE3FMNYtuoJG/xTxt2yVkLCdzpoRLSORUVwfn4cP6Mzy6/DcSI6jI
 1PI8QrN6II3PruXrI09Yuu45e/OHQJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-vuTzwSkiMr2-lQGeQMYHEQ-1; Fri, 02 Oct 2020 04:01:19 -0400
X-MC-Unique: vuTzwSkiMr2-lQGeQMYHEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7210190A3E0;
 Fri,  2 Oct 2020 08:01:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 638415D9D3;
 Fri,  2 Oct 2020 08:01:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A6F551132784; Fri,  2 Oct 2020 10:01:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 09/13] qmp: Move dispatcher to a coroutine
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-10-kwolf@redhat.com>
Date: Fri, 02 Oct 2020 10:01:13 +0200
In-Reply-To: <20200909151149.490589-10-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 9 Sep 2020 17:11:45 +0200")
Message-ID: <878scpoy46.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Additional nitpick detail on Kevin's request.

Kevin Wolf <kwolf@redhat.com> writes:

> This moves the QMP dispatcher to a coroutine and runs all QMP command
> handlers that declare 'coroutine': true in coroutine context so they
> can avoid blocking the main loop while doing I/O or waiting for other
> events.
>
> For commands that are not declared safe to run in a coroutine, the
> dispatcher drops out of coroutine context by calling the QMP command
> handler from a bottom half.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
[...]
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 629aa073ee..ac2722bf91 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -55,8 +55,32 @@ typedef struct {
>  /* Shared monitor I/O thread */
>  IOThread *mon_iothread;
>  
> -/* Bottom half to dispatch the requests received from I/O thread */
> -QEMUBH *qmp_dispatcher_bh;
> +/* Coroutine to dispatch the requests received from I/O thread */
> +Coroutine *qmp_dispatcher_co;
> +
> +/* Set to true when the dispatcher coroutine should terminate */
> +bool qmp_dispatcher_co_shutdown;
> +
> +/*
> + * qmp_dispatcher_co_busy is used for synchronisation between the
> + * monitor thread and the main thread to ensure that the dispatcher
> + * coroutine never gets scheduled a second time when it's already
> + * scheduled (scheduling the same coroutine twice is forbidden).
> + *
> + * It is true if the coroutine is active and processing requests.
> + * Additional requests may then be pushed onto mon->qmp_requests,
> + * and @qmp_dispatcher_co_shutdown may be set without further ado.
> + * @qmp_dispatcher_co_busy must not be woken up in this case.
> + *
> + * If false, you also have to set @qmp_dispatcher_co_busy to true and
> + * wake up @qmp_dispatcher_co after pushing the new requests.
> + *
> + * The coroutine will automatically change this variable back to false
> + * before it yields.  Nobody else may set the variable to false.
> + *
> + * Access must be atomic for thread safety.
> + */
> +bool qmp_dispatcher_co_busy;
>  
>  /*
>   * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
> @@ -623,9 +647,24 @@ void monitor_cleanup(void)
>      }
>      qemu_mutex_unlock(&monitor_lock);
>  
> -    /* QEMUBHs needs to be deleted before destroying the I/O thread */
> -    qemu_bh_delete(qmp_dispatcher_bh);
> -    qmp_dispatcher_bh = NULL;
> +    /*
> +     * The dispatcher needs to stop before destroying the I/O thread.
> +     *
> +     * We need to poll both qemu_aio_context and iohandler_ctx to make
> +     * sure that the dispatcher coroutine keeps making progress and
> +     * eventually terminates.  qemu_aio_context is automatically
> +     * polled by calling AIO_WAIT_WHILE on it, but we must poll
> +     * iohandler_ctx manually.
> +     */
> +    qmp_dispatcher_co_shutdown = true;
> +    if (!atomic_xchg(&qmp_dispatcher_co_busy, true)) {
> +        aio_co_wake(qmp_dispatcher_co);
> +    }
> +
> +    AIO_WAIT_WHILE(qemu_get_aio_context(),
> +                   (aio_poll(iohandler_get_aio_context(), false),
> +                    atomic_mb_read(&qmp_dispatcher_co_busy)));
> +
>      if (mon_iothread) {
>          iothread_destroy(mon_iothread);
>          mon_iothread = NULL;
> @@ -649,9 +688,9 @@ void monitor_init_globals_core(void)
>       * have commands assuming that context.  It would be nice to get
>       * rid of those assumptions.
>       */
> -    qmp_dispatcher_bh = aio_bh_new(iohandler_get_aio_context(),
> -                                   monitor_qmp_bh_dispatcher,
> -                                   NULL);
> +    qmp_dispatcher_co = qemu_coroutine_create(monitor_qmp_dispatcher_co, NULL);

Rather long line, caused by rather long identifiers.

Not your fault; you imitated the existing pattern static variable
qmp_dispatcher_bh / extern function monitor_qmp_bh_dispatcher().  But
the prefix monitor_qmp_ is awfully long, and not just here.  Let's leave
this for another day.

> +    atomic_mb_set(&qmp_dispatcher_co_busy, true);
> +    aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
>  }
>  
>  int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
[...]
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index f7f13ebfc2..30bb21d699 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -15,6 +15,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "block/block.h"
> +#include "qemu/main-loop.h"
>  #include "qemu/rcu.h"
>  #include "qemu/rcu_queue.h"
>  #include "qemu/sockets.h"
> @@ -558,8 +559,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
>       * There cannot be two concurrent aio_poll calls for the same AioContext (or
>       * an aio_poll concurrent with a GSource prepare/check/dispatch callback).
>       * We rely on this below to avoid slow locked accesses to ctx->notify_me.
> +     *
> +     * aio_poll() may only be called in the AioContext's thread. iohandler_ctx
> +     * is special in that it runs in the main thread, but that thread's context
> +     * is qemu_aio_context.

Wrapping the comment around column 70 or so would make it easier to
read.  Up to you.

>       */
> -    assert(in_aio_context_home_thread(ctx));
> +    assert(in_aio_context_home_thread(ctx == iohandler_get_aio_context() ?
> +                                      qemu_get_aio_context() : ctx));
>  
>      qemu_lockcnt_inc(&ctx->list_lock);


