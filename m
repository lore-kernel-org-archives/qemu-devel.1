Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D433C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6818E20753
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsOqUqMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6818E20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGs8-0006Vo-Jc
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWGpC-0002mn-CR
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:58:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23836
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWGpB-0007mZ-HR
 for qemu-devel@nongnu.org; Wed, 06 May 2020 05:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588759124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3kjyS4/HKDNJDJTMMdkm0lc0Rr2NH7WKocMyGfUSP/k=;
 b=LsOqUqMU2oP58V50iEzs6U4Wovj7fFsPa/EKez+7CwxJ9LkAJvkoi+B/+kJfWNpOAv9IoT
 ASWUlwjbHboUvsVmY0i4MXDoLjzhOYqdkOlb2OoQu25iwvVmZ26XlUY4+s1HRM+nO3C6ZG
 9VxetTGeEJ1zcK7Llalzs2GZIYDpPPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-xGfruh4MMXWJYvlO6GLLWg-1; Wed, 06 May 2020 05:58:42 -0400
X-MC-Unique: xGfruh4MMXWJYvlO6GLLWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A79581899523;
 Wed,  6 May 2020 09:58:41 +0000 (UTC)
Received: from work-vm (ovpn-114-245.ams2.redhat.com [10.36.114.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A1855C1D4;
 Wed,  6 May 2020 09:58:37 +0000 (UTC)
Date: Wed, 6 May 2020 10:58:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 1/4] migration: Export migration_bitmap_sync_precopy()
Message-ID: <20200506095835.GE2743@work-vm>
References: <20200428194219.10963-1-peterx@redhat.com>
 <20200428194219.10963-2-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200428194219.10963-2-peterx@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> Make it usable outside migration.  To make it easier to use, remove the
> RAMState parameter since after all ram.c has the reference of ram_state
> directly from its context.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/misc.h |  1 +
>  migration/ram.c          | 10 +++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index d2762257aa..e338be8c30 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -66,6 +66,7 @@ void remove_migration_state_change_notifier(Notifier *n=
otify);
>  bool migration_in_setup(MigrationState *);
>  bool migration_has_finished(MigrationState *);
>  bool migration_has_failed(MigrationState *);
> +void migration_bitmap_sync_precopy(void);
>  /* ...and after the device transmission */
>  bool migration_in_postcopy_after_devices(MigrationState *);
>  void migration_global_dump(Monitor *mon);
> diff --git a/migration/ram.c b/migration/ram.c
> index 04f13feb2e..d737175d4e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -970,7 +970,7 @@ static void migration_bitmap_sync(RAMState *rs)
>      }
>  }
> =20
> -static void migration_bitmap_sync_precopy(RAMState *rs)
> +void migration_bitmap_sync_precopy(void)
>  {
>      Error *local_err =3D NULL;
> =20
> @@ -983,7 +983,7 @@ static void migration_bitmap_sync_precopy(RAMState *r=
s)
>          local_err =3D NULL;
>      }
> =20
> -    migration_bitmap_sync(rs);
> +    migration_bitmap_sync(ram_state);
> =20
>      if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
>          error_report_err(local_err);
> @@ -2303,7 +2303,7 @@ static void ram_init_bitmaps(RAMState *rs)
>      WITH_RCU_READ_LOCK_GUARD() {
>          ram_list_init_bitmaps();
>          memory_global_dirty_log_start();
> -        migration_bitmap_sync_precopy(rs);
> +        migration_bitmap_sync_precopy();
>      }
>      qemu_mutex_unlock_ramlist();
>      qemu_mutex_unlock_iothread();
> @@ -2592,7 +2592,7 @@ static int ram_save_complete(QEMUFile *f, void *opa=
que)
> =20
>      WITH_RCU_READ_LOCK_GUARD() {
>          if (!migration_in_postcopy()) {
> -            migration_bitmap_sync_precopy(rs);
> +            migration_bitmap_sync_precopy();
>          }
> =20
>          ram_control_before_iterate(f, RAM_CONTROL_FINISH);
> @@ -2642,7 +2642,7 @@ static void ram_save_pending(QEMUFile *f, void *opa=
que, uint64_t max_size,
>          remaining_size < max_size) {
>          qemu_mutex_lock_iothread();
>          WITH_RCU_READ_LOCK_GUARD() {
> -            migration_bitmap_sync_precopy(rs);
> +            migration_bitmap_sync_precopy();
>          }
>          qemu_mutex_unlock_iothread();
>          remaining_size =3D rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> --=20
> 2.24.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


