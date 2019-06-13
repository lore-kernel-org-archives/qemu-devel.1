Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB25DC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DA92082C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="b06QORLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DA92082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38538 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbNZo-0002Kn-BN
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 07:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbNRf-0004ks-R7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbNGY-0004tU-TV
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:47:35 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com
 ([40.107.2.133]:54825 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbNGY-0004sB-7n; Thu, 13 Jun 2019 06:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kQgkZCnDhg4pl+OEs/qBoULalwcHOvdTXNJxH5oIY8=;
 b=b06QORLJvJUCBg0i0+c1JBvBEoefsNCWofEn5RW0vJt1fxc6+SQ2oGK3dpQ2YApoBZRijf7dqsgaFvft2VZ1Irlv4kT4Cd5NERXKkPM7IKOrFEW+hDIjQHRz9QnRTX8+mlEI0oKEVtX3Z5JYpo4ER1mD9D76y5iavOgsOajpBuM=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4241.eurprd08.prod.outlook.com (20.179.32.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 10:47:31 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 10:47:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 01/42] block: Mark commit and mirror as filter drivers
Thread-Index: AQHVIWubFCldCvLC7UyMUcYW2zhTFqaZZ/IA
Date: Thu, 13 Jun 2019 10:47:30 +0000
Message-ID: <3c3bdbdf-dd19-b54d-cd47-152b0cf1951d@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-2-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-2-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0283.eurprd05.prod.outlook.com
 (2603:10a6:7:93::14) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613134728898
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bd61bb8-0b6e-4af0-53fb-08d6efec88c8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4241; 
x-ms-traffictypediagnostic: AM0PR08MB4241:
x-microsoft-antispam-prvs: <AM0PR08MB42410206EB8EFABCF3076AA0C1EF0@AM0PR08MB4241.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:33;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(136003)(346002)(376002)(366004)(199004)(189003)(52116002)(476003)(110136005)(99286004)(54906003)(486006)(86362001)(6486002)(386003)(6506007)(6436002)(8676002)(81166006)(81156014)(229853002)(8936002)(31696002)(76176011)(186003)(6116002)(71200400001)(2906002)(71190400001)(3846002)(26005)(316002)(102836004)(66066001)(66476007)(66556008)(256004)(2616005)(446003)(2501003)(7736002)(305945005)(14454004)(53936002)(6512007)(66446008)(66946007)(73956011)(4326008)(64756008)(478600001)(5660300002)(25786009)(11346002)(6246003)(31686004)(36756003)(68736007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4241;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GcwZePIyhMPfVwP4kbNiuKlKOk3n/tK41FgPimC0Zgd/cR6/aJUFnZbDX8pH16XrzLrhIkKfLS9pGYWKlFd/vY9ZGySXIWFhYs0g3Tgrj5PXOODqOHXrdiQ0zmLJ9iOXVLCnCIrUYYAA+b30Tvs4eYZLPYOpw0c6U8Qb0scF1EvUldKyEn5FfB38DHH0CAnfxK6UU4eK6EoMRWwb+tdZDe7swt/K6HEjBnqH9TRBgNtHv5iQyMpyN5EzZMbQ/FTvf5gGAMjHoBdIU4TRyzv5OPY3Xi8nM1iWHImmVqMsgTnm8yDcWR9BR1owyAUYbI4tYX5eV16IZ8Pyk/rF0kb+tgJeDDxqV10er9bWi0X6UAfKqsNts1aDDDgWxZE42Kyro2L8gnlL5TMAGhmlcCsyrvNOqXJWnM1QxJkTK3x//hg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40830E4F7FF0144C8A8A9DF580E6EDAD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd61bb8-0b6e-4af0-53fb-08d6efec88c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 10:47:30.8322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4241
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.133
Subject: Re: [Qemu-devel] [PATCH v5 01/42] block: Mark commit and mirror as
 filter drivers
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFRoZSBjb21taXQgYW5kIG1pcnJv
ciBibG9jayBub2RlcyBhcmUgZmlsdGVycywgc28gdGhleSBzaG91bGQgYmUgbWFya2VkDQo+IGFz
IHN1Y2guICAoU3RyaWN0bHkgc3BlYWtpbmcsIEJEUy5pc19maWx0ZXIncyBkb2N1bWVudGF0aW9u
IHN0YXRlcyB0aGF0DQo+IGEgZmlsdGVyJ3MgY2hpbGQgbXVzdCBiZSBicy0+ZmlsZS4gIFRoZSBm
b2xsb3dpbmcgcGF0Y2ggd2lsbCByZWxheCB0aGlzDQo+IHJlc3RyaWN0aW9uLCBob3dldmVyLikN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+IFJl
dmlld2VkLWJ5OiBBbGJlcnRvIEdhcmNpYSA8YmVydG9AaWdhbGlhLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+IC0t
LQ0KPiAgIGJsb2NrL2NvbW1pdC5jIHwgMiArKw0KPiAgIGJsb2NrL21pcnJvci5jIHwgMiArKw0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YmxvY2svY29tbWl0LmMgYi9ibG9jay9jb21taXQuYw0KPiBpbmRleCBjODE1ZGVmODlhLi5mMjBh
MjZmZWNkIDEwMDY0NA0KPiAtLS0gYS9ibG9jay9jb21taXQuYw0KPiArKysgYi9ibG9jay9jb21t
aXQuYw0KPiBAQCAtMjU2LDYgKzI1Niw4IEBAIHN0YXRpYyBCbG9ja0RyaXZlciBiZHJ2X2NvbW1p
dF90b3AgPSB7DQo+ICAgICAgIC5iZHJ2X2NvX2Jsb2NrX3N0YXR1cyAgICAgICA9IGJkcnZfY29f
YmxvY2tfc3RhdHVzX2Zyb21fYmFja2luZywNCj4gICAgICAgLmJkcnZfcmVmcmVzaF9maWxlbmFt
ZSAgICAgID0gYmRydl9jb21taXRfdG9wX3JlZnJlc2hfZmlsZW5hbWUsDQo+ICAgICAgIC5iZHJ2
X2NoaWxkX3Blcm0gICAgICAgICAgICA9IGJkcnZfY29tbWl0X3RvcF9jaGlsZF9wZXJtLA0KPiAr
DQo+ICsgICAgLmlzX2ZpbHRlciAgICAgICAgICAgICAgICAgID0gdHJ1ZSwNCj4gICB9Ow0KPiAg
IA0KPiAgIHZvaWQgY29tbWl0X3N0YXJ0KGNvbnN0IGNoYXIgKmpvYl9pZCwgQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsDQo+IGRpZmYgLS1naXQgYS9ibG9jay9taXJyb3IuYyBiL2Jsb2NrL21pcnJvci5j
DQo+IGluZGV4IGY4YmRiNWIyMWIuLjRmYThmNTdjODAgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL21p
cnJvci5jDQo+ICsrKyBiL2Jsb2NrL21pcnJvci5jDQo+IEBAIC0xNDgwLDYgKzE0ODAsOCBAQCBz
dGF0aWMgQmxvY2tEcml2ZXIgYmRydl9taXJyb3JfdG9wID0gew0KPiAgICAgICAuYmRydl9jb19i
bG9ja19zdGF0dXMgICAgICAgPSBiZHJ2X2NvX2Jsb2NrX3N0YXR1c19mcm9tX2JhY2tpbmcsDQo+
ICAgICAgIC5iZHJ2X3JlZnJlc2hfZmlsZW5hbWUgICAgICA9IGJkcnZfbWlycm9yX3RvcF9yZWZy
ZXNoX2ZpbGVuYW1lLA0KPiAgICAgICAuYmRydl9jaGlsZF9wZXJtICAgICAgICAgICAgPSBiZHJ2
X21pcnJvcl90b3BfY2hpbGRfcGVybSwNCj4gKw0KPiArICAgIC5pc19maWx0ZXIgICAgICAgICAg
ICAgICAgICA9IHRydWUsDQo+ICAgfTsNCj4gICANCj4gICBzdGF0aWMgdm9pZCBtaXJyb3Jfc3Rh
cnRfam9iKGNvbnN0IGNoYXIgKmpvYl9pZCwgQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+IA0KDQoN
Ci0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

