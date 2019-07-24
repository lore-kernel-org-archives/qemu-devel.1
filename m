Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CC3C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D035622387
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D035622387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqF43-0000Wk-6I
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47241)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqF3t-000077-5U
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqF3s-0004DD-6V
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hqF3s-0004Cw-18
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:03:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 332CC30B1AC9;
 Wed, 24 Jul 2019 11:03:55 +0000 (UTC)
Received: from work-vm (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A4AD60BEC;
 Wed, 24 Jul 2019 11:03:53 +0000 (UTC)
Date: Wed, 24 Jul 2019 12:03:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190724110350.GD2717@work-vm>
References: <20190724095523.1527-1-quintela@redhat.com>
 <20190724095523.1527-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724095523.1527-5-quintela@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 24 Jul 2019 11:03:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/4] migration: fix migrate_cancel multifd
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, Ivan Ren <renyime@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ivan Ren <ivanren@tencent.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Juan Quintela (quintela@redhat.com) wrote:
> From: Ivan Ren <renyime@gmail.com>
> 
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
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Message-Id: <1561468699-9819-4-git-send-email-ivanren@tencent.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index eb6716710e..889148dd84 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1292,6 +1292,11 @@ int multifd_load_cleanup(Error **errp)
>  
>          if (p->running) {
>              p->quit = true;
> +            /*
> +             * multifd_recv_thread may hung at MULTIFD_FLAG_SYNC handle code,
> +             * however try to wakeup it without harm in cleanup phase.
> +             */
> +            qemu_sem_post(&p->sem_sync);
>              qemu_thread_join(&p->thread);
>          }
>          object_unref(OBJECT(p->c));
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

