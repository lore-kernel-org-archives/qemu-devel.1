Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5E6C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167F9229ED
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167F9229ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqCwL-00084T-UT
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 04:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35424)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hqCvw-0006px-5n
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hqCvv-0004eQ-1U
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:47:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hqCvu-0004eB-RQ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:47:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2FDC5307D96F;
 Wed, 24 Jul 2019 08:47:34 +0000 (UTC)
Received: from redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B69E45DA2E;
 Wed, 24 Jul 2019 08:47:33 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Ivan Ren <renyime@gmail.com>
In-Reply-To: <1561468699-9819-3-git-send-email-ivanren@tencent.com> (Ivan
 Ren's message of "Tue, 25 Jun 2019 21:18:18 +0800")
References: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
 <1561468699-9819-3-git-send-email-ivanren@tencent.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 24 Jul 2019 10:47:31 +0200
Message-ID: <87imrr95uk.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 24 Jul 2019 08:47:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: fix migrate_cancel leads
 live_migration thread hung forever
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
> When we 'migrate_cancel' a multifd migration, live_migration thread may
> hung forever at some points, because of multifd_send_thread has already
> exit for socket error:
> 1. multifd_send_pages may hung at qemu_sem_wait(&multifd_send_state->
>    channels_ready)
> 2. multifd_send_sync_main my hung at qemu_sem_wait(&multifd_send_state->
>    sem_sync)
>
> Signed-off-by: Ivan Ren <ivanren@tencent.com>
> ---
>  migration/ram.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index f8908286c2..e4eb9c441f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1097,7 +1097,11 @@ static void *multifd_send_thread(void *opaque)
>  {
>      MultiFDSendParams *p = opaque;
>      Error *local_err = NULL;
> -    int ret;
> +    int ret = 0;

I agree with the ret change.

> +
> +    uint32_t used = 0;
> +    uint64_t packet_num = 0;
> +    uint32_t flags = 0;

This movement is unneeded.

>      trace_multifd_send_thread_start(p->id);
>      rcu_register_thread();
> @@ -1113,9 +1117,9 @@ static void *multifd_send_thread(void *opaque)
>          qemu_mutex_lock(&p->mutex);
>  
>          if (p->pending_job) {
> -            uint32_t used = p->pages->used;
> -            uint64_t packet_num = p->packet_num;
> -            uint32_t flags = p->flags;
> +            used = p->pages->used;
> +            packet_num = p->packet_num;
> +            flags = p->flags;
>  
>              p->next_packet_size = used * qemu_target_page_size();
>              multifd_send_fill_packet(p);
> @@ -1164,6 +1168,17 @@ out:
>          multifd_send_terminate_threads(local_err);
>      }
>  
> +    /*
> +     * Error happen, I will exit, but I can't just leave, tell
> +     * who pay attention to me.
> +     */
> +    if (ret != 0) {
> +        if (flags & MULTIFD_FLAG_SYNC) {
> +            qemu_sem_post(&multifd_send_state->sem_sync);
> +        }
> +        qemu_sem_post(&multifd_send_state->channels_ready);
> +    }

The real change is just this one.  Good catch, thanks.

Reviewed-by: Juan Quintela <quintela@redhat.com>


Later, Juan.

