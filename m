Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EABC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7697820829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7697820829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Qvi-0007vn-OT
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1k1QuY-0007OE-8Q
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:01:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2474 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1k1QuT-0000Qb-0p
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:01:05 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id CE6D3A88278BE37552DF;
 Fri, 31 Jul 2020 17:00:48 +0800 (CST)
Received: from dggeme707-chm.china.huawei.com (10.1.199.103) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 31 Jul 2020 17:00:48 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 31 Jul 2020 17:00:48 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Fri, 31 Jul 2020 17:00:48 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Lukas Straub <lukasstraub2@web.de>, Derek Su <dereksu@qnap.com>
Subject: RE: [PATCH v1 0/1] COLO: migrate dirty ram pages before colo
 checkpoint
Thread-Topic: [PATCH v1 0/1] COLO: migrate dirty ram pages before colo
 checkpoint
Thread-Index: AQHWR3EcmDhsnQsjxEWJOGaLUtyUkKkhCgeAgACOQaA=
Date: Fri, 31 Jul 2020 09:00:48 +0000
Message-ID: <acb998dd88fe4749b3f9938765d5ac2c@huawei.com>
References: <20200621021004.5559-1-dereksu@qnap.com>
 <20200731094940.7a26e583@luklap>
In-Reply-To: <20200731094940.7a26e583@luklap>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 05:00:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: "chyang@qnap.com" <chyang@qnap.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "ctcheng@qnap.com" <ctcheng@qnap.com>,
 "jwsu1986@gmail.com" <jwsu1986@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Lukas Straub & Derek,

Sorry for the late reply, too busy these days ;)

> -----Original Message-----
> From: Lukas Straub [mailto:lukasstraub2@web.de]
> Sent: Friday, July 31, 2020 3:52 PM
> To: Derek Su <dereksu@qnap.com>
> Cc: qemu-devel@nongnu.org; Zhanghailiang
> <zhang.zhanghailiang@huawei.com>; chyang@qnap.com;
> quintela@redhat.com; dgilbert@redhat.com; ctcheng@qnap.com;
> jwsu1986@gmail.com
> Subject: Re: [PATCH v1 0/1] COLO: migrate dirty ram pages before colo
> checkpoint
>=20
> On Sun, 21 Jun 2020 10:10:03 +0800
> Derek Su <dereksu@qnap.com> wrote:
>=20
> > This series is to reduce the guest's downtime during colo checkpoint
> > by migrating dirty ram pages as many as possible before colo checkpoint=
.
> >
> > If the iteration count reaches COLO_RAM_MIGRATE_ITERATION_MAX or
> ram
> > pending size is lower than 'x-colo-migrate-ram-threshold', stop the
> > ram migration and do colo checkpoint.
> >
> > Test environment:
> > The both primary VM and secondary VM has 1GiB ram and 10GbE NIC for
> FT
> > traffic.
> > One fio buffer write job runs on the guest.
> > The result shows the total primary VM downtime is decreased by ~40%.
> >
> > Please help to review it and suggestions are welcomed.
> > Thanks.
>=20
> Hello Derek,
> Sorry for the late reply.
> I think this is not a good idea, because it unnecessarily introduces a de=
lay
> between checkpoint request and the checkpoint itself and thus impairs
> network bound workloads due to increased network latency. Workloads that
> are independent from network don't cause many checkpoints anyway, so it
> doesn't help there either.
>=20

Agreed, though it seems to reduce VM's downtime while do checkpoint, but
It doesn't help to reduce network latency, because the network packages whi=
ch are
Different between SVM and PVM caused this checkpoint request, it will be bl=
ocked
Until finishing checkpoint process.


> Hailang did have a patch to migrate ram between checkpoints, which should
> help all workloads, but it wasn't merged back then. I think you can pick =
it up
> again, rebase and address David's and Eric's comments:
> https://lore.kernel.org/qemu-devel/20200217012049.22988-3-zhang.zhang
> hailiang@huawei.com/T/#u
> =20

The second one is not merged, which can help reduce the downtime.

> Hailang, are you ok with that?
>=20

Yes. @Derek, please feel free to pick it up if you would like to ;)


Thanks,
Hailiang

> Regards,
> Lukas Straub

