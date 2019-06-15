Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A12C31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 19:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BCBE2184D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 19:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCBE2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcE0R-0004AC-4b
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 15:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49927)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hcDzk-0003aw-QB
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 15:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hcDzj-0002VF-HO
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 15:05:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:16547)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hcDzj-0002Ny-98; Sat, 15 Jun 2019 15:05:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jun 2019 12:05:34 -0700
X-ExtLoop1: 1
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga007.jf.intel.com with ESMTP; 15 Jun 2019 12:05:33 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 15 Jun 2019 12:05:33 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.33]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.246]) with mapi id 14.03.0439.000;
 Sun, 16 Jun 2019 03:05:31 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH] block/replication.c: Fix crash issue after failover
Thread-Index: AQHVIpRAydOaDooXLE2XODWfsjRMe6aaaaGAgAKpMWA=
Date: Sat, 15 Jun 2019 19:05:31 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780617EC89@shsmsx102.ccr.corp.intel.com>
References: <20190614092853.26551-1-chen.zhang@intel.com>
 <20190614101803.GG6042@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190614101803.GG6042@dhcp-200-226.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzNmNGIzYmItNmZjOS00MDJjLThmNjctZjZiYmE0ZDZiN2NkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiT3BOM0tqdjRDXC9iY3JBallMc3RRek9YWlV1UmFBbDRPXC9wRjg5aTNQVmtxZjhLcHdaTVM5MlwvWFJoXC9xVDBZK0EifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: Re: [Qemu-devel] [PATCH] block/replication.c: Fix crash issue after
 failover
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
Cc: "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 qemu-block <qemu-block@nongnu.org>, Xie Changlong <xiechanglong.d@gmail.com>,
 qemu-dev <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Zhang
 Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Sent: Friday, June 14, 2019 6:18 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: Xie Changlong <xiechanglong.d@gmail.com>; Max Reitz
> <mreitz@redhat.com>; qemu-block <qemu-block@nongnu.org>; qemu-dev
> <qemu-devel@nongnu.org>; Zhang Chen <zhangckid@gmail.com>;
> vsementsov@virtuozzo.com
> Subject: Re: [PATCH] block/replication.c: Fix crash issue after failover
>=20
> Am 14.06.2019 um 11:28 hat Zhang Chen geschrieben:
> > From: Zhang Chen <chen.zhang@intel.com>
> >
> > No block job on active disk after failover.
> > In the replication_stop() function have canceled the block job, we
> > check it again here.
> >
> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> > ---
> >  block/replication.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/replication.c b/block/replication.c index
> > 3d4dedddfc..bdf2bf4bbc 100644
> > --- a/block/replication.c
> > +++ b/block/replication.c
> > @@ -146,7 +146,9 @@ static void replication_close(BlockDriverState *bs)
> >          replication_stop(s->rs, false, NULL);
> >      }
> >      if (s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> > -        job_cancel_sync(&s->active_disk->bs->job->job);
> > +        if (s->secondary_disk->bs->job) {
> > +            job_cancel_sync(&s->secondary_disk->bs->job->job);
> > +        }
>=20
> Why are you changing the code from active_disk to secondary_disk?
>=20

Sorry, It seems that I misunderstood the original code.=20
I have re-checked the code, looks in the "commit_active_start()" create a j=
ob for the active_disk.
But in my test, when occur failover, running to the " replication_close() "=
 the active_disk's job always =3D 0,
It will crash here:
job_cancel_sync(&s->active_disk->bs->job->job);

So, I will add a check here:
if (s->active_disk->bs->job) {
    job_cancel_sync(&s->active_disk->bs->job->job);
}

What do you think?

> Also, please rebase on top of Vladimir's '[PATCH 0/4] block: drop
> bs->job'.

Sure.

Thanks
Zhang Chen

>=20
> Kevin

