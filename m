Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4ECC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0888A214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GnGaCxC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0888A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCgFf-00055a-5y
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 04:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCgEE-0004N1-8d
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCgEC-0000QQ-Em
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 04:31:21 -0400
Received: from mail-ve1eur03on0700.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::700]:20411
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCgEB-0000Ot-Nf; Tue, 24 Sep 2019 04:31:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crMGGNaOhtekb46Pq+kNFuaJX9qU1HA8HtLpktR2DOvgomPtlfxAkumzzwqrwvMRmj95D/l/tFiZ8Mf9ZymTFBn1aAqntK0KlRs+fKnmqiQ9t7BVJFo1WqHa8HFGEgX0rf3fVFZqXJqarDB7YSWkZK7SY50OmumluzVcMhZrbA7SH2F94nu8sG8CbgYGfiqc6fwyQB95kfoapEWBwcb+NZ4JcpLZuLNYgGEzFIWTn2+pqZxQDbmqAw3xOuK+CCIjiHzJeXou3/ozP1auPjMOQHw1IfvMovm5jS2rsaq5qPvw2mjp6hEa7+GQF2gm3EL97iIOYoEVcfNgrotGONOCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ibytec5B8mVwTHZ/ZrfCRvvwYOVVOAF+7YcEtwbMeo=;
 b=oIQv95ZXqfk4lOZEgNNW4LyEZv+LBR7epaPHMIaZOSjq7O75R0z8loUkiecZrUXmNKVK012Vqj413+tbzwunPOtwpGqKBlhXuitRaKBCfTST5AI2qtjUJW2FJZZVTbEXQU5JoF3DkbtX5XD74C4tCVNm5Gn9El5Xf9Lk9tnbXP8FJnPu75opZG2aQhzvMkxeaGR959/Gp1g6Vgq0VcHom5WIqDwORSrvSq7lAvWHgAalnVg++bmFmOVNmYdfxdDQvgjxtwC3URU7EFEWy2erF4pEnCIVAmM6UU5QuWThUVeLYndOOGVPPtNeU2u9ZaV/JtUAeRkF32l39Xn629Mksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ibytec5B8mVwTHZ/ZrfCRvvwYOVVOAF+7YcEtwbMeo=;
 b=GnGaCxC1sv5RbzN7A/GIif0RAvIJHJN1o3tVUpROqGc7A94v7MeMbHqKTp5amiGWnorz6BvJDhNitI+Iw6jeoHbAzhC21e525IvcMd9ialPgx38BdTkqdDcKBUBfno7ZXHtkEYv9y8f5upNxYQc4t3aegYFvOGEyt/ttme+n60I=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4027.eurprd08.prod.outlook.com (20.179.9.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 08:31:16 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 08:31:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v9 3/3] iotests: test nbd reconnect
Thread-Topic: [PATCH v9 3/3] iotests: test nbd reconnect
Thread-Index: AQHVbXs7mHyYLS78iEaXGwF4PWg406c5ta+AgADUM4A=
Date: Tue, 24 Sep 2019 08:31:15 +0000
Message-ID: <88a7e9c9-caf2-b114-93c4-7c99036c9b33@virtuozzo.com>
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
 <20190917171322.4127-4-vsementsov@virtuozzo.com>
 <7f0a7890-7b3d-9fd7-954d-389a8e28106f@redhat.com>
In-Reply-To: <7f0a7890-7b3d-9fd7-954d-389a8e28106f@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::26) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190924113112983
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b4c752c-5173-481a-62a3-08d740c990be
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4027; 
x-ms-traffictypediagnostic: DB8PR08MB4027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB40273EA0AC730C0A368AD488C1840@DB8PR08MB4027.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(396003)(346002)(366004)(376002)(124014002)(199004)(189003)(6506007)(7736002)(53546011)(14454004)(6486002)(66476007)(102836004)(386003)(86362001)(31696002)(99286004)(5660300002)(486006)(8676002)(11346002)(305945005)(2906002)(6246003)(4326008)(107886003)(31686004)(186003)(54906003)(66066001)(81166006)(2616005)(476003)(110136005)(256004)(81156014)(316002)(6436002)(6512007)(8936002)(66446008)(71200400001)(3846002)(26005)(478600001)(52116002)(66946007)(76176011)(36756003)(71190400001)(6116002)(229853002)(2501003)(66556008)(446003)(64756008)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4027;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /aXvfRuOGjAd03PIsX8pa9AaveTOTKgIp/Zt1Th+5t77PCINkx0gIRDzR2qu4vA2AllCoujlTzbiX5a1ZWG0JRi5H+eCXoMUbVhkc1DVLkDOKZyganAAxt1Rn68th/o0V6Ue5uV/IwpQCMUUVMMFJqRR6e2htjgwPZn+9loaFwYRyEgU8u82mr42sWeO+GJThxAmua3oBaJRbuWcjW0aO9V1Qo0aikbnkPFIpUmKxl4Y7Eul0XBy681bsJ2ML0kuD7tkweNFFgzEx949Ms76Q/UNcrvTa6N5bvdcKcdTkTYuBdwvC6I0L5tnGl/yQEsdGnOVirMZzGXTLGZZuKBO2lbu1aYXKcXRxqPqpgE7sP2rfTM9sal0UctjsZYGMXsqMQ936I0kpTAuvfsrwkwRo9faJrh/J3EP0RQfOWVZIic=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E491EF07296CC4DA6EC31E7F093B229@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4c752c-5173-481a-62a3-08d740c990be
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 08:31:15.9176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDj47IEbjDgUYBYe9po2+WcvGyCcDNiZQz1/H+pxVSckhCgjYviNRMK0lJ8wZq0I+XY8iYFWsNQ2GElg/at1qXpLIajC1lXqQmF7Bkjd4EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4027
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::700
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjMuMDkuMjAxOSAyMjo1MSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOS8xNy8xOSAxMjoxMyBQ
TSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEFkZCB0ZXN0LCB3aGlj
aCBzdGFydHMgYmFja3VwIHRvIG5iZCB0YXJnZXQgYW5kIHJlc3RhcnRzIG5iZCBzZXJ2ZXINCj4+
IGR1cmluZyBiYWNrdXAuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIHRlc3Rz
L3FlbXUtaW90ZXN0cy8yNjQgICAgICAgIHwgNjUgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2NC5vdXQgICAgfCAxMiArKysrKysr
DQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgICAgIHwgIDEgKw0KPj4gICB0ZXN0cy9x
ZW11LWlvdGVzdHMvaW90ZXN0cy5weSB8ICA0ICsrKw0KPj4gICA0IGZpbGVzIGNoYW5nZWQsIDgy
IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL3FlbXUtaW90ZXN0
cy8yNjQNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjQub3V0
DQo+Pg0KPiANCj4+ICtpbXBvcnQgdGltZQ0KPj4gKw0KPj4gK2ltcG9ydCBpb3Rlc3RzDQo+PiAr
ZnJvbSBpb3Rlc3RzIGltcG9ydCBxZW11X2ltZ19jcmVhdGUsIGZpbGVfcGF0aCwgcWVtdV9uYmRf
cG9wZW4sIGxvZw0KPj4gKw0KPj4gK2Rpc2tfYSwgZGlza19iLCBuYmRfc29jayA9IGZpbGVfcGF0
aCgnZGlza19hJywgJ2Rpc2tfYicsICduYmQtc29jaycpDQo+PiArDQo+PiArcWVtdV9pbWdfY3Jl
YXRlKCctZicsIGlvdGVzdHMuaW1nZm10LCBkaXNrX2EsICc1TScpDQo+PiArcWVtdV9pbWdfY3Jl
YXRlKCctZicsIGlvdGVzdHMuaW1nZm10LCBkaXNrX2IsICc1TScpDQo+PiArc3J2ID0gcWVtdV9u
YmRfcG9wZW4oJy1rJywgbmJkX3NvY2ssICctZicsIGlvdGVzdHMuaW1nZm10LCBkaXNrX2IpDQo+
PiArdGltZS5zbGVlcCgxKQ0KPj4gKw0KPiANCj4gSGFyZC1jb2RlZCBzbGVlcCB0aW1lcyBjYW4g
YmUgcHJvYmxlbWF0aWMgKHRvbyBsb25nLCBhbmQgdGhlIHRlc3QgaXMgbm8NCj4gbG9uZ2VyIHF1
aWNrOyB0b28gc2hvcnQsIGFuZCBoZWF2eSBsb2FkIGNhbiBpbnRlcmZlcmUpOyBpcyB0aGVyZSBh
bnkgd2F5DQo+IHRvIHBvbGwgZm9yIGEgY29tcGxldGlvbiBldmVudCByYXRoZXIgdGhhbiBqdXN0
IHdhaXRpbmcgb25lIHNlY29uZD8NCg0KSG1tLCBJIHRoaW5rIHFlbXUtbmJkIGRvbid0IHNlbmQg
ZXZlbnRzLi4gSGVyZSBJIGp1c3Qgd2FudCB0byBnaXZlIGl0IGEgdGltZQ0KdG8gc3RhcnQuIFBv
c3NpYmx5IHdlIGNhbiBlbmFibGUgdHJhY2luZyBhbmQgd2FpdCBmb3Igc29tZSB0cmFjZS1wb2lu
dCwgYnV0IEknbQ0Kbm90IHN1cmUgdGhhdCB0aGlzIGlzIGdvb2QgaWRlYS4gQW5kIHNsZWVwIGlz
IHNpbXBsZXIuDQoNCj4gDQo+PiArdm0gPSBpb3Rlc3RzLlZNKCkuYWRkX2RyaXZlKGRpc2tfYSkN
Cj4+ICt2bS5sYXVuY2goKQ0KPj4gK3ZtLmhtcF9xZW11X2lvKCdkcml2ZTAnLCAnd3JpdGUgMCA1
TScpDQo+PiArDQo+PiArdm0ucW1wX2xvZygnYmxvY2tkZXYtYWRkJywgZmlsdGVycz1baW90ZXN0
cy5maWx0ZXJfcW1wX3Rlc3RmaWxlc10sDQo+PiArICAgICAgICAgICAqKnsnbm9kZV9uYW1lJzog
J2JhY2t1cDAnLA0KPj4gKyAgICAgICAgICAgICAgJ2RyaXZlcic6ICdyYXcnLA0KPj4gKyAgICAg
ICAgICAgICAgJ2ZpbGUnOiB7J2RyaXZlcic6ICduYmQnLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgJ3NlcnZlcic6IHsndHlwZSc6ICd1bml4JywgJ3BhdGgnOiBuYmRfc29ja30sDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAncmVjb25uZWN0LWRlbGF5JzogMTB9fSkNCj4+ICt2bS5x
bXBfbG9nKCdibG9ja2Rldi1iYWNrdXAnLCBkZXZpY2U9J2RyaXZlMCcsIHN5bmM9J2Z1bGwnLCB0
YXJnZXQ9J2JhY2t1cDAnLA0KPj4gKyAgICAgICAgICAgc3BlZWQ9KDEgKiAxMDI0ICogMTAyNCkp
DQo+IA0KPiBUaHJvdHRsaW5nIHRvIG1ha2Ugc3VyZSB3ZSBhcmUgbGlrZWx5IHRvIHN0aWxsIGJl
IGdvaW5nIGFuZCB0aHVzIHRlc3QNCj4gdGhlIHJlY29ubmVjdCBsb2dpYy4NCj4gDQo+PiArDQo+
PiArdGltZS5zbGVlcCgxKQ0KPj4gK2xvZygnS2lsbCBOQkQgc2VydmVyJykNCj4+ICtzcnYua2ls
bCgpDQo+IA0KPiBBZ2FpbiwgdGhhdCBoYXJkLWNvZGVkIHNsZWVwIGxvb2tzIGEgYml0IHJpc2t5
Lg0KDQpIbW0sIHlvdSBhcmUgcmlnaHQgaXQncyBkZWZpbml0ZWx5IHJpc2t5Li4gSSBmb3JnZXQs
IHRoYXQgaW4gZG93bi1zdHJlYW0gdmlydHVvenpvDQpicmFuY2ggdGhpcyBwbGFjZSBpcyByZXdy
aXR0ZW4gdG8gYmUgc21hcnRlciwgSSdsbCByZXNlbmQgdXBkYXRlZCB0ZXN0LCByZXBseWluZw0K
dG8gdGhpcyB0aHJlYWQuDQoNCj4gDQo+PiArDQo+PiAram9icyA9IHZtLnFtcCgncXVlcnktYmxv
Y2stam9icycpWydyZXR1cm4nXQ0KPj4gK2lmIGpvYnMgYW5kIGpvYnNbMF1bJ29mZnNldCddIDwg
am9ic1swXVsnbGVuJ106DQo+PiArICAgIGxvZygnQmFja3VwIGpvYiBpcyBzdGlsbCBpbiBwcm9n
cmVzcycpDQo+PiArDQo+PiArdGltZS5zbGVlcCgxKQ0KPiANCj4gV2h5IGRvIHdlIG5lZWQgeWV0
IGFub3RoZXIgc2xlZXA/DQoNClRoZSBpZGVhIGlzIHRvIGVtdWxhdGUgdGhhdCBzZXJ2ZXIgaXMg
ZG93biBmb3Igc29tZSB0aW1lLiBJdCBtYXkgYmUgYmV0dGVyDQp0byBkaXNhYmxlIHRocm90dGxp
bmcgYmVmb3JlIHRoaXMgc2xlZXAsIHRvIGdpdmUgYmFja3VwIG1vcmUgY2hhbmNlIHRvIGNyZWF0
ZQ0KcmVxdWVzdHMgZHVyaW5nIHNlcnZlciBkb3duLXRpbWUuDQoNCj4gDQo+PiArDQo+PiArbG9n
KCdTdGFydCBOQkQgc2VydmVyJykNCj4+ICtzcnYgPSBxZW11X25iZF9wb3BlbignLWsnLCBuYmRf
c29jaywgJy1mJywgaW90ZXN0cy5pbWdmbXQsIGRpc2tfYikNCj4+ICsNCj4+ICt2bS5xbXBfbG9n
KCdibG9jay1qb2Itc2V0LXNwZWVkJywgZGV2aWNlPSdkcml2ZTAnLCBzcGVlZD0wKQ0KPiANCj4g
U28gaGVyZSwgeW91IHJlbGVhc2UgdGhlIHRocm90dGxlIHRvIGZpbmlzaCB0aGUgam9iLg0KPiAN
Cj4+ICtlID0gdm0uZXZlbnRfd2FpdCgnQkxPQ0tfSk9CX0NPTVBMRVRFRCcpDQo+PiArbG9nKCdC
YWNrdXAgY29tcGxldGVkOiB7fScuZm9ybWF0KGVbJ2RhdGEnXVsnb2Zmc2V0J10pKQ0KPj4gKw0K
Pj4gK3ZtLnFtcF9sb2coJ2Jsb2NrZGV2LWRlbCcsIG5vZGVfbmFtZT0nYmFja3VwMCcpDQo+PiAr
c3J2LmtpbGwoKQ0KPj4gK3ZtLnNodXRkb3duKCkNCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11
LWlvdGVzdHMvMjY0Lm91dCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNjQub3V0DQo+PiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMC4uNGEyZjRhYTUwOQ0KPj4gLS0tIC9k
ZXYvbnVsbA0KPj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI2NC5vdXQNCj4+IEBAIC0wLDAg
KzEsMTIgQEANCj4+ICt7ImV4ZWN1dGUiOiAiYmxvY2tkZXYtYWRkIiwgImFyZ3VtZW50cyI6IHsi
ZHJpdmVyIjogInJhdyIsICJmaWxlIjogeyJkcml2ZXIiOiAibmJkIiwgInJlY29ubmVjdC1kZWxh
eSI6IDEwLCAic2VydmVyIjogeyJwYXRoIjogIlRFU1RfRElSL1BJRC1uYmQtc29jayIsICJ0eXBl
IjogInVuaXgifX0sICJub2RlLW5hbWUiOiAiYmFja3VwMCJ9fQ0KPj4gK3sicmV0dXJuIjoge319
DQo+PiAreyJleGVjdXRlIjogImJsb2NrZGV2LWJhY2t1cCIsICJhcmd1bWVudHMiOiB7ImRldmlj
ZSI6ICJkcml2ZTAiLCAic3BlZWQiOiAxMDQ4NTc2LCAic3luYyI6ICJmdWxsIiwgInRhcmdldCI6
ICJiYWNrdXAwIn19DQo+PiAreyJyZXR1cm4iOiB7fX0NCj4+ICtLaWxsIE5CRCBzZXJ2ZXINCj4+
ICtCYWNrdXAgam9iIGlzIHN0aWxsIGluIHByb2dyZXNzDQo+PiArU3RhcnQgTkJEIHNlcnZlcg0K
Pj4gK3siZXhlY3V0ZSI6ICJibG9jay1qb2Itc2V0LXNwZWVkIiwgImFyZ3VtZW50cyI6IHsiZGV2
aWNlIjogImRyaXZlMCIsICJzcGVlZCI6IDB9fQ0KPj4gK3sicmV0dXJuIjoge319DQo+PiArQmFj
a3VwIGNvbXBsZXRlZDogNTI0Mjg4MA0KPj4gK3siZXhlY3V0ZSI6ICJibG9ja2Rldi1kZWwiLCAi
YXJndW1lbnRzIjogeyJub2RlLW5hbWUiOiAiYmFja3VwMCJ9fQ0KPj4gK3sicmV0dXJuIjoge319
DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwIGIvdGVzdHMvcWVtdS1p
b3Rlc3RzL2dyb3VwDQo+PiBpbmRleCA1ZDNkYTkzN2U0Li40ZjZkZDZmMTUzIDEwMDY0NA0KPj4g
LS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwDQo+PiArKysgYi90ZXN0cy9xZW11LWlvdGVz
dHMvZ3JvdXANCj4+IEBAIC0yNzUsNSArMjc1LDYgQEANCj4+ICAgMjU4IHJ3IHF1aWNrDQo+PiAg
IDI2MiBydyBxdWljayBtaWdyYXRpb24NCj4+ICAgMjYzIHJ3IHF1aWNrDQo+PiArMjY0IHJ3IHF1
aWNrDQo+IA0KPiBXaXRoIHRoYXQgbWFueSBoYXJkLWNvZGVkIHNsZWVwcywgaXMgaXQgc3RpbGwg
cXVpY2s/DQo+IA0KPiAvbWUgYXBwbGllcyB0aGUgcGF0Y2ggYW5kIHJ1bnMgaXQuLi4NCj4gDQo+
IDI2NCAgICAgIHBhc3MgICAgICAgWzE0OjQ5OjU1XSBbMTQ6NTA6MDFdICAgNnMNCj4gDQo+IHRo
YXQncyBib3JkZXJsaW5lIGVub3VnaCB0aGF0IEkgd291bGQgbm90IGNhbGwgaXQgcXVpY2suDQo+
IA0KPj4gICANCj4+ICtkZWYgcWVtdV9uYmRfcG9wZW4oKmFyZ3MpOg0KPj4gKyAgICAnJydSdW4g
cWVtdS1uYmQgaW4gZGFlbW9uIG1vZGUgYW5kIHJldHVybiB0aGUgcGFyZW50J3MgZXhpdCBjb2Rl
JycnDQo+PiArICAgIHJldHVybiBzdWJwcm9jZXNzLlBvcGVuKHFlbXVfbmJkX2FyZ3MgKyBbJy0t
cGVyc2lzdGVudCddICsgbGlzdChhcmdzKSkNCj4+ICsNCj4gDQo+IFNob3VsZCB5b3UgYWxzbyB1
c2UgYSBwaWQgZmlsZSBoZXJlLCBhbmQgd2FpdCBmb3IgdGhlIGV4aXN0ZW5jZSBvZiB0aGUNCj4g
cGlkIGZpbGUgYmVmb3JlIHJldHVybmluZyAocmF0aGVyIHRoYW4gaGFyZC1jb2Rpbmcgc2xlZXAo
MSkpPw0KDQpXaGF0IGRvIHlvdSBtZWFuIC8gaG93IHRvIGRvIGl0Pw0KDQpXZSB3YW50IHRvIHdh
aXQgdW50aWwgbGlzdGVuaW5nIHNvY2tldCBpcyBwcmVwYXJlZC4uDQoNCj4gDQo+PiAgIGRlZiBj
b21wYXJlX2ltYWdlcyhpbWcxLCBpbWcyLCBmbXQxPWltZ2ZtdCwgZm10Mj1pbWdmbXQpOg0KPj4g
ICAgICAgJycnUmV0dXJuIFRydWUgaWYgdHdvIGltYWdlIGZpbGVzIGFyZSBpZGVudGljYWwnJycN
Cj4+ICAgICAgIHJldHVybiBxZW11X2ltZygnY29tcGFyZScsICctZicsIGZtdDEsDQo+Pg0KPiAN
Cj4gQXQgYW55IHJhdGUsDQo+IA0KPiBUZXN0ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRo
YXQuY29tPg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

