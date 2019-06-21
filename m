Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E52C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1CEF2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ckMT8GQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CEF2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJPk-00031O-Iy
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 09:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48562)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJO0-0001xz-ST
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJNw-0008OS-FB
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:15:24 -0400
Received: from mail-eopbgr60101.outbound.protection.outlook.com
 ([40.107.6.101]:35982 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heJNu-00088S-Cs; Fri, 21 Jun 2019 09:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL1doUSwgDbJuB0X27jtiKkWEBcPWI9cfSZVjj7K2g4=;
 b=ckMT8GQHSvpgNu+5akEMPFnXEu9z3kPmiJMguZw4HDJYfDOdemMSHSGMSeV9sF5OnpHSxbPFa7+azr62XJ9AMLy8DSlCnH2Aomxno7ySax4AdzcHIHOJqsRi+4olemjqeA+eY9CntkPRlwt9kSEyg3rsHpQETj1iIeW5dVkBRXE=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4886.eurprd08.prod.outlook.com (20.179.47.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 21 Jun 2019 13:15:08 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 13:15:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 30/42] qemu-img: Use child access functions
Thread-Index: AQHVIWvHnxVNzSHLQUiliZZrFDtDOaaivO6AgABtcACAAvl3AA==
Date: Fri, 21 Jun 2019 13:15:08 +0000
Message-ID: <d086a736-6a4d-754d-74a4-f244a577d848@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-31-mreitz@redhat.com>
 <5fb4108f-eb50-d076-4e1a-d59de96ef3a7@virtuozzo.com>
 <9a90cab8-6738-5e20-8350-12965e240c5a@redhat.com>
In-Reply-To: <9a90cab8-6738-5e20-8350-12965e240c5a@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0004.eurprd07.prod.outlook.com
 (2603:10a6:7:67::14) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621161504897
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b05843b8-799f-4371-ad67-08d6f64a7ba3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DBBPR08MB4886; 
x-ms-traffictypediagnostic: DBBPR08MB4886:
x-microsoft-antispam-prvs: <DBBPR08MB4886C160615D155DAEF15288C1E70@DBBPR08MB4886.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(39840400004)(366004)(376002)(189003)(199004)(6246003)(8936002)(6506007)(446003)(11346002)(256004)(14454004)(86362001)(8676002)(2501003)(3846002)(6486002)(4326008)(478600001)(25786009)(81156014)(6116002)(31686004)(7736002)(305945005)(2616005)(476003)(53936002)(71200400001)(81166006)(71190400001)(52116002)(54906003)(68736007)(110136005)(66066001)(99286004)(6436002)(2906002)(386003)(486006)(316002)(229853002)(53546011)(186003)(76176011)(66476007)(66946007)(31696002)(102836004)(36756003)(73956011)(66556008)(6512007)(66446008)(64756008)(5660300002)(26005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4886;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8T3B9hJnujXbYFzXSj6Yg0S3jNCrT8A7DpVVUaNfLMlP7XKROiHgOzhbfwiiPB6OxI6Yh/hUvW9O66k7AEGVib+vlast9QvZgrKhVHmLi7p3kTTjHZsprkoun+Ra8yHOEnPQF0e60KZ4elqlK4l+2oz1ABx54ljsV5ZgS0sbywLmO0qLQnDkSlgU0FcSHN8NrLHyaBoW3itPK/5qbp6EXy70A8W/2UN68b4SYfnVaujMku4v2LfqzKqX0Bwd6zr3Jw45/fmWFLEjBlD0nz+vMfIQBtQmPs8Ucg51Fer9s9YW+NwIY1/+Yg5DlOK928ZXQ31fQJiTj5oIrh+seCYYBmqj+1FbL5dkpqX7c1ZC0DPkdDSgDcrwtSmWBemLFdOdDbQG24BJyEKKNKsEar9EXJ3QhmvCrlLLc0JSUbIQtjM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57832E64794E144B82F48D9D1C99E5A6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05843b8-799f-4371-ad67-08d6f64a7ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 13:15:08.5309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4886
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.101
Subject: Re: [Qemu-devel] [PATCH v5 30/42] qemu-img: Use child access
 functions
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

MTkuMDYuMjAxOSAxODo0OSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxOS4wNi4xOSAxMToxOCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA2LjIwMTkgMTowOSwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4+IFRoaXMgY2hhbmdlcyBpb3Rlc3QgMjA0J3Mgb3V0cHV0LCBi
ZWNhdXNlIGJsa2RlYnVnIG9uIHRvcCBvZiBhIENPVyBub2RlDQo+Pj4gdXNlZCB0byBtYWtlIHFl
bXUtaW1nIG1hcCBkaXNyZWdhcmQgdGhlIHJlc3Qgb2YgdGhlIGJhY2tpbmcgY2hhaW4gKHRoZQ0K
Pj4+IGJhY2tpbmcgY2hhaW4gd2FzIGJyb2tlbiBieSB0aGUgZmlsdGVyKS4gIFdpdGggdGhpcyBw
YXRjaCwgdGhlDQo+Pj4gYWxsb2NhdGlvbiBpbiB0aGUgYmFzZSBpbWFnZSBpcyByZXBvcnRlZCBj
b3JyZWN0bHkuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRo
YXQuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIHFlbXUtaW1nLmMgICAgICAgICAgICAgICAgIHwgMzYg
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tDQo+Pj4gICAgdGVzdHMvcWVtdS1p
b3Rlc3RzLzIwNC5vdXQgfCAgMSArDQo+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRp
b25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9xZW11LWltZy5j
IGIvcWVtdS1pbWcuYw0KPj4+IGluZGV4IDA3YjZlMmE4MDguLjdiZmE2ZTVkNDAgMTAwNjQ0DQo+
Pj4gLS0tIGEvcWVtdS1pbWcuYw0KPj4+ICsrKyBiL3FlbXUtaW1nLmMNCj4+PiBAQCAtOTkyLDcg
Kzk5Miw3IEBAIHN0YXRpYyBpbnQgaW1nX2NvbW1pdChpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+
Pj4gICAgICAgIGlmICghYmxrKSB7DQo+Pj4gICAgICAgICAgICByZXR1cm4gMTsNCj4+PiAgICAg
ICAgfQ0KPj4+IC0gICAgYnMgPSBibGtfYnMoYmxrKTsNCj4+PiArICAgIGJzID0gYmRydl9za2lw
X2ltcGxpY2l0X2ZpbHRlcnMoYmxrX2JzKGJsaykpOw0KPj4NCj4+IGlmIGZpbGVuYW1lIGlzIGpz
b24sIGRlc2NyaWJpbmcgZXhwbGljaXQgZmlsdGVyIG92ZXIgbm9ybWFsIG5vZGUsIGJzIHdpbGwg
YmUNCj4+IGV4cGxpY2l0IGZpbHRlciAuLi4NCj4+DQo+Pj4gICAgDQo+Pj4gICAgICAgIHFlbXVf
cHJvZ3Jlc3NfaW5pdChwcm9ncmVzcywgMS5mKTsNCj4+PiAgICAgICAgcWVtdV9wcm9ncmVzc19w
cmludCgwLmYsIDEwMCk7DQo+Pj4gQEAgLTEwMDksNyArMTAwOSw3IEBAIHN0YXRpYyBpbnQgaW1n
X2NvbW1pdChpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+Pj4gICAgICAgICAgICAvKiBUaGlzIGlz
IGRpZmZlcmVudCBmcm9tIFFNUCwgd2hpY2ggYnkgZGVmYXVsdCB1c2VzIHRoZSBkZWVwZXN0IGZp
bGUgaW4NCj4+PiAgICAgICAgICAgICAqIHRoZSBiYWNraW5nIGNoYWluIChpLmUuLCB0aGUgdmVy
eSBiYXNlKTsgaG93ZXZlciwgdGhlIHRyYWRpdGlvbmFsDQo+Pj4gICAgICAgICAgICAgKiBiZWhh
dmlvciBvZiBxZW11LWltZyBjb21taXQgaXMgdXNpbmcgdGhlIGltbWVkaWF0ZSBiYWNraW5nIGZp
bGUuICovDQo+Pj4gLSAgICAgICAgYmFzZV9icyA9IGJhY2tpbmdfYnMoYnMpOw0KPj4+ICsgICAg
ICAgIGJhc2VfYnMgPSBiZHJ2X2ZpbHRlcmVkX2Nvd19icyhicyk7DQo+Pj4gICAgICAgICAgICBp
ZiAoIWJhc2VfYnMpIHsNCj4+DQo+PiBhbmQgaGVyZSB3ZSdsbCBmYWlsLg0KPiANCj4gUmlnaHQs
IHdpbGwgY2hhbmdlIHRvIGJkcnZfYmFja2luZ19jaGFpbl9uZXh0KCkuDQo+IA0KPj4+ICAgICAg
ICAgICAgICAgIGVycm9yX3NldGcoJmxvY2FsX2VyciwgIkltYWdlIGRvZXMgbm90IGhhdmUgYSBi
YWNraW5nIGZpbGUiKTsNCj4+PiAgICAgICAgICAgICAgICBnb3RvIGRvbmU7DQo+Pj4gQEAgLTE2
MjYsMTkgKzE2MjYsMTggQEAgc3RhdGljIGludCBjb252ZXJ0X2l0ZXJhdGlvbl9zZWN0b3JzKElt
Z0NvbnZlcnRTdGF0ZSAqcywgaW50NjRfdCBzZWN0b3JfbnVtKQ0KPj4+ICAgIA0KPj4+ICAgICAg
ICBpZiAocy0+c2VjdG9yX25leHRfc3RhdHVzIDw9IHNlY3Rvcl9udW0pIHsNCj4+PiAgICAgICAg
ICAgIGludDY0X3QgY291bnQgPSBuICogQkRSVl9TRUNUT1JfU0laRTsNCj4+PiArICAgICAgICBC
bG9ja0RyaXZlclN0YXRlICpzcmNfYnMgPSBibGtfYnMocy0+c3JjW3NyY19jdXJdKTsNCj4+PiAr
ICAgICAgICBCbG9ja0RyaXZlclN0YXRlICpiYXNlOw0KPj4+ICAgIA0KPj4+ICAgICAgICAgICAg
aWYgKHMtPnRhcmdldF9oYXNfYmFja2luZykgew0KPj4+IC0NCj4+PiAtICAgICAgICAgICAgcmV0
ID0gYmRydl9ibG9ja19zdGF0dXMoYmxrX2JzKHMtPnNyY1tzcmNfY3VyXSksDQo+Pj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChzZWN0b3JfbnVtIC0gc3JjX2N1cl9vZmZz
ZXQpICoNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQkRSVl9TRUNU
T1JfU0laRSwNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY291bnQs
ICZjb3VudCwgTlVMTCwgTlVMTCk7DQo+Pj4gKyAgICAgICAgICAgIGJhc2UgPSBiZHJ2X2JhY2tp
bmdfY2hhaW5fbmV4dChzcmNfYnMpOw0KPj4NCj4+IEFzIHlvdSBkZXNjcmliZWQgaW4gYW5vdGhl
ciBwYXRjaCwgd2lsbCBub3Qgd2UgaGVyZSBnZXQgYWxsb2NhdGVkIGluIGJhc2UgYXMgYWxsb2Nh
dGVkLCBiZWNhdXNlIG9mDQo+PiBjb3VudGluZyBmaWx0ZXJzIGFib3ZlIGJhc2U/DQo+IA0KPiBE
YW1uLCB5ZXMuICBTbw0KPiANCj4gICAgICBiYXNlID0gYmRydl9maWx0ZXJlZF9jb3dfYnMoYmRy
dl9za2lwX3J3X2ZpbHRlcnMoc3JjX2JzKSk7DQo+IA0KPiBJIHN1cHBvc2UuDQo+IA0KPj4gSG1t
LiBJIG5vdyB0aGluaywgd2h5IGZpbHRlcnMgZG9uJ3QgcmVwb3J0IGV2ZXJ5dGhpbmcgYXMgdW5h
bGxvY2F0ZWQsIHdvdWxkIG5vdCBpdCBiZSBtb3JlIGNvcnJlY3QNCj4+IHRoYW4gZmFsbHRocm91
Z2ggdG8gY2hpbGQ/DQo+IA0KPiBJIGRvbuKAmXQga25vdywgYWN0dWFsbHkuICBNYXliZSwgbWF5
YmUgbm90Lg0KPiANCj4+PiAgICAgICAgICAgIH0gZWxzZSB7DQo+Pj4gLSAgICAgICAgICAgIHJl
dCA9IGJkcnZfYmxvY2tfc3RhdHVzX2Fib3ZlKGJsa19icyhzLT5zcmNbc3JjX2N1cl0pLCBOVUxM
LA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc2VjdG9y
X251bSAtIHNyY19jdXJfb2Zmc2V0KSAqDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJEUlZfU0VDVE9SX1NJWkUsDQo+Pj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvdW50LCAmY291bnQsIE5VTEwsIE5VTEwpOw0KPj4+
ICsgICAgICAgICAgICBiYXNlID0gTlVMTDsNCj4+PiAgICAgICAgICAgIH0NCj4+PiArICAgICAg
ICByZXQgPSBiZHJ2X2Jsb2NrX3N0YXR1c19hYm92ZShzcmNfYnMsIGJhc2UsDQo+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHNlY3Rvcl9udW0gLSBzcmNfY3VyX29m
ZnNldCkgKg0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJEUlZf
U0VDVE9SX1NJWkUsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y291bnQsICZjb3VudCwgTlVMTCwgTlVMTCk7DQo+Pj4gICAgICAgICAgICBpZiAocmV0IDwgMCkg
ew0KPj4+ICAgICAgICAgICAgICAgIGVycm9yX3JlcG9ydCgiZXJyb3Igd2hpbGUgcmVhZGluZyBi
bG9jayBzdGF0dXMgb2Ygc2VjdG9yICUiIFBSSWQ2NA0KPj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAiOiAlcyIsIHNlY3Rvcl9udW0sIHN0cmVycm9yKC1yZXQpKTsNCj4gDQo+IFsuLi5d
DQo+IA0KPj4+IEBAIC0yOTQ5LDcgKzI5NTAsNyBAQCBzdGF0aWMgaW50IGltZ19tYXAoaW50IGFy
Z2MsIGNoYXIgKiphcmd2KQ0KPj4+ICAgICAgICBpZiAoIWJsaykgew0KPj4+ICAgICAgICAgICAg
cmV0dXJuIDE7DQo+Pj4gICAgICAgIH0NCj4+PiAtICAgIGJzID0gYmxrX2JzKGJsayk7DQo+Pj4g
KyAgICBicyA9IGJkcnZfc2tpcF9pbXBsaWNpdF9maWx0ZXJzKGJsa19icyhibGspKTsNCj4+DQo+
PiBIbW0sIGFub3RoZXIgdGhvdWdodCBhYm91dCBpbXBsaWNpdCBmaWx0ZXJzLCBob3cgdGhleSBj
b3VsZCBiZSBoZXJlIGluIHFlbXUtaW1nPw0KPiANCj4gSG0sIEkgZG9u4oCZdCB0aGluayB0aGV5
IGNhbi4NCj4gDQo+PiBJZiBpbXBsaWNpdCBhcmUgb25seQ0KPj4gam9iIGZpbHRlcnMuIERvIHlv
dSBwcmVwYXJlZCBpdCBmb3IgaW1wbGljaXQgQ09SPyBCdXQgd2UgZGlzY3Vzc2VkIHdpdGggS2V2
aW4gdGhhdCB3ZSdkIGJldHRlciBkZXByZWNhdGUNCj4+IGNvcHktb24tcmVhZCBvcHRpb24uLg0K
Pj4NCj4+IFNvLCBpZiBpbXBsaWNpdCBmaWx0ZXJzIGFyZSBmb3IgY29tcGF0aWJpbGl0eSwgd2Un
bGwgaGF2ZSB0aGVtIG9ubHkgaW4gYmxvY2stam9icy4gU28sIHNlZW1zIG5vIHJlYXNvbiB0byBz
dXBwb3J0DQo+PiB0aGVtIGluIHFlbXUtaW1nLg0KPiANCj4gU2VlbXMgcmVhc29uYWJsZSwgeWVz
Lg0KPiANCj4+IEFsc28sIGluIGJsb2NrLWpvYnMsIHdlIGNhbiBhYmFuZG9uIGNyZWF0aW5nIGlt
cGxpY2l0IGZpbHRlcnMgYWJvdmUgYW55IGZpbHRlciBub2RlcywgYXMgd2VsbCBhcyBhYmFuZG9u
IGNyZWF0aW5nIGFueQ0KPj4gZmlsdGVyIG5vZGVzIGFib3ZlIGltcGxpY2l0IGZpbHRlcnMuIFRo
aXMgd2lsbCBzdGlsbCBzdXBwb3J0IG9sZCBzY2VuYXJpb3MsIGJ1dCBnaXZlcyB2ZXJ5IHNpbXBs
ZSBhbmQgd2VsbCBkZWZpbmVkIHNjb3BlDQo+PiBvZiB1c2luZyBpbXBsaWNpdCBmaWx0ZXJzIGFu
ZCBob3cgdG8gd29yayB3aXRoIHRoZW0uIFdoYXQgZG8geW91IHRoaW5rPw0KPiANCj4gSG0sIGlu
IHdoYXQgd2F5IHdvdWxkIHRoYXQgbWFrZSB0aGluZ3Mgc2ltcGxlcj8NCj4gDQoNClRoaXMgcXVl
c3Rpb24gd2FzIGluIG15IG1pbmQgd2hpbGUgSSd2ZSBmaW5pc2hpbmcgdGhpcyBwYXJhZ3JhcGgp
IEF0IGxlYXN0IHN1Y2ggcmVzdHJpY3Rpb24gYW5zd2VyIHRoZSBxdWVzdGlvbiwgd2hlcmUNCnNo
b3VsZCBuZXcgZmlsdGVycyBiZSBhZGRlZDogYmVsb3cgb3IgdW5kZXIgaW1wbGljaXQgZmlsdGVy
cy4uIFdpdGggc3VjaCByZXN0cmljdGlvbiB3ZSBhbHdheXMgY2FuIGhhdmUgb25seSBvbmUgaW1w
bGljaXQgZmlsdGVyDQpvdmVyIG5vbi1maWx0ZXIgbm9kZSwgYW5kIGFib3ZlIGl0IHNob3VsZCBi
ZSBleHBsaWNpdCBmaWx0ZXIgb3Igbm9uLWZpbHRlciBub2RlLiBCdXQgdGhpcyBuZWVkIGh1Z2Ug
d29yayB0byBiZSBkb25lIHdpdGggc21hbGwNCmJlbmVmaXQsIHNvLCBmb3JnZXQgaXQpDQoNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

