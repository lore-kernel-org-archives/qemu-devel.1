Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C96EC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE292081C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 11:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="W4ui4VA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE292081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52235 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVwxm-0004wI-RP
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 07:41:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVwwu-0004HH-RB
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVwws-0002rx-Nb
	for qemu-devel@nongnu.org; Wed, 29 May 2019 07:40:52 -0400
Received: from mail-eopbgr10114.outbound.protection.outlook.com
	([40.107.1.114]:19607
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hVwwo-0002pZ-Qh; Wed, 29 May 2019 07:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=IvpibRitPiACavZEBN4XRAI5G42CmjZKnNNeX53jbys=;
	b=W4ui4VA8xg8tfCrx5BXo0+xW5QigvSBNO5vlzFGjgE04qvPtlOpbGqItgPAAqdltVQIyQgzizsOon6PENYEa0vgejbski8uZIp8D3b7A4W9VvIwJ9HFegaKzd6MG88wfRTnqYeyzmY9bqT5IVfxyTSurozkCT6BIS2RRWfLnNeE=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB5170.eurprd08.prod.outlook.com (10.255.31.84) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.22; Wed, 29 May 2019 11:40:43 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6]) by AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6%4]) with mapi id 15.20.1922.021;
	Wed, 29 May 2019 11:40:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, "kwolf@redhat.com"
	<kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com"
	<armbru@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v0 1/3] qcow2: introduce compression type feature
Thread-Index: AQHVFWL3jaV+mlqzXEmsffTHklJdlqaB++MA
Date: Wed, 29 May 2019 11:40:39 +0000
Message-ID: <507334f0-c680-c975-5001-159087dd0670@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
	<20190528143727.10529-2-dplotnikov@virtuozzo.com>
In-Reply-To: <20190528143727.10529-2-dplotnikov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0029.eurprd01.prod.exchangelabs.com
	(2603:10a6:7:14::42) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190529144036822
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e2d4371-678c-4dad-7ae5-08d6e42a78c6
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB5170; 
x-ms-traffictypediagnostic: AM0PR08MB5170:
x-microsoft-antispam-prvs: <AM0PR08MB5170519EF0DFA26437EA6A36C11F0@AM0PR08MB5170.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(136003)(366004)(39850400004)(376002)(346002)(199004)(189003)(54906003)(53936002)(6436002)(99286004)(305945005)(6486002)(8676002)(102836004)(256004)(110136005)(6512007)(486006)(6506007)(81156014)(386003)(36756003)(2501003)(6246003)(8936002)(316002)(14444005)(25786009)(66066001)(229853002)(31686004)(76176011)(52116002)(107886003)(81166006)(478600001)(86362001)(4326008)(31696002)(66556008)(73956011)(64756008)(66446008)(2201001)(68736007)(26005)(71190400001)(186003)(7736002)(11346002)(476003)(3846002)(6116002)(2616005)(66946007)(14454004)(446003)(2906002)(5660300002)(71200400001)(66476007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5170;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rLE37VM6LjUNXlFSx3+pW7Y1+FUxv5ZvodOa2N+7K/ljbFKkbA6vGQlbB7u2MfMKIps+46/A1DTPwKNL3Cluxwg17QAoYnvZdJxX/YU/WZT/dQYW2weyp88dedJTLHnv4ggT+Hh7bNPfJ8alOyLCWNwJGTqbB+AC5z8Gt1xXZ4bD30ZuIW7JnPuRhiagnSXhCVPKWVGhNHd7KzLSP6cV0s2DCcazkCTEQRGp6Ej7a+WBzZBEfMQ/Z4Cff71kBOdc9lZZ+tU4OblJfUYJ2zB0/V13XRXq7mn7Y2H4GJ1LCu3Cr732w7X/I7naeUwFA/MZd1+Xt2Zwr5uLZEb1jX6tm5Op6TPrXm68VXljyiObgVhU9IgI8EoWmeZXFxLUB54lGxva190bGmH65b/HUqGXYJHsGQ/3kh34rDen622suBc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EF49056F115AC439BFA1394E89870E7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2d4371-678c-4dad-7ae5-08d6e42a78c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 11:40:39.4741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5170
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.114
Subject: Re: [Qemu-devel] [PATCH v0 1/3] qcow2: introduce compression type
 feature
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDUuMjAxOSAxNzozNywgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiBUaGUgcGF0Y2ggYWRk
cyBzb21lIHByZXBhcmF0aW9uIHBhcnRzIGZvciBpbmNvbXBhdGlibGUgY29tcHJlc3Npb24gdHlw
ZQ0KPiBmZWF0dXJlIHRvIFFDT1cyIGhlYWRlciB0aGF0IGluZGljYXRlcyB0aGF0ICphbGwqIGNv
bXByZXNzZWQgY2x1c3RlcnMNCj4gbXVzdCBiZSAoZGUpY29tcHJlc3NlZCB1c2luZyBhIGNlcnRh
aW4gY29tcHJlc3Npb24gdHlwZS4NCj4gDQo+IEl0IGlzIGltcGxpZWQgdGhhdCB0aGUgY29tcHJl
c3Npb24gdHlwZSBpcyBzZXQgb24gdGhlIGltYWdlIGNyZWF0aW9uIGFuZA0KPiBjYW4gYmUgY2hh
bmdlZCBvbmx5IGxhdGVyIGJ5IGltYWdlIGNvbnZlcnNpb24sIHRodXMgY29tcHJlc3Npb24gdHlw
ZQ0KPiBkZWZpbmVzIHRoZSBvbmx5IGNvbXByZXNzaW9uIGFsZ29yaXRobSB1c2VkIGZvciB0aGUg
aW1hZ2UuDQo+IA0KPiBUaGUgZ29hbCBvZiB0aGUgZmVhdHVyZSBpcyB0byBhZGQgc3VwcG9ydCBv
ZiBvdGhlciBjb21wcmVzc2lvbiBhbGdvcml0aG1zDQo+IHRvIHFjb3cyLiBGb3IgZXhhbXBsZSwg
WlNURCB3aGljaCBpcyBtb3JlIGVmZmVjdGl2ZSBvbiBjb21wcmVzc2lvbiB0aGFuIFpMSUIuDQo+
IEl0IHdvcmtzIHJvdWdobHkgeDIgZmFzdGVyIHRoYW4gWkxJQiBwcm92aWRpbmcgYSBjb21wYXJh
YmxlIGNvbXByZXNzaW9uIHJhdGlvDQo+IGFuZCB0aGVyZWZvcmUgcHJvdmlkZSBhIHBlcmZvcm1h
bmNlIGFkdmFudGFnZSBpbiBiYWNrdXAgc2NlbmFyaW9zLg0KPiANCj4gVGhlIGRlZmF1bHQgY29t
cHJlc3Npb24gaXMgWkxJQi4gSW1hZ2VzIGNyZWF0ZWQgd2l0aCBaTElCIGNvbXByZXNzaW9uIHR5
cGUNCj4gaXMgYmFja3dhcmQgY29tcGF0aWJsZSB3aXRoIG9sZGVyIHFlbXUgdmVyc2lvbnMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5pcyBQbG90bmlrb3YgPGRwbG90bmlrb3ZAdmlydHVvenpv
LmNvbT4NCj4gLS0tDQoNClsuLi5dDQoNCj4gZGlmZiAtLWdpdCBhL2RvY3MvaW50ZXJvcC9xY293
Mi50eHQgYi9kb2NzL2ludGVyb3AvcWNvdzIudHh0DQo+IGluZGV4IGFmNTcxMWU1MzMuLmNlYmNi
YzRmMmYgMTAwNjQ0DQo+IC0tLSBhL2RvY3MvaW50ZXJvcC9xY293Mi50eHQNCj4gKysrIGIvZG9j
cy9pbnRlcm9wL3Fjb3cyLnR4dA0KPiBAQCAtMTA5LDcgKzEwOSwxNCBAQCBpbiB0aGUgZGVzY3Jp
cHRpb24gb2YgYSBmaWVsZC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFu
IEV4dGVybmFsIERhdGEgRmlsZSBOYW1lIGhlYWRlciBleHRlbnNpb24gbWF5DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBiZSBwcmVzZW50IGlmIHRoaXMgYml0IGlzIHNldC4N
Cj4gICANCj4gLSAgICAgICAgICAgICAgICAgICAgQml0cyAzLTYzOiAgUmVzZXJ2ZWQgKHNldCB0
byAwKQ0KPiArICAgICAgICAgICAgICAgICAgICBCaXQgMzogICAgICBDb21wcmVzc2lvbiB0eXBl
LiBJZiB0aGUgYml0IGlzIHNldCwgdGhlbiB0aGUNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdHlwZSBvZiBjb21wcmVzc2lvbiB0aGUgaW1hZ2UgdXNlcyBpcyBzZXQgaW4gdGhl
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhlYWRlciBleHRlbnNpb24uIFdo
ZW4gdGhlIGJpdCBpcyBzZXQgdGhlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbXByZXNzaW9uIHR5cGUgZXh0ZW5zaW9uIGhlYWRlciBtdXN0IGJlIHByZXNlbnQuDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFdoZW4gdGhlIGJpdCBpcyBub3Qgc2V0IHRo
ZSBjb21wcmVzc2lvbiB0eXBlDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhl
YWRlciBtdXN0IGFic2VudC4NCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICBCaXRzIDQtNjM6
ICBSZXNlcnZlZCAoc2V0IHRvIDApDQo+ICAgDQo+ICAgICAgICAgICAgODAgLSAgODc6ICBjb21w
YXRpYmxlX2ZlYXR1cmVzDQo+ICAgICAgICAgICAgICAgICAgICAgICBCaXRtYXNrIG9mIGNvbXBh
dGlibGUgZmVhdHVyZXMuIEFuIGltcGxlbWVudGF0aW9uIGNhbg0KPiBAQCAtMTc1LDYgKzE4Miw3
IEBAIGJlIHN0b3JlZC4gRWFjaCBleHRlbnNpb24gaGFzIGEgc3RydWN0dXJlIGxpa2UgdGhlIGZv
bGxvd2luZzoNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAweDIzODUyODc1IC0gQml0bWFw
cyBleHRlbnNpb24NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAweDA1MzdiZTc3IC0gRnVs
bCBkaXNrIGVuY3J5cHRpb24gaGVhZGVyIHBvaW50ZXINCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAweDQ0NDE1NDQxIC0gRXh0ZXJuYWwgZGF0YSBmaWxlIG5hbWUgc3RyaW5nDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAweDQzNEQ1MDUyIC0gQ29tcHJlc3Npb24gdHlwZSBleHRlbnNp
b24NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBvdGhlciAgICAgIC0gVW5rbm93biBoZWFk
ZXIgZXh0ZW5zaW9uLCBjYW4gYmUgc2FmZWx5DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlnbm9yZWQNCj4gICANCj4gQEAgLTc3MSwzICs3NzksMzAgQEAgSW4gdGhl
IGltYWdlIGZpbGUgdGhlICdlbmFibGVkJyBzdGF0ZSBpcyByZWZsZWN0ZWQgYnkgdGhlICdhdXRv
JyBmbGFnLiBJZiB0aGlzDQo+ICAgZmxhZyBpcyBzZXQsIHRoZSBzb2Z0d2FyZSBtdXN0IGNvbnNp
ZGVyIHRoZSBiaXRtYXAgYXMgJ2VuYWJsZWQnIGFuZCBzdGFydA0KPiAgIHRyYWNraW5nIHZpcnR1
YWwgZGlzayBjaGFuZ2VzIHRvIHRoaXMgYml0bWFwIGZyb20gdGhlIGZpcnN0IHdyaXRlIHRvIHRo
ZQ0KPiAgIHZpcnR1YWwgZGlzay4gSWYgdGhpcyBmbGFnIGlzIG5vdCBzZXQgdGhlbiB0aGUgYml0
bWFwIGlzIGRpc2FibGVkLg0KPiArDQo+ICsNCj4gKz09IENvbXByZXNzaW9uIHR5cGUgZXh0ZW5z
aW9uID09DQo+ICsNCj4gK1RoZSBjb21wcmVzc2lvbiB0eXBlIGV4dGVuc2lvbiBpcyBhbiBvcHRp
b25hbCBoZWFkZXIgZXh0ZW5zaW9uLiBJdCBzdG9yZXMgdGhlDQo+ICtjb21wcmVzc2lvbiB0eXBl
IHVzZWQgZm9yIGRpc2sgY2x1c3RlcnMgKGRlKWNvbXByZXNzaW9uLg0KPiArQSBzaW5nbGUgY29t
cHJlc3Npb24gdHlwZSBpcyBhcHBsaWVkIHRvIGFsbCBjb21wcmVzc2VkIGRpc2sgY2x1c3RlcnMs
DQo+ICt3aXRoIG5vIHdheSB0byBjaGFuZ2UgY29tcHJlc3Npb24gdHlwZXMgcGVyIGNsdXN0ZXIu
IFR3byBjbHVzdGVycyBvZiB0aGUgaW1hZ2UNCj4gK2NvdWxkbid0IGJlIGNvbXByZXNzZWQgd2l0
aCBkaWZmZXJlbnQgY29tcHJlc3Npb24gdHlwZXMuDQo+ICsNCj4gK1RoZSBjb21wcmVzc2lvbiB0
eXBlIGlzIHNldCBvbiBpbWFnZSBjcmVhdGlvbi4gVGhlIG9ubHkgd2F5IHRvIGNoYW5nZQ0KPiAr
dGhlIGNvbXByZXNzaW9uIHR5cGUgaXMgdG8gY29udmVydCB0aGUgaW1hZ2UgZXhwbGljaXRseS4N
Cj4gKw0KPiArVGhlIGNvbXByZXNzaW9uIHR5cGUgZXh0ZW5zaW9uIGlzIHByZXNlbnQgaWYgYW5k
IG9ubHkgaWYgdGhlIGluY29tcGF0aWJsZQ0KPiArY29tcHJlc3Npb24gdHlwZSBiaXQgaXMgc2V0
LiBXaGVuIHRoZSBiaXQgaXMgbm90IHNldCB0aGUgY29tcHJlc3Npb24gdHlwZQ0KPiAraGVhZGVy
IG11c3QgYmUgYWJzZW50Lg0KDQpIbW0sIG5vdCB0aGUgZmlyc3QgdGltZSB3ZSBpbnRyb2R1Y2Ug
aW5jb21wYXRpYmxlIGJpdCB0byBtYWtlIGluY29tcGF0aWJsZQ0KaGVhZGVyIGV4dGVuc2lvbiwg
YXMgYWxsIGhlYWRlciBleHRlbnNpb25zIGFyZSBjb21wYXRpYmxlIGJ5IGRlZmF1bHQsIGFzIGZv
cg0KdW5rbm93biBoZWFkZXIgZXh0ZW5zaW9uIHdlIGhhdmU6DQoNCiAgICAgICAgICAgICAgICAg
ICAgICAgICBvdGhlciAgICAgIC0gVW5rbm93biBoZWFkZXIgZXh0ZW5zaW9uLCBjYW4gYmUgc2Fm
ZWx5DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlnbm9yZWQNCg0KSG0u
IFNob3VsZCB3ZSBpbnN0ZWFkIGRlZmluZSBvbmUgaW5jb21wYXRpYmxlIGJpdCBmb3IgYWxsIHN1
Y2ggZnV0dXJlIGNhc2VzLA0KaS5lLiBhZGQgaW5jb21wYXRpYmxlIGJpdCBIRUFERVJfRVhURU5T
SU9OX0ZMQUdTLCBhZGQgZmxhZyBmaWVsZCB0byBoZWFkZXINCmV4dGVuc2lvbiBkZWNsYXJhdGlv
biwgYW5kIGRlZmluZSBvbmUgZmxhZyBpbiBpdDogQ09NUEFUSUJMRSwgd2hpY2ggd2lsbCBtZWFu
LA0KdGhhdCB0aGlzIGV4dGVuc2lvbiBtYXkgYmUgc2FmZWx5IGlnbm9yZWQgKG9sZCBkZWZhdWx0
IGJlaGF2aW9yKS4NCg0KPiArDQo+ICtXaGVuIHRoZSBjb21wcmVzc2lvbiB0eXBlIGJpdCBpcyBu
b3Qgc2V0IGFuZCB0aGUgY29tcHJlc3Npb24gdHlwZSBoZWFkZXINCj4gK2V4dGVuc2lvbiBpcyBh
YnNlbnQsIFpMSUIgY29tcHJlc3Npb24gaXMgdXNlZCBmb3IgY29tcHJlc3NlZCBjbHVzdGVycy4N
Cj4gK1RoaXMgZGVmaW5lcyBkZWZhdWx0IGltYWdlIGNvbXByZXNzaW9uIHR5cGU6IFpMSUIuDQo+
ICtRZW11IDwgNC4xIGNhbiB1c2UgaW1hZ2VzIGNyZWF0ZWQgd2l0aCBjb21wcmVzc2lvbiB0eXBl
IFpMSUIgd2l0aG91dCBhbnkNCj4gK2FkZGl0aW9uYWwgcHJlcGFyYXRpb25zIGFuZCBjYW5ub3Qg
dXNlIGltYWdlcyBjcmVhdGVkIHdpdGggY29tcHJlc3Npb24NCj4gK3R5cGVzICE9IFpMSUIuDQo+
ICsNCj4gK0F2YWlsYWJsZSBjb21wcmVzc2lvbiB0eXBlczoNCj4gKyAgICAwOiBaTElCDQo+ICsg
ICAgMTogWlNURA0KDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

