Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27817C46477
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E263213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FKEP0PWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E263213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59436 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdGl1-0003IN-WB
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46733)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdFWI-0008CJ-TQ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdFVz-0002Qy-6o
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:55:34 -0400
Received: from mail-db3eur04on0724.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::724]:41348
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdFVv-0002Co-34; Tue, 18 Jun 2019 10:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9gADZ9X/o1Iu5gozbcrHf9El4lzSjWtIEFFofAwk1w=;
 b=FKEP0PWXWAyHPTq+AIoayjYZKSk1+3x1plSG6hgfX83m/L36113e0fRFMPGOmkB7YCDJRdOs+hh4x7KGdp7I6xgKUjUs9U9oeKCBpVmFRtplOcctD+WzJRvXOwEvqkHWEqiqADjWMoye0XSPc3W3LDixTBAUiLuhAvADww+lRi0=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4316.eurprd08.prod.outlook.com (20.179.41.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 14:55:04 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 14:55:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 25/42] mirror: Deal with filters
Thread-Index: AQHVIWvAOulVgEmCL0SDlzLUOSLYKaahbDiAgAAacgCAAAIbAA==
Date: Tue, 18 Jun 2019 14:55:04 +0000
Message-ID: <dbf0d6b9-3cd1-90ab-ea4b-ceb4fd1b4437@virtuozzo.com>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-26-mreitz@redhat.com>
 <ffaaf50e-ea9c-a75e-5868-7322d06b4062@virtuozzo.com>
 <f21fb0b0-3cee-dc4d-355c-ae197f071802@redhat.com>
In-Reply-To: <f21fb0b0-3cee-dc4d-355c-ae197f071802@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::15) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618175502484
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e14678d-0120-4b51-496e-08d6f3fcf25c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4316; 
x-ms-traffictypediagnostic: DBBPR08MB4316:
x-microsoft-antispam-prvs: <DBBPR08MB4316437FB03D8E3988DC1CD8C1EA0@DBBPR08MB4316.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(39850400004)(376002)(136003)(366004)(199004)(189003)(14444005)(26005)(71200400001)(8676002)(81166006)(2906002)(186003)(71190400001)(68736007)(6246003)(81156014)(4326008)(8936002)(6486002)(6436002)(2616005)(476003)(229853002)(486006)(66946007)(64756008)(66446008)(73956011)(66556008)(66476007)(7736002)(305945005)(25786009)(36756003)(446003)(11346002)(31686004)(53546011)(6506007)(102836004)(386003)(2501003)(99286004)(76176011)(52116002)(5660300002)(6512007)(478600001)(86362001)(14454004)(6116002)(3846002)(66066001)(256004)(53936002)(316002)(31696002)(54906003)(110136005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4316;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pOJiPTyd80GC6FglGqOPBqGrRiOOUpn86JInfmMdG5yK/tlteYb44McZUHtSD8rup2VPf/O2Cc69rHO+4ZqackKiQAX9g9BbCzy0ligA0WxDkeh8qxpxe1pEAw6CnrRP0eFG5IefVpJM8p0bmLQC/qXO9FiTMF9emx6vhL4NXaSnPUFmpADSoJneg5o8TCk5B55wnY3+/+OAeDI3ioKud2ON06LOCvxZba40rRMwO5BqKnQak86N1THBysoqh0ZAmE0QhVLf71Zq2VR3WHVAMkRSesbScVo9lxI5gr9Hc6ZAFBVye7Lx+tKF0YgFx+vVPHKk/OMRMQ9763j3q9nX6FUsGlau/D60aPVSWmj1lNIAjQmQwWIy86MeOHWPJjSgwr/g6UKb3EqYRnwDgtF7T+d9iX2xSPLp+i2Hcfh8zq4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B6D2727E5941F4295ED51EEE613E341@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e14678d-0120-4b51-496e-08d6f3fcf25c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 14:55:04.5534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4316
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0c::724
Subject: Re: [Qemu-devel] [PATCH v5 25/42] mirror: Deal with filters
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

MTguMDYuMjAxOSAxNzo0NywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxOC4wNi4xOSAxNToxMiwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA2LjIwMTkgMTowOSwg
TWF4IFJlaXR6IHdyb3RlOg0KPj4+IFRoaXMgaW5jbHVkZXMgc29tZSBwZXJtaXNzaW9uIGxpbWl0
aW5nIChmb3IgZXhhbXBsZSwgd2Ugb25seSBuZWVkIHRvDQo+Pj4gdGFrZSB0aGUgUkVTSVpFIHBl
cm1pc3Npb24gZm9yIGFjdGl2ZSBjb21taXRzIHdoZXJlIHRoZSBiYXNlIGlzIHNtYWxsZXINCj4+
PiB0aGFuIHRoZSB0b3ApLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVp
dHpAcmVkaGF0LmNvbT4NCj4+DQo+PiBvaG0sIHVuZm9ydHVuYXRlbHkgSSdtIGZhciBmcm9tIGtu
b3dpbmcgYmxvY2svbWlycm9yIG1lY2hhbmljcyBhbmQgaW50ZXJmYWNlcyA6KC4NCj4+DQo+PiBz
dGlsbCBzb21lIGNvbW1lbnRzIGJlbG93Lg0KPj4NCj4+PiAtLS0NCj4+PiAgICBibG9jay9taXJy
b3IuYyB8IDExMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tDQo+Pj4gICAgYmxvY2tkZXYuYyAgICAgfCAgNDcgKysrKysrKysrKysrKysrKystLS0tDQo+
Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAxMjQgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0p
DQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svbWlycm9yLmMgYi9ibG9jay9taXJyb3IuYw0K
Pj4+IGluZGV4IDRmYThmNTdjODAuLjNkNzY3ZTMwMzAgMTAwNjQ0DQo+Pj4gLS0tIGEvYmxvY2sv
bWlycm9yLmMNCj4+PiArKysgYi9ibG9jay9taXJyb3IuYw0KPj4+IEBAIC02NjAsOCArNjYwLDEw
IEBAIHN0YXRpYyBpbnQgbWlycm9yX2V4aXRfY29tbW9uKEpvYiAqam9iKQ0KPj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpOw0KPj4+ICAgICAgICBpZiAoIWFi
b3J0ICYmIHMtPmJhY2tpbmdfbW9kZSA9PSBNSVJST1JfU09VUkNFX0JBQ0tJTkdfQ0hBSU4pIHsN
Cj4+PiAgICAgICAgICAgIEJsb2NrRHJpdmVyU3RhdGUgKmJhY2tpbmcgPSBzLT5pc19ub25lX21v
ZGUgPyBzcmMgOiBzLT5iYXNlOw0KPj4+IC0gICAgICAgIGlmIChiYWNraW5nX2JzKHRhcmdldF9i
cykgIT0gYmFja2luZykgew0KPj4+IC0gICAgICAgICAgICBiZHJ2X3NldF9iYWNraW5nX2hkKHRh
cmdldF9icywgYmFja2luZywgJmxvY2FsX2Vycik7DQo+Pj4gKyAgICAgICAgQmxvY2tEcml2ZXJT
dGF0ZSAqdW5maWx0ZXJlZF90YXJnZXQgPSBiZHJ2X3NraXBfcndfZmlsdGVycyh0YXJnZXRfYnMp
Ow0KPj4+ICsNCj4+PiArICAgICAgICBpZiAoYmRydl9maWx0ZXJlZF9jb3dfYnModW5maWx0ZXJl
ZF90YXJnZXQpICE9IGJhY2tpbmcpIHsNCj4+PiArICAgICAgICAgICAgYmRydl9zZXRfYmFja2lu
Z19oZCh1bmZpbHRlcmVkX3RhcmdldCwgYmFja2luZywgJmxvY2FsX2Vycik7DQo+Pj4gICAgICAg
ICAgICAgICAgaWYgKGxvY2FsX2Vycikgew0KPj4+ICAgICAgICAgICAgICAgICAgICBlcnJvcl9y
ZXBvcnRfZXJyKGxvY2FsX2Vycik7DQo+Pj4gICAgICAgICAgICAgICAgICAgIHJldCA9IC1FUEVS
TTsNCj4+PiBAQCAtNzExLDcgKzcxMyw3IEBAIHN0YXRpYyBpbnQgbWlycm9yX2V4aXRfY29tbW9u
KEpvYiAqam9iKQ0KPj4+ICAgICAgICBibG9ja19qb2JfcmVtb3ZlX2FsbF9iZHJ2KGJqb2IpOw0K
Pj4+ICAgICAgICBiZHJ2X2NoaWxkX3RyeV9zZXRfcGVybShtaXJyb3JfdG9wX2JzLT5iYWNraW5n
LCAwLCBCTEtfUEVSTV9BTEwsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZl
cnJvcl9hYm9ydCk7DQo+Pj4gLSAgICBiZHJ2X3JlcGxhY2Vfbm9kZShtaXJyb3JfdG9wX2JzLCBi
YWNraW5nX2JzKG1pcnJvcl90b3BfYnMpLCAmZXJyb3JfYWJvcnQpOw0KPj4+ICsgICAgYmRydl9y
ZXBsYWNlX25vZGUobWlycm9yX3RvcF9icywgbWlycm9yX3RvcF9icy0+YmFja2luZy0+YnMsICZl
cnJvcl9hYm9ydCk7DQo+Pj4gICAgDQo+Pj4gICAgICAgIC8qIFdlIGp1c3QgY2hhbmdlZCB0aGUg
QkRTIHRoZSBqb2IgQkIgcmVmZXJzIHRvICh3aXRoIGVpdGhlciBvciBib3RoIG9mIHRoZQ0KPj4+
ICAgICAgICAgKiBiZHJ2X3JlcGxhY2Vfbm9kZSgpIGNhbGxzKSwgc28gc3dpdGNoIHRoZSBCQiBi
YWNrIHNvIHRoZSBjbGVhbnVwIGRvZXMNCj4+PiBAQCAtNzU3LDYgKzc1OSw3IEBAIHN0YXRpYyBp
bnQgY29yb3V0aW5lX2ZuIG1pcnJvcl9kaXJ0eV9pbml0KE1pcnJvckJsb2NrSm9iICpzKQ0KPj4+
ICAgIHsNCj4+PiAgICAgICAgaW50NjRfdCBvZmZzZXQ7DQo+Pj4gICAgICAgIEJsb2NrRHJpdmVy
U3RhdGUgKmJhc2UgPSBzLT5iYXNlOw0KPj4+ICsgICAgQmxvY2tEcml2ZXJTdGF0ZSAqZmlsdGVy
ZWRfYmFzZTsNCj4+PiAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnMgPSBzLT5taXJyb3JfdG9w
X2JzLT5iYWNraW5nLT5iczsNCj4+PiAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqdGFyZ2V0X2Jz
ID0gYmxrX2JzKHMtPnRhcmdldCk7DQo+Pj4gICAgICAgIGludCByZXQ7DQo+Pj4gQEAgLTc5NSw2
ICs3OTgsOSBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBtaXJyb3JfZGlydHlfaW5pdChNaXJy
b3JCbG9ja0pvYiAqcykNCj4+PiAgICAgICAgICAgIHMtPmluaXRpYWxfemVyb2luZ19vbmdvaW5n
ID0gZmFsc2U7DQo+Pj4gICAgICAgIH0NCj4+PiAgICANCj4+PiArICAgIC8qIFdpbGwgYmUgTlVM
TCBpZiBAYmFzZSBpcyBub3QgaW4gQGJzJ3MgY2hhaW4gKi8NCj4+DQo+PiBTaG91bGQgd2UgYXNz
ZXJ0IHRoYXQgbm90IE5VTEw/DQo+IA0KPiBXZWxsLCBidXQgaXQgY2FuIGJlIE5VTEwuICBJdCBp
cyBvbmx5IG5vbi1OVUxMIGZvciBhY3RpdmUgY29tbWl0Lg0KPiANCj4+IEhtbSwgc28gdGhpcyBp
cyB0aGUgd2F5IHRvICJza2lwIGZpbHRlcnMgcmV2ZXJzZSBmcm9tIHRoZSBiYXNlIiwgeWVzPyBX
b3J0aCBhZGQgYSBjb21tZW50Pw0KPiANCj4gV2UgbmVlZCB0aGlzIGJlY2F1c2UgYmRydl9pc19h
bGxvY2F0ZWQoKSB3aWxsIHJlcG9ydCBldmVyeXRoaW5nIGFzDQo+IGFsbG9jYXRlZCBpbiBhIGZp
bHRlciBpZiBpdCBpcyBhbGxvY2F0ZWQgaW4gaXRzIGZpbHRlcmVkIGNoaWxkLiAgU28gaWYNCj4g
d2UgdXNlIEBiYXNlIGluIGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlKCkgYW5kIHRoZXJlIGlzIGEg
ZmlsdGVyIG9uIHRvcA0KPiBvZiBpdCwgYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUoKSB3aWxsIHJl
cG9ydCBldmVyeXRoaW5nIGFzIGFsbG9jYXRlZA0KPiB0aGF0IGlzIGFsbG9jYXRlZCBpbiBAYmFz
ZSAod2hpY2ggd2UgZG8gbm90IHdhbnQpLg0KPiANCj4gVGhlcmVmb3IsIHdlIG5lZWQgdG8gZ28g
dG8gdGhlIHRvcG1vc3QgUi9XIGZpbHRlciBvbiB0b3Agb2YgQGJhc2UsIHNvDQo+IHRoYXQgYmRy
dl9pc19hbGxvY2F0ZWRfYWJvdmUoKSBhY3R1YWxseSBzdGFydHMgYXQgdGhlIGZpcnN0IENPVyBj
aGFpbg0KPiBlbGVtZW50IGFib3ZlIEBiYXNlLg0KPiANCj4gQXMgZm9yIHRoZSBjb21tZW50LCBJ
IHRob3VnaHQgdGhlIG5hbWUg4oCcZmlsdGVyZWQgYmFzZeKAnSB3b3VsZCBzdWZmaWNlLA0KPiBi
dXQgc3VyZS4NCj4gDQo+ICjigJxAZmlsdGVyZWRfYmFzZSBpcyB0aGUgdG9wbW9zdCBub2RlIGlu
IHRoZSBAYnMtQGJhc2UgY2hhaW4gdGhhdCBpcw0KPiBjb25uZWN0ZWQgdG8gQGJhc2Ugb25seSB0
aHJvdWdoIGZpbHRlcnPigJ0gb3Igc29tZXRoaW5nOyBwbHVzIHRoZQ0KPiBleHBsYW5hdGlvbiB3
aHkgd2UgbmVlZCBpdC4pDQo+IA0KPj4+ICsgICAgZmlsdGVyZWRfYmFzZSA9IGJkcnZfZmlsdGVy
ZWRfY293X2JzKGJkcnZfZmluZF9vdmVybGF5KGJzLCBiYXNlKSk7DQo+Pj4gKw0KPj4+ICAgICAg
ICAvKiBGaXJzdCBwYXJ0LCBsb29wIG9uIHRoZSBzZWN0b3JzIGFuZCBpbml0aWFsaXplIHRoZSBk
aXJ0eSBiaXRtYXAuICAqLw0KPj4+ICAgICAgICBmb3IgKG9mZnNldCA9IDA7IG9mZnNldCA8IHMt
PmJkZXZfbGVuZ3RoOyApIHsNCj4+PiAgICAgICAgICAgIC8qIEp1c3QgdG8gbWFrZSBzdXJlIHdl
IGFyZSBub3QgZXhjZWVkaW5nIGludCBsaW1pdC4gKi8NCj4gDQo+IFsuLi5dDQo+IA0KPj4+IEBA
IC0xNTgzLDE1ICsxNTkwLDQyIEBAIHN0YXRpYyB2b2lkIG1pcnJvcl9zdGFydF9qb2IoY29uc3Qg
Y2hhciAqam9iX2lkLCBCbG9ja0RyaXZlclN0YXRlICpicywNCj4+PiAgICAgICAgICogSW4gdGhl
IGNhc2Ugb2YgYWN0aXZlIGNvbW1pdCwgdGhpbmdzIGxvb2sgYSBiaXQgZGlmZmVyZW50LCB0aG91
Z2gsDQo+Pj4gICAgICAgICAqIGJlY2F1c2UgdGhlIHRhcmdldCBpcyBhbiBhbHJlYWR5IHBvcHVs
YXRlZCBiYWNraW5nIGZpbGUgaW4gYWN0aXZlIHVzZS4NCj4+PiAgICAgICAgICogV2UgY2FuIGFs
bG93IGFueXRoaW5nIGV4Y2VwdCByZXNpemUgdGhlcmUuKi8NCj4+PiArDQo+Pj4gKyAgICB0YXJn
ZXRfcGVybXMgPSBCTEtfUEVSTV9XUklURTsNCj4+PiArICAgIHRhcmdldF9zaGFyZWRfcGVybXMg
PSBCTEtfUEVSTV9XUklURV9VTkNIQU5HRUQ7DQo+Pj4gKw0KPj4+ICAgICAgICB0YXJnZXRfaXNf
YmFja2luZyA9IGJkcnZfY2hhaW5fY29udGFpbnMoYnMsIHRhcmdldCk7DQo+Pg0KPj4gZG9uJ3Qg
eW91IHdhbnQgc2tpcCBmaWx0ZXJzIGhlcmU/IGFjdHVhbCB0YXJnZXQgbm9kZSBtYXkgYmUgaW4g
YmFja2luZyBjaGFpbiwgYnV0IGhhcyBzZXBhcmF0ZQ0KPj4gZmlsdGVycyBhYm92ZSBpdA0KPiAN
Cj4gSSBkb27igJl0IHF1aXRlIHVuZGVyc3RhbmQuICBiZHJ2X2NoYWluX2NvbnRhaW5zKCkgaXRl
cmF0ZXMgb3ZlciB0aGUNCj4gZmlsdGVyIGNoYWluLCBzbyBpdCBzaG91bGRu4oCZdCBtYXR0ZXIg
d2hldGhlciB0aGVyZSBhcmUgZmlsdGVycyBhYm92ZQ0KPiB0YXJnZXQgb3Igbm90Lg0KPiANCj4g
Wy4uLl0NCg0KDQpJIGp1c3QgaW1hZ2luZSBzb21ldGhpbmcgbGlrZSB0aGlzOg0KDQpicw0KICB8
DQouLi4gIHRhcmdldCBub2RlIChpdCdzIGZpbHRlcikNCiAgfCAgLw0KICB2IHYNCmJhc2UgKHVu
ZmlsdGVyZWQgdGFyZ2V0KQ0KDQoNCj4gDQo+Pj4gQEAgLTE2NDEsMTUgKzE2NzUsMzkgQEAgc3Rh
dGljIHZvaWQgbWlycm9yX3N0YXJ0X2pvYihjb25zdCBjaGFyICpqb2JfaWQsIEJsb2NrRHJpdmVy
U3RhdGUgKmJzLA0KPj4+ICAgICAgICAvKiBJbiBjb21taXRfYWN0aXZlX3N0YXJ0KCkgYWxsIGlu
dGVybWVkaWF0ZSBub2RlcyBkaXNhcHBlYXIsIHNvDQo+Pj4gICAgICAgICAqIGFueSBqb2JzIGlu
IHRoZW0gbXVzdCBiZSBibG9ja2VkICovDQo+Pg0KPj4gaG1tLCBwcmVleGlzdGluZywgaXQgcy9q
b2JzL25vZGVzLw0KPiANCj4gSSB0aGluayB0aGUgaWRlYSB3YXMgdGhhdCBubyBvdGhlciBqb2Jz
IG1heSBiZSBydW4gb24gaW50ZXJtZWRpYXRlDQo+IG5vZGVzLiAgKEJ1dCBieSBub3cgaXTigJlz
IG5vIGxvbmdlciBqdXN0IGFib3V0IGpvYnMsIHNvIHllcywgc2hvdWxkIGJlDQo+IHMvam9icy9u
b2Rlcy8uICBJIGRvbuKAmXQga25vdyB3aGV0aGVyIEkgc2hvdWxkIHNxdWVlemUgdGhhdCBpbiBo
ZXJlLCB0aG91Z2guKQ0KPiANCj4gTWF4DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

