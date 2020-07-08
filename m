Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E45C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 06:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15428206E2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 06:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15428206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt3ky-0002Ge-7w
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 02:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jt3k9-0001qh-EJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 02:39:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:16172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jt3k6-0002cC-Eb
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 02:39:44 -0400
IronPort-SDR: mcjQly4sdf35D7QeXpx1bc7i3zdL95NSDjpclc+Rprtq/tnq0M3baoyNITDy+E/PloJe6C5SyN
 HcIsCeaYzJFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127828659"
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; d="scan'208";a="127828659"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 23:39:35 -0700
IronPort-SDR: H6EmyLaTFCccWH7VNDuunmZpScur5zzpqorAZCP3O9341jkIX22TFgP/yFjh4cgtjzzwyr3u+Q
 k+HA7q/5ztZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; d="scan'208";a="388732058"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2020 23:39:35 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Jul 2020 23:39:34 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 8 Jul 2020 14:39:32 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 8 Jul 2020 14:39:32 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Zhang, Chen" <chen.zhang@intel.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
Subject: RE: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
Thread-Topic: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
Thread-Index: AQHWPQXUSKAMWxVp4EWHfvIjGmZAKajRXpJwgArmGoCAAXaSIIAfr1gQ
Date: Wed, 8 Jul 2020 06:39:32 +0000
Message-ID: <a857b4ba8c2b406cb3c393b5b5a9eafd@intel.com>
References: <20200607194611.24763-1-chen.zhang@intel.com>
 <d1b031b8c9f241d4af843392d8091a18@intel.com> <20200617122541.GD2776@work-vm>
 <f02f06aa12cd406db9f681d11a2b3b47@intel.com>
In-Reply-To: <f02f06aa12cd406db9f681d11a2b3b47@intel.com>
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
Received-SPF: pass client-ip=192.55.52.151; envelope-from=chen.zhang@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 02:39:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Zhang Chen <zhangckid@gmail.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-dev <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Hailiang/Dave,

No news for a while, any comments?

Thanks
Zhang Chen

> -----Original Message-----
> From: Qemu-devel <qemu-devel-
> bounces+chen.zhang=3Dintel.com@nongnu.org> On Behalf Of Zhang, Chen
> Sent: Monday, June 22, 2020 2:53 PM
> To: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>; qemu-dev <qemu-
> devel@nongnu.org>; Zhang Chen <zhangckid@gmail.com>
> Subject: RE: [PATCH V3 0/3] migration/colo: Optimize COLO framework code
>=20
>=20
>=20
> > -----Original Message-----
> > From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Sent: Wednesday, June 17, 2020 8:26 PM
> > To: Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-dev <qemu-devel@nongnu.org>; Zhang Chen
> > <zhangckid@gmail.com>; Zhanghailiang
> <zhang.zhanghailiang@huawei.com>
> > Subject: Re: [PATCH V3 0/3] migration/colo: Optimize COLO framework
> > code
> >
> > * Zhang, Chen (chen.zhang@intel.com) wrote:
> > > Hi Dave,
> > >
> >
> > I think it's OK; I guess Zhanghailiang is going to do a pull for it?
> > One thought about the change of use of MIGRATION_STATUS_ACTIVE; I
> > think it's OK at the moment - but the migration states and the way
> > they change becomes part of the API - changing which states we use can
> > confuse management applications; since there's no libvirt support,
> > I'll leave it to Zhanghailiang to know if that's OK.
>=20
> Hi Hailiang/Dave,
>=20
> Current upstream libvirt can't support COLO, it looks no new issue for no=
rmal
> migration process.
> For the future, new COLO migration status is good for COLO enable work on
> libvirt and upper layer.
>=20
> Thanks
> Zhang Chen
>=20
> >
> > Dave
> >
> >
> > >
> > > Thanks
> > > Zhang Chen
> > >
> > > > -----Original Message-----
> > > > From: Zhang, Chen <chen.zhang@intel.com>
> > > > Sent: Monday, June 8, 2020 3:46 AM
> > > > To: Dr . David Alan Gilbert <dgilbert@redhat.com>; qemu-dev <qemu-
> > > > devel@nongnu.org>
> > > > Cc: Zhang Chen <zhangckid@gmail.com>; Zhanghailiang
> > > > <zhang.zhanghailiang@huawei.com>; Zhang, Chen
> > <chen.zhang@intel.com>
> > > > Subject: [PATCH V3 0/3] migration/colo: Optimize COLO framework
> > > > code
> > > >
> > > > From: Zhang Chen <chen.zhang@intel.com>
> > > >
> > > > This series optimize some code of COLO, please review.
> > > >
> > > > Zhang Chen (3):
> > > >   migration/colo: Optimize COLO boot code path
> > > >   migration/colo: Update checkpoint time lately
> > > >   migration/migration.c: Remove MIGRATION_STATUS_ACTIVE in
> > > >     migration_iteration_finish
> > > >
> > > >  migration/colo.c      |  7 ++-----
> > > >  migration/migration.c | 12 +++++-------
> > > >  2 files changed, 7 insertions(+), 12 deletions(-)
> > > >
> > > > --
> > > > 2.17.1
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


