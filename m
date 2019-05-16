Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B531C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DC820815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S6yfOdOM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HoZPbVBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DC820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60270 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRImF-0000my-Ho
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 11:58:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=032022a23=Alistair.Francis@wdc.com>)
	id 1hRIkc-0008CO-9t
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=032022a23=Alistair.Francis@wdc.com>)
	id 1hRIkb-0002nR-4n
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:56:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=032022a23=Alistair.Francis@wdc.com>)
	id 1hRIkY-0002dq-EW; Thu, 16 May 2019 11:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558022274; x=1589558274;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=KOA4tjoqRTIgKGn5oG7v9P8fXDxDaHx6wcTpvA49qsI=;
	b=S6yfOdOMW2WDxDoI2nJyCyMa8io4kxiFErJuA0vlq221t13l6/CdnixB
	ZW14OnSYYSw9wHyW6LYrYpbKP41+sqIf5cbJGS0pBIh2JGxsbmuJb5GIB
	UUoo9n8zYrvijvlA0PJ2U6acDImn0wQlCof2UNP6HajSgI6cXgN6HAB8j
	bM1iXZmGYA8Bk942bHf9wRTIw3SF00V/NjjJtbERaFkAS6MGkI9JmxD47
	3/X/0Va1rFOXtK7pRm7dW9WgQzcyqbwjpk+ot5hzjyvWHzAenz0W5qlL1
	CEmhrIay3nR1YGx4vlGUND866NUYibuZtDKfB8Q88+CAHjDsleaGZRSk0 Q==;
X-IronPort-AV: E=Sophos;i="5.60,477,1549900800"; d="scan'208";a="207856561"
Received: from mail-dm3nam03lp2057.outbound.protection.outlook.com (HELO
	NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.57])
	by ob1.hgst.iphmx.com with ESMTP; 16 May 2019 23:57:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=KOA4tjoqRTIgKGn5oG7v9P8fXDxDaHx6wcTpvA49qsI=;
	b=HoZPbVBcW5ie6Sb149yPJjzpaJN+nyQ+3aCHaKV0P/Ulr6O6d9fsIm9UncUC7I/zN0I2leQiWvbyF/kJkkLxD3vu4SmM5YBG4D/GI+8MTatI/b/sInb71if1zC5vHLIsqX3ztHLDlJY/Amts4TWmXA4mDOtkKuyzyuHj0bv4MTQ=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5526.namprd04.prod.outlook.com (20.178.232.88) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.22; Thu, 16 May 2019 15:56:48 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::9583:df9e:7ef5:44b7]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::9583:df9e:7ef5:44b7%4]) with mapi id 15.20.1900.010;
	Thu, 16 May 2019 15:56:48 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "qemu-arm@nongnu.org"
	<qemu-arm@nongnu.org>
Thread-Topic: [Qemu-arm] [PATCH v2 1/1] target/arm: Fix vector operation
	segfault
Thread-Index: AQHVCrQmh+Ko5HkmvEGc3iReziFjO6ZtUxgAgACXboA=
Date: Thu, 16 May 2019 15:56:48 +0000
Message-ID: <8ae9064546d66de109115558a007cec3632b942a.camel@wdc.com>
References: <78cf484c4d991e899d0065b2dab3a2e204ce8723.1557879499.git.alistair.francis@wdc.com>
	<875zqanb2f.fsf@zen.linaroharston>
In-Reply-To: <875zqanb2f.fsf@zen.linaroharston>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-originating-ip: [2601:646:8e00:37b2:d3fd:11e9:7cc1:adaf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2be4d1a8-8bf2-4f85-f33e-08d6da171ae1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5526; 
x-ms-traffictypediagnostic: BYAPR04MB5526:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB55261F4B897DBEAAFF3145B2900A0@BYAPR04MB5526.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(366004)(136003)(39860400002)(376002)(346002)(199004)(189003)(6512007)(6436002)(102836004)(229853002)(110136005)(54906003)(2501003)(6486002)(6506007)(305945005)(476003)(99286004)(2616005)(7736002)(76176011)(11346002)(81156014)(8936002)(8676002)(118296001)(446003)(46003)(71190400001)(71200400001)(186003)(81166006)(6116002)(86362001)(2906002)(256004)(4326008)(316002)(478600001)(5660300002)(68736007)(72206003)(486006)(53936002)(6246003)(36756003)(66476007)(66556008)(64756008)(66446008)(14454004)(73956011)(76116006)(25786009)(66946007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5526;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TGl8QOKJjXhudyzJ1HvebpYB26xUEVB0ZLk2kjbo2ABv/7t95T91k7sfldrkVa0y+gtQ/DNTpjQjszLqK+FYyWeNUP9aP22LochFWhQL/70mANFdLGmeSYnb9LMzSDRyjlMFeHj430usfUH412wL2U1bZw/FMhINERcf5aakfA9++jZIG0/4gLGcbAPjN/ANCZPPyqXs6oiiGjKPFJ2P2//8ZvNslqVwsfl9+l9ZVlb3zbj+iFP/jbnPjfspBpl6k5B7acvuos6WcOTMXaWkkbfhMVGS2xUzH5MK0CpqNbV4PDOilQtdySlIaZulgKZ1Oj2F7A6Og8h0wrliHH66T3aLN/Ftvc0sL8GbhY17oeNBS0Mw/FDeACAVgGO4/h3AwtEGdiNOHNKoF0wa09z+D225lwNpAzHStj7IHG+U0SY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5211D7EA646092468D22AE790C759667@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be4d1a8-8bf2-4f85-f33e-08d6da171ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 15:56:48.7383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5526
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.143.124
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 1/1] target/arm: Fix vector
 operation segfault
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"richard.henderson@linaro.org" <richard.henderson@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDE5LTA1LTE2IGF0IDA3OjU0ICswMTAwLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+
IEFsaXN0YWlyIEZyYW5jaXMgPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT4gd3JpdGVzOg0KPiAN
Cj4gPiBDb21taXQgODllNjhiNTc1ICJ0YXJnZXQvYXJtOiBVc2UgdmVjdG9yIG9wZXJhdGlvbnMg
Zm9yIHNhdHVyYXRpb24iDQo+ID4gY2F1c2VzIHRoaXMgYWJvcnQoKSB3aGVuIGJvb3RpbmcgUUVN
VSBBUk0gd2l0aCBhIENvcnRleC1BMTU6DQo+ID4gDQo+ID4gMCAgMHgwMDAwN2ZmZmY0YzIzODJm
IGluIHJhaXNlICgpIGF0IC91c3IvbGliL2xpYmMuc28uNg0KPiA+IDEgIDB4MDAwMDdmZmZmNGMw
ZTY3MiBpbiBhYm9ydCAoKSBhdCAvdXNyL2xpYi9saWJjLnNvLjYNCj4gPiAyICAweDAwMDA1NTU1
NTU5YzE4MzkgaW4gZGlzYXNfbmVvbl9kYXRhX2luc24gKGluc249PG9wdGltaXplZA0KPiA+IG91
dD4sIHM9PG9wdGltaXplZCBvdXQ+KSBhdCAuL3RhcmdldC9hcm0vdHJhbnNsYXRlLmM6NjY3Mw0K
PiA+IDMgIDB4MDAwMDU1NTU1NTljMTgzOSBpbiBkaXNhc19uZW9uX2RhdGFfaW5zbiAocz08b3B0
aW1pemVkIG91dD4sDQo+ID4gaW5zbj08b3B0aW1pemVkIG91dD4pIGF0IC4vdGFyZ2V0L2FybS90
cmFuc2xhdGUuYzo2Mzg2DQo+ID4gNCAgMHgwMDAwNTU1NTU1OWNkOGE0IGluIGRpc2FzX2FybV9p
bnNuIChpbnNuPTQwODExMDcwNjgsDQo+ID4gcz0weDdmZmZlNTlhOTUxMCkgYXQgLi90YXJnZXQv
YXJtL3RyYW5zbGF0ZS5jOjkyODkNCj4gPiA1ICAweDAwMDA1NTU1NTU5Y2Q4YTQgaW4gYXJtX3Ry
X3RyYW5zbGF0ZV9pbnNuDQo+ID4gKGRjYmFzZT0weDdmZmZlNTlhOTUxMCwgY3B1PTxvcHRpbWl6
ZWQgb3V0PikgYXQNCj4gPiAuL3RhcmdldC9hcm0vdHJhbnNsYXRlLmM6MTM2MTINCj4gPiA2ICAw
eDAwMDA1NTU1NTU4ZDFkMzkgaW4gdHJhbnNsYXRvcl9sb29wIChvcHM9MHg1NTU1NTYxY2M1ODAN
Cj4gPiA8YXJtX3RyYW5zbGF0b3Jfb3BzPiwgZGI9MHg3ZmZmZTU5YTk1MTAsIGNwdT0weDU1NTU1
Njg2YTJmMCwNCj4gPiB0Yj08b3B0aW1pemVkIG91dD4sIG1heF9pbnNucz08b3B0aW1pemVkIG91
dD4pIGF0DQo+ID4gLi9hY2NlbC90Y2cvdHJhbnNsYXRvci5jOjk2DQo+ID4gNyAgMHgwMDAwNTU1
NTU1OWQxMGQ0IGluIGdlbl9pbnRlcm1lZGlhdGVfY29kZSAoY3B1PWNwdUBlbnRyeT0weDU1NQ0K
PiA+IDU1Njg2YTJmMCwgdGI9dGJAZW50cnk9MHg3ZmZmZDc4NDAwODAgPGNvZGVfZ2VuX2J1ZmZl
cisxMjYwOTEzNDc+LCANCj4gPiBtYXhfaW5zbnM9bWF4X2luc25zQGVudHJ5PTUxMikgYXQgLi90
YXJnZXQvYXJtL3RyYW5zbGF0ZS5jOjEzOTAxDQo+ID4gOCAgMHgwMDAwNTU1NTU1OGQwNmI5IGlu
IHRiX2dlbl9jb2RlIChjcHU9Y3B1QGVudHJ5PTB4NTU1NTU2ODZhMmYwLA0KPiA+IHBjPTMwNjcw
OTYyMTYsIGNzX2Jhc2U9MCwgZmxhZ3M9MTkyLCBjZmxhZ3M9LTE2MjUyOTI4LCBjZmxhZ3NAZW50
cnkNCj4gPiA9NTI0Mjg4KSBhdCAuL2FjY2VsL3RjZy90cmFuc2xhdGUtYWxsLmM6MTczNg0KPiA+
IDkgIDB4MDAwMDU1NTU1NThjZTQ2NyBpbiB0Yl9maW5kIChjZl9tYXNrPTUyNDI4OCwgdGJfZXhp
dD0xLA0KPiA+IGxhc3RfdGI9MHg3ZmZmZDc4M2U2NDAgPGNvZGVfZ2VuX2J1ZmZlcisxMjYwODQ2
Mjc+LCBjcHU9MHgxKSBhdA0KPiA+IC4vYWNjZWwvdGNnL2NwdS1leGVjLmM6NDA3DQo+ID4gMTAg
MHgwMDAwNTU1NTU1OGNlNDY3IGluIGNwdV9leGVjIChjcHU9Y3B1QGVudHJ5PTB4NTU1NTU2ODZh
MmYwKSBhdA0KPiA+IC4vYWNjZWwvdGNnL2NwdS1leGVjLmM6NzI4DQo+ID4gMTEgMHgwMDAwNTU1
NTU1ODhiMGNmIGluIHRjZ19jcHVfZXhlYyAoY3B1PTB4NTU1NTU2ODZhMmYwKSBhdA0KPiA+IC4v
Y3B1cy5jOjE0MzENCj4gPiAxMiAweDAwMDA1NTU1NTU4OGQyMjMgaW4gcWVtdV90Y2dfY3B1X3Ro
cmVhZF9mbg0KPiA+IChhcmc9MHg1NTU1NTY4NmEyZjApIGF0IC4vY3B1cy5jOjE3MzUNCj4gPiAx
MyAweDAwMDA1NTU1NTU4OGQyMjMgaW4gcWVtdV90Y2dfY3B1X3RocmVhZF9mbiAoYXJnPWFyZ0Bl
bnRyeT0weDU1DQo+ID4gNTU1Njg2YTJmMCkgYXQgLi9jcHVzLmM6MTcwOQ0KPiA+IDE0IDB4MDAw
MDU1NTU1NWQyNjI5YSBpbiBxZW11X3RocmVhZF9zdGFydCAoYXJncz08b3B0aW1pemVkIG91dD4p
DQo+ID4gYXQgLi91dGlsL3FlbXUtdGhyZWFkLXBvc2l4LmM6NTAyDQo+ID4gMTUgMHgwMDAwN2Zm
ZmY0ZGI4YTkyIGluIHN0YXJ0X3RocmVhZCAoKSBhdCAvdXNyL2xpYi9saWJwdGhyZWFkLg0KPiA+
IA0KPiA+IFRoaXMgcGF0Y2ggZW5zdXJlcyB0aGF0IHdlIGRvbid0IGhpdCB0aGUgYWJvcnQoKSBp
biB0aGUgc2Vjb25kDQo+ID4gc3dpdGNoDQo+ID4gY2FzZSBpbiBkaXNhc19uZW9uX2RhdGFfaW5z
bigpIGFzIHdlIHdpbGwgcmV0dXJuIGZyb20gdGhlIGZpcnN0DQo+ID4gY2FzZS4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5j
b20+DQo+IA0KPiBUaGlzIGZpeGVzIHRoZSBhYm9ydCgpJ3MgSSB3YXMgc2VlaW5nIHdoaWxlIHJ1
bm5pbmcgdGhlIHFlbXUtaW90ZXN0cw0KPiB1bmRlciBhbiBlbXVsYXRlZCBEZWJpYW4gQnVzdGVy
IGFybWhmIHN5c3RlbSBzbzoNCg0KR3JlYXQhIEkganVzdCBzZW5kIGEgdjMgd2hpY2ggc2hvdWxk
IGJlIHBsYWluIHRleHQuDQoNCkFsaXN0YWlyDQoNCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4IEJl
bm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IFRlc3RlZC1ieTogQWxleCBCZW5uw6ll
IDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiANCj4gDQo+ID4gLS0tDQo+ID4gIHRhcmdldC9h
cm0vdHJhbnNsYXRlLmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2FybS90
cmFuc2xhdGUuYyBiL3RhcmdldC9hcm0vdHJhbnNsYXRlLmMNCj4gPiBpbmRleCBkZDA1M2M4MGQ2
Li4yOThjMjYyODI1IDEwMDY0NA0KPiA+IC0tLSBhL3RhcmdldC9hcm0vdHJhbnNsYXRlLmMNCj4g
PiArKysgYi90YXJnZXQvYXJtL3RyYW5zbGF0ZS5jDQo+ID4gQEAgLTY1OTgsMTMgKzY1OTgsMTMg
QEAgc3RhdGljIGludA0KPiA+IGRpc2FzX25lb25fZGF0YV9pbnNuKERpc2FzQ29udGV4dCAqcywg
dWludDMyX3QgaW5zbikNCj4gPiAgICAgICAgICAgICAgdGNnX2dlbl9ndmVjXzQocmRfb2ZzLCBv
ZmZzZXRvZihDUFVBUk1TdGF0ZSwgdmZwLnFjKSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcm5fb2ZzLCBybV9vZnMsIHZlY19zaXplLCB2ZWNfc2l6ZSwNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKHUgPyB1cWFkZF9vcCA6IHNxYWRkX29wKSArIHNpemUpOw0KPiA+
IC0gICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gDQo+
ID4gICAgICAgICAgY2FzZSBORU9OXzNSX1ZRU1VCOg0KPiA+ICAgICAgICAgICAgICB0Y2dfZ2Vu
X2d2ZWNfNChyZF9vZnMsIG9mZnNldG9mKENQVUFSTVN0YXRlLCB2ZnAucWMpLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBybl9vZnMsIHJtX29mcywgdmVjX3NpemUsIHZlY19zaXpl
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodSA/IHVxc3ViX29wIDogc3FzdWJf
b3ApICsgc2l6ZSk7DQo+ID4gLSAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4gPiANCj4gPiAgICAgICAgICBjYXNlIE5FT05fM1JfVk1VTDogLyogVk1VTCAq
Lw0KPiA+ICAgICAgICAgICAgICBpZiAodSkgew0KPiANCj4gLS0NCj4gQWxleCBCZW5uw6llDQo=

