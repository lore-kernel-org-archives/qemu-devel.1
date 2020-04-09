Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0714CC2D0EA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 07:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5A52072F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 07:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5A52072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMRB0-0002d7-26
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 03:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jMRAF-0001yP-3J
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1jMRAD-0001Oc-81
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:59:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:14211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1jMRAD-0001HN-0O
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:59:49 -0400
IronPort-SDR: UQE+fUr4CWwitAKJh6pdOHX13T5sWadil2VDkoccG1KmRy9ffgfvozglMCeVNQPS1sAMTJXtti
 aR49Gorsp+Sw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2020 23:59:40 -0700
IronPort-SDR: PtP67FNuc/6he5douLihdON9OhMQ0nKDiIH4uJlj/TJWifKZlGv9wWDn4VK5lYsw764nQXMUfM
 K32vfxnvfTHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,361,1580803200"; d="scan'208";a="251806707"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga003.jf.intel.com with ESMTP; 08 Apr 2020 23:59:40 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 23:59:39 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 Apr 2020 14:59:36 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Thu, 9 Apr 2020 14:59:36 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, Derek Su <dereksu@qnap.com>
Subject: RE: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
Thread-Topic: [PATCH v4 2/2] net/colo-compare.c: handling of the full primary
 or secondary queue
Thread-Index: AQHWBP8jbziCKwk6wUatrdITk0cinKhvJO0AgAFH8mA=
Date: Thu, 9 Apr 2020 06:59:36 +0000
Message-ID: <3f0534dbaa744ee4bff9f11615a3b964@intel.com>
References: <20200328124646.7778-1-dereksu@qnap.com>
 <20200328124646.7778-3-dereksu@qnap.com> <20200408211842.2c0f1e4a@luklap>
In-Reply-To: <20200408211842.2c0f1e4a@luklap>
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
X-Received-From: 134.134.136.65
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
Cc: "lizhijian@cn.fujitsu.com" <lizhijian@cn.fujitsu.com>,
 "chyang@qnap.com" <chyang@qnap.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ctcheng@qnap.com" <ctcheng@qnap.com>,
 "jwsu1986@gmail.com" <jwsu1986@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Thursday, April 9, 2020 3:19 AM
> To: Derek Su <dereksu@qnap.com>
> Cc: qemu-devel@nongnu.org; lizhijian@cn.fujitsu.com; chyang@qnap.com;
> jasowang@redhat.com; ctcheng@qnap.com; Zhang, Chen
> <chen.zhang@intel.com>; jwsu1986@gmail.com
> Subject: Re: [PATCH v4 2/2] net/colo-compare.c: handling of the full prim=
ary
> or secondary queue
>=20
> On Sat, 28 Mar 2020 20:46:46 +0800
> Derek Su <dereksu@qnap.com> wrote:
>=20
> > The pervious handling of the full primary or queue is only dropping
> > the packet. If there are lots of clients to the guest VM, the "drop"
> > will lead to the lost of the networking connection until next
> > checkpoint.
> >
> > To address the issue, this patch drops the packet firstly.
> > Then, do checkpoint and flush packets.
> >
> > Signed-off-by: Derek Su <dereksu@qnap.com>
>=20
> Hello,
> I had a look at this again and did some benchmarking.
> First just qemu 5.0-rc1 with my bugfixes
> ( https://lists.nongnu.org/archive/html/qemu-devel/2020-
> 04/msg01432.html ) Then qemu 5.0-rc1 with my bugfixes and this patch
> series.
>=20
> This commit hurts performance too much:
> Client-to-server bandwidth falls from ~45.9 Mbit/s to 22.9 Mbit/s.
> Server-to-client bandwidth falls from ~6.3 Mbit/s to just ~674 Kbit/s.
> Average latency rises from ~197ms to ~397ms.
>=20
> Meanwhile the packet loss without this commit is negligible, only 1-2 pin=
g
> packets got lost during each test run.
>=20
> Instead I think we should just turn the error message into a trace so it
> doesn't flood the logs.

We re-test this patch, Lukas is right.
Sorry for the original idea, looks like it did not show better performance =
in the test.
Agree with Lukas's comments. Derek, can you please change it?

Thanks
Zhang Chen


>=20
> Regards,
> Lukas Straub

