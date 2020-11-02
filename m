Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737A4C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 12:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E2122268
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 12:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E2122268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZZJW-0000NN-05
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 07:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kZZIk-0008II-Hk; Mon, 02 Nov 2020 07:51:10 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:58610
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kZZIh-0005T3-3S; Mon, 02 Nov 2020 07:51:09 -0500
Received: from host81-158-111-11.range81-158.btcentralplus.com
 ([81.158.111.11] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kZZIf-0006jT-QS; Mon, 02 Nov 2020 12:51:09 +0000
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Weil <sw@weilnetz.de>
References: <20201021064033.8600-1-vr_qemu@t-online.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <87eed2b3-d9a6-a1d1-e12a-e74bcbc9a702@ilande.co.uk>
Date: Mon, 2 Nov 2020 12:50:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201021064033.8600-1-vr_qemu@t-online.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.111.11
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] qmp: fix aio_poll() assertion failure on Windows
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2020 07:40, Volker Rümelin wrote:

> Commit 9ce44e2ce2 "qmp: Move dispatcher to a coroutine" modified
> aio_poll() in util/aio-posix.c to avoid an assertion failure. This
> change is missing in util/aio-win32.c.
> 
> Apply the changes to util/aio-posix.c to util/aio-win32.c too.
> This fixes an assertion failure on Windows whenever QEMU exits.
> 
> $ ./qemu-system-x86_64.exe -machine pc,accel=tcg -display gtk
> **
> ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion failed:
> (in_aio_context_home_thread(ctx))
> Bail out! ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion
> failed: (in_aio_context_home_thread(ctx))
> 
> Fixes: 9ce44e2ce2 ("qmp: Move dispatcher to a coroutine")
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> ---
>   util/aio-win32.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/util/aio-win32.c b/util/aio-win32.c
> index e7b1d649e9..168717b51b 100644
> --- a/util/aio-win32.c
> +++ b/util/aio-win32.c
> @@ -18,6 +18,7 @@
>   #include "qemu/osdep.h"
>   #include "qemu-common.h"
>   #include "block/block.h"
> +#include "qemu/main-loop.h"
>   #include "qemu/queue.h"
>   #include "qemu/sockets.h"
>   #include "qapi/error.h"
> @@ -333,8 +334,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
>        * There cannot be two concurrent aio_poll calls for the same AioContext (or
>        * an aio_poll concurrent with a GSource prepare/check/dispatch callback).
>        * We rely on this below to avoid slow locked accesses to ctx->notify_me.
> +     *
> +     * aio_poll() may only be called in the AioContext's thread. iohandler_ctx
> +     * is special in that it runs in the main thread, but that thread's context
> +     * is qemu_aio_context.
>        */
> -    assert(in_aio_context_home_thread(ctx));
> +    assert(in_aio_context_home_thread(ctx == iohandler_get_aio_context() ?
> +                                      qemu_get_aio_context() : ctx));
>       progress = false;
>   
>       /* aio_notify can avoid the expensive event_notifier_set if

Sorry about the delay, however I've just tried this on top of git master and it fixes 
the problem with the assert() when exiting QEMU on Win32 so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Is it possible to get this merged for 5.2?


ATB,

Mark.

