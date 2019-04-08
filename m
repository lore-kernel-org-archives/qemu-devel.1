Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C322C282DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:58:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4817220883
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 09:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YC06Xtws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4817220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50379 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDR2N-00009a-IK
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 05:57:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDR1O-00086w-QD
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDR1L-0005VP-VZ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:56:58 -0400
Received: from mail-eopbgr10098.outbound.protection.outlook.com
	([40.107.1.98]:54585
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
	id 1hDR18-0005Nn-1m; Mon, 08 Apr 2019 05:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Tce3ePH6M0qNB42WGBaLUhndh5qpCcb2kG6Iz7261o8=;
	b=YC06XtwsgEiDQVF121z9cBwqPsYyh2D66FeH9mj6qGb4n2ApKT+kR3N8vlfVpwUn/NsDq+k8xiqW7ZIFQy7YBbyzMJbmqYOLoZFeLF6ph1QDUfTYD2WuuTAj899SYFBqMVt9YvXXa3RlhDIdl08UiCh2WoLdsEt9KGJpLHw88GM=
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com (20.179.18.23) by
	AM6PR08MB4087.eurprd08.prod.outlook.com (20.179.2.202) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Mon, 8 Apr 2019 09:56:37 +0000
Received: from AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644]) by
	AM6PR08MB4421.eurprd08.prod.outlook.com
	([fe80::d15a:3eaa:44bc:2644%4]) with mapi id 15.20.1771.019;
	Mon, 8 Apr 2019 09:56:37 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-block] [PATCH v2] qcow2: discard bitmap when removed
Thread-Index: AQHUz0fFuPhc95BDyUWuCjMQWLZPB6YSEmuAgCAxuYA=
Date: Mon, 8 Apr 2019 09:56:37 +0000
Message-ID: <d4593259-c3a8-8e84-cbbb-8caf02d6b9a7@virtuozzo.com>
References: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<28859adc-27c2-e2ed-3f24-ba620236970f@redhat.com>
In-Reply-To: <28859adc-27c2-e2ed-3f24-ba620236970f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0057.eurprd01.prod.exchangelabs.com
	(2603:10a6:7:7d::34) To AM6PR08MB4421.eurprd08.prod.outlook.com
	(2603:10a6:20b:71::23)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4723372-eaba-4fd9-de0e-08d6bc087da6
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:AM6PR08MB4087; 
x-ms-traffictypediagnostic: AM6PR08MB4087:
x-microsoft-antispam-prvs: <AM6PR08MB408797BB03EFE6F5A60889BCF42C0@AM6PR08MB4087.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39840400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(2906002)(478600001)(5660300002)(4326008)(486006)(7736002)(14454004)(81156014)(81166006)(8676002)(8936002)(97736004)(25786009)(36756003)(68736007)(102836004)(66066001)(186003)(11346002)(446003)(26005)(305945005)(2616005)(31686004)(476003)(76176011)(386003)(6436002)(54906003)(6486002)(6512007)(53546011)(6506007)(106356001)(229853002)(110136005)(105586002)(6246003)(256004)(31696002)(53936002)(2201001)(52116002)(14444005)(86362001)(99286004)(2501003)(316002)(71190400001)(71200400001)(6116002)(3846002)(44832011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4087;
	H:AM6PR08MB4421.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kIugw7DcHe0ReQbI89i3Wn3qQfsaOP7fmCY5oyFv+pG9fpaLHXnMW7hGiek5tIOGznwKs1P8IEBYT8NtrG4eCbeZ5XRl4nqpfgjRKzWMY7MWTu5aUDHsq1kEhKWkjsZ9UUpPGA1IZaQBvqUz5+kbdpV7D9udkH1zh5HfXU5Mm/C0JjOrq3hqhm4m2lKTFPnbgq6v6mGJAcZmocQg0gTW+/YfuoRJIx0yldzzW3509ds7NrrPjPf2aeOxA3HJsFXN7Bjnlaex12co2GWlNobkAwPvSGcwCi6UIVmMGLu7BFOpojk2DKL0AOWFqBib4qjhAbOACV55sr7H0ebmDl9uoy8lU1vGocYdKxna2bo8zEfuVdWotozPMfSAaQuEp02+7qZqp2aJY8NJI6TvOyD1Tf72W18PTzJm60qnNrlHCbk=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <989E22637DC47246A2E806680027669E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4723372-eaba-4fd9-de0e-08d6bc087da6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 09:56:37.5953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4087
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.98
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qcow2: discard bitmap when
 removed
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
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408095637.8RM6UIAoXtMv0n5k-SST4jQABcZp0kFZffEdoBWSUoU@z>

UElOR0lORw0KDQpJIGtpbmRseSByZW1pbmQgeW91IGFib3V0IHRoaXMgc21hbGwgcGF0Y2ggZm9y
IFFFTVUgNC4xLg0KSSBhbSBnb2luZyB0byBiZSBhd2F5IGZvciB2YWNhdGlvbiBmcm9tIEFwcmls
LCAxMHRoIHRvIE1heSwgMTV0aC4NCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5
IFNoaW5rZXZpY2gNCg0KDQpPbiAxOS8wMy8yMDE5IDAxOjE4LCBKb2huIFNub3cgd3JvdGU6DQo+
IA0KPiANCj4gT24gMi8yOC8xOSA0OjI2IEFNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+
IFdoZW4gYSBiaXRtYXAgaXMgcmVtb3ZlZCwgd2UgY2FuIGNsZWFuIHNvbWUgc3BhY2Ugb24gdGhl
IGRpc2suIFRoZSBzaXplDQo+PiBvZiBhIGNsdXN0ZXIgbWF5IGJlIGxhcmdlciwgc28gaXMgdGhl
IHNpemUgb2YgdGhlIGJpdG1hcCB0aGF0IGluY2x1ZGVzDQo+PiBtYW55IGNsdXN0ZXJzLiBTb21l
IGJpdG1hcHMgY2FuIGJlIGFzIGxhcmdlIGFzIHRlbnMgb2YgbWVnYWJ5dGVzLg0KPj4gVGhlIGZs
YWcgUUNPVzJfRElTQ0FSRF9BTFdBWVMgYWxsb3dzIGEgY2FsbCB0byB0aGUgcmF3X2NvX3BkaXNj
YXJkKCkNCj4+IHRoYXQgZG9lcyB0aGUgYWN0dWFsIGNsZWFuaW5nIG9mIHRoZSBpbWFnZSBvbiBk
aXNrLCB3aGlsZSB3aXRoIHRoZSBmbGFnDQo+PiBRQ09XMl9ESVNDQVJEX09USEVSLCBhIHJlZmVy
ZW5jZSBjb3VudCBvZiB0aGUgY2x1c3RlciBpcyB1cGRhdGVkIG9ubHkuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5j
b20+DQo+PiAtLS0NCj4+IHYxOiBEaXNjYXJkIG9sZCBiaXRtYXAgZGlyZWN0b3JpZXMgaW4gUUNP
VzIgaW1hZ2UNCj4+DQo+PiBJbiB0aGUgZmlyc3QgdmVyc2lvbiBvZiB0aGUgcGF0Y2gsIGFueSBj
YWxsIHRvIHFjb3cyX2ZyZWVfY2x1c3RlcnMoKSBpbg0KPj4gYmxvY2svcWNvdzItYml0bWFwLmMg
d2FzIHdpdGggdGhlIGZsYWcgUUNPVzJfRElTQ0FSRF9BTFdBWVMsIGV2ZW4gaW4gdGhlDQo+PiBj
YXNlcyB3aGVuIHRoZSBjbGVhbmVkIHNwYWNlIGlzIGluc2lnbmlmaWNhbnQsIHBhcnRpY3VsYXJs
eSwgaW4gY2FzZSBvZg0KPj4gYml0bWFwIGRpcmVjdG9yaWVzLg0KPj4gRGlzY3Vzc2VkIGluIHRo
ZSBlbWFpbCB0aHJlYWQgd2l0aCB0aGUgbWVzc2FnZSBJRA0KPj4gPDE1NDk5NzQ5NTEtNzMxMjg1
LTEtZ2l0LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+DQo+
PiAgIGJsb2NrL3Fjb3cyLWJpdG1hcC5jIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNv
dzItYml0bWFwLmMgYi9ibG9jay9xY293Mi1iaXRtYXAuYw0KPj4gaW5kZXggM2VlNTI0ZC4uMTYy
NzQ0ZSAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+PiArKysgYi9ibG9j
ay9xY293Mi1iaXRtYXAuYw0KPj4gQEAgLTIwMiw3ICsyMDIsNyBAQCBzdGF0aWMgdm9pZCBjbGVh
cl9iaXRtYXBfdGFibGUoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90ICpiaXRtYXBfdGFi
bGUsDQo+PiAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gICAgICAgICAgIH0NCj4+ICAgDQo+
PiAtICAgICAgICBxY293Ml9mcmVlX2NsdXN0ZXJzKGJzLCBhZGRyLCBzLT5jbHVzdGVyX3NpemUs
IFFDT1cyX0RJU0NBUkRfT1RIRVIpOw0KPj4gKyAgICAgICAgcWNvdzJfZnJlZV9jbHVzdGVycyhi
cywgYWRkciwgcy0+Y2x1c3Rlcl9zaXplLCBRQ09XMl9ESVNDQVJEX0FMV0FZUyk7DQo+PiAgICAg
ICAgICAgYml0bWFwX3RhYmxlW2ldID0gMDsNCj4+ICAgICAgIH0NCj4+ICAgfQ0KPj4NCj4gTG9v
a3MgbGlrZSA0LjEgbWF0ZXJpYWwgbm93LiBLZXZpbiBtYXkgaGF2ZSBiZWVuIGV4cGVjdGluZyBt
ZSB0byBlbmdhZ2UNCj4gd2l0aCB0aGlzLCBldmVuIHRob3VnaCBJIGRvIG5vdCBtYWludGFpbiB0
aGUgcWNvdzItYml0bWFwLmMgZmlsZS4gKEFuZA0KPiBJJ20gdmVyeSBiZWhpbmQgb24gcmVhZGlu
ZyBtYWlsIHRoYXQgd2FzIG5vdCBkaXJlY3RseSBhZGRyZXNzZWQgdG8gbWUsDQo+IHNvcnJ5Li4u
ISkNCj4gDQo+IFBsZWFzZSByZXNlbmQgd2hlbiB0aGUgNC4xIHdpbmRvdyBvcGVucyBhbmQgd2Un
bGwgYWRkcmVzcyB0aGlzIHRoZW4uDQo+IA0KPiAtLWpzDQo+IA0KDQo=

