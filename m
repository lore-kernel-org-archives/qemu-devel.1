Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E314EC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8AD20880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8AD20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnNCV-0006y3-Ho
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 09:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44885)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hnNCC-0005u6-Nc
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hnNCA-0002Si-K0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:08:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44025)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hnNC8-0002Po-7f; Tue, 16 Jul 2019 09:08:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D71D308338E;
 Tue, 16 Jul 2019 13:08:35 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46627600C4;
 Tue, 16 Jul 2019 13:08:34 +0000 (UTC)
Message-ID: <8e029ef60c0318774e14d487a0ddc3766da37228.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 16 Jul 2019 16:08:33 +0300
In-Reply-To: <20190712173600.14554-2-mreitz@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
 <20190712173600.14554-2-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 16 Jul 2019 13:08:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/7] block/nbd: Fix hang in
 .bdrv_close()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-07-12 at 19:35 +0200, Max Reitz wrote:
> When nbd_close() is called from a coroutine, the connection_co never
> gets to run, and thus nbd_teardown_connection() hangs.
> 
> This is because aio_co_enter() only puts the connection_co into the main
> coroutine's wake-up queue, so this main coroutine needs to yield and
> wait for connection_co to terminate.

After diving into NBD's co-routines (this is 2nd time I do this) and speaking about this
with Max Reitz on IRC, could I suggest to extend the explanation a bit, something like that:


When nbd_close() is called from a coroutine, the connection_co never
gets to run, and thus nbd_teardown_connection() hangs.

This happens because the connection_co is woken up by nbd_teardown_connection() by closing the socket, 
which wakes up the IO channel on which the connection_co is blocked.

However connection_co is waken up by aio_co_wake, which has an assumption that if the caller is already in
a coroutine, the caller doesn't switch immediately to the woken coroutine, but rather it adds the coroutine to list
of coroutines to wake immediately after the current co-routine yields/terminates (self->co_queue_wakeup)
Since we instead do aio_poll, that never happens.


The patch itself looks fine, so
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/nbd.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 81edabbf35..8f5ee86842 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -61,6 +61,7 @@ typedef struct BDRVNBDState {
>      CoMutex send_mutex;
>      CoQueue free_sema;
>      Coroutine *connection_co;
> +    Coroutine *teardown_co;
>      int in_flight;
>  
>      NBDClientRequest requests[MAX_NBD_REQUESTS];
> @@ -135,7 +136,15 @@ static void nbd_teardown_connection(BlockDriverState *bs)
>      qio_channel_shutdown(s->ioc,
>                           QIO_CHANNEL_SHUTDOWN_BOTH,
>                           NULL);
> -    BDRV_POLL_WHILE(bs, s->connection_co);
> +    if (qemu_in_coroutine()) {
> +        s->teardown_co = qemu_coroutine_self();
> +        /* connection_co resumes us when it terminates */
> +        qemu_coroutine_yield();
> +        s->teardown_co = NULL;
> +    } else {
> +        BDRV_POLL_WHILE(bs, s->connection_co);
> +    }
> +    assert(!s->connection_co);
>  
>      nbd_client_detach_aio_context(bs);
>      object_unref(OBJECT(s->sioc));
> @@ -207,6 +216,9 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
>      bdrv_dec_in_flight(s->bs);
>  
>      s->connection_co = NULL;
> +    if (s->teardown_co) {
> +        aio_co_wake(s->teardown_co);
> +    }
>      aio_wait_kick();
>  }
>  



