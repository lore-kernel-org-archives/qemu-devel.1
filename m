Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C4EC31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E4A2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b2qEQ76p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E4A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46632 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqZO-0003nw-5O
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcqGT-0006vU-DH
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcqGR-0006AN-EW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:57:33 -0400
Received: from mail-ve1eur04hn2080.outbound.protection.outlook.com
 ([52.101.139.80]:7958 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hcqGR-00066s-2T; Mon, 17 Jun 2019 07:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAyHJTewnOjqx4mjcBs8IDnX/Affr1Bea1JCFtTqL/0=;
 b=b2qEQ76p0t9/o1ysLn3UmkowL86veZHMw/iX3ftg7/svqtuTE7i9esZDsgfsTslRSAaayYOqqowzsJG+bEsc/LbBGMR2UXatvs+x3hLCLSzpZuIdAN3y0II/5zB+BsDg97dYW+rqhRmu071RVA9YJKUHgRd+0wgEax1yx9rKr8w=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB5500.eurprd08.prod.outlook.com (52.133.243.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Mon, 17 Jun 2019 11:57:18 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 11:57:18 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Thread-Topic: [PATCH v2 2/7] iotests: exclude killed processes from running
 under Valgrind
Thread-Index: AQHVIH/Wi8p8J0/z1kCgZMBwauxb2KaZWP6AgAZtnoA=
Date: Mon, 17 Jun 2019 11:57:18 +0000
Message-ID: <20190617115715.GA32624@rkaganb.sw.ru>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <3bd93c9c-6f8e-d982-1c60-0cd8b5a9ec51@virtuozzo.com>
In-Reply-To: <3bd93c9c-6f8e-d982-1c60-0cd8b5a9ec51@virtuozzo.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Vladimir
 Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,	Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>,	"qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>,	"mreitz@redhat.com"
 <mreitz@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev
 <den@virtuozzo.com>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0501CA0022.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::32) To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d64b66d1-95c7-4167-9360-08d6f31af295
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5500; 
x-ms-traffictypediagnostic: DB8PR08MB5500:|DB8PR08MB5500:
x-microsoft-antispam-prvs: <DB8PR08MB5500E0D2D92A33B1E054B19CC9EB0@DB8PR08MB5500.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(366004)(39840400004)(396003)(346002)(376002)(136003)(189003)(199004)(229853002)(25786009)(316002)(52116002)(81156014)(71190400001)(6436002)(86362001)(58126008)(54906003)(476003)(486006)(99286004)(81166006)(2906002)(3846002)(6116002)(33656002)(14454004)(478600001)(66476007)(66556008)(68736007)(64756008)(66446008)(73956011)(6862004)(66946007)(305945005)(53936002)(6486002)(66066001)(107886003)(256004)(11346002)(446003)(6246003)(36756003)(6512007)(9686003)(7736002)(8936002)(386003)(6506007)(5660300002)(102836004)(4326008)(1076003)(76176011)(71200400001)(6636002)(14444005)(26005)(186003)(8676002)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB5500;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E8k83zHyONiQ2vOFILHRlNRlm65WD1rejUnKCRgZ9x2ZKyGMThyosTmPQG68u38ZR9ovyZ5Ia/GvAOVWGhOpdQNaXr7Uvr0kt72Q6PsRbhu7ZQaRiRYi5Q149Y3tmb0CAcGs8epN698sQ41RYP5Bvix6NHrFvAe3eyOgsut7qnpU1OV8d4J2vDoPwKJpligRnvKYgpivyITFyRlK2OgITlgRpemTXGg9AwRgZObFkMiV6BiQn3Ow3ZgPfIOT78njIyq6tHwP7maAIZIVxfCRU4RxBmr7exXO4ZdJIj+7bxXb9GG23c3FMMYFIzRC/VHd7B9F0mk1UIUr8xykAzB+ieG2NycZVU6eiCiPqWLJNy4MfrrNcqM3j15mZUKcr5NGsNU66S3s8Kpgaur1e20uA0l9tXzsH56M65CATzLx5atm0LfyWkRQ/QpS8hLYMM2wSbFIjnX+9TTZrfLFu/r0CZXpLmtHDoDY2B7hMUiF8I79bZtfcze/Er8ghe1rJDyn
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A78F0F20534D964CA125C4BADB6BF8B6@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64b66d1-95c7-4167-9360-08d6f31af295
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 11:57:18.6440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5500
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.139.80
Subject: Re: [Qemu-devel] [PATCH v2 2/7] iotests: exclude killed processes
 from running under Valgrind
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 13, 2019 at 12:47:21PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 11.06.2019 21:02, Andrey Shinkevich wrote:
> > The Valgrind tool fails to manage its termination when QEMU raises the
> > signal SIGKILL. Lets exclude such test cases from running under the
> > Valgrind because there is no sense to check memory issues that way.
> > 
> > Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > ---
> >   tests/qemu-iotests/039 | 5 +++++
> >   tests/qemu-iotests/061 | 2 ++
> >   tests/qemu-iotests/137 | 1 +
> >   3 files changed, 8 insertions(+)
> > 
> > diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> > index 0d4e963..95115e2 100755
> > --- a/tests/qemu-iotests/039
> > +++ b/tests/qemu-iotests/039
> > @@ -65,6 +65,7 @@ echo "== Creating a dirty image file =="
> >   IMGOPTS="compat=1.1,lazy_refcounts=on"
> >   _make_test_img $size
> >   
> > +VALGRIND_QEMU="" \
> 
> 
> Shouldn't it be written once per test, just without "\" ?

Only qemu-io invocations that perform raise(KILL) need to bypass
valgrinding.  Clearing VALGRIND_QEMU globally will indulge all qemu-io
throughout the test.

Roman.

> >   $QEMU_IO -c "write -P 0x5a 0 512" \
> >            -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> >       | _filter_qemu_io
> > @@ -100,6 +101,7 @@ echo "== Opening a dirty image read/write should repair it =="
> >   IMGOPTS="compat=1.1,lazy_refcounts=on"
> >   _make_test_img $size
> >   
> > +VALGRIND_QEMU="" \
> >   $QEMU_IO -c "write -P 0x5a 0 512" \
> >            -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> >       | _filter_qemu_io
> > @@ -118,6 +120,7 @@ echo "== Creating an image file with lazy_refcounts=off =="
> >   IMGOPTS="compat=1.1,lazy_refcounts=off"
> >   _make_test_img $size
> >   
> > +VALGRIND_QEMU="" \
> >   $QEMU_IO -c "write -P 0x5a 0 512" \
> >            -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> >       | _filter_qemu_io
> > @@ -151,6 +154,7 @@ echo "== Changing lazy_refcounts setting at runtime =="
> >   IMGOPTS="compat=1.1,lazy_refcounts=off"
> >   _make_test_img $size
> >   
> > +VALGRIND_QEMU="" \
> >   $QEMU_IO -c "reopen -o lazy-refcounts=on" \
> >            -c "write -P 0x5a 0 512" \
> >            -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> > @@ -163,6 +167,7 @@ _check_test_img
> >   IMGOPTS="compat=1.1,lazy_refcounts=on"
> >   _make_test_img $size
> >   
> > +VALGRIND_QEMU="" \
> >   $QEMU_IO -c "reopen -o lazy-refcounts=off" \
> >            -c "write -P 0x5a 0 512" \
> >            -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> > diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
> > index d7dbd7e..5d0724c 100755
> > --- a/tests/qemu-iotests/061
> > +++ b/tests/qemu-iotests/061
> > @@ -73,6 +73,7 @@ echo
> >   echo "=== Testing dirty version downgrade ==="
> >   echo
> >   IMGOPTS="compat=1.1,lazy_refcounts=on" _make_test_img 64M
> > +VALGRIND_QEMU="" \
> >   $QEMU_IO -c "write -P 0x2a 0 128k" -c flush \
> >            -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 | _filter_qemu_io
> >   $PYTHON qcow2.py "$TEST_IMG" dump-header
> > @@ -107,6 +108,7 @@ echo
> >   echo "=== Testing dirty lazy_refcounts=off ==="
> >   echo
> >   IMGOPTS="compat=1.1,lazy_refcounts=on" _make_test_img 64M
> > +VALGRIND_QEMU="" \
> >   $QEMU_IO -c "write -P 0x2a 0 128k" -c flush \
> >            -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 | _filter_qemu_io
> >   $PYTHON qcow2.py "$TEST_IMG" dump-header
> > diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
> > index 0c3d2a1..a442fc8 100755
> > --- a/tests/qemu-iotests/137
> > +++ b/tests/qemu-iotests/137
> > @@ -130,6 +130,7 @@ echo
> >   
> >   # Whether lazy-refcounts was actually enabled can easily be tested: Check if
> >   # the dirty bit is set after a crash
> > +VALGRIND_QEMU="" \
> >   $QEMU_IO \
> >       -c "reopen -o lazy-refcounts=on,overlap-check=blubb" \
> >       -c "write -P 0x5a 0 512" \
> > 
> 
> 
> -- 
> Best regards,
> Vladimir

