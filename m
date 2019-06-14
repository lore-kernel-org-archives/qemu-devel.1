Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779C6C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F0E2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bPRWBYPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F0E2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnvz-0004EI-5V
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34392)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbnFE-00059e-9o
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbnFA-0002Vz-Dh
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:31:54 -0400
Received: from mail-eopbgr70091.outbound.protection.outlook.com
 ([40.107.7.91]:28167 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbnF7-0002OQ-Ko; Fri, 14 Jun 2019 10:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoILFJkKUD1M7yUR2dsG0qmCHwqRyy6X7D+ZOfDaouE=;
 b=bPRWBYPKrT60ezxIsc1uYn+7Blymj1S5diI+2cL2Q23CIL3NAuU1aXkx4+l0gkvl1msB9BkOjEmiCVxqs/33pTPbW+Iwih4PcH3ig1LdEjtacNRuHy0oKFyBnZlhWjJyB0JSDWZSG8pUoQGg13ZG3qTa3uDym9JQpKumO8NPfCo=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3716.eurprd08.prod.outlook.com (20.178.23.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Fri, 14 Jun 2019 14:31:38 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 14:31:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 14/42] block: Use CAFs when working with backing chains
Thread-Index: AQHVIWuuPVMblAMNYkC6XowcCoyrZaabJqGAgAAGwYCAAAuEAA==
Date: Fri, 14 Jun 2019 14:31:38 +0000
Message-ID: <bfa2b6e6-7b5a-78c5-abb5-51c000fc81be@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-15-mreitz@redhat.com>
 <837ee511-af51-3062-8a2e-41adde1023b3@virtuozzo.com>
 <616b970a-2c06-11d8-8f91-c607fd986e18@redhat.com>
In-Reply-To: <616b970a-2c06-11d8-8f91-c607fd986e18@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0004.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::14) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614173136487
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87f7a95c-5cdc-48f7-2046-08d6f0d5025b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3716; 
x-ms-traffictypediagnostic: AM0PR08MB3716:
x-microsoft-antispam-prvs: <AM0PR08MB3716900CDC0FCB979FD2D47DC1EE0@AM0PR08MB3716.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(39850400004)(136003)(396003)(366004)(346002)(199004)(189003)(3846002)(6486002)(6436002)(66476007)(66556008)(66446008)(64756008)(66066001)(476003)(486006)(446003)(6512007)(2501003)(2616005)(11346002)(66946007)(31686004)(52116002)(8936002)(81166006)(81156014)(6506007)(386003)(76176011)(53546011)(6116002)(7736002)(8676002)(99286004)(6246003)(305945005)(73956011)(229853002)(36756003)(26005)(102836004)(5660300002)(4326008)(71190400001)(71200400001)(186003)(68736007)(14444005)(478600001)(110136005)(54906003)(86362001)(25786009)(31696002)(256004)(2906002)(316002)(53936002)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3716;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W/lyoxXFlAJO/4Fjz7Dc8gb8Ev0SQXsddPp64Y5TZgDy7vb3IX9X7Uz0yCaeA6J55XmxBRuosWuJMpS4fSNuyVmZUw2VVKmkABqy2AEh0AB58Bt1Q1jgwG0xeLRf05v51DIrvk+IChwF3MLRMpG2f0mJl6HgdGKOpdu3OObBvGVcy8WGWYHo21wGi73HOQ8teelEpJmvRY0xmY3mB9FAJlMQBjrF3d3Zd5nsIE8kwm5Sa0fZXftfIQYcsTq+bQuxC18E1X8tDdqUdcEdDC87899cfVoIEJak7zwp5xNy35+WTK4ljuvSZQV2YL78EpPl3Fy8v+tdtIjaqJ9TwcakID3rloZbSJ0dAL5qIkCsnZJzWv5Fo/HRfh8Sf/DyIYuhoYoXJl6RZ3YcxOwUtvAOuIVDYa83qVBfyjWs6/MD5zY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <365BA898B7E1DE49A60591E916C3DB76@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f7a95c-5cdc-48f7-2046-08d6f0d5025b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 14:31:38.2597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3716
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.91
Subject: Re: [Qemu-devel] [PATCH v5 14/42] block: Use CAFs when working with
 backing chains
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

MTQuMDYuMjAxOSAxNjo1MCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNC4wNi4xOSAxNToyNiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA2LjIwMTkgMTowOSwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4+IFVzZSBjaGlsZCBhY2Nlc3MgZnVuY3Rpb25zIHdoZW4gaXRl
cmF0aW5nIHRocm91Z2ggYmFja2luZyBjaGFpbnMgc28NCj4+PiBmaWx0ZXJzIGRvIG5vdCBicmVh
ayB0aGUgY2hhaW4uDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekBy
ZWRoYXQuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGJsb2NrLmMgfCA0MCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2Vy
dGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2Jsb2NrLmMg
Yi9ibG9jay5jDQo+Pj4gaW5kZXggMTFmMzc5ODNkOS4uNTA1YjNlOWEwMSAxMDA2NDQNCj4+PiAt
LS0gYS9ibG9jay5jDQo+Pj4gKysrIGIvYmxvY2suYw0KPiANCj4gWy4uLl0NCj4gDQo+Pj4gQEAg
LTQyNzMsMTEgKzQyNzQsMTggQEAgaW50IGJkcnZfY2hhbmdlX2JhY2tpbmdfZmlsZShCbG9ja0Ry
aXZlclN0YXRlICpicywNCj4+PiAgICBCbG9ja0RyaXZlclN0YXRlICpiZHJ2X2ZpbmRfb3Zlcmxh
eShCbG9ja0RyaXZlclN0YXRlICphY3RpdmUsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+Pj4gICAgew0KPj4+IC0gICAg
d2hpbGUgKGFjdGl2ZSAmJiBicyAhPSBiYWNraW5nX2JzKGFjdGl2ZSkpIHsNCj4+PiAtICAgICAg
ICBhY3RpdmUgPSBiYWNraW5nX2JzKGFjdGl2ZSk7DQo+Pj4gKyAgICBicyA9IGJkcnZfc2tpcF9y
d19maWx0ZXJzKGJzKTsNCj4+PiArICAgIGFjdGl2ZSA9IGJkcnZfc2tpcF9yd19maWx0ZXJzKGFj
dGl2ZSk7DQo+Pj4gKw0KPj4+ICsgICAgd2hpbGUgKGFjdGl2ZSkgew0KPj4+ICsgICAgICAgIEJs
b2NrRHJpdmVyU3RhdGUgKm5leHQgPSBiZHJ2X2JhY2tpbmdfY2hhaW5fbmV4dChhY3RpdmUpOw0K
Pj4+ICsgICAgICAgIGlmIChicyA9PSBuZXh0KSB7DQo+Pj4gKyAgICAgICAgICAgIHJldHVybiBh
Y3RpdmU7DQo+Pj4gKyAgICAgICAgfQ0KPj4+ICsgICAgICAgIGFjdGl2ZSA9IG5leHQ7DQo+Pj4g
ICAgICAgIH0NCj4+PiAgICANCj4+PiAtICAgIHJldHVybiBhY3RpdmU7DQo+Pj4gKyAgICByZXR1
cm4gTlVMTDsNCj4+PiAgICB9DQo+Pg0KPj4gU2VtYW50aWNzIGNoYW5nZWQgZm9yIHRoaXMgZnVu
Y3Rpb24uDQo+PiBJdCBpcyB1c2VkIGluIHR3byBwbGFjZXMNCj4+IDEuIGZyb20gYmRydl9maW5k
X2Jhc2Ugd3RpaCBAYnM9TlVMTCwgaXQgc2hvdWxkIGJlIHVuY2hhbmdlZCwgYXMgSSBob3BlIHdl
IHdpbGwgbmV2ZXIgaGF2ZQ0KPj4gICAgICBmaWx0ZXIgbm9kZSBhcyBhIGJvdHRvbSBvZiBzb21l
IHZhbGlkIGNoYWluDQo+Pg0KPj4gMi4gZnJvbSBxbXBfYmxvY2tfY29tbWl0LCBvbmx5IHRvIGNo
ZWNrIG9wLWJsb2NrZXIuLi4gaG1tbS4gSSByZWFsbHkgZG9uJ3QgdW5kZXJzdGFuZCwNCj4+IHdo
eSBkbyB3ZSBjaGVjayBCTE9DS19PUF9UWVBFX0NPTU1JVF9UQVJHRVQgb24gdG9wX2JzIG92ZXJs
YXkuLiB0b3BfYnMgb3ZlcmxheSBpcyBvdXQgb2YgdGhlIGpvYiwNCj4+IHdoYXQgaXMgdGhpcyBj
aGVjayBmb3I/DQo+IA0KPiBUaGVyZSBpcyBhIGxvb3AgYmVmb3JlIHRoaXMgY2hlY2sgd2hpY2gg
Y2hlY2tzIHRoYXQgdGhlIHNhbWUgYmxvY2tlciBpcw0KPiBub3Qgc2V0IG9uIGFueSBub2RlcyBi
ZXR3ZWVuIHRvcCBhbmQgYmFzZSAoYm90aCBpbmNsdXNpdmUpLiAgSSBndWVzcw0KPiBub24tYWN0
aXZlIGNvbW1pdCBjaGVja3MgdGhlIG5vZGUgYWJvdmUgQHRvcCwgdG9vLCBiZWNhdXNlIGl0cyBi
YWNraW5nDQo+IGZpbGUgd2lsbCBjaGFuZ2UuDQoNClNvIGluIHRoaXMgY2FzZSBmcm96ZW4gY2hh
aW4gd29ya3MgYmV0dGVyLg0KDQo+IA0KPj4+ICAgIC8qIEdpdmVuIGEgQkRTLCBzZWFyY2hlcyBm
b3IgdGhlIGJhc2UgbGF5ZXIuICovDQo+IA0KPiBbLi4uXQ0KPiANCj4+PiBAQCAtNTE0OSw3ICs1
MTY1LDcgQEAgQmxvY2tEcml2ZXJTdGF0ZSAqYmRydl9maW5kX2JhY2tpbmdfaW1hZ2UoQmxvY2tE
cml2ZXJTdGF0ZSAqYnMsDQo+Pj4gICAgICAgICAgICAgICAgY2hhciAqYmFja2luZ19maWxlX2Z1
bGxfcmV0Ow0KPj4+ICAgIA0KPj4+ICAgICAgICAgICAgICAgIGlmIChzdHJjbXAoYmFja2luZ19m
aWxlLCBjdXJyX2JzLT5iYWNraW5nX2ZpbGUpID09IDApIHsNCj4+DQo+PiBobW0sIGludGVyZXN0
aW5nLCB3aGF0IGJzLT5iYWNraW5nX2ZpbGUgbm93IG1lYW5zPyBJdCdzIHN0cmFuZ2UgZW5vdWdo
IHRvIHN0b3JlIHN1Y2ggZmllbGQgb24NCj4+IGJkcywgd2hlbiB3ZSBoYXZlIGJhY2tpbmcgbGlu
ayBhbnl3YXkuLg0KPiANCj4gUGF0Y2ggMzcgaGFzIHlvdSBjb3ZlcmVkLiA6LSkNCj4gDQoNCkht
bSwgaWYgaXQgaGFzIHJlbW92ZWQgdGhpcyBmaWVsZCwgYnV0IGl0IGRvZXNuJ3QpDQoNClNvLCB3
ZSBmaW5pc2hlZCB3aXRoIHNvbWUgb2JqZWN0LCBjYWxsZWQgIm92ZXJsYXkiLCBidXQgaXQgaXMg
bm90IGFuIG92ZXJsYXkgb2YgYnMsIGl0J3Mgb3ZlcmxheSBvZg0KZmlyc3Qgbm9uLWltcGxpY2l0
IGZpbHRlcmVkIG5vZGUgaW4gYnMgYmFja2luZyBjaGFpbiwgaXQgbWF5IGJlIGZvdW5kIGJ5IGJk
cnZfZmluZF9vdmVybGF5KCkgaGVscGVyICh3aGljaCBpcw0KYWxtb3N0IHVudXNlZCBhbmQgbXkg
YmUgc2FmZWx5IGRyb3BwZWQpLCBhbmQgZmlsZW5hbWUgb2YgdGhpcyAib3ZlcmxheSIgaXMgc3Rv
cmVkIGluIGJzLT5iYWNraW5nX2ZpbGUgc3RyaW5nDQp2YXJpYWJsZSwga2VlcGluZyBpbiBtaW5k
IHRoYXQgYnMtPmJhY2tpbmcgaXMgcG9pbnRlciB0byBiYWNraW5nIGNoaWxkIG9mIGJzIHdoaWNo
IGlzIGNvbXBsZXRlbHkgYW5vdGhlciB0aGluZz8NCg0KT2gsIG5vLCBldmVyeXRoaW5nIHJlbGF0
ZWQgdG8gZmlsZW5hbWUtYmFzZWQgYmFja2luZyBjaGFpbiBsb2dpYyBpcyBub3QgZm9yIG1lIG9f
Ty4gSWYgc29tZXRoaW5nIGRvZXNuJ3Qgd29yaw0Kd2l0aCBmaWxlbmFtZS1iYXNlZCBsb2dpYyB1
c2VycyBzaG91bGQgdXNlIG5vZGUtbmFtZXMuLiBBbmQgSSdkIHByZWZlciB0byBkZXByZWNhdGUg
ZmlsZW5hbWUgYmFzZWQgaW50ZXJmYWNlcw0KYXQgYWxsLg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=

