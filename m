Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9D8C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB8B21841
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VJ5HRuj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB8B21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53312 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbp6H-0007MQ-T2
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39718)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hboyj-0003Ix-Hw
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hboyh-00039E-R0
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 12:23:01 -0400
Received: from mail-eopbgr130123.outbound.protection.outlook.com
 ([40.107.13.123]:53122 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hboyb-00032o-Ih; Fri, 14 Jun 2019 12:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPZHHN2tvZQziVt56g1oeEMIZmd7OV+/LUQGsocgbmY=;
 b=VJ5HRuj48Jzau9CKTRBn10SzlGkwJQkS0tQcTpFr8by/Iv31ft/VuI/L6LxhOg4aj6fidCMB0MBcchmdoN/f360u85u4MnXvly+bnAYRZU9Sa4wilkn7JthobXUnjtPRHcpWF3tgvhRMB77bM59lVd6RRniUl/A3lwh9CULFcHc=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB5058.eurprd08.prod.outlook.com (10.255.29.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Fri, 14 Jun 2019 16:22:49 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Fri, 14 Jun 2019
 16:22:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 4/7] block: introduce backup-top filter driver
Thread-Index: AQHVFjXHKN4zfc/OLkS/ttIGgp7hZ6aZ1OmAgAFRQoCAAA7mAIAAOVGA
Date: Fri, 14 Jun 2019 16:22:49 +0000
Message-ID: <46ad242a-3aa5-bfa1-1d64-5f2e98f4ed32@virtuozzo.com>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-5-vsementsov@virtuozzo.com>
 <c31e0d6e-3754-8b22-ccee-84c772eca404@redhat.com>
 <7b401fba-36dd-d80e-966a-15fdd72ac335@virtuozzo.com>
 <825995ac-488e-b25c-c551-526812046caf@redhat.com>
In-Reply-To: <825995ac-488e-b25c-c551-526812046caf@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::33) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190614192247063
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f66c0c79-e25a-4f24-c16c-08d6f0e48ada
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB5058; 
x-ms-traffictypediagnostic: AM0PR08MB5058:
x-microsoft-antispam-prvs: <AM0PR08MB50582793EEFCAE3029DBBC56C1EE0@AM0PR08MB5058.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39850400004)(199004)(52314003)(189003)(229853002)(6436002)(14444005)(6506007)(386003)(25786009)(36756003)(14454004)(53936002)(53546011)(186003)(31686004)(5660300002)(102836004)(66066001)(71190400001)(52116002)(76176011)(6246003)(6512007)(71200400001)(6486002)(26005)(446003)(316002)(31696002)(110136005)(73956011)(54906003)(81166006)(64756008)(81156014)(2201001)(256004)(66946007)(66476007)(476003)(66446008)(11346002)(8936002)(2616005)(66556008)(7736002)(5024004)(86362001)(6116002)(478600001)(8676002)(486006)(305945005)(3846002)(68736007)(99286004)(4326008)(2906002)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB5058;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Iir024w0KYgwN/snvhLCxDyMpmF4LN5eSSmoFBlnJ6c9dfI7BrvLrrwuUTz4b0QNlmKuJnBVukM7nROJ0MJ2yzpFk/jeayGnknP0Vr44PJWGeSAZfgimTaov8m+C5yig1PdCWZW+n+/bfjW9dIqUwJXh100ZmgOeiL52E037xT9vn7/ZBQ1GLt+YaAEnEOFYeDzqL2hWcp0FXAM3n9y8se1UDqTENHK4HvJVguJ3EVyzZVVnggjPzr23c8Jyn2melE1ZLQ22+QWMZGOeY46wpvIfaaxy292ZRHTnc+xDkXrEPBgZX1ORgmuTzsnuCFdUw6riFXdSBcpWuXIb2mJ1VIW6DGT5jXzmMOfpuO74dHv+/jb+of+OBBxaBkK0AdTv6+LIhXVIzmuGYyuaWZoy0nLGpX/4gqTimBfPaU42Xk0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7428CB10EE5FC64691EA116676983231@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66c0c79-e25a-4f24-c16c-08d6f0e48ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 16:22:49.5134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5058
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.123
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTQuMDYuMjAxOSAxNTo1NywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNC4wNi4xOSAxMTowNCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDEzLjA2LjIwMTkgMTg6NTcs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAyOS4wNS4xOSAxNzo0NiwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gQmFja3VwLXRvcCBmaWx0ZXIgZG9lcyBjb3B5LWJl
Zm9yZS13cml0ZSBvcGVyYXRpb24uIEl0IHNob3VsZCBiZQ0KPj4+PiBpbnNlcnRlZCBhYm92ZSBh
Y3RpdmUgZGlzayBhbmQgaGFzIGEgdGFyZ2V0IG5vZGUgZm9yIENCVywgbGlrZSB0aGUNCj4+Pj4g
Zm9sbG93aW5nOg0KPj4+Pg0KPj4+PiAgICAgICArLS0tLS0tLSsNCj4+Pj4gICAgICAgfCBHdWVz
dCB8DQo+Pj4+ICAgICAgICstLS0tLS0tKw0KPj4+PiAgICAgICAgICAgfHIsdw0KPj4+PiAgICAg
ICAgICAgdg0KPj4+PiAgICAgICArLS0tLS0tLS0tLS0tKyAgdGFyZ2V0ICAgKy0tLS0tLS0tLS0t
LS0tLSsNCj4+Pj4gICAgICAgfCBiYWNrdXBfdG9wIHwtLS0tLS0tLS0tPnwgdGFyZ2V0KHFjb3cy
KSB8DQo+Pj4+ICAgICAgICstLS0tLS0tLS0tLS0rICAgQ0JXICAgICArLS0tLS0tLS0tLS0tLS0t
Kw0KPj4+PiAgICAgICAgICAgfA0KPj4+PiBiYWNraW5nIHxyLHcNCj4+Pj4gICAgICAgICAgIHYN
Cj4+Pj4gICAgICAgKy0tLS0tLS0tLS0tLS0rDQo+Pj4+ICAgICAgIHwgQWN0aXZlIGRpc2sgfA0K
Pj4+PiAgICAgICArLS0tLS0tLS0tLS0tLSsNCj4+Pj4NCj4+Pj4gVGhlIGRyaXZlciB3aWxsIGJl
IHVzZWQgaW4gYmFja3VwIGluc3RlYWQgb2Ygd3JpdGUtbm90aWZpZXJzLg0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZp
cnR1b3p6by5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgICBibG9jay9iYWNrdXAtdG9wLmggIHwgIDY0
ICsrKysrKysrKw0KPj4+PiAgICBibG9jay9iYWNrdXAtdG9wLmMgIHwgMzIyICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIGJsb2NrL01ha2VmaWxl
Lm9ianMgfCAgIDIgKw0KPj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDM4OCBpbnNlcnRpb25zKCsp
DQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBibG9jay9iYWNrdXAtdG9wLmgNCj4+Pj4gICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGJsb2NrL2JhY2t1cC10b3AuYw0KPj4+Pg0KPj4+PiBkaWZmIC0t
Z2l0IGEvYmxvY2svYmFja3VwLXRvcC5oIGIvYmxvY2svYmFja3VwLXRvcC5oDQo+Pj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+Pj4+IGluZGV4IDAwMDAwMDAwMDAuLjc4OGUxOGMzNTgNCj4+Pj4g
LS0tIC9kZXYvbnVsbA0KPj4+PiArKysgYi9ibG9jay9iYWNrdXAtdG9wLmgNCj4gDQo+IFsuLi5d
DQo+IA0KPj4+PiArLyoNCj4+Pj4gKyAqIGJkcnZfYmFja3VwX3RvcF9hcHBlbmQNCj4+Pj4gKyAq
DQo+Pj4+ICsgKiBBcHBlbmQgYmFja3VwX3RvcCBmaWx0ZXIgbm9kZSBhYm92ZSBAc291cmNlIG5v
ZGUuIEB0YXJnZXQgbm9kZSB3aWxsIHJlY2VpdmUNCj4+Pj4gKyAqIHRoZSBkYXRhIGJhY2tlZCB1
cCBkdXJpbmcgQ0JFIG9wZXJhdGlvbnMuIE5ldyBmaWx0ZXIgdG9nZXRoZXIgd2l0aCBAdGFyZ2V0
DQo+Pj4+ICsgKiBub2RlIGFyZSBhdHRhY2hlZCB0byBAc291cmNlIGFpbyBjb250ZXh0Lg0KPj4+
PiArICoNCj4+Pj4gKyAqIFRoZSByZXN1bHRpbmcgZmlsdGVyIG5vZGUgaXMgaW1wbGljaXQuDQo+
Pj4NCj4+PiBXaHk/ICBJdOKAmXMganVzdCBhcyBlYXN5IGZvciB0aGUgY2FsbGVyIHRvIGp1c3Qg
bWFrZSBpdCBpbXBsaWNpdCBpZiBpdA0KPj4+IHNob3VsZCBiZS4gIChBbmQgdXN1YWxseSB0aGUg
Y2FsbGVyIHNob3VsZCBkZWNpZGUgdGhhdC4pDQo+Pg0KPj4gUGVyc29uYWxseSwgSSBkb24ndCBr
bm93IHdoYXQgYXJlIHRoZSByZWFzb25zIGZvciBmaWx0ZXJzIHRvIGJpIGltcGxpY2l0IG9yIG5v
dCwNCj4+IEkganVzdCBtYWRlIGl0IGxpa2Ugb3RoZXIgam9iLWZpbHRlcnMuLiBJIGNhbiBtb3Zl
IG1ha2luZy1pbXBsaWNpdCB0byB0aGUgY2FsbGVyDQo+PiBvciBkcm9wIGl0IGF0IGFsbCAoaWYg
aXQgd2lsbCB3b3JrKS4NCj4gDQo+IE5vZGVzIGFyZSBpbXBsaWNpdCBpZiB0aGV5IGhhdmVu4oCZ
dCBiZWVuIGFkZGVkIGNvbnNjaW91c2x5IGJ5IHRoZSB1c2VyLg0KPiBBIG5vZGUgYWRkZWQgYnkg
YSBibG9jayBqb2IgY2FuIGJlIG5vbi1pbXBsaWNpdCwgdG9vLCBhcyBtaXJyb3Igc2hvd3M7DQo+
IElmIHRoZSB1c2VyIHNwZWNpZmllcyB0aGUgZmlsdGVyLW5vZGUtbmFtZSBvcHRpb24sIHRoZXkg
d2lsbCBrbm93IGFib3V0DQo+IHRoZSBub2RlLCB0aHVzIGl0IGlzIG5vIGxvbmdlciBpbXBsaWNp
dC4NCj4gDQo+IElmIHRoZSB1c2VyIGRvZXNu4oCZdCBrbm93IGFib3V0IHRoZSBub2RlICh0aGV5
IGRpZG7igJl0IGdpdmUgdGhlDQo+IGZpbHRlci1ub2RlLW5hbWUgb3B0aW9uKSwgdGhlIG5vZGUg
aXMgaW1wbGljaXQuDQo+IA0KDQpPaywgSSB1bmRlcnN0YW5kIGl0LiBCdXQgaXQgZG9lc24ndCBz
aG93LCB3aHkgaXQgc2hvdWxkIGJlIGltcGxpY2l0Pw0KSXNuJ3QgaXQgbGVzcyBidWdneSB0byBt
YWtlIGFsbCBmaWx0ZXJzIGV4cGxpY2l0PyBXZSBkb24ndCBoaWRlIGltcGxpY2l0IG5vZGVzDQpm
cm9tIHF1ZXJ5LW5hbWVkLWJsb2NrLW5vZGVzICh0aGUgb25seSBpbnRlcmZhY2UgdG8gZXhwbG9y
ZSB0aGUgd2hvbGUgZ3JhcGggZm9yIG5vdykNCmFueXdheS4gQW5kIHdlIGNhbid0IGFic29sdXRl
bHkgaGlkZSBzaWRlIGVmZmVjdHMgb2YgYWRkaXRpb25hbCBub2RlIGluIHRoZSBncmFwaC4NCg0K
U28sIGlzIHRoZXJlIGFueSByZWFsIGJlbmVmaXQgb2Ygc3VwcG9ydGluZyBzZXBhcmF0aW9uIGlu
dG8gaW1wbGljaXQgYW5kIGV4cGxpY2l0IGZpbHRlcnM/DQpJdCBzZWVtcyBmb3IgbWUgdGhhdCBp
dCBvbmx5IGNvbXBsaWNhdGVzIHRoaW5ncy4uLg0KSW4gb3RoZXIgd29yZHMsIHdoYXQgd2lsbCBi
cmVhayBpZiB3ZSBtYWtlIGFsbCBmaWx0ZXJzIGV4cGxpY2l0Pw0KDQo+IFsuLi5dDQo+IA0KPj4+
PiArc3RhdGljIGludCBjb3JvdXRpbmVfZm4gYmFja3VwX3RvcF9jb19mbHVzaChCbG9ja0RyaXZl
clN0YXRlICpicykNCj4+Pj4gK3sNCj4+Pj4gKyAgICBpZiAoIWJzLT5iYWNraW5nKSB7DQo+Pj4+
ICsgICAgICAgIHJldHVybiAwOw0KPj4+PiArICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgIHJldHVy
biBiZHJ2X2NvX2ZsdXNoKGJzLT5iYWNraW5nLT5icyk7DQo+Pj4NCj4+PiBTaG91bGQgd2UgZmx1
c2ggdGhlIHRhcmdldCwgdG9vPw0KPj4NCj4+IEhtLCB5b3UndmUgYXNrZWQgaXQgYWxyZWFkeSwg
b24gcHJldmlvdXMgdmVyc2lvbiA6KQ0KPiANCj4gSSB3YXNu4oCZdCBzdXJlLi4uDQo+IA0KPj4g
QmFja3VwIGRvbid0IGRvIGl0LA0KPj4gc28gSSBqdXN0IGtlZXAgb2xkIGJlaGF2aW9yLiBBbmQg
d2hhdCBpcyB0aGUgcmVhc29uIHRvIGZsdXNoIGJhY2t1cCB0YXJnZXQNCj4+IG9uIGFueSBndWVz
dCBmbHVzaD8NCj4gDQo+IEhtLCB3ZWxsLCB3aGF04oCZcyB0aGUgcmVhc29uIG5vdCB0byBkbyBp
dD8NCg0KZ3Vlc3QgZmx1c2hlcyB3aWxsIGJlIHNsb3dlZCBkb3duPw0KDQo+IEFsc28sIHRoZXJl
IGFyZSBub3Qgb25seSBndWVzdCBmbHVzaGVzLiAgYmRydl9mbHVzaF9hbGwoKSBleGlzdHMsIHdo
aWNoDQo+IGlzIGNhbGxlZCB3aGVuIHRoZSBndWVzdCBpcyBzdG9wcGVkLiAgU28gd2hvIGlzIGdv
aW5nIHRvIGZsdXNoIHRoZQ0KPiB0YXJnZXQgaWYgbm90IGl0cyBwYXJlbnQ/DQo+IA0KPiBbLi4u
XQ0KDQpCYWNrdXAgam9iPyBCdXQgZmlsdGVyIHNob3VsZCBub3QgcmVsYXkgb24gaXQuLg0KDQpC
dXQgc2hvdWxkIHJlYWxseSBmaWx0ZXIgZG8gdGhhdCBqb2IsIG9yIGl0IGlzIGhlcmUgb25seSB0
byBkbyBDQlc/IE1heWJlIHRhcmdldA0KbXVzdCBoYXZlIGFub3RoZXIgcGFyZW50IHdoaWNoIHdp
bGwgY2FyZSBhYm91dCBmbHVzaGluZy4NCg0KT2ssIEkgdGhpbmsgSSdsbCBmbHVzaCB0YXJnZXQg
aGVyZSB0b28gZm9yIHNhZmV0eSwgYW5kIGxlYXZlIGEgY29tbWVudCwgdGhhdCBzb21ldGhpbmcN
CnNtYXJ0ZXIgd291bGQgYmUgYmV0dGVyLg0KKG9yLCBpZiB3ZSBkZWNpZGUgdG8gZmx1c2ggYWxs
IGNoaWxkcmVuIGJ5IGRlZmF1bHQgaW4gZ2VuZXJpYyBjb2RlLCBJJ2xsIGRyb3AgdGhpcyBoYW5k
bGVyKQ0KDQo+IA0KPj4+PiArDQo+Pj4+ICsgICAgaWYgKHJvbGUgPT0gJmNoaWxkX2ZpbGUpIHsN
Cj4+Pj4gKyAgICAgICAgLyoNCj4+Pj4gKyAgICAgICAgICogVGFyZ2V0IGNoaWxkDQo+Pj4+ICsg
ICAgICAgICAqDQo+Pj4+ICsgICAgICAgICAqIFNoYXJlIHdyaXRlIHRvIHRhcmdldCAoY2hpbGRf
ZmlsZSksIHRvIG5vdCBpbnRlcmZlcmUNCj4+Pj4gKyAgICAgICAgICogd2l0aCBndWVzdCB3cml0
ZXMgdG8gaXRzIGRpc2sgd2hpY2ggbWF5IGJlIGluIHRhcmdldCBiYWNraW5nIGNoYWluLg0KPj4+
PiArICAgICAgICAgKi8NCj4+Pj4gKyAgICAgICAgaWYgKHBlcm0gJiBCTEtfUEVSTV9XUklURSkg
ew0KPj4+PiArICAgICAgICAgICAgKm5zaGFyZWQgPSAqbnNoYXJlZCB8IEJMS19QRVJNX1dSSVRF
Ow0KPj4+DQo+Pj4gV2h5IG5vdCBhbHdheXMgc2hhcmUgV1JJVEUgb24gdGhlIHRhcmdldD8NCj4+
DQo+PiBIbW0sIGl0J3MgYSBiYWQgdGhpbmcgdG8gc2hhcmUgd3JpdGVzIG9uIHRhcmdldCwgc28g
SSdtIHRyeWluZyB0byByZWR1Y2UgbnVtYmVyIG9mDQo+PiBjYXNlcyB3aGVuIHdlIGhhdmUgc2hh
cmUgaXQuDQo+IA0KPiBJcyBpdD8gIEZpcnN0IG9mIGFsbCwgdGhpcyBmaWx0ZXIgZG9lc27igJl0
IGNhcmUuICBJdCBkb2VzbuKAmXQgZXZlbiByZWFkDQo+IGZyb20gdGhlIHRhcmdldCAocmVsYXRl
ZCBub3RlOiB3ZSBwcm9iYWJseSBkb27igJl0IG5lZWQgQ09OU0lTVEVOVF9SRUFEIG9uDQo+IHRo
ZSB0YXJnZXQpLg0KPiANCj4gU2Vjb25kLCB0aGVyZSBpcyBnZW5lcmFsbHkgZ29pbmcgdG8gYmUg
YSBwYXJlbnQgb24gYmFja3VwLXRvcCB0aGF0IGhhcw0KPiB0aGUgV1JJVEUgcGVybWlzc2lvbiB0
YWtlbi4gIFNvIHRoaXMgZG9lcyBub3QgcmVhbGx5IGVmZmVjdGl2ZWx5IHJlZHVjZQ0KPiB0aGF0
IG51bWJlciBvZiBjYXNlcy4NCg0KT2suDQoNCj4gDQo+Pj4+ICsgICAgICAgIH0NCj4+Pj4gKyAg
ICB9IGVsc2Ugew0KPj4+PiArICAgICAgICAvKiBTb3VyY2UgY2hpbGQgKi8NCj4+Pj4gKyAgICAg
ICAgaWYgKHBlcm0gJiBCTEtfUEVSTV9XUklURSkgew0KPj4+DQo+Pj4gT3IgV1JJVEVfVU5DSEFO
R0VELCBubz8NCj4+DQo+PiBXaHk/IFdlIGRvbid0IG5lZWQgZG9pbmcgQ0JXIGZvciB1bmNoYW5n
ZWQgd3JpdGUuDQo+IA0KPiBCdXQgd2Ugd2lsbCBkbyBpdCBzdGlsbCwgd29u4oCZdCB3ZT8NCj4g
DQo+IChJZiBhbiB1bmNoYW5naW5nIHdyaXRlIGNvbWVzIGluLCB0aGlzIGRyaXZlciB3aWxsIGhh
bmRsZSBpdCBqdXN0IGxpa2UgYQ0KPiBub3JtYWwgd3JpdGUsIHdpbGwgaXQgbm90PykNCg0KTm8s
IGl0IHdpbGwgbm90LCBJIGNoZWNrIHRoaXMgZmxhZyBpbiBiYWNrdXBfdG9wX2NvX3B3cml0ZXYN
Cg0KPiANCj4gWy4uLl0NCj4gDQo+Pj4+ICsNCj4+Pj4gK0Jsb2NrRHJpdmVyU3RhdGUgKmJkcnZf
YmFja3VwX3RvcF9hcHBlbmQoQmxvY2tEcml2ZXJTdGF0ZSAqc291cmNlLA0KPj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCbG9ja0RyaXZlclN0YXRlICp0YXJn
ZXQsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhCaXRt
YXAgKmNvcHlfYml0bWFwLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBFcnJvciAqKmVycnApDQo+Pj4+ICt7DQo+IA0KPiBbLi4uXQ0KPiANCj4+Pj4gK30N
Cj4+Pg0KPj4+IEkgZ3Vlc3MgaXQgd291bGQgYmUgbmljZSBpZiBpdCB1c2VycyBjb3VsZCBibG9j
a2Rldi1hZGQgYSBiYWNrdXAtdG9wDQo+Pj4gbm9kZSB0byBiYXNpY2FsbHkgZ2V0IGEgYmFja3Vw
IHdpdGggc3luYz1ub25lLg0KPj4+DQo+Pj4gKFRoZSBiZHJ2X29wZW4gaW1wbGVtZW50YXRpb24g
c2hvdWxkIHRoZW4gY3JlYXRlIGEgbmV3IGJpdG1hcCBhbmQNCj4+PiBpbml0aWFsaXplIGl0IHRv
IGJlIGZ1bGx5IHNldC4pDQo+Pj4NCj4+PiBCdXQgbWF5YmUgaXQgd291bGRu4oCZdCBiZSBzbyBu
aWNlIGFuZCBJIGp1c3QgaGF2ZSBmZXZlcmlzaCBkcmVhbXMuDQo+Pg0KPj4gV2hlbiBzZXJpZXMg
YmVndW4sIEkgd2FzIHRyeWluZyB0byBtYWtlIGV4YWN0bHkgdGhpcyAtIHVzZXItYXZhaWxhYmxl
IGZpbHRlciwNCj4+IHdoaWNoIG1heSBiZSB1c2VkIGluIHNlcGFyYXRlLCBidXQgeW91IHdhcyBh
Z2FpbnN0KQ0KPiANCj4gUGFzdCBtZSBpcyBzdHVwaWQuDQo+IA0KPj4gTWF5YmUsIG5vdCB0b3Rh
bGx5IGFnYWluc3QsIGJ1dCBJIGRlY2lkZWQgbm90IHRvIGFyZ3VlIGxvbmcsIGFuZCBpbnN0ZWFk
IG1ha2UNCj4+IGZpbHRlciBpbXBsaWNpdCBhbmQgZHJvcCBwdWJsaWMgYXBpIChsaWtlIG1pcnJv
ciBhbmQgY29tbWl0IGZpbHRlcnMpLCBidXQgcGxhY2UgaXQNCj4+IGluIGEgc2VwYXJhdGUgZmls
ZSAobm8gb25lIHdpbGwgYXJndWUgYWdhaW5zdCBwdXR0aW5nIGxhcmdlIGVub3VnaCBhbmQgY29t
cGxldGUNCj4+IG5ldyBmZWF0dXJlLCByZXByZXNlbnRlZCBieSBvYmplY3QgaW50byBhIHNlcGFy
YXRlIGZpbGUgOikuIEFuZCB0aGlzIGFjdHVhbGx5DQo+PiBtYWtlcyBpdCBlYXN5IHRvIHB1Ymxp
c2ggdGhpcyBmaWx0ZXIgYXQgc29tZSBtb21lbnQuIEFuZCBub3cgSSB0aGluayBpdCB3YXMNCj4+
IGdvb2QgZGVjaXNpb24gYW55d2F5LCBhcyB3ZSBwb3N0cG9uZWQgYXJndWluZyBhcm91bmQgQVBJ
IGFuZCBhcm91bmQgc2hhcmVkIGRpcnR5DQo+PiBiaXRtYXBzLg0KPj4NCj4+IFNvIHB1Ymxpc2hp
bmcgdGhlIGZpbHRlciBpcyBmdXR1cmUgc3RlcC4NCj4gDQo+IE9LLCBzdXJlLg0KPiANCj4+Pj4g
K3ZvaWQgYmRydl9iYWNrdXBfdG9wX3NldF9wcm9ncmVzc19jYWxsYmFjaygNCj4+Pj4gKyAgICAg
ICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIEJhY2t1cFRvcFByb2dyZXNzQ2FsbGJhY2sgcHJvZ3Jl
c3NfY2IsDQo+Pj4+ICsgICAgICAgIHZvaWQgKnByb2dyZXNzX29wYXF1ZSkNCj4+Pj4gK3sNCj4+
Pj4gKyAgICBCRFJWQmFja3VwVG9wU3RhdGUgKnMgPSBicy0+b3BhcXVlOw0KPj4+PiArDQo+Pj4+
ICsgICAgcy0+cHJvZ3Jlc3NfY2IgPSBwcm9ncmVzc19jYjsNCj4+Pj4gKyAgICBzLT5wcm9ncmVz
c19vcGFxdWUgPSBwcm9ncmVzc19vcGFxdWU7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3ZvaWQg
YmRydl9iYWNrdXBfdG9wX2Ryb3AoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpDQo+Pj4+ICt7DQo+Pj4+
ICsgICAgQkRSVkJhY2t1cFRvcFN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4+Pj4gKyAgICBBaW9D
b250ZXh0ICphaW9fY29udGV4dCA9IGJkcnZfZ2V0X2Fpb19jb250ZXh0KGJzKTsNCj4+Pj4gKw0K
Pj4+PiArICAgIGFpb19jb250ZXh0X2FjcXVpcmUoYWlvX2NvbnRleHQpOw0KPj4+PiArDQo+Pj4+
ICsgICAgYmRydl9kcmFpbmVkX2JlZ2luKGJzKTsNCj4+Pj4gKw0KPj4+PiArICAgIGJkcnZfY2hp
bGRfdHJ5X3NldF9wZXJtKGJzLT5iYWNraW5nLCAwLCBCTEtfUEVSTV9BTEwsICZlcnJvcl9hYm9y
dCk7DQo+Pj4NCj4+PiBQcmUtZXhpc3RpbmcgaW4gb3RoZXIgam9icywgYnV0IEkgdGhpbmsgY2Fs
bGluZyB0aGlzIGZ1bmN0aW9uIGlzDQo+Pj4gZGFuZ2Vyb3VzLiAgKFdoaWNoIGlzIHdoeSBJIHJl
bW92ZSBpdCBpbiBteSDigJxibG9jazogSWdub3JlIGxvb3NlbmluZw0KPj4+IHBlcm0gcmVzdHJp
Y3Rpb25zIGZhaWx1cmVz4oCdIHNlcmllcy4pDQo+Pg0KPj4gSG1tLCBnb29kIHRoaW5nLi4gU2hv
dWxkIEkgcmViYXNlIG9uIGl0Pw0KPiANCj4gSXQgd291bGQgaGVscCBtZSBhdCBsZWFzdC4NCg0K
QW5kIG5vdyBpdCdzIGFscmVhZHkgc3RhZ2VkLCBzbyBJIHNob3VsZC4NCg0KPiANCj4+Pj4gKyAg
ICBiZHJ2X3JlcGxhY2Vfbm9kZShicywgYmFja2luZ19icyhicyksICZlcnJvcl9hYm9ydCk7DQo+
Pj4+ICsgICAgYmRydl9zZXRfYmFja2luZ19oZChicywgTlVMTCwgJmVycm9yX2Fib3J0KTsNCj4+
Pg0KPj4+IEkgdGhpbmsgc29tZSBvZiB0aGlzIGZ1bmN0aW9uIHNob3VsZCBiZSBpbiBhIC5iZHJ2
X2Nsb3NlKCkNCj4+PiBpbXBsZW1lbnRhdGlvbiwgZm9yIGV4YW1wbGUgdGhpcyBiZHJ2X3NldF9i
YWNraW5nX2hkKCkgY2FsbC4NCj4+DQo+PiBXaHk/IFdlIGRvbid0IGhhdmUgLmJkcnZfb3Blbiwg
c28gd2h5IHRvIGhhdmUgLmJkcnZfY2xvc2U/IEkgdGhpbmssIHdoZW4NCj4+IHdlIHB1Ymxpc2gg
dGhpcyBmaWx0ZXIgbW9zdCBvZiBfYWRkKCkgYW5kIF9kcm9wKCkgd2lsbCBiZSByZWZhY3RvcmVk
IHRvDQo+PiBvcGVuKCkgYW5kIGNsb3NlKCkuIElzIHRoZXJlIGEgcmVhbCByZWFzb24gdG8gaW1w
bGVtZW50IC5jbG9zZSgpIG5vdz8NCj4gDQo+IE5vdCByZWFsbHkgaWYgaXQgaXNu4oCZdCBhIHVz
YWJsZSBibG9jayBkcml2ZXIgeWV0LCBuby4NCj4gDQo+IE1heA0KPiANCg0KDQotLSANCkJlc3Qg
cmVnYXJkcywNClZsYWRpbWlyDQo=

