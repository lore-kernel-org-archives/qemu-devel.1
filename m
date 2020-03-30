Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46866C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1140820732
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J29cI6Hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1140820732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIpVJ-0003QF-33
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 04:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jIpUc-0002qa-5F
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jIpUb-0002j5-36
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:09:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32607)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jIpUb-0002i1-01
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585555796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3jnxmCb4UMXan50BeAyp+fJOVbc6faP6uDFVZKYd9A=;
 b=J29cI6HpP2rM9LRCgrqrGZYMqAhMJBob3D7tJzYMghtDdfcc1g0OtXjMnArzOB0ij04R0Y
 gLLq1uVoIc+oqdB3EhiI8K8VbiPjvBtvwM/oQrtLo1xcJ8K9AalNn3b4+PwD2a6xE0ryHT
 qDKI+bAxCQ+xV+Prz1ELL5Z0xTh6wUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-CIWUM-vzMd6danoAanVWbg-1; Mon, 30 Mar 2020 04:09:52 -0400
X-MC-Unique: CIWUM-vzMd6danoAanVWbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C4C313FA;
 Mon, 30 Mar 2020 08:09:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-69.ams2.redhat.com
 [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDD0260C63;
 Mon, 30 Mar 2020 08:09:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB9F311385E2; Mon, 30 Mar 2020 10:09:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Subject: Re: AIO_WAIT_WHILE questions
References: <1242491200.59.1585326983523@webmail.proxmox.com>
Date: Mon, 30 Mar 2020 10:09:45 +0200
In-Reply-To: <1242491200.59.1585326983523@webmail.proxmox.com> (Dietmar
 Maurer's message of "Fri, 27 Mar 2020 17:36:23 +0100 (CET)")
Message-ID: <87o8sexnzq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing people based on output of "scripts/get_maintainer.pl -f
include/block/aio-wait.h".

Dietmar Maurer <dietmar@proxmox.com> writes:

> Hi all,
>
> I have a question about AIO_WAIT_WHILE. The docs inside the code say:
>
>  * The caller's thread must be the IOThread that owns @ctx or the main lo=
op
>  * thread (with @ctx acquired exactly once).
>
> I wonder if that "with @ctx acquired exactly once" is always required?
>
> I have done a quick test (see code below) and this reveals that the condi=
tion is not
> always met.
>
> Or is my test wrong (or the docs)?
>
> ---debug helper---
> diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
> index afeeb18f95..cf78dca9f9 100644
> --- a/include/block/aio-wait.h
> +++ b/include/block/aio-wait.h
> @@ -82,6 +82,8 @@ extern AioWait global_aio_wait;
>      atomic_inc(&wait_->num_waiters);                               \
>      if (ctx_ && in_aio_context_home_thread(ctx_)) {                \
>          while ((cond)) {                                           \
> +            printf("AIO_WAIT_WHILE %p %d\n", ctx, ctx_->lock_count);    =
 \
> +            assert(ctx_->lock_count =3D=3D 1);                   \
>              aio_poll(ctx_, true);                                  \
>              waited_ =3D true;                                        \
>          }                                                          \
> diff --git a/include/block/aio.h b/include/block/aio.h
> index cb1989105a..51ef20e2f0 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -125,6 +125,7 @@ struct AioContext {
> =20
>      /* Used by AioContext users to protect from multi-threaded access.  =
*/
>      QemuRecMutex lock;
> +    int lock_count;
> =20
>      /* The list of registered AIO handlers.  Protected by ctx->list_lock=
. */
>      AioHandlerList aio_handlers;
> diff --git a/util/async.c b/util/async.c
> index b94518b948..9804c6c64f 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -594,9 +594,11 @@ void aio_context_unref(AioContext *ctx)
>  void aio_context_acquire(AioContext *ctx)
>  {
>      qemu_rec_mutex_lock(&ctx->lock);
> +    ctx->lock_count++;
>  }
> =20
>  void aio_context_release(AioContext *ctx)
>  {
> +    ctx->lock_count--;
>      qemu_rec_mutex_unlock(&ctx->lock);
>  }


