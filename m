Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE2FCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309742064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309742064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNBpU-0005I2-08
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iNBlh-0003tM-Ey
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iNBlf-0003zK-Fn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:13:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:46986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iNBlW-0003rQ-TF; Wed, 23 Oct 2019 04:13:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 01:13:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; d="scan'208";a="399313756"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2019 01:13:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 01:13:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Oct 2019 01:13:05 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 23 Oct 2019 01:13:04 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.176]) by
 SHSMSX154.ccr.corp.intel.com ([10.239.6.54]) with mapi id 14.03.0439.000;
 Wed, 23 Oct 2019 16:13:03 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: RE: [PATCH v6 1/4] block/replication.c: Ignore requests after failover
Thread-Topic: [PATCH v6 1/4] block/replication.c: Ignore requests after
 failover
Thread-Index: AQHVe32aVfw2EzK+KEK1bz+22WroiKdgS5kAgAeu5VA=
Date: Wed, 23 Oct 2019 08:13:03 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78062C3254@shsmsx102.ccr.corp.intel.com>
References: <cover.1570280098.git.lukasstraub2@web.de>
 <596a6f07850002a09461f317afa75f3e0c9bb784.1570280098.git.lukasstraub2@web.de>
 <20191018204626.0559de89@luklap>
In-Reply-To: <20191018204626.0559de89@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWZiYWE2YzAtY2NiMi00YWRhLWExMjEtM2Y2ZTA1MDQ0ZmE4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK3JFZWV5azB0b1E4SFwvS2tkdklHMnc2RmZlTEhyS2xcL0VWNjRNUVEzTmhoaFZEODRsZ2dVMUFLbnV5NUQyWXdWIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Saturday, October 19, 2019 2:46 AM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Jason Wang
> <jasowang@redhat.com>; Wen Congyang <wencongyang2@huawei.com>;
> Xie Changlong <xiechanglong.d@gmail.com>; Kevin Wolf
> <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; qemu-block
> <qemu-block@nongnu.org>
> Subject: Re: [PATCH v6 1/4] block/replication.c: Ignore requests after fa=
ilover
>=20
> On Sat, 5 Oct 2019 15:05:23 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
>=20
> > After failover the Secondary side of replication shouldn't change
> > state, because it now functions as our primary disk.
> >
> > In replication_start, replication_do_checkpoint, replication_stop,
> > ignore the request if current state is BLOCK_REPLICATION_DONE
> > (sucessful failover) or BLOCK_REPLICATION_FAILOVER (failover in
> > progres i.e. currently merging active and hidden images into the base
> image).
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> > ---
> >  block/replication.c | 38 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> >
> > diff --git a/block/replication.c b/block/replication.c index
> > 3d4dedddfc..97cc65c0cf 100644
> > --- a/block/replication.c
> > +++ b/block/replication.c
> > @@ -454,6 +454,17 @@ static void replication_start(ReplicationState *rs=
,
> ReplicationMode mode,
> >      aio_context_acquire(aio_context);
> >      s =3D bs->opaque;
> >
> > +    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
> > +        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> > +        /*
> > +         * This case happens when a secondary is promoted to primary.
> > +         * Ignore the request because the secondary side of replicatio=
n
> > +         * doesn't have to do anything anymore.
> > +         */
> > +        aio_context_release(aio_context);
> > +        return;
> > +    }
> > +
> >      if (s->stage !=3D BLOCK_REPLICATION_NONE) {
> >          error_setg(errp, "Block replication is running or done");
> >          aio_context_release(aio_context); @@ -529,8 +540,7 @@ static
> > void replication_start(ReplicationState *rs, ReplicationMode mode,
> >                     "Block device is in use by internal backup job");
> >
> >          top_bs =3D bdrv_lookup_bs(s->top_id, s->top_id, NULL);
> > -        if (!top_bs || !bdrv_is_root_node(top_bs) ||
> > -            !check_top_bs(top_bs, bs)) {
> > +        if (!top_bs || !check_top_bs(top_bs, bs)) {
> >              error_setg(errp, "No top_bs or it is invalid");
> >              reopen_backing_file(bs, false, NULL);
> >              aio_context_release(aio_context); @@ -577,6 +587,17 @@
> > static void replication_do_checkpoint(ReplicationState *rs, Error **err=
p)
> >      aio_context_acquire(aio_context);
> >      s =3D bs->opaque;
> >
> > +    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
> > +        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> > +        /*
> > +         * This case happens when a secondary was promoted to primary.
> > +         * Ignore the request because the secondary side of replicatio=
n
> > +         * doesn't have to do anything anymore.
> > +         */
> > +        aio_context_release(aio_context);
> > +        return;
> > +    }
> > +
> >      if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
> >          secondary_do_checkpoint(s, errp);
> >      }
> > @@ -593,7 +614,7 @@ static void replication_get_error(ReplicationState
> *rs, Error **errp)
> >      aio_context_acquire(aio_context);
> >      s =3D bs->opaque;
> >
> > -    if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
> > +    if (s->stage =3D=3D BLOCK_REPLICATION_NONE) {
> >          error_setg(errp, "Block replication is not running");
> >          aio_context_release(aio_context);
> >          return;
> > @@ -635,6 +656,17 @@ static void replication_stop(ReplicationState *rs,
> bool failover, Error **errp)
> >      aio_context_acquire(aio_context);
> >      s =3D bs->opaque;
> >
> > +    if (s->stage =3D=3D BLOCK_REPLICATION_DONE ||
> > +        s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> > +        /*
> > +         * This case happens when a secondary was promoted to primary.
> > +         * Ignore the request because the secondary side of replicatio=
n
> > +         * doesn't have to do anything anymore.
> > +         */
> > +        aio_context_release(aio_context);
> > +        return;
> > +    }
> > +
> >      if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
> >          error_setg(errp, "Block replication is not running");
> >          aio_context_release(aio_context);
>=20
> Hello Everyone,
> Could the block people have a look at this patch?

Add Dave, do you have time to review this series?

Thanks
Zhang Chen

>=20
> Regards,
> Lukas Straub

