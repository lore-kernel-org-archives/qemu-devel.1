Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B82C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCA12084D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCA12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqD9H-00044n-Ir
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 05:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38777)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hqD96-0003gX-Ej
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hqD95-0006xT-CI
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:01:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58990)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hqD95-0006wd-3v
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:01:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2447F307D85B;
 Wed, 24 Jul 2019 09:01:10 +0000 (UTC)
Received: from redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B37608A5;
 Wed, 24 Jul 2019 09:01:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Ivan Ren <renyime@gmail.com>
In-Reply-To: <1561468699-9819-4-git-send-email-ivanren@tencent.com> (Ivan
 Ren's message of "Tue, 25 Jun 2019 21:18:19 +0800")
References: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
 <1561468699-9819-4-git-send-email-ivanren@tencent.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 24 Jul 2019 11:01:07 +0200
Message-ID: <878ssn957w.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 24 Jul 2019 09:01:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Reply-To: quintela@redhat.com
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ivan Ren <renyime@gmail.com> wrote:
> When migrate_cancel a multifd migration, if run sequence like this:
>
>         [source]                              [destination]
>
> multifd_send_sync_main[finish]
>                                     multifd_recv_thread wait &p->sem_sync
> shutdown to_dst_file
>                                     detect error from_src_file
> send  RAM_SAVE_FLAG_EOS[fail]       [no chance to run multifd_recv_sync_main]
>                                     multifd_load_cleanup
>                                     join multifd receive thread forever
>
> will lead destination qemu hung at following stack:
>
> pthread_join
> qemu_thread_join
> multifd_load_cleanup
> process_incoming_migration_co
> coroutine_trampoline
>
> Signed-off-by: Ivan Ren <ivanren@tencent.com>

I think this one is not enough.  We need to set some error code, or
disable the running bit at that point.

> ---
>  migration/ram.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index e4eb9c441f..504c8ccb03 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1291,6 +1291,11 @@ int multifd_load_cleanup(Error **errp)
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
>          if (p->running) {
> +            /*
> +             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
> +             * however try to wakeup it without harm in cleanup phase.
> +             */
> +            qemu_sem_post(&p->sem_sync);
>              qemu_thread_join(&p->thread);
>          }
>          object_unref(OBJECT(p->c));

Let's see where we wait for p->sem_sync:


static void *multifd_recv_thread(void *opaque)
{
    ....
    while (true) {
        uint32_t used;
        uint32_t flags;

        ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
                                       p->packet_len, &local_err);
        .....

        if (flags & MULTIFD_FLAG_SYNC) {
            qemu_sem_post(&multifd_recv_state->sem_sync);
            qemu_sem_wait(&p->sem_sync);
        }
    }
    if (local_err) {
        multifd_recv_terminate_threads(local_err);
    }
    qemu_mutex_lock(&p->mutex);
    p->running = false;
    qemu_mutex_unlock(&p->mutex);

    rcu_unregister_thread();
    trace_multifd_recv_thread_end(p->id, p->num_packets, p->num_pages);

    return NULL;
}

If we just post it there, we get out of the wait (that bit is ok), but
then we go back to the beggining of the bucle, we (probably) got one
error on the qui_channel_read_all_eof(), and we go back to
multifd_recv_terminate_threads(), or wait there.

I think that it is better to *also* set an p->quit variable there, and
not even try to receive anything for that channel?

I will send a patch later.

Good catch.

Later, Juan.

