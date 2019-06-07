Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C0C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC205208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XokSPnys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC205208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZLGP-0004ol-Nv
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 16:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57312)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZJzo-0006fa-Q8
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hZJzm-0002MZ-KE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:53:48 -0400
Received: from mail-eopbgr130105.outbound.protection.outlook.com
 ([40.107.13.105]:18446 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hZJza-0001qm-LP; Fri, 07 Jun 2019 14:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnSxo+2/40QkxF2L0ofj6Q1BJsabCN8F8HPnqIjfY7w=;
 b=XokSPnysmf1XDrsPl9ND3i0HDAagVnOwgaMfcEAEjv2LUzQ6cexF+eNELKbGdL25lV2STnF+wJfbUpyKbmDkl4iD1I1SI9MEl5kNrqnhmBcbd9l8vicKuaGtYtZde0itxzpcYZ8MuKny/D0kE46uGtv6/+3pA0uaCAZE0F21P1Q=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
 AM0PR08MB3428.eurprd08.prod.outlook.com (20.177.109.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 18:53:29 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8]) by AM0PR08MB2961.eurprd08.prod.outlook.com
 ([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 18:53:29 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH] qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap
Thread-Index: AQHVHWGt3O1zHwGo8UiWi6cR5sNsBKaQidAA
Date: Fri, 7 Jun 2019 18:53:29 +0000
Message-ID: <f218e52c-8b0b-07cc-519f-23e9612b2320@virtuozzo.com>
References: <20190607184802.100945-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190607184802.100945-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0501CA0022.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::32) To AM0PR08MB2961.eurprd08.prod.outlook.com
 (2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190607215326798
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bdf32c4-0ed8-4dd7-fe50-08d6eb796e0b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3428; 
x-ms-traffictypediagnostic: AM0PR08MB3428:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR08MB3428784137D0E9A43AD002BFC1100@AM0PR08MB3428.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39850400004)(396003)(136003)(376002)(366004)(52314003)(189003)(199004)(6436002)(6506007)(73956011)(4326008)(66476007)(966005)(66946007)(31696002)(486006)(66446008)(64756008)(229853002)(2616005)(476003)(446003)(6116002)(11346002)(68736007)(14454004)(478600001)(25786009)(3846002)(386003)(76176011)(102836004)(2501003)(52116002)(186003)(81166006)(2906002)(81156014)(26005)(36756003)(8676002)(6486002)(305945005)(7736002)(66066001)(99286004)(5660300002)(6246003)(31686004)(66556008)(316002)(54906003)(110136005)(8936002)(6306002)(53936002)(256004)(6512007)(71200400001)(86362001)(71190400001)(14444005)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3428;
 H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FP8BvNBqJLZcAeezj7YxffEnpA4VW0qLuXJflaeAH2AV2VUWrGTMR4T8P3dIddCZsF0egocUVP5za0kp/SUP9PwdX7hpHXUDDpXBfZUDO8LCeIfgqa5nymPKCSzDfn5LL1U9ZywCcbnDqOTmsvfJyIi1OLDmFuU0Bi0CCqVxR8NiKb354bgjLxNUIb5lDE4RDQo+6XcaqJ0Au/+Zpuo7Tpupez0aYQCIFskq7FVEIQyJenSxVXi8T7f7a0aNJxNfXcAZ+iOwKWOfHFkHxjHDQUZjuJTXszV6UrAMz5cWu/F4YQMmAcwTXwpkVrmnijVuqZRtw1O8EOfmGBzqQhjF8j7L3Vqr98WUUxU4weAk86VMXhfXyNPpLa+6RXTYXD8eQ5YO+DT+kLfvhaZ5u3uaBxk3Np9Tv25iNLCZf23JDk4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E857C416C0319418357B7587756E37B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdf32c4-0ed8-4dd7-fe50-08d6eb796e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 18:53:29.2032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3428
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.105
Subject: Re: [Qemu-devel] [PATCH] qcow2-bitmaps: fix
 qcow2_can_store_new_dirty_bitmap
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDcuMDYuMjAxOSAyMTo0OCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
cWNvdzJfY2FuX3N0b3JlX25ld19kaXJ0eV9iaXRtYXAgd29ya3Mgd3JvbmcsIGFzIGl0IGNvbnNp
ZGVycyBvbmx5DQo+IGJpdG1hcHMgYWxyZWFkeSBzdG9yZWQgaW4gdGhlIHFjb3cyIGltYWdlIGFu
ZCBpZ25vcmVzIHBlcnNpc3RlbnQNCj4gQmRydkRpcnR5Qml0bWFwIG9iamVjdHMuDQo+IA0KPiBT
bywgbGV0J3MgaW5zdGVhZCBjb3VudCBwZXJzaXN0ZW50IEJkcnZEaXJ0eUJpdG1hcHMuIFdlIGxv
YWQgYWxsIHFjb3cyDQo+IGJpdG1hcHMgb24gb3Blbiwgc28gdGhlcmUgc2hvdWxkIG5vdCBiZSBh
bnkgYml0bWFwIGluIHRoZSBpbWFnZSBmb3INCj4gd2hpY2ggd2UgZG9uJ3QgaGF2ZSBCZHJ2RGly
dHlCaXRtYXBzIHZlcnNpb24uIElmIGl0IGlzIC0gaXQncyBhIGtpbmQgb2YNCj4gY29ycnVwdGlv
biwgYW5kIG5vIHJlYXNvbiB0byBjaGVjayBmb3IgY29ycnVwdGlvbnMgaGVyZSAob3BlbigpIGFu
ZA0KPiBjbG9zZSgpIGFyZSBiZXR0ZXIgcGxhY2VzIGZvciBpdCkuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5j
b20+DQo+IC0tLQ0KPiANCj4gSGkhDQo+IA0KPiBQYXRjaCBpcyBiZXR0ZXIgdGhhbiBkaXNjdXNz
aW5nIEkgdGhpbmcsIHNvIGhlcmUgaXMgbXkgY291bnRlci1zdWdnZXN0aW9uIGZvcg0KPiAiW1BB
VENIIDAvNV0gYmxvY2svZGlydHktYml0bWFwOiBjaGVjayBudW1iZXIgYW5kIHNpemUgY29uc3Ry
YWludHMgYWdhaW5zdCBxdWV1ZWQgYml0bWFwcyINCj4gYnkgSm9obi4NCj4gDQo+IEl0J3Mgb2Yg
Y291cnNlIG5lZWRzIHNvbWUgYWRkaXRpb25hbCByZWZhY3RvcmluZywgYXMgZmlyc3QgYXNzZXJ0
IHNob3dzIGJhZCBkZXNpZ24sDQo+IEkganVzdCB3cm90ZSBpdCBpbiBzdWNoIG1hbm5lciB0byBt
YWtlIG1pbmltdW0gY2hhbmdlcyB0byBmaXggdGhlIGJ1Zy4NCj4gDQo+IE9mIGNvdXJzZSwNCj4g
UmVwb3J0ZWQtYnk6IGFpaHVhIGxpYW5nIDxhbGlhbmdAcmVkaGF0LmNvbT4NCj4gbWF5IGJlIGFw
cGxpZWQgaGVyZSAoaWYgSSB1bmRlcnN0b29kIGNvcnJlY3RseSksIGFuZCBJIGhvcGUgdGhhdA0K
PiBGaXhlczogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNzEy
NjM2DQo+IHRvby4NCj4gDQo+ICAgYmxvY2svcWNvdzItYml0bWFwLmMgfCAzOCArKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9xY293
Mi1iaXRtYXAuYyBiL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+IGluZGV4IGIyNDg3MTAxZWQuLjdk
MWIzZWViMmIgMTAwNjQ0DQo+IC0tLSBhL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jDQo+ICsrKyBiL2Js
b2NrL3Fjb3cyLWJpdG1hcC5jDQo+IEBAIC0xNjE5LDggKzE2MTksMTEgQEAgYm9vbCBxY293Ml9j
YW5fc3RvcmVfbmV3X2RpcnR5X2JpdG1hcChCbG9ja0RyaXZlclN0YXRlICpicywNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4gICB7DQo+
ICAgICAgIEJEUlZRY293MlN0YXRlICpzID0gYnMtPm9wYXF1ZTsNCj4gLSAgICBib29sIGZvdW5k
Ow0KPiAtICAgIFFjb3cyQml0bWFwTGlzdCAqYm1fbGlzdDsNCj4gKyAgICBCZHJ2RGlydHlCaXRt
YXAgKmJpdG1hcDsNCj4gKyAgICB1aW50NjRfdCBiaXRtYXBfZGlyZWN0b3J5X3NpemUgPSAwOw0K
PiArICAgIHVpbnQzMl90IG5iX2JpdG1hcHMgPSAwOw0KPiArDQo+ICsgICAgYXNzZXJ0KCFiZHJ2
X2ZpbmRfZGlydHlfYml0bWFwKGJzLCBuYW1lKSk7DQoNCmV4YWN0bHkgYmFkLCB0aGlzIHNob3Vs
ZCBiZSBjaGVja2VkIGluIHFtcF9ibG9ja19kaXJ0eV9iaXRtYXBfYWRkKCksIGJlZm9yZSBjaGVj
a3MgYXJvdW5kDQpwZXJzaXN0ZW5jZS4gYW5kIGFpb19jb250ZXh0X2FjcXVpcmUgbWF5IGJlIGRy
b3BwZWQuLg0KDQpCdXQgYW55d2F5LCBpZGVhIGlzIGNsZWFyIEkgdGhpbmssIGNvbnNpZGVyIGl0
IGFzIFJGQyBwYXRjaA0KDQo+ICAgDQo+ICAgICAgIGlmIChzLT5xY293X3ZlcnNpb24gPCAzKSB7
DQo+ICAgICAgICAgICAvKiBXaXRob3V0IGF1dG9jbGVhcl9mZWF0dXJlcywgd2Ugd291bGQgYWx3
YXlzIGhhdmUgdG8gYXNzdW1lDQo+IEBAIC0xNjM2LDM2ICsxNjM5LDI5IEBAIGJvb2wgcWNvdzJf
Y2FuX3N0b3JlX25ld19kaXJ0eV9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+ICAgICAg
ICAgICBnb3RvIGZhaWw7DQo+ICAgICAgIH0NCj4gICANCj4gLSAgICBpZiAocy0+bmJfYml0bWFw
cyA9PSAwKSB7DQo+IC0gICAgICAgIHJldHVybiB0cnVlOw0KPiArICAgIGZvciAoYml0bWFwID0g
YmRydl9kaXJ0eV9iaXRtYXBfbmV4dChicywgTlVMTCk7IGJpdG1hcCAhPSBOVUxMOw0KPiArICAg
ICAgICAgYml0bWFwID0gYmRydl9kaXJ0eV9iaXRtYXBfbmV4dChicywgYml0bWFwKSkNCj4gKyAg
ICB7DQo+ICsgICAgICAgIGlmIChiZHJ2X2RpcnR5X2JpdG1hcF9nZXRfcGVyc2lzdGVuY2UoYml0
bWFwKSkgew0KPiArICAgICAgICAgICAgbmJfYml0bWFwcysrOw0KPiArICAgICAgICAgICAgYml0
bWFwX2RpcmVjdG9yeV9zaXplICs9DQo+ICsgICAgICAgICAgICAgICAgY2FsY19kaXJfZW50cnlf
c2l6ZShzdHJsZW4oYmRydl9kaXJ0eV9iaXRtYXBfbmFtZShiaXRtYXApKSwgMCk7DQo+ICsgICAg
ICAgIH0NCj4gICAgICAgfQ0KPiArICAgIG5iX2JpdG1hcHMrKzsNCj4gKyAgICBiaXRtYXBfZGly
ZWN0b3J5X3NpemUgKz0gY2FsY19kaXJfZW50cnlfc2l6ZShzdHJsZW4obmFtZSksIDApOw0KPiAg
IA0KPiAtICAgIGlmIChzLT5uYl9iaXRtYXBzID49IFFDT1cyX01BWF9CSVRNQVBTKSB7DQo+ICsg
ICAgaWYgKG5iX2JpdG1hcHMgPiBRQ09XMl9NQVhfQklUTUFQUykgew0KPiAgICAgICAgICAgZXJy
b3Jfc2V0ZyhlcnJwLA0KPiAgICAgICAgICAgICAgICAgICAgICAiTWF4aW11bSBudW1iZXIgb2Yg
cGVyc2lzdGVudCBiaXRtYXBzIGlzIGFscmVhZHkgcmVhY2hlZCIpOw0KPiAgICAgICAgICAgZ290
byBmYWlsOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgaWYgKHMtPmJpdG1hcF9kaXJlY3Rvcnlf
c2l6ZSArIGNhbGNfZGlyX2VudHJ5X3NpemUoc3RybGVuKG5hbWUpLCAwKSA+DQo+IC0gICAgICAg
IFFDT1cyX01BWF9CSVRNQVBfRElSRUNUT1JZX1NJWkUpDQo+IC0gICAgew0KPiArICAgIGlmIChi
aXRtYXBfZGlyZWN0b3J5X3NpemUgPiBRQ09XMl9NQVhfQklUTUFQX0RJUkVDVE9SWV9TSVpFKSB7
DQo+ICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJOb3QgZW5vdWdoIHNwYWNlIGluIHRoZSBi
aXRtYXAgZGlyZWN0b3J5Iik7DQo+ICAgICAgICAgICBnb3RvIGZhaWw7DQo+ICAgICAgIH0NCj4g
ICANCj4gLSAgICBibV9saXN0ID0gYml0bWFwX2xpc3RfbG9hZChicywgcy0+Yml0bWFwX2RpcmVj
dG9yeV9vZmZzZXQsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcy0+Yml0bWFw
X2RpcmVjdG9yeV9zaXplLCBlcnJwKTsNCj4gLSAgICBpZiAoYm1fbGlzdCA9PSBOVUxMKSB7DQo+
IC0gICAgICAgIGdvdG8gZmFpbDsNCj4gLSAgICB9DQo+IC0NCj4gLSAgICBmb3VuZCA9IGZpbmRf
Yml0bWFwX2J5X25hbWUoYm1fbGlzdCwgbmFtZSk7DQo+IC0gICAgYml0bWFwX2xpc3RfZnJlZShi
bV9saXN0KTsNCj4gLSAgICBpZiAoZm91bmQpIHsNCj4gLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiQml0bWFwIHdpdGggdGhlIHNhbWUgbmFtZSBpcyBhbHJlYWR5IHN0b3JlZCIpOw0KPiAtICAg
ICAgICBnb3RvIGZhaWw7DQo+IC0gICAgfQ0KPiAtDQo+ICAgICAgIHJldHVybiB0cnVlOw0KPiAg
IA0KPiAgIGZhaWw6DQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

