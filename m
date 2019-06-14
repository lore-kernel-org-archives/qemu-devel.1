Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423B0C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A7420866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gEFxY6ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A7420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmPE-0007HB-A2
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41925)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbmDn-00072R-EU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbmDl-0004Gl-6t
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:26:22 -0400
Received: from mail-eopbgr40129.outbound.protection.outlook.com
 ([40.107.4.129]:17869 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbmDk-0004FX-5j; Fri, 14 Jun 2019 09:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKcsPpjBji4qS/A41ASUuOPIY8KqdKsvbgcPzr4Xqc4=;
 b=gEFxY6ayKLAwRE2+13fZLWlEwon74PFWHAVBnXEXT87DVNmljoynO/yPouyQB+cFLjYZMW2blV+9xke/M2u4/0QCfca5QOjMQ1GOai7Shh6Bdrgo9r2AqH4L6u7d/AgkT9iWGB38VNclFcDZ/+zG+C3aqrsCpEa3W8vr6v2EYAs=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB5283.eurprd08.prod.outlook.com (20.178.117.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 14 Jun 2019 13:26:15 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 13:26:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 14/42] block: Use CAFs when working with backing chains
Thread-Index: AQHVIWuuPVMblAMNYkC6XowcCoyrZaabJqGA
Date: Fri, 14 Jun 2019 13:26:15 +0000
Message-ID: <837ee511-af51-3062-8a2e-41adde1023b3@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-15-mreitz@redhat.com>
In-Reply-To: <20190612221004.2317-15-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0003.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::13) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614162613621
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a1a617e-f049-4fc2-3fe4-08d6f0cbe06e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:AM0PR08MB5283; 
x-ms-traffictypediagnostic: AM0PR08MB5283:
x-microsoft-antispam-prvs: <AM0PR08MB5283F4C9D09698098243A6A6C1EE0@AM0PR08MB5283.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39850400004)(366004)(346002)(376002)(136003)(199004)(189003)(6246003)(66946007)(486006)(8936002)(36756003)(2616005)(476003)(8676002)(14444005)(446003)(11346002)(25786009)(4326008)(478600001)(305945005)(81156014)(2501003)(81166006)(256004)(86362001)(31696002)(386003)(6486002)(229853002)(76176011)(316002)(64756008)(66556008)(3846002)(53936002)(14454004)(73956011)(5660300002)(6512007)(68736007)(2906002)(66066001)(6116002)(52116002)(102836004)(99286004)(54906003)(66446008)(7736002)(186003)(66476007)(71200400001)(6506007)(6436002)(110136005)(71190400001)(26005)(31686004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5283;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QwrgVAcDXRcHpGwKdjrJ4SQnNSNyBO/kzdlBnG3Ky8V9SlZNgkd63J4edFlYdVmDHFss2niBhNVY1orK7uWC5esKtLAge2GHAp17ARJKI1MKyGQ9JXQ2qBXEQpLmo4uW+lEEndnmB0I1PZYRq5J6xdKoXcAnuswI400PfZzhgjbOCIIUTFzi7FRsi/mtX9eebDYjYx9opm8bT6lqmudW0zBnFoKrD50Fm7lv/Av/yTAurlZwkL0XnwLTV1bNWE9JWXz2glqH1NxmAMguD0S+n0cID9A2xeAojeGKi//QQFhSx82RSHAs1gIyy9Kp5g0mnyPvmjqOWlG7Yt4302nT8jPuXbm0c6B4qOEDwhTg1L7L6SCs6WC9igQsWkoNPOzZOm4yv3Ke1JupqRrX3STZWQdIb75p/VVJrgZ1RsPX6eY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB737ED94FC97049B45507422CFCAECA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1a617e-f049-4fc2-3fe4-08d6f0cbe06e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 13:26:15.7890 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5283
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.129
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

MTMuMDYuMjAxOSAxOjA5LCBNYXggUmVpdHogd3JvdGU6DQo+IFVzZSBjaGlsZCBhY2Nlc3MgZnVu
Y3Rpb25zIHdoZW4gaXRlcmF0aW5nIHRocm91Z2ggYmFja2luZyBjaGFpbnMgc28NCj4gZmlsdGVy
cyBkbyBub3QgYnJlYWsgdGhlIGNoYWluLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6
IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgYmxvY2suYyB8IDQwICsrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjggaW5z
ZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYmxvY2suYyBi
L2Jsb2NrLmMNCj4gaW5kZXggMTFmMzc5ODNkOS4uNTA1YjNlOWEwMSAxMDA2NDQNCj4gLS0tIGEv
YmxvY2suYw0KPiArKysgYi9ibG9jay5jDQo+IEBAIC00MjYxLDcgKzQyNjEsOCBAQCBpbnQgYmRy
dl9jaGFuZ2VfYmFja2luZ19maWxlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgIH0NCj4gICAN
Cj4gICAvKg0KPiAtICogRmluZHMgdGhlIGltYWdlIGxheWVyIGluIHRoZSBjaGFpbiB0aGF0IGhh
cyAnYnMnIGFzIGl0cyBiYWNraW5nIGZpbGUuDQo+ICsgKiBGaW5kcyB0aGUgaW1hZ2UgbGF5ZXIg
aW4gdGhlIGNoYWluIHRoYXQgaGFzICdicycgKG9yIGEgZmlsdGVyIG9uDQo+ICsgKiB0b3Agb2Yg
aXQpIGFzIGl0cyBiYWNraW5nIGZpbGUuDQo+ICAgICoNCj4gICAgKiBhY3RpdmUgaXMgdGhlIGN1
cnJlbnQgdG9wbW9zdCBpbWFnZS4NCj4gICAgKg0KPiBAQCAtNDI3MywxMSArNDI3NCwxOCBAQCBp
bnQgYmRydl9jaGFuZ2VfYmFja2luZ19maWxlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgIEJs
b2NrRHJpdmVyU3RhdGUgKmJkcnZfZmluZF9vdmVybGF5KEJsb2NrRHJpdmVyU3RhdGUgKmFjdGl2
ZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCbG9ja0RyaXZlclN0
YXRlICpicykNCj4gICB7DQo+IC0gICAgd2hpbGUgKGFjdGl2ZSAmJiBicyAhPSBiYWNraW5nX2Jz
KGFjdGl2ZSkpIHsNCj4gLSAgICAgICAgYWN0aXZlID0gYmFja2luZ19icyhhY3RpdmUpOw0KPiAr
ICAgIGJzID0gYmRydl9za2lwX3J3X2ZpbHRlcnMoYnMpOw0KPiArICAgIGFjdGl2ZSA9IGJkcnZf
c2tpcF9yd19maWx0ZXJzKGFjdGl2ZSk7DQo+ICsNCj4gKyAgICB3aGlsZSAoYWN0aXZlKSB7DQo+
ICsgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKm5leHQgPSBiZHJ2X2JhY2tpbmdfY2hhaW5fbmV4
dChhY3RpdmUpOw0KPiArICAgICAgICBpZiAoYnMgPT0gbmV4dCkgew0KPiArICAgICAgICAgICAg
cmV0dXJuIGFjdGl2ZTsNCj4gKyAgICAgICAgfQ0KPiArICAgICAgICBhY3RpdmUgPSBuZXh0Ow0K
PiAgICAgICB9DQo+ICAgDQo+IC0gICAgcmV0dXJuIGFjdGl2ZTsNCj4gKyAgICByZXR1cm4gTlVM
TDsNCj4gICB9DQoNClNlbWFudGljcyBjaGFuZ2VkIGZvciB0aGlzIGZ1bmN0aW9uLg0KSXQgaXMg
dXNlZCBpbiB0d28gcGxhY2VzDQoxLiBmcm9tIGJkcnZfZmluZF9iYXNlIHd0aWggQGJzPU5VTEws
IGl0IHNob3VsZCBiZSB1bmNoYW5nZWQsIGFzIEkgaG9wZSB3ZSB3aWxsIG5ldmVyIGhhdmUNCiAg
ICBmaWx0ZXIgbm9kZSBhcyBhIGJvdHRvbSBvZiBzb21lIHZhbGlkIGNoYWluDQoNCjIuIGZyb20g
cW1wX2Jsb2NrX2NvbW1pdCwgb25seSB0byBjaGVjayBvcC1ibG9ja2VyLi4uIGhtbW0uIEkgcmVh
bGx5IGRvbid0IHVuZGVyc3RhbmQsDQp3aHkgZG8gd2UgY2hlY2sgQkxPQ0tfT1BfVFlQRV9DT01N
SVRfVEFSR0VUIG9uIHRvcF9icyBvdmVybGF5Li4gdG9wX2JzIG92ZXJsYXkgaXMgb3V0IG9mIHRo
ZSBqb2IsDQp3aGF0IGlzIHRoaXMgY2hlY2sgZm9yPw0KDQoNCj4gICANCj4gICAvKiBHaXZlbiBh
IEJEUywgc2VhcmNoZXMgZm9yIHRoZSBiYXNlIGxheWVyLiAqLw0KPiBAQCAtNDQyMSw5ICs0NDI5
LDcgQEAgaW50IGJkcnZfZHJvcF9pbnRlcm1lZGlhdGUoQmxvY2tEcml2ZXJTdGF0ZSAqdG9wLCBC
bG9ja0RyaXZlclN0YXRlICpiYXNlLA0KPiAgICAgICAgKiBvdGhlciBpbnRlcm1lZGlhdGUgbm9k
ZXMgaGF2ZSBiZWVuIGRyb3BwZWQuDQo+ICAgICAgICAqIElmICd0b3AnIGlzIGFuIGltcGxpY2l0
IG5vZGUgKGUuZy4gImNvbW1pdF90b3AiKSB3ZSBzaG91bGQgc2tpcA0KPiAgICAgICAgKiBpdCBi
ZWNhdXNlIG5vIG9uZSBpbmhlcml0cyBmcm9tIGl0LiBXZSB1c2UgZXhwbGljaXRfdG9wIGZvciB0
aGF0LiAqLw0KPiAtICAgIHdoaWxlIChleHBsaWNpdF90b3AgJiYgZXhwbGljaXRfdG9wLT5pbXBs
aWNpdCkgew0KPiAtICAgICAgICBleHBsaWNpdF90b3AgPSBiYWNraW5nX2JzKGV4cGxpY2l0X3Rv
cCk7DQo+IC0gICAgfQ0KPiArICAgIGV4cGxpY2l0X3RvcCA9IGJkcnZfc2tpcF9pbXBsaWNpdF9m
aWx0ZXJzKGV4cGxpY2l0X3RvcCk7DQo+ICAgICAgIHVwZGF0ZV9pbmhlcml0c19mcm9tID0gYmRy
dl9pbmhlcml0c19mcm9tX3JlY3Vyc2l2ZShiYXNlLCBleHBsaWNpdF90b3ApOw0KPiAgIA0KPiAg
ICAgICAvKiBzdWNjZXNzIC0gd2UgY2FuIGRlbGV0ZSB0aGUgaW50ZXJtZWRpYXRlIHN0YXRlcywg
YW5kIGxpbmsgdG9wLT5iYXNlICovDQo+IEBAIC00OTAyLDcgKzQ5MDgsNyBAQCBCbG9ja0RyaXZl
clN0YXRlICpiZHJ2X2xvb2t1cF9icyhjb25zdCBjaGFyICpkZXZpY2UsDQo+ICAgYm9vbCBiZHJ2
X2NoYWluX2NvbnRhaW5zKEJsb2NrRHJpdmVyU3RhdGUgKnRvcCwgQmxvY2tEcml2ZXJTdGF0ZSAq
YmFzZSkNCj4gICB7DQo+ICAgICAgIHdoaWxlICh0b3AgJiYgdG9wICE9IGJhc2UpIHsNCj4gLSAg
ICAgICAgdG9wID0gYmFja2luZ19icyh0b3ApOw0KPiArICAgICAgICB0b3AgPSBiZHJ2X2ZpbHRl
cmVkX2JzKHRvcCk7DQo+ICAgICAgIH0NCj4gICANCj4gICAgICAgcmV0dXJuIHRvcCAhPSBOVUxM
Ow0KPiBAQCAtNTE0MSw3ICs1MTQ3LDE3IEBAIEJsb2NrRHJpdmVyU3RhdGUgKmJkcnZfZmluZF9i
YWNraW5nX2ltYWdlKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPiAgIA0KPiAgICAgICBpc19wcm90
b2NvbCA9IHBhdGhfaGFzX3Byb3RvY29sKGJhY2tpbmdfZmlsZSk7DQo+ICAgDQo+IC0gICAgZm9y
IChjdXJyX2JzID0gYnM7IGN1cnJfYnMtPmJhY2tpbmc7IGN1cnJfYnMgPSBjdXJyX2JzLT5iYWNr
aW5nLT5icykgew0KPiArICAgIC8qDQo+ICsgICAgICogQmVpbmcgbGFyZ2VseSBhIGxlZ2FjeSBm
dW5jdGlvbiwgc2tpcCBhbnkgZmlsdGVycyBoZXJlDQo+ICsgICAgICogKGJlY2F1c2UgZmlsdGVy
cyBkbyBub3QgaGF2ZSBub3JtYWwgZmlsZW5hbWVzLCBzbyB0aGV5IGNhbm5vdA0KPiArICAgICAq
IG1hdGNoIGFueXdheTsgYW5kIGFsbG93aW5nIGpzb246e30gZmlsZW5hbWVzIGlzIGEgYml0IG91
dCBvZg0KPiArICAgICAqIHNjb3BlKS4NCj4gKyAgICAgKi8NCj4gKyAgICBmb3IgKGN1cnJfYnMg
PSBiZHJ2X3NraXBfcndfZmlsdGVycyhicyk7DQo+ICsgICAgICAgICBiZHJ2X2ZpbHRlcmVkX2Nv
d19jaGlsZChjdXJyX2JzKSAhPSBOVUxMOw0KPiArICAgICAgICAgY3Vycl9icyA9IGJkcnZfYmFj
a2luZ19jaGFpbl9uZXh0KGN1cnJfYnMpKQ0KPiArICAgIHsNCj4gKyAgICAgICAgQmxvY2tEcml2
ZXJTdGF0ZSAqYnNfYmVsb3cgPSBiZHJ2X2JhY2tpbmdfY2hhaW5fbmV4dChjdXJyX2JzKTsNCj4g
ICANCj4gICAgICAgICAgIC8qIElmIGVpdGhlciBvZiB0aGUgZmlsZW5hbWUgcGF0aHMgaXMgYWN0
dWFsbHkgYSBwcm90b2NvbCwgdGhlbg0KPiAgICAgICAgICAgICogY29tcGFyZSB1bm1vZGlmaWVk
IHBhdGhzOyBvdGhlcndpc2UgbWFrZSBwYXRocyByZWxhdGl2ZSAqLw0KPiBAQCAtNTE0OSw3ICs1
MTY1LDcgQEAgQmxvY2tEcml2ZXJTdGF0ZSAqYmRydl9maW5kX2JhY2tpbmdfaW1hZ2UoQmxvY2tE
cml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgICAgICAgICAgY2hhciAqYmFja2luZ19maWxlX2Z1bGxf
cmV0Ow0KPiAgIA0KPiAgICAgICAgICAgICAgIGlmIChzdHJjbXAoYmFja2luZ19maWxlLCBjdXJy
X2JzLT5iYWNraW5nX2ZpbGUpID09IDApIHsNCg0KaG1tLCBpbnRlcmVzdGluZywgd2hhdCBicy0+
YmFja2luZ19maWxlIG5vdyBtZWFucz8gSXQncyBzdHJhbmdlIGVub3VnaCB0byBzdG9yZSBzdWNo
IGZpZWxkIG9uDQpiZHMsIHdoZW4gd2UgaGF2ZSBiYWNraW5nIGxpbmsgYW55d2F5Li4NCg0KPiAt
ICAgICAgICAgICAgICAgIHJldHZhbCA9IGN1cnJfYnMtPmJhY2tpbmctPmJzOw0KPiArICAgICAg
ICAgICAgICAgIHJldHZhbCA9IGJzX2JlbG93Ow0KPiAgICAgICAgICAgICAgICAgICBicmVhazsN
Cj4gICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgLyogQWxzbyBjaGVjayBhZ2FpbnN0
IHRoZSBmdWxsIGJhY2tpbmcgZmlsZW5hbWUgZm9yIHRoZSBpbWFnZSAqLw0KPiBAQCAtNTE1OSw3
ICs1MTc1LDcgQEAgQmxvY2tEcml2ZXJTdGF0ZSAqYmRydl9maW5kX2JhY2tpbmdfaW1hZ2UoQmxv
Y2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAgICAgICAgICAgICAgIGJvb2wgZXF1YWwgPSBzdHJj
bXAoYmFja2luZ19maWxlLCBiYWNraW5nX2ZpbGVfZnVsbF9yZXQpID09IDA7DQo+ICAgICAgICAg
ICAgICAgICAgIGdfZnJlZShiYWNraW5nX2ZpbGVfZnVsbF9yZXQpOw0KPiAgICAgICAgICAgICAg
ICAgICBpZiAoZXF1YWwpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgcmV0dmFsID0gY3Vycl9i
cy0+YmFja2luZy0+YnM7DQo+ICsgICAgICAgICAgICAgICAgICAgIHJldHZhbCA9IGJzX2JlbG93
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgICAgICAgICAgIH0N
Cj4gICAgICAgICAgICAgICB9DQo+IEBAIC01MTg1LDcgKzUyMDEsNyBAQCBCbG9ja0RyaXZlclN0
YXRlICpiZHJ2X2ZpbmRfYmFja2luZ19pbWFnZShCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAg
ICAgICAgICAgICBnX2ZyZWUoZmlsZW5hbWVfdG1wKTsNCj4gICANCj4gICAgICAgICAgICAgICBp
ZiAoc3RyY21wKGJhY2tpbmdfZmlsZV9mdWxsLCBmaWxlbmFtZV9mdWxsKSA9PSAwKSB7DQo+IC0g
ICAgICAgICAgICAgICAgcmV0dmFsID0gY3Vycl9icy0+YmFja2luZy0+YnM7DQo+ICsgICAgICAg
ICAgICAgICAgcmV0dmFsID0gYnNfYmVsb3c7DQo+ICAgICAgICAgICAgICAgICAgIGJyZWFrOw0K
PiAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgIH0NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

