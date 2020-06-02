Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9CAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D30206F1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D30206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxcx-0002hG-B4
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jfxcO-0002FY-JF
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:29:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2466 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jfxcN-0001i5-1g
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:29:36 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 507A99EF7A89F7385CC7;
 Tue,  2 Jun 2020 11:29:24 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 2 Jun 2020 11:29:23 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 2 Jun 2020 11:29:23 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Tue, 2 Jun 2020 11:29:23 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Zhang Chen <chen.zhang@intel.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH  1/3] migration/colo: Optimize COLO boot code path
Thread-Topic: [PATCH  1/3] migration/colo: Optimize COLO boot code path
Thread-Index: AQHWKnLAhsatwYIqwkaVq7CHXXxxPKjEvPcw
Date: Tue, 2 Jun 2020 03:29:23 +0000
Message-ID: <3bc368bca0c548659b314cfbd320e6ed@huawei.com>
References: <20200515042818.17908-1-chen.zhang@intel.com>
 <20200515042818.17908-2-chen.zhang@intel.com>
In-Reply-To: <20200515042818.17908-2-chen.zhang@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 23:29:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

> -----Original Message-----
> From: Zhang Chen [mailto:chen.zhang@intel.com]
> Sent: Friday, May 15, 2020 12:28 PM
> To: Dr . David Alan Gilbert <dgilbert@redhat.com>; Juan Quintela
> <quintela@redhat.com>; Zhanghailiang <zhang.zhanghailiang@huawei.com>;
> qemu-dev <qemu-devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Jason Wang
> <jasowang@redhat.com>; Zhang Chen <chen.zhang@intel.com>
> Subject: [PATCH 1/3] migration/colo: Optimize COLO boot code path
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> No need to reuse MIGRATION_STATUS_ACTIVE boot COLO.
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  migration/colo.c      |  2 --
>  migration/migration.c | 17 ++++++++++-------
>  2 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c index
> d015d4f84e..5ef69b885d 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -669,8 +669,6 @@ void migrate_start_colo_process(MigrationState *s)
>                                  colo_checkpoint_notify, s);
>=20
>      qemu_sem_init(&s->colo_exit_sem, 0);
> -    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                      MIGRATION_STATUS_COLO);
>      colo_process_checkpoint(s);
>      qemu_mutex_lock_iothread();
>  }
> diff --git a/migration/migration.c b/migration/migration.c index
> 0bb042a0f7..c889ef6eb7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2972,7 +2972,10 @@ static void
> migration_completion(MigrationState *s)
>          goto fail_invalidate;
>      }
>=20
> -    if (!migrate_colo_enabled()) {
> +    if (migrate_colo_enabled()) {
> +        migrate_set_state(&s->state, current_active_state,
> +                          MIGRATION_STATUS_COLO);
> +    } else {
>          migrate_set_state(&s->state, current_active_state,
>                            MIGRATION_STATUS_COMPLETED);
>      }
> @@ -3304,12 +3307,7 @@ static void
> migration_iteration_finish(MigrationState *s)
>          migration_calculate_complete(s);
>          runstate_set(RUN_STATE_POSTMIGRATE);
>          break;
> -
> -    case MIGRATION_STATUS_ACTIVE:
> -        /*
> -         * We should really assert here, but since it's during
> -         * migration, let's try to reduce the usage of assertions.
> -         */
> +    case MIGRATION_STATUS_COLO:
>          if (!migrate_colo_enabled()) {
>              error_report("%s: critical error: calling COLO code without =
"
>                           "COLO enabled", __func__); @@ -3319,6
> +3317,11 @@ static void migration_iteration_finish(MigrationState *s)
>           * Fixme: we will run VM in COLO no matter its old running state=
.
>           * After exited COLO, we will keep running.
>           */
> +    case MIGRATION_STATUS_ACTIVE:
> +        /*
> +         * We should really assert here, but since it's during
> +         * migration, let's try to reduce the usage of assertions.
> +         */
>          s->vm_was_running =3D true;
>          /* Fallthrough */
>      case MIGRATION_STATUS_FAILED:
> --
> 2.17.1


