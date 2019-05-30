Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4C0C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 14:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B56D25B28
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 14:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z5zwGA/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B56D25B28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWMER-0007RG-9E
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 10:40:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWMDA-0006nK-Bs
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hWMD8-0005BQ-VL
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:39:20 -0400
Received: from mail-eopbgr60094.outbound.protection.outlook.com
	([40.107.6.94]:3710
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hWMD5-00058Q-E0; Thu, 30 May 2019 10:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=2GJ1vSYuh+n/Jv1lKNbHoPfRuiy2b84ELnQyuTW2AoI=;
	b=Z5zwGA/g+8lY3Ou1RstSwqaeORehnTca167Ha6Wdw9oa5BzP7H/FIaa4884QOHyme96SmK9/5A6qwKyGw7Eg8lImLN43oyE4ZAzwiGAUpug5X0Dyx/b9Mfg3yacf2+U+bofpyFoEH85kXDUpTMhJUrVNCcsVwuWKgaRXWQQJAVo=
Received: from DB7PR08MB2972.eurprd08.prod.outlook.com (52.134.109.150) by
	DB7PR08MB3324.eurprd08.prod.outlook.com (52.134.111.143) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.18; Thu, 30 May 2019 14:39:13 +0000
Received: from DB7PR08MB2972.eurprd08.prod.outlook.com
	([fe80::e5eb:4576:5a22:7f82]) by
	DB7PR08MB2972.eurprd08.prod.outlook.com
	([fe80::e5eb:4576:5a22:7f82%7]) with mapi id 15.20.1943.016;
	Thu, 30 May 2019 14:39:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/3] block/qcow2-bitmap: rewrite bitmap
	reopening logic
Thread-Index: AQHVEX7kb+YUVuiEF0SEYwFufr/zvqaBNhAAgACjxgCAAJZXAIABIQwAgAAxcgCAAAU5AA==
Date: Thu, 30 May 2019 14:39:12 +0000
Message-ID: <a1be0624-dfb3-46bb-eb87-f80e48aa347d@virtuozzo.com>
References: <20190523154733.54944-1-vsementsov@virtuozzo.com>
	<20190523154733.54944-4-vsementsov@virtuozzo.com>
	<c63d4dae-6fa5-a47f-9aca-791f36963262@redhat.com>
	<a00207af-97f3-fd24-90a5-2860473ace17@virtuozzo.com>
	<50d29692-51df-3880-58d0-e151deae7471@redhat.com>
	<3c695d7d-0ae1-a96c-17f8-0c1c72466122@virtuozzo.com>
	<8d969ad9-976c-ad6c-f728-4e7d1028975d@redhat.com>
In-Reply-To: <8d969ad9-976c-ad6c-f728-4e7d1028975d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0025.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::38)
	To DB7PR08MB2972.eurprd08.prod.outlook.com
	(2603:10a6:5:1c::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190530173910004
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dac9fb2-d271-46de-96be-08d6e50c952b
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DB7PR08MB3324; 
x-ms-traffictypediagnostic: DB7PR08MB3324:
x-microsoft-antispam-prvs: <DB7PR08MB3324B3FC7A6E518CEF623FD4C1180@DB7PR08MB3324.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(136003)(39850400004)(366004)(346002)(376002)(52314003)(199004)(189003)(25786009)(2906002)(54906003)(4326008)(14454004)(68736007)(64756008)(73956011)(31696002)(66946007)(76176011)(3846002)(31686004)(186003)(66446008)(26005)(66476007)(229853002)(71190400001)(36756003)(66556008)(2501003)(71200400001)(110136005)(5660300002)(86362001)(14444005)(256004)(2201001)(99286004)(6486002)(66066001)(2616005)(476003)(6436002)(102836004)(52116002)(6506007)(53546011)(386003)(446003)(107886003)(8676002)(53936002)(6116002)(81166006)(478600001)(8936002)(6246003)(81156014)(316002)(305945005)(6512007)(11346002)(486006)(7736002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3324;
	H:DB7PR08MB2972.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XBOSY/bwHO08YI2ypZs0x1lCpRWeRlT9bYPWEWqy3cnrGAUX0jvc0J3BhkZgOCvKkgncl6Fb9K9drF2y/jed2YVqEN+6D29m1bPv9YylE7K/Uubfj/YjHx3QuNjLhTu8WZ9X4XtncDc3B2FCcvJhlTUy5ju+faNrOXf3rHjkT2hTW19RuPOPG8jAr4NbkPlIrWEtY54PvhUcrxAtwbocx3oHJizqsc5i3hWaHVX+O4DWF8qiOp+JYZZClF5OaoZ8WJZVnS0CE2hAD07YTRZC7eZTR+waR/qRNin8+hN9nJvcFAbChUAAapqrCn8qt6znUykI4rIiii1jOz4dieHqs7pEJxpD7KKL3wRw1PYaaWG+M6FR8uzU/q3zkcuFv2j0MOMphqAKJjmT6XZW5Vx1usASd5mhyvj64YOS6f91yTU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <268BF730BCF692499FEC8CB8C845C212@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dac9fb2-d271-46de-96be-08d6e50c952b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 14:39:12.9820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3324
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.94
Subject: Re: [Qemu-devel] [PATCH 3/3] block/qcow2-bitmap: rewrite bitmap
 reopening logic
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
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MzAuMDUuMjAxOSAxNzoyMCwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gT24gNS8zMC8xOSA0OjIz
IEFNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMjkuMDUuMjAxOSAy
MTowOCwgSm9obiBTbm93IHdyb3RlOg0KPj4+IE9uIDUvMjkvMTkgNToxMCBBTSwgVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMjkuMDUuMjAxOSAyOjI0LCBKb2huIFNu
b3cgd3JvdGU6DQo+Pj4+PiBPbiA1LzIzLzE5IDExOjQ3IEFNLCBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+Pj4NCj4+PiBSaWdodCwgd2UndmUg
bm90IHJlYWxseSB1c2VkIHJlYWRvbmx5IGluIHRoaXMgd2F5IGJlZm9yZS4gSXQgbWFrZXMgc2Vu
c2UNCj4+PiB0byBhIHBvaW50LCBidXQgaXQncyBhIGJpdCBvZiBhIHNlbWFudGljIG92ZXJsb2Fk
IC0tIHRoZSBkaXNrIGlzDQo+Pj4gYWN0dWFsbHkgUlcgYnV0IHRoZSBiaXRtYXAgaXMgUk87IHRo
ZSBwcm9ibGVtIHRoYXQgSSBoYXZlIHdpdGggdGhpcyBpcw0KPj4+IHRoYXQgd2UgZ3VhcmQgUk8g
Yml0bWFwcyB3aXRoIGFzc2VydGlvbnMgYW5kIG5vdCBlcnJvcnMsDQo+Pg0KPj4gT29wcywgeW91
IGFyZSByaWdodC4gSSB0aG91Z2h0IHdlIGhhdmUgZXJyb3JzIGZvciBndWVzdCB3cml0ZXMgaW4g
dGhpcyBjYXNlLg0KPj4NCj4gDQo+IChJJ20gbG9va2luZyBhdCB5b3VyIHNlY29uZCBlbWFpbCkg
LS0gQWgsIHdlIGd1YXJkIHRoaXMgZWxzZXdoZXJlLg0KPiANCj4gQXNzZXJ0czoNCj4gYmRydl9z
ZXRfZGlydHlfYml0bWFwX2xvY2tlZA0KPiBiZHJ2X3Jlc2V0X2RpcnR5X2JpdG1hcF9sb2NrZWQN
Cj4gYmRydl9jbGVhcl9kaXJ0eV9iaXRtYXANCj4gYmRydl9yZXN0b3JlX2RpcnR5X2JpdG1hcA0K
PiBiZHJ2X3NldF9kaXJ0eQ0KPiANCj4gUnVudGltZSBlcnJvcnMgKHZpYSBoYXNfcmVhZG9ubHlf
Yml0bWFwcyk6DQo+IGJkcnZfYWxpZ25lZF9wd3JpdGV2DQo+IGJkcnZfY29fcGRpc2NhcmQNCj4g
DQo+IEkgZ3Vlc3MgaXQncyBPSyB0byBzZXQgcmVhZG9ubHkgaW4gdGhpcyB3YXkgdGhlbiwgYnV0
IEkgc3RpbGwgdGhpbmsgaXQncw0KPiBhIGxpdHRsZSBjb25mdXNpbmcgYW5kLCBzbyBsb25nIGFz
IHRoZSBpbi1tZW1vcnkgaW5jb25zaXN0ZW50IGJpdCBpcw0KPiBzZXQsIG5vdCBzdHJpY3RseSBu
ZWNlc3NhcnkuIChVbmxlc3MgdGhlcmUncyBzb21lIGNhc2UgSSBhbSBub3QgYXdhcmUNCj4gb2Ys
IG9yIGl0IGp1c3QgaGVscHMgdGhlIGNvZGUgdG8gYmUgbmljZXIgaW4gc29tZSB3YXksIGV0Yy4g
SSdtIG5vdA0KPiBhaW1pbmcgdG8gYmUgYSBwdXJpc3QgYWJvdXQgdGhlIHdheSB0aGlzIGZsYWcg
aXMgdXNlZC4pDQo+IA0KPj4+IHNvIGl0IHNlZW1zDQo+Pj4gZmVhc2libGUgdG8gbWUgdGhhdCB0
aGUgcmVvcGVuLXJ3IHdpbGwgc3VjY2VlZCwgYSBndWVzdCB3aWxsIHdyaXRlLCBhbmQNCj4+PiB0
aGVuIHdlJ2xsIGFib3J0IGJlY2F1c2Ugb2YgdGhlc2UgInJlYWRvbmx5IGNvcnJ1cHQiIGJpdG1h
cHMuDQo+Pj4NCj4+PiBJbiBvdGhlciB3b3Jkcywgd2UgZG9uJ3QgKnJlYWxseSogc3VwcG9ydCB0
aGUgaWRlYSBvZiBoYXZpbmcgcmVhZG9ubHkNCj4+PiBiaXRtYXBzIG9uIHJlYWR3cml0ZSBub2Rl
cy4NCj4+Pg0KPj4+IEkgdGhpbmsgZ2l2ZW4gdGhhdCB0aGlzIGlzIGFuIGVycm9yIHN0YXRlIHRv
IGJlZ2luIHdpdGggdGhhdCBzaW1wbHkNCj4+PiBtYXJraW5nIHRoZSBiaXRtYXAgYXMgaW5jb25z
aXN0ZW50IGluIG1lbW9yeSAoYW5kIHRyeWluZyB0byB3cml0ZSB0aGUNCj4+PiBJTl9VU0UgZmxh
ZyB0byBpdHMgaGVhZGVyKSBpcyBzdWZmaWNpZW50LCBpdCB3aWxsIHNraXAgYW55IG5ldyB3cml0
ZXMNCj4+PiBhbmQgcHJvaGliaXQgaXRzIHVzZSBmb3IgYW55IGJhY2t1cCBvcGVyYXRpb25zLg0K
Pj4NCj4+IFNvLCB5b3UgcHJvcG9zZSBub3QgdG8gYW5ub3kgdXNlciB0b28gbXVjaCBiZWNhdXNl
IG9mIGluY29uc2lzdGVudCBiaXRtYXBzLA0KPj4gZm9yIHdoaWNoIHdlIGNhbid0IHN5bmMgdGhl
aXIgaW5jb25zaXN0YW5jeSB0byB0aGUgaW1hZ2UuLiBNYXkgYmUgaXQncyBPSywNCj4+IGJ1dCBs
ZXQncyBzZWUgd2hhdCB3ZSBkZWNpZGUgaW4gYmxvY2stZGlzY3Vzc2lvbi4gSXQgd291bGQgYmUg
cmVhbGx5IGNvb2wNCj4+IGlmIHdlIGNhbiBtb3ZlIHRoaXMgYWxsIHRvIC5wcmVwYXJlDQo+Pg0K
PiANCj4gSG0sIEkgd291bGRuJ3Qgc2F5IGl0J3MgYWJvdXQgbm90IGFubm95aW5nIHRoZSB1c2Vy
IHRvbyBtdWNoOyB3ZSBzaG91bGQNCj4gc3RpbGwgdHJ5IHRvIHdyaXRlIHRoZSBJTl9VU0UgZmxh
ZyB0byB0aGUgaW1hZ2UgYW5kIChpZGVhbGx5KSByZXBvcnQNCj4gdGhhdCB3ZSB3ZXJlIHVuYWJs
ZSB0byBpZiB3ZSBmYWlsLg0KPiANCj4gU28gSSB0aGluayBkb2luZyB0aGVzZSB0d28gdGhpbmdz
IGlzIGVub3VnaDoNCj4gDQo+IDEuIFNldCB0aGUgaW4tbWVtb3J5IGluY29uc2lzdGVudCBmbGFn
LCB3aGljaCB3aWxsIHByb2hpYml0IHRoZSB1c2VyDQo+IGZyb20gZG9pbmcgYW55dGhpbmcgd2l0
aCB0aGlzIGJpdG1hcCBBTkQgaWdub3JlIGFsbCBmdXR1cmUgZGF0YSB3cml0ZXMNCj4gDQo+IDIu
IEF0dGVtcHQgdG8gd3JpdGUgdGhlIElOX1VTRSBmbGFnIGJhY2sgb3V0IHRvIGRpc2sgdG8gZW5z
dXJlIHRoYXQgaXQNCj4gd2lsbCBiZSBsb2FkZWQgaW5jb25zaXN0ZW50IGluIHRoZSBmdXR1cmUu
IElmIHdlIGZhaWwgdG8gZG8gc28sIHRoaXMNCj4gc2hvdWxkIGJlIGNvbnNpZGVyZWQgYSBmYXRh
bCBlcnJvci4gKFdoeSBjYW4ndCB3ZSB3cml0ZSB0byBvdXIgbm9kZT8NCj4gSXQncyBwcm9iYWJs
eSBFSU8gb3Igc29tZXRoaW5nIGZhdGFsLikNCj4gDQo+IE9mIGNvdXJzZSwgYWN0dWFsbHkgaGF2
aW5nICMyIGJlIGZhdGFsIGRlcGVuZHMgb24gcmV3b3JraW5nIHRoZSBibG9jaw0KPiBsYXllciBh
IGJpdC4NCj4gDQo+IFsuLi5dDQo+IA0KPj4+Pj4+ICsgICAgaWYgKG5lZWRfdXBkYXRlKSB7DQo+
Pj4+Pj4gKyAgICAgICAgaWYgKCFjYW5fd3JpdGUoYnMtPmZpbGUtPmJzKSkgew0KPj4+Pj4NCj4+
Pj4+IEkgZ2VudWluZWx5IGRvbid0IGtub3c6IGlzIGl0IGxlZ2l0aW1hdGUgdG8gY2hlY2sgeW91
ciBjaGlsZCdzIHdyaXRlDQo+Pj4+PiBwZXJtaXNzaW9uIGluIHRoaXMgd2F5PyB3aWxsIHdlIGFs
d2F5cyBoYXZlIGJzLT5maWxlLT5icz8NCj4+Pj4NCj4+Pj4gSG1tLi4gYnV0IHdlIGFyZSBnb2lu
ZyB0byB3cml0ZSB0byBpdCB2ZXJ5IHNvb24sIEkgdGhpbmsgaXQgc2hvdWxkIGV4aXN0Lg0KPj4+
Pg0KPj4+DQo+Pj4gQXBwYXJlbnRseSBNYXggaXMgYWRkaW5nIGEgYmRydl9zdG9yYWdlX2JzKCkg
aGVscGVyIGZvciB0aGlzIGV4YWN0DQo+Pj4gdGhpbmcsIGluIGFuIHVwY29taW5nIHBhdGNoLiBJ
IGp1c3QgZ2V0IG5lcnZvdXMgd2hlbiBJIHNlZSBkb3VibGUNCj4+PiBpbmRpcmVjdGlvbnMgPg0K
Pj4NCj4+IEhtbS4uLiBCdXQgaWYgd2UgaGF2ZSBzZXBhcmF0ZSBkYXRhIGZpbGUgZm9yIHFjb3cy
LCBiZHJ2X3N0b3JhZ2VfYnMgd2lsbCByZWZlciB0byBpdCwNCj4+IHNvIGhlcmUgd2UgbmVlZCBl
eGFjdGx5IGJzLT5maWxlIEkgdGhpbmsuDQo+Pg0KPiANCj4gQWxyaWdodCwgSSBkb24ndCBrbm93
IHRoZSBwYXJ0aWN1bGFycy4gV2hhdGV2ZXIgd29ya3MgaXMgZmluZSBieSBtZS4NCj4gDQo+IFsu
Li5dDQo+IA0KPj4+Pg0KPj4+PiBZZXMuIEluIHNob3J0LCBpdCB3YXMgYmFkLCBpdCBzdGlsbCBi
YWQsIGJ1dCBhdCBsZWFzdCBvbmUgYnVnIGlzIGZpeGVkIDopDQo+Pj4+DQo+Pj4NCj4+PiBIYWhh
aGEhIFZlcnkgZ29vZCBzdW1tYXJ5LiBMZXQncyBkaXNjdXNzIHRoZSBibG9jayBpbXBsaWNhdGlv
bnMgd2l0aA0KPj4+IE1heCwgQmVydG8gYW5kIEtldmluLiBVbnRpbCB0aGVuLCBkbyB5b3UgdGhp
bmsgaXQncyBPSyB0byBzcGxpdCBvdXQgdGhlDQo+Pj4gcmVsZWFzZV9iaXRtYXBzIGJvb2xlYW4g
YXMgaXRzIG93biBwYXRjaCB0byAibGVzc2VuIiB0aGUgc2V2ZXJpdHkgb2YgdGhlDQo+Pj4gYnVn
Pw0KPj4NCj4+IEJpdG1hcCB3aWxsIG5vdCBiZSByZW9wZW5kIHJ3IGFueXdheSwgc28sIHdlIHNo
b3VsZCBjcmFzaCBvbiBmaXJzdCBndWVzdCB3cml0ZSwgYXMNCj4+IHlvdSBub3RlZC4uDQo+Pg0K
PiANCj4gV2h5IG5vdD8gSWYgdGhlIGJpdG1hcHMgYXJlIHN0aWxsIGluIG1lbW9yeSAoYmVjYXVz
ZSB3ZSBkaWRuJ3QgY2xvc2UNCj4gdGhlbSBmdWxseSBvbiByZW9wZW4tcm8pLCB0aGVuIHJlb3Bl
bi1ydyBvdWdodCB0byBiZSBhYmxlIHRvIHNlZSB0aGVtDQo+IGFuZCBkcm9wIHRoZSByZWFkb25s
eSBtYXJrZXIsIHJpZ2h0Pw0KPiANCj4+IE1heWJlLCBJJ2xsIHJlZmFjdG9yIGl0IGJhY2ssIHRv
IHJldHVybiBub3JtYWwgZXJyb3IsIGFuZCBqdXN0IGlnbm9yZSBpdCBpbiBjb21taXQsIHNvIHRo
YXQsDQo+PiB3ZSdsbCBtb3ZlIGl0IHRvIC5wcmVwYXJlIGFzIHNvb24gYXMgd2UgYWJsZSB0byBk
byBhbmQgd2l0aCBsZXNzIHBhaW4/DQo+Pg0KPiANCj4gSSBtYXkgaGF2ZSBtaXN1bmRlcnN0b29k
IE1heCwgYnV0IGF0IHRoZSBtb21lbnQgSSdtIHRoaW5raW5nIHRoYXQgYXMNCj4gbXVjaCBhcyB5
b3UgY2FuIG1vdmUgaW50byBwcmVwYXJlKCkgYW5kIGhhdmUgaXQgc3RpbGwgd29yayB0aGUgYmV0
dGVyLiBJDQo+IGFzc3VtZSB0aGF0IHdyaXRpbmcgdGhlIElOX1VTRSBmbGFncyBmcm9tIHByZXBh
cmUoKSB3b24ndCB3b3JrLCB0aG91Z2gsDQo+IGJlY2F1c2UgdGhlIG5vZGVzIGFyZW4ndCB0ZWNo
bmljYWxseSBSVyB5ZXQsIHNvIHRoZSB3cml0ZSBwcmltaXRpdmVzDQo+IHdvbid0IHdvcmsuLi4N
Cj4gDQo+IEF0IHRoaXMgcG9pbnQsIEknbGwgdHJ1c3QgeW91ciBqdWRnbWVudCB0byBjb21lIHVw
IHdpdGggc29tZXRoaW5nIHRoYXQNCj4gc2VlbXMgdGlkaWVyOyBJIGRvbid0IHRoaW5rIEkgaGF2
ZSBzdWdnZXN0aW9ucyB1bmxlc3MgSSBzdGFydA0KPiBwcm90b3R5cGluZyBpdCB0b28uDQo+IA0K
PiAoVGhvdWdoIEkgbWlnaHQgdHJ5IHRvIGNvbWUgdXAgd2l0aCBzb21ldGhpbmcgbWluaW1hbGx5
IHdvcmthYmxlIGFzIGENCj4gYnVnZml4IHdoaWxlIHdlIHRyeSB0byB0YWNrbGUgbW9yZSBzeXN0
ZW1pYyBpc3N1ZXMuLi4pDQo+IA0KPiAtLWpzDQo+IA0KDQpJJ20gbm93IHByZXBhcmluZyB2MiB3
aGljaCB0cmllcyB0byBkbyBldmVyeXRoaW5nIHdlIG5lZWQgaW4gcHJlcGFyZSwgd2hpY2ggaW5j
bHVkZXMNCmNoYW5nZXMgaW4gZ2VuZXJpYyBibG9jayBsYXllciByZW9wZW4gZnVuY3Rpb25hbGl0
eS4gU2VlbXMgbGlrZSBpdCdzIG5vdCB2ZXJ5IGhhcmQuDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

