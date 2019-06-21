Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F3EC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 10:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CD2208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 10:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dlo1QVZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CD2208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heGWe-00035P-5Y
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 06:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54548)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heGKj-0001no-TO
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1heGKg-0007eV-Qv
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 05:59:49 -0400
Received: from mail-eopbgr20111.outbound.protection.outlook.com
 ([40.107.2.111]:61414 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1heGKd-0007dH-Af; Fri, 21 Jun 2019 05:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwMMXD2xMm5bAYPtRFDfEOYVl+U1wNT1PoP91CpBSDc=;
 b=dlo1QVZS1zx74QZz3r51LAXf3iebBaq+iy9OihXqeW6hA1dB4ot0bGCgmQA6/eR1p5NoWJDY0Mgrbeyur+2fHsEwW2u8uqiPQ0asmu8raUpBgWFQeXTVwfNhlDLtZNftcMJooLgstwK/aYbly7ar6/jzmZy/uFK4SOHhH95Uyno=
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com (20.179.46.151) by
 DBBPR08MB4394.eurprd08.prod.outlook.com (20.179.42.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Fri, 21 Jun 2019 09:59:39 +0000
Received: from DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3]) by DBBPR08MB4838.eurprd08.prod.outlook.com
 ([fe80::9c49:321c:cc13:35d3%3]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 09:59:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
Thread-Topic: [Qemu-devel] [Qemu-block] [PATCH] blk: postpone request
 execution on a context protected with "drained section"
Thread-Index: AQHUjJVeO5+XWLnUGkeJykuaR8qJNqVzNxOAgAaUQwCAAUbigIABfM+AgAAUUoCAAYsRgICMJU6AgB7xGQCACxh6AIByra8AgAAL7IA=
Date: Fri, 21 Jun 2019 09:59:39 +0000
Message-ID: <d2ad5561-1806-d885-350a-b43dd0fe4339@virtuozzo.com>
References: <20181205122326.26625-1-dplotnikov@virtuozzo.com>
 <20181207122647.GE5119@linux.fritz.box>
 <bb51b8f9-a3a4-90e6-2f69-57e90ccd623a@virtuozzo.com>
 <20181212122457.GB5415@linux.fritz.box>
 <d0d2cab4-2157-1f9f-3bc9-a70f28a211b0@virtuozzo.com>
 <20181213122039.GC5427@linux.fritz.box>
 <f2fcbcc2-5e0f-053d-f4c7-fe0f5f6092f0@virtuozzo.com>
 <20190313160412.GF5167@linux.fritz.box>
 <101bbf98-0456-5022-e117-fd6f693a8786@virtuozzo.com>
 <20190409100142.GC6610@localhost.localdomain>
 <20190621091656.GA9744@localhost.localdomain>
In-Reply-To: <20190621091656.GA9744@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR08CA0051.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::22) To DBBPR08MB4838.eurprd08.prod.outlook.com
 (2603:10a6:10:d9::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190621125937235
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a3eeaeb-803b-44da-6b72-08d6f62f2cb8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4394; 
x-ms-traffictypediagnostic: DBBPR08MB4394:
x-microsoft-antispam-prvs: <DBBPR08MB4394A3286B3E80C2B1B2FDB5C1E70@DBBPR08MB4394.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(376002)(366004)(136003)(39840400004)(189003)(199004)(6486002)(6246003)(6512007)(73956011)(4326008)(68736007)(53936002)(6506007)(229853002)(76176011)(64756008)(2906002)(446003)(66446008)(66476007)(36756003)(31696002)(186003)(11346002)(71190400001)(86362001)(305945005)(71200400001)(2616005)(99286004)(25786009)(26005)(66066001)(102836004)(7736002)(6636002)(316002)(81166006)(486006)(52116002)(256004)(31686004)(8936002)(54906003)(81156014)(66556008)(3846002)(14444005)(476003)(8676002)(6116002)(66946007)(110136005)(53546011)(478600001)(14454004)(386003)(5660300002)(6436002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4394;
 H:DBBPR08MB4838.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d6W7eOXFu105BW0bsD0Me1bKiPGnfs66VWo0IjC5ddy3aIFFUv2HABsylCErNmqyo3a6OQ9G7Xt4Ibl4tyJ/1TacFMKXfsiLU1MfRwq8YxK1QtnI9qYKUH6rz8i5E8K2HCcGXhf7mJAPATZpDchbOjwj5PfLELvCrG1fs/hyhjsShUvt+haS/elNrqASvIK2QxIJFuRckvLtCbZaPoner2aee8FRaDl+aQQWgsbqmt6DRCycTIxUbChuBelqhmcPUVKLhqbatjtmL5sKS6imp51fhGnXSXiKuKWsizQuJRVcZZHpkSS+L+PlnRpPUR9U/t9yZ4s0KVEdDkGTDcd55MwgSv+JjQqPqk7tH8GDALoyNsUGJMY7+oatid14XGPZK66oFpS77P5JZ+YA/wSdGSyftl7bHwxqh0WUdQakMnw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B7CAC736385824D8FB56C744142EB4A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3eeaeb-803b-44da-6b72-08d6f62f2cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 09:59:39.6631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4394
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.111
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blk: postpone request
 execution on a context protected with "drained section"
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "keith.busch@intel.com" <keith.busch@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMDYuMjAxOSAxMjoxNiwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMDkuMDQuMjAxOSB1bSAx
MjowMSBoYXQgS2V2aW4gV29sZiBnZXNjaHJpZWJlbjoNCj4+IEFtIDAyLjA0LjIwMTkgdW0gMTA6
MzUgaGF0IERlbmlzIFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+PiBPbiAxMy4wMy4yMDE5IDE5
OjA0LCBLZXZpbiBXb2xmIHdyb3RlOg0KPj4+PiBBbSAxNC4xMi4yMDE4IHVtIDEyOjU0IGhhdCBE
ZW5pcyBQbG90bmlrb3YgZ2VzY2hyaWViZW46DQo+Pj4+PiBPbiAxMy4xMi4yMDE4IDE1OjIwLCBL
ZXZpbiBXb2xmIHdyb3RlOg0KPj4+Pj4+IEFtIDEzLjEyLjIwMTggdW0gMTI6MDcgaGF0IERlbmlz
IFBsb3RuaWtvdiBnZXNjaHJpZWJlbjoNCj4+Pj4+Pj4gU291bmRzIGl0IHNob3VsZCBiZSBzbywg
YnV0IGl0IGRvZXNuJ3Qgd29yayB0aGF0IHdheSBhbmQgdGhhdCdzIHdoeToNCj4+Pj4+Pj4gd2hl
biBkb2luZyBtaXJyb3Igd2UgbWF5IHJlc3VtZSBwb3N0cG9uZWQgY29yb3V0aW5lcyB0b28gZWFy
bHkgd2hlbiB0aGUNCj4+Pj4+Pj4gdW5kZXJseWluZyBicyBpcyBwcm90ZWN0ZWQgZnJvbSB3cml0
aW5nIGF0IGFuZCB0aHVzIHdlIGVuY291bnRlciB0aGUNCj4+Pj4+Pj4gYXNzZXJ0IG9uIGEgd3Jp
dGUgcmVxdWVzdCBleGVjdXRpb24gYXQgYmRydl9jb193cml0ZV9yZXFfcHJlcGFyZSB3aGVuDQo+
Pj4+Pj4+IHJlc3VtaW5nIHRoZSBwb3N0cG9uZWQgY29yb3V0aW5lcy4NCj4+Pj4+Pj4NCj4+Pj4+
Pj4gVGhlIHRoaW5nIGlzIHRoYXQgdGhlIGJzIGlzIHByb3RlY3RlZCBmb3Igd3JpdGluZyBiZWZv
cmUgZXhlY3V0aW9uIG9mDQo+Pj4+Pj4+IGJkcnZfcmVwbGFjZV9ub2RlIGF0IG1pcnJvcl9leGl0
X2NvbW1vbiBhbmQgYmRydl9yZXBsYWNlX25vZGUgY2FsbHMNCj4+Pj4+Pj4gYmRydl9yZXBsYWNl
X2NoaWxkX25vcGVybSB3aGljaCwgaW4gdHVybiwgY2FsbHMgY2hpbGQtPnJvbGUtPmRyYWluZWRf
ZW5kDQo+Pj4+Pj4+IHdoZXJlIG9uZSBvZiB0aGUgY2FsbGJhY2tzIGlzIGJsa19yb290X2RyYWlu
ZWRfZW5kIHdoaWNoIGNoZWNrDQo+Pj4+Pj4+IGlmKC0tYmxrLT5xdWllc2NlX2NvdW50ZXIgPT0g
MCkgYW5kIHJ1bnMgdGhlIHBvc3Rwb25lZCByZXF1ZXN0cw0KPj4+Pj4+PiAoY29yb3V0aW5lcykg
aWYgdGhlIGNvdW5kaXRpb24gaXMgdHJ1ZS4NCj4+Pj4+Pg0KPj4+Pj4+IEhtLCBzbyBzb21ldGhp
bmcgaXMgbWVzc2VkIHVwIHdpdGggdGhlIGRyYWluIHNlY3Rpb25zIGluIHRoZSBtaXJyb3INCj4+
Pj4+PiBkcml2ZXIuIFdlIGhhdmU6DQo+Pj4+Pj4NCj4+Pj4+PiAgICAgICAgYmRydl9kcmFpbmVk
X2JlZ2luKHRhcmdldF9icyk7DQo+Pj4+Pj4gICAgICAgIGJkcnZfcmVwbGFjZV9ub2RlKHRvX3Jl
cGxhY2UsIHRhcmdldF9icywgJmxvY2FsX2Vycik7DQo+Pj4+Pj4gICAgICAgIGJkcnZfZHJhaW5l
ZF9lbmQodGFyZ2V0X2JzKTsNCj4+Pj4+Pg0KPj4+Pj4+IE9idmlvdXNseSwgdGhlIGludGVudGlv
biB3YXMgdG8ga2VlcCB0aGUgQmxvY2tCYWNrZW5kIGRyYWluZWQgZHVyaW5nDQo+Pj4+Pj4gYmRy
dl9yZXBsYWNlX25vZGUoKS4gU28gaG93IGNvdWxkIGJsay0+cXVpZXNjZV9jb3VudGVyIGV2ZXIg
Z2V0IHRvIDANCj4+Pj4+PiBpbnNpZGUgYmRydl9yZXBsYWNlX25vZGUoKSB3aGVuIHRhcmdldF9i
cyBpcyBkcmFpbmVkPw0KPj4+Pj4+DQo+Pj4+Pj4gTG9va2luZyBhdCBiZHJ2X3JlcGxhY2VfY2hp
bGRfbm9wZXJtKCksIGl0IHNlZW1zIHRoYXQgdGhlIGZ1bmN0aW9uIGhhcw0KPj4+Pj4+IGEgYnVn
OiBFdmVuIGlmIG9sZF9icyBhbmQgbmV3X2JzIGFyZSBib3RoIGRyYWluZWQsIHRoZSBxdWllc2Nl
X2NvdW50ZXINCj4+Pj4+PiBmb3IgdGhlIHBhcmVudCByZWFjaGVzIDAgZm9yIGEgbW9tZW50IGJl
Y2F1c2Ugd2UgY2FsbCAuZHJhaW5lZF9lbmQgZm9yDQo+Pj4+Pj4gdGhlIG9sZCBjaGlsZCBmaXJz
dCBhbmQgLmRyYWluZWRfYmVnaW4gZm9yIHRoZSBuZXcgb25lIGxhdGVyLg0KPj4+Pj4+DQo+Pj4+
Pj4gU28gaXQgc2VlbXMgdGhlIGZpeCB3b3VsZCBiZSB0byByZXZlcnNlIHRoZSBvcmRlciBhbmQg
Zmlyc3QgY2FsbA0KPj4+Pj4+IC5kcmFpbmVkX2JlZ2luIGZvciB0aGUgbmV3IGNoaWxkIGFuZCB0
aGVuIC5kcmFpbmVkX2VuZCBmb3IgdGhlIG9sZA0KPj4+Pj4+IGNoaWxkLiBTb3VuZHMgbGlrZSBh
IGdvb2QgbmV3IHRlc3RjYXNlIGZvciB0ZXN0cy90ZXN0LWJkcnYtZHJhaW4uYywgdG9vLg0KPj4+
Pj4gWWVzLCBpdCdzIHRydWUsIGJ1dCBpdCdzIG5vdCBlbm91Z2guLi4NCj4+Pj4NCj4+Pj4gRGlk
IHlvdSBldmVyIGltcGxlbWVudCB0aGUgY2hhbmdlcyBzdWdnZXN0ZWQgc28gZmFyLCBzbyB0aGF0
IHdlIGNvdWxkDQo+Pj4+IGNvbnRpbnVlIGZyb20gdGhlcmU/IE9yIHNob3VsZCBJIHRyeSBhbmQg
Y29tZSB1cCB3aXRoIHNvbWV0aGluZyBteXNlbGY/DQo+Pj4NCj4+PiBTb3JyeSBmb3IgdGhlIGxh
dGUgcmVwbHkuLi4NCj4+PiBZZXMsIEkgZGlkIC4uLg0KPj4NCj4+IElmIHRoZXJlIGFyZSBtb3Jl
IHF1ZXN0aW9uIG9yIHByb2JsZW1zLCBjYW4geW91IHBvc3QgdGhlIHBhdGNoZXMgaW4NCj4+IHRo
ZWlyIGN1cnJlbnQgc2hhcGUgKGFzIGFuIFJGQykgb3IgYSBnaXQgVVJMIHNvIEkgY2FuIHBsYXkg
d2l0aCBpdCBhDQo+PiBiaXQ/IElmIHlvdSBjb3VsZCBpbmNsdWRlIGEgZmFpbGluZyB0ZXN0IGNh
c2UsIHRvbywgdGhhdCB3b3VsZCBiZSBpZGVhbC4NCj4gDQo+IERlbmlzPyBQbGVhc2U/DQo+IA0K
PiBXZSByZWFsbHkgc2hvdWxkIGdldCB0aGlzIGZpeGVkIGFuZCBJIHdvdWxkIGJlIHdpbGxpbmcg
dG8gbGVuZCBhIGhhbmQsDQo+IGJ1dCBpZiB5b3Uga2VlcCB5b3VyIHBhdGNoZXMgc2VjcmV0LCBJ
IGNhbid0IHJlYWxseSBkbyBzbyBhbmQgd291bGQgaGF2ZQ0KPiB0byBkdXBsaWNhdGUgeW91ciB3
b3JrLg0KPiANCj4gQWxzbywgcGxlYXNlIHNlZSBteSBvbGQgYW5zd2VyIGZyb20gQXByaWwgYmVs
b3cgZm9yIHRoZSBsYXN0IHByb2JsZW0geW91DQo+IGhhZCB3aXRoIGltcGxlbWVudGluZyB0aGUg
Y29ycmVjdCBhcHByb2FjaC4NCj4gDQo+IEtldmluDQoNCkhlIGlzIG5vdCBhdCB3b3JrIHRvZGF5
LCBJIHRoaW5rIGhlJ2xsIGJlIGFibGUgdG8gYW5zd2VyIG9uIE1vbmRheS4NCg0KDQotLSANCkJl
c3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

