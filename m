Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76FDC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B968720896
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CXV5NxoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B968720896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRLH-0000tO-0A
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51689)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbPmu-0004mT-Pb
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbPmt-0006Ve-N9
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:29:08 -0400
Received: from mail-eopbgr70097.outbound.protection.outlook.com
 ([40.107.7.97]:44133 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbPmq-0006TI-KC; Thu, 13 Jun 2019 09:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kV3rg986V4HCl8evOL8m3GdP7PJp6Gcjzmd5syEx2Q=;
 b=CXV5NxoK2IPYMFhG2r3Gwp0s2KaIBZMndd6R/n6NFnP3o2CgG26QhZGLSlh4YXC/TMTUOUf/r5s+fxR0QrycFQdb58087KEQan9aDapMKZuI67j7nATlMnYPJ6mAk5ctMidE5GzAK4O1b/upx9e7FikDVEKfX/kbfPq8fzqol4M=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4450.eurprd08.prod.outlook.com (20.179.33.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Thu, 13 Jun 2019 13:29:00 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 13:29:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 11/42] block: Add bdrv_supports_compressed_writes()
Thread-Index: AQHVIWuqR6rvEt+Rd0Sot3Q4bIiZmaaZlRCA
Date: Thu, 13 Jun 2019 13:29:00 +0000
Message-ID: <7a0fe60a-0d16-5420-0c6a-65cfe01bc933@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-12-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-12-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0021.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::31) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613162857941
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d29b82b-cec4-43ab-d4f8-08d6f0031860
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4450; 
x-ms-traffictypediagnostic: AM0PR08MB4450:
x-microsoft-antispam-prvs: <AM0PR08MB4450811BE160585FF559F43DC1EF0@AM0PR08MB4450.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39850400004)(189003)(199004)(76176011)(6512007)(8936002)(52116002)(5660300002)(7736002)(8676002)(102836004)(186003)(86362001)(81156014)(81166006)(66066001)(53936002)(305945005)(26005)(99286004)(6246003)(25786009)(6436002)(54906003)(446003)(6116002)(316002)(2616005)(386003)(6506007)(110136005)(4326008)(3846002)(31696002)(11346002)(71190400001)(476003)(486006)(2906002)(14454004)(68736007)(6486002)(31686004)(71200400001)(478600001)(256004)(36756003)(66946007)(66476007)(66556008)(66446008)(64756008)(73956011)(229853002)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4450;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bTfN1qhDGnmqxlmDaHtRyyurhHhwufajcx76NKTiFNRtDvF6CesoMux71qhAD1x8zJljyfksH3jKVmArYpiFJqu9L3gx4omvIycA0ytS8jI4N6G0WaUe4wcjsklhPuhqubU2gW+9eiCY81jXOP7QXOsTBV4li6LpyNbX9lrA8ciAM3v/k/s+npetKw3ExOM8OK94gBA2W1+yx985UZxlN/wX46540BrMgDI+I/WmR4zelJHatEz7BYB0jkndvFRxj0pyu/bCmvY+ZY4bIrQEjdqFqwJtNCwoAHI/LympXSFYrwlS7KhmUGNejhIwCfzFmpbr4zxppAbvo74KX/YzzKRasRF0HB+hmdUxHED8KqOeoHlLXWrkSGswUjKtIjGKchpQOk2XrQL1g/VQ/yUEUSilYcJt/ILsRsMaX7Ho0IQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FEC4B14A841D64F884B763491CB8FB3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d29b82b-cec4-43ab-d4f8-08d6f0031860
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 13:29:00.8098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4450
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.97
Subject: Re: [Qemu-devel] [PATCH v5 11/42] block: Add
 bdrv_supports_compressed_writes()
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IEZpbHRlcnMgY2Fubm90IGNvbXBy
ZXNzIGRhdGEgdGhlbXNlbHZlcyBidXQgdGhleSBoYXZlIHRvIGltcGxlbWVudA0KPiAuYmRydl9j
b19wd3JpdGV2X2NvbXByZXNzZWQoKSBzdGlsbCAob3IgdGhleSBjYW5ub3QgZm9yd2FyZCBjb21w
cmVzc2VkDQo+IHdyaXRlcykuICBUaGVyZWZvcmUsIGNoZWNraW5nIHdoZXRoZXINCj4gYnMtPmRy
di0+YmRydl9jb19wd3JpdGV2X2NvbXByZXNzZWQgaXMgbm9uLU5VTEwgaXMgbm90IHN1ZmZpY2ll
bnQgdG8NCj4ga25vdyB3aGV0aGVyIHRoZSBub2RlIGNhbiBhY3R1YWxseSBoYW5kbGUgY29tcHJl
c3NlZCB3cml0ZXMuICBUaGlzDQo+IGZ1bmN0aW9uIGxvb2tzIGRvd24gdGhlIGZpbHRlciBjaGFp
biB0byBzZWUgd2hldGhlciB0aGVyZSBpcyBhDQo+IG5vbi1maWx0ZXIgdGhhdCBjYW4gYWN0dWFs
bHkgY29udmVydCB0aGUgY29tcHJlc3NlZCB3cml0ZXMgaW50bw0KPiBjb21wcmVzc2VkIGRhdGEg
KGFuZCB0aHVzIG5vcm1hbCB3cml0ZXMpLg0KDQpXaHkgbm90IHRvIHVzZSB0aGlzIGZ1bmN0aW9u
IGluIChhcyBJIHJlbWVtYmVyIG9ubHkgMi0zIGNhc2VzKSB3aGVuDQp3ZSBjaGVjayBmb3IgYnMt
PmRydi0+YmRydl9jb19wd3JpdGV2X2NvbXByZXNzZWQ/IEl0IHdvdWxkIGJlIGEgY29tcGxldGUg
Zml4DQpmb3IgZGVzY3JpYmVkIHByb2JsZW0uDQooaG1tLCBvaywgb3RoZXIgbmV3IEFQSXMgYXJl
IGFkZGVkIHNlcGFyYXRlbHkgdG9vLCBmb3Igc29tZSByZWFzb24gdGhleSBkb24ndA0KY29uZnVz
ZSBtZSBhbmQgdGhpcyBjb25mdXNlcykNCg0KT24gdGhlIG90aGVyIGhhbmQsICh0aGUgc2Vjb25k
IHRpbWUgSSB0aGluayBhYm91dCBpdCBkdXJpbmcgcmV2aWV3KSwgY291bGQNCndlIGhhbmRsZSBj
b21wcmVzc2lvbiB0aHJvdWdoIGZsYWdzIGNvbXBsZXRlbHk/DQpXZSBoYXZlIHN1cHBvcnRlZF93
cml0ZV9mbGFncyBmZWF0dXJlLCB3aGljaCBzaG91bGQgYmUgdXNlZCBmb3IgYWxsIHRoZXNlIGNo
ZWNrcy4uDQpBbmQgbWF5IGJlLCB3ZSBtYXkgZHJvcCAuYmRydl9jb19wd3JpdGV2X2NvbXByZXNz
ZWQgYXQgYWxsLg0KDQpCdXQgaWYgeW91IHdhbnQgdG8ga2VlcCBpdCBhcyBpcywgaXQncyBPSyB0
b286DQpSZXZpZXdlZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0
ekByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmggfCAgMSArDQo+
ICAgYmxvY2suYyAgICAgICAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
IDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvYmxvY2svYmxvY2suaCBiL2luY2x1ZGUvYmxvY2svYmxvY2suaA0KPiBpbmRleCA2ODdj
MDNiMjc1Li43ODM1YzViMzcwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmgN
Cj4gKysrIGIvaW5jbHVkZS9ibG9jay9ibG9jay5oDQo+IEBAIC00ODcsNiArNDg3LDcgQEAgdm9p
ZCBiZHJ2X25leHRfY2xlYW51cChCZHJ2TmV4dEl0ZXJhdG9yICppdCk7DQo+ICAgDQo+ICAgQmxv
Y2tEcml2ZXJTdGF0ZSAqYmRydl9uZXh0X21vbml0b3Jfb3duZWQoQmxvY2tEcml2ZXJTdGF0ZSAq
YnMpOw0KPiAgIGJvb2wgYmRydl9pc19lbmNyeXB0ZWQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0K
PiArYm9vbCBiZHJ2X3N1cHBvcnRzX2NvbXByZXNzZWRfd3JpdGVzKEJsb2NrRHJpdmVyU3RhdGUg
KmJzKTsNCj4gICB2b2lkIGJkcnZfaXRlcmF0ZV9mb3JtYXQodm9pZCAoKml0KSh2b2lkICpvcGFx
dWUsIGNvbnN0IGNoYXIgKm5hbWUpLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lk
ICpvcGFxdWUsIGJvb2wgcmVhZF9vbmx5KTsNCj4gICBjb25zdCBjaGFyICpiZHJ2X2dldF9ub2Rl
X25hbWUoY29uc3QgQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPiBkaWZmIC0tZ2l0IGEvYmxvY2su
YyBiL2Jsb2NrLmMNCj4gaW5kZXggNTY3YTBmODJjOC4uOTc3NzRiN2IwNiAxMDA2NDQNCj4gLS0t
IGEvYmxvY2suYw0KPiArKysgYi9ibG9jay5jDQo+IEBAIC00NTg0LDYgKzQ1ODQsMjggQEAgYm9v
bCBiZHJ2X2lzX2VuY3J5cHRlZChCbG9ja0RyaXZlclN0YXRlICpicykNCj4gICAgICAgcmV0dXJu
IGZhbHNlOw0KPiAgIH0NCj4gICANCj4gKy8qKg0KPiArICogUmV0dXJuIHdoZXRoZXIgdGhlIGdp
dmVuIG5vZGUgc3VwcG9ydHMgY29tcHJlc3NlZCB3cml0ZXMuDQo+ICsgKi8NCj4gK2Jvb2wgYmRy
dl9zdXBwb3J0c19jb21wcmVzc2VkX3dyaXRlcyhCbG9ja0RyaXZlclN0YXRlICpicykNCj4gK3sN
Cj4gKyAgICBCbG9ja0RyaXZlclN0YXRlICpmaWx0ZXJlZCA9IGJkcnZfZmlsdGVyZWRfcndfYnMo
YnMpOw0KPiArDQo+ICsgICAgaWYgKCFicy0+ZHJ2IHx8ICFicy0+ZHJ2LT5iZHJ2X2NvX3B3cml0
ZXZfY29tcHJlc3NlZCkgew0KPiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAgfQ0KPiAr
DQo+ICsgICAgaWYgKGZpbHRlcmVkKSB7DQo+ICsgICAgICAgIC8qDQo+ICsgICAgICAgICAqIEZp
bHRlcnMgY2FuIG9ubHkgZm9yd2FyZCBjb21wcmVzc2VkIHdyaXRlcywgc28gd2UgaGF2ZSB0bw0K
PiArICAgICAgICAgKiBjaGVjayB0aGUgY2hpbGQuDQo+ICsgICAgICAgICAqLw0KPiArICAgICAg
ICByZXR1cm4gYmRydl9zdXBwb3J0c19jb21wcmVzc2VkX3dyaXRlcyhmaWx0ZXJlZCk7DQo+ICsg
ICAgfQ0KPiArDQo+ICsgICAgcmV0dXJuIHRydWU7DQo+ICt9DQo+ICsNCj4gICBjb25zdCBjaGFy
ICpiZHJ2X2dldF9mb3JtYXRfbmFtZShCbG9ja0RyaXZlclN0YXRlICpicykNCj4gICB7DQo+ICAg
ICAgIHJldHVybiBicy0+ZHJ2ID8gYnMtPmRydi0+Zm9ybWF0X25hbWUgOiBOVUxMOw0KPiANCg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

