Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B95FC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD3C2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XFWESVW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD3C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJ7e-0001vk-8J
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44050)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJ6d-0001QV-Cw
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heJ6a-0001Eu-A6
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:57:27 -0400
Received: from mail-eopbgr140125.outbound.protection.outlook.com
 ([40.107.14.125]:53511 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heJ6O-0000q3-UM; Fri, 21 Jun 2019 08:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL0DYOE84VZS27eJfdIBlrfLZKZQu3WT4BIkn1/6BW8=;
 b=XFWESVW3D7A+FldLamxrfe/GSsBgr42iwbXF5vt2SVG/DKlz8k0QSQxk/J45QZdVyp004H+QLPGAxHX+0uVMldieGL3QeqTQGWvZdSneJwcy2+kJjw5iLOqCyr9Se6kDPDUPYQhftLuhShftH9Gr4uruiUi30nvJUY0SeSTan3Q=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4476.eurprd08.prod.outlook.com (20.179.43.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Fri, 21 Jun 2019 12:57:07 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 12:57:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH 07/12] block/backup: add 'always' bitmap sync policy
Thread-Index: AQHVJwQUASyLXkk6xUaH3k5xNAqj4qamE50A
Date: Fri, 21 Jun 2019 12:57:07 +0000
Message-ID: <8fde15e1-9693-9e46-b5c8-0f657b1eebed@virtuozzo.com>
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
In-Reply-To: <20190620010356.19164-8-jsnow@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0057.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::46)
 To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621155704177
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2318c7f0-e948-4d01-e06b-08d6f647f6e2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4476; 
x-ms-traffictypediagnostic: DBBPR08MB4476:
x-microsoft-antispam-prvs: <DBBPR08MB4476E708387D18C8A0BABC95C1E70@DBBPR08MB4476.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(376002)(396003)(136003)(346002)(51444003)(199004)(189003)(7416002)(25786009)(305945005)(14444005)(81166006)(6512007)(8676002)(31696002)(2616005)(102836004)(6506007)(110136005)(256004)(99286004)(66556008)(4326008)(6116002)(2906002)(54906003)(478600001)(66946007)(14454004)(71190400001)(3846002)(6246003)(5660300002)(76176011)(6486002)(36756003)(229853002)(71200400001)(386003)(64756008)(73956011)(66476007)(446003)(81156014)(7736002)(476003)(8936002)(86362001)(66066001)(53936002)(6436002)(52116002)(66446008)(11346002)(2201001)(2501003)(186003)(486006)(31686004)(316002)(26005)(68736007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4476;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jPtZENoA7zdozmxaBI+wpuSjpmuvAahDWeJewVnQHWRbRU2Qgb++PUC5gfL0K36aecVGPnslW00l+ycgDXa9D5Mt5R7eRkE0qd8OuEzVJnVg6kQTDpl01axFkJEjmopQxmroeC7s45Afnf/FBr4O2gUwBez2BFjRQO8RzQIgkAWgBpUF6v84GMvDYEMkd4wVKlzuWtpQyepgTHnSaZlxr0UgTRl4hFrAPNKdT6TTg2BgG7VxtWOLgCH4Z+ev/h9AkJNeGqkVpimwLoeC0Sv33tOQPiozj4YaR9/A3nEmbSg/mUtCYNjtFpvjYSyawQhm+2UbrZyi6PK6nzU4LCFolLTPwNq5ynQn6ptGVzV7Tvg1ui64TG2UstONdXDL0RTV+4rwrc3T22tVe+jdOKRsh/j0raBtx37rDpdvq+tX0A0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB4B513A6A479548904D34D690E0AE3A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2318c7f0-e948-4d01-e06b-08d6f647f6e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 12:57:07.2783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4476
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.125
Subject: Re: [Qemu-devel] [PATCH 07/12] block/backup: add 'always' bitmap
 sync policy
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDYuMjAxOSA0OjAzLCBKb2huIFNub3cgd3JvdGU6DQo+IFRoaXMgYWRkcyBhbiAiYWx3YXlz
IiBwb2xpY3kgZm9yIGJpdG1hcCBzeW5jaHJvbml6YXRpb24uIFJlZ2FyZGxlc3Mgb2YgaWYNCj4g
dGhlIGpvYiBzdWNjZWVkcyBvciBmYWlscywgdGhlIGJpdG1hcCBpcyAqYWx3YXlzKiBzeW5jaHJv
bml6ZWQuIFRoaXMgbWVhbnMNCj4gdGhhdCBmb3IgYmFja3VwcyB0aGF0IGZhaWwgcGFydC13YXkg
dGhyb3VnaCwgdGhlIGJpdG1hcCByZXRhaW5zIGEgcmVjb3JkIG9mDQo+IHdoaWNoIHNlY3RvcnMg
bmVlZCB0byBiZSBjb3BpZWQgb3V0IHRvIGFjY29tcGxpc2ggYSBuZXcgYmFja3VwIHVzaW5nIHRo
ZQ0KPiBvbGQsIHBhcnRpYWwgcmVzdWx0Lg0KPiANCj4gSW4gZWZmZWN0LCB0aGlzIGFsbG93cyB1
cyB0byAicmVzdW1lIiBhIGZhaWxlZCBiYWNrdXA7IGhvd2V2ZXIgdGhlIG5ldyBiYWNrdXANCj4g
d2lsbCBiZSBmcm9tIHRoZSBuZXcgcG9pbnQgaW4gdGltZSwgc28gaXQgaXNuJ3QgYSAicmVzdW1l
IiBhcyBtdWNoIGFzIGl0IGlzDQo+IGFuICJpbmNyZW1lbnRhbCByZXRyeS4iIFRoaXMgY2FuIGJl
IHVzZWZ1bCBpbiB0aGUgY2FzZSBvZiBleHRyZW1lbHkgbGFyZ2UNCj4gYmFja3VwcyB0aGF0IGZh
aWwgY29uc2lkZXJhYmx5IHRocm91Z2ggdGhlIG9wZXJhdGlvbiBhbmQgd2UnZCBsaWtlIHRvIG5v
dCB3YXN0ZQ0KPiB0aGUgd29yayB0aGF0IHdhcyBhbHJlYWR5IHBlcmZvcm1lZC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgcWFw
aS9ibG9jay1jb3JlLmpzb24gfCAgNSArKysrLQ0KPiAgIGJsb2NrL2JhY2t1cC5jICAgICAgIHwg
MTAgKysrKysrLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9xYXBpL2Jsb2NrLWNvcmUuanNvbiBiL3Fh
cGkvYmxvY2stY29yZS5qc29uDQo+IGluZGV4IDAzMzJkY2FhYmMuLjU4ZDI2N2YxZjUgMTAwNjQ0
DQo+IC0tLSBhL3FhcGkvYmxvY2stY29yZS5qc29uDQo+ICsrKyBiL3FhcGkvYmxvY2stY29yZS5q
c29uDQo+IEBAIC0xMTQzLDYgKzExNDMsOSBAQA0KPiAgICMgQW4gZW51bWVyYXRpb24gb2YgcG9z
c2libGUgYmVoYXZpb3JzIGZvciB0aGUgc3luY2hyb25pemF0aW9uIG9mIGEgYml0bWFwDQo+ICAg
IyB3aGVuIHVzZWQgZm9yIGRhdGEgY29weSBvcGVyYXRpb25zLg0KPiAgICMNCj4gKyMgQGFsd2F5
czogVGhlIGJpdG1hcCBpcyBhbHdheXMgc3luY2hyb25pemVkIHdpdGggcmVtYWluaW5nIGJsb2Nr
cyB0byBjb3B5LA0KPiArIyAgICAgICAgICB3aGV0aGVyIG9yIG5vdCB0aGUgb3BlcmF0aW9uIGhh
cyBjb21wbGV0ZWQgc3VjY2Vzc2Z1bGx5IG9yIG5vdC4NCg0KSG1tLCBub3cgSSB0aGluayB0aGF0
ICdhbHdheXMnIHNvdW5kcyBhIGJpdCBsaWtlICdyZWFsbHkgYWx3YXlzJyBpLmUuIGR1cmluZyBi
YWNrdXANCnRvbywgd2hpY2ggaXMgY29uZnVzaW5nLi4gQnV0IEkgZG9uJ3QgaGF2ZSBiZXR0ZXIg
c3VnZ2VzdGlvbi4NCg0KPiArIw0KPiAgICMgQGNvbmRpdGlvbmFsOiBUaGUgYml0bWFwIGlzIG9u
bHkgc3luY2hyb25pemVkIHdoZW4gdGhlIG9wZXJhdGlvbiBpcyBzdWNjZXNzdWwuDQo+ICAgIyAg
ICAgICAgICAgICAgIFRoaXMgaXMgdXNlZnVsIGZvciBJbmNyZW1lbnRhbCBzZW1hbnRpY3MuDQo+
ICAgIw0KPiBAQCAtMTE1Myw3ICsxMTU2LDcgQEANCj4gICAjIFNpbmNlOiA0LjENCj4gICAjIw0K
PiAgIHsgJ2VudW0nOiAnQml0bWFwU3luY01vZGUnLA0KPiAtICAnZGF0YSc6IFsnY29uZGl0aW9u
YWwnLCAnbmV2ZXInXSB9DQo+ICsgICdkYXRhJzogWydhbHdheXMnLCAnY29uZGl0aW9uYWwnLCAn
bmV2ZXInXSB9DQo+ICAgDQo+ICAgIyMNCj4gICAjIEBNaXJyb3JDb3B5TW9kZToNCj4gZGlmZiAt
LWdpdCBhL2Jsb2NrL2JhY2t1cC5jIGIvYmxvY2svYmFja3VwLmMNCj4gaW5kZXggNjI3ZjcyNGI2
OC4uYmViMjA3ODY5NiAxMDA2NDQNCj4gLS0tIGEvYmxvY2svYmFja3VwLmMNCj4gKysrIGIvYmxv
Y2svYmFja3VwLmMNCj4gQEAgLTI2NiwxNSArMjY2LDE3IEBAIHN0YXRpYyB2b2lkIGJhY2t1cF9j
bGVhbnVwX3N5bmNfYml0bWFwKEJhY2t1cEJsb2NrSm9iICpqb2IsIGludCByZXQpDQo+ICAgICAg
IEJsb2NrRHJpdmVyU3RhdGUgKmJzID0gYmxrX2JzKGpvYi0+Y29tbW9uLmJsayk7DQo+ICAgDQo+
ICAgICAgIGlmIChyZXQgPCAwIHx8IGpvYi0+Yml0bWFwX21vZGUgPT0gQklUTUFQX1NZTkNfTU9E
RV9ORVZFUikgew0KPiAtICAgICAgICAvKiBGYWlsdXJlLCBvciB3ZSBkb24ndCB3YW50IHRvIHN5
bmNocm9uaXplIHRoZSBiaXRtYXAuDQo+IC0gICAgICAgICAqIE1lcmdlIHRoZSBzdWNjZXNzb3Ig
YmFjayBpbnRvIHRoZSBwYXJlbnQsIGRlbGV0ZSBub3RoaW5nLiAqLw0KPiArICAgICAgICAvKiBG
YWlsdXJlLCBvciB3ZSBkb24ndCB3YW50IHRvIHN5bmNocm9uaXplIHRoZSBiaXRtYXAuICovDQo+
ICsgICAgICAgIGlmIChqb2ItPmJpdG1hcF9tb2RlID09IEJJVE1BUF9TWU5DX01PREVfQUxXQVlT
KSB7DQo+ICsgICAgICAgICAgICBiZHJ2X2RpcnR5X2JpdG1hcF9jbGFpbShqb2ItPnN5bmNfYml0
bWFwLCAmam9iLT5jb3B5X2JpdG1hcCk7DQo+ICsgICAgICAgIH0NCj4gKyAgICAgICAgLyogTWVy
Z2UgdGhlIHN1Y2Nlc3NvciBiYWNrIGludG8gdGhlIHBhcmVudC4gKi8NCj4gICAgICAgICAgIGJt
ID0gYmRydl9yZWNsYWltX2RpcnR5X2JpdG1hcChicywgam9iLT5zeW5jX2JpdG1hcCwgTlVMTCk7
DQoNCkhtbSBnb29kLCBpdCBzaG91bGQgd29yay4gSXQncyBhIGxvdCBtb3JlIHRyaWNreSwgdGhh
biBqdXN0DQoic3luY2hyb25pemVkIHdpdGggcmVtYWluaW5nIGJsb2NrcyB0byBjb3B5IiwgYnV0
IEknbSBub3Qgc3VyZSB0aGUgd2UgbmVlZCBtb3JlIGRldGFpbHMgaW4NCnNwZWMuDQoNCldoYXQg
d2UgaGF2ZSBpbiBiYWNrdXA/IFNvLCBmcm9tIG9uZSBoYW5kIHdlIGhhdmUgYW4gaW5jcmVtZW50
YWwgYmFja3VwLCBhbmQgYSBiaXRtYXAsIGNvdW50aW5nIGZyb20gaXQuDQpPbiB0aGUgb3RoZXIg
aGFuZCBpdCdzIG5vdCBub3JtYWwgaW5jcmVtZW50YWwgYmFja3VwLCBhcyBpdCBkb24ndCBjb3Jy
ZXNwb25kIHRvIGFueSB2YWxpZCBzdGF0ZSBvZiB2bSBkaXNrLA0KYW5kIGl0IG1heSBiZSB1c2Vk
IG9ubHkgYXMgYSBiYWNraW5nIGluIGEgY2hhaW4gb2YgZnVydGhlciBzdWNjZXNzZnVsIGluY3Jl
bWVudGFsIGJhY2t1cCwgeWVzPw0KDQpBbmQgdGhlbiBJIHRoaW5rOiB3aXRoIHRoaXMgbW9kZSB3
ZSBjYW4gbm90IHN0b3Agb24gZmlyc3QgZXJyb3IsIGJ1dCBpZ25vcmUgaXQsIGp1c3QgbGVhdmlu
ZyBkaXJ0eSBiaXQgZm9yDQpyZXN1bHRpbmcgYml0bWFwLi4gV2UgaGF2ZSBCTE9DS0RFVl9PTl9F
UlJPUl9JR05PUkUsIHdoaWNoIG1heSBiZSB1c2VkIHRvIGFjaGlldmUgaXQsIGJ1dCBzZWVtcyBp
dCBkb24ndA0Kd29yayBhcyBleHBlY3RlZCwgYXMgaW4gYmFja3VwX2xvb3AoKSB3ZSByZXRyeSBv
cGVyYXRpb24gaWYgcmV0IDwgMCBhbmQgIGFjdGlvbiAhPSBCTE9DS19FUlJPUl9BQ1RJT05fUkVQ
T1JULg0KDQpBbmQgYW5vdGhlciB0aG91Z2h0OiBjYW4gdXNlciB0YWtlIGEgZGVjaXNpb24gb2Yg
ZGlzY2FyZGluZyAobGlrZSBDT05ESVRJT05BTCkgb3Igc2F2aW5nIGluIGJhY2tpbmcgY2hhaW4g
KGxpa2UNCkFMV0FZUykgZmFpbGVkIGJhY2t1cCByZXN1bHQgX2FmdGVyXyBiYWNrdXAgam9iIGNv
bXBsZXRlPyBGb3IgZXhhbXBsZSwgZm9yIHNtYWxsIHJlc3VsdGluZyBiYWNrdXAgaXQgbWF5IGJl
DQpiZXR0ZXIgdG8gZGlzY2FyZCBpdCBhbmQgZm9yIGxhcmdlIC0gdG8gc2F2ZS4NCldpbGwgaXQg
d29yayBpZiB3ZSBzdGFydCBqb2Igd2l0aCBBTFdBWVMgbW9kZSBhbmQgYXV0b2NvbXBsZXRlID0g
ZmFsc2UsIHRoZW4gb24gZmFpbCB3ZSBjYW4gbG9vayBhdCBqb2IgcHJvZ3Jlc3MsDQphbmQgaWYg
aXQgaXMgc21hbGwgd2UgY2FuY2VsIGpvYiwgb3RoZXJ3aXNlIGNhbGwgY29tcGxldGU/IE9yIHN0
b3AsIGJsb2NrLWpvYi1jb21wbGV0ZSB3aWxsIG5vdCB3b3JrIHdpdGggZmFpbHVyZQ0Kc2NlbmFy
aW9zPyBUaGVuIHdlIGhhdmUgdG8gc2V0IEJMT0NLREVWX09OX0VSUk9SX0lHTk9SRSwgYW5kIG9u
IGZpcnN0IGVycm9yIGV2ZW50IGRlY2lkZSwgY2FuY2VsIG9yIG5vdD8gQnV0IHdlDQpjYW4gb25s
eSBjYW5jZWwgb3IgY29udGludWUuLg0KDQpIbW0uIENhbmNlbC4gU28gb24gY2FuY2VsIGFuZCBh
Ym9ydCB5b3Ugc3luY2hyb25pemUgYml0bWFwIHRvbz8gU2VlbXMgaW4gYmFkIHJlbGF0aW9uIHdp
dGggd2hhdCBjYW5jZWwgc2hvdWxkIGRvLA0KYW5kIGluIHRyYW5zYWN0aW9ucyBpbiBnZW5lcmFs
Li4uDQoNCg0KPiAtICAgICAgICBhc3NlcnQoYm0pOw0KPiAgICAgICB9IGVsc2Ugew0KPiAgICAg
ICAgICAgLyogRXZlcnl0aGluZyBpcyBmaW5lLCBkZWxldGUgdGhpcyBiaXRtYXAgYW5kIGluc3Rh
bGwgdGhlIGJhY2t1cC4gKi8NCj4gICAgICAgICAgIGJtID0gYmRydl9kaXJ0eV9iaXRtYXBfYWJk
aWNhdGUoYnMsIGpvYi0+c3luY19iaXRtYXAsIE5VTEwpOw0KPiAtICAgICAgICBhc3NlcnQoYm0p
Ow0KPiAgICAgICB9DQo+ICsgICAgYXNzZXJ0KGJtKTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGlj
IHZvaWQgYmFja3VwX2NvbW1pdChKb2IgKmpvYikNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

