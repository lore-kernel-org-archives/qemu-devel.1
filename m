Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD93EC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 13:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D4725992
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 13:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fUcqENWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D4725992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54098 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWL5A-0003xL-Hf
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 09:27:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWL4I-0003VH-P1
	for qemu-devel@nongnu.org; Thu, 30 May 2019 09:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWL4H-0006to-JC
	for qemu-devel@nongnu.org; Thu, 30 May 2019 09:26:06 -0400
Received: from mail-eopbgr140137.outbound.protection.outlook.com
	([40.107.14.137]:52839
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWL4D-0006pW-8G; Thu, 30 May 2019 09:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=L24bEcgNxoNhfXWTkiCK0TLEo4SXkdY39scZGSc5i+0=;
	b=fUcqENWf91JKjmKOXkf9+ja3BraFvzTao5mIUMuFhfrFPpGN3uylnCf5nsV+DFa3185Hsez9r0NGwa7K3ltl1rBiu7kkOM1hvloBMRd1X2f3tPBK7Ln6W+2Bi+uY90vkGspzvuCecFYaZUS6MAbiotye8LucO606Vjju7h7fm2g=
Received: from DB7PR08MB2972.eurprd08.prod.outlook.com (52.134.109.150) by
	DB7PR08MB3083.eurprd08.prod.outlook.com (52.134.110.25) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.16; Thu, 30 May 2019 13:25:55 +0000
Received: from DB7PR08MB2972.eurprd08.prod.outlook.com
	([fe80::e5eb:4576:5a22:7f82]) by
	DB7PR08MB2972.eurprd08.prod.outlook.com
	([fe80::e5eb:4576:5a22:7f82%7]) with mapi id 15.20.1943.016;
	Thu, 30 May 2019 13:25:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 0/7] backup-top filter driver for backup
Thread-Index: AQHVFjXG5C3ar/FgH0iQpyr20x551aaDqfwA
Date: Thu, 30 May 2019 13:25:55 +0000
Message-ID: <5a71a794-f01f-59d6-e140-334c20db31d2@virtuozzo.com>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190529154654.95870-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0022.eurprd01.prod.exchangelabs.com
	(2603:10a6:3:77::32) To DB7PR08MB2972.eurprd08.prod.outlook.com
	(2603:10a6:5:1c::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190530162552683
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cc2a7b3-5e88-4ae1-6e79-08d6e5025831
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DB7PR08MB3083; 
x-ms-traffictypediagnostic: DB7PR08MB3083:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR08MB3083665F707C69E39F49CC6FC1180@DB7PR08MB3083.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(346002)(376002)(366004)(396003)(136003)(199004)(189003)(53754006)(26005)(66066001)(305945005)(386003)(6506007)(53936002)(6246003)(54906003)(7736002)(102836004)(11346002)(2501003)(446003)(81166006)(2616005)(110136005)(3846002)(6512007)(81156014)(8676002)(186003)(8936002)(86362001)(31696002)(4326008)(14444005)(2906002)(6116002)(5660300002)(256004)(6306002)(476003)(14454004)(66476007)(229853002)(66556008)(31686004)(6436002)(25786009)(966005)(68736007)(486006)(66946007)(66446008)(99286004)(76176011)(52116002)(6486002)(71190400001)(478600001)(64756008)(316002)(36756003)(71200400001)(73956011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3083;
	H:DB7PR08MB2972.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mx9ntihTHHCAK2d/o63fZcHnyzH5IvO8p9TyOwVZEaPUis4U+xFgDXXIViibKPern3DpkeD7YhsPZ48gct3odU2QXheHsHEJinTEtTfOw78o0Enc1wayc+8Ow+XbLmEB5t0jCV+8FpfumBp4DAxnVQezX0BuwWSV/JKc7DZAjMUhuYV3XDDcL86cLChgkluy/5jsk9uRadP+NMU+fVMA/itlDaES8fH2kAXi2I4PxbBnucwdtgMJB0YzTS93dE2fDAFrkBzlb8PinpvQhfJYju7uwde1Vd4Gi4g4LQ20F89bVSQZHBSOGyKkvaDVo+x5D0wZZaU1OFWZVodeeZtcvfPsnpXsoEoOu8vv6MpJwnRjf7N0UkcgWeNid7mic6TxqjLSvKfzfUo/qf1td3bBHH/33Z3lQUsOKjJ8HK3fnI0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A31BC8717B80904386D98DC0D1122FC5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc2a7b3-5e88-4ae1-6e79-08d6e5025831
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 13:25:55.5901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3083
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.137
Subject: Re: [Qemu-devel] [PATCH v8 0/7] backup-top filter driver for backup
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjkuMDUuMjAxOSAxODo0NiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SGkgYWxsIQ0KPiANCj4gVGhlc2Ugc2VyaWVzIGludHJvZHVjZSBiYWNrdXAtdG9wIGRyaXZlci4g
SXQncyBhIGZpbHRlci1ub2RlLCB3aGljaA0KPiBkbyBjb3B5LWJlZm9yZS13cml0ZSBvcGVyYXRp
b24uIE1pcnJvciB1c2VzIGZpbHRlci1ub2RlIGZvciBoYW5kbGluZw0KPiBndWVzdCB3cml0ZXMs
IGxldCdzIG1vdmUgdG8gZmlsdGVyLW5vZGUgKGZyb20gd3JpdGUtbm90aWZpZXJzKSBmb3INCj4g
YmFja3VwIHRvbw0KPiANCj4gdjg6DQo+IDAxLTAzOiBuZXcNCj4gMDU6IGFkZCBNYXgncyByLWIN
Cj4gb3RoZXJzIGNoYW5nZWQsIGNoYW5nZSBkZXNjcmlwdGlvbiBpbiBlYWNoIHBhdGNoIG1haWwg
aW4gTm90ZXMgc2VjdGlvbi4NCj4gDQo+IHY2LXY3IHdhcyBwcmVwYXJpbmcgcmVmYWN0b3Jpbmcs
IHdoaWNoIG5vdyBpcyBpbiBNYXgncyBwdWxsIHJlcXVlc3QsIGFuZA0KPiB0aGVzZSBzZXJpZXMg
YmFzZWQgb24gaXQ6DQo+IEJhc2VkLW9uOiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9o
dG1sL3FlbXUtZGV2ZWwvMjAxOS0wNS9tc2cwNjUyNi5odG1sDQoNCkl0IG1lcmdlZCwgc28sIG5v
dyB0aGUgc2VyaWVzIGJhc2VkIG9uIG1hc3Rlci4NCg0KPiANCj4gVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSAoNyk6DQo+ICAgIGJsb2NrOiB0ZWFjaCBiZHJ2X2RlYnVnX2JyZWFrcG9pbnQg
c2tpcCBmaWx0ZXJzIHdpdGggYmFja2luZw0KPiAgICBibG9jazogc3dhcCBvcGVyYXRpb24gb3Jk
ZXIgaW4gYmRydl9hcHBlbmQNCj4gICAgYmxvY2s6IGFsbG93IG5vdCBvbmUgY2hpbGQgZm9yIGlt
cGxpY2l0IG5vZGUNCj4gICAgYmxvY2s6IGludHJvZHVjZSBiYWNrdXAtdG9wIGZpbHRlciBkcml2
ZXINCj4gICAgYmxvY2svaW86IHJlZmFjdG9yIHdhaXRfc2VyaWFsaXNpbmdfcmVxdWVzdHMNCj4g
ICAgYmxvY2s6IGFkZCBsb2NrL3VubG9jayByYW5nZSBmdW5jdGlvbnMNCj4gICAgYmxvY2svYmFj
a3VwOiB1c2UgYmFja3VwLXRvcCBpbnN0ZWFkIG9mIHdyaXRlIG5vdGlmaWVycw0KPiANCj4gICBi
bG9jay9iYWNrdXAtdG9wLmggICAgICAgICB8ICA2NCArKysrKysrKw0KPiAgIGluY2x1ZGUvYmxv
Y2svYmxvY2tfaW50LmggIHwgICA0ICsNCj4gICBibG9jay5jICAgICAgICAgICAgICAgICAgICB8
ICA2MCArKysrKy0tDQo+ICAgYmxvY2svYmFja3VwLXRvcC5jICAgICAgICAgfCAzMjIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGJsb2NrL2JhY2t1cC5jICAgICAg
ICAgICAgIHwgMTcxICsrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAgYmxvY2svaW8uYyAgICAgICAg
ICAgICAgICAgfCAgNjggKysrKysrLS0NCj4gICBibG9jay9NYWtlZmlsZS5vYmpzICAgICAgICB8
ICAgMiArDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzA1NiAgICAgfCAgIDIgKy0NCj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvMDg1Lm91dCB8ICAgMiArLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8x
MjkgICAgIHwgICAxIC0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMTQxLm91dCB8ICAgMiArLQ0K
PiAgIDExIGZpbGVzIGNoYW5nZWQsIDU2NyBpbnNlcnRpb25zKCspLCAxMzEgZGVsZXRpb25zKC0p
DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJsb2NrL2JhY2t1cC10b3AuaA0KPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBibG9jay9iYWNrdXAtdG9wLmMNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

