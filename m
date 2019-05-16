Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40714C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5C72082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eeHgEcwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5C72082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHme-0007tD-Cg
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:55:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRHjN-0005aM-Rs
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hRHjN-00013f-1o
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:51:37 -0400
Received: from mail-ve1eur01on0716.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::716]:39488
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hRHjM-0000tM-DT; Thu, 16 May 2019 10:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=SCE72iC/B4JsiH8x53oQ2i6fj4bc5WxfZUdRq1COGBg=;
	b=eeHgEcwOG1FyfFXvzsBu2D2IZJ7sCg4kN8OttLQw9Ae1bG0ekozm9nBGB4k39A5MWiXTSyHD6Up6HpN1sdkfz3yZCilpuQ1ipIzwI4IRTX33gxDzqWYfqvDahbCp2l1RW052aNTtOmxMStAFc9v8vSdNEr5SMmNiUhauwBaOu1o=
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com (10.255.96.78) by
	AM6PR08MB4644.eurprd08.prod.outlook.com (10.255.22.83) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.25; Thu, 16 May 2019 14:51:31 +0000
Received: from AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1]) by
	AM6PR08MB4675.eurprd08.prod.outlook.com
	([fe80::9051:3c85:28c6:a0c1%6]) with mapi id 15.20.1878.024;
	Thu, 16 May 2019 14:51:31 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v14 1/1] qcow2: skip writing zero buffers to empty COW
	areas
Thread-Index: AQHVC/OS54EXOze61k+cXZVdUWneQqZt1ciA
Date: Thu, 16 May 2019 14:51:31 +0000
Message-ID: <ab977ecc-4d49-24f0-8116-873e91ee4dd8@virtuozzo.com>
References: <20190516142749.81019-1-anton.nefedov@virtuozzo.com>
	<20190516142749.81019-2-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190516142749.81019-2-anton.nefedov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0328.eurprd05.prod.outlook.com
	(2603:10a6:7:92::23) To AM6PR08MB4675.eurprd08.prod.outlook.com
	(2603:10a6:20b:c2::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190516175129103
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1ba02da-d2bf-4c74-75f0-08d6da0dfbc2
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4644; 
x-ms-traffictypediagnostic: AM6PR08MB4644:
x-microsoft-antispam-prvs: <AM6PR08MB46444F9F499C51C5BB147F34C10A0@AM6PR08MB4644.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(396003)(366004)(346002)(376002)(136003)(39850400004)(199004)(189003)(2616005)(11346002)(316002)(3846002)(6116002)(26005)(186003)(446003)(486006)(476003)(5660300002)(66476007)(66946007)(73956011)(64756008)(66556008)(54906003)(66446008)(2906002)(14454004)(4744005)(6246003)(110136005)(99286004)(36756003)(2501003)(71190400001)(71200400001)(6436002)(6512007)(229853002)(6486002)(53936002)(305945005)(7736002)(4326008)(31696002)(86362001)(8676002)(68736007)(25786009)(81156014)(81166006)(52116002)(386003)(6506007)(478600001)(102836004)(256004)(66066001)(76176011)(31686004)(8936002)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4644;
	H:AM6PR08MB4675.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jaeB7p7sNOUUnx/PerI8XSkNO6jtY1rVhIZx8waXVdMHgUpY5ic/inyW35yRQGyyxbpTLovcg5gv/1hEEQ60tk0pizDNA6zXVDVvjaMcPh9459OmYYjshFQd6APcsUrzCShtJuoXBCZk1Rq4BM+NAiWJ+KRToazHAiytSptXmXZhLejIAjJNlxMrajvsE07mH5CPrtWoB8qoP0TAgH1e4b3nLF4h+gcxjOWR+2zK1P/NBHZPMN2/ZikHxTCrcKGGZU1MfskvxkvnxZlroQJEk1ijaSvecN89YEzkRjMyDRdWynyr1+WULHbtHAM+ljHsluXwDk6+gBqzwT+T8BEeKZO1oo738986Dxr/rf02R9XAM+9D9ZPHfAaME4Kb9xpAOgg6gdDHMVAFLcceMAlyo6UpBWbYBtcc0/XxlyE09jo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1782D3B5ECD9B347B672F36D6541F9FB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ba02da-d2bf-4c74-75f0-08d6da0dfbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 14:51:31.5247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4644
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe1f::716
Subject: Re: [Qemu-devel] [PATCH v14 1/1] qcow2: skip writing zero buffers
 to empty COW areas
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMDUuMjAxOSAxNzoyNywgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gSWYgQ09XIGFyZWFzIG9m
IHRoZSBuZXdseSBhbGxvY2F0ZWQgY2x1c3RlcnMgYXJlIHplcm9lcyBvbiB0aGUgYmFja2luZw0K
PiBpbWFnZSwgZWZmaWNpZW50IGJkcnZfd3JpdGVfemVyb2VzKGZsYWdzPUJEUlZfUkVRX05PX0ZB
TExCQUNLKSBjYW4gYmUNCj4gdXNlZCBvbiB0aGUgd2hvbGUgY2x1c3RlciBpbnN0ZWFkIG9mIHdy
aXRpbmcgZXhwbGljaXQgemVybyBidWZmZXJzIGxhdGVyDQo+IGluIHBlcmZvcm1fY293KCkuDQo+
IA0KPiBpb3Rlc3QgMDYwOg0KPiB3cml0ZSB0byB0aGUgZGlzY2FyZGVkIGNsdXN0ZXIgZG9lcyBu
b3QgdHJpZ2dlciBDT1cgYW55bW9yZS4NCj4gVXNlIGEgYmFja2luZyBpbWFnZSBpbnN0ZWFkLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRvdkB2aXJ0dW96
em8uY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNl
bWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K

