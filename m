Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1EBC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 16:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C932054F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 16:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JlS3zkla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C932054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfSHw-0008Bk-Nh
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 12:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38649)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfSFr-0006yc-Ne
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 12:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hfSFn-0001Rs-Q9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 12:55:41 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com
 ([40.107.8.94]:44513 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hfSFg-0001Ey-JU; Mon, 24 Jun 2019 12:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF8g/hPlElBNOopz17um3bogUBP7kwRZD/ag1InAYx4=;
 b=JlS3zkla5mLJcW57Fqq5kT5laKAx+Yj0yOTkndenTeFmU9+9shSdOZpTYNqhp+pA43a/2xPiU4TVyLnjvky9OM+7ZKt9dWcz7KCEW9gJjN4JnJZoPI0DoqIVqWNg+dHnw903SCisHOj2r2j59Akr9uLw8tNGMycKdAWjsyrP/ek=
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com (20.177.61.92) by
 VI1PR08MB3167.eurprd08.prod.outlook.com (52.133.15.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Mon, 24 Jun 2019 16:55:29 +0000
Received: from VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed]) by VI1PR08MB3677.eurprd08.prod.outlook.com
 ([fe80::4c71:9c23:235b:fbed%3]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 16:55:29 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Denis Lunev <den@virtuozzo.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Thread-Topic: [PATCH v2 2/7] iotests: exclude killed processes from running
 under Valgrind
Thread-Index: AQHVIH/WOQAwtzC6oUygLLRaivlcpKafutMAgAAR2gCAAAnEgIAAB4KAgAAZUQCACyL6AA==
Date: Mon, 24 Jun 2019 16:55:29 +0000
Message-ID: <09368170-1ab5-6e8f-fc21-3a06383d52de@virtuozzo.com>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <20190617111504.GC7397@linux.fritz.box>
 <20190617121855.GB32624@rkaganb.sw.ru>
 <20190617125355.GH7397@linux.fritz.box>
 <20190617132043.GE32624@rkaganb.sw.ru>
 <20190617145124.GJ7397@linux.fritz.box>
In-Reply-To: <20190617145124.GJ7397@linux.fritz.box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::15)
 To VI1PR08MB3677.eurprd08.prod.outlook.com
 (2603:10a6:803:85::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66918ae7-bd4b-4cc5-cefb-08d6f8c4c32e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3167; 
x-ms-traffictypediagnostic: VI1PR08MB3167:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR08MB3167DBECAC2EA99565EF4EC6F4E00@VI1PR08MB3167.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(376002)(346002)(136003)(366004)(199004)(189003)(6436002)(11346002)(66946007)(53936002)(186003)(8936002)(53546011)(316002)(102836004)(7736002)(256004)(305945005)(68736007)(15974865002)(6506007)(110136005)(31686004)(6246003)(6116002)(3846002)(478600001)(76176011)(99286004)(52116002)(66066001)(2906002)(476003)(25786009)(14454004)(966005)(64756008)(229853002)(66446008)(386003)(73956011)(86362001)(486006)(66556008)(2616005)(66476007)(446003)(44832011)(14444005)(6486002)(26005)(71200400001)(81166006)(36756003)(2201001)(6306002)(31696002)(5660300002)(81156014)(6512007)(8676002)(2501003)(6636002)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3167;
 H:VI1PR08MB3677.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8bMCxzIajgc+/Oz1jJpEmtY1XB9aWu2HACCZ5yQwG3/spbk0GE8rtWX4xKGkoneS5HNp7a+6oQn50hy2trnQwrj5gBYARdJswg0rcCwjcGwXhxTt4plhmMpp6YXf2xDwTtyK6Am394uWKklITYeLqLI2GmhE5BglnoEz4vlsEUwEgGEDDgPgFLT+FRnZVjAxgNK6iJNtaG7f/G/deRyR7/MtoPTZJP9/06gdWnF+Rzo4P0rzhTz37EhIs0M80q+ttSruJP67qCNK/RRoK2kbI5CLrWcO5Q+Pt1++82ngy3OeU7kYKv8wFdXPg5BHGYpHWykuU8mg4GUdG9mEkogIZFgLNQX7/CMUeRQnNfo5FBSd6n2/vSLxHvvmrWOYKjnI1FJJugoOLTBCLzbrZIwhyF8c13zkzaxbW1m1GKECXnk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06813B4441888E449211F42E39B0B6D4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66918ae7-bd4b-4cc5-cefb-08d6f8c4c32e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 16:55:29.5894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3167
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.94
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDE3LzA2LzIwMTkgMTc6NTEsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFtIDE3LjA2LjIw
MTkgdW0gMTU6MjAgaGF0IFJvbWFuIEthZ2FuIGdlc2NocmllYmVuOg0KPj4gT24gTW9uLCBKdW4g
MTcsIDIwMTkgYXQgMDI6NTM6NTVQTSArMDIwMCwgS2V2aW4gV29sZiB3cm90ZToNCj4+PiBBbSAx
Ny4wNi4yMDE5IHVtIDE0OjE4IGhhdCBSb21hbiBLYWdhbiBnZXNjaHJpZWJlbjoNCj4+Pj4gT24g
TW9uLCBKdW4gMTcsIDIwMTkgYXQgMDE6MTU6MDRQTSArMDIwMCwgS2V2aW4gV29sZiB3cm90ZToN
Cj4+Pj4+IEFtIDExLjA2LjIwMTkgdW0gMjA6MDIgaGF0IEFuZHJleSBTaGlua2V2aWNoIGdlc2No
cmllYmVuOg0KPj4+Pj4+IFRoZSBWYWxncmluZCB0b29sIGZhaWxzIHRvIG1hbmFnZSBpdHMgdGVy
bWluYXRpb24gd2hlbiBRRU1VIHJhaXNlcyB0aGUNCj4+Pj4+PiBzaWduYWwgU0lHS0lMTC4gTGV0
cyBleGNsdWRlIHN1Y2ggdGVzdCBjYXNlcyBmcm9tIHJ1bm5pbmcgdW5kZXIgdGhlDQo+Pj4+Pj4g
VmFsZ3JpbmQgYmVjYXVzZSB0aGVyZSBpcyBubyBzZW5zZSB0byBjaGVjayBtZW1vcnkgaXNzdWVz
IHRoYXQgd2F5Lg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZp
Y2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+Pj4+Pg0KPj4+Pj4gSSBkb24n
dCBmdWxseSB1bmRlcnN0YW5kIHRoZSByZWFzb25pbmcgaGVyZS4gTW9zdCBpbnRlcmVzdGluZyBt
ZW1vcnkNCj4+Pj4+IGFjY2VzcyBlcnJvcnMgaGFwcGVuIGJlZm9yZSBhIHByb2Nlc3MgdGVybWlu
YXRlcy4gKEknbSBub3QgdGFsa2luZyBhYm91dA0KPj4+Pj4gbGVha3MgaGVyZSwgYnV0IHVzZS1h
ZnRlci1mcmVlLCBidWZmZXIgb3ZlcmZsb3dzLCB1bmluaXRpYWxpc2VkIG1lbW9yeQ0KPj4+Pj4g
ZXRjLikNCj4+Pj4NCj4+Pj4gTm90aGluZyBvZiB0aGUgYWJvdmUsIGFuZCBub3RoaW5nIGluIGdl
bmVyYWwsIGhhcHBlbnMgaW4gdGhlIHVzZXJtb2RlDQo+Pj4+IHByb2Nlc3MgdXBvbiBTSUdLSUxM
IGRlbGl2ZXJ5Lg0KPj4+DQo+Pj4gTXkgcG9pbnQgaXMsIHRoZSBpbnRlcmVzdGluZyBwYXJ0IGlz
IHdoYXQgdGhlIHByb2dyYW0gZG9lcyBiZWZvcmUNCj4+PiBTSUdLSUxMIGhhcHBlbnMuIFRoZXJl
IGlzIHZhbHVlIGluIHJlcG9ydGluZyBtZW1vcnkgZXJyb3JzIGFzIGxvbmcgYXMgd2UNCj4+PiBj
YW4sIGV2ZW4gaWYgdGhlIGZpbmFsIGNoZWNrIGRvZXNuJ3QgaGFwcGVuIGJlY2F1c2Ugb2YgU0lH
S0lMTC4NCj4+DQo+PiBBZ3JlZWQgaW4gZ2VuZXJhbCwgYnV0IGhlcmUgdGhlIHRlc3RjYXNlcyB0
aGF0IGluY2x1ZGUgJ3NpZ3JhaXNlIDknIG9ubHkNCj4+IGRvIHNpbXBsZSBvcGVyYXRpb25zIGJl
Zm9yZSB0aGF0IHdoaWNoIGFyZSBjb3ZlcmVkIGVsc2V3aGVyZSB0b28uICBTbw0KPj4gdGhlIGV4
dHJhIGVmZm9ydCBvbiBtYWtpbmcgdmFsZ3JpbmQgd29yayB3aXRoIHRoZXNlIHRlc3RjYXNlcyBh
cmd1YWJseQ0KPj4gaXNuJ3Qgd29ydGggdGhlIGV4dHJhIHZhbHVlIHRvIGJlIGdhaW5lZC4NCj4g
DQo+IE9rLCBmYWlyIGVub3VnaC4NCj4gDQo+Pj4+PiBIb3dldmVyLCBJIGRvIHNlZSB0aGF0IHJ1
bm5pbmcgdGhlc2UgdGVzdCBjYXNlcyB3aXRoIC12YWxncmluZCBlbmRzIGluIGENCj4+Pj4+IGhh
bmcgYmVjYXVzZSB0aGUgdmFsZ3JpbmQgcHJvY2VzcyBrZWVwcyBoYW5naW5nIGFyb3VuZCBhcyBh
IHpvbWJpZQ0KPj4+Pj4gcHJvY2VzcyBhbmQgdGhlIHRlc3QgY2FzZSBkb2Vzbid0IHJlYXAgaXQu
IEknbSBub3QgZXhhY3RseSBzdXJlIHdoeSB0aGF0DQo+Pj4+PiBpcywgYnV0IGl0IGxvb2tzIG1v
cmUgbGlrZSBhIHByb2JsZW0gd2l0aCB0aGUgcGFyZW50IHByb2Nlc3MgKGkuZS4gdGhlDQo+Pj4+
PiBiYXNoIHNjcmlwdCkuDQo+Pj4+DQo+Pj4+IEl0IHJhdGhlciBsb29rcyBsaWtlIHZhbGdyaW5k
IGdldHRpbmcgY29uZnVzZWQgYWJvdXQgd2hhdCB0byBkbyB3aXRoDQo+Pj4+IHJhaXNlKFNJR0tJ
TEwpIGluIHRoZSBtdWx0aXRocmVhZGVkIGNhc2UuDQo+Pj4NCj4+PiBXZWxsLCB2YWxncmluZCBj
YW4ndCBkbyBhbnl0aGluZyB3aXRoIFNJR0tJTEwsIG9idmlvdXNseSwgYmVjYXVzZSBpdCdzDQo+
Pj4ga2lsbGVkIGltbWVkaWF0ZWx5Lg0KPj4NCj4+IFJpZ2h0LCBidXQgaXQgY2FuIGRvIHdoYXRl
dmVyIGl0IHdhbnRzIHdpdGggcmFpc2UoU0lHS0lMTCkuICBJIGhhdmVuJ3QNCj4+IGxvb2tlZCBh
dCB2YWxncmluZCBzb3VyY2VzLCBidXQNCj4+DQo+PiAgICAjIHN0cmFjZSAtZmYgdmFsZ2luZCBx
ZW11LWlvIC1jICdzaWdyYWlzZSA5Jw0KPj4NCj4+IHNob3dzIFNJR0tJTEwgbmVpdGhlciBzZW50
IG5vciByZWNlaXZlZCBieSBhbnkgdGhyZWFkOyBpdCBqdXN0IHNob3dzIHRoZQ0KPj4gbWFpbiB0
aHJlYWQgZXhpdCBhbmQgdGhlIHNlY29uZCB0aHJlYWQgZ2V0dGluZyBzdHVjayB3YWl0aW5nIG9u
IGEgZnV0ZXguDQo+IA0KPiBPaCwgSSBkaWRuJ3Qgc2VlIHRoaXMhIFNvIHRoZXJlIGlzbid0IGV2
ZW4gYSByZWFsIFNJR0tJTEwgc2lnbmFsLg0KPiANCj4+PiBCdXQgbWF5YmUgdGhlIGtlcm5lbCBk
b2VzIGdldCBjb25mdXNlZCBmb3Igc29tZQ0KPj4+IHJlYXNvbi4gSSBnZXQgdGhlIG1haW4gdGhy
ZWFkcyBhcyBhIHpvbWJpZSwgYnV0IGEgc2Vjb25kIGlzIHN0aWxsDQo+Pj4gcnVubmluZy4gU2Vu
ZGluZyBTSUdLSUxMIHRvIHRoZSBzZWNvbmQgdGhyZWFkLCB0b28sIG1ha2VzIHRoZSB0ZXN0IGNh
c2UNCj4+PiBjb21wbGV0ZSBzdWNjZXNzZnVsbHkuDQo+Pj4NCj4+PiBTbyBJIGd1ZXNzIHRoZSBt
YWluIHF1ZXN0aW9uIGlzIHdoeSB0aGUgc2Vjb25kIHRocmVhZCBpc24ndA0KPj4+IGF1dG9tYXRp
Y2FsbHkga2lsbGVkIHdoZW4gdGhlIG1haW4gdGhyZWFkIHJlY2VpdmVzIFNJR0tJTEwuDQo+Pg0K
Pj4gSSBkb24ndCBzZWUgYW55IHRocmVhZCByZWNlaXZlIFNJR0tJTEwuICBTbyBJIHRlbmQgdG8g
dGhpbmsgdGhpcyBpcw0KPj4gdmFsZ3JpbmQncyBidWcvZmVhdHVyZS4NCj4+DQo+PiBBbnl3YXkg
dGhlIHByb2JsZW0gaXMgb3V0c2lkZSBvZiBRRU1VLCBzbyBJIHRoaW5rIHdlIG5lZWQgdG8gd2Vp
Z2ggdGhlDQo+PiBjb3N0cyBvZiBpbnZlc3RpZ2F0aW5nIGl0IGFuZCBpbXBsZW1lbnRpbmcgYSB3
b3JrYXJvdW5kIHdpdGggdGhlDQo+PiBwb3RlbnRpYWwgYmVuZWZpdC4NCj4gDQo+IEknZCBzdWdn
ZXN0IHRvIGZpbGUgYSBidWcgYWdhaW5zdCB2YWxncmluZCBhdCBsZWFzdC4gQW5kIGluZGVlZCBq
dXN0DQo+IGRpc2FibGUgdmFsZ3JpbmQgaGVyZSBsaWtlIHRoaXMgcGF0Y2ggZG9lcy4NCj4gDQo+
IEtldmluDQo+IA0KDQpJIGhhdmUgcmVwb3J0ZWQgdGhlIGlzc3VlIHRvIHRoZSBLREUgQnVndHJh
Y2tpbmcgU3lzdGVtIG9uIGJ1Z3Mua2RlLm9yZw0KYXMgaW5zdHJ1Y3RlZCBvbiB0aGUgd3d3LnZh
bGdyaW5kLm9yZy9zdXBwb3J0L2J1Z19yZXBvcnRzLmh0bWwNCg0KVGhlIGJ1ZyA0MDkxNDEgIlZh
bGdyaW5kIGhhbmdzIHdoZW4gU0lHS0lMTGVkIiBoYXMgYmVlbiBjcmVhdGVkLg0KVGhlIHRocmVh
ZCBjYW4gYmUgc2VlbiBvbiBodHRwczovL2J1Z3Mua2RlLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9NDA5
MTQxDQoNCkFuZHJleQ0K

