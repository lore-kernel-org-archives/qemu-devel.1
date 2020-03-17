Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C0FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F60B205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 08:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F60B205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE7ef-00052Q-Qh
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 04:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jE7e2-0004cZ-FZ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:32:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jE7e0-00081Y-W1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:32:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:29723)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jE7e0-0007hn-Mm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 04:32:12 -0400
IronPort-SDR: y2pr43VegW+c7MTIdFDybpn1JkL6/IdQZlVF7GHCJvrIOUumO6DFtrPQ104w5QfzGnGvCPt686
 Vzh01Dgn0BXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2020 01:32:08 -0700
IronPort-SDR: UKpNlINTdJ+ZnWDYUSHYlt5hg6ecYo2qVqFdn1vinAZ1YV8ngGCCcoHFYbGOC5PS6gPBgkCCdA
 xNNdnDMCGRkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; d="scan'208";a="267886680"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 01:32:08 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 17 Mar 2020 01:32:08 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Mar 2020 16:32:06 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 17 Mar 2020 16:32:06 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>
Subject: RE: The issues about architecture of the COLO checkpoint
Thread-Topic: The issues about architecture of the COLO checkpoint
Thread-Index: AQHV4KTcP1R3sKJVikmfjsOVjXKwRqgVv2IAgACfSoCAAKv5kP//rSyAgAEfU4CAAIj8QIAABEuQ//+ILQCAAH9LAIACrsiAgAPMiICAAUtUgIADQekA//+FpwAAxsXV4AAJj7+AAdZL4rAAY+3agAEwcryAAPr/VeA=
Date: Tue, 17 Mar 2020 08:32:06 +0000
Message-ID: <f65c766e750a463ba81970f6d27ce986@intel.com>
References: <20200213103752.GE2960@work-vm>
 <CA+XQNE7i15fTmwN6UL_fNi1e2sEb5v6+T05FaYdy0nS-DFC9HA@mail.gmail.com>
 <e820e35d-5b8a-18c8-736b-6c38cff9798e@intel.com>
 <CA+XQNE49wq2nRKJ0CA4uHDZ4OUEbFGPKBfAWB4+UwPYgiZkrCw@mail.gmail.com>
 <5d030380-76d6-67c6-39a1-82c197e320b4@intel.com>
 <CA+XQNE6riKARXtP9oZaQjK9Gqgfh-+Ae8qX+WsWhGfMB0hf8tg@mail.gmail.com>
 <0c69b913bf1047c4b7d5edac50f3988b@intel.com>
 <CA+XQNE6tZv0uhGoqqnS2ki=ZjP_YFaE53ZZntKPAbCxGnO1V8A@mail.gmail.com>
 <343daa37127e424c94fa0a3edde30f0c@intel.com> <20200306162201.3a1cd3ae@luklap>
 <20200312163919.GJ3211@work-vm>
In-Reply-To: <20200312163919.GJ3211@work-vm>
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
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: Daniel Cho <danielcho@qnap.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Sent: Friday, March 13, 2020 12:39 AM
> To: Lukas Straub <lukasstraub2@web.de>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Daniel Cho
> <danielcho@qnap.com>; qemu-devel@nongnu.org; Jason Wang
> <jasowang@redhat.com>; Zhanghailiang <zhang.zhanghailiang@huawei.com>
> Subject: Re: The issues about architecture of the COLO checkpoint
>=20
> * Lukas Straub (lukasstraub2@web.de) wrote:
> > On Wed, 4 Mar 2020 07:44:11 +0000
> > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> >
> > > > -----Original Message-----
> > > > From: Daniel Cho <danielcho@qnap.com>
> > > > Sent: Monday, February 24, 2020 3:15 PM
> > > > To: Zhang, Chen <chen.zhang@intel.com>
> > > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>; Zhanghailiang
> > > > <zhang.zhanghailiang@huawei.com>; qemu-devel@nongnu.org; Jason
> > > > Wang <jasowang@redhat.com>
> > > > Subject: Re: The issues about architecture of the COLO checkpoint
> > > >
> > > > Hi Zhang,
> > > >
> > > > Thanks for your help.
> > > > However, did you occur the error which the function qemu_hexdump
> > > > in colo-compare.c will crash the qemu process while doing
> > > > operation with network?
> > > >
> > >
> > > No, qemu_hexdump looks no relationship with network...
> > > Do you means it will crashed in qemu_hexdump sometimes?
> >
> > Jeah, I hit that bug too, but it was fixed with
> > 1e907a32b77e5d418538453df5945242e43224fa "COLO-compare: Fix
> incorrect `if` logic"
> > in qemu 4.2.
>=20
> Is anyone running any CI stuff for COLO?  I'm not, but bugs like that mak=
e it
> clear we probably should be;  it's not trivial to setup, but it should be=
 doable
> in a nest setup these days.

Currently, No CI stuff for COLO,  I'm busy on COLO landing with CSPs.
We will be happy If someone want to take this work.

Thanks
Zhang Chen

>=20
> Dave
>=20
> > Regards,
> > Lukas Straub
> >
> > > > We are working on VM fault tolerance study and COLO function
> > > > evalutation first. Currently we did not have a confirmed plan on it=
.
> > >
> > > OK, keep connection.
> > >
> > > Thanks
> > > Zhang Chen
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


