Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E49DC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE0420863
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RlfTYpan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE0420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd9WK-0006Cy-86
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 04:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40158)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hd9V8-0005YG-Ak
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hd9V6-0005I0-SE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:29:58 -0400
Received: from mail-eopbgr60090.outbound.protection.outlook.com
 ([40.107.6.90]:14062 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hd9V3-0005DT-6W; Tue, 18 Jun 2019 04:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoR3vZBIX3BWhmQvJrwCvQoRhz73jWWrLz6VoOjEFl8=;
 b=RlfTYpanOE1iQBUjvN0XeAWJpK7TtujJwlIlrV81YUPHcu9cjwEXskXCJb3IZhTfv7WyRtzNFNekxS2gL0DJcjN2OMz3a+EhNKU35t1F4ypCrYbmpDCzgA0JP2q8wmFQSPC8S3NvRR8eywUopl8kKMTEkNw32EuPtG1caipewzA=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4728.eurprd08.prod.outlook.com (10.255.79.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 08:29:49 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 08:29:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v8 4/7] block: introduce backup-top filter driver
Thread-Index: AQHVFjXHKN4zfc/OLkS/ttIGgp7hZ6aZ1OmAgAFRQoCAAA7mAIAAa5yAgAALVACABBiRAIAASKGAgAAP7YCAAAJrAIAABpmAgAD50wCAABEfgIAAAnWA
Date: Tue, 18 Jun 2019 08:29:49 +0000
Message-ID: <78aa87cc-f6dd-7437-522c-715cb4b7992a@virtuozzo.com>
References: <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
 <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
 <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>
 <9a6a5790-c9ff-e8a4-3a41-4aebe554ae1c@redhat.com>
 <20190617155315.GK7397@linux.fritz.box>
 <b86c6a8f-7a89-58ca-6966-b2f00aff0f2b@redhat.com>
 <20190617162531.GM7397@linux.fritz.box>
 <02e338ba-5e5e-240e-ddcb-d8e7840d0b06@virtuozzo.com>
 <20190618082057.GC4296@localhost.localdomain>
In-Reply-To: <20190618082057.GC4296@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:7:28::26) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618112945884
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48d19206-249f-450a-bafb-08d6f3c720de
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4728; 
x-ms-traffictypediagnostic: DBBPR08MB4728:
x-microsoft-antispam-prvs: <DBBPR08MB4728D00F10D8A523C79E66A3C1EA0@DBBPR08MB4728.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39850400004)(189003)(199004)(446003)(305945005)(229853002)(99286004)(2616005)(52116002)(486006)(102836004)(68736007)(26005)(6506007)(14454004)(478600001)(3846002)(53936002)(76176011)(6116002)(6246003)(8936002)(4326008)(25786009)(6486002)(6916009)(14444005)(6512007)(256004)(386003)(73956011)(71200400001)(66946007)(71190400001)(6436002)(81156014)(81166006)(8676002)(186003)(66066001)(316002)(66446008)(66476007)(31686004)(11346002)(36756003)(54906003)(66556008)(31696002)(64756008)(7736002)(2906002)(86362001)(476003)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4728;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vFxvBRZ/pnovytopVQ54jE5tqycItDTWsJqEYtnAcYTNrhZAxnCz3H9+fH2RbfbLMg4QPSH4w6Ct3uvZk2SY/Cl9KsC7MMM/HbCHcBZH8F7x18frk3g4FBbgCj57r7gJeIwMUIEe5HQJKgzx14MyNsIixqJ6n1BPmFGlh1crlDebJYWVLCeNgGUzCY3FBIwH+Z4YMARSM9n+8OL8hHbl0JqhpAFtGcEcvodIUndkC6+EHfByhyvAt4qYs/EyzcGUwuICmde6x2T84M3n2HF7sky7hEZu9FjC1uCqaw0oRnZyrrXU0qoo6niFsohYIU7vPFevwMMFa/0kIvim1KZd7zRv/Cqrt6YuEbmWGGufLM++cTWVGs00bp7gog8fd3V2yCwt9lTKjXxi/8DmpxLPRPXg0ZY7EPdZN4+aOQNDilQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCA9A371952DB043871159B722B716D2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d19206-249f-450a-bafb-08d6f3c720de
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 08:29:49.7841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4728
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.90
Subject: Re: [Qemu-devel] [PATCH v8 4/7] block: introduce backup-top filter
 driver
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTguMDYuMjAxOSAxMToyMCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTguMDYuMjAxOSB1bSAw
OToxOSBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDE3
LjA2LjIwMTkgMTk6MjUsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gVGhlIGZpcnN0IHN0ZXAgd291
bGQgYmUgbWFraW5nIHRoZSBibG9jayBkcml2ZXJzIGZ1bGwgcmVwbGFjZW1lbnRzIG9mDQo+Pj4g
dGhlIG9sZCB0aGluZ3MsIHdoaWNoIHVuZm9ydHVuYXRlbHkgaXNuJ3QgdHJ1ZSB0b2RheS4NCj4+
Pg0KPj4+IEFmdGVyIHlvdXIgImRlYWwgd2l0aCBmaWx0ZXJzIiBzZXJpZXMsIHdlIHNob3VsZCBi
ZSBhIGxvdCBjbG9zZXIgZm9yIHRoZQ0KPj4+IGNvcmUgaW5mcmFzdHJ1Y3R1cmUgYXQgbGVhc3Qu
DQo+Pj4NCj4+PiBOb3Qgc3VyZSBhYm91dCBjb3B5LW9uLXJlYWQsIGJ1dCBJIGtub3cgdGhhdCB0
aHJvdHRsZSBzdGlsbCBkb2Vzbid0IGhhdmUNCj4+PiBmZWF0dXJlIHBhcml0eSB3aXRoIC1kcml2
ZSB0aHJvdHRsaW5nLiBBdCBsZWFzdCBJJ20gcHJldHR5IHN1cmUgdGhhdA0KPj4+IHNvbWV0aGlu
ZyBhYm91dCBjaGFuZ2luZyB0aGUgZ3JvdXAgb3IgZ3JvdXAgb3B0aW9ucyBhdCBydW50aW1lIChh
bmQgbm90DQo+Pj4ganVzdCBkcm9wcGluZyB0aGUgeC0pIHdhcyBtaXNzaW5nLg0KPj4NCj4+IE9L
LCB0aGFua3MsIEkgdW5kZXJzdGFuZCBub3cgdGhhdCBpbXBsaWNpdCBmaWx0ZXJzIGFyZSBub3Qg
anVzdCBhDQo+PiBmZWF0dXJlIGJ1dCBjb21wYXRpYmlsaXR5IG1lY2hhbmlzbS4NCj4+DQo+PiBT
bywgY2FuIHdlIGF0IHNvbWUgcG9pbnQgZGVwcmVjYXRlICJvcHRpb25hbGl0eSIgb2YgZmlsdGVy
LW5vZGUtbmFtZQ0KPj4gcGFyYW1ldGVycyBvZiBqb2JzLCBpbiBhZGRpdGlvbiB0byBkZXByZWNh
dGlvbiBvZiB0aGluZ3MgbGlrZSBvbGQNCj4+IGNvcHktb24tcmVhZCBvcHRpb24/ICBBbmQgYWN0
dWFsbHkgZGVwcmVjYXRlIGltcGxpY2l0IGZpbHRlcnMgYnkgdGhpcz8NCj4gDQo+IEhtLCBJJ20g
bm90IHN1cmUgaWYgd2UgaGF2ZSBldmVyIG1vdmVkIGFuIG9wdGlvbmFsIGZlYXR1cmUgdG8gcmVx
dWlyZWQsDQo+IGFuZCBob3cgdG8gY29tbXVuaWNhdGUgdGhpcyB0byBsaWJ2aXJ0LCBidXQgdGhp
cyB3b3VsZCBiZSBpZGVhbCwgeWVzLg0KPiANCj4+Pj4+Pj4+PiBCdXQgc2hvdWxkIHJlYWxseSBm
aWx0ZXIgZG8gdGhhdCBqb2IsIG9yIGl0IGlzIGhlcmUgb25seSB0byBkbyBDQlc/IE1heWJlIHRh
cmdldA0KPj4+Pj4+Pj4+IG11c3QgaGF2ZSBhbm90aGVyIHBhcmVudCB3aGljaCB3aWxsIGNhcmUg
YWJvdXQgZmx1c2hpbmcuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBPaywgSSB0aGluayBJJ2xsIGZs
dXNoIHRhcmdldCBoZXJlIHRvbyBmb3Igc2FmZXR5LCBhbmQgbGVhdmUgYSBjb21tZW50LCB0aGF0
IHNvbWV0aGluZw0KPj4+Pj4+Pj4+IHNtYXJ0ZXIgd291bGQgYmUgYmV0dGVyLg0KPj4+Pj4+Pj4+
IChvciwgaWYgd2UgZGVjaWRlIHRvIGZsdXNoIGFsbCBjaGlsZHJlbiBieSBkZWZhdWx0IGluIGdl
bmVyaWMgY29kZSwgSSdsbCBkcm9wIHRoaXMgaGFuZGxlcikNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBb
MV0gVGhpbmtpbmcgbW9yZSBhYm91dCB0aGlzLCBmb3Igbm9ybWFsIGJhY2t1cHMgdGhlIHRhcmdl
dCBmaWxlIGRvZXMNCj4+Pj4+Pj4+IG5vdCByZWZsZWN0IGEgdmFsaWQgZGlzayBzdGF0ZSB1bnRp
bCB0aGUgYmFja3VwIGlzIGRvbmU7IGp1c3QgbGlrZSBmb3INCj4+Pj4+Pj4+IHFlbXUtaW1nIGNv
bnZlcnQuICBKdXN0IGxpa2UgcWVtdS1pbWcgY29udmVydCwgdGhlcmUgaXMgdGhlcmVmb3JlIG5v
DQo+Pj4+Pj4+PiByZWFzb24gdG8gZmx1c2ggdGhlIHRhcmdldCB1bnRpbCB0aGUgam9iIGlzIGRv
bmUuDQo+Pj4+Pg0KPj4+Pj4gRGVwZW5kcywgdGhlIHRhcmdldCBjb3VsZCBoYXZlIHRoZSBzb3Vy
Y2UgYXMgaXRzIGJhY2tpbmcgZmlsZSAobGlrZQ0KPj4+Pj4gZmxlZWNpbmcsIGJ1dCB3aXRob3V0
IGV4cG9ydGluZyBpdCByaWdodCBub3cpLCBhbmQgdGhlbiB5b3UgY291bGQgYWx3YXlzDQo+Pj4+
PiBoYXZlIGEgY29uc2lzdGVudCB2aWV3IG9uIHRoZSB0YXJnZXQuIFdlbGwsIGFsbW9zdC4NCj4+
Pj4+DQo+Pj4+PiBBbG1vc3QgYmVjYXVzZSB0byBndWFyYW50ZWUgdGhpcywgd2UnZCBoYXZlIHRv
IGZsdXNoIGJldHdlZW4gZWFjaCBDQlcNCj4+Pj4+IGFuZCB0aGUgY29ycmVzcG9uZGluZyB3cml0
ZSB0byB0aGUgc2FtZSBibG9jaywgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIG9sZA0KPj4+Pj4gZGF0
YSBpcyBiYWNrZWQgdXAgYmVmb3JlIGl0IGlzIG92ZXJ3cml0dGVuLg0KPj4+Pg0KPj4+PiBZZXMs
IHRoYXTigJlzIHdoYXQgSSBtZWFudCBieSDigJxlbmZvcmNlIG9uIHRoZSBob3N0IHRoYXQgdGhl
IHRhcmdldCBpcw0KPj4+PiBhbHdheXMgZmx1c2hlZCBiZWZvcmUgdGhlIHNvdXJjZeKAnS4gIFdl
bGwsIEkgbWVhbnQgdG8gc2F5IHRoZXJlIGlzIG5vDQo+Pj4+IGdvb2Qgd2F5IG9mIGRvaW5nIHRo
YXQsIGFuZCBJIGtpbmQgb2YgZG9u4oCZdCBjb25zaWRlciB0aGlzIGEgZ29vZCB3YXkuDQo+Pj4+
DQo+Pj4+PiBPZiBjb3Vyc2UsIHRoaXMgd291bGQgcGVyZm9ybSBhYm91dCBhcyBiYWRseSBhcyBp
bnRlcm5hbCBDT1cgaW4gcWNvdzIuLi4NCj4+Pj4+IFNvIHByb2JhYmx5IG5vdCBhIGd1YXJhbnRl
ZSB3ZSBzaG91bGQgYmUgbWFraW5nIGJ5IGRlZmF1bHQuIEJ1dCBpdCBtaWdodA0KPj4+Pj4gbWFr
ZSBzZW5zZSBhcyBhbiBvcHRpb24uDQo+Pj4+DQo+Pj4+IEkgZG9u4oCZdCBrbm93LiAg4oCcVXNl
IHRoaXMgb3B0aW9uIHNvIHlvdXIgZGF0YSBpc27igJl0IGxvc3QgaW4gY2FzZSBvZiBhDQo+Pj4+
IHBvd2VyIGZhaWx1cmUsIGJ1dCBpdCBtYWtlcyBldmVyeXRoaW5nIHByZXR0eSBzbG934oCdPyAg
V2hvIGlzIGdvaW5nIHRvIGRvDQo+Pj4+IGV4cGxpY2l0bHkgZW5hYmxlIHRoYXQgKGJlZm9yZSB0
aGVpciBmaXJzdCBkYXRhIGxvc3MpPw0KPj4+DQo+Pj4gTWF5YmUgdGhlIGJhY2t1cCBqb2Igd2Fz
bid0IHRoYXQgY2xldmVyIGFmdGVyIGFsbC4gQXQgbGVhc3QgaWYgeW91IGNhcmUNCj4+PiBhYm91
dCBrZWVwaW5nIHRoZSBwb2ludC1pbi10aW1lIHNuYXBzaG90IGF0IHRoZSBzdGFydCBvZiB0aGUg
YmFja3VwIGpvYg0KPj4+IGluc3RlYWQgb2YganVzdCByZXRyeWluZyBhbmQgZ2V0dGluZyBhIHNu
YXBzaG90IG9mIGEgZGlmZmVyZW50IHBvaW50IGluDQo+Pj4gdGltZSB0aGF0IGlzIGp1c3QgYXMg
Z29vZC4NCj4+Pg0KPj4+IElmIHlvdSBkbyBjYXJlIGFib3V0IHRoZSBzcGVjaWZpYyBwb2ludCBp
biB0aW1lLCB0aGUgc2FmZSB3YXkgdG8gZG8gaXQNCj4+PiBpcyB0byB0YWtlIGEgc25hcHNob3Qg
YW5kIGNvcHkgdGhhdCBhd2F5LCBhbmQgdGhlbiBkZWxldGUgdGhlIHNuYXBzaG90DQo+Pj4gYWdh
aW4uDQo+Pj4NCj4+PiBUaGUgb25seSBwcm9ibGVtIGlzIHRoYXQgbWVyZ2luZyBleHRlcm5hbCBz
bmFwc2hvdHMgaXMgc2xvdyBhbmQgeW91IGVuZA0KPj4+IHVwIHdyaXRpbmcgdGhlIG5ldyBkYXRh
IHR3aWNlLiBJZiBvbmx5IHdlIGhhZCBhIENPVyBpbWFnZSBmb3JtYXQuLi4gOi0pDQo+Pg0KPj4g
U28sIEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgcmVhc29uIG9mIGZsdXNoaW5nIGJhY2t1
cCB0YXJnZXQgaW4gYQ0KPj4gbWVhbnRpbWUuICBCYWNrdXAgdGFyZ2V0IHJlbWFpbnMgaW52YWxp
ZCB1bnRpbCB0aGUgc3VjY2Vzc2Z1bCBlbmQgb2YNCj4+IHRoZSBqb2IsIGF0IHdoaWNoIHBvaW50
IHdlIGRlZmluaXRlbHkgZmx1c2ggdGFyZ2V0LCBidXQgb25seSBvbmNlLg0KPj4NCj4+IElmIG5v
ZGUgY3Jhc2hlcyBkdXJpbmcgYmFja3VwLCBiYWNrdXAgd291bGQgYmUgaW52YWxpZCBpbmRlcGVu
ZGVudGx5DQo+PiBvZiB3ZXJlIHRoZXJlIGZsdXNoZXMgYWZ0ZXIgZWFjaCB3cml0ZSAob3IgYmV0
dGVyIGp1c3QgZW5hYmxlDQo+PiBPX0RJUkVDVCkgb3Igbm90Lg0KPiANCj4gU2F5IHlvdXIgVk0g
aXMgcnVubmluZyBvbiBkaXNrLnFjb3cyIGFuZCB5b3UgdXNlIGEgYmFja3VwIGpvYiB0byBjb3B5
DQo+IGRhdGEgdG8gYmFja3VwLnFjb3cyLiBBdCBzb21lIHBvaW50LCB0aGUgaG9zdCBjcmFzaGVz
LiBJZiB3ZSBtYWRlIHN1cmUNCj4gdGhhdCBldmVyeSBDQlcgdG8gYmFja3VwLnFjb3cyIGhhcyBj
b21wbGV0ZWQgYmVmb3JlIHdlIHdyaXRlIG5ldyBkYXRhIHRvDQo+IGRpc2sucWNvdzIsIGJhY2t1
cC5xY293MiBjb250YWlucyB2YWxpZCBkYXRhIHRoYXQgcmVwcmVzZW50cyB0aGUgc3RhdGUNCj4g
YXQgdGhlIHN0YXJ0IG9mIHRoZSBiYWNrdXAgam9iIGFzIGxvbmcgYXMgeW91IHVzZSBkaXNrLnFj
b3cyIGFzIGl0cw0KPiBiYWNraW5nIGZpbGUuDQo+IA0KPiBUaGUgb25seSB3YXkgdG8gZW5zdXJl
IHRoZSByaWdodCBvcmRlciBpcyBmbHVzaGluZyBiZXR3ZWVuIHRoZSB0d28NCj4gb3BlcmF0aW9u
cy4gSWYgeW91IGRvbid0IGRvIHRoYXQsIHRoZW4geWVzLCB5b3VyIGJhY2tpbmcgaXMgaW52YWxp
ZA0KPiBiZWZvcmUgaXQgaGFzIGNvbXBsZXRlZC4NCj4gDQo+IE9fRElSRUNUIGRvZXNuJ3QgZ3Vh
cmFudGVlIHRoYXQgdGhlIGRhdGEgaXMgb24gZGlzaywgb25seSBhIGZsdXNoIGRvZXMNCj4gdGhh
dC4gTWF5YmUgeW91ciBjaGFuY2VzIHRoYXQgdGhpbmdzIGFjdHVhbGx5IG1ha2UgaXQgdG8gdGhl
IGRpc2sgaW4NCj4gY2FzZSBvZiBhIGhvc3QgY3Jhc2ggYXJlIGhpZ2hlciBpZiBpdCBzaXRzIGlu
IHRoZSBkaXNrIGNhY2hlIHJhdGhlciB0aGFuDQo+IGluIHRoZSBob3N0J3MgUkFNLCBidXQgdGhl
cmUgaXMgbm8gZ3VhcmFudGVlIHdpdGhvdXQgYSBmbHVzaC4NCj4gDQo+IE5vdyBmbHVzaGluZyB0
aGUgdGFyZ2V0IHdoZW4gdGhlIGd1ZXN0IGZsdXNoZXMgaXRzIGRpc2sgZG9lc24ndCBnaXZlIHlv
dQ0KPiBuZXcgZ3VhcmFudGVlcy4gTWF5YmUgaXQgaW5jcmVhc2VzIHlvdXIgY2hhbmNlcyB0aGF0
IHlvdSdyZSBsdWNreSBhbmQNCj4geW91ciBkYXRhIGlzIGNvcnJlY3QsIGJ1dCB5b3Ugd29uJ3Qg
YmUgYWJsZSB0byB0ZWxsLiBTby4uLiBub3QgcmVhbGx5IGENCj4gcmVhc29uIG5vdCB0byBkbyBp
dCwgYnV0IGl0J3MgcHJvYmFibHkga2luZCBvZiB1c2VsZXNzLg0KPiANCg0KQWxsIGNsZWFyIG5v
dywgdGhhbmtzIQ0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

