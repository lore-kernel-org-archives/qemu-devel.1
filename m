Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B2C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF8020851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eXuzpzOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF8020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40380 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQiP-0003G5-JJ
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45294)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbPP6-0001JS-2J
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbPOw-0003dJ-41
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:04:24 -0400
Received: from mail-ve1eur03on0714.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::714]:15589
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbPOs-0003WO-BU; Thu, 13 Jun 2019 09:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AfSKuE7v/PuywE4k09NqQ6TvKisJsiv6YTy71ht2AA=;
 b=eXuzpzOh8SuyWnansf2T2yoN5pOOV6x07O5ylI1viZVyPUKF5IDkqF6NVaQ+CSD0mqm78Pb7js2kWX0jPjdEb3LLUbrb9o6X8HFyrkulEs28F6MLSZkV/vEVXrwyZR+56/D1V/ujXriC+fKDbX9SkLx9zX5Mn6OujokUSeUvF/s=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB5169.eurprd08.prod.outlook.com (10.255.31.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 13:04:13 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 13:04:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 09/42] block: Include filters when freezing backing
 chain
Thread-Index: AQHVIWuoAEv+sqURUUKdt5YL9mFLCaaZjiWA
Date: Thu, 13 Jun 2019 13:04:12 +0000
Message-ID: <d6074caa-ee1e-4dde-1977-83ab327e2771@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-10-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-10-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::28) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613160410988
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 240b8f78-92ac-4917-1cce-08d6efffa19c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5169; 
x-ms-traffictypediagnostic: AM0PR08MB5169:
x-microsoft-antispam-prvs: <AM0PR08MB5169513BDD4EB16163DF0E59C1EF0@AM0PR08MB5169.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(14444005)(52116002)(256004)(6486002)(5660300002)(6512007)(81166006)(7736002)(31686004)(73956011)(76176011)(8936002)(66476007)(71200400001)(6436002)(64756008)(66066001)(66556008)(66446008)(25786009)(8676002)(26005)(81156014)(478600001)(66946007)(71190400001)(6116002)(3846002)(6506007)(102836004)(386003)(305945005)(99286004)(186003)(31696002)(2501003)(14454004)(6246003)(53936002)(4326008)(54906003)(2906002)(86362001)(446003)(476003)(68736007)(11346002)(110136005)(2616005)(36756003)(229853002)(316002)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5169;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NugK4nS6fmM+GPeo7P6fLfuQYzJnlGgM0TZr9fY1A/+hf5WD5cdoEsNrp/aZh6QauboTNkLfWHrWtPZSKDML2Cc/zoPSBwA7MJ0CY2YglMwHutHNLGoHMDOjt0RHFDzdw4SN+jd08NKrby8EQRkbZmX8uDtxhjT20E+sMx2Xh0xTY6M8aOGGZGKOCnwiXfbWouvJ69tVUKvDFIlL88TzV1y4/1m4WXwo+rL6LOhZkRC8BH6F3j/4ipv6KfWP+HSSKSnKqgY5GO2Gffow+lE9QfvFiZnSPK06daD5SwWVUnLGMYGvvRUJYlHOLnYFNyBPnxFGHmbKWNj1CdMtbd2FXd5onTgiAIe/JyIPUhaQkk+Y3ZqNKFfLI3l1r/pDdwTyWJWPZBypZUvzp7rFsrECjyfIaErGn4Wj5b/w6LjfS0g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23B6581CA2E68D418035F4081ACEFCA3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240b8f78-92ac-4917-1cce-08d6efffa19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 13:04:12.8884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5169
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::714
Subject: Re: [Qemu-devel] [PATCH v5 09/42] block: Include filters when
 freezing backing chain
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IEluIG9yZGVyIHRvIG1ha2UgZmls
dGVycyB3b3JrIGluIGJhY2tpbmcgY2hhaW5zLCB0aGUgYXNzb2NpYXRlZA0KPiBmdW5jdGlvbnMg
bXVzdCBiZSBhYmxlIHRvIGRlYWwgd2l0aCB0aGVtIGFuZCBmcmVlemUgYWxsIGZpbHRlciBsaW5r
cywgYmUNCj4gdGhleSBDT1cgb3IgUi9XIGZpbHRlciBsaW5rcy4NCj4gDQo+IFdoaWxlIGF0IGl0
LCBhZGQgc29tZSBjb21tZW50cyB0aGF0IG5vdGUgd2hpY2ggZnVuY3Rpb25zIHJlcXVpcmUgdGhl
aXINCj4gY2FsbGVyIHRvIGVuc3VyZSB0aGF0IGEgZ2l2ZW4gY2hpbGQgbGluayBpcyBub3QgZnJv
emVuLCBhbmQgaG93IHRoZQ0KPiBjYWxsZXJzIGRvIHNvLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgYmxvY2suYyB8IDQ1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9ibG9jay5jIGIvYmxvY2suYw0KPiBpbmRleCA4NDM4YjA2OTllLi40NTg4MmEzNDcwIDEw
MDY0NA0KPiAtLS0gYS9ibG9jay5jDQo+ICsrKyBiL2Jsb2NrLmMNCj4gQEAgLTIyMTQsMTIgKzIy
MTQsMTUgQEAgc3RhdGljIHZvaWQgYmRydl9yZXBsYWNlX2NoaWxkX25vcGVybShCZHJ2Q2hpbGQg
KmNoaWxkLA0KPiAgICAqIElmIEBuZXdfYnMgaXMgbm90IE5VTEwsIGJkcnZfY2hlY2tfcGVybSgp
IG11c3QgYmUgY2FsbGVkIGJlZm9yZWhhbmQsIGFzIHRoaXMNCj4gICAgKiBmdW5jdGlvbiB1c2Vz
IGJkcnZfc2V0X3Blcm0oKSB0byB1cGRhdGUgdGhlIHBlcm1pc3Npb25zIGFjY29yZGluZyB0byB0
aGUgbmV3DQo+ICAgICogcmVmZXJlbmNlIHRoYXQgQG5ld19icyBnZXRzLg0KPiArICoNCj4gKyAq
IENhbGxlcnMgbXVzdCBlbnN1cmUgdGhhdCBjaGlsZC0+ZnJvemVuIGlzIGZhbHNlLg0KPiAgICAq
Lw0KPiAgIHN0YXRpYyB2b2lkIGJkcnZfcmVwbGFjZV9jaGlsZChCZHJ2Q2hpbGQgKmNoaWxkLCBC
bG9ja0RyaXZlclN0YXRlICpuZXdfYnMpDQo+ICAgew0KPiAgICAgICBCbG9ja0RyaXZlclN0YXRl
ICpvbGRfYnMgPSBjaGlsZC0+YnM7DQo+ICAgICAgIHVpbnQ2NF90IHBlcm0sIHNoYXJlZF9wZXJt
Ow0KPiAgIA0KPiArICAgIC8qIEFzc2VydHMgdGhhdCBjaGlsZC0+ZnJvemVuID09IGZhbHNlICov
DQo+ICAgICAgIGJkcnZfcmVwbGFjZV9jaGlsZF9ub3Blcm0oY2hpbGQsIG5ld19icyk7DQo+ICAg
DQo+ICAgICAgIGlmIChvbGRfYnMpIHsNCj4gQEAgLTIzNjAsNiArMjM2Myw3IEBAIHN0YXRpYyB2
b2lkIGJkcnZfZGV0YWNoX2NoaWxkKEJkcnZDaGlsZCAqY2hpbGQpDQo+ICAgICAgIGdfZnJlZShj
aGlsZCk7DQo+ICAgfQ0KPiAgIA0KPiArLyogQ2FsbGVycyBtdXN0IGVuc3VyZSB0aGF0IGNoaWxk
LT5mcm96ZW4gaXMgZmFsc2UuICovDQoNCklzIHN1Y2ggYSBjb21tZW50IGJldHRlciB0aGFuIG9u
ZS1saW5lIGV4dHJhIGFzc2VydGlvbiBhdCBzdGFydCBvZiB0aGUgZnVuY3Rpb24gYm9keT8NCg0K
PiAgIHZvaWQgYmRydl9yb290X3VucmVmX2NoaWxkKEJkcnZDaGlsZCAqY2hpbGQpDQo+ICAgew0K
PiAgICAgICBCbG9ja0RyaXZlclN0YXRlICpjaGlsZF9iczsNCj4gQEAgLTIzNjksNiArMjM3Myw3
IEBAIHZvaWQgYmRydl9yb290X3VucmVmX2NoaWxkKEJkcnZDaGlsZCAqY2hpbGQpDQo+ICAgICAg
IGJkcnZfdW5yZWYoY2hpbGRfYnMpOw0KPiAgIH0NCj4gICANCj4gKy8qIENhbGxlcnMgbXVzdCBl
bnN1cmUgdGhhdCBjaGlsZC0+ZnJvemVuIGlzIGZhbHNlLiAqLw0KPiAgIHZvaWQgYmRydl91bnJl
Zl9jaGlsZChCbG9ja0RyaXZlclN0YXRlICpwYXJlbnQsIEJkcnZDaGlsZCAqY2hpbGQpDQo+ICAg
ew0KPiAgICAgICBpZiAoY2hpbGQgPT0gTlVMTCkgew0KPiBAQCAtMjQzNSw2ICsyNDQwLDcgQEAg
dm9pZCBiZHJ2X3NldF9iYWNraW5nX2hkKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBCbG9ja0RyaXZl
clN0YXRlICpiYWNraW5nX2hkLA0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIGlmIChicy0+YmFj
a2luZykgew0KPiArICAgICAgICAvKiBDYW5ub3QgYmUgZnJvemVuLCB3ZSBjaGVja2VkIHRoYXQg
YWJvdmUgKi8NCj4gICAgICAgICAgIGJkcnZfdW5yZWZfY2hpbGQoYnMsIGJzLT5iYWNraW5nKTsN
Cj4gICAgICAgfQ0KPiAgIA0KPiBAQCAtMzkwOCw2ICszOTE0LDcgQEAgc3RhdGljIHZvaWQgYmRy
dl9jbG9zZShCbG9ja0RyaXZlclN0YXRlICpicykNCj4gICANCj4gICAgICAgaWYgKGJzLT5kcnYp
IHsNCj4gICAgICAgICAgIGlmIChicy0+ZHJ2LT5iZHJ2X2Nsb3NlKSB7DQo+ICsgICAgICAgICAg
ICAvKiBNdXN0IHVuZnJlZXplIGFsbCBjaGlsZHJlbiwgc28gYmRydl91bnJlZl9jaGlsZCgpIHdv
cmtzICovDQo+ICAgICAgICAgICAgICAgYnMtPmRydi0+YmRydl9jbG9zZShicyk7DQo+ICAgICAg
ICAgICB9DQo+ICAgICAgICAgICBicy0+ZHJ2ID0gTlVMTDsNCj4gQEAgLTQyODEsMTcgKzQyODgs
MjAgQEAgQmxvY2tEcml2ZXJTdGF0ZSAqYmRydl9maW5kX2Jhc2UoQmxvY2tEcml2ZXJTdGF0ZSAq
YnMpDQo+ICAgICogUmV0dXJuIHRydWUgaWYgYXQgbGVhc3Qgb25lIG9mIHRoZSBiYWNraW5nIGxp
bmtzIGJldHdlZW4gQGJzIGFuZA0KPiAgICAqIEBiYXNlIGlzIGZyb3plbi4gQGVycnAgaXMgc2V0
IGlmIHRoYXQncyB0aGUgY2FzZS4NCj4gICAgKiBAYmFzZSBtdXN0IGJlIHJlYWNoYWJsZSBmcm9t
IEBicywgb3IgTlVMTC4NCj4gKyAqIChGaWx0ZXJzIGFyZSB0cmVhdGVkIGFzIG5vcm1hbCBlbGVt
ZW50cyBvZiB0aGUgYmFja2luZyBjaGFpbi4pDQo+ICAgICovDQo+ICAgYm9vbCBiZHJ2X2lzX2Jh
Y2tpbmdfY2hhaW5fZnJvemVuKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBCbG9ja0RyaXZlclN0YXRl
ICpiYXNlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVy
cnApDQo+ICAgew0KPiAgICAgICBCbG9ja0RyaXZlclN0YXRlICppOw0KPiArICAgIEJkcnZDaGls
ZCAqY2hpbGQ7DQo+ICAgDQo+IC0gICAgZm9yIChpID0gYnM7IGkgIT0gYmFzZTsgaSA9IGJhY2tp
bmdfYnMoaSkpIHsNCj4gLSAgICAgICAgaWYgKGktPmJhY2tpbmcgJiYgaS0+YmFja2luZy0+ZnJv
emVuKSB7DQo+ICsgICAgZm9yIChpID0gYnM7IGkgIT0gYmFzZTsgaSA9IGNoaWxkX2JzKGNoaWxk
KSkgew0KPiArICAgICAgICBjaGlsZCA9IGJkcnZfZmlsdGVyZWRfY2hpbGQoaSk7DQo+ICsNCj4g
KyAgICAgICAgaWYgKGNoaWxkICYmIGNoaWxkLT5mcm96ZW4pIHsNCj4gICAgICAgICAgICAgICBl
cnJvcl9zZXRnKGVycnAsICJDYW5ub3QgY2hhbmdlICclcycgbGluayBmcm9tICclcycgdG8gJyVz
JyIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGktPmJhY2tpbmctPm5hbWUsIGktPm5vZGVf
bmFtZSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgYmFja2luZ19icyhpKS0+bm9kZV9uYW1l
KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY2hpbGQtPm5hbWUsIGktPm5vZGVfbmFtZSwg
Y2hpbGQtPmJzLT5ub2RlX25hbWUpOw0KPiAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiAg
ICAgICAgICAgfQ0KPiAgICAgICB9DQo+IEBAIC00MzA1LDE5ICs0MzE1LDIyIEBAIGJvb2wgYmRy
dl9pc19iYWNraW5nX2NoYWluX2Zyb3plbihCbG9ja0RyaXZlclN0YXRlICpicywgQmxvY2tEcml2
ZXJTdGF0ZSAqYmFzZSwNCj4gICAgKiBub25lIG9mIHRoZSBsaW5rcyBhcmUgbW9kaWZpZWQuDQo+
ICAgICogQGJhc2UgbXVzdCBiZSByZWFjaGFibGUgZnJvbSBAYnMsIG9yIE5VTEwuDQo+ICAgICog
UmV0dXJucyAwIG9uIHN1Y2Nlc3MuIE9uIGZhaWx1cmUgcmV0dXJucyA8IDAgYW5kIHNldHMgQGVy
cnAuDQo+ICsgKiAoRmlsdGVycyBhcmUgdHJlYXRlZCBhcyBub3JtYWwgZWxlbWVudHMgb2YgdGhl
IGJhY2tpbmcgY2hhaW4uKQ0KPiAgICAqLw0KPiAgIGludCBiZHJ2X2ZyZWV6ZV9iYWNraW5nX2No
YWluKEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBCbG9ja0RyaXZlclN0YXRlICpiYXNlLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4gICB7DQo+ICAgICAg
IEJsb2NrRHJpdmVyU3RhdGUgKmk7DQo+ICsgICAgQmRydkNoaWxkICpjaGlsZDsNCj4gICANCj4g
ICAgICAgaWYgKGJkcnZfaXNfYmFja2luZ19jaGFpbl9mcm96ZW4oYnMsIGJhc2UsIGVycnApKSB7
DQo+ICAgICAgICAgICByZXR1cm4gLUVQRVJNOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgZm9y
IChpID0gYnM7IGkgIT0gYmFzZTsgaSA9IGJhY2tpbmdfYnMoaSkpIHsNCj4gLSAgICAgICAgaWYg
KGktPmJhY2tpbmcpIHsNCj4gLSAgICAgICAgICAgIGktPmJhY2tpbmctPmZyb3plbiA9IHRydWU7
DQo+ICsgICAgZm9yIChpID0gYnM7IGkgIT0gYmFzZTsgaSA9IGNoaWxkX2JzKGNoaWxkKSkgew0K
PiArICAgICAgICBjaGlsZCA9IGJkcnZfZmlsdGVyZWRfY2hpbGQoaSk7DQo+ICsgICAgICAgIGlm
IChjaGlsZCkgew0KPiArICAgICAgICAgICAgY2hpbGQtPmZyb3plbiA9IHRydWU7DQo+ICAgICAg
ICAgICB9DQo+ICAgICAgIH0NCj4gICANCj4gQEAgLTQzMjgsMTUgKzQzNDEsMTggQEAgaW50IGJk
cnZfZnJlZXplX2JhY2tpbmdfY2hhaW4oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEJsb2NrRHJpdmVy
U3RhdGUgKmJhc2UsDQo+ICAgICogVW5mcmVlemUgYWxsIGJhY2tpbmcgbGlua3MgYmV0d2VlbiBA
YnMgYW5kIEBiYXNlLiBUaGUgY2FsbGVyIG11c3QNCj4gICAgKiBlbnN1cmUgdGhhdCBhbGwgbGlu
a3MgYXJlIGZyb3plbiBiZWZvcmUgdXNpbmcgdGhpcyBmdW5jdGlvbi4NCj4gICAgKiBAYmFzZSBt
dXN0IGJlIHJlYWNoYWJsZSBmcm9tIEBicywgb3IgTlVMTC4NCj4gKyAqIChGaWx0ZXJzIGFyZSB0
cmVhdGVkIGFzIG5vcm1hbCBlbGVtZW50cyBvZiB0aGUgYmFja2luZyBjaGFpbi4pDQo+ICAgICov
DQo+ICAgdm9pZCBiZHJ2X3VuZnJlZXplX2JhY2tpbmdfY2hhaW4oQmxvY2tEcml2ZXJTdGF0ZSAq
YnMsIEJsb2NrRHJpdmVyU3RhdGUgKmJhc2UpDQo+ICAgew0KPiAgICAgICBCbG9ja0RyaXZlclN0
YXRlICppOw0KPiArICAgIEJkcnZDaGlsZCAqY2hpbGQ7DQo+ICAgDQo+IC0gICAgZm9yIChpID0g
YnM7IGkgIT0gYmFzZTsgaSA9IGJhY2tpbmdfYnMoaSkpIHsNCj4gLSAgICAgICAgaWYgKGktPmJh
Y2tpbmcpIHsNCj4gLSAgICAgICAgICAgIGFzc2VydChpLT5iYWNraW5nLT5mcm96ZW4pOw0KPiAt
ICAgICAgICAgICAgaS0+YmFja2luZy0+ZnJvemVuID0gZmFsc2U7DQo+ICsgICAgZm9yIChpID0g
YnM7IGkgIT0gYmFzZTsgaSA9IGNoaWxkX2JzKGNoaWxkKSkgew0KPiArICAgICAgICBjaGlsZCA9
IGJkcnZfZmlsdGVyZWRfY2hpbGQoaSk7DQo+ICsgICAgICAgIGlmIChjaGlsZCkgew0KPiArICAg
ICAgICAgICAgYXNzZXJ0KGNoaWxkLT5mcm96ZW4pOw0KPiArICAgICAgICAgICAgY2hpbGQtPmZy
b3plbiA9IGZhbHNlOw0KPiAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+ICAgfQ0KPiBAQCAtNDQz
OCw4ICs0NDU0LDExIEBAIGludCBiZHJ2X2Ryb3BfaW50ZXJtZWRpYXRlKEJsb2NrRHJpdmVyU3Rh
dGUgKnRvcCwgQmxvY2tEcml2ZXJTdGF0ZSAqYmFzZSwNCj4gICAgICAgICAgICAgICB9DQo+ICAg
ICAgICAgICB9DQo+ICAgDQo+IC0gICAgICAgIC8qIERvIHRoZSBhY3R1YWwgc3dpdGNoIGluIHRo
ZSBpbi1tZW1vcnkgZ3JhcGguDQo+IC0gICAgICAgICAqIENvbXBsZXRlcyBiZHJ2X2NoZWNrX3Vw
ZGF0ZV9wZXJtKCkgdHJhbnNhY3Rpb24gaW50ZXJuYWxseS4gKi8NCj4gKyAgICAgICAgLyoNCj4g
KyAgICAgICAgICogRG8gdGhlIGFjdHVhbCBzd2l0Y2ggaW4gdGhlIGluLW1lbW9yeSBncmFwaC4N
Cj4gKyAgICAgICAgICogQ29tcGxldGVzIGJkcnZfY2hlY2tfdXBkYXRlX3Blcm0oKSB0cmFuc2Fj
dGlvbiBpbnRlcm5hbGx5Lg0KPiArICAgICAgICAgKiBjLT5mcm96ZW4gaXMgZmFsc2UsIHdlIGhh
dmUgY2hlY2tlZCB0aGF0IGFib3ZlLg0KPiArICAgICAgICAgKi8NCj4gICAgICAgICAgIGJkcnZf
cmVmKGJhc2UpOw0KPiAgICAgICAgICAgYmRydl9yZXBsYWNlX2NoaWxkKGMsIGJhc2UpOw0KPiAg
ICAgICAgICAgYmRydl91bnJlZih0b3ApOw0KPiANCg0KSG1tLCBPSywgaXQncyBiZXR0ZXIgdGhh
biBpdCB3YXMsIHNvOg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkg
PHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KQnV0IEkgaGF2ZSBvbmUgdGhvdWdodDogd2Ug
Y2hlY2sgdGhhdCBmcm96ZW4gaXMgZmFsc2UgYXQgc29tZSBwb2ludCwgYW5kIHRoZW4NCmRvIHNv
bWUgbG9naWMgYXJvdW5kIHRoaXMgY2hpbGQuIFdoZXJlIGlzIGd1YXJhbnRlZSwgdGhhdCBzb21l
b25lIGVsc2Ugd2lsbCBub3QNCnNldCBmcm96ZW49dHJ1ZSBkdXJpbmcgc29tZSB5aWVsZCwgZm9y
IGV4YW1wbGU/IFNvLCBkbyB3ZSBuZWVkIGEga2luZCBvZiBjaGlsZF9tdXRleCwNCm9yIHNvbWV0
aGluZyBsaWtlIHRoaXM/DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

