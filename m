Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A765DC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AE120830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HXeBb4oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AE120830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhLS-0001fT-HV
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:24:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNhGq-0006IA-PE
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNhGp-0005nS-Qp
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:19:20 -0400
Received: from mail-eopbgr120102.outbound.protection.outlook.com
	([40.107.12.102]:52945
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNhGn-0005ix-Jz; Mon, 06 May 2019 13:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=NCNXWomry8OXKi8oPCuyrT9vvaALdtQZyRTXMOQn6bk=;
	b=HXeBb4oH1qPLOMV4TO/PfkyAppc1IzM0Lml1nv7L0UDkfqWRJgxGYXlI5WX9SflTKn9XcoGBNOlA/mrKhKs+UyETwxIJSwEjvi+MeP9szCXbVqcYb2HDzQsS6sM9e0IMi+j7bBr5JXPs/0bVPiUlkW7VU5EaL6J1i8KQz11CFAY=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB5226.eurprd08.prod.outlook.com (52.133.110.85) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Mon, 6 May 2019 17:19:14 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 17:19:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 3/5] vvfat: Replace bdrv_{read, write}()
	with bdrv_{pread, pwrite}()
Thread-Index: AQHVAErQYNmfHrX4XUG7LuH1I77KcaZeVhIAgAAFe4CAAAOCAA==
Date: Mon, 6 May 2019 17:19:14 +0000
Message-ID: <4a09edd8-f89e-ec70-b56d-63e93396982b@virtuozzo.com>
References: <cover.1556732434.git.berto@igalia.com>
	<524e211cb818a20f521d6e271e782ab62b8e5e80.1556732434.git.berto@igalia.com>
	<8bff27c1-a93c-d9f0-c95c-6d10d5700f91@virtuozzo.com>
	<cd1d6df5-3540-910e-d39b-9074b94ffd38@redhat.com>
In-Reply-To: <cd1d6df5-3540-910e-d39b-9074b94ffd38@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0001.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::14)
	To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190506201911941
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d74fd7dc-a6de-4ea9-6b64-08d6d246f648
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB5226; 
x-ms-traffictypediagnostic: PR2PR08MB5226:
x-microsoft-antispam-prvs: <PR2PR08MB5226304424B59FE4FEA1C978C1300@PR2PR08MB5226.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:370;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39840400004)(346002)(136003)(396003)(366004)(376002)(199004)(189003)(36756003)(2616005)(446003)(486006)(11346002)(476003)(102836004)(386003)(53546011)(6506007)(478600001)(14454004)(26005)(186003)(5660300002)(71190400001)(71200400001)(2501003)(7736002)(305945005)(2906002)(68736007)(31686004)(66066001)(81166006)(8676002)(8936002)(81156014)(3846002)(6116002)(6436002)(256004)(316002)(110136005)(6246003)(25786009)(73956011)(6486002)(4326008)(54906003)(229853002)(66476007)(66556008)(66946007)(76176011)(6512007)(53936002)(99286004)(86362001)(31696002)(66446008)(64756008)(52116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB5226;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RnKt+HP3YBAJNN9xv52zTFGcuczhPcrPHge95KmndX2fv4jqJdmOTq4oaxAzUp66lg2KhXle9BXOPLucqa/k/P0WI2v8APzTSzlMVnFn3zdKybfDJI2JRDRzkB3YgKIpKXcuWtAzPqZ+8jYk07rUFtStTkCdrVvQh++cabKiTsJdU9Za5d3KCXRfqTFfx7yICF4uaXmJCyv94DR0QaE+AEruo/3bTO4+86r3z1HXBW8uTzWadFcgcONZRuEHo3U3jkYnO+i4A0i11ElBUb+ecrKuNIx9Ju+jzuCpaQXnZe4TcPPc3GX9c4rur65xluttedJrRv5QrGcnA5FKqd2GuhVRRqTH0xBOkebCFTehUvSQso+Cm4eooJeTnQzj4gpfjO7Cd7+bwF9g8whmKup28UY3hwLMV3T9tRgQf2Y47B4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CA0B0F3595C974B877BC9ECE054B5D3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74fd7dc-a6de-4ea9-6b64-08d6d246f648
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 17:19:14.6292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB5226
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.102
Subject: Re: [Qemu-devel] [PATCH v2 3/5] vvfat: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMDUuMjAxOSAyMDowNiwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNS82LzE5IDExOjQ3IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMDEuMDUuMjAxOSAyMTox
MywgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+Pj4gVGhlcmUncyBvbmx5IGEgY291cGxlIG9mIGJk
cnZfcmVhZCgpIGFuZCBiZHJ2X3dyaXRlKCkgY2FsbHMgbGVmdCBpbg0KPj4+IHRoZSB2dmZhdCBj
b2RlLCBhbmQgdGhleSBjYW4gYmUgdHJpdmlhbGx5IHJlcGxhY2VkIHdpdGggdGhlIGJ5dGUtYmFz
ZWQNCj4+PiBiZHJ2X3ByZWFkKCkgYW5kIGJkcnZfcHdyaXRlKCkuDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBBbGJlcnRvIEdhcmNpYSA8YmVydG9AaWdhbGlhLmNvbT4NCj4+PiAtLS0NCj4+PiAg
ICBibG9jay92dmZhdC5jIHwgMTIgKysrKysrKy0tLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9i
bG9jay92dmZhdC5jIGIvYmxvY2svdnZmYXQuYw0KPj4+IGluZGV4IDVmNjY3ODc4OTAuLjI1M2Nj
NzE2ZGQgMTAwNjQ0DQo+Pj4gLS0tIGEvYmxvY2svdnZmYXQuYw0KPj4+ICsrKyBiL2Jsb2NrL3Z2
ZmF0LmMNCj4+PiBAQCAtMTQ5NCw4ICsxNDk0LDggQEAgc3RhdGljIGludCB2dmZhdF9yZWFkKEJs
b2NrRHJpdmVyU3RhdGUgKmJzLCBpbnQ2NF90IHNlY3Rvcl9udW0sDQo+Pj4gICAgICAgICAgICAg
ICAgICAgIERMT0coZnByaW50ZihzdGRlcnIsICJzZWN0b3JzICUiIFBSSWQ2NCAiKyUiIFBSSWQ2
NA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiBhbGxvY2F0ZWRcbiIsIHNl
Y3Rvcl9udW0sDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuID4+IEJEUlZf
U0VDVE9SX0JJVFMpKTsNCj4+PiAtICAgICAgICAgICAgICAgIGlmIChiZHJ2X3JlYWQocy0+cWNv
dywgc2VjdG9yX251bSwgYnVmICsgaSAqIDB4MjAwLA0KPj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBuID4+IEJEUlZfU0VDVE9SX0JJVFMpKSB7DQo+Pj4gKyAgICAgICAgICAgICAg
ICBpZiAoYmRydl9wcmVhZChzLT5xY293LCBzZWN0b3JfbnVtICogQkRSVl9TRUNUT1JfU0laRSwN
Cj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJ1ZiArIGkgKiAweDIwMCwgbikg
PCAwKSB7DQo+Pg0KPj4gU2hvdWxkbid0IHdlIHVzZSBRRU1VX0FMSUdOX0RPV04obiwgQkRSVl9T
RUNUT1JfU0laRSkgPw0KPiANCj4gTm8sIG4gc2hvdWxkIGFscmVhZHkgYmUgYWxpZ25lZCwgd2hp
Y2ggbWFrZXMgYWxpZ25fZG93biBhIG5vLW9wLg0KPiANCj4+IENvdWxkIGJkcnZfaXNfYWxsb2Nh
dGVkIGdpdmUgdW5hbGlnbmVkIG4/DQo+Pg0KPiANCj4gWWVzLCBiZHJ2X2lzX2FsbG9jYXRlZCBj
YW4gcmV0dXJuIHVuYWxpZ25lZCBuIGluIHNvbWUgc2l0dWF0aW9uczsgSSBoYWQNCj4gYSBwYXRj
aCB0aGF0IGRpZG4ndCBtYWtlIDQuMCB0aGF0IHdvdWxkIGFkZCBiZHJ2X2Jsb2NrX3N0YXR1c19h
bGlnbmVkDQo+IGZvciBjYXNlcyB3aGVyZSB3ZSBuZWVkIHRvIGd1YXJhbnRlZSB0aGF0IGRpZmZl
cmVudCBhbGlnbm1lbnQgb2YgYQ0KPiBiYWNraW5nIGNoYWluIGRvZXNuJ3QgYmxlZWQgdGhyb3Vn
aCB0byB0aGUgc3BlY2lmaWVkIGFsaWdubWVudCBvZiB0aGUNCj4gY3VycmVudCBsYXllci4gQnV0
IHRob3NlIHNpdHVhdGlvbnMgYXJlIHJhcmUsIGFuZCBJIG5lZWQgdG8gcmV2aXNpdA0KPiB0aG9z
ZSBhbmQgc2VuZCBhIHYyOyBzbyBJIGRvbid0IHNlZSBhIHByb2JsZW0gd2l0aCB0aGlzIG9uZSBn
b2luZyBpbg0KPiBkdXJpbmcgdGhlIG1lYW50aW1lIGFzLWlzLg0KPiANCg0KVGhhbiwgbiBpcyBu
b3QgYWxyZWFkeSBhbGlnbmVkLCBhcyBpdCBjb21lcyBmcm9tIGJkcnZfaXNfYWxsb2NhdGVkLg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

