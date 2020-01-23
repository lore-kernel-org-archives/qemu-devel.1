Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D293C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1570421D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVYlypZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1570421D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iulNl-0000BD-7J
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 17:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iulNC-000873-PM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:54:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iulNB-0001JX-7v
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:54:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iulNB-0001Ip-4y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579820088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ALGPFl9/JBt2bJ+7NDUfxft2FZGhvmy7DnuuUMUPD0=;
 b=FVYlypZ062KuHoyOuLoWXHicMwAyWp8FPO1F6Yhwcbx4SEDytOAGZ522yo+/EpXTdy94FJ
 1D+bgLzX0nLmh6QH2j2V+HSsVlCEm4qos5rmBDLuCC4+ygFVIBxQmv9vfegT3u05JlAmpd
 HwKjvlxENK7tCUlKHh7y7VNlOQu67dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-jTxQtVD0MhKZl1P5Bs1txg-1; Thu, 23 Jan 2020 17:54:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21566800D48;
 Thu, 23 Jan 2020 22:54:44 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B80BD86456;
 Thu, 23 Jan 2020 22:54:42 +0000 (UTC)
Message-ID: <b3399a19c62999d05ddcf444607edf9e2cebf293.camel@redhat.com>
Subject: Re: [PATCH v2 1/5] block/nbd: Fix hang in .bdrv_close()
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Fri, 24 Jan 2020 00:54:41 +0200
In-Reply-To: <20200122164532.178040-2-mreitz@redhat.com>
References: <20200122164532.178040-1-mreitz@redhat.com>
 <20200122164532.178040-2-mreitz@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: jTxQtVD0MhKZl1P5Bs1txg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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

On Wed, 2020-01-22 at 17:45 +0100, Max Reitz wrote:
> When nbd_close() is called from a coroutine, the connection_co never
> gets to run, and thus nbd_teardown_connection() hangs.
> 
> This is because aio_co_enter() only puts the connection_co into the main
> coroutine's wake-up queue, so this main coroutine needs to yield and
> wait for connection_co to terminate.

Took me a while to understand this back then, good that I explained
my thoughts in the review comment, although the commit message
is alright when you already understand qemu co-routines I guess.

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
> index d085554f21..6d3b22f844 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -70,6 +70,7 @@ typedef struct BDRVNBDState {
>      CoMutex send_mutex;
>      CoQueue free_sema;
>      Coroutine *connection_co;
> +    Coroutine *teardown_co;
>      QemuCoSleepState *connection_co_sleep_ns_state;
>      bool drained;
>      bool wait_drained_end;
> @@ -203,7 +204,15 @@ static void nbd_teardown_connection(BlockDriverState *bs)
>              qemu_co_sleep_wake(s->connection_co_sleep_ns_state);
>          }
>      }
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
>  }
>  
>  static bool nbd_client_connecting(BDRVNBDState *s)
> @@ -395,6 +404,9 @@ static coroutine_fn void nbd_connection_entry(void *opaque)
>          s->ioc = NULL;
>      }
>  
> +    if (s->teardown_co) {
> +        aio_co_wake(s->teardown_co);
> +    }
>      aio_wait_kick();
>  }
>  



