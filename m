Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ED8C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCEE2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYC5vXdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCEE2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzzoY-0001bJ-Dh
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 05:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jzznl-00017e-82
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:52:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28974
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jzznj-0006ls-Ii
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595843526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UYvUHP1p0h8U8f9tNI0L0NvII6qftKDfhgkNO1cuR9E=;
 b=ZYC5vXdprasd2HOu9+jgsdtfudTIKxbC2F5VzxBySvKHtBUDlCHjOTyDsj9sD/1KhEyKfL
 2pgUnpdbP47BzbyYv95haddfcQy9l5tJF/k+yYYCHTc/i99o+EUOXqAi464COx2vv1lv17
 iPltw/fCfN01tFgUOKiKkU61SSswOZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-9_eEvXklMF-_J3NGllcXhg-1; Mon, 27 Jul 2020 05:52:02 -0400
X-MC-Unique: 9_eEvXklMF-_J3NGllcXhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 439AD80046F;
 Mon, 27 Jul 2020 09:52:01 +0000 (UTC)
Received: from work-vm (ovpn-114-135.ams2.redhat.com [10.36.114.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EAC572699;
 Mon, 27 Jul 2020 09:51:55 +0000 (UTC)
Date: Mon, 27 Jul 2020 10:51:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 10/21] migration/block-dirty-bitmap: move mutex init
 to dirty_bitmap_mig_init
Message-ID: <20200727095153.GG3040@work-vm>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
 <20200724084327.15665-11-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200724084327.15665-11-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> No reasons to keep two public init functions.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Yes so I think that means the initialisation of that lock is a little
later in startup, but OK

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.h          | 1 -
>  migration/block-dirty-bitmap.c | 6 +-----
>  migration/migration.c          | 2 --
>  3 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index f617960522..ab20c756f5 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -335,7 +335,6 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>  void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
>  
>  void dirty_bitmap_mig_before_vm_start(void);
> -void init_dirty_bitmap_incoming_migration(void);
>  void migrate_add_address(SocketAddress *address);
>  
>  int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 01a536d7d3..4b67e4f4fb 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -148,11 +148,6 @@ typedef struct LoadBitmapState {
>  static GSList *enabled_bitmaps;
>  QemuMutex finish_lock;
>  
> -void init_dirty_bitmap_incoming_migration(void)
> -{
> -    qemu_mutex_init(&finish_lock);
> -}
> -
>  static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
>  {
>      uint8_t flags = qemu_get_byte(f);
> @@ -801,6 +796,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
>  void dirty_bitmap_mig_init(void)
>  {
>      QSIMPLEQ_INIT(&dirty_bitmap_mig_state.dbms_list);
> +    qemu_mutex_init(&finish_lock);
>  
>      register_savevm_live("dirty-bitmap", 0, 1,
>                           &savevm_dirty_bitmap_handlers,
> diff --git a/migration/migration.c b/migration/migration.c
> index 2ed9923227..1c61428988 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -165,8 +165,6 @@ void migration_object_init(void)
>      qemu_sem_init(&current_incoming->postcopy_pause_sem_dst, 0);
>      qemu_sem_init(&current_incoming->postcopy_pause_sem_fault, 0);
>  
> -    init_dirty_bitmap_incoming_migration();
> -
>      if (!migration_object_check(current_migration, &err)) {
>          error_report_err(err);
>          exit(1);
> -- 
> 2.21.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


