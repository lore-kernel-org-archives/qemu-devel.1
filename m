Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEECBC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F10206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Af3OUg7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F10206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htDdY-0007iH-Ty
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 12:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48685)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htDXn-0003ZV-3A
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1htDXk-0003jF-Kk
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:03:06 -0400
Received: from mail-eopbgr60132.outbound.protection.outlook.com
 ([40.107.6.132]:58689 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1htDXk-0003iY-0j; Thu, 01 Aug 2019 12:03:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqG3SL1yXOYiScZ43Fz1ENtQwJHf4J8qehIEqmQhpd9bZW8VgYGq5Z6zCyxQld/G7S8CZ8Ajf6KGy9YZGuQsJS+Qr21oI86u3y02CQdF2kM7Ha3bVXpvnvv8wAb61uB76DqBnidksSz+B+K+UzF2kGGrF25xK5lWzD45BDpGGGd5JblVYTr5YdOg2VRJv8SumqIOuR2zL3X+oeUaQygAxqlmCYjIirhZgsFkC9yrwg7SJoaUytMJqDoFm7p6zJ718MPaASnygNjJlyFN+SFMINYsAnFyzeFqyu0tPtgY0q9dkvaxlJKE0Bn2Gij/O+Y8iVLRA4vbNuOBKdV1KvcLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NbbMrbGWe1u9bsaHEUNEQVnBV0Qq4eUGaVREZNTYCs=;
 b=DrrNhIOrtJWQk5sUziejH+912pfnUrhdTkaBQs8XXJGNhOS4wMI2ewG3coRPZkiMbzNVnozLH/HbZ11i9HWmVYCVSH2m6tllRTJJz8Ql0F6dyQqv10/DCskxghLE9w0UPOGGcVspWIGbSLtNIY4kzM5GkCZsrArNHmxBld/b5mjwD+CzHQj8nMArMyhJAG9qpDrMfZVn8VJ+Os3RXRnEhn+HB0RX1LSmsQTpkPQaVPyZHSzhzB0zjcP1nE5aijMmScp6b/GnHKK+r9OXobLPBVICn+dBxOC7Ab4bNyQ9zQndXoKMA1RXf0kTnrziXe7lvIICfK45pNFt5OsF/nUVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NbbMrbGWe1u9bsaHEUNEQVnBV0Qq4eUGaVREZNTYCs=;
 b=Af3OUg7AYc1kTs9xLjTnDJQJ3k747VIIyvT/ZmtFWHyYdc3AlaNgfB1Z/7x4foYAm2QXH+3GdMw8LU3yF7tneiLHs18S4xdFjrTDm67l4ij2tQ8IkX7mWMZTj6fkKTpczNMDz0YIVZLnaRDyoWyGU8edkOyJRi6frcUQ9iHQti8=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB3977.eurprd08.prod.outlook.com (20.179.11.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Thu, 1 Aug 2019 16:03:02 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 16:03:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH for-4.1 2/2] iotests: Test backup job with two guest
 writes
Thread-Index: AQHVSHuSmXijrz1GlEejh1OLI2A9XqbmdDaA
Date: Thu, 1 Aug 2019 16:03:01 +0000
Message-ID: <68653483-e7d2-154a-75c6-2dfef235d33d@virtuozzo.com>
References: <20190801151235.8434-1-mreitz@redhat.com>
 <20190801151235.8434-3-mreitz@redhat.com>
In-Reply-To: <20190801151235.8434-3-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::14) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190801190259597
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 544a3b6a-e2f3-4d64-307a-08d71699bae7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB3977; 
x-ms-traffictypediagnostic: DB8PR08MB3977:
x-microsoft-antispam-prvs: <DB8PR08MB397720E0296FA586937AC8CDC1DE0@DB8PR08MB3977.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(346002)(39850400004)(376002)(366004)(396003)(136003)(189003)(199004)(305945005)(6116002)(110136005)(71190400001)(14444005)(476003)(71200400001)(14454004)(8676002)(256004)(11346002)(25786009)(8936002)(86362001)(446003)(31686004)(2616005)(486006)(81156014)(81166006)(4326008)(26005)(478600001)(31696002)(53936002)(2906002)(6512007)(3846002)(6246003)(68736007)(54906003)(229853002)(66446008)(316002)(66476007)(186003)(66556008)(66946007)(102836004)(66066001)(2501003)(386003)(64756008)(6486002)(36756003)(99286004)(7736002)(6436002)(5660300002)(52116002)(6506007)(76176011)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB3977;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qWEUV/aAbiaa6t7CoG62qQxqM/OC+66H/1eMT7CZxz4txiOx/Abl2CZBgoQEmguetnMxWPntsSEopIVQZfPPWBNAJJMuqUt0c2hxTSkj06fplYuoWiELB9w/wIeEPoT4iwYuu2Nksx4vSPyaqoKBqXpTuua/Zd4IqyH7Tqy3ZbUgn7Ixab0+U4wmi8DKUsczjQorvYBbdsAxVYHHalTLjxhAcglLAayDqogBFsUJUT1Pb+sPKD5Sgd1CtxHlQM5kyAnnULTKnCV1QHEqVfJlGurIki3ZRNgaoXD5umVkGERzRRhg3MIT7I974VErNlFqCvB0P4mHi8iq/8wYSST82iDr8Nho9/lDTp23YOfqd12dx2dA2zBEo2kegFcpHEYKyOioXxK4mpdvQpxkqqyFVOMNVIdxLTAA3/EcHpsndj8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B37DFEC9842CB41B308F7342C1CC215@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544a3b6a-e2f3-4d64-307a-08d71699bae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 16:03:01.9096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3977
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.132
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] iotests: Test backup job with
 two guest writes
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDguMjAxOSAxODoxMiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBQZXJmb3JtIHR3byBndWVzdCB3
cml0ZXMgdG8gbm90IHlldCBiYWNrZWQgdXAgYXJlYXMgb2YgYW4gaW1hZ2UsIHdoZXJlDQo+IHRo
ZSBmb3JtZXIgdG91Y2hlcyBhbiBpbm5lciBhcmVhIG9mIHRoZSBsYXR0ZXIuDQo+IA0KPiBCZWZv
cmUgSEVBRF4sIGNvcHkgb2ZmbG9hZGluZyBicm9rZSB0aGlzIGluIHR3byB3YXlzOg0KPiAoMSkg
VGhlIG91dHB1dCBkaWZmZXJzIGZyb20gdGhlIHJlZmVyZW5jZSBvdXRwdXQgKHdoYXQgdGhlIHNv
dXJjZSB3YXMNCj4gICAgICBiZWZvcmUgdGhlIGd1ZXN0IHdyaXRlcykuDQo+ICgyKSBCdXQgeW91
IHdpbGwgbm90IHNlZSB0aGF0IGluIHRoZSBmYWlsaW5nIG91dHB1dCwgYmVjYXVzZSB0aGUgam9i
DQo+ICAgICAgb2Zmc2V0IGlzIHJlcG9ydGVkIGFzIGJlaW5nIGdyZWF0ZXIgdGhhbiB0aGUgam9i
IGxlbmd0aC4gIFRoaXMgaXMNCj4gICAgICBiZWNhdXNlIG9uZSBjbHVzdGVyIGlzIGNvcGllZCB0
d2ljZSwgYW5kIHRodXMgYWNjb3VudGVkIGZvciB0d2ljZSwNCj4gICAgICBidXQgb2YgY291cnNl
IHRoZSBqb2IgbGVuZ3RoIGRvZXMgbm90IGluY3JlYXNlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rl
c3RzLzA1NiAgICAgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAg
dGVzdHMvcWVtdS1pb3Rlc3RzLzA1Ni5vdXQgfCAgNCArKy0tDQo+ICAgMiBmaWxlcyBjaGFuZ2Vk
LCAzNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3FlbXUtaW90ZXN0cy8wNTYgYi90ZXN0cy9xZW11LWlvdGVzdHMvMDU2DQo+IGluZGV4IGY0
MGZjMTFhMDkuLmQ3MTk4NTA3ZjUgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8w
NTYNCj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1Ng0KPiBAQCAtMTMzLDYgKzEzMyw3IEBA
IGNsYXNzIEJhY2t1cFRlc3QoaW90ZXN0cy5RTVBUZXN0Q2FzZSk6DQo+ICAgICAgICAgICBzZWxm
LnZtID0gaW90ZXN0cy5WTSgpDQo+ICAgICAgICAgICBzZWxmLnRlc3RfaW1nID0gaW1nX2NyZWF0
ZSgndGVzdCcpDQo+ICAgICAgICAgICBzZWxmLmRlc3RfaW1nID0gaW1nX2NyZWF0ZSgnZGVzdCcp
DQo+ICsgICAgICAgIHNlbGYucmVmX2ltZyA9IGltZ19jcmVhdGUoJ3JlZicpDQo+ICAgICAgICAg
ICBzZWxmLnZtLmFkZF9kcml2ZShzZWxmLnRlc3RfaW1nKQ0KPiAgICAgICAgICAgc2VsZi52bS5s
YXVuY2goKQ0KPiAgIA0KPiBAQCAtMTQwLDYgKzE0MSw3IEBAIGNsYXNzIEJhY2t1cFRlc3QoaW90
ZXN0cy5RTVBUZXN0Q2FzZSk6DQo+ICAgICAgICAgICBzZWxmLnZtLnNodXRkb3duKCkNCj4gICAg
ICAgICAgIHRyeV9yZW1vdmUoc2VsZi50ZXN0X2ltZykNCj4gICAgICAgICAgIHRyeV9yZW1vdmUo
c2VsZi5kZXN0X2ltZykNCj4gKyAgICAgICAgdHJ5X3JlbW92ZShzZWxmLnJlZl9pbWcpDQo+ICAg
DQo+ICAgICAgIGRlZiBobXBfaW9fd3JpdGVzKHNlbGYsIGRyaXZlLCBwYXR0ZXJucyk6DQo+ICAg
ICAgICAgICBmb3IgcGF0dGVybiBpbiBwYXR0ZXJuczoNCj4gQEAgLTE3Nyw2ICsxNzksMzggQEAg
Y2xhc3MgQmFja3VwVGVzdChpb3Rlc3RzLlFNUFRlc3RDYXNlKToNCj4gICAgICAgICAgICAgICBz
ZWxmLmFzc2VydF9xbXAoZXZlbnQsICdkYXRhL2Vycm9yJywgcWVycm9yKQ0KPiAgICAgICAgICAg
ICAgIHJldHVybiBGYWxzZQ0KPiAgIA0KPiArICAgIGRlZiB0ZXN0X292ZXJsYXBwaW5nX3dyaXRl
cyhzZWxmKToNCj4gKyAgICAgICAgIyBXcml0ZSBzb21ldGhpbmcgdG8gYmFjayB1cA0KPiArICAg
ICAgICBzZWxmLmhtcF9pb193cml0ZXMoJ2RyaXZlMCcsIFsoJzQyJywgJzBNJywgJzJNJyldKQ0K
PiArDQo+ICsgICAgICAgICMgQ3JlYXRlIGEgcmVmZXJlbmNlIGJhY2t1cA0KPiArICAgICAgICBz
ZWxmLnFtcF9iYWNrdXBfYW5kX3dhaXQoZGV2aWNlPSdkcml2ZTAnLCBmb3JtYXQ9aW90ZXN0cy5p
bWdmbXQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzeW5jPSdmdWxsJywg
dGFyZ2V0PXNlbGYucmVmX2ltZykNCj4gKw0KPiArICAgICAgICAjIE5vdyB0byB0aGUgdGVzdCBi
YWNrdXA6IFdlIHNpbXVsYXRlIHRoZSBmb2xsb3dpbmcgZ3Vlc3QNCj4gKyAgICAgICAgIyB3cml0
ZXM6DQo+ICsgICAgICAgICMgKDEpIFsxTSArIDY0aywgMU0gKyAxMjhrKTogQWZ0ZXJ3YXJkcywg
ZXZlcnl0aGluZyBpbiB0aGF0DQo+ICsgICAgICAgICMgICAgIGFyZWEgc2hvdWxkIGJlIGluIHRo
ZSB0YXJnZXQgaW1hZ2UsIGFuZCB3ZSBtdXN0IG5vdCBjb3B5DQo+ICsgICAgICAgICMgICAgIGl0
IGFnYWluIChiZWNhdXNlIHRoZSBzb3VyY2UgaW1hZ2UgaGFzIGNoYW5nZWQgbm93KQ0KPiArICAg
ICAgICAjICAgICAoNjRrIGlzIHRoZSBqb2IncyBjbHVzdGVyIHNpemUpDQo+ICsgICAgICAgICMg
KDIpIFsxTSwgMk0pOiBUaGUgYmFja3VwIGpvYiBtdXN0IG5vdCBnZXQgb3ZlcmVhZ2VyLiAgSXQN
Cj4gKyAgICAgICAgIyAgICAgbXVzdCBjb3B5IFsxTSwgMU0gKyA2NGspIGFuZCBbMU0gKyAxMjhr
LCAyTSkgc2VwYXJhdGVseSwNCj4gKyAgICAgICAgIyAgICAgYnV0IG5vdCB0aGUgYXJlYSBpbiBi
ZXR3ZWVuLg0KPiArDQo+ICsgICAgICAgIHNlbGYucW1wX2JhY2t1cChkZXZpY2U9J2RyaXZlMCcs
IGZvcm1hdD1pb3Rlc3RzLmltZ2ZtdCwgc3luYz0nZnVsbCcsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICB0YXJnZXQ9c2VsZi5kZXN0X2ltZywgc3BlZWQ9MSkNCj4gKw0KPiArICAgICAgICBz
ZWxmLmhtcF9pb193cml0ZXMoJ2RyaXZlMCcsIFsoJzIzJywgJyVpaycgJSAoMTAyNCArIDY0KSwg
JzY0aycpLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoJzY2Jywg
JzFNJywgJzFNJyldKQ0KPiArDQo+ICsgICAgICAgICMgTGV0IHRoZSBqb2IgY29tcGxldGUNCj4g
KyAgICAgICAgcmVzID0gc2VsZi52bS5xbXAoJ2Jsb2NrLWpvYi1zZXQtc3BlZWQnLCBkZXZpY2U9
J2RyaXZlMCcsIHNwZWVkPTApDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXMsICdyZXR1
cm4nLCB7fSkNCj4gKyAgICAgICAgc2VsZi5xbXBfYmFja3VwX3dhaXQoJ2RyaXZlMCcpDQo+ICsN
Cj4gKyAgICAgICAgc2VsZi5hc3NlcnRUcnVlKGlvdGVzdHMuY29tcGFyZV9pbWFnZXMoc2VsZi5y
ZWZfaW1nLCBzZWxmLmRlc3RfaW1nKSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICd0YXJn
ZXQgaW1hZ2UgZG9lcyBub3QgbWF0Y2ggcmVmZXJlbmNlIGltYWdlJykNCj4gKw0KPiAgICAgICBk
ZWYgdGVzdF9kaXNtaXNzX2ZhbHNlKHNlbGYpOg0KPiAgICAgICAgICAgcmVzID0gc2VsZi52bS5x
bXAoJ3F1ZXJ5LWJsb2NrLWpvYnMnKQ0KPiAgICAgICAgICAgc2VsZi5hc3NlcnRfcW1wKHJlcywg
J3JldHVybicsIFtdKQ0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA1Ni5vdXQg
Yi90ZXN0cy9xZW11LWlvdGVzdHMvMDU2Lm91dA0KPiBpbmRleCBkYWU0MDRlMjc4Li4zNjM3NmJl
ZDg3IDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDU2Lm91dA0KPiArKysgYi90
ZXN0cy9xZW11LWlvdGVzdHMvMDU2Lm91dA0KPiBAQCAtMSw1ICsxLDUgQEANCj4gLS4uLi4uLi4u
Lg0KPiArLi4uLi4uLi4uLg0KPiAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLVJhbiA5IHRlc3RzDQo+ICtS
YW4gMTAgdGVzdHMNCj4gICANCj4gICBPSw0KPiANCg0KRmFpbGVkIGZvciBtZToNCi0uLi4uLi4u
Li4uDQorcWVtdS1pbWc6IENvdWxkIG5vdCBvcGVuICcvd29yay9zcmMvcWVtdS9tYXN0ZXIvdGVz
dHMvcWVtdS1pb3Rlc3RzL3NjcmF0Y2gvZGVzdC5xY293Mic6IEZhaWxlZCB0byBnZXQgc2hhcmVk
ICJ3cml0ZSIgbG9jaw0KK0lzIGFub3RoZXIgcHJvY2VzcyB1c2luZyB0aGUgaW1hZ2UgWy93b3Jr
L3NyYy9xZW11L21hc3Rlci90ZXN0cy9xZW11LWlvdGVzdHMvc2NyYXRjaC9kZXN0LnFjb3cyXT8N
CisuLi4uLi5GLi4uDQorPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KK0ZBSUw6IHRlc3Rfb3ZlcmxhcHBpbmdfd3Jp
dGVzIChfX21haW5fXy5CYWNrdXBUZXN0KQ0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCitUcmFjZWJhY2sgKG1v
c3QgcmVjZW50IGNhbGwgbGFzdCk6DQorICBGaWxlICIwNTYiLCBsaW5lIDIxMiwgaW4gdGVzdF9v
dmVybGFwcGluZ193cml0ZXMNCisgICAgJ3RhcmdldCBpbWFnZSBkb2VzIG5vdCBtYXRjaCByZWZl
cmVuY2UgaW1hZ2UnKQ0KK0Fzc2VydGlvbkVycm9yOiBGYWxzZSBpcyBub3QgdHJ1ZSA6IHRhcmdl
dCBpbWFnZSBkb2VzIG5vdCBtYXRjaCByZWZlcmVuY2UgaW1hZ2UNCisNCiAgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KICBSYW4gMTAgdGVzdHMNCg0KLU9LDQorRkFJTEVEIChmYWlsdXJlcz0xKQ0KDQoNCg0KU28s
IHdpdGggYXBwbGllZA0KDQpAQCAtMjA3LDYgKzIwNyw3IEBAIGNsYXNzIEJhY2t1cFRlc3QoaW90
ZXN0cy5RTVBUZXN0Q2FzZSk6DQogICAgICAgICAgcmVzID0gc2VsZi52bS5xbXAoJ2Jsb2NrLWpv
Yi1zZXQtc3BlZWQnLCBkZXZpY2U9J2RyaXZlMCcsIHNwZWVkPTApDQogICAgICAgICAgc2VsZi5h
c3NlcnRfcW1wKHJlcywgJ3JldHVybicsIHt9KQ0KICAgICAgICAgIHNlbGYucW1wX2JhY2t1cF93
YWl0KCdkcml2ZTAnKQ0KKyAgICAgICAgc2VsZi52bS5zaHV0ZG93bigpDQoNCiAgICAgICAgICBz
ZWxmLmFzc2VydFRydWUoaW90ZXN0cy5jb21wYXJlX2ltYWdlcyhzZWxmLnJlZl9pbWcsIHNlbGYu
ZGVzdF9pbWcpLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAndGFyZ2V0IGltYWdlIGRvZXMg
bm90IG1hdGNoIHJlZmVyZW5jZSBpbWFnZScpDQoNCg0KDQpSZXZpZXdlZC1ieTogVmxhZGltaXIg
U2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KVGVzdGVkLWJ5
OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

