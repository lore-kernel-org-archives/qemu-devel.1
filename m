Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39588C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06BC420657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZM9KCQhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06BC420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46716 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqgB-0007ot-B4
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcqbm-0005fq-TD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rkagan@virtuozzo.com>) id 1hcqbV-00062C-PF
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:19:25 -0400
Received: from mail-bgr052101129080.outbound.protection.outlook.com
 ([52.101.129.80]:55622 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
 id 1hcqbV-0005u4-FE; Mon, 17 Jun 2019 08:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHXnv2ezghILu8+IAPvC+sSO/1G0VrEsyviIi92WAaw=;
 b=ZM9KCQhI1yIlNG5TTjTFkG28Pfj8twCJXp4hB2JCnYbY3kb6yFhQYz1LzawsOMZqHR9kBUqvWmDjenSBwy84MMN98DNEzOI9r6b1eDrA0Bo7DNWTjl53QcID1T5BZq1UKfZOZvW46r4lUZCfCNBEODWbpoDfVPfiCakMLtMTkkM=
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) by
 DB8PR08MB4010.eurprd08.prod.outlook.com (20.179.10.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Mon, 17 Jun 2019 12:18:58 +0000
Received: from DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944]) by DB8PR08MB3977.eurprd08.prod.outlook.com
 ([fe80::3530:3b13:be7f:2944%4]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 12:18:58 +0000
From: Roman Kagan <rkagan@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v2 2/7] iotests: exclude killed processes from running
 under Valgrind
Thread-Index: AQHVIH/Wi8p8J0/z1kCgZMBwauxb2KafutMAgAAR14A=
Date: Mon, 17 Jun 2019 12:18:58 +0000
Message-ID: <20190617121855.GB32624@rkaganb.sw.ru>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190617111504.GC7397@linux.fritz.box>
In-Reply-To: <20190617111504.GC7397@linux.fritz.box>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.4 (2019-03-13)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,	Kevin Wolf
 <kwolf@redhat.com>,	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com,
 berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0802CA0015.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::25) To DB8PR08MB3977.eurprd08.prod.outlook.com
 (2603:10a6:10:ad::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a782df65-f6bc-43f4-c454-08d6f31df96f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4010; 
x-ms-traffictypediagnostic: DB8PR08MB4010:|DB8PR08MB4010:
x-microsoft-antispam-prvs: <DB8PR08MB401018EC3FF28C6F1525252DC9EB0@DB8PR08MB4010.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(376002)(39840400004)(396003)(366004)(136003)(346002)(189003)(199004)(6512007)(26005)(6506007)(386003)(2906002)(66946007)(66446008)(64756008)(66556008)(66476007)(53936002)(73956011)(66066001)(6436002)(6246003)(6486002)(86362001)(71200400001)(71190400001)(1076003)(99286004)(476003)(58126008)(478600001)(8936002)(316002)(11346002)(52116002)(446003)(33656002)(76176011)(68736007)(6916009)(102836004)(229853002)(107886003)(3846002)(6116002)(8676002)(486006)(14444005)(256004)(186003)(54906003)(305945005)(36756003)(9686003)(4326008)(14454004)(7736002)(5660300002)(81166006)(81156014)(25786009)(30126002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:DB8PR08MB4010;
 H:DB8PR08MB3977.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 76Tqw6diV/T+MxKSvt0vjahs2W6hxQnBximqoOAYH/+QI4pVfMcpVVKIjWGbdjnKeP/a6L0Ks6OcxITJ+UI0g38E3fC/YcQQ3UPafjnTrSCC0n+VhXYm0Xx/i1+fXKlP7+9zd5XPB+JjmSIdLiqjuz9jmDEdP+sjvihuHX3ZcyJGnRlZviNuKHEwmBoiKkTBzA9+vRC8/ja/rGjfvzZkC8i5O8m/BhhUyXupBpxusjtQVRYN7hcfsZPT2K2NW3orIwGPCk8utIeUG6edl4pEOt3eSMcJifhevzCQ378AOxIvYmNXSHGzX1j3tFEO3FGTUMee7xv8q2X6vy24pvU2tKAmnaGUBqRlFdMWcucy57Xpw3DhqiI4iLOwLKBL/Ynao0oAoAbJytBjDRZDCXgDR5BvUEheriSwU0afR6MU6jSUq385UnEm/ElbBXCh6g2GP3kye+4OJL3JQyl3Z7qUYt6tQshVzhyR5IzdUJNruaUwo5fE0oaidX74UdbFj0kP
Content-Type: text/plain; charset="us-ascii"
Content-ID: <897687AB4D68B1479CC47C761630D2D8@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a782df65-f6bc-43f4-c454-08d6f31df96f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 12:18:58.6075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkagan@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4010
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 52.101.129.80
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 01:15:04PM +0200, Kevin Wolf wrote:
> Am 11.06.2019 um 20:02 hat Andrey Shinkevich geschrieben:
> > The Valgrind tool fails to manage its termination when QEMU raises the
> > signal SIGKILL. Lets exclude such test cases from running under the
> > Valgrind because there is no sense to check memory issues that way.
> > 
> > Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> 
> I don't fully understand the reasoning here. Most interesting memory
> access errors happen before a process terminates. (I'm not talking about
> leaks here, but use-after-free, buffer overflows, uninitialised memory
> etc.)

Nothing of the above, and nothing in general, happens in the usermode
process upon SIGKILL delivery.  

> However, I do see that running these test cases with -valgrind ends in a
> hang because the valgrind process keeps hanging around as a zombie
> process and the test case doesn't reap it. I'm not exactly sure why that
> is, but it looks more like a problem with the parent process (i.e. the
> bash script).

It rather looks like valgrind getting confused about what to do with
raise(SIGKILL) in the multithreaded case.

> If we can't figure out how to fix this, we can disable valgrind in these
> cases, but I think the explanation needs to be different.
> 
> > diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> > index 0d4e963..95115e2 100755
> > --- a/tests/qemu-iotests/039
> > +++ b/tests/qemu-iotests/039
> > @@ -65,6 +65,7 @@ echo "== Creating a dirty image file =="
> >  IMGOPTS="compat=1.1,lazy_refcounts=on"
> >  _make_test_img $size
> >  
> > +VALGRIND_QEMU="" \
> >  $QEMU_IO -c "write -P 0x5a 0 512" \
> >           -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
> >      | _filter_qemu_io
> 
> I agree with Vladimir that setting VALGRIND_QEMU only once at the top of
> the script is probably the better option.

It is not, because there's no reason for qemu-io invocations that don't
perform raise(SIGKILL) to escape valgrinding.

Roman.

