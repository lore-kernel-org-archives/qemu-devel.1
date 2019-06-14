Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB2C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD61D204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AQKwpKon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD61D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboBi-0007Ib-Jx
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50314)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbnv4-0004Ls-M6
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbnv3-0007XQ-BI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:15:10 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:36589 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbnv2-0007Rw-Su; Fri, 14 Jun 2019 11:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93jMU4BREExXopDlXq/1fp8mAVKJ4Jz8Ae2/N2j6Gc0=;
 b=AQKwpKon0vbgZVgeVii0mn2DdwEY/Pl3xRUZ+OvezlQFotFd06Q3BJhuYY33kFRcmslSN6Xlb8WejEWR14FPX0FtjnCOJXrqEqiS4kCyrkuNN5d3cxFojjNkwfuQ4wNbnGMjWKDrDFc1JpL4VkSgB56t2Mv8U4RJ8BAhivCz9L0=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4131.eurprd08.prod.outlook.com (20.178.118.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 14 Jun 2019 15:15:00 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 15:14:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 19/42] block: Use CAF in bdrv_co_rw_vmstate()
Thread-Index: AQHVIWu2/2D1dZCbpk28+hr8z8bidqabRQKA
Date: Fri, 14 Jun 2019 15:14:59 +0000
Message-ID: <0e69cb07-e957-a38e-e758-8043f74e7d76@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-20-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-20-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:7:67::17) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614181457905
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1aa93900-f71f-44d2-e0d3-08d6f0db112c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4131; 
x-ms-traffictypediagnostic: AM0PR08MB4131:
x-microsoft-antispam-prvs: <AM0PR08MB4131248AE2C7DDFD42C8540EC1EE0@AM0PR08MB4131.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(346002)(136003)(376002)(396003)(189003)(199004)(110136005)(486006)(81166006)(64756008)(86362001)(5660300002)(54906003)(6246003)(316002)(66446008)(446003)(11346002)(66066001)(6436002)(66476007)(2616005)(8676002)(2501003)(4326008)(66556008)(186003)(81156014)(53936002)(8936002)(31696002)(66946007)(476003)(73956011)(6512007)(229853002)(68736007)(71200400001)(71190400001)(52116002)(76176011)(14454004)(36756003)(99286004)(256004)(6486002)(6116002)(102836004)(478600001)(7736002)(6506007)(386003)(305945005)(3846002)(25786009)(14444005)(31686004)(26005)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4131;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:3; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vc/e7yiD1VVaj/dDIO6go2/H3ANWkql/Z8hZN4X8jVT93ovwAw+NJ+GEmh2ezFVb/RQhPGZT65Apmbzz6qG2DWJowTW7uMQKrwGtKBpKLxo9h3aKm7ipyJWauK+tq+fkLB1vOEKVAMWLjxP9XV5o0ABOAjiOsT3GdMj1cO0N75JoBiPTH0CzC7rHTuIOLMumXn7jFG7n7G1qfDvkNByiG9X3urRMxomFbkZDLC35shSWLDnyPJebW1uE9/Qm2u0wUEdSepKVCC016HnGJVPxmL4CE3EOViJexWquz4yaFpankgOcB1pwaKh645i9+8qUgpJAIyC5Bo/pKbS7rsxtW2pbt/KYelCD+NhXGnEZH7DQLSfIM9eJS5aLtz2kgImWDGr6w82ofoyYvpBaPAgdzstkoDTpf2+wy9Os5tkP9qs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FA4C9D950ED2446BD05C11E60CB7130@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa93900-f71f-44d2-e0d3-08d6f0db112c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 15:14:59.8550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4131
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.120
Subject: Re: [Qemu-devel] [PATCH v5 19/42] block: Use CAF in
 bdrv_co_rw_vmstate()
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IElmIGEgbm9kZSB3aG9zZSBkcml2
ZXIgZG9lcyBub3QgcHJvdmlkZSBWTSBzdGF0ZSBmdW5jdGlvbnMgaGFzIGENCj4gbWV0YWRhdGEg
Y2hpbGQsIHRoZSBWTSBzdGF0ZSBzaG91bGQgcHJvYmFibHkgZ28gdGhlcmU7IGlmIGl0IGlzIGEN
Cj4gZmlsdGVyLCB0aGUgVk0gc3RhdGUgc2hvdWxkIHByb2JhYmx5IGdvIHRoZXJlLiAgSXQgZm9s
bG93cyB0aGF0IHdlDQo+IHNob3VsZCBnZW5lcmFsbHkgZ28gZG93biB0byB0aGUgcHJpbWFyeSBj
aGlsZC4NCg0KSG1tLCBhcyBJIHVuZGVyc3RhbmQgdm1zdGF0ZSBpcyBzb21ldGhpbmcgc3RvcmVk
IGluIGZpbGUgYW5kIGludmlzaWJsZSBmb3IgYWN0dWFsIGZpbGUgdXNlciwNCndoaWNoIG1heSBi
ZSBndWVzdCBvciBmb3JtYXQgbm9kZS4uIFNvIGFjdHVhbGx5IGl0IGRvZXNuJ3QgbWF0dGVyIGlu
IHdoaWNoDQpjaGlsZCB0byBzdG9yZSBpdCwgaXQgc2hvdWxkIGJlIHRyYW5zcGFyZW50IGZvciB0
aGUgcGFyZW50Li4gTWF5YmUgdGhlIHJpZ2h0DQp0aGluZyBpcyB0byBsb29wIHRocm91Z2ggY2hp
bGRyZW4gYW5kIHVzZSBmaXJzdCB3aGljaCBzdXBwb3J0cyBzdG9yaW5nIHZtc3RhdGUuDQoNCkJ1
dCBJJ20gT0sgd2l0aCB0aGlzIHRvby4NCg0KKGhtbSB5b3UgYXNzdW1lIHRoYXQgdm1zdGF0ZSBz
aG91bGQgZ28gdG8gbWV0YWRhdGEgY2hpbGQsDQpidXQgdGhlIG9ubHkgZm9ybWF0IHdoaWNoIGhh
cyBzZXBhcmF0ZSBtZXRhZGF0YSBhbmQgc3RvcmFnZSBjaGlsZCBzdG9yZXMgdm1zdGF0ZSB0bw0K
c3RvcmFnZSBjaGlsZCkNCg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
YXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBibG9jay9pby5jIHwgNSAr
KystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2svaW8uYyBiL2Jsb2NrL2lvLmMNCj4gaW5kZXggNjU5
ZWEwYzUyYS4uMTRmOTllMWMwMCAxMDA2NDQNCj4gLS0tIGEvYmxvY2svaW8uYw0KPiArKysgYi9i
bG9jay9pby5jDQo+IEBAIC0yMzk1LDYgKzIzOTUsNyBAQCBiZHJ2X2NvX3J3X3Ztc3RhdGUoQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsIFFFTVVJT1ZlY3RvciAqcWlvdiwgaW50NjRfdCBwb3MsDQo+ICAg
ICAgICAgICAgICAgICAgICAgIGJvb2wgaXNfcmVhZCkNCj4gICB7DQo+ICAgICAgIEJsb2NrRHJp
dmVyICpkcnYgPSBicy0+ZHJ2Ow0KPiArICAgIEJsb2NrRHJpdmVyU3RhdGUgKmNoaWxkX2JzID0g
YmRydl9wcmltYXJ5X2JzKGJzKTsNCj4gICAgICAgaW50IHJldCA9IC1FTk9UU1VQOw0KPiAgIA0K
PiAgICAgICBiZHJ2X2luY19pbl9mbGlnaHQoYnMpOw0KPiBAQCAtMjQwNyw4ICsyNDA4LDggQEAg
YmRydl9jb19yd192bXN0YXRlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBRRU1VSU9WZWN0b3IgKnFp
b3YsIGludDY0X3QgcG9zLA0KPiAgICAgICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAgICAgICBy
ZXQgPSBkcnYtPmJkcnZfc2F2ZV92bXN0YXRlKGJzLCBxaW92LCBwb3MpOw0KPiAgICAgICAgICAg
fQ0KPiAtICAgIH0gZWxzZSBpZiAoYnMtPmZpbGUpIHsNCj4gLSAgICAgICAgcmV0ID0gYmRydl9j
b19yd192bXN0YXRlKGJzLT5maWxlLT5icywgcWlvdiwgcG9zLCBpc19yZWFkKTsNCj4gKyAgICB9
IGVsc2UgaWYgKGNoaWxkX2JzKSB7DQo+ICsgICAgICAgIHJldCA9IGJkcnZfY29fcndfdm1zdGF0
ZShjaGlsZF9icywgcWlvdiwgcG9zLCBpc19yZWFkKTsNCj4gICAgICAgfQ0KPiAgIA0KPiAgICAg
ICBiZHJ2X2RlY19pbl9mbGlnaHQoYnMpOw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=

