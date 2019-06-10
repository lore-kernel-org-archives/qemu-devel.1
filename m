Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646A2C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 317C2206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RGCpDBkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317C2206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43014 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGvX-0004r7-EY
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47921)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haGr9-0002Xq-1M
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1haGr4-0005U2-5R
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:44:46 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:13997 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1haGqy-0005O5-H7; Mon, 10 Jun 2019 05:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivnfRKmqgSTDtyNHDP0SDozt1uDbIGSP+gQWuUuXI3s=;
 b=RGCpDBkKY0XixGwKjXL0xVw49YhVjPLOo2Xa6M9WIY7nhybYLrEUHtHceIIiGrWd35PZOw8kWh0rWVDZaeZazblA2DUszVLTKVPP1GXM8GT6c7n9F9wmKiRBAi80ybUFJCY0RqjRoPU45rShxZT7vMZi3D0ZOjdkoLMC6KfOAy0=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3985.eurprd08.prod.outlook.com (20.178.118.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 09:44:32 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 09:44:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 2/4] block/dirty-bitmap: add hide/unhide API
Thread-Index: AQHVGgPwBj3MFoZcyE+HgKuZ0A6+WqaQz8YAgAQNsACAAAJSAP//zmMA
Date: Mon, 10 Jun 2019 09:44:32 +0000
Message-ID: <ff745697-58a6-8ee8-06ce-799c59c36445@virtuozzo.com>
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
x-clientproxiedby: HE1P192CA0024.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::34)
 To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190610124430172
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10c349e3-fa32-4a9d-9f29-08d6ed883d8a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3985; 
x-ms-traffictypediagnostic: AM0PR08MB3985:
x-microsoft-antispam-prvs: <AM0PR08MB39858F5D0B40EFB0F3EF4B90C1130@AM0PR08MB3985.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(346002)(136003)(39840400004)(376002)(189003)(199004)(52314003)(68736007)(110136005)(54906003)(305945005)(316002)(6246003)(446003)(76176011)(52116002)(11346002)(486006)(8936002)(81166006)(6486002)(256004)(8676002)(99286004)(2616005)(229853002)(476003)(31686004)(107886003)(2906002)(6512007)(4326008)(14444005)(81156014)(5660300002)(6436002)(66946007)(73956011)(7736002)(66476007)(64756008)(66556008)(71200400001)(71190400001)(66446008)(3846002)(6116002)(478600001)(36756003)(2201001)(31696002)(6506007)(26005)(66066001)(25786009)(186003)(14454004)(102836004)(86362001)(2501003)(53936002)(386003)(53546011)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3985;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FhvHFr7j/9VqG84/UeZTQlhSzyp3AN8fgy2aWtMmfhSYhAZDZFDOjH3tVbeSlZtIlRPqLTxfK6CLjV0xU4EaQyilEspvxuQlzkl3iW2f95Qghh5dkuvPpAmhTzCRFCvmIs1YAJTNFTzBG9NBTlxHPoJg+dlaUAaBrv9QFox3aAN5d1ipC7IyJO/7bPEfzFo2Pa9T8k4pJrDLAgG7KEW00hUUzMvDx7iDqnSMgx+56YRi+K7iI4/O4ZCz6dxaD8OXkiGXGBIWoLXBdMelxbZpd6ngMhzJwr8exAInTP5muJ0wIi6t/XMB8UwOqURqHV3lInimQtHYGH/QPEpKZz6PCwVuMrV1xMa1Ubw1tUMUQ4biJ6oATtsvKfjOb43mC7rZ6qUKxbCYCcxP3deUXGlNzZfHWB3FhEtcSKVyKUC41XY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCBF817E3A40FE44AFBCE67E6B5FC2C9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c349e3-fa32-4a9d-9f29-08d6ed883d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 09:44:32.5662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3985
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.131
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
ZWVkIHRvIGZpeCBpdCBpbiB2MiBzb21laG93Lg0KDQpBaGFoYSwgYW5kIEknbSBhZ2FpbiB3cm9u
ZywgYXMgbXkgc2VyaWVzIGRvIHJpZ2h0IHRoaW5nOiByZW1vdmUgYml0bWFwIGZyb20gdGhlIGlt
YWdlDQppbiAucHJlcGFyZSwgc28gdGhlcmUgd291bGQgbm90IGJlIHN0YWxlIGVudHJpZXMsIGFs
bCBpcyBPSy4NCg0KPiANCj4+DQo+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+
Pj4gwqAgaW5jbHVkZS9ibG9jay9kaXJ0eS1iaXRtYXAuaCB8wqAgMiArKw0KPj4+PiDCoCBibG9j
ay9kaXJ0eS1iaXRtYXAuY8KgwqDCoMKgwqDCoMKgwqAgfCAyNiArKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykNCj4+Pj4N
Cj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYmxvY2svZGlydHktYml0bWFwLmggYi9pbmNsdWRl
L2Jsb2NrL2RpcnR5LWJpdG1hcC5oDQo+Pj4+IGluZGV4IDgwNDRhY2U2M2UuLjU0MmU0MzcxMjMg
MTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvYmxvY2svZGlydHktYml0bWFwLmgNCj4+Pj4gKysr
IGIvaW5jbHVkZS9ibG9jay9kaXJ0eS1iaXRtYXAuaA0KPj4+PiBAQCAtMTE2LDUgKzExNiw3IEBA
IGJvb2wgYmRydl9kaXJ0eV9iaXRtYXBfbmV4dF9kaXJ0eV9hcmVhKEJkcnZEaXJ0eUJpdG1hcCAq
Yml0bWFwLA0KPj4+PiDCoCBCZHJ2RGlydHlCaXRtYXAgKmJkcnZfcmVjbGFpbV9kaXJ0eV9iaXRt
YXBfbG9ja2VkKEJsb2NrRHJpdmVyU3RhdGUgKmJzLA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQmRydkRpcnR5Qml0bWFwICpiaXRtYXAsDQo+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFcnJvciAqKmVy
cnApOw0KPj4+PiArdm9pZCBiZHJ2X2RpcnR5X2JpdG1hcF9oaWRlKEJkcnZEaXJ0eUJpdG1hcCAq
Yml0bWFwKTsNCj4+Pj4gK3ZvaWQgYmRydl9kaXJ0eV9iaXRtYXBfdW5oaWRlKEJkcnZEaXJ0eUJp
dG1hcCAqYml0bWFwKTsNCj4+Pj4gwqAgI2VuZGlmDQo+Pj4+IGRpZmYgLS1naXQgYS9ibG9jay9k
aXJ0eS1iaXRtYXAuYyBiL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+Pj4+IGluZGV4IDQ5NjQ2YTMw
ZTYuLjU5Mjk2NDYzNWUgMTAwNjQ0DQo+Pj4+IC0tLSBhL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+
Pj4+ICsrKyBiL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+Pj4+IEBAIC0zNSw2ICszNSwxMCBAQCBz
dHJ1Y3QgQmRydkRpcnR5Qml0bWFwIHsNCj4+Pj4gwqDCoMKgwqDCoCBib29sIGJ1c3k7wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBCaXRtYXAgaXMgYnVzeSwgaXQgY2FuJ3Qg
YmUgdXNlZCB2aWEgUU1QICovDQo+Pj4+IMKgwqDCoMKgwqAgQmRydkRpcnR5Qml0bWFwICpzdWNj
ZXNzb3I7IC8qIEFub255bW91cyBjaGlsZCwgaWYgYW55LiAqLw0KPj4+PiDCoMKgwqDCoMKgIGNo
YXIgKm5hbWU7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogT3B0aW9uYWwgbm9u
LWVtcHR5IHVuaXF1ZSBJRCAqLw0KPj4+PiArwqDCoMKgIGNoYXIgKmhpZGRlbl9uYW1lO8KgwqDC
oMKgwqDCoMKgwqDCoCAvKiBCYWNrdXAgb2YgQG5hbWUgZm9yIHJlbW92YWwgdHJhbnNhY3Rpb24N
Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGFjdGlvbi4gVXNlZCBmb3IgaGlkZS91bmhpZGUgQVBJLiAqLw0K
Pj4+PiArwqDCoMKgIGJvb2wgaGlkZGVuX3BlcnNpc3RlbnQ7wqDCoMKgwqAgLyogQmFja3VwIG9m
IEBwZXJzaXN0ZW50IGZvciByZW1vdmFsIHRyYW5zYWN0aW9uDQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
Y3Rpb24uICovDQo+Pj4+IMKgwqDCoMKgwqAgaW50NjRfdCBzaXplO8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgLyogU2l6ZSBvZiB0aGUgYml0bWFwLCBpbiBieXRlcyAqLw0KPj4+PiDCoMKg
wqDCoMKgIGJvb2wgZGlzYWJsZWQ7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogQml0bWFw
IGlzIGRpc2FibGVkLiBJdCBpZ25vcmVzIGFsbCB3cml0ZXMgdG8NCj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHRoZSBkZXZpY2UgKi8NCj4+Pj4gQEAgLTg0OSwzICs4NTMsMjUgQEAgb3V0Og0KPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgcWVtdV9tdXRleF91bmxvY2soc3JjLT5tdXRleCk7DQo+Pj4+IMKg
wqDCoMKgwqAgfQ0KPj4+PiDCoCB9DQo+Pj4+ICsNCj4+Pj4gK3ZvaWQgYmRydl9kaXJ0eV9iaXRt
YXBfaGlkZShCZHJ2RGlydHlCaXRtYXAgKmJpdG1hcCkNCj4+Pj4gK3sNCj4+Pj4gK8KgwqDCoCBx
ZW11X211dGV4X2xvY2soYml0bWFwLT5tdXRleCk7DQo+Pj4+ICvCoMKgwqAgYXNzZXJ0KCFiaXRt
YXAtPmhpZGRlbl9uYW1lKTsNCj4+Pj4gK8KgwqDCoCBiaXRtYXAtPmhpZGRlbl9uYW1lID0gYml0
bWFwLT5uYW1lOw0KPj4+PiArwqDCoMKgIGJpdG1hcC0+aGlkZGVuX3BlcnNpc3RlbnQgPSBiaXRt
YXAtPnBlcnNpc3RlbnQ7DQo+Pj4+ICvCoMKgwqAgYml0bWFwLT5uYW1lID0gTlVMTDsNCj4+Pj4g
K8KgwqDCoCBiaXRtYXAtPnBlcnNpc3RlbnQgPSBmYWxzZTsNCj4+Pj4gK8KgwqDCoCBxZW11X211
dGV4X3VubG9jayhiaXRtYXAtPm11dGV4KTsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArdm9pZCBi
ZHJ2X2RpcnR5X2JpdG1hcF91bmhpZGUoQmRydkRpcnR5Qml0bWFwICpiaXRtYXApDQo+Pj4+ICt7
DQo+Pj4+ICvCoMKgwqAgcWVtdV9tdXRleF9sb2NrKGJpdG1hcC0+bXV0ZXgpOw0KPj4+PiArwqDC
oMKgIGFzc2VydCghYml0bWFwLT5uYW1lKTsNCj4+Pj4gK8KgwqDCoCBiaXRtYXAtPm5hbWUgPSBi
aXRtYXAtPmhpZGRlbl9uYW1lOw0KPj4+PiArwqDCoMKgIGJpdG1hcC0+cGVyc2lzdGVudCA9IGJp
dG1hcC0+aGlkZGVuX3BlcnNpc3RlbnQ7DQo+Pj4+ICvCoMKgwqAgYml0bWFwLT5oaWRkZW5fbmFt
ZSA9IE5VTEw7DQo+Pj4+ICvCoMKgwqAgYml0bWFwLT5oaWRkZW5fcGVyc2lzdGVudCA9IGZhbHNl
Ow0KPj4+PiArwqDCoMKgIHFlbXVfbXV0ZXhfdW5sb2NrKGJpdG1hcC0+bXV0ZXgpOw0KPj4+PiAr
fQ0KPj4+Pg0KPj4NCj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWly
DQo=

