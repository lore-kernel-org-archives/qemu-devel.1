Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E14C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 08:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00DAC2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 08:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DAC2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kThOR-0006AK-Pj
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 04:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kThNL-0005Su-6h
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 04:15:40 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:60030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kThNF-0000ot-Uw
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 04:15:38 -0400
Received: from fwd07.aul.t-online.de (fwd07.aul.t-online.de [172.20.27.150])
 by mailout11.t-online.de (Postfix) with SMTP id B50F3421834C;
 Sat, 17 Oct 2020 10:15:28 +0200 (CEST)
Received: from [192.168.211.200]
 (bLgi7iZUghhdtzrmJz12GIi+NEItmFJavak75v9CeOiICfydMfbO8f9cTUbpLyAwyu@[46.86.52.112])
 by fwd07.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kThNA-1Hj59s0; Sat, 17 Oct 2020 10:15:28 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PULL 09/14] qmp: Move dispatcher to a coroutine
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
References: <20201009063432.303441-1-armbru@redhat.com>
 <20201009063432.303441-10-armbru@redhat.com>
Message-ID: <b4a717b6-a709-f6a7-c992-3dca13fe792e@t-online.de>
Date: Sat, 17 Oct 2020 10:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009063432.303441-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ID: bLgi7iZUghhdtzrmJz12GIi+NEItmFJavak75v9CeOiICfydMfbO8f9cTUbpLyAwyu
X-TOI-EXPURGATEID: 150726::1602922528-0000DD00-728CEEEE/0/0 CLEAN NORMAL
X-TOI-MSGID: 3bb97b43-50df-4b6b-b8cc-188c09dadf76
Received-SPF: none client-ip=194.25.134.85; envelope-from=vr_qemu@t-online.de;
 helo=mailout11.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 04:15:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Kevin Wolf <kwolf@redhat.com>
>
> This moves the QMP dispatcher to a coroutine and runs all QMP command
> handlers that declare 'coroutine': true in coroutine context so they
> can avoid blocking the main loop while doing I/O or waiting for other
> events.
>
> For commands that are not declared safe to run in a coroutine, the
> dispatcher drops out of coroutine context by calling the QMP command
> handler from a bottom half.

Hi Kevin,

since commit 9ce44e2ce2 "qmp: Move dispatcher to a coroutine" I see the following error on Windows whenever I close the QEMU window or shut down the guest.

$ ./qemu-system-x86_64.exe -machine pc,accel=tcg -display gtk
**
ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion failed: (in_aio_context_home_thread(ctx))
Bail out! ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion failed: (in_aio_context_home_thread(ctx))

I wonder if you forgot to apply the changes to util/aio-posix.c to util/aio-win32.c too? This solves the problem on my Windows host. But I have to admit I don't know the code here.

With best regards,
Volker

> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 280f27bb99..30f5354b1e 100644
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
>       */
> -    assert(in_aio_context_home_thread(ctx));
> +    assert(in_aio_context_home_thread(ctx == iohandler_get_aio_context() ?
> +                                      qemu_get_aio_context() : ctx));
>  
>      qemu_lockcnt_inc(&ctx->list_lock);
>  


