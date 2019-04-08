Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEB1C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 12:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2252087F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 12:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M0URnkQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2252087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52223 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDTC4-0005QW-Re
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 08:16:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDTBA-0004zC-1S
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDTB8-0007uz-1o
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 08:15:11 -0400
Received: from mail-eopbgr150111.outbound.protection.outlook.com
	([40.107.15.111]:48558
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hDTAz-0007ij-Sp; Mon, 08 Apr 2019 08:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=7RfftQeTMz0edQXrwgcNlAfrU7RMGxoe4oW7vaf4L+I=;
	b=M0URnkQCar6HqrLojnzjKVITE8VrHOvdPYBUUKr0LBBl5LySnIHPeftvEJdm/2yqXw/dxxHklW9kFgZMJ9wa5t9RZxPWOiHFYyQScOhQxuWjmSG5IImB6EIC6KG7rh0ulvBp/uba8oEx6x2R8BiwC5iHhLnvjygj43dQrcyEd64=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3324.eurprd08.prod.outlook.com (52.134.111.143) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.18; Mon, 8 Apr 2019 12:14:55 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1771.021;
	Mon, 8 Apr 2019 12:14:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH 2/7] nbd/server: Trace server noncompliance on unaligned
	requests
Thread-Index: AQHU6cocegMEUkn+302xS4dmtchABqYtpzmAgABaoYCABDPmgA==
Date: Mon, 8 Apr 2019 12:14:55 +0000
Message-ID: <d646c7db-fd11-617e-019f-fa46f5427a33@virtuozzo.com>
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-3-eblake@redhat.com>
	<ae484c62-04f9-5b4e-03d0-bf368ed7714a@virtuozzo.com>
	<d974e0e2-ced3-bff3-d75c-84a41013bffa@redhat.com>
In-Reply-To: <d974e0e2-ced3-bff3-d75c-84a41013bffa@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0050.eurprd04.prod.outlook.com
	(2603:10a6:7:7c::39) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190408151451882
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a21fd6be-c47e-42f6-420a-08d6bc1bcf5b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3324; 
x-ms-traffictypediagnostic: DB7PR08MB3324:
x-microsoft-antispam-prvs: <DB7PR08MB33248C1CAA5B75D21F2C70FCC12C0@DB7PR08MB3324.eurprd08.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(396003)(39840400004)(366004)(136003)(346002)(52314003)(189003)(199004)(31686004)(2906002)(8676002)(99286004)(86362001)(6116002)(2501003)(68736007)(110136005)(3846002)(31696002)(106356001)(305945005)(66066001)(81156014)(316002)(36756003)(7736002)(229853002)(478600001)(81166006)(6512007)(93886005)(486006)(386003)(53546011)(14444005)(97736004)(6506007)(71190400001)(6486002)(71200400001)(5660300002)(76176011)(14454004)(11346002)(8936002)(105586002)(25786009)(186003)(54906003)(53936002)(26005)(6246003)(4326008)(476003)(2616005)(6436002)(102836004)(446003)(256004)(52116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3324;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RmgCyDdM7dqo3olwZYBruEh9FLKZQrNqxGcmiYortuc6FJ3PAb5YGyVbRYl/IBzzisi5VYO2OiQBZEC3EZL6tNugLKd6oGC4KO1uNl31g0QRfFrc7Bxy9+0fI9Fe6+tlH595A2yRc30MmynL4D3kLu2jhc9d9V5jDvQe+uYAHyQmgbUS3YoHKiJB+AuxmmWegDpd3oZqXeLmfxn4gd5XjGNMSLmOuQBJC6xiibtZp6hfo822zljXkOQ9O1fyZKRqwjEse1TAlx9MX8fPUtVpe7vPQ6+sqg+WhUuYq6unylvaM9MXsf72rhJGwaXao2xS/23TJ1n2zU92zaArecyyG6eHm1RqoGt7R8CIJfi6E0b7RKzUYALQDAXYH9HZ4VJzVI/AJ6g4GBHtn6Tb18AoIN27MD8kQ9R2MqHFNgWjeHo=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <999F923FB4AC9D47903839FC8F9DA4ED@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21fd6be-c47e-42f6-420a-08d6bc1bcf5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 12:14:55.1899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3324
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.111
Subject: Re: [Qemu-devel] [PATCH 2/7] nbd/server: Trace server noncompliance
 on unaligned requests
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
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408121455.yQwls3-f3U0a1RWbVFTjnfaM-kWZqIryVNbsUjOVwt4@z>

MDUuMDQuMjAxOSAyMzowNCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNC81LzE5IDk6MzkgQU0s
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiAwMy4wNC4yMDE5IDY6MDUs
IEVyaWMgQmxha2Ugd3JvdGU6DQo+Pj4gV2UndmUgcmVjZW50bHkgYWRkZWQgdHJhY2VzIGZvciBj
bGllbnRzIHRvIGZsYWcgc2VydmVyIG5vbi1jb21wbGlhbmNlOw0KPj4+IGxldCdzIGRvIHRoZSBz
YW1lIGZvciBzZXJ2ZXJzIHRvIGZsYWcgY2xpZW50IG5vbi1jb21wbGlhbmNlLiBBY2NvcmRpbmcN
Cj4gDQo+IFRodXMsIHMvVHJhY2Ugc2VydmVyL1RyYWNlIGNsaWVudC8gaW4gdGhlIHN1YmplY3Qg
bGluZS4NCj4gDQo+Pj4NCj4+PiBRZW11IGFzIGNsaWVudCB1c2VkIHRvIGhhdmUgb25lIHNwb3Qg
d2hlcmUgaXQgc2VudCBub24tY29tcGxpYW50DQo+Pj4gcmVxdWVzdHM6IGlmIHRoZSBzZXJ2ZXIg
c2VuZHMgYW4gdW5hbGlnbmVkIHJlcGx5IHRvDQo+Pj4gTkJEX0NNRF9CTE9DS19TVEFUVVMsIGFu
ZCB0aGUgY2xpZW50IHdhcyBpdGVyYXRpbmcgb3ZlciB0aGUgZW50aXJlDQo+Pj4gZGlzaywgdGhl
IG5leHQgcmVxdWVzdCB3b3VsZCBzdGFydCBhdCB0aGF0IHVuYWxpZ25lZCBwb2ludDsgdGhpcyB3
YXMNCj4+PiBmaXhlZCBpbiBjb21taXQgYTM5Mjg2ZGQgd2hlbiB0aGUgY2xpZW50IHdhcyB0YXVn
aHQgdG8gd29yayBhcm91bmQNCj4+PiBzZXJ2ZXIgbm9uLWNvbXBsaWFuY2U7IGJ1dCBpcyBlcXVh
bGx5IGZpeGVkIGlmIHRoZSBzZXJ2ZXIgaXMgcGF0Y2hlZA0KPj4+IHRvIG5vdCBzZW5kIHVuYWxp
Z25lZCByZXBsaWVzIGluIHRoZSBmaXJzdCBwbGFjZSAodGhlIG5leHQgZmV3IHBhdGNoZXMNCj4+
PiB3aWxsIGFkZHJlc3MgdGhhdCkuDQo+IA0KPiBJJ2xsIGhhdmUgdG8gcmV3b3JkIHRoaXMgbm93
IHRoYXQgd2Uga25vdyA0LjAgd2lsbCBzdGlsbCBoYXZlIHNvbWUgb2YNCj4gdGhvc2Ugc2VydmVy
IGJ1Z3MgaW4gcGxhY2UgKGFzIHRoZSB0YWlsIG9mIHRoaXMgc2VyaWVzIGlzIGRlZmVycmVkIHRv
IDQuMSkuDQo+IA0KPiANCj4+PiBAQCAtNjYwLDYgKzY2Miw4IEBAIHN0YXRpYyBpbnQgbmJkX25l
Z290aWF0ZV9oYW5kbGVfaW5mbyhOQkRDbGllbnQgKmNsaWVudCwgdWludDE2X3QgbXlmbGFncywN
Cj4+Pg0KPj4+ICAgICAgICBpZiAoY2xpZW50LT5vcHQgPT0gTkJEX09QVF9HTykgew0KPj4+ICAg
ICAgICAgICAgY2xpZW50LT5leHAgPSBleHA7DQo+Pj4gKyAgICAgICAgY2xpZW50LT5jaGVja19h
bGlnbiA9IGJsb2Nrc2l6ZSA/DQo+Pj4gKyAgICAgICAgICAgIGJsa19nZXRfcmVxdWVzdF9hbGln
bm1lbnQoZXhwLT5ibGspIDogMDsNCj4+DQo+PiBJIHRoaW5rIGJldHRlciBzZXQgaW4gc2FtZSBw
bGFjZSwgd2hlcmUgc2l6ZXNbMF0gc2V0LCBvciB1c2Ugc2l6ZXNbMF0gaGVyZSBvciBhZGQgc2Vw
YXJhdGUgbG9jYWwNCj4+IHZhcmliYWxlIGZvciBpdCwgc28gdGhhdCwgaWYgInNpemVzWzBdID0i
IGNoYW5nZXMgc29tZWhvdywgd2Ugd2lsbCBub3QgZm9yZ2V0IHRvIGZpeCB0aGlzIHBsYWNlIHRv
by4NCj4gDQo+IEkgZG9uJ3Qgd2FudCB0byBzZXQgY2xpZW50LT5jaGVja19hbGlnbiBmb3IgTkJE
X09QVF9JTkZPOyBidXQgSSBjYW4NCj4gaW5kZWVkIHVzZSBhIHRlbXBvcmFyeSB2YXJpYWJsZSBv
ciBob2lzdCB0aGUgY29tcHV0YXRpb24gc28gdGhhdCBpdCBpcw0KPiBhbGwgaW4gb25lIHNwb3Qu
DQo+IA0KPiANCj4+PiArKysgYi9uYmQvdHJhY2UtZXZlbnRzDQo+Pj4gQEAgLTcxLDQgKzcxLDUg
QEAgbmJkX2NvX3NlbmRfZXh0ZW50cyh1aW50NjRfdCBoYW5kbGUsIHVuc2lnbmVkIGludCBleHRl
bnRzLCB1aW50MzJfdCBpZCwgdWludDY0X3QNCj4+PiAgICBuYmRfY29fc2VuZF9zdHJ1Y3R1cmVk
X2Vycm9yKHVpbnQ2NF90IGhhbmRsZSwgaW50IGVyciwgY29uc3QgY2hhciAqZXJybmFtZSwgY29u
c3QgY2hhciAqbXNnKSAiU2VuZCBzdHJ1Y3R1cmVkIGVycm9yIHJlcGx5OiBoYW5kbGUgPSAlIiBQ
Ukl1NjQgIiwgZXJyb3IgPSAlZCAoJXMpLCBtc2cgPSAnJXMnIg0KPj4+ICAgIG5iZF9jb19yZWNl
aXZlX3JlcXVlc3RfZGVjb2RlX3R5cGUodWludDY0X3QgaGFuZGxlLCB1aW50MTZfdCB0eXBlLCBj
b25zdCBjaGFyICpuYW1lKSAiRGVjb2RpbmcgdHlwZTogaGFuZGxlID0gJSIgUFJJdTY0ICIsIHR5
cGUgPSAlIiBQUkl1MTYgIiAoJXMpIg0KPj4+ICAgIG5iZF9jb19yZWNlaXZlX3JlcXVlc3RfcGF5
bG9hZF9yZWNlaXZlZCh1aW50NjRfdCBoYW5kbGUsIHVpbnQzMl90IGxlbikgIlBheWxvYWQgcmVj
ZWl2ZWQ6IGhhbmRsZSA9ICUiIFBSSXU2NCAiLCBsZW4gPSAlIiBQUkl1MzINCj4+PiArbmJkX2Nv
X3JlY2VpdmVfYWxpZ25fY29tcGxpYW5jZShjb25zdCBjaGFyICpvcCkgImNsaWVudCBzZW50IG5v
bi1jb21wbGlhbnQgdW5hbGlnbmVkICVzIHJlcXVlc3QiDQo+Pg0KPj4gRG9uJ3QgeW91IHdhbnQg
cHJpbnQgcmVxdWVzdC0+ZnJvbSwgcmVxdWVzdC0+bGVuIGFuZCBjbGllbnQtPmNoZWNrX2FsaWdu
IGFzIHdlbGw/DQo+IA0KPiBXb3VsZG4ndCBodXJ0Lg0KPiANCj4+DQo+Pj4gICAgbmJkX3RyaXAo
dm9pZCkgIlJlYWRpbmcgcmVxdWVzdCINCj4+Pg0KPj4NCj4+IFBhdGNoIHNlZW1zIGNvcnJlY3Qg
YW55d2F5LCBzbyBpZiB5b3UgYXJlIGluIGEgaHVycnksIGl0J3MgT0sgYXMgaXM6DQo+Pg0KPj4g
UmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmly
dHVvenpvLmNvbT4NCj4+DQo+IA0KPiBIZXJlJ3Mgd2hhdCBJJ2xsIHNxdWFzaCBpbjsgSSB0aGlu
ayBpdCBpcyBvYnZpb3VzIGVub3VnaCB0byBzdGlsbCBrZWVwDQo+IHlvdXIgUi1iLCBpZiBJIHNl
bmQgdGhlIHB1bGwgcmVxdWVzdCBiZWZvcmUgeW91IHJlcGx5IGJhY2suDQo+IA0KPiBkaWZmIC0t
Z2l0IGkvbmJkL3NlcnZlci5jIHcvbmJkL3NlcnZlci5jDQo+IGluZGV4IDMwNDBjZWI1NjA2Li5j
YjM4ZGZlNjkwMiAxMDA2NDQNCj4gLS0tIGkvbmJkL3NlcnZlci5jDQo+ICsrKyB3L25iZC9zZXJ2
ZXIuYw0KPiBAQCAtNTM1LDYgKzUzNSw3IEBAIHN0YXRpYyBpbnQgbmJkX25lZ290aWF0ZV9oYW5k
bGVfaW5mbyhOQkRDbGllbnQNCj4gKmNsaWVudCwgdWludDE2X3QgbXlmbGFncywNCj4gICAgICAg
Ym9vbCBibG9ja3NpemUgPSBmYWxzZTsNCj4gICAgICAgdWludDMyX3Qgc2l6ZXNbM107DQo+ICAg
ICAgIGNoYXIgYnVmW3NpemVvZih1aW50NjRfdCkgKyBzaXplb2YodWludDE2X3QpXTsNCj4gKyAg
ICB1aW50MzJfdCBjaGVja19hbGlnbiA9IDA7DQo+IA0KPiAgICAgICAvKiBDbGllbnQgc2VuZHM6
DQo+ICAgICAgICAgICA0IGJ5dGVzOiBMLCBuYW1lIGxlbmd0aCAoY2FuIGJlIDApDQo+IEBAIC02
MTEsNyArNjEyLDcgQEAgc3RhdGljIGludCBuYmRfbmVnb3RpYXRlX2hhbmRsZV9pbmZvKE5CRENs
aWVudA0KPiAqY2xpZW50LCB1aW50MTZfdCBteWZsYWdzLA0KPiAgICAgICAgKiB3aGV0aGVyIHRo
aXMgaXMgT1BUX0lORk8gb3IgT1BUX0dPLiAqLw0KPiAgICAgICAvKiBtaW5pbXVtIC0gMSBmb3Ig
YmFjay1jb21wYXQsIG9yIGFjdHVhbCBpZiBjbGllbnQgd2lsbCBvYmV5IGl0LiAqLw0KPiAgICAg
ICBpZiAoY2xpZW50LT5vcHQgPT0gTkJEX09QVF9JTkZPIHx8IGJsb2Nrc2l6ZSkgew0KPiAtICAg
ICAgICBzaXplc1swXSA9IGJsa19nZXRfcmVxdWVzdF9hbGlnbm1lbnQoZXhwLT5ibGspOw0KPiAr
ICAgICAgICBjaGVja19hbGlnbiA9IHNpemVzWzBdID0gYmxrX2dldF9yZXF1ZXN0X2FsaWdubWVu
dChleHAtPmJsayk7DQo+ICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICBzaXplc1swXSA9IDE7
DQo+ICAgICAgIH0NCj4gQEAgLTY2Miw4ICs2NjMsNyBAQCBzdGF0aWMgaW50IG5iZF9uZWdvdGlh
dGVfaGFuZGxlX2luZm8oTkJEQ2xpZW50DQo+ICpjbGllbnQsIHVpbnQxNl90IG15ZmxhZ3MsDQo+
IA0KPiAgICAgICBpZiAoY2xpZW50LT5vcHQgPT0gTkJEX09QVF9HTykgew0KPiAgICAgICAgICAg
Y2xpZW50LT5leHAgPSBleHA7DQo+IC0gICAgICAgIGNsaWVudC0+Y2hlY2tfYWxpZ24gPSBibG9j
a3NpemUgPw0KPiAtICAgICAgICAgICAgYmxrX2dldF9yZXF1ZXN0X2FsaWdubWVudChleHAtPmJs
aykgOiAwOw0KPiArICAgICAgICBjbGllbnQtPmNoZWNrX2FsaWduID0gY2hlY2tfYWxpZ247DQo+
ICAgICAgICAgICBRVEFJTFFfSU5TRVJUX1RBSUwoJmNsaWVudC0+ZXhwLT5jbGllbnRzLCBjbGll
bnQsIG5leHQpOw0KPiAgICAgICAgICAgbmJkX2V4cG9ydF9nZXQoY2xpZW50LT5leHApOw0KPiAg
ICAgICAgICAgbmJkX2NoZWNrX21ldGFfZXhwb3J0KGNsaWVudCk7DQo+IEBAIC0yMTM2LDcgKzIx
MzYsMTAgQEAgc3RhdGljIGludCBuYmRfY29fcmVjZWl2ZV9yZXF1ZXN0KE5CRFJlcXVlc3REYXRh
DQo+ICpyZXEsIE5CRFJlcXVlc3QgKnJlcXVlc3QsDQo+ICAgICAgICAgICAgKiBUaGUgYmxvY2sg
bGF5ZXIgZ3JhY2VmdWxseSBoYW5kbGVzIHVuYWxpZ25lZCByZXF1ZXN0cywgYnV0DQo+ICAgICAg
ICAgICAgKiBpdCdzIHN0aWxsIHdvcnRoIHRyYWNpbmcgY2xpZW50IG5vbi1jb21wbGlhbmNlDQo+
ICAgICAgICAgICAgKi8NCj4gLQ0KPiB0cmFjZV9uYmRfY29fcmVjZWl2ZV9hbGlnbl9jb21wbGlh
bmNlKG5iZF9jbWRfbG9va3VwKHJlcXVlc3QtPnR5cGUpKTsNCj4gKyAgICAgICAgdHJhY2VfbmJk
X2NvX3JlY2VpdmVfYWxpZ25fY29tcGxpYW5jZShuYmRfY21kX2xvb2t1cChyZXF1ZXN0LT50eXBl
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJlcXVlc3QtPmZyb20sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVxdWVzdC0+bGVuLA0KPiArDQo+IGNs
aWVudC0+Y2hlY2tfYWxpZ24pKTsNCg0Kc29tZXRoaW5nIHN0cmFuZ2UgaGVyZSB3aXRoIGJyYWNr
ZXRzLg0KDQo+ICAgICAgIH0NCj4gICAgICAgdmFsaWRfZmxhZ3MgPSBOQkRfQ01EX0ZMQUdfRlVB
Ow0KPiAgICAgICBpZiAocmVxdWVzdC0+dHlwZSA9PSBOQkRfQ01EX1JFQUQgJiYgY2xpZW50LT5z
dHJ1Y3R1cmVkX3JlcGx5KSB7DQo+IGRpZmYgLS1naXQgaS9uYmQvdHJhY2UtZXZlbnRzIHcvbmJk
L3RyYWNlLWV2ZW50cw0KPiBpbmRleCA4N2EyYjg5NmMzNS4uZWMyZDQ2YzkyNDcgMTAwNjQ0DQo+
IC0tLSBpL25iZC90cmFjZS1ldmVudHMNCj4gKysrIHcvbmJkL3RyYWNlLWV2ZW50cw0KPiBAQCAt
NzEsNSArNzEsNSBAQCBuYmRfY29fc2VuZF9leHRlbnRzKHVpbnQ2NF90IGhhbmRsZSwgdW5zaWdu
ZWQgaW50DQo+IGV4dGVudHMsIHVpbnQzMl90IGlkLCB1aW50NjRfdA0KPiAgIG5iZF9jb19zZW5k
X3N0cnVjdHVyZWRfZXJyb3IodWludDY0X3QgaGFuZGxlLCBpbnQgZXJyLCBjb25zdCBjaGFyDQo+
ICplcnJuYW1lLCBjb25zdCBjaGFyICptc2cpICJTZW5kIHN0cnVjdHVyZWQgZXJyb3IgcmVwbHk6
IGhhbmRsZSA9ICUiDQo+IFBSSXU2NCAiLCBlcnJvciA9ICVkICglcyksIG1zZyA9ICclcyciDQo+
ICAgbmJkX2NvX3JlY2VpdmVfcmVxdWVzdF9kZWNvZGVfdHlwZSh1aW50NjRfdCBoYW5kbGUsIHVp
bnQxNl90IHR5cGUsDQo+IGNvbnN0IGNoYXIgKm5hbWUpICJEZWNvZGluZyB0eXBlOiBoYW5kbGUg
PSAlIiBQUkl1NjQgIiwgdHlwZSA9ICUiIFBSSXUxNg0KPiAiICglcykiDQo+ICAgbmJkX2NvX3Jl
Y2VpdmVfcmVxdWVzdF9wYXlsb2FkX3JlY2VpdmVkKHVpbnQ2NF90IGhhbmRsZSwgdWludDMyX3Qg
bGVuKQ0KPiAiUGF5bG9hZCByZWNlaXZlZDogaGFuZGxlID0gJSIgUFJJdTY0ICIsIGxlbiA9ICUi
IFBSSXUzMg0KPiAtbmJkX2NvX3JlY2VpdmVfYWxpZ25fY29tcGxpYW5jZShjb25zdCBjaGFyICpv
cCkgImNsaWVudCBzZW50DQo+IG5vbi1jb21wbGlhbnQgdW5hbGlnbmVkICVzIHJlcXVlc3QiDQo+
ICtuYmRfY29fcmVjZWl2ZV9hbGlnbl9jb21wbGlhbmNlKGNvbnN0IGNoYXIgKm9wLCB1aW50NjRf
dCBmcm9tLCB1aW50MzJfdA0KPiBsZW4sIHVpbnQzMl90IGFsaWduKSAiY2xpZW50IHNlbnQgbm9u
LWNvbXBsaWFudCB1bmFsaWduZWQgJXMgcmVxdWVzdDoNCj4gZnJvbT0weCUiIFBSSXg2NCAiLCBs
ZW49MHgleCwgYWxpZ249MHgleCINCg0KJXggb3IgJSBQUkl4MzIgLSBkb2Vzbid0IG1hdHRlcj8N
Cg0KPiAgIG5iZF90cmlwKHZvaWQpICJSZWFkaW5nIHJlcXVlc3QiDQo+IA0KPiANCj4gDQoNCk9L
IGZvciBtZSwgdGhhbmtzLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

