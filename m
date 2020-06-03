Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAA9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D617205CB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D617205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgPrt-0006iD-DX
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 05:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jgPrB-00066l-0I
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:38:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2467 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jgPr8-0000Ju-M1
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:38:44 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 48A795579428F313DCC3;
 Wed,  3 Jun 2020 17:38:33 +0800 (CST)
Received: from dggeme708-chm.china.huawei.com (10.1.199.104) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 3 Jun 2020 17:38:30 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme708-chm.china.huawei.com (10.1.199.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 3 Jun 2020 17:38:30 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Wed, 3 Jun 2020 17:38:30 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: "Zhang, Chen" <chen.zhang@intel.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/3] migration/colo: Merge multi checkpoint request into
 one.
Thread-Topic: [PATCH 3/3] migration/colo: Merge multi checkpoint request into
 one.
Thread-Index: AQHWKnK/yUUVTef7UEqWweUf3ZnClajFADCwgAEym4CAAIlGcA==
Date: Wed, 3 Jun 2020 09:38:30 +0000
Message-ID: <2d33c10d444e4067b798413731dd231e@huawei.com>
References: <20200515042818.17908-1-chen.zhang@intel.com>
 <20200515042818.17908-4-chen.zhang@intel.com>
 <359be3274bdf4f0e87c6c45cdc05ae90@huawei.com>
 <ec06e82a5cf34545a332fe80fef0a94e@intel.com>
In-Reply-To: <ec06e82a5cf34545a332fe80fef0a94e@intel.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 05:38:34
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

> -----Original Message-----
> From: Zhang, Chen [mailto:chen.zhang@intel.com]
> Sent: Wednesday, June 3, 2020 5:11 PM
> To: Zhanghailiang <zhang.zhanghailiang@huawei.com>; Dr . David Alan
> Gilbert <dgilbert@redhat.com>; Juan Quintela <quintela@redhat.com>;
> qemu-dev <qemu-devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Jason Wang
> <jasowang@redhat.com>
> Subject: RE: [PATCH 3/3] migration/colo: Merge multi checkpoint request
> into one.
>=20
>=20
>=20
> > -----Original Message-----
> > From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Sent: Tuesday, June 2, 2020 2:59 PM
> > To: Zhang, Chen <chen.zhang@intel.com>; Dr . David Alan Gilbert
> > <dgilbert@redhat.com>; Juan Quintela <quintela@redhat.com>; qemu-dev
> > <qemu-devel@nongnu.org>
> > Cc: Zhang Chen <zhangckid@gmail.com>; Jason Wang
> <jasowang@redhat.com>
> > Subject: RE: [PATCH 3/3] migration/colo: Merge multi checkpoint
> > request into one.
> >
> >
> >
> > > -----Original Message-----
> > > From: Zhang Chen [mailto:chen.zhang@intel.com]
> > > Sent: Friday, May 15, 2020 12:28 PM
> > > To: Dr . David Alan Gilbert <dgilbert@redhat.com>; Juan Quintela
> > > <quintela@redhat.com>; Zhanghailiang
> > <zhang.zhanghailiang@huawei.com>;
> > > qemu-dev <qemu-devel@nongnu.org>
> > > Cc: Zhang Chen <zhangckid@gmail.com>; Jason Wang
> > > <jasowang@redhat.com>; Zhang Chen <chen.zhang@intel.com>
> > > Subject: [PATCH 3/3] migration/colo: Merge multi checkpoint request
> > > into one.
> > >
> > > From: Zhang Chen <chen.zhang@intel.com>
> > >
> > > When COLO guest occur issues, COLO-compare will catch lots of
> > > different network packet and trigger notification multi times, force
> > > periodic may happen at the same time. So this can be efficient merge
> > > checkpoint request within COLO_CHECKPOINT_INTERVAL.
> > >
> > > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> > > ---
> > >  migration/colo.c | 22 ++++++++++++++++------
> > >  1 file changed, 16 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/migration/colo.c b/migration/colo.c index
> > > d5bced22cb..e6a7d8c6e2 100644
> > > --- a/migration/colo.c
> > > +++ b/migration/colo.c
> > > @@ -47,6 +47,9 @@ static COLOMode last_colo_mode;
> > >
> > >  #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
> > >
> > > +/* Default COLO_CHECKPOINT_INTERVAL is 1000 ms */ #define
> > > +COLO_CHECKPOINT_INTERVAL 1000
> > > +
> > >  bool migration_in_colo_state(void)
> > >  {
> > >      MigrationState *s =3D migrate_get_current(); @@ -651,13 +654,20
> > > @@
> > > out:
> > >  void colo_checkpoint_notify(void *opaque)  {
> > >      MigrationState *s =3D opaque;
> > > -    int64_t next_notify_time;
> > > +    int64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> > >
> > > -    qemu_sem_post(&s->colo_checkpoint_sem);
> > > -    s->colo_checkpoint_time =3D
> qemu_clock_get_ms(QEMU_CLOCK_HOST);
> > > -    next_notify_time =3D s->colo_checkpoint_time +
> > > -                    s->parameters.x_checkpoint_delay;
> > > -    timer_mod(s->colo_delay_timer, next_notify_time);
> > > +    /*
> > > +     * When COLO guest occur issues, COLO-compare will catch lots of
> > > +     * different network packet and trigger notification multi times=
,
> > > +     * force periodic may happen at the same time. So this can be
> > > +     * efficient merge checkpoint request within
> > > COLO_CHECKPOINT_INTERVAL.
> > > +     */
> > > +    if (now > s->colo_checkpoint_time + COLO_CHECKPOINT_INTERVAL)
> {
> > > +        qemu_sem_post(&s->colo_checkpoint_sem);
> >
> > It is not right here, this notification should not be controlled by
> > the interval time, I got what happened here, when multiple checkpoint
> > requires come, this Colo_delay_time will be added every time and it
> > will be a big value which is not what we want.
>=20
> Not just this, multi checkpoint will spend lots of resource to sync memor=
y
> from PVM to SVM, It will make VM stop/start multi times, but for the resu=
lts
> are same with one checkpoint.
> So in short time just need one checkpoint, because do checkpoint still ne=
ed
> some time...
>=20

Yes, this because we use semaphore here, it will be increased multiple time=
s,
And I think Lukas's patch 'migration/colo.c: Use event instead of semaphore=
' has fixed this problem.
Did you try the qemu upstream which has merged this patch ?

> Thanks
> Zhang Chen
>=20
> >
> > Besides, please update this patch based on [PATCH 0/6] colo: migration
> > related bugfixes series which Has modified the same place.
> >
> >
> >
> > > +        timer_mod(s->colo_delay_timer, now +
> > > +                  s->parameters.x_checkpoint_delay);
> > > +        s->colo_checkpoint_time =3D now;
> > > +    }
> > >  }
> > >
> > >  void migrate_start_colo_process(MigrationState *s)
> > > --
> > > 2.17.1


