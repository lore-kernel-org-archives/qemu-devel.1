Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EFFC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A7C2089E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 15:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CaY8zkXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A7C2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48808 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZGo9-0001bw-VV
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 11:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56679)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZFqe-00044z-UQ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZFqd-0001ci-J4
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 10:28:04 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com
 ([40.107.5.97]:58929 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZFqZ-0001Ud-Of; Fri, 07 Jun 2019 10:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnamAhs17aZXpJGFo13gS0gSEwN8rG5i7V2Sf+Qcef0=;
 b=CaY8zkXRm4cdTrdHtB7iM6iNsv3vg7Ncu6fngzrTf8asdUKzF1dJCxnVSWAAh6XpXibLuUOD9KWwTgp7Y1RuotRkjGiChpsFtUmy/tLPjrUxde7d8THVcWMIyd7ksplLQ4uofY4fAt1h+dzv5+UWRo/HDJkHjqQUWfY2MoHyFzA=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
 AM0PR08MB4019.eurprd08.prod.outlook.com (20.178.119.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 7 Jun 2019 14:27:56 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8]) by AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 14:27:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH v6 6/7] block/nbd-client: nbd reconnect
Thread-Index: AQHU8IvOU96perqu+EiRV82H4T/8KaaP3geAgABQuoCAAHQ7gP//5UIAgAARDQA=
Date: Fri, 7 Jun 2019 14:27:56 +0000
Message-ID: <c1c87a1c-9f1a-b7c8-d5a7-bb496556a256@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-7-vsementsov@virtuozzo.com>
 <0b64cff5-33fa-0945-504c-b1bdd004c42a@redhat.com>
 <20190607080635.GB5055@dhcp-200-226.str.redhat.com>
 <c1414cfd-99cd-ea31-ab22-f7d76974e6b3@virtuozzo.com>
 <20190607132652.GD5055@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190607132652.GD5055@dhcp-200-226.str.redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::15) To AM0PR08MB2961.eurprd08.prod.outlook.com
 (2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190607172754166
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f6cf1d8-d3f7-4992-202b-08d6eb545531
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB4019; 
x-ms-traffictypediagnostic: AM0PR08MB4019:
x-microsoft-antispam-prvs: <AM0PR08MB40199B8E2D6F21262348C57EC1100@AM0PR08MB4019.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(136003)(396003)(346002)(376002)(52314003)(189003)(199004)(54906003)(7736002)(52116002)(478600001)(81166006)(446003)(66556008)(31686004)(73956011)(6512007)(3846002)(81156014)(6116002)(76176011)(6506007)(66476007)(53546011)(53936002)(25786009)(2906002)(68736007)(11346002)(316002)(26005)(102836004)(386003)(5660300002)(305945005)(64756008)(66066001)(6246003)(107886003)(66446008)(99286004)(229853002)(31696002)(36756003)(14454004)(5024004)(14444005)(71200400001)(4326008)(256004)(8676002)(2616005)(6486002)(66946007)(71190400001)(476003)(486006)(86362001)(6436002)(8936002)(6916009)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4019;
 H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ynyuOIGsydspEd/Mp29nfExvoWnS+CytZ98AdCwYC8hyW7jHIYL7ojPb1Xq8LnesFO62xzcdBr1eIdSnzlTD57uLMcdjd8+FiplxY6JvB6z9OMVFPAExIuJVch7nClcHhTOUg049F72ZaSLeifC/DCEFMnljJ9Hu/CBIKB3odBLLDXs161R6ZOyUYXMqKdlxwjbMpn6GFYLec4BWFKhHBfevxWSgKDAO6nTTuLKCkmpqKQ7BGytOIXGDk+MpBYNNLqhsIPQuBke8jj+oxuJbJTvInuVS8Bj9Ed0PxgQrLRds4tzHWfVKsYkO+tmiFb/CZLeX+qpNAS0cK4NwZKaaRU9nCV7cAHL4RV4RBHOwOvJleF9XirB8k1kt7yM2Wcr0yCJRRZGtr27MwR6SeJjJq0D4cECWMLtHcp/X/ghACvA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B05BA7CE32DA8543881A303BAE20BD7C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6cf1d8-d3f7-4992-202b-08d6eb545531
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 14:27:56.1375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4019
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.97
Subject: Re: [Qemu-devel] [PATCH v6 6/7] block/nbd-client: nbd reconnect
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

MDcuMDYuMjAxOSAxNjoyNiwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDcuMDYuMjAxOSB1bSAx
NDowMiBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDA3
LjA2LjIwMTkgMTE6MDYsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMDcuMDYuMjAxOSB1bSAw
NToxNyBoYXQgRXJpYyBCbGFrZSBnZXNjaHJpZWJlbjoNCj4+Pj4gT24gNC8xMS8xOSAxMjoyNyBQ
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+ICtzdGF0aWMgY29y
b3V0aW5lX2ZuIHZvaWQgbmJkX3JlY29ubmVjdF9sb29wKE5CRENvbm5lY3Rpb24gKmNvbikNCj4+
Pj4+ICt7DQo+Pj4+PiArICAgIE5CRENsaWVudFNlc3Npb24gKnMgPSBuYmRfZ2V0X2NsaWVudF9z
ZXNzaW9uKGNvbi0+YnMpOw0KPj4+Pj4gKyAgICB1aW50NjRfdCBzdGFydF90aW1lX25zID0gcWVt
dV9jbG9ja19nZXRfbnMoUUVNVV9DTE9DS19SRUFMVElNRSk7DQo+Pj4+PiArICAgIHVpbnQ2NF90
IGRlbGF5X25zID0gcy0+cmVjb25uZWN0X2RlbGF5ICogMTAwMDAwMDAwMFVMOw0KPj4+Pg0KPj4+
PiBEbyB3ZSBoYXZlIGEgI2RlZmluZSBjb25zdGFudCBmb3IgbmFub3NlY29uZHMgaW4gYSBzZWNv
bmQgdG8gbWFrZSB0aGlzDQo+Pj4+IG1vcmUgbGVnaWJsZSB0aGFuIGNvdW50aW5nICcwJ3M/DQo+
Pj4+DQo+Pj4+PiArICAgIHVpbnQ2NF90IHRpbWVvdXQgPSAxMDAwMDAwMDAwVUw7IC8qIDEgc2Vj
ICovDQo+Pj4+PiArICAgIHVpbnQ2NF90IG1heF90aW1lb3V0ID0gMTYwMDAwMDAwMDBVTDsgLyog
MTYgc2VjICovDQo+Pj4+DQo+Pj4+IDEgKiBjb25zdGFudCwgMTYgKiBjb25zdGFudA0KPj4+Pg0K
Pj4+Pj4gKw0KPj4+Pj4gKyAgICBuYmRfcmVjb25uZWN0X2F0dGVtcHQoY29uKTsNCj4+Pj4+ICsN
Cj4+Pj4+ICsgICAgd2hpbGUgKG5iZF9jbGllbnRfY29ubmVjdGluZyhzKSkgew0KPj4+Pj4gKyAg
ICAgICAgaWYgKHMtPnN0YXRlID09IE5CRF9DTElFTlRfQ09OTkVDVElOR19XQUlUICYmDQo+Pj4+
PiArICAgICAgICAgICAgcWVtdV9jbG9ja19nZXRfbnMoUUVNVV9DTE9DS19SRUFMVElNRSkgLSBz
dGFydF90aW1lX25zID4gZGVsYXlfbnMpDQo+Pj4+PiArICAgICAgICB7DQo+Pj4+PiArICAgICAg
ICAgICAgcy0+c3RhdGUgPSBOQkRfQ0xJRU5UX0NPTk5FQ1RJTkdfTk9XQUlUOw0KPj4+Pj4gKyAg
ICAgICAgICAgIHFlbXVfY29fcXVldWVfcmVzdGFydF9hbGwoJnMtPmZyZWVfc2VtYSk7DQo+Pj4+
PiArICAgICAgICB9DQo+Pj4+PiArDQo+Pj4+PiArICAgICAgICBiZHJ2X2RlY19pbl9mbGlnaHQo
Y29uLT5icyk7DQo+Pj4+PiArICAgICAgICBxZW11X2NvX3NsZWVwX25zKFFFTVVfQ0xPQ0tfUkVB
TFRJTUUsIHRpbWVvdXQpOw0KPj4+Pg0KPj4+PiBBbm90aGVyIHBsYWNlIHdoZXJlIEknZCBsaWtl
IHNvbWVvbmUgbW9yZSBmYW1pbGlhciB3aXRoIGNvcm91dGluZXMgdG8NCj4+Pj4gYWxzbyBoYXZl
IGEgbG9vay4NCj4+Pg0KPj4+IFdoYXQncyB0aGUgZXhhY3QgcXVlc3Rpb24geW91J2QgbGlrZSBt
ZSB0byBhbnN3ZXI/DQo+Pj4NCj4+PiBCdXQgYW55d2F5LCBiZHJ2X2RlYy9pbmNfaW5fZmxpZ2h0
KCkgYXJvdW5kIHRoZSBzbGVlcCBsb29rcyB3cm9uZyB0byBtZS4NCj4+PiBFaXRoZXIgdGhlIG9w
ZXJhdGlvbiBtdXN0IGJlIHdhaXRlZCBmb3IgaW4gZHJhaW4sIHRoZW4geW91IGNhbid0DQo+Pj4g
ZGVjcmVhc2UgdGhlIGNvdW50ZXIgZXZlbiBkdXJpbmcgdGhlIHNsZWVwLiBPciBkcmFpbiBkb2Vz
bid0IGhhdmUgdG8NCj4+PiBjb25zaWRlciBpdCwgdGhlbiB3aHkgaXMgdGhlIGNvdW50ZXIgZXZl
biBpbmNyZWFzZWQgaW4gdGhlIGZpcnN0IHBsYWNlPw0KPj4+DQo+Pj4gVGhlIHdheSBpdCBjdXJy
ZW50bHkgaXMsIGRyYWluIGNhbiByZXR1cm4gYXNzdW1pbmcgdGhhdCB0aGVyZSBhcmUgbm8NCj4+
PiByZXF1ZXN0cywgYnV0IGFmdGVyIHRoZSB0aW1lb3V0IHRoZSByZXF1ZXN0IGF1dG9tYXRpY2Fs
bHkgY29tZXMgYmFjaw0KPj4+IHdoaWxlIHRoZSBkcmFpbiBjYWxsZXIgYXNzdW1lcyB0aGF0IHRo
ZXJlIGlzIG5vIG1vcmUgYWN0aXZpdHkuIFRoaXMNCj4+PiBkb2Vzbid0IGxvb2sgcmlnaHQuDQo+
Pg0KPj4gSG1tLg0KPj4NCj4+IFRoaXMgaW5kL2RlYyBhcm91bmQgYWxsIGxpZmV0aW1lIG9mIGNv
bm5lY3Rpb24gY29yb3V0aW5lIHlvdSBhZGRlZCBpbg0KPj4NCj4+IGNvbW1pdCA1YWQ4MWI0OTQ2
YmFmOTQ4YzY1Y2Y3ZTE0MzZkOWI3NDgwM2MxMjgwDQo+PiBBdXRob3I6IEtldmluIFdvbGYgPGt3
b2xmQHJlZGhhdC5jb20+DQo+PiBEYXRlOiAgIEZyaSBGZWIgMTUgMTY6NTM6NTEgMjAxOSArMDEw
MA0KPj4NCj4+ICAgICAgIG5iZDogUmVzdHJpY3QgY29ubmVjdGlvbl9jbyByZWVudHJhbmNlDQo+
Pg0KPj4NCj4+IEFuZCBub3cgSSB0cnkgdG8gY29ubmVjdCBpbiBlbmRsZXNzIGxvb3AsIHdpdGgg
cWVtdV9jb19zbGVlcF9ucygpIGluc2lkZS4NCj4+IEkgbmVlZCB0byBnZXQgYSBjaGFuZ2UgdG8g
YmRydl9kcmFpbiB0byBjb21wbGV0ZSwgc28gSSBoYXZlIHRvIHNvbWV0aW1lcw0KPj4gZHJvcCB0
aGlzIGluX2ZsaWdodCByZXF1ZXN0LiBCdXQgSSB1bmRlcnN0YW5kIHlvdXIgcG9pbnQuDQo+IA0K
PiBBaCwgcmlnaHQsIEkgc2VlLiBJIHRoaW5rIGl0J3MgZmluZSB0byBhZGQgYSBzZWNvbmQgcG9p
bnQgd2hlcmUgd2UNCj4gZGVjcmVhc2UgdGhlIGNvdW50ZXIgKHRob3VnaCBJIHdvdWxkIGFkZCBh
IGNvbW1lbnQgdGVsbGluZyB3aHkgd2UgZG8NCj4gdGhpcykgYXMgbG9uZyBhcyB0aGUgcmlnaHQg
Y29uZGl0aW9ucyBhcmUgbWV0Lg0KPiANCj4gVGhlIHJpZ2h0IGNvbmRpdGlvbnMgYXJlIHByb2Jh
Ymx5IHNvbWV0aGluZyBsaWtlOiBPbmNlIGRyYWluZWQsIHdlDQo+IGd1YXJhbnRlZSB0aGF0IHdl
IGRvbid0IGNhbGwgYW55IGNhbGxiYWNrcyB1bnRpbCB0aGUgZHJhaW5lZCBzZWN0aW9uDQo+IGVu
ZHMuIEluIG5iZF9yZWFkX2VvZigpIHRoaXMgaXMgdHJ1ZSBiZWNhdXNlIHdlIGNhbid0IGdldCBh
biBhbnN3ZXIgaWYNCj4gd2UgaGFkIG5vIHJlcXVlc3QgcnVubmluZy4NCj4gDQo+IE9yIGFjdHVh
bGx5Li4uIFRoaXMgYXNzdW1lcyBhIG5pY2UgY29tcGxpYW50IHNlcnZlciB0aGF0IGRvZXNuJ3Qg
anVzdA0KPiBhcmJpdHJhcmlseSBzZW5kIHVuZXhwZWN0ZWQgbWVzc2FnZXMuIElzIHRoZSBleGlz
dGluZyBjb2RlIGJyb2tlbiBpZiB3ZQ0KPiBjb25uZWN0IHRvIGEgbWFsaWNpb3VzIHNlcnZlcj8N
Cj4gDQo+PiBXaWxsIHRoZSBmb2xsb3dpbmcgd29yayBiZXR0ZXI/DQo+Pg0KPj4gYmRydl9kZWNf
aW5fZmxpZ2h0KGNvbi0+YnMpOw0KPj4gcWVtdV9jb19zbGVlcF9ucyguLi4pOw0KPj4gd2hpbGUg
KHMtPmRyYWluZWQpIHsNCj4+ICAgICBzLT53YWl0X2RyYWluZWRfZW5kID0gdHJ1ZTsNCj4+ICAg
ICBxZW11X2Nvcm91dGluZV95aWVsZCgpOw0KPj4gfQ0KPj4gYmRydl9pbmNfaW5fZmxpZ2h0KGNv
bi0+YnMpOw0KPj4NCj4+IC4uLg0KPj4gLmRyYWluZWRfYmVnaW4oKSB7DQo+PiAgICAgIHMtPmRy
YWluZWQgPSB0cnVlOw0KPj4gfQ0KPj4NCj4+IC5kcmFpbmVkX2VuZCgpIHsNCj4+ICAgICAgaWYg
KHMtPndhaXRfZHJhaW5lZF9lbmQpIHsNCj4+ICAgICAgICAgcy0+d2FpdF9kcmFpbmVkX2VuZCA9
IGZhbHNlOw0KPj4gICAgICAgICBhaW9fY29fd2FrZShzLT5jb25uZWN0aW9uX2NvKTsNCj4+ICAg
ICAgfQ0KPj4gfQ0KPiANCj4gVGhpcyBzaG91bGQgbWFrZSBzdXJlIHRoYXQgd2UgZG9uJ3QgY2Fs
bCBhbnkgY2FsbGJhY2tzIGJlZm9yZSB0aGUgZHJhaW4NCj4gc2VjdGlvbiBoYXMgZW5kZWQuDQo+
IA0KPiBXZSBwcm9iYWJseSBzdGlsbCBoYXZlIGEgcHJvYmxlbSBiZWNhdXNlIG5iZF9jbGllbnRf
YXR0YWNoX2Fpb19jb250ZXh0KCkNCj4gcmVlbnRlcnMgdGhlIGNvcm91dGluZSB3aXRoIHFlbXVf
YWlvX2Nvcm91dGluZV9lbnRlcigpLCB3aGljaCB3aWxsIGNhdXNlDQo+IGFuIGFzc2VydGlvbiBm
YWlsdXJlIGlmIGNvLT5zY2hlZHVsZWQgaXMgc2V0LiBTbyB0aGlzIG5lZWRzIHRvIHVzZSBhDQo+
IHZlcnNpb24gdGhhdCBjYW4gY2FuY2VsIGEgc2xlZXAuDQo+IA0KPiBJIHNlZSB0aGF0IHlvdXIg
cGF0Y2ggY3VycmVudGx5IHNpbXBseSBpZ25vcmVzIGF0dGFjaGluZyBhIG5ldyBjb250ZXh0LA0K
PiBidXQgdGhlbiB0aGUgY29yb3V0aW5lIHN0YXlzIGluIHRoZSBvbGQgQWlvQ29udGV4dC4gRGlk
IEkgbWlzcyBzb21lDQo+IGFkZGl0aW9uYWwgY29kZSB0aGF0IG1vdmVzIGl0IHRvIHRoZSBuZXcg
Y29udGV4dCBzb21laG93IG9yIHdpbGwgaXQganVzdA0KPiBzdGF5IHdoZXJlIGl0IHdhcyBpZiB0
aGUgY29yb3V0aW5lIGhhcHBlbnMgdG8gYmUgcmVjb25uZWN0aW5nIHdoZW4gdGhlDQo+IEFpb0Nv
bnRleHQgd2FzIHN1cHBvc2VkIHRvIGNoYW5nZT8NCg0KDQpIbW0uIERvIHlvdSBtZWFuICJpbiBs
YXR0ZXIgY2FzZSB3ZSBkbyBub3RoaW5nIiBpbg0KDQogICB2b2lkIG5iZF9jbGllbnRfYXR0YWNo
X2Fpb19jb250ZXh0KEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBBaW9Db250ZXh0ICpuZXdfY29udGV4dCkNCiAgIHsNCiAgICAgICBO
QkRDbGllbnRTZXNzaW9uICpjbGllbnQgPSBuYmRfZ2V0X2NsaWVudF9zZXNzaW9uKGJzKTsNCg0K
ICAgICAgIC8qDQogICAgICAgICogY2xpZW50LT5jb25uZWN0aW9uX2NvIGlzIGVpdGhlciB5aWVs
ZGVkIGZyb20gbmJkX3JlY2VpdmVfcmVwbHkgb3IgZnJvbQ0KICAgICAgICAqIG5iZF9yZWNvbm5l
Y3RfbG9vcCgpLCBpbiBsYXR0ZXIgY2FzZSB3ZSBkbyBub3RoaW5nDQogICAgICAgICovDQogICAg
ICAgaWYgKGNsaWVudC0+c3RhdGUgPT0gTkJEX0NMSUVOVF9DT05ORUNURUQpIHsNCiAgICAgICAg
ICAgcWlvX2NoYW5uZWxfYXR0YWNoX2Fpb19jb250ZXh0KFFJT19DSEFOTkVMKGNsaWVudC0+aW9j
KSwgbmV3X2NvbnRleHQpOw0KDQogICAgICAgICAgIGJkcnZfaW5jX2luX2ZsaWdodChicyk7DQoN
CiAgICAgICAgICAgLyoNCiAgICAgICAgICAgICogTmVlZCB0byB3YWl0IGhlcmUgZm9yIHRoZSBC
SCB0byBydW4gYmVjYXVzZSB0aGUgQkggbXVzdCBydW4gd2hpbGUgdGhlDQogICAgICAgICAgICAq
IG5vZGUgaXMgc3RpbGwgZHJhaW5lZC4NCiAgICAgICAgICAgICovDQogICAgICAgICAgIGFpb193
YWl0X2JoX29uZXNob3QobmV3X2NvbnRleHQsIG5iZF9jbGllbnRfYXR0YWNoX2Fpb19jb250ZXh0
X2JoLCBicyk7DQogICAgICAgfQ0KICAgfQ0KDQo/DQpOb3Qgc3VyZSB3aHkgSSBpZ25vcmVkIHRo
aXMgY2FzZS4gU28sIEkgc2hvdWxkIHJ1biBpZigpIGJvZHkgdW5jb25kaXRpb25hbGx5IGhlcmUg
YW5kIHN1cHBvcnQNCmludGVycnVwdGluZyB0aW1lci1zbGVlcGluZyBjb3JvdXRpbmUgaW4gbmJk
X2NsaWVudF9hdHRhY2hfYWlvX2NvbnRleHRfYmgsIHllcz8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

