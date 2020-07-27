Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F852070A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlUuNHOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F852070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k034y-0001jU-6s
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k034D-00015r-TY
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:21:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59216
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1k034C-0006JF-Cl
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595856079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGgwrtVutTgVXaGhkElwuVJnTna9n233J03uftklanw=;
 b=QlUuNHOekv+HowLs+4jpQQRusKhLdtS4vdY9PLx4c6hNxJscvsQmM8p/2elfEUYabUceVm
 MRGdOtw03XlSaYFr1sCim52hD5vPjizPqBKOF6RdNtipeVsSXEEjpIp8ZvBY4nX89h1k2E
 XP4kBUhS32JlI+khsp1epQTphYbbZd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-3tAi-LtqPauu_G0Qm8EBwA-1; Mon, 27 Jul 2020 09:21:14 -0400
X-MC-Unique: 3tAi-LtqPauu_G0Qm8EBwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40C411932481;
 Mon, 27 Jul 2020 13:21:13 +0000 (UTC)
Received: from work-vm (ovpn-114-135.ams2.redhat.com [10.36.114.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6E2372699;
 Mon, 27 Jul 2020 13:21:07 +0000 (UTC)
Date: Mon, 27 Jul 2020 14:21:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 16/21] migration/block-dirty-bitmap: cancel migration
 on shutdown
Message-ID: <20200727132105.GM3040@work-vm>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-17-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200724084327.15665-17-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> If target is turned off prior to postcopy finished, target crashes
> because busy bitmaps are found at shutdown.
> Canceling incoming migration helps, as it removes all unfinished (and
> therefore busy) bitmaps.
> 
> Similarly on source we crash in bdrv_close_all which asserts that all
> bdrv states are removed, because bdrv states involved into dirty bitmap
> migration are referenced by it. So, we need to cancel outgoing
> migration as well.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  migration/migration.h          |  2 ++
>  migration/block-dirty-bitmap.c | 16 ++++++++++++++++
>  migration/migration.c          | 13 +++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index ab20c756f5..6c6a931d0d 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -335,6 +335,8 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>  void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>  
>  void dirty_bitmap_mig_before_vm_start(void);
> +void dirty_bitmap_mig_cancel_outgoing(void);
> +void dirty_bitmap_mig_cancel_incoming(void);
>  void migrate_add_address(SocketAddress *address);
>  
>  int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index c24d4614bf..a198ec7278 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -657,6 +657,22 @@ static void cancel_incoming_locked(DBMLoadState *s)
>      s->bitmaps = NULL;
>  }
>  
> +void dirty_bitmap_mig_cancel_outgoing(void)
> +{
> +    dirty_bitmap_do_save_cleanup(&dbm_state.save);
> +}
> +
> +void dirty_bitmap_mig_cancel_incoming(void)
> +{
> +    DBMLoadState *s = &dbm_state.load;
> +
> +    qemu_mutex_lock(&s->lock);
> +
> +    cancel_incoming_locked(s);
> +
> +    qemu_mutex_unlock(&s->lock);
> +}
> +
>  static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
>  {
>      GSList *item;
> diff --git a/migration/migration.c b/migration/migration.c
> index 1c61428988..8fe36339db 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -188,6 +188,19 @@ void migration_shutdown(void)
>       */
>      migrate_fd_cancel(current_migration);
>      object_unref(OBJECT(current_migration));
> +
> +    /*
> +     * Cancel outgoing migration of dirty bitmaps. It should
> +     * at least unref used block nodes.
> +     */
> +    dirty_bitmap_mig_cancel_outgoing();
> +
> +    /*
> +     * Cancel incoming migration of dirty bitmaps. Dirty bitmaps
> +     * are non-critical data, and their loss never considered as
> +     * something serious.
> +     */
> +    dirty_bitmap_mig_cancel_incoming();

Are you sure this is the right place to put them - I'm thinking that
perhaps the object_unref of current_migration should still be after
them?

Dave

>  }
>  
>  /* For outgoing */
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


