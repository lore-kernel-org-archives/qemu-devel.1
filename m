Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28CBC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904B320679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JR30K2bP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904B320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54354 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd8RA-0004xX-MQ
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 03:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51748)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hd8PI-00047q-VB
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hd8PH-0007zS-LN
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:19:52 -0400
Received: from mail-eopbgr50130.outbound.protection.outlook.com
 ([40.107.5.130]:60078 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hd8PE-0007xM-5q; Tue, 18 Jun 2019 03:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+0GhCJzzfL3TYms5jNVcOhEKXVkYfNt1OArrO4AEHE=;
 b=JR30K2bPk0PuAyHx6cthdoIDinGFFO6YDO6tr5RBGQ3SKVJhAZGdMmOKufqbjyM0sEvNFR/m9B0ltFfjXmnPLHLvG9c8fDDTRzvlErBKcdYuwua35bDav5RkZHXrCVyRI6xksUxb+AGEthZ4LEplcoeISSVXULiWeewE/AYkNHs=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4679.eurprd08.prod.outlook.com (10.255.78.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 18 Jun 2019 07:19:43 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 07:19:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Thread-Topic: [PATCH v8 4/7] block: introduce backup-top filter driver
Thread-Index: AQHVFjXHKN4zfc/OLkS/ttIGgp7hZ6aZ1OmAgAFRQoCAAA7mAIAAa5yAgAALVACABBiRAIAASKGAgAAP7YCAAAJrAIAABpmAgAD50wA=
Date: Tue, 18 Jun 2019 07:19:43 +0000
Message-ID: <02e338ba-5e5e-240e-ddcb-d8e7840d0b06@virtuozzo.com>
References: <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
 <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
 <46f18bb5-f123-b20a-7cb9-97caedae8290@redhat.com>
 <13b8c3d7-dd95-d42f-e7bc-86907444b78a@virtuozzo.com>
 <9a6a5790-c9ff-e8a4-3a41-4aebe554ae1c@redhat.com>
 <20190617155315.GK7397@linux.fritz.box>
 <b86c6a8f-7a89-58ca-6966-b2f00aff0f2b@redhat.com>
 <20190617162531.GM7397@linux.fritz.box>
In-Reply-To: <20190617162531.GM7397@linux.fritz.box>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0016.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::26)
 To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190618101940733
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfcd64d6-a2ce-487c-de4a-08d6f3bd55cc
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4679; 
x-ms-traffictypediagnostic: DBBPR08MB4679:
x-microsoft-antispam-prvs: <DBBPR08MB4679F75EF4047963BA5221B8C1EA0@DBBPR08MB4679.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(136003)(366004)(376002)(396003)(189003)(199004)(386003)(73956011)(7736002)(6506007)(6512007)(99286004)(102836004)(316002)(66066001)(229853002)(6246003)(476003)(486006)(81156014)(4326008)(81166006)(8676002)(53936002)(31696002)(66476007)(66556008)(66446008)(64756008)(76176011)(25786009)(86362001)(52116002)(14454004)(71190400001)(5660300002)(71200400001)(3846002)(26005)(6116002)(66946007)(305945005)(8936002)(478600001)(31686004)(68736007)(54906003)(446003)(6486002)(186003)(36756003)(11346002)(256004)(110136005)(6436002)(2616005)(2906002)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4679;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iozYOrx/wGinSOyMLuNkgFoHpeeFN2rjoPPG6ZPN8WAecBum4Ow3pYO2oF1SBEBrsbsv6/SVuWuNUpJM0KWXbEL+9FGEsO5iRrtg0O1OUqTSGni03rctyUlBM/KY9NqjQItyvuVsWY73vbNW3MZ4NHnE/BLvBqoVpdWPzmUWsUq7/Kj9lKv9Je3C3ZJwxNE9I0ub4hWR8yCSZLtOTX0hQBtU+C1O8WnQxQavMQk819Ha9DNF8xkH+HLIT/Zqvc0jVkX5Bt7trNRbeylyIWSpiUTvxwLbZRXyMlpFNSazwsKSwfWMQPp8NhjccJxRvELRti1xOusrpaLbisxUpjn1epDUOVv0j820ql96m6rgSRhX/NUI8H+yob956fTQ9Hw6qgmiCyecHnyxGxX/Qf55coIarYbfRO11R9wxQ4u9ZG4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85E151850D82A9439EF675FC8530EFB4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcd64d6-a2ce-487c-de4a-08d6f3bd55cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 07:19:43.8579 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4679
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.130
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTcuMDYuMjAxOSAxOToyNSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTcuMDYuMjAxOSB1bSAx
ODowMSBoYXQgTWF4IFJlaXR6IGdlc2NocmllYmVuOg0KPj4+Pj4gU2hvdWxkIG5ldyBpbXBsaWNp
dC9leHBsaWNpdA0KPj4+Pj4gZmlsdGVycyBiZSBjcmVhdGVkIGFib3ZlIG9yIHVuZGVyIHRoZW0/
DQo+Pj4+DQo+Pj4+IFRoYXQgd2FzIGFsd2F5cyB0aGUgbW9zdCBkaWZmaWN1bHQgcXVlc3Rpb24g
d2UgaGFkIHdoZW4gd2UgaW50cm9kdWNlZA0KPj4+PiBmaWx0ZXJzLg0KPj4+Pg0KPj4+PiBUaGUg
cHJvYmxlbSBpcyB0aGF0IHdlIG5ldmVyIGFuc3dlcmVkIGl0IGluIG91ciBjb2RlIGJhc2UuDQo+
Pj4+DQo+Pj4+IE9uZSBkYXksIHdlIGp1c3QgYWRkZWQgZmlsdGVycyAo4oCcbGV04oCZcyBzZWUg
d2hhdCBoYXBwZW5z4oCdKSwgYW5kIGluIHRoZQ0KPj4+PiBiZWdpbm5pbmcsIHRoZXkgd2VyZSBh
bGwgZXhwbGljaXQsIHNvIHdlIHN0aWxsIGRpZG7igJl0IGhhdmUgdG8gYW5zd2VyDQo+Pj4+IHRo
aXMgcXVlc3Rpb24gKGluIGNvZGUpLiAgVGhlbiBqb2IgZmlsdGVycyB3ZXJlIGFkZGVkLCBhbmQg
d2Ugc3RpbGwNCj4+Pj4gZGlkbuKAmXQgaGF2ZSB0bywgYmVjYXVzZSB0aGV5IHNldCBibG9ja2Vy
cyBzbyB0aGUgZ3JhcGggY291bGRu4oCZdCBiZQ0KPj4+PiByZW9yZ2FuaXplZCB3aXRoIHRoZW0g
aW4gcGxhY2UgYW55d2F5Lg0KPj4+Pg0KPj4+PiBJZiB3ZSBjb252ZXJ0ZWQgY29weS1vbi1yZWFk
PW9uIHRvIGEgQ09SIG5vZGUsIHdlIHdvdWxkIGhhdmUgdG8gYW5zd2VyDQo+Pj4+IHRoYXQgcXVl
c3Rpb24uDQo+Pj4NCj4+PiBUaGF0J3Mgd2h5IHdlIHNob3VsZG4ndCBkbyB0aGF0LCBidXQganVz
dCByZW1vdmUgY29weS1vbi1yZWFkPW9uLiA6LSkNCj4+DQo+PiBBbmQgQkItbGV2ZWwgdGhyb3R0
bGluZywgZmFpciBlbm91Z2guDQo+Pg0KPj4gKEFsdGhvdWdoIHRoZSBmaXJzdCBzdGVwIHdvdWxk
IGJlIHByb2JhYmx5IHRvIG1ha2UgdGhyb3R0bGUgZ3JvdXBzDQo+PiBub24tZXhwZXJpbWVudGFs
PyAgTGlrZSwgZHJvcCB0aGUgeC0gcHJlZml4IGZvciBhbGwgdGhlaXIgcGFyYW1ldGVycy4pDQo+
IA0KPiBUaGUgZmlyc3Qgc3RlcCB3b3VsZCBiZSBtYWtpbmcgdGhlIGJsb2NrIGRyaXZlcnMgZnVs
bCByZXBsYWNlbWVudHMgb2YNCj4gdGhlIG9sZCB0aGluZ3MsIHdoaWNoIHVuZm9ydHVuYXRlbHkg
aXNuJ3QgdHJ1ZSB0b2RheS4NCj4gDQo+IEFmdGVyIHlvdXIgImRlYWwgd2l0aCBmaWx0ZXJzIiBz
ZXJpZXMsIHdlIHNob3VsZCBiZSBhIGxvdCBjbG9zZXIgZm9yIHRoZQ0KPiBjb3JlIGluZnJhc3Ry
dWN0dXJlIGF0IGxlYXN0Lg0KPiANCj4gTm90IHN1cmUgYWJvdXQgY29weS1vbi1yZWFkLCBidXQg
SSBrbm93IHRoYXQgdGhyb3R0bGUgc3RpbGwgZG9lc24ndCBoYXZlDQo+IGZlYXR1cmUgcGFyaXR5
IHdpdGggLWRyaXZlIHRocm90dGxpbmcuIEF0IGxlYXN0IEknbSBwcmV0dHkgc3VyZSB0aGF0DQo+
IHNvbWV0aGluZyBhYm91dCBjaGFuZ2luZyB0aGUgZ3JvdXAgb3IgZ3JvdXAgb3B0aW9ucyBhdCBy
dW50aW1lIChhbmQgbm90DQo+IGp1c3QgZHJvcHBpbmcgdGhlIHgtKSB3YXMgbWlzc2luZy4NCg0K
T0ssIHRoYW5rcywgSSB1bmRlcnN0YW5kIG5vdyB0aGF0IGltcGxpY2l0IGZpbHRlcnMgYXJlIG5v
dCBqdXN0IGEgZmVhdHVyZSBidXQNCmNvbXBhdGliaWxpdHkgbWVjaGFuaXNtLg0KDQpTbywgY2Fu
IHdlIGF0IHNvbWUgcG9pbnQgZGVwcmVjYXRlICJvcHRpb25hbGl0eSIgb2YgZmlsdGVyLW5vZGUt
bmFtZSBwYXJhbWV0ZXJzIG9mIGpvYnMsDQppbiBhZGRpdGlvbiB0byBkZXByZWNhdGlvbiBvZiB0
aGluZ3MgbGlrZSBvbGQgY29weS1vbi1yZWFkIG9wdGlvbj8NCkFuZCBhY3R1YWxseSBkZXByZWNh
dGUgaW1wbGljaXQgZmlsdGVycyBieSB0aGlzPw0KDQo+IA0KPj4+Pj4+PiBCdXQgc2hvdWxkIHJl
YWxseSBmaWx0ZXIgZG8gdGhhdCBqb2IsIG9yIGl0IGlzIGhlcmUgb25seSB0byBkbyBDQlc/IE1h
eWJlIHRhcmdldA0KPj4+Pj4+PiBtdXN0IGhhdmUgYW5vdGhlciBwYXJlbnQgd2hpY2ggd2lsbCBj
YXJlIGFib3V0IGZsdXNoaW5nLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBPaywgSSB0aGluayBJJ2xsIGZs
dXNoIHRhcmdldCBoZXJlIHRvbyBmb3Igc2FmZXR5LCBhbmQgbGVhdmUgYSBjb21tZW50LCB0aGF0
IHNvbWV0aGluZw0KPj4+Pj4+PiBzbWFydGVyIHdvdWxkIGJlIGJldHRlci4NCj4+Pj4+Pj4gKG9y
LCBpZiB3ZSBkZWNpZGUgdG8gZmx1c2ggYWxsIGNoaWxkcmVuIGJ5IGRlZmF1bHQgaW4gZ2VuZXJp
YyBjb2RlLCBJJ2xsIGRyb3AgdGhpcyBoYW5kbGVyKQ0KPj4+Pj4+DQo+Pj4+Pj4gWzFdIFRoaW5r
aW5nIG1vcmUgYWJvdXQgdGhpcywgZm9yIG5vcm1hbCBiYWNrdXBzIHRoZSB0YXJnZXQgZmlsZSBk
b2VzDQo+Pj4+Pj4gbm90IHJlZmxlY3QgYSB2YWxpZCBkaXNrIHN0YXRlIHVudGlsIHRoZSBiYWNr
dXAgaXMgZG9uZTsganVzdCBsaWtlIGZvcg0KPj4+Pj4+IHFlbXUtaW1nIGNvbnZlcnQuICBKdXN0
IGxpa2UgcWVtdS1pbWcgY29udmVydCwgdGhlcmUgaXMgdGhlcmVmb3JlIG5vDQo+Pj4+Pj4gcmVh
c29uIHRvIGZsdXNoIHRoZSB0YXJnZXQgdW50aWwgdGhlIGpvYiBpcyBkb25lLg0KPj4+DQo+Pj4g
RGVwZW5kcywgdGhlIHRhcmdldCBjb3VsZCBoYXZlIHRoZSBzb3VyY2UgYXMgaXRzIGJhY2tpbmcg
ZmlsZSAobGlrZQ0KPj4+IGZsZWVjaW5nLCBidXQgd2l0aG91dCBleHBvcnRpbmcgaXQgcmlnaHQg
bm93KSwgYW5kIHRoZW4geW91IGNvdWxkIGFsd2F5cw0KPj4+IGhhdmUgYSBjb25zaXN0ZW50IHZp
ZXcgb24gdGhlIHRhcmdldC4gV2VsbCwgYWxtb3N0Lg0KPj4+DQo+Pj4gQWxtb3N0IGJlY2F1c2Ug
dG8gZ3VhcmFudGVlIHRoaXMsIHdlJ2QgaGF2ZSB0byBmbHVzaCBiZXR3ZWVuIGVhY2ggQ0JXDQo+
Pj4gYW5kIHRoZSBjb3JyZXNwb25kaW5nIHdyaXRlIHRvIHRoZSBzYW1lIGJsb2NrLCB0byBtYWtl
IHN1cmUgdGhhdCB0aGUgb2xkDQo+Pj4gZGF0YSBpcyBiYWNrZWQgdXAgYmVmb3JlIGl0IGlzIG92
ZXJ3cml0dGVuLg0KPj4NCj4+IFllcywgdGhhdOKAmXMgd2hhdCBJIG1lYW50IGJ5IOKAnGVuZm9y
Y2Ugb24gdGhlIGhvc3QgdGhhdCB0aGUgdGFyZ2V0IGlzDQo+PiBhbHdheXMgZmx1c2hlZCBiZWZv
cmUgdGhlIHNvdXJjZeKAnS4gIFdlbGwsIEkgbWVhbnQgdG8gc2F5IHRoZXJlIGlzIG5vDQo+PiBn
b29kIHdheSBvZiBkb2luZyB0aGF0LCBhbmQgSSBraW5kIG9mIGRvbuKAmXQgY29uc2lkZXIgdGhp
cyBhIGdvb2Qgd2F5Lg0KPj4NCj4+PiBPZiBjb3Vyc2UsIHRoaXMgd291bGQgcGVyZm9ybSBhYm91
dCBhcyBiYWRseSBhcyBpbnRlcm5hbCBDT1cgaW4gcWNvdzIuLi4NCj4+PiBTbyBwcm9iYWJseSBu
b3QgYSBndWFyYW50ZWUgd2Ugc2hvdWxkIGJlIG1ha2luZyBieSBkZWZhdWx0LiBCdXQgaXQgbWln
aHQNCj4+PiBtYWtlIHNlbnNlIGFzIGFuIG9wdGlvbi4NCj4+DQo+PiBJIGRvbuKAmXQga25vdy4g
IOKAnFVzZSB0aGlzIG9wdGlvbiBzbyB5b3VyIGRhdGEgaXNu4oCZdCBsb3N0IGluIGNhc2Ugb2Yg
YQ0KPj4gcG93ZXIgZmFpbHVyZSwgYnV0IGl0IG1ha2VzIGV2ZXJ5dGhpbmcgcHJldHR5IHNsb3fi
gJ0/ICBXaG8gaXMgZ29pbmcgdG8gZG8NCj4+IGV4cGxpY2l0bHkgZW5hYmxlIHRoYXQgKGJlZm9y
ZSB0aGVpciBmaXJzdCBkYXRhIGxvc3MpPw0KPiANCj4gTWF5YmUgdGhlIGJhY2t1cCBqb2Igd2Fz
bid0IHRoYXQgY2xldmVyIGFmdGVyIGFsbC4gQXQgbGVhc3QgaWYgeW91IGNhcmUNCj4gYWJvdXQg
a2VlcGluZyB0aGUgcG9pbnQtaW4tdGltZSBzbmFwc2hvdCBhdCB0aGUgc3RhcnQgb2YgdGhlIGJh
Y2t1cCBqb2INCj4gaW5zdGVhZCBvZiBqdXN0IHJldHJ5aW5nIGFuZCBnZXR0aW5nIGEgc25hcHNo
b3Qgb2YgYSBkaWZmZXJlbnQgcG9pbnQgaW4NCj4gdGltZSB0aGF0IGlzIGp1c3QgYXMgZ29vZC4N
Cj4gDQo+IElmIHlvdSBkbyBjYXJlIGFib3V0IHRoZSBzcGVjaWZpYyBwb2ludCBpbiB0aW1lLCB0
aGUgc2FmZSB3YXkgdG8gZG8gaXQNCj4gaXMgdG8gdGFrZSBhIHNuYXBzaG90IGFuZCBjb3B5IHRo
YXQgYXdheSwgYW5kIHRoZW4gZGVsZXRlIHRoZSBzbmFwc2hvdA0KPiBhZ2Fpbi4NCj4gDQo+IFRo
ZSBvbmx5IHByb2JsZW0gaXMgdGhhdCBtZXJnaW5nIGV4dGVybmFsIHNuYXBzaG90cyBpcyBzbG93
IGFuZCB5b3UgZW5kDQo+IHVwIHdyaXRpbmcgdGhlIG5ldyBkYXRhIHR3aWNlLiBJZiBvbmx5IHdl
IGhhZCBhIENPVyBpbWFnZSBmb3JtYXQuLi4gOi0pDQo+IA0KDQpTbywgSSBzdGlsbCBkb24ndCB1
bmRlcnN0YW5kIHRoZSByZWFzb24gb2YgZmx1c2hpbmcgYmFja3VwIHRhcmdldCBpbiBhIG1lYW50
aW1lLg0KQmFja3VwIHRhcmdldCByZW1haW5zIGludmFsaWQgdW50aWwgdGhlIHN1Y2Nlc3NmdWwg
ZW5kIG9mIHRoZSBqb2IsIGF0IHdoaWNoIHBvaW50DQp3ZSBkZWZpbml0ZWx5IGZsdXNoIHRhcmdl
dCwgYnV0IG9ubHkgb25jZS4NCg0KSWYgbm9kZSBjcmFzaGVzIGR1cmluZyBiYWNrdXAsIGJhY2t1
cCB3b3VsZCBiZSBpbnZhbGlkIGluZGVwZW5kZW50bHkgb2Ygd2VyZSB0aGVyZQ0KZmx1c2hlcyBh
ZnRlciBlYWNoIHdyaXRlIChvciBiZXR0ZXIganVzdCBlbmFibGUgT19ESVJFQ1QpIG9yIG5vdC4N
Cg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

