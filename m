Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D68C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D013B2067B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D013B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1CG-0002iU-28
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1ji1BX-0002JJ-17
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:42:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:56493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1ji1BU-0003sX-Rw
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:42:22 -0400
IronPort-SDR: 3W+DSj0wsmMRJZX9uGbrb8G0FgqybLvFl6+2U7fL5MMsS9TgRcELdtdE/+QOE/y2tQR3cX0fUY
 L8bVf3NcxJ/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2020 12:42:10 -0700
IronPort-SDR: 8mV8U1UWYw8/ctQlQp05Vd9mZS7+FOF1QkkCKOgpMqm2K3PFEiEM0cg5Y5C+S2lEYjKznMa/Hd
 pXNILklDW57Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,485,1583222400"; d="scan'208";a="270302946"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga003.jf.intel.com with ESMTP; 07 Jun 2020 12:42:10 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 7 Jun 2020 12:42:10 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 8 Jun 2020 03:42:07 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Mon, 8 Jun 2020 03:42:07 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH V2 1/2] migration/colo: Optimize COLO boot code path
Thread-Topic: [PATCH V2 1/2] migration/colo: Optimize COLO boot code path
Thread-Index: AQHWOk954oyXJj/quUm4jXiNdWNl9KjLfnsAgAIT/WA=
Date: Sun, 7 Jun 2020 19:42:07 +0000
Message-ID: <a0e7e9a42fa5450c9e4cfdfe3bb63e94@intel.com>
References: <20200604085533.7769-1-chen.zhang@intel.com>
 <20200604085533.7769-2-chen.zhang@intel.com> <20200606215646.6679f8b6@luklap>
In-Reply-To: <20200606215646.6679f8b6@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.20; envelope-from=chen.zhang@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 15:42:10
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Sunday, June 7, 2020 3:57 AM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: Dr . David Alan Gilbert <dgilbert@redhat.com>; qemu-dev <qemu-
> devel@nongnu.org>; Zhanghailiang <zhang.zhanghailiang@huawei.com>;
> Zhang Chen <zhangckid@gmail.com>
> Subject: Re: [PATCH V2 1/2] migration/colo: Optimize COLO boot code path
>=20
> On Thu,  4 Jun 2020 16:55:32 +0800
> Zhang Chen <chen.zhang@intel.com > wrote:
>=20
> > From: Zhang Chen <chen.zhang@intel.com>
> >
> > No need to reuse MIGRATION_STATUS_ACTIVE boot COLO.
> >
> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> > Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > ---
> >  migration/colo.c      |  2 --
> >  migration/migration.c | 17 ++++++++++-------
> >  2 files changed, 10 insertions(+), 9 deletions(-)
> >
> > diff --git a/migration/colo.c b/migration/colo.c index
> > ea7d1e9d4e..91c76789fa 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -670,8 +670,6 @@ void migrate_start_colo_process(MigrationState *s)
> >                                  colo_checkpoint_notify, s);
> >
> >      qemu_sem_init(&s->colo_exit_sem, 0);
> > -    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> > -                      MIGRATION_STATUS_COLO);
> >      colo_process_checkpoint(s);
> >      qemu_mutex_lock_iothread();
> >  }
> > diff --git a/migration/migration.c b/migration/migration.c index
> > b63ad91d34..7f3f82a715 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2972,7 +2972,10 @@ static void migration_completion(MigrationState
> *s)
> >          goto fail_invalidate;
> >      }
> >
> > -    if (!migrate_colo_enabled()) {
> > +    if (migrate_colo_enabled()) {
> > +        migrate_set_state(&s->state, current_active_state,
> > +                          MIGRATION_STATUS_COLO);
> > +    } else {
> >          migrate_set_state(&s->state, current_active_state,
> >                            MIGRATION_STATUS_COMPLETED);
> >      }
> > @@ -3304,12 +3307,7 @@ static void
> migration_iteration_finish(MigrationState *s)
> >          migration_calculate_complete(s);
> >          runstate_set(RUN_STATE_POSTMIGRATE);
> >          break;
> > -
> > -    case MIGRATION_STATUS_ACTIVE:
> > -        /*
> > -         * We should really assert here, but since it's during
> > -         * migration, let's try to reduce the usage of assertions.
> > -         */
> > +    case MIGRATION_STATUS_COLO:
> >          if (!migrate_colo_enabled()) {
> >              error_report("%s: critical error: calling COLO code withou=
t "
> >                           "COLO enabled", __func__); @@ -3319,6
> > +3317,11 @@ static void migration_iteration_finish(MigrationState *s)
> >           * Fixme: we will run VM in COLO no matter its old running sta=
te.
> >           * After exited COLO, we will keep running.
> >           */
> > +    case MIGRATION_STATUS_ACTIVE:
> > +        /*
> > +         * We should really assert here, but since it's during
> > +         * migration, let's try to reduce the usage of assertions.
> > +         */
>=20
> I think this case should be removed, because arriving here with
> MIGRATION_STATUS_ACTIVE is invalid. It should be handled by the default
> case.

OK, looks good here. I will add this part in V3.

Thanks
Zhang Chen

>=20
> Regards,
> Lukas Straub
>=20
> >          s->vm_was_running =3D true;
> >          /* Fallthrough */
> >      case MIGRATION_STATUS_FAILED:


