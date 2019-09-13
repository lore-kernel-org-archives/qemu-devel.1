Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F800C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8F9206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LEJP7jJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8F9206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mSn-0006c3-54
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8mRj-0005wA-WB
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8mRi-0007L2-Sn
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:21:11 -0400
Received: from mail-eopbgr70091.outbound.protection.outlook.com
 ([40.107.7.91]:50567 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8mRd-0007Hl-Dw; Fri, 13 Sep 2019 10:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnruQLG9HK7tQ56+PlSb3pr/38T6L6ahjNxjCWdILwIWFCdP5YmjskbAnIxx5Klm4Jh3IVRJHm1ZP1mwiIiLaRVLOh7QEy+337UnwF3l7ygykLtdl+KzkTa36xZocRn1AmkJRRKpK+AcIB92gfKmsuWCvqHwEQvy+ROc1jePcwTP/v/TVqgwvQFRLfsc7PGjetGeS+LBRk/ip1FJbTcfJYCAfN4MRWUtWdMerAxX2lUm6GtfcELXg0QOVqyV1DN7X55ztRR8Ygs3Yg8Q8dTNdYIEdDBsL+UDOT5b+CXvw6oDXwOclWlWVLClrPhly3xmpOFYW9RIms9Pg1IS7bFFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAhuLd+Wirr3LbCLsEbcpQ2LeG/HbUk+LG4Il45uqxc=;
 b=gzCp8Dvpc/WJEARYeOTVKtPFJvZFEEv1CoGHyyv7XnLr9gHkDedAeCsrP+9vZ/26qI7+VY1D6MVZy4SI8pEnd6xxOHVNVtBkTeOTKYsuAP2pmNHBbugjU2y5c8YByT7ktaiYawAkEOg8E02n8Y5x+LkhnJp+lxfzrAyfLQagZCgGKbNwrM9H3lR4FBirrenVni5elsTQHWK9uB/w+aMus1mUlu3GrISvqK2fsckP3VMYQ5MaRR0Xcpn8Pr1hxtNvQAlZBQ8WmFeCWmN+9zNTDGyIcA5lIpgfe12a/JoMIHGb9WqzIsR2t90amTW9EyAwYUcBUj651YV0vgoIbQ/tUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAhuLd+Wirr3LbCLsEbcpQ2LeG/HbUk+LG4Il45uqxc=;
 b=LEJP7jJCrvGzKEvkZFNKtZgJl+iW6Zpp6fJKniS54WEPblDa1vc6/QrIG1712vnc4VPf95VmrfEoZHunHeBRKZ0zRgmnGG8vmpr6NP9EXVXw0B1hsiZ+nRd3JhDoC5Rs8d9LIUqHvdZTbtIPJy2dLMyjJvHbkszDyIcOeZXjD88=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4011.eurprd08.prod.outlook.com (20.179.8.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Fri, 13 Sep 2019 14:21:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2263.016; Fri, 13 Sep 2019
 14:21:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v4 1/3] block/qcow2: refactoring of threaded
 encryption code
Thread-Index: AQHVajMOj6Verwh1NkqU8HmUL2OtZKcpoxmAgAAByACAAAOlAA==
Date: Fri, 13 Sep 2019 14:21:00 +0000
Message-ID: <c35ee603-c56b-2683-275a-f2e0949fd191@virtuozzo.com>
References: <20190913125909.15348-1-mlevitsk@redhat.com>
 <20190913125909.15348-2-mlevitsk@redhat.com>
 <5d578974-d02d-8b05-8d51-85715d1d4468@virtuozzo.com>
 <5fdc4891c02c7977762bb76fd877e4383e04be0c.camel@redhat.com>
In-Reply-To: <5fdc4891c02c7977762bb76fd877e4383e04be0c.camel@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0005.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190913172058125
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa86284a-a8b3-4823-f7fc-08d7385599e9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4011; 
x-ms-traffictypediagnostic: DB8PR08MB4011:
x-microsoft-antispam-prvs: <DB8PR08MB4011B79CB5C243CFB7B4D6DBC1B30@DB8PR08MB4011.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39850400004)(346002)(376002)(136003)(189003)(199004)(66556008)(66476007)(64756008)(14454004)(386003)(6246003)(66946007)(6506007)(26005)(476003)(99286004)(66446008)(66066001)(76176011)(256004)(110136005)(54906003)(316002)(2616005)(446003)(11346002)(102836004)(71190400001)(5660300002)(36756003)(305945005)(486006)(2501003)(31686004)(52116002)(71200400001)(186003)(7736002)(8676002)(3846002)(6116002)(6486002)(81156014)(81166006)(2906002)(229853002)(53936002)(6512007)(478600001)(31696002)(4326008)(8936002)(6436002)(25786009)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4011;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: f3S68Ww3c1BI/8on3f5gc/m1vF59o7A3/H3h+7fZpGC063lSFX7dSY+l3cN9tW2JdKMzzDlpAiW9tZNluMRuVlFA7VTr0Ua1zgUKO6ux5vkB47OwspcV3POh44RNqSniuPdxRtQcm459bHVx2KKIAKTT6f1fxhRZw2rR1Z2hKbwsOYBVqLTDQnAUa87pLMyIsFlcszIPBzIuzlV2yXpH0HeJkD00z+xYVGZlLqAD2cTC+RmLyVgQWDjpNOslC03lF9/JcxDifwOP3dGC+4ndbmWthUMMUwbT6uNHeT/xYe/TS1mfgyopRwMQSdcjTtGHjopJMgh/WJ2mroqqJavDOzUemBsIjhUNyeqDlMj06rVy4p2QQGkqX1QC6PvVSBpvbHcHfTV7W+DIy1Ze+/poEICrTl2VMfVchFG0Hv9abQE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A601503B6EF6F4D8048302381898DDF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa86284a-a8b3-4823-f7fc-08d7385599e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 14:21:00.3238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LP0xGUMHEvCd/ztSesqMJqd656MnN1uMi4sMecY8bNIkpK9ljiMS28FG5GT+m3dv6vdZV0gqEqcjwmLkPLnKr/EqIJsNJ3qxoAQFM0PO6Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4011
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.91
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block/qcow2: refactoring of
 threaded encryption code
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDkuMjAxOSAxNzowNywgTWF4aW0gTGV2aXRza3kgd3JvdGU6DQo+IE9uIEZyaSwgMjAxOS0w
OS0xMyBhdCAxNDowMSArMDAwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToN
Cj4+IDEzLjA5LjIwMTkgMTU6NTksIE1heGltIExldml0c2t5IHdyb3RlOg0KPj4+IFRoaXMgY29t
bWl0IHRyaWVzIHRvIGNsYXJpZnkgZmV3IGZ1bmN0aW9uIGFyZ3VtZW50cywNCj4+PiBhbmQgYWRk
IGNvbW1lbnRzIGRlc2NyaWJpbmcgdGhlIGVuY3J5cHQvZGVjcnlwdCBpbnRlcmZhY2UNCj4+Pg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IE1heGltIExldml0c2t5IDxtbGV2aXRza0ByZWRoYXQuY29tPg0K
Pj4+IC0tLQ0KPj4+ICAgIGJsb2NrL3Fjb3cyLWNsdXN0ZXIuYyB8ICA5ICsrKystLS0NCj4+PiAg
ICBibG9jay9xY293Mi10aHJlYWRzLmMgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tDQo+Pj4gICAgYmxvY2svcWNvdzIuYyAgICAgICAgIHwgIDUgKystLQ0K
Pj4+ICAgIGJsb2NrL3Fjb3cyLmggICAgICAgICB8ICA4ICsrKy0tLQ0KPj4+ICAgIDQgZmlsZXMg
Y2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvYmxvY2svcWNvdzItY2x1c3Rlci5jIGIvYmxvY2svcWNvdzItY2x1c3Rlci5jDQo+
Pj4gaW5kZXggZjA5Y2M5OTJhZi4uNDZiMDg1NGQ3ZSAxMDA2NDQNCj4+PiAtLS0gYS9ibG9jay9x
Y293Mi1jbHVzdGVyLmMNCj4+PiArKysgYi9ibG9jay9xY293Mi1jbHVzdGVyLmMNCj4+PiBAQCAt
NDYzLDggKzQ2Myw4IEBAIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIGRvX3BlcmZvcm1fY293X3Jl
YWQoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+Pj4gICAgfQ0KPj4+ICAgIA0KPj4+ICAgIHN0YXRp
YyBib29sIGNvcm91dGluZV9mbiBkb19wZXJmb3JtX2Nvd19lbmNyeXB0KEJsb2NrRHJpdmVyU3Rh
dGUgKmJzLA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50NjRfdCBzcmNfY2x1c3Rlcl9vZmZzZXQsDQo+Pj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IGNsdXN0ZXJfb2Zmc2V0LA0K
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCBndWVzdF9jbHVzdGVyX29mZnNldCwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgaG9zdF9jbHVzdGVyX29mZnNldCwNCj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNp
Z25lZCBvZmZzZXRfaW5fY2x1c3RlciwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1aW50OF90ICpidWZmZXIsDQo+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgYnl0ZXMpDQo+
Pj4gQEAgLTQ3NCw4ICs0NzQsOSBAQCBzdGF0aWMgYm9vbCBjb3JvdXRpbmVfZm4gZG9fcGVyZm9y
bV9jb3dfZW5jcnlwdChCbG9ja0RyaXZlclN0YXRlICpicywNCj4+PiAgICAgICAgICAgIGFzc2Vy
dCgob2Zmc2V0X2luX2NsdXN0ZXIgJiB+QkRSVl9TRUNUT1JfTUFTSykgPT0gMCk7DQo+Pj4gICAg
ICAgICAgICBhc3NlcnQoKGJ5dGVzICYgfkJEUlZfU0VDVE9SX01BU0spID09IDApOw0KPj4+ICAg
ICAgICAgICAgYXNzZXJ0KHMtPmNyeXB0byk7DQo+Pj4gLSAgICAgICAgaWYgKHFjb3cyX2NvX2Vu
Y3J5cHQoYnMsIGNsdXN0ZXJfb2Zmc2V0LA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNyY19jbHVzdGVyX29mZnNldCArIG9mZnNldF9pbl9jbHVzdGVyLA0KPj4+ICsgICAgICAg
IGlmIChxY293Ml9jb19lbmNyeXB0KGJzLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGhvc3RfY2x1c3Rlcl9vZmZzZXQgKyBvZmZzZXRfaW5fY2x1c3RlciwNCj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBndWVzdF9jbHVzdGVyX29mZnNldCArIG9mZnNldF9pbl9j
bHVzdGVyLA0KPj4NCj4+IG9vcHMsIHNlZW1zIHlvdSBhY2NpZGVudGFsbHkgZml4ZWQgdGhlIGJ1
Zywgd2hpY2ggeW91IGFyZSBnb2luZyB0byBmaXggaW4gdGhlIG5leHQNCj4+IHBhdGNoLCBhcyBu
b3cgY29ycmVjdCBvZmZzZXRzIGFyZSBnaXZlbiB0byBxY293Ml9jb19lbmNyeXB0IDopDQo+Pg0K
Pj4gYW5kIG5leHQgcGF0Y2ggbm8gaXMgYSBzaW1wbGUgbm8tbG9naWMtY2hhbmdlIHJlZmFjdG9y
aW5nLCBzbyBhdCBsZWFzdCBjb21taXQgbWVzc2FnZQ0KPj4gc2hvdWxkIGJlIGNoYW5nZWQuDQo+
IA0KPiBZZXAgOi0oIEkgYW0gdHJ5aW5nIG15IGJlc3QgaW4gYWRkaXRpb24gdG8gZml4aW5nIHRo
ZSBidWcsIGFsc28gY2xhcmlmeSB0aGUgYXJlYSB0bw0KPiBhdm9pZCB0aGlzIGZyb20gaGFwcGVu
aW5nIGFnYWluLg0KDQpBbmQgdGhpcyBpcyByZWFsbHkgZ3JlYXQhIEknbSBzb3JyeSB0aGF0IEkn
dmUgYnJva2VuIHRoZXNlIHRoaW5ncywgd2UgYWN0dWFsbHkgZG9uJ3QNCnVzZSBlbmNyeXB0aW9u
IChkb24ndCBhc2sgbWUgd2h5IEkndmUgaW1wbGVtZW50ZWQgdGhyZWFkZWQgZW5jcnlwdGlvbiA6
KSwgc28sIEkgaG9wZQ0KeW91IGFyZSBub3Qgb25seSBkYW1hZ2VkIGJ5IG15IHBhdGNoZXMgYnV0
IGFsc28gaGF2ZSBzb21lIGJlbmVmaXQuDQoNCj4gDQo+IFdoYXQgZG8geW91IHRoaW5rIHRoYXQg
SSBmb2xkIHRoZXNlIHR3byBwYXRjaGVzIHRvZ2V0aGVyIGFmdGVyIGFsbD8NCg0KT0sgZm9yIG1l
IChidXQgSSdtIG5vdCBhIG1haW50YWluZXIpLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

