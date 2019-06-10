Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3874AC282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075C8206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GCCUusxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075C8206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGxV-0000DE-TZ
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48270)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haGsw-0003Rd-71
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haGss-0006dI-B5
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:46:36 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:38369 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1haGsm-0006Ww-OC; Mon, 10 Jun 2019 05:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pY4j3jYlpojBi5q06AK90NyJfX83qnsfkRXZuRtG5FM=;
 b=GCCUusxHoJlK9H5fhuC1poK+Gsoz9/Va+Y96AsuQ/m+wB6NkRZpy2dZICkNDRX4X+tvQeeBETAfX6SOyM9Z4nsiwKgUEOmuVDcE5M6ZV59ryEqsDEiUL37XMUViEl4X7WU8v5V8KDnf3wLcsrhnN8onthC34OtiKqK04Rn1tS1U=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3985.eurprd08.prod.outlook.com (20.178.118.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 09:46:20 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 09:46:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add hide/unhide API
Thread-Index: AQHVGgPwBj3MFoZcyE+HgKuZ0A6+WqaQz8YAgAQNsACAAAJSAP//zuOA
Date: Mon, 10 Jun 2019 09:46:20 +0000
Message-ID: <ba125cb0-95ab-3800-855e-0a31305d378e@virtuozzo.com>
References: <20190603120005.37394-1-vsementsov@virtuozzo.com>
 <20190603120005.37394-3-vsementsov@virtuozzo.com>
 <1e937a40-5ce2-467a-a50b-e8f822f2dcdc@redhat.com>
 <f26f5edb-279e-8153-86bf-767cb04c4c74@virtuozzo.com>
 <39132feb-128d-004b-f40c-bb64f75c3298@virtuozzo.com>
In-Reply-To: <39132feb-128d-004b-f40c-bb64f75c3298@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::36) To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190610124617629
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77865f99-5fc8-4594-a64a-08d6ed887d82
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3985; 
x-ms-traffictypediagnostic: AM0PR08MB3985:
x-microsoft-antispam-prvs: <AM0PR08MB398515632D6EC30F409EB4E5C1130@AM0PR08MB3985.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(136003)(39840400004)(376002)(189003)(199004)(52314003)(68736007)(110136005)(54906003)(305945005)(316002)(6246003)(446003)(76176011)(52116002)(11346002)(486006)(8936002)(81166006)(6486002)(256004)(8676002)(99286004)(2616005)(229853002)(476003)(31686004)(107886003)(2906002)(6512007)(4326008)(14444005)(81156014)(5660300002)(6436002)(66946007)(73956011)(7736002)(66476007)(64756008)(66556008)(71200400001)(71190400001)(66446008)(3846002)(6116002)(478600001)(36756003)(2201001)(31696002)(6506007)(26005)(66066001)(25786009)(186003)(14454004)(102836004)(86362001)(2501003)(53936002)(386003)(53546011)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3985;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uXdmxbQvPL0KQ2IGVRzk9q3FUk4B1JQYXUe0CgmC3gPKks2pvnzXRytW+c6fGYB7I9iuYCdPOmFgpfyOlpyFgZBjnKifdJtNZilwX1z7H0+0rj5BkyaKMBw7IbodIGr637ANXoPgI8KzZLJzOZngeqIT0+OMHLonSVwHkvUH2KTIIRSxdalioxu9pT4OE4t3eaeViuof6u77doeyQaqJiiEHSCrgCu8paSzuOtXPTvx2hiLyEu+FthMN0W7ArRLyI4GXVKGgFBBeWX+vkIid3PXMthq/aWu/L6W7n0gegxFEUsQGK2gALjzuvvd55K5QWBvMiFHYbBtZ3eZ3Lrg8Ql2jcCF4ie0qrp1UHCWdB+rs0fgkBWnc1miOimEK5pz2eYrvcwTHbzfx1qww171kLpJ6VJSaLTcXrvZXS9zNevg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE8E7613637F794798B0E3BC2A5AEF4E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77865f99-5fc8-4594-a64a-08d6ed887d82
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 09:46:20.2689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3985
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.137
Subject: Re: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add hide/unhide API
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTAuMDYuMjAxOSAxMjo0MiwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTAuMDYuMjAxOSAxMjozMywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
IDA4LjA2LjIwMTkgMTozOSwgSm9obiBTbm93IHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiA2LzMv
MTkgODowMCBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gQWRk
IGZ1bmN0aW9uYWxpdHkgdG8gbWFrZSBiaXRtYXAgdGVtcG9yYXJ5IGFub255bW91cy4gSXQgd2ls
bCBiZSB1c2VkDQo+Pj4+IHRvIGltcGxlbWVudCBiaXRtYXAgcmVtb3ZlIHRyYW5zYWN0aW9uIGFj
dGlvbi4gV2UgbmVlZCBoaWRlIGJpdG1hcA0KPj4+PiBwZXJzaXN0ZW5jZSB0b28sIGFzIHRoZXJl
IGFyZSBzaG91bGQgbm90IGJlIHVubmFtZWQgcGVyc2lzdGVudCBiaXRtYXBzLg0KPj4+Pg0KPj4+
DQo+Pj4gQWgsIHNvIHRoaXMgZWZmZWN0aXZlbHkgLi4uICJoaWRlcyIgYSBiaXRtYXAgZnJvbSBh
bnkgZnVydGhlcg0KPj4+IHRyYW5zYWN0aW9uIGFjdGlvbnMuIEl0IGFsc28gImhpZGVzIiBpdCBm
cm9tIGdldHRpbmcgZmx1c2hlZCB0byBkaXNrLi4uDQo+Pj4gc29ydCBvZj8NCj4+Pg0KPj4+IFRo
ZSBvdXRlciBsb29wIGluIHN0b3JlIHdvcmtzIHdpdGggYmRydl9kaXJ0eV9iaXRtYXBfbmV4dCwg
YW5kIHdlJ2xsDQo+Pj4gc2tpcCB0aGlzIGJpdG1hcCBiZWNhdXNlIGl0J3MgYW5vbnltb3VzL25v
dCBwZXJzaXN0ZW50Lg0KPj4+DQo+Pj4gVGhlcmUncyBhIHNlY29uZCBsb29wIHdoZXJlIHdlIGl0
ZXJhdGUgYm1fbGlzdCwgYW5kIHdlJ2xsIHNraXAgc3RvcmluZw0KPj4+IHRoaXMgYml0bWFwIGJl
Y2F1c2UgdGhhdCBlbnRyeSB3b24ndCBoYXZlIGFuIGluLW1lbW9yeSBiaXRtYXAgYXNzb2NpYXRl
ZA0KPj4+IHdpdGggaXQgaW4gYm1fbGlzdC4NCj4+Pg0KPj4+IC4uLkJ1dCB0aGVuIHdlJ2xsIGNh
bGwgdXBkYXRlX2V4dF9oZWFkZXJfYW5kX2RpciB3aXRoIHRoZSBzdGFsZSBlbnRyaWVzDQo+Pj4g
aW4gYm1fbGlzdD8NCj4+DQo+PiBIaWRkZW4gaXMgYSB0ZW1wcm9yeSBzdGF0ZSwgc28sIHdlIHNo
b3VsZCBub3QgZ28gdG8gY2xvc2UoKSBpbiB0aGlzIHN0YXRlLg0KPj4gSXQncyBhIHN0YXRlIGlu
c2lkZSBhIHRyYW5zYWN0aW9uLg0KPj4NCj4+IFN0YWxlIGVudHJpZXMgaW4gbGlzdCB3aWxsIGJl
IG1hcmtlZCBJTl9VU0UgYW55d2F5LCBzbyB0aGVyZSBpcyBubyBkYW1hZ2UgYW55d2F5Lg0KPiAN
Cj4gSSdtIHdyb25nLCBzdG9yaW5nIGluc2lkZSB0cmFuc2FjdGlvbiBpcyBleGFjdGx5IHdoYXQg
dGVzdCBkb2VzLi4gSG1tLCBzbywgc2VlbXMgeW91DQo+IGFyZSByaWdodCwgd2UgYXJlIHN0b3Jp
bmcgc3RhbGUgSU5fVVNFIGJpdG1hcHMuIE5vIHNlcmlvdXMgZGFtYWdlLCBidXQgYmFkIGRlc2ln
bjoNCj4gY3JlYXRpbmcgaW5jb25zaXN0ZW50IGJpdG1hcHMgaW4gZWFjaCBzbmFwc2hvdC4gSSBu
ZWVkIHRvIGZpeCBpdCBpbiB2MiBzb21laG93Lg0KDQpBaGFoYSwgYW5kIEknbSB3cm9uZyBhZ2Fp
biwgYXMgbXkgc2VyaWVzIGRvIHJpZ2h0IHRoaW5nOiByZW1vdmUgYml0bWFwIGZyb20gdGhlIGlt
YWdlDQppbiAucHJlcGFyZSwgc28gdGhlcmUgd2lsbCBiZSBubyBzdGFsZSBlbnRyaWVzLi4NCg0K
PiANCj4+DQo+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+Pj4gwqAgaW5jbHVk
ZS9ibG9jay9kaXJ0eS1iaXRtYXAuaCB8wqAgMiArKw0KPj4+PiDCoCBibG9jay9kaXJ0eS1iaXRt
YXAuY8KgwqDCoMKgwqDCoMKgwqAgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+
PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvYmxvY2svZGlydHktYml0bWFwLmggYi9pbmNsdWRlL2Jsb2NrL2RpcnR5
LWJpdG1hcC5oDQo+Pj4+IGluZGV4IDgwNDRhY2U2M2UuLjU0MmU0MzcxMjMgMTAwNjQ0DQo+Pj4+
IC0tLSBhL2luY2x1ZGUvYmxvY2svZGlydHktYml0bWFwLmgNCj4+Pj4gKysrIGIvaW5jbHVkZS9i
bG9jay9kaXJ0eS1iaXRtYXAuaA0KPj4+PiBAQCAtMTE2LDUgKzExNiw3IEBAIGJvb2wgYmRydl9k
aXJ0eV9iaXRtYXBfbmV4dF9kaXJ0eV9hcmVhKEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFwLA0KPj4+
PiDCoCBCZHJ2RGlydHlCaXRtYXAgKmJkcnZfcmVjbGFpbV9kaXJ0eV9iaXRtYXBfbG9ja2VkKEJs
b2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgQmRydkRpcnR5Qml0bWFwICpiaXRtYXAsDQo+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFcnJvciAqKmVycnApOw0KPj4+PiAr
dm9pZCBiZHJ2X2RpcnR5X2JpdG1hcF9oaWRlKEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFwKTsNCj4+
Pj4gK3ZvaWQgYmRydl9kaXJ0eV9iaXRtYXBfdW5oaWRlKEJkcnZEaXJ0eUJpdG1hcCAqYml0bWFw
KTsNCj4+Pj4gwqAgI2VuZGlmDQo+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9kaXJ0eS1iaXRtYXAu
YyBiL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+Pj4+IGluZGV4IDQ5NjQ2YTMwZTYuLjU5Mjk2NDYz
NWUgMTAwNjQ0DQo+Pj4+IC0tLSBhL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+Pj4+ICsrKyBiL2Js
b2NrL2RpcnR5LWJpdG1hcC5jDQo+Pj4+IEBAIC0zNSw2ICszNSwxMCBAQCBzdHJ1Y3QgQmRydkRp
cnR5Qml0bWFwIHsNCj4+Pj4gwqDCoMKgwqDCoCBib29sIGJ1c3k7wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvKiBCaXRtYXAgaXMgYnVzeSwgaXQgY2FuJ3QgYmUgdXNlZCB2aWEg
UU1QICovDQo+Pj4+IMKgwqDCoMKgwqAgQmRydkRpcnR5Qml0bWFwICpzdWNjZXNzb3I7IC8qIEFu
b255bW91cyBjaGlsZCwgaWYgYW55LiAqLw0KPj4+PiDCoMKgwqDCoMKgIGNoYXIgKm5hbWU7wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogT3B0aW9uYWwgbm9uLWVtcHR5IHVuaXF1
ZSBJRCAqLw0KPj4+PiArwqDCoMKgIGNoYXIgKmhpZGRlbl9uYW1lO8KgwqDCoMKgwqDCoMKgwqDC
oCAvKiBCYWNrdXAgb2YgQG5hbWUgZm9yIHJlbW92YWwgdHJhbnNhY3Rpb24NCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGFjdGlvbi4gVXNlZCBmb3IgaGlkZS91bmhpZGUgQVBJLiAqLw0KPj4+PiArwqDCoMKg
IGJvb2wgaGlkZGVuX3BlcnNpc3RlbnQ7wqDCoMKgwqAgLyogQmFja3VwIG9mIEBwZXJzaXN0ZW50
IGZvciByZW1vdmFsIHRyYW5zYWN0aW9uDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhY3Rpb24uICovDQo+
Pj4+IMKgwqDCoMKgwqAgaW50NjRfdCBzaXplO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LyogU2l6ZSBvZiB0aGUgYml0bWFwLCBpbiBieXRlcyAqLw0KPj4+PiDCoMKgwqDCoMKgIGJvb2wg
ZGlzYWJsZWQ7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogQml0bWFwIGlzIGRpc2FibGVk
LiBJdCBpZ25vcmVzIGFsbCB3cml0ZXMgdG8NCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRoZSBkZXZp
Y2UgKi8NCj4+Pj4gQEAgLTg0OSwzICs4NTMsMjUgQEAgb3V0Og0KPj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgcWVtdV9tdXRleF91bmxvY2soc3JjLT5tdXRleCk7DQo+Pj4+IMKgwqDCoMKgwqAgfQ0K
Pj4+PiDCoCB9DQo+Pj4+ICsNCj4+Pj4gK3ZvaWQgYmRydl9kaXJ0eV9iaXRtYXBfaGlkZShCZHJ2
RGlydHlCaXRtYXAgKmJpdG1hcCkNCj4+Pj4gK3sNCj4+Pj4gK8KgwqDCoCBxZW11X211dGV4X2xv
Y2soYml0bWFwLT5tdXRleCk7DQo+Pj4+ICvCoMKgwqAgYXNzZXJ0KCFiaXRtYXAtPmhpZGRlbl9u
YW1lKTsNCj4+Pj4gK8KgwqDCoCBiaXRtYXAtPmhpZGRlbl9uYW1lID0gYml0bWFwLT5uYW1lOw0K
Pj4+PiArwqDCoMKgIGJpdG1hcC0+aGlkZGVuX3BlcnNpc3RlbnQgPSBiaXRtYXAtPnBlcnNpc3Rl
bnQ7DQo+Pj4+ICvCoMKgwqAgYml0bWFwLT5uYW1lID0gTlVMTDsNCj4+Pj4gK8KgwqDCoCBiaXRt
YXAtPnBlcnNpc3RlbnQgPSBmYWxzZTsNCj4+Pj4gK8KgwqDCoCBxZW11X211dGV4X3VubG9jayhi
aXRtYXAtPm11dGV4KTsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArdm9pZCBiZHJ2X2RpcnR5X2Jp
dG1hcF91bmhpZGUoQmRydkRpcnR5Qml0bWFwICpiaXRtYXApDQo+Pj4+ICt7DQo+Pj4+ICvCoMKg
wqAgcWVtdV9tdXRleF9sb2NrKGJpdG1hcC0+bXV0ZXgpOw0KPj4+PiArwqDCoMKgIGFzc2VydCgh
Yml0bWFwLT5uYW1lKTsNCj4+Pj4gK8KgwqDCoCBiaXRtYXAtPm5hbWUgPSBiaXRtYXAtPmhpZGRl
bl9uYW1lOw0KPj4+PiArwqDCoMKgIGJpdG1hcC0+cGVyc2lzdGVudCA9IGJpdG1hcC0+aGlkZGVu
X3BlcnNpc3RlbnQ7DQo+Pj4+ICvCoMKgwqAgYml0bWFwLT5oaWRkZW5fbmFtZSA9IE5VTEw7DQo+
Pj4+ICvCoMKgwqAgYml0bWFwLT5oaWRkZW5fcGVyc2lzdGVudCA9IGZhbHNlOw0KPj4+PiArwqDC
oMKgIHFlbXVfbXV0ZXhfdW5sb2NrKGJpdG1hcC0+bXV0ZXgpOw0KPj4+PiArfQ0KPj4+Pg0KPj4N
Cj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

