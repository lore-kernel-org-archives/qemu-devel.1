Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3267C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA5D206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJrgtmjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA5D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOG3M-0007NO-Ho
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOG0t-0004xT-P9
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kOG0r-0007QK-UT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 04:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601625717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8fC4w/pl3p5/oAwmbIRlfr7bdwX19ZGdX5a7g4b7m8M=;
 b=hJrgtmjcEouL+hxfu3tBLX1fUt9qd9h+Uyf/SPEQnZ9bvE9bXofCdDAvz74IkZMOiameOQ
 qz7D7snylAwev8a3yen/eDZebIJvWgCwhDKDGThuHYOoGmUfhLpm+l2iVJkDHsPCq05hvD
 0Z+/uWWaZZ/2O49onfnr9TwUjqjBTfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-BfUCya37Pbi8D9xloSeC8g-1; Fri, 02 Oct 2020 04:01:55 -0400
X-MC-Unique: BfUCya37Pbi8D9xloSeC8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C77664086;
 Fri,  2 Oct 2020 08:01:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52FD060C17;
 Fri,  2 Oct 2020 08:01:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C58A81132784; Fri,  2 Oct 2020 10:01:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v7 11/13] util/async: Add aio_co_reschedule_self()
References: <20200909151149.490589-1-kwolf@redhat.com>
 <20200909151149.490589-12-kwolf@redhat.com>
Date: Fri, 02 Oct 2020 10:01:49 +0200
In-Reply-To: <20200909151149.490589-12-kwolf@redhat.com> (Kevin Wolf's message
 of "Wed, 9 Sep 2020 17:11:47 +0200")
Message-ID: <875z7toy36.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Additional nitpick detail on Kevin's request.

Kevin Wolf <kwolf@redhat.com> writes:

> Add a function that can be used to move the currently running coroutine
> to a different AioContext (and therefore potentially a different
> thread).
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/aio.h | 10 ++++++++++
>  util/async.c        | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/include/block/aio.h b/include/block/aio.h
> index b2f703fa3f..c37617b404 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -17,6 +17,7 @@
>  #ifdef CONFIG_LINUX_IO_URING
>  #include <liburing.h>
>  #endif
> +#include "qemu/coroutine.h"
>  #include "qemu/queue.h"
>  #include "qemu/event_notifier.h"
>  #include "qemu/thread.h"
> @@ -654,6 +655,15 @@ static inline bool aio_node_check(AioContext *ctx, bool is_external)
>   */
>  void aio_co_schedule(AioContext *ctx, struct Coroutine *co);
>  
> +/**
> + * aio_co_reschedule_self:
> + * @new_ctx: the new context
> + *
> + * Move the currently running coroutine to new_ctx. If the coroutine is already
> + * running in new_ctx, do nothing.

Wrapping the comment around column 70 or so would make it easier to
read.  Up to you.

> + */
> +void coroutine_fn aio_co_reschedule_self(AioContext *new_ctx);
> +
>  /**
>   * aio_co_wake:
>   * @co: the coroutine
> diff --git a/util/async.c b/util/async.c
> index 4266745dee..a609e18693 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -569,6 +569,36 @@ void aio_co_schedule(AioContext *ctx, Coroutine *co)
>      aio_context_unref(ctx);
>  }
>  
> +typedef struct AioCoRescheduleSelf {
> +    Coroutine *co;
> +    AioContext *new_ctx;
> +} AioCoRescheduleSelf;
> +
> +static void aio_co_reschedule_self_bh(void *opaque)
> +{
> +    AioCoRescheduleSelf *data = opaque;
> +    aio_co_schedule(data->new_ctx, data->co);
> +}
> +
> +void coroutine_fn aio_co_reschedule_self(AioContext *new_ctx)
> +{
> +    AioContext *old_ctx = qemu_get_current_aio_context();
> +
> +    if (old_ctx != new_ctx) {
> +        AioCoRescheduleSelf data = {
> +            .co = qemu_coroutine_self(),
> +            .new_ctx = new_ctx,
> +        };
> +        /*
> +         * We can't directly schedule the coroutine in the target context
> +         * because this would be racy: The other thread could try to enter the
> +         * coroutine before it has yielded in this one.
> +         */

Likewise.

> +        aio_bh_schedule_oneshot(old_ctx, aio_co_reschedule_self_bh, &data);
> +        qemu_coroutine_yield();
> +    }
> +}
> +
>  void aio_co_wake(struct Coroutine *co)
>  {
>      AioContext *ctx;


