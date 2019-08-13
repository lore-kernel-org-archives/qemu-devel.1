Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EE9C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E65F20644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A1gc2Lmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E65F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXZl-0001PD-O6
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxXZJ-0000v5-HJ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxXZI-000819-0W
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:14:33 -0400
Received: from mail-eopbgr20101.outbound.protection.outlook.com
 ([40.107.2.101]:48511 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxXZH-0007yf-Be; Tue, 13 Aug 2019 10:14:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7FyCFevmAQN9540nvPNIu0DGVWcjuGn6pnLuGgr71zg0EEguig4EFyWhYJ2mSbuuju/dIEWTnLOUypx8LpwTEjizF48mdz8ni3o1bxWROfrdtetZYkcx+mGBGEsr9bvblcz095Jn3DDRhRlX3d6twCr6dHMHIVsatOqTN1sdJ/Mj3KMyd6tfyBly1cTfWRDp7BFxoWeebXXZQR2xYGR9dxbseGWvCr3oMruWTEzI68sWFpBRY9f7oJYi8uOGkAZCQLQ9+mwLR/wHapup0ocmeE5viyiQnSt/7MSDkTGOaGrEhWqvbBUMhAv9bbV6sFuZsYtBwQe5/sOLf15FO2jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGonmkVrEzDhxsrygae6qz8YjIekV983+GVl6B89jrY=;
 b=kme4kpRvLbrXEqFTOQxXkRtDom0QMiAXHIVoA4oVU5QGJL0gs7cb7av+MWgY2OX9rh74+cVsyy/nom9wMtfgPomP9wpCf+OoC547+xsFhLOHWkkBlFgTnFWkv9fqTrCR8HMMvazD9/m4leygybSGIF8S0xCcavSjOMDiDWyCN+AGIji7WOCtaSsHchR1UNESs2hD2xZdGoZPt7VAlsYbS6wqByJW5DZD8bpgvhFGpT/7XGTqwVr7Wo7qVXFPkFQ/t5+44iLUFBXvxtjsSwDrqDdAWvutQ1nr81Rr6dODBqFZWQOy4cVZkt5zjjX+lc/rHb8y5Btq0IIhtgh+cWvThw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGonmkVrEzDhxsrygae6qz8YjIekV983+GVl6B89jrY=;
 b=A1gc2LmrrLLVLcKkvX1CcjlCwNZa5iSn21Qhj4soUnsfF3HPf8rMIy4ceKRheZ6hFwxm8Ky2Eurs8+Vvd25J3n99GVTCPciG3j8JhaIE/7S4xeFPEv4ODwAE/+NJYKSvNgNtlR1h4KYX/2HzqZ7GFBojwUk8aJhrOgV2vsfQsFg=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4972.eurprd08.prod.outlook.com (10.255.18.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 14:14:26 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 14:14:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 6/7] block/backup: teach backup_cow_with_bounce_buffer
 to copy more at once
Thread-Index: AQHVT7JML2nk8Wsax0eUZCBvWTBktKb3oMEAgAAKYwCAAAavAIAABzYAgAFqYoA=
Date: Tue, 13 Aug 2019 14:14:26 +0000
Message-ID: <4093762b-a1bc-d6b1-8358-4f9d1ab52557@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
 <20190810193155.58637-7-vsementsov@virtuozzo.com>
 <5102eac9-125b-0719-910f-4adb240732f1@redhat.com>
 <89c87c83-276a-7663-a239-57dbd9f91a30@virtuozzo.com>
 <ecff86a8-57d1-4c8a-d4b4-95524471d249@redhat.com>
 <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
In-Reply-To: <e3fc5e07-33c6-1fe3-2042-35bdac0a03c3@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0263.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813171423498
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e05c6a6-cd42-42af-c84c-08d71ff88c34
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4972; 
x-ms-traffictypediagnostic: DB8PR08MB4972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB4972D02BD0B8E504687E31B1C1D20@DB8PR08MB4972.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39840400004)(52314003)(199004)(189003)(256004)(14444005)(71200400001)(66446008)(7736002)(66556008)(11346002)(305945005)(66476007)(99286004)(64756008)(6486002)(229853002)(14454004)(52116002)(5660300002)(316002)(6436002)(54906003)(6512007)(66946007)(2501003)(71190400001)(478600001)(3846002)(6246003)(66066001)(31696002)(86362001)(186003)(102836004)(476003)(107886003)(81166006)(53936002)(2616005)(486006)(110136005)(2906002)(25786009)(31686004)(26005)(6116002)(36756003)(386003)(53546011)(4326008)(6506007)(446003)(8676002)(8936002)(76176011)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4972;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F2UCkrlo6Si1lDpjAzoAA/5qOadgX0PTfM3LeiKBO0elAQFuK4Ywyonetv7BeUjtoj5x9MEGzdrCTVAgPcj8tzNyr6Hs22nhFHEY2aOg1fQ14Z3Q5kcb0UWjmsIcGhZXIVRS/2/yBXL6hLSLSDb/XrpaA1exAsWO+piM29i/0Kf0BPy8dYAufOeVsgL4ohG3cz1QUotb3WmvNMkxqcSV95F1u4vHo7C20QfKFNOBp6s0Qgk3iIRX5e7VsUuMlt3v/64CarB2I3MaG0WHaCUf7BWYgj9mzlvKSb0LyEEvJGrdjWtEtOx4kprbGfaT0RccFQY9W8JobHFunveKHsSxmoKXdAav2i0dfthbB9VeZOKVW6sOmtmcEs2egKYYQkI0Qu/SfXyke6FliSEeclkOFAkuR96vTRTqZhwVv/4mFFI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF53F403F2F5734C9694FDF12A758580@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e05c6a6-cd42-42af-c84c-08d71ff88c34
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 14:14:26.2275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbvC3YOQAiHzM1BihsYTlPzH/cEmwWmYBzeiP2nggU3q35bY/0Et77u8qJOJoSv0SZfuks9MxH/cy7i1qFmAT6AXN7PzYa1XD2pP9pke5rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4972
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.101
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTIuMDguMjAxOSAxOTozNywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTIuMDguMjAxOSAxOToxMSwgTWF4IFJlaXR6IHdyb3RlOg0KPj4gT24gMTIuMDguMTkgMTc6NDcs
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMTIuMDguMjAxOSAxODox
MCwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+PiBPbiAxMC4wOC4xOSAyMTozMSwgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IGJhY2t1cF9jb3dfd2l0aF9vZmZsb2FkIGNh
biB0cmFuc2ZlciBtb3JlIHRoYW4gb25lIGNsdXN0ZXIuIExldA0KPj4+Pj4gYmFja3VwX2Nvd193
aXRoX2JvdW5jZV9idWZmZXIgYmVoYXZlIHNpbWlsYXJseS4gSXQgcmVkdWNlcyB0aGUgbnVtYmVy
DQo+Pj4+PiBvZiBJTyByZXF1ZXN0cywgc2luY2UgdGhlcmUgaXMgbm8gbmVlZCB0byBjb3B5IGNs
dXN0ZXIgYnkgY2x1c3Rlci4NCj4+Pj4+DQo+Pj4+PiBMb2dpYyBhcm91bmQgYm91bmNlX2J1ZmZl
ciBhbGxvY2F0aW9uIGNoYW5nZWQ6IHdlIGNhbid0IGp1c3QgYWxsb2NhdGUNCj4+Pj4+IG9uZS1j
bHVzdGVyLXNpemVkIGJ1ZmZlciB0byBzaGFyZSBmb3IgYWxsIGl0ZXJhdGlvbnMuIFdlIGNhbid0
IGFsc28NCj4+Pj4+IGFsbG9jYXRlIGJ1ZmZlciBvZiBmdWxsLXJlcXVlc3QgbGVuZ3RoIGl0IG1h
eSBiZSB0b28gbGFyZ2UsIHNvDQo+Pj4+PiBCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIgaXMgaW50
cm9kdWNlZC4gQW5kIGZpbmFsbHksIGFsbG9jYXRpb24gbG9naWMNCj4+Pj4+IGlzIHRvIGFsbG9j
YXRlIGEgYnVmZmVyIHN1ZmZpY2llbnQgdG8gaGFuZGxlIGFsbCByZW1haW5pbmcgaXRlcmF0aW9u
cw0KPj4+Pj4gYXQgdGhlIHBvaW50IHdoZXJlIHdlIG5lZWQgdGhlIGJ1ZmZlciBmb3IgdGhlIGZp
cnN0IHRpbWUuDQo+Pj4+Pg0KPj4+Pj4gQm9udXM6IGdldCByaWQgb2YgcG9pbnRlci10by1wb2lu
dGVyLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gwqDCoCBi
bG9jay9iYWNrdXAuYyB8IDY1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tDQo+Pj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCsp
LCAyNCBkZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvYmxvY2svYmFja3Vw
LmMgYi9ibG9jay9iYWNrdXAuYw0KPj4+Pj4gaW5kZXggZDQ4MmQ5MzQ1OC4uNjVmNzIxMmM4NSAx
MDA2NDQNCj4+Pj4+IC0tLSBhL2Jsb2NrL2JhY2t1cC5jDQo+Pj4+PiArKysgYi9ibG9jay9iYWNr
dXAuYw0KPj4+Pj4gQEAgLTI3LDYgKzI3LDcgQEANCj4+Pj4+IMKgwqAgI2luY2x1ZGUgInFlbXUv
ZXJyb3ItcmVwb3J0LmgiDQo+Pj4+PiDCoMKgICNkZWZpbmUgQkFDS1VQX0NMVVNURVJfU0laRV9E
RUZBVUxUICgxIDw8IDE2KQ0KPj4+Pj4gKyNkZWZpbmUgQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVS
ICg2NCAqIDEwMjQgKiAxMDI0KQ0KPj4+Pj4gwqDCoCB0eXBlZGVmIHN0cnVjdCBDb3dSZXF1ZXN0
IHsNCj4+Pj4+IMKgwqDCoMKgwqDCoCBpbnQ2NF90IHN0YXJ0X2J5dGU7DQo+Pj4+PiBAQCAtOTgs
NDQgKzk5LDU1IEBAIHN0YXRpYyB2b2lkIGNvd19yZXF1ZXN0X2VuZChDb3dSZXF1ZXN0ICpyZXEp
DQo+Pj4+PiDCoMKgwqDCoMKgwqAgcWVtdV9jb19xdWV1ZV9yZXN0YXJ0X2FsbCgmcmVxLT53YWl0
X3F1ZXVlKTsNCj4+Pj4+IMKgwqAgfQ0KPj4+Pj4gLS8qIENvcHkgcmFuZ2UgdG8gdGFyZ2V0IHdp
dGggYSBib3VuY2UgYnVmZmVyIGFuZCByZXR1cm4gdGhlIGJ5dGVzIGNvcGllZC4gSWYNCj4+Pj4+
IC0gKiBlcnJvciBvY2N1cnJlZCwgcmV0dXJuIGEgbmVnYXRpdmUgZXJyb3IgbnVtYmVyICovDQo+
Pj4+PiArLyoNCj4+Pj4+ICsgKiBDb3B5IHJhbmdlIHRvIHRhcmdldCB3aXRoIGEgYm91bmNlIGJ1
ZmZlciBhbmQgcmV0dXJuIHRoZSBieXRlcyBjb3BpZWQuIElmDQo+Pj4+PiArICogZXJyb3Igb2Nj
dXJyZWQsIHJldHVybiBhIG5lZ2F0aXZlIGVycm9yIG51bWJlcg0KPj4+Pj4gKyAqDQo+Pj4+PiAr
ICogQGJvdW5jZV9idWZmZXIgaXMgYXNzdW1lZCB0byBlbm91Z2ggdG8gc3RvcmUNCj4+Pj4NCj4+
Pj4gcy90by90byBiZS8NCj4+Pj4NCj4+Pj4+ICsgKiBNSU4oQkFDS1VQX01BWF9CT1VOQ0VfQlVG
RkVSLCBAZW5kIC0gQHN0YXJ0KSBieXRlcw0KPj4+Pj4gKyAqLw0KPj4+Pj4gwqDCoCBzdGF0aWMg
aW50IGNvcm91dGluZV9mbiBiYWNrdXBfY293X3dpdGhfYm91bmNlX2J1ZmZlcihCYWNrdXBCbG9j
a0pvYiAqam9iLA0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IHN0YXJ0LA0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQ2NF90IGVuZCwNCj4+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ym9vbCBpc193cml0ZV9ub3RpZmllciwNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCAqZXJyb3JfaXNfcmVhZCwNCj4+Pj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQg
Kipib3VuY2VfYnVmZmVyKQ0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqYm91bmNlX2J1ZmZlcikNCj4+Pj4+IMKgwqAgew0KPj4+
Pj4gwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+Pj4+PiDCoMKgwqDCoMKgwqAgQmxvY2tCYWNrZW5k
ICpibGsgPSBqb2ItPmNvbW1vbi5ibGs7DQo+Pj4+PiAtwqDCoMKgIGludCBuYnl0ZXM7DQo+Pj4+
PiArwqDCoMKgIGludCBuYnl0ZXMsIHJlbWFpbmluZ19ieXRlczsNCj4+Pj4+IMKgwqDCoMKgwqDC
oCBpbnQgcmVhZF9mbGFncyA9IGlzX3dyaXRlX25vdGlmaWVyID8gQkRSVl9SRVFfTk9fU0VSSUFM
SVNJTkcgOiAwOw0KPj4+Pj4gwqDCoMKgwqDCoMKgIGFzc2VydChRRU1VX0lTX0FMSUdORUQoc3Rh
cnQsIGpvYi0+Y2x1c3Rlcl9zaXplKSk7DQo+Pj4+PiAtwqDCoMKgIGJkcnZfcmVzZXRfZGlydHlf
Yml0bWFwKGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LCBqb2ItPmNsdXN0ZXJfc2l6ZSk7DQo+Pj4+
PiAtwqDCoMKgIG5ieXRlcyA9IE1JTihqb2ItPmNsdXN0ZXJfc2l6ZSwgam9iLT5sZW4gLSBzdGFy
dCk7DQo+Pj4+PiAtwqDCoMKgIGlmICghKmJvdW5jZV9idWZmZXIpIHsNCj4+Pj4+IC3CoMKgwqDC
oMKgwqDCoCAqYm91bmNlX2J1ZmZlciA9IGJsa19ibG9ja2FsaWduKGJsaywgam9iLT5jbHVzdGVy
X3NpemUpOw0KPj4+Pj4gLcKgwqDCoCB9DQo+Pj4+PiArwqDCoMKgIGJkcnZfcmVzZXRfZGlydHlf
Yml0bWFwKGpvYi0+Y29weV9iaXRtYXAsIHN0YXJ0LCBlbmQgLSBzdGFydCk7DQo+Pj4+PiArwqDC
oMKgIG5ieXRlcyA9IE1JTihlbmQgLSBzdGFydCwgam9iLT5sZW4gLSBzdGFydCk7DQo+Pj4+PiAt
wqDCoMKgIHJldCA9IGJsa19jb19wcmVhZChibGssIHN0YXJ0LCBuYnl0ZXMsICpib3VuY2VfYnVm
ZmVyLCByZWFkX2ZsYWdzKTsNCj4+Pj4+IC3CoMKgwqAgaWYgKHJldCA8IDApIHsNCj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoCB0cmFjZV9iYWNrdXBfZG9fY293X3JlYWRfZmFpbChqb2IsIHN0YXJ0LCBy
ZXQpOw0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChlcnJvcl9pc19yZWFkKSB7DQo+Pj4+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZXJyb3JfaXNfcmVhZCA9IHRydWU7DQo+Pj4+PiArDQo+
Pj4+PiArwqDCoMKgIHJlbWFpbmluZ19ieXRlcyA9IG5ieXRlczsNCj4+Pj4+ICvCoMKgwqAgd2hp
bGUgKHJlbWFpbmluZ19ieXRlcykgew0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGludCBjaHVuayA9
IE1JTihCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIsIHJlbWFpbmluZ19ieXRlcyk7DQo+Pj4+PiAr
DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gYmxrX2NvX3ByZWFkKGJsaywgc3RhcnQsIGNo
dW5rLCBib3VuY2VfYnVmZmVyLCByZWFkX2ZsYWdzKTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAocmV0IDwgMCkgew0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJhY2VfYmFja3Vw
X2RvX2Nvd19yZWFkX2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChlcnJvcl9pc19yZWFkKSB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICplcnJvcl9pc19yZWFkID0gdHJ1ZTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH0NCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZmFpbDsNCj4+
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCBnb3RvIGZh
aWw7DQo+Pj4+PiAtwqDCoMKgIH0NCj4+Pj4+IC3CoMKgwqAgcmV0ID0gYmxrX2NvX3B3cml0ZShq
b2ItPnRhcmdldCwgc3RhcnQsIG5ieXRlcywgKmJvdW5jZV9idWZmZXIsDQo+Pj4+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBqb2ItPndyaXRlX2ZsYWdz
KTsNCj4+Pj4+IC3CoMKgwqAgaWYgKHJldCA8IDApIHsNCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCB0
cmFjZV9iYWNrdXBfZG9fY293X3dyaXRlX2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+Pj4+IC3C
oMKgwqDCoMKgwqDCoCBpZiAoZXJyb3JfaXNfcmVhZCkgew0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKmVycm9yX2lzX3JlYWQgPSBmYWxzZTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBy
ZXQgPSBibGtfY29fcHdyaXRlKGpvYi0+dGFyZ2V0LCBzdGFydCwgY2h1bmssIGJvdW5jZV9idWZm
ZXIsDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGpvYi0+d3JpdGVfZmxhZ3MpOw0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChy
ZXQgPCAwKSB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cmFjZV9iYWNrdXBfZG9f
Y293X3dyaXRlX2ZhaWwoam9iLCBzdGFydCwgcmV0KTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChlcnJvcl9pc19yZWFkKSB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICplcnJvcl9pc19yZWFkID0gZmFsc2U7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGZhaWw7DQo+Pj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgZ290byBmYWls
Ow0KPj4+Pj4gKw0KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0YXJ0ICs9IGNodW5rOw0KPj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIHJlbWFpbmluZ19ieXRlcyAtPSBjaHVuazsNCj4+Pj4+IMKgwqDCoMKg
wqDCoCB9DQo+Pj4+PiDCoMKgwqDCoMKgwqAgcmV0dXJuIG5ieXRlczsNCj4+Pj4+IEBAIC0zMDEs
OSArMzEzLDE0IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGJhY2t1cF9kb19jb3coQmFja3Vw
QmxvY2tKb2IgKmpvYiwNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KCFqb2ItPnVzZV9jb3B5X3JhbmdlKSB7DQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoIWJvdW5jZV9idWZmZXIpIHsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc2l6ZV90IGxlbiA9IE1JTihCQUNLVVBfTUFYX0JPVU5DRV9CVUZGRVIsDQo+Pj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBNQVgoZGlydHlfZW5kIC0gc3RhcnQsIGVuZCAtIGRpcnR5X2VuZCkpOw0KPj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib3VuY2VfYnVmZmVyID0gYmxrX3RyeV9ibG9j
a2FsaWduKGpvYi0+Y29tbW9uLmJsaywgbGVuKTsNCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH0NCj4+Pj4NCj4+Pj4gSWYgeW91IHVzZSBfdHJ5XywgeW91IHNob3VsZCBwcm9iYWJseSBh
bHNvIGNoZWNrIHdoZXRoZXIgaXQgc3VjY2VlZGVkLg0KPj4+DQo+Pj4gT29wcywgeW91IGFyZSBy
aWdodCwgb2YgY291cnNlLg0KPj4+DQo+Pj4+DQo+Pj4+IEFueXdheSwgSSB3b25kZXIgd2hldGhl
ciBpdOKAmWQgYmUgYmV0dGVyIHRvIGp1c3QgYWxsb2NhdGUgdGhpcyBidWZmZXINCj4+Pj4gb25j
ZSBwZXIgam9iICh0aGUgZmlyc3QgdGltZSB3ZSBnZXQgaGVyZSwgcHJvYmFibHkpIHRvIGJlIG9m
IHNpemUNCj4+Pj4gQkFDS1VQX01BWF9CT1VOQ0VfQlVGRkVSIGFuZCBwdXQgaXQgaW50byBCYWNr
dXBCbG9ja0pvYi7CoCAoQW5kIG1heWJlIGFkZA0KPj4+PiBhIGJ1Zi1zaXplIHBhcmFtZXRlciBz
aW1pbGFyIHRvIHdoYXQgdGhlIG1pcnJvciBqb2JzIGhhdmUuKQ0KPj4+Pg0KPj4+DQo+Pj4gT25j
ZSBwZXIgam9iIHdpbGwgbm90IHdvcmssIGFzIHdlIG1heSBoYXZlIHNldmVyYWwgZ3Vlc3Qgd3Jp
dGVzIGluIHBhcmFsbGVsIGFuZCB0aGVyZWZvcmUNCj4+PiBzZXZlcmFsIHBhcmFsbGVsIGNvcHkt
YmVmb3JlLXdyaXRlIG9wZXJhdGlvbnMuDQo+Pg0KPj4gSG0uwqAgSeKAmW0gbm90IHF1aXRlIGhh
cHB5IHdpdGggdGhhdCBiZWNhdXNlIGlmIHRoZSBndWVzdCBqdXN0IGlzc3VlcyBtYW55DQo+PiBs
YXJnZSBkaXNjYXJkcyBpbiBwYXJhbGxlbCwgdGhpcyBtZWFucyB0aGF0IHFlbXUgd2lsbCBhbGxv
Y2F0ZSBhIGxhcmdlDQo+PiBhbW91bnQgb2YgbWVtb3J5Lg0KPj4NCj4+IEl0IHdvdWxkIGJlIG5p
Y2UgaWYgdGhlcmUgd2FzIGEgc2ltcGxlIHdheSB0byBrZWVwIHRyYWNrIG9mIHRoZSB0b3RhbA0K
Pj4gbWVtb3J5IHVzYWdlIGFuZCBsZXQgcmVxdWVzdHMgeWllbGQgaWYgdGhleSB3b3VsZCBleGNl
ZWQgaXQuDQo+IA0KPiBBZ3JlZSwgaXQgc2hvdWxkIGJlIGZpeGVkIGFueXdheS4NCj4gDQoNCg0K
QnV0IHN0aWxsLi4NCg0KU3luY2hyb25vdXMgbWlycm9yIGFsbG9jYXRlcyBmdWxsLXJlcXVlc3Qg
YnVmZmVycyBvbiBndWVzdCB3cml0ZS4gSXMgaXQgY29ycmVjdD8NCg0KSWYgd2UgYXNzdW1lIHRo
YXQgaXQgaXMgY29ycmVjdCB0byBkb3VibGUgbWVtb3J5IHVzYWdlIG9mIGd1ZXN0IG9wZXJhdGlv
bnMsIHRoYW4gZm9yIGJhY2t1cA0KdGhlIHByb2JsZW0gaXMgb25seSBpbiB3cml0ZV96ZXJvIGFu
ZCBkaXNjYXJkIHdoZXJlIGd1ZXN0LWFzc3VtZWQgbWVtb3J5IHVzYWdlIHNob3VsZCBiZSB6ZXJv
Lg0KQW5kIGlmIHdlIHNob3VsZCBkaXN0aW5ndWlzaCB3cml0ZXMgZnJvbSB3cml0ZV96ZXJvZXMg
YW5kIGRpc2NhcmQsIGl0J3MgYmV0dGVyIHRvIHBvc3Rwb25lIHRoaXMNCmltcHJvdmVtZW50IHRv
IGJlIGFmdGVyIGJhY2t1cC10b3AgZmlsdGVyIG1lcmdlZC4NCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

