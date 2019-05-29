Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9621CC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E11204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JzQxdMPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E11204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49129 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVt9F-0005hF-Ci
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:37:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVt78-0004Ki-6w
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hVt76-00033m-Gz
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:35:10 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com
	([40.107.0.105]:35237
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hVt71-0002z5-5e; Wed, 29 May 2019 03:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=bn/3nidQ0S5Mm8LhPY+KvJYiExIPa26epZtO9oUzALs=;
	b=JzQxdMPR3HCnb9Q1Mt4EyUJKSAkXrMgs1rer65PgDDbPB6AfSwVzexUeROCPGFo+ey+1AAxQP/K19zctwmO8+QumQJLraW8AxBITH/lAN5hAPX7sYYQodU35dK6TV9wV0esKW1SrVeY6neYW6P+41VQ5R+7GfPmAGFoyHypVTPI=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB5252.eurprd08.prod.outlook.com (20.179.39.153) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.16; Wed, 29 May 2019 07:34:59 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6]) by AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::9499:ef6a:95e:a3c6%4]) with mapi id 15.20.1922.021;
	Wed, 29 May 2019 07:34:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v6 3/3] block/stream: introduce a bottom node
Thread-Index: AQHVBCE9xsQwL5Xm6Ui8YJ6AfY9Z7qaA7sSAgADq/wA=
Date: Wed, 29 May 2019 07:34:59 +0000
Message-ID: <5a18f815-ed81-fd58-5f48-9ffe944f0ea4@virtuozzo.com>
References: <20190506153429.52737-1-vsementsov@virtuozzo.com>
	<20190506153429.52737-4-vsementsov@virtuozzo.com>
	<ee950bac-f0d8-3bc9-f5ed-deaf4d36777b@redhat.com>
In-Reply-To: <ee950bac-f0d8-3bc9-f5ed-deaf4d36777b@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0001.eurprd01.prod.exchangelabs.com
	(2603:10a6:7:14::14) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190529103456590
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c8e28ab-253d-4608-f32b-08d6e4082749
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:AM0PR08MB5252; 
x-ms-traffictypediagnostic: AM0PR08MB5252:
x-microsoft-antispam-prvs: <AM0PR08MB52529B2F712A156716C6E851C11F0@AM0PR08MB5252.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(39850400004)(396003)(346002)(366004)(136003)(199004)(189003)(25786009)(31686004)(99286004)(2501003)(6512007)(386003)(486006)(66476007)(186003)(86362001)(2906002)(110136005)(71190400001)(71200400001)(26005)(53936002)(54906003)(446003)(66556008)(2616005)(11346002)(66946007)(6246003)(53546011)(73956011)(4326008)(76176011)(66446008)(64756008)(52116002)(6506007)(476003)(5660300002)(7736002)(2201001)(305945005)(316002)(31696002)(256004)(66066001)(8936002)(229853002)(68736007)(6486002)(3846002)(7416002)(102836004)(6436002)(36756003)(478600001)(14454004)(8676002)(81156014)(81166006)(6116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5252;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t7Cez0vi39o3Ua8mtAKwH8Tj7qhTi9fpF3SlwNvSg4KYZtzSB9a9TVtzbhgFCMIEBxxE23B+a+1THEr836EQT1u9I0oE0BiOUvV/mN7cvi4sq1SpisFHNLFUAXU7dZ7VWA4468mGCICqAz9/+sgmUVva+/iDcCjDnbfZ3Gs8oj6bAKKWQraM3/7sXiujWe4yenNPwXbqiKYdNbVTxHCHOwNv0vmsC9v4McMz45q1f+d+EHIPdrOrCEj3KNAQe6CR7Zmn1+myZQw5dRzIF6d+2/Z23bRvGik5YKpX5BeM/gU3O4GX1XsTvhBdqt9ZqOc8UaN3RDw9whmkMbabycDAAx7qz/Eqjm4dRRO6bk3xa9ZvQYjRSF4HYO6PNgijBvxOnUBIV6kc3RYoQIV7GMDeqYWN57X1l0hX/qUGthqwFZ4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <462818B46960C24C8F44BC5DD3BB563A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8e28ab-253d-4608-f32b-08d6e4082749
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 07:34:59.4050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5252
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.105
Subject: Re: [Qemu-devel] [PATCH v6 3/3] block/stream: introduce a bottom
 node
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
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"wencongyang2@huawei.com" <wencongyang2@huawei.com>,
	"xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMDUuMjAxOSAyMDozMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwNi4wNS4xOSAxNzozNCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEZyb206IEFuZHJleSBTaGlu
a2V2aWNoIDxhbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4NCj4+IFRoZSBib3R0
b20gbm9kZSBpcyB0aGUgaW50ZXJtZWRpYXRlIGJsb2NrIGRldmljZSB0aGF0IGhhcyB0aGUgYmFz
ZSBhcyBpdHMNCj4+IGJhY2tpbmcgaW1hZ2UuIEl0IGlzIHVzZWQgaW5zdGVhZCBvZiB0aGUgYmFz
ZSBub2RlIHdoaWxlIGEgYmxvY2sgc3RyZWFtDQo+PiBqb2IgaXMgcnVubmluZyB0byBhdm9pZCBk
ZXBlbmRlbmN5IG9uIHRoZSBiYXNlIHRoYXQgbWF5IGNoYW5nZSBkdWUgdG8gdGhlDQo+PiBwYXJh
bGxlbCBqb2JzLiBUaGUgY2hhbmdlIG1heSB0YWtlIHBsYWNlIGR1ZSB0byBhIGZpbHRlciBub2Rl
IGFzIHdlbGwgdGhhdA0KPj4gaXMgaW5zZXJ0ZWQgYmV0d2VlbiB0aGUgYmFzZSBhbmQgdGhlIGlu
dGVybWVkaWF0ZSBib3R0b20gbm9kZS4gSXQgb2NjdXJzDQo+PiB3aGVuIHRoZSBiYXNlIG5vZGUg
aXMgdGhlIHRvcCBvbmUgZm9yIGFub3RoZXIgY29tbWl0IG9yIHN0cmVhbSBqb2IuDQo+PiBBZnRl
ciB0aGUgaW50cm9kdWN0aW9uIG9mIHRoZSBib3R0b20gbm9kZSwgZG9uJ3QgZnJlZXplIGl0cyBi
YWNraW5nIGNoaWxkLA0KPj4gdGhhdCdzIHRoZSBiYXNlLCBhbnltb3JlLg0KPj4NCj4+IFN1Z2dl
c3RlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96
em8uY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlu
a2V2aWNoQHZpcnR1b3p6by5jb20+DQo+PiBSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEFs
YmVydG8gR2FyY2lhIDxiZXJ0b0BpZ2FsaWEuY29tPg0KPj4gLS0tDQo+PiAgIGJsb2NrL3N0cmVh
bS5jICAgICAgICAgfCA0OSArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI0NSB8ICA0ICsrLS0NCj4+ICAgMiBmaWxlcyBj
aGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvYmxvY2svc3RyZWFtLmMgYi9ibG9jay9zdHJlYW0uYw0KPj4gaW5kZXggNjViMTNiMjdl
MC4uZmM5N2M4OWY4MSAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL3N0cmVhbS5jDQo+PiArKysgYi9i
bG9jay9zdHJlYW0uYw0KPiANCj4gWy4uLl0NCj4gDQo+PiBAQCAtMjQ4LDI2ICsyNTAsMjUgQEAg
dm9pZCBzdHJlYW1fc3RhcnQoY29uc3QgY2hhciAqam9iX2lkLCBCbG9ja0RyaXZlclN0YXRlICpi
cywNCj4+ICAgICAgICAqIGFscmVhZHkgaGF2ZSBvdXIgb3duIHBsYW5zLiBBbHNvIGRvbid0IGFs
bG93IHJlc2l6ZSBhcyB0aGUgaW1hZ2Ugc2l6ZSBpcw0KPj4gICAgICAgICogcXVlcmllZCBvbmx5
IGF0IHRoZSBqb2Igc3RhcnQgYW5kIHRoZW4gY2FjaGVkLiAqLw0KPj4gICAgICAgcyA9IGJsb2Nr
X2pvYl9jcmVhdGUoam9iX2lkLCAmc3RyZWFtX2pvYl9kcml2ZXIsIE5VTEwsIGJzLA0KPj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICBCTEtfUEVSTV9DT05TSVNURU5UX1JFQUQgfCBCTEtfUEVS
TV9XUklURV9VTkNIQU5HRUQgfA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICBCTEtfUEVS
TV9HUkFQSF9NT0QsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgIEJMS19QRVJNX0NPTlNJ
U1RFTlRfUkVBRCB8IEJMS19QRVJNX1dSSVRFX1VOQ0hBTkdFRCB8DQo+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgIEJMS19QRVJNX1dSSVRFLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICBiYXNpY19mbGFncyB8IEJMS19QRVJNX0dSQVBIX01PRCwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgYmFzaWNfZmxhZ3MgfCBCTEtfUEVSTV9XUklURSwNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHNwZWVkLCBjcmVhdGlvbl9mbGFncywgTlVMTCwgTlVMTCwgZXJycCk7DQo+
PiAgICAgICBpZiAoIXMpIHsNCj4+ICAgICAgICAgICBnb3RvIGZhaWw7DQo+PiAgICAgICB9DQo+
PiAgIA0KPj4gLSAgICAvKiBCbG9jayBhbGwgaW50ZXJtZWRpYXRlIG5vZGVzIGJldHdlZW4gYnMg
YW5kIGJhc2UsIGJlY2F1c2UgdGhleSB3aWxsDQo+PiAtICAgICAqIGRpc2FwcGVhciBmcm9tIHRo
ZSBjaGFpbiBhZnRlciB0aGlzIG9wZXJhdGlvbi4gVGhlIHN0cmVhbWluZyBqb2IgcmVhZHMNCj4+
IC0gICAgICogZXZlcnkgYmxvY2sgb25seSBvbmNlLCBhc3N1bWluZyB0aGF0IGl0IGRvZXNuJ3Qg
Y2hhbmdlLCBzbyBibG9jayB3cml0ZXMNCj4+IC0gICAgICogYW5kIHJlc2l6ZXMuICovDQo+PiAt
ICAgIGZvciAoaXRlciA9IGJhY2tpbmdfYnMoYnMpOyBpdGVyICYmIGl0ZXIgIT0gYmFzZTsgaXRl
ciA9IGJhY2tpbmdfYnMoaXRlcikpIHsNCj4+IC0gICAgICAgIGJsb2NrX2pvYl9hZGRfYmRydigm
cy0+Y29tbW9uLCAiaW50ZXJtZWRpYXRlIG5vZGUiLCBpdGVyLCAwLA0KPj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJMS19QRVJNX0NPTlNJU1RFTlRfUkVBRCB8IEJMS19QRVJNX1dSSVRF
X1VOQ0hBTkdFRCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQp
Ow0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBCbG9jayBhbGwgaW50ZXJtZWRpYXRlIG5vZGVzIGJl
dHdlZW4gYnMgYW5kIGJvdHRvbSAoaW5jbHVzaXZlKSwgYmVjYXVzZQ0KPj4gKyAgICAgKiB0aGV5
IHdpbGwgZGlzYXBwZWFyIGZyb20gdGhlIGNoYWluIGFmdGVyIHRoaXMgb3BlcmF0aW9uLiBUaGUg
c3RyZWFtaW5nDQo+PiArICAgICAqIGpvYiByZWFkcyBldmVyeSBibG9jayBvbmx5IG9uY2UsIGFz
c3VtaW5nIHRoYXQgaXQgZG9lc24ndCBjaGFuZ2UsIHNvDQo+PiArICAgICAqIGZvcmJpZCB3cml0
ZXMgYW5kIHJlc2l6ZXMuDQo+PiArICAgICAqLw0KPj4gKyAgICBmb3IgKGl0ZXIgPSBiczsgaXRl
ciAhPSBib3R0b207IGl0ZXIgPSBiYWNraW5nX2JzKGl0ZXIpKSB7DQo+PiArICAgICAgICBibG9j
a19qb2JfYWRkX2JkcnYoJnMtPmNvbW1vbiwgImludGVybWVkaWF0ZSBub2RlIiwgYmFja2luZ19i
cyhpdGVyKSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCBiYXNpY19mbGFncywg
JmVycm9yX2Fib3J0KTsNCj4gDQo+IEkgZG9u4oCZdCB1bmRlcnN0YW5kIHRoaXMgY2hhbmdlLiAg
SXNu4oCZdCBpdCBkb2luZyBleGFjdGx5IHRoZSBzYW1lIGFzIGJlZm9yZT8NCj4gDQo+IChJZiBz
bywgSSBqdXN0IGZpbmQgaXQgaGFyZGVyIHRvIHJlYWQgYmVjYXVzZSBldmVyeSBpdGVyYXRpb24g
aXNu4oCZdA0KPiBhYm91dCBAaXRlciBidXQgYmFja2luZ19icyhpdGVyKS4pDQoNCkhtLCBpdCdz
IHRoZSBzYW1lLCBidXQgbm90IHVzaW5nIGJhc2UuIFdlIG1heSBzYXZlIG9sZCBsb29wIGlmIGNh
bGN1bGF0ZSBiYXNlIGV4YWN0bHkgYmVmb3JlDQp0aGUgbG9vcCAob3IgYXQgbGVhc3Qgbm90IHNl
cGFyYXRlZCBmcm9tIGl0IGJ5IGFueSB5aWVsZC1wb2ludCkNCg0KPiANCj4gVGhlIHJlc3QgbG9v
a3MgZ29vZCB0byBtZS4NCj4gDQo+IE1heA0KPiANCj4+ICAgICAgIH0NCj4+ICAgDQo+PiAtICAg
IHMtPmJhc2UgPSBiYXNlOw0KPj4gKyAgICBzLT5ib3R0b20gPSBib3R0b207DQo+PiAgICAgICBz
LT5iYWNraW5nX2ZpbGVfc3RyID0gZ19zdHJkdXAoYmFja2luZ19maWxlX3N0cik7DQo+PiAgICAg
ICBzLT5ic19yZWFkX29ubHkgPSBic19yZWFkX29ubHk7DQo+PiAgICAgICBzLT5jaGFpbl9mcm96
ZW4gPSB0cnVlOw0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

