Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD500C4321B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2D420820
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GV3HtQuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2D420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hae76-000835-Ur
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 06:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60739)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hae13-0002nV-Ld
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hae11-0001x3-N7
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:28:33 -0400
Received: from mail-eopbgr60133.outbound.protection.outlook.com
 ([40.107.6.133]:7044 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hae0s-0001nV-HI; Tue, 11 Jun 2019 06:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOKQk/9OpzfcefwuuScyr2FTCWhIsCmqH8gSlhpt1Jc=;
 b=GV3HtQuImDpWdJRN4MN/APE7ozXIej06+kFTIAT5EhCCQqndcZ2KPnm+fxOgZzs/5MGnRbk+OZlYz03QoM/94HAkbKRYUmUfdvf2Blt4vUWfu3pEzp0pkb2CW6/Ql9JHVlQp2RsmAoEn4U9vsO6H1HV60d33cySTXBQvS02g62k=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB4098.eurprd08.prod.outlook.com (20.178.202.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Tue, 11 Jun 2019 10:28:19 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 10:28:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v6 5/7] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
Thread-Index: AQHU8IvPncRKmUnNFESi2c9mvKXDwqaQLEMAgAA4CACAAB0MAIAAL54AgAAVoACABb6MgIAAGooA
Date: Tue, 11 Jun 2019 10:28:19 +0000
Message-ID: <8fee04e0-5549-20f7-f7f6-389c8b715099@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-6-vsementsov@virtuozzo.com>
 <20190607075740.GA5055@dhcp-200-226.str.redhat.com>
 <16b7ad42-611c-fc3e-2029-d491882b0750@virtuozzo.com>
 <20190607130210.GC5055@dhcp-200-226.str.redhat.com>
 <4e970256-1eb1-2d12-5d40-13341fd0890b@virtuozzo.com>
 <974c3f2d-e353-795a-8ca9-134447a311ec@virtuozzo.com>
 <20190611085317.GC8112@localhost.localdomain>
In-Reply-To: <20190611085317.GC8112@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::28)
 To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190611132816597
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be33619d-926d-481a-c251-08d6ee5785b5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4098; 
x-ms-traffictypediagnostic: AM0PR08MB4098:
x-microsoft-antispam-prvs: <AM0PR08MB409888878A4F4A8891B6ED0CC1ED0@AM0PR08MB4098.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(136003)(39850400004)(366004)(189003)(199004)(5660300002)(2906002)(8936002)(6512007)(486006)(31696002)(36756003)(68736007)(229853002)(478600001)(31686004)(6436002)(6486002)(66066001)(86362001)(316002)(14454004)(54906003)(99286004)(7736002)(6916009)(53936002)(386003)(6116002)(11346002)(25786009)(2616005)(107886003)(446003)(476003)(6506007)(305945005)(186003)(6246003)(52116002)(73956011)(102836004)(66476007)(66556008)(71200400001)(256004)(66446008)(76176011)(3846002)(81156014)(81166006)(64756008)(4326008)(66946007)(8676002)(26005)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4098;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tWjmX4fhcNDXuDuobisdE/yzOBToIqjlKrhYn6e+1dC8pqDxPgjy2LEmJjBVdAjRUotzfK5d8BwcBCPcRBaueriSylx8mZcVGyiiAiBaUG+k0HmZvR362pKdAT5c9CPOqnNhXJ7CiJHr+vxIWzfjwAARcuWDVAO1vUG2XWb+NM/GFZXr9x8nNsLr8luJRpGLdcFZ4XdYZC+ouhdIx2u6YnH8z0AgakhU6+EO7FBmiuYu/zJD0ZKHj8wRmSyVrAbTKTZb/nEprH1uem6gksQZTDZ1gDGbLzCXJPpQMhfmKGT4/o2tDvm5NTs7FyQnChEz5lpTnPSwVfPHxVX4XIXBFEQDsqaxYcHzmBpB/ArE6MhTRv6WfaLxI52UL+dyNY16BsRRHyFTpFK5whFxuBflre3wIC0vu6uKTqx/wxNQ9TE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44B579D94B76694AB8D489E66F10679B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be33619d-926d-481a-c251-08d6ee5785b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 10:28:19.6328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4098
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.133
Subject: Re: [Qemu-devel] [PATCH v6 5/7] qemu-coroutine-sleep: introduce
 qemu_co_sleep_wake
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTEuMDYuMjAxOSAxMTo1MywgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDcuMDYuMjAxOSB1bSAx
OToxMCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDA3
LjA2LjIwMTkgMTg6NTIsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4g
MDcuMDYuMjAxOSAxNjowMiwgS2V2aW4gV29sZiB3cm90ZToNCj4+Pj4gQW0gMDcuMDYuMjAxOSB1
bSAxMzoxOCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+
Pj4+IDA3LjA2LjIwMTkgMTA6NTcsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4+Pj4gQW0gMTEuMDQu
MjAxOSB1bSAxOToyNyBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJl
bjoNCj4+Pj4+Pj4gSW50cm9kdWNlIGEgZnVuY3Rpb24gdG8gZ3JhY2VmdWxseSB3YWtlLXVwIGEg
Y29yb3V0aW5lLCBzbGVlcGluZyBpbg0KPj4+Pj4+PiBxZW11X2NvX3NsZWVwX25zKCkgc2xlZXAu
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4+Pg0KPj4+Pj4+IFlvdSBjYW4g
c2ltcGx5IHJlZW50ZXIgdGhlIGNvcm91dGluZSB3aGlsZSBpdCBoYXMgeWllbGRlZCBpbg0KPj4+
Pj4+IHFlbXVfY29fc2xlZXBfbnMoKS4gVGhpcyBpcyBzdXBwb3J0ZWQuDQo+Pj4+Pg0KPj4+Pj4g
Tm8gaXQgZG9lc24ndC4gcWVtdV9haW9fY29yb3V0aW5lX2VudGVyIGNoZWNrcyBmb3Igc2NoZWR1
bGVkIGZpZWxkLA0KPj4+Pj4gYW5kIGFib3J0cyBpZiBpdCBpcyBzZXQuDQo+Pj4+DQo+Pj4+IEFo
LCB5ZXMsIGl0IGhhcyBiZWVuIGJyb2tlbiBzaW5jZSBjb21taXQNCj4+Pj4NCj4+Pj4gSSBhY3R1
YWxseSB0cmllZCB0byBmaXggaXQgb25jZSwgYnV0IGl0IHR1cm5lZCBvdXQgbW9yZSBjb21wbGlj
YXRlZCBhbmQNCj4+Pj4gSSB0aGluayB3ZSBmb3VuZCBhIGRpZmZlcmVudCBzb2x1dGlvbiBmb3Ig
dGhlIHByb2JsZW0gYXQgaGFuZDoNCj4+Pj4NCj4+Pj4gIMKgwqDCoMKgIFN1YmplY3Q6IFtQQVRD
SCBmb3ItMi4xMSAwLzRdIEZpeCBxZW11LWlvdGVzdHMgZmFpbHVyZXMNCj4+Pj4gIMKgwqDCoMKg
IE1lc3NhZ2UtSWQ6IDwyMDE3MTEyODE1NDM1MC4yMTUwNC0xLWt3b2xmQHJlZGhhdC5jb20+DQo+
Pj4+DQo+Pj4+IEluIHRoaXMgY2FzZSwgSSBndWVzcyB5b3VyIGFwcHJvYWNoIHdpdGggYSBuZXcg
ZnVuY3Rpb24gdG8gaW50ZXJydXB0DQo+Pj4+IHFlbXVfY29fc2xlZXBfbnMoKSBpcyBva2F5Lg0K
Pj4+Pg0KPj4+PiBEbyB3ZSBuZWVkIHRvIHRpbWVyX2RlbCgpIHdoZW4gdGFraW5nIHRoZSBzaG9y
dGN1dD8gV2UgZG9uJ3QgbmVjZXNzYXJpbHkNCj4+Pj4gcmVlbnRlciB0aGUgY29yb3V0aW5lIGlt
bWVkaWF0ZWx5LCBidXQgbWlnaHQgb25seSBiZSBzY2hlZHVsaW5nIGl0LiBJbg0KPj4+PiB0aGlz
IGNhc2UsIHRoZSB0aW1lciBjb3VsZCBmaXJlIGJlZm9yZSBxZW11X2NvX3NsZWVwX25zKCkgaGFz
IHJ1biBhbmQNCj4+Pj4gc2NoZWR1bGUgdGhlIGNvcm91dGluZSBhIHNlY29uZCB0aW1lDQo+Pj4N
Cj4+PiBObyBpdCB3aWxsIG5vdCwgYXMgd2UgZG8gY21weGNoZywgc2NoZWR1bGVkIHRvIE5VTEws
IHNvIHNlY29uZCBjYWxsIHdpbGwgZG8NCj4+PiBub3RoaW5nLi4NCj4+Pg0KPj4+IEJ1dCBpdCBz
ZWVtcyB1bnNhZmUsIGFzIGV2ZW4gY29yb3V0aW5lIHBvaW50ZXIgbWF5IGJlIHN0YWxlIHdoZW4g
d2UgY2FsbA0KPj4+IHFlbXVfY29fc2xlZXBfd2FrZSBzZWNvbmQgdGltZS4gU28sIHdlIHBvc3Np
Ymx5IHNob3VsZCByZW1vdmUgdGltZXIsIGJ1dCAuLg0KPj4+DQo+Pj4gICDCoChpZ25vcmluZyBj
by0+c2NoZWR1bGVkIGFnYWluIC0NCj4+Pj4gbWF5YmUgd2Ugc2hvdWxkIGFjdHVhbGx5IG5vdCBk
byB0aGF0IGluIHRoZSB0aW1lciBjYWxsYmFjayBwYXRoLCBidXQNCj4+Pj4gaW5zdGVhZCBsZXQg
aXQgcnVuIGludG8gdGhlIGFzc2VydGlvbiBiZWNhdXNlIGl0IHdvdWxkIGJlIGEgYnVnIGZvciB0
aGUNCj4+Pj4gdGltZXIgY2FsbGJhY2sgdG8gZW5kIHVwIGluIHRoaXMgc2l0dWF0aW9uKS4NCj4+
Pj4NCj4+Pj4gS2V2aW4NCj4+Pj4NCj4+Pg0KPj4+IEludGVyZXN0aW5nLCBjb3VsZCB0aGVyZSBi
ZSBhIHJhY2UgY29uZGl0aW9uLCB3aGVuIHdlIGNhbGwgcWVtdV9jb19zbGVlcF93YWtlLA0KPj4+
IGJ1dCBjb19zbGVlcF9jYiBhbHJlYWR5IHNjaGVkdWxlZCBpbiBzb21lIHF1ZXVlIGFuZCB3aWxs
IHJ1biBzb29uPyBUaGVuIHJlbW92aW5nDQo+Pj4gdGhlIHRpbWVyIHdpbGwgbm90IGhlbHAuDQo+
Pj4NCj4+Pg0KPj4NCj4+IEhtbSwgaXQncyBjb21tZW50ZWQgdGhhdCB0aW1lcl9kZWwgaXMgdGhy
ZWFkLXNhZmUuLg0KPj4NCj4+IEhtbSwgc28sIGlmIGFueXdheSB3YW50IHRvIHJldHVybiBUaW1l
ciBwb2ludGVyIGZyb20gcWVtdV9jb19zbGVlcF9ucywgbWF5IGJlIGl0J3MgYmV0dGVyDQo+PiB0
byBqdXN0IGNhbGwgdGltZXJfbW9kKHRzLCAwKSB0byBzaG9ydGVuIHdhaXRpbmcgaW5zdGVhZCBv
ZiBjaGVhdGluZyB3aXRoIC5zY2hlZHVsZWQ/DQo+IA0KPiBUaGlzIGlzIHByb2JhYmx5IHNsb3dl
ciB0aGFuIHRpbWVyX2RlbCgpIGFuZCBkaXJlY3RseSBlbnRlcmluZyB0aGUNCj4gY29yb3V0aW5l
LiBJcyB0aGVyZSBhbnkgYWR2YW50YWdlIGluIHVzaW5nIHRpbWVyX21vZCgpPyBJIGRvbid0IHRo
aW5rDQo+IG1lc3Npbmcgd2l0aCAuc2NoZWR1bGVkIGlzIHRvbyBiYWQgYXMgaXQncyBzZXQgaW4g
dGhlIGZ1bmN0aW9uIGp1c3QNCj4gYmVsb3csIHNvIGl0IHBhaXJzIG5pY2VseSBlbm91Z2guDQo+
IA0KDQpPaywgd2lsbCB0cnkgdGhpcyB2YXJpYW50IHRvby4NCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

