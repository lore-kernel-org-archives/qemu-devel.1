Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E846C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687D72190F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSZTNlTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687D72190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFTk-0004Ma-El
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56521)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hqFTZ-0003yC-GQ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hqFTY-0005zv-4R
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:30:29 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hqFTX-0005zc-Uw
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:30:28 -0400
Received: by mail-io1-xd41.google.com with SMTP id i10so88723572iol.13
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gfi8x9UBu19AA2pNf1uooYnrBEdMNifXC/4O8tIbwlo=;
 b=lSZTNlTz3EcrkGySB5Ht9qg4gyD91ZQo6C/WJiyUD9iyGfRPunEKKkrerjqOrJZzDm
 yxhvj84gZDmVDOBajzIwGwwTczZsyQk5Mo1AWniPMdW9CmSFXQkTlslQJ5ysPmUAM9AR
 lvKOtNGJBkwCx9/gwVj5xCGHTPvfDuQZd0zaFoH2FkCkZZQKkep3zYz9CHmRWepRgF/K
 gDZsd9YNkLnny84yWheoZ+rvwGj6BxJK/WGanC3bz+aNnT49Q7H/a6T+EdCjMCMyBoDC
 vRAU9/NRbM89lEDMrL+5kZguGjq4t2AhjJOPNXS96l5Id+yejNNBH1gT+hQaJ81rEmMm
 4mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gfi8x9UBu19AA2pNf1uooYnrBEdMNifXC/4O8tIbwlo=;
 b=EKTXivTKPHo1U1aOyXfXHhM6HUox5S+UnNU4/SMobVJjnHVdYpqyUwPdsPOmf4YuLR
 Hw2STUPYBEJps2Xs36czoomlaPo/Qid0pHsj3bRV/Wv5DD5BLMGNzyI3sbENYXILIWHl
 7QoH4wb+A9/CgRIrPIRhRZRLpxx7WPvj0pZSvwFUbNUKFvjgIKDUvSyEMyVBtff6lqOD
 0RXJd7xL2UcckoRSj8Y4D9w8l8ssSw4wyDinBqNHjGF2egASPnqTvT6o9aZyDQG5dCzw
 6su/bXiy8MP9LiLeNBZ+fDnZKjKk79tBS41MFPmqXXY4E2YtZdLf1o8eQr+Yz7ibSj3F
 /MDg==
X-Gm-Message-State: APjAAAWg0CtsGaEwDSbXJf5IqijkkjRjPWnIcuevVSXH3/7gkxfBtJds
 yoFdGudA2z+xWpv4S+qJUs10k6e7qz9ygWFZI/UlmXZS
X-Google-Smtp-Source: APXvYqzK1QlOoYFGCLbWk7Y2LuKtpZv0akPUyQuJoH9O0zlddvgmEJdUzH6Q3GwYKXuMMDxUq5uIc40T9OcMJs8KMGg=
X-Received: by 2002:a05:6602:2248:: with SMTP id
 o8mr11700516ioo.90.1563967827200; 
 Wed, 24 Jul 2019 04:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
 <1561468699-9819-4-git-send-email-ivanren@tencent.com>
 <878ssn957w.fsf@trasno.org>
In-Reply-To: <878ssn957w.fsf@trasno.org>
From: Ivan Ren <renyime@gmail.com>
Date: Wed, 24 Jul 2019 19:30:15 +0800
Message-ID: <CA+6E1=mGdbfqFNyOk-r5H2C8Rm1tJmQyu37n-Bw24Ns-vZ4iyg@mail.gmail.com>
To: quintela@redhat.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d41
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 3/3] migration: fix migrate_cancel multifd
 migration leads destination hung forever
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
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> If we just post it there, we get out of the wait (that bit is ok), but
> then we go back to the beggining of the bucle, we (probably) got one
> error on the qui_channel_read_all_eof(), and we go back to
> multifd_recv_terminate_threads(), or wait there.
>
> I think that it is better to *also* set an p->quit variable there, and
> not even try to receive anything for that channel?
>
> I will send a patch later.

Yes, agree.

Thanks for review.

On Wed, Jul 24, 2019 at 5:01 PM Juan Quintela <quintela@redhat.com> wrote:

> Ivan Ren <renyime@gmail.com> wrote:
> > When migrate_cancel a multifd migration, if run sequence like this:
> >
> >         [source]                              [destination]
> >
> > multifd_send_sync_main[finish]
> >                                     multifd_recv_thread wait &p->sem_sync
> > shutdown to_dst_file
> >                                     detect error from_src_file
> > send  RAM_SAVE_FLAG_EOS[fail]       [no chance to run
> multifd_recv_sync_main]
> >                                     multifd_load_cleanup
> >                                     join multifd receive thread forever
> >
> > will lead destination qemu hung at following stack:
> >
> > pthread_join
> > qemu_thread_join
> > multifd_load_cleanup
> > process_incoming_migration_co
> > coroutine_trampoline
> >
> > Signed-off-by: Ivan Ren <ivanren@tencent.com>
>
> I think this one is not enough.  We need to set some error code, or
> disable the running bit at that point.
>
> > ---
> >  migration/ram.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index e4eb9c441f..504c8ccb03 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1291,6 +1291,11 @@ int multifd_load_cleanup(Error **errp)
> >          MultiFDRecvParams *p = &multifd_recv_state->params[i];
> >
> >          if (p->running) {
> > +            /*
> > +             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle
> code,
> > +             * however try to wakeup it without harm in cleanup phase.
> > +             */
> > +            qemu_sem_post(&p->sem_sync);
> >              qemu_thread_join(&p->thread);
> >          }
> >          object_unref(OBJECT(p->c));
>
> Let's see where we wait for p->sem_sync:
>
>
> static void *multifd_recv_thread(void *opaque)
> {
>     ....
>     while (true) {
>         uint32_t used;
>         uint32_t flags;
>
>         ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
>                                        p->packet_len, &local_err);
>         .....
>
>         if (flags & MULTIFD_FLAG_SYNC) {
>             qemu_sem_post(&multifd_recv_state->sem_sync);
>             qemu_sem_wait(&p->sem_sync);
>         }
>     }
>     if (local_err) {
>         multifd_recv_terminate_threads(local_err);
>     }
>     qemu_mutex_lock(&p->mutex);
>     p->running = false;
>     qemu_mutex_unlock(&p->mutex);
>
>     rcu_unregister_thread();
>     trace_multifd_recv_thread_end(p->id, p->num_packets, p->num_pages);
>
>     return NULL;
> }
>
> If we just post it there, we get out of the wait (that bit is ok), but
> then we go back to the beggining of the bucle, we (probably) got one
> error on the qui_channel_read_all_eof(), and we go back to
> multifd_recv_terminate_threads(), or wait there.
>
> I think that it is better to *also* set an p->quit variable there, and
> not even try to receive anything for that channel?
>
> I will send a patch later.
>
> Good catch.
>
> Later, Juan.
>
