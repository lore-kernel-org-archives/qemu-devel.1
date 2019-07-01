Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003C7C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7013620673
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HKWvRLJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7013620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3ZZ-0001AM-FT
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:10:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44030)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hi3CZ-0000Z0-C5
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hi3CV-0000gq-DT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:47:01 -0400
Received: from mail-eopbgr10139.outbound.protection.outlook.com
 ([40.107.1.139]:6561 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hi3CV-0000cw-00; Mon, 01 Jul 2019 16:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78cPTOI38FLje8u9wfEVQElQvNpC/Sz4bndzkc2oGnc=;
 b=HKWvRLJHhjp/JywsL3DPdRIS9bzQVz4wKxfpXR3nEFtbNHoA1bzYLoUOlZKa7lR6Y1eTe+LNdfoewpq3CtQkHmeXiPDeW0eZxMDWFvc36I7ObsVt/yVduZy9eSknhxPyZ1ninMbTbpppDiRC7U0qqSuQKOQIps+lTa5fBE+/t88=
Received: from DB7PR08MB3258.eurprd08.prod.outlook.com (52.134.111.155) by
 DB7PR08MB3834.eurprd08.prod.outlook.com (20.178.45.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 16:41:52 +0000
Received: from DB7PR08MB3258.eurprd08.prod.outlook.com
 ([fe80::5d2:b836:e08a:f5cf]) by DB7PR08MB3258.eurprd08.prod.outlook.com
 ([fe80::5d2:b836:e08a:f5cf%3]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 16:41:51 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 2/5] iotests: Fix throttling in 030
Thread-Index: AQHVLThSCsVTE4oOY0GJkyciA7f+oaa1/U8A
Date: Mon, 1 Jul 2019 16:41:51 +0000
Message-ID: <aaea4609-7629-1e83-ba2f-568c5666679c@virtuozzo.com>
References: <20190627223255.3789-1-mreitz@redhat.com>
 <20190627223255.3789-3-mreitz@redhat.com>
In-Reply-To: <20190627223255.3789-3-mreitz@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0299.eurprd05.prod.outlook.com
 (2603:10a6:7:93::30) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:20::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d904b2af-a031-463d-b1d5-08d6fe4304a3
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB7PR08MB3834; 
x-ms-traffictypediagnostic: DB7PR08MB3834:
x-microsoft-antispam-prvs: <DB7PR08MB3834DB16F92323E5C6A67F39F4F90@DB7PR08MB3834.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(376002)(39850400004)(396003)(346002)(136003)(199004)(189003)(53936002)(31686004)(14454004)(73956011)(66946007)(186003)(5024004)(14444005)(256004)(81166006)(6506007)(53546011)(8676002)(68736007)(52116002)(26005)(486006)(476003)(2616005)(11346002)(446003)(25786009)(66446008)(66066001)(2906002)(81156014)(66556008)(64756008)(478600001)(386003)(6486002)(229853002)(4326008)(6512007)(6436002)(66476007)(71200400001)(99286004)(86362001)(44832011)(305945005)(31696002)(7736002)(2501003)(6116002)(5660300002)(3846002)(76176011)(36756003)(6246003)(110136005)(54906003)(316002)(8936002)(102836004)(71190400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3834;
 H:DB7PR08MB3258.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0DQzbKBD8yAbVhEO6NIuid1+hdkoGVUHsWbrglDx2S9hkd9uRK8sp9TprbPQrWnPz26iHJg5tNCQaY3rTH6dskuavJS0VZA8vSAoJqJ8ka3+AGHFpZsMyY0MxouzEXCp3NTpalqaom7B4H+emrV6Cv711SrE7kvD9qk90/pR96sXwLkongDqdGjLjnAY4uu6RQMIDU3RmgX6lWfmluTmzlmNaBiHGvy/4etlBeTFYeKRHscBSowHqjGq3Kr5XEF3Aes3TYfYBl0naT/tY3PVK3sSmklGOhhqijKVgXnXGOH0aKGQs2QqfsEsnF5r8oXJsrA3hfcdBYlwCWIFiD2FVLpZ5++VMwIIhLHSu7W1SCo4xyahL3/wn5hO7SR7DFB7FRDrYoNEHBUm1OlQUA0yVrg+FIE3vwuWd2yK5k/yjdY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <917705F0ACD82D428088E6D413B313DE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d904b2af-a031-463d-b1d5-08d6fe4304a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 16:41:51.6942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: andrey.shinkevich@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3834
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.139
Subject: Re: [Qemu-devel] [PATCH 2/5] iotests: Fix throttling in 030
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDI4LzA2LzIwMTkgMDE6MzIsIE1heCBSZWl0eiB3cm90ZToNCj4gQ3VycmVudGx5LCBU
ZXN0UGFyYWxsZWxPcHMgaW4gMDMwIGNyZWF0ZXMgaW1hZ2VzIHRoYXQgYXJlIHRvbyBzbWFsbCBm
b3INCj4gam9iIHRocm90dGxpbmcgdG8gYmUgZWZmZWN0aXZlLiAgVGhpcyBpcyByZWZsZWN0ZWQg
YnkgdGhlIGZhY3QgdGhhdCBpdA0KPiBuZXZlciB1bmRvZXMgdGhlIHRocm90dGxpbmcuDQo+IA0K
PiBJbmNyZWFzZSB0aGUgaW1hZ2Ugc2l6ZSBhbmQgdW5kbyB0aGUgdGhyb3R0bGluZyB3aGVuIHRo
ZSBqb2Igc2hvdWxkIGJlDQo+IGNvbXBsZXRlZC4gIEFsc28sIGFkZCB0aHJvdHRsaW5nIGluIHRl
c3Rfb3ZlcmxhcHBpbmdfNCwgb3IgdGhlIGpvYnMgbWF5DQo+IG5vdCBiZSBzbyBvdmVybGFwcGlu
ZyBhZnRlciBhbGwuICBJbiBmYWN0LCB0aGUgZXJyb3IgdXN1YWxseSBlbWl0dGVkDQo+IGhlcmUg
aXMgdGhhdCBub2RlMiBzaW1wbHkgZG9lcyBub3QgZXhpc3QsIG5vdCB0aGF0IG92ZXJsYXBwaW5n
IGpvYnMgYXJlDQo+IG5vdCBhbGxvd2VkIC0tIHRoZSBmYWN0IHRoYXQgdGhpcyBqb2IgaWdub3Jl
cyB0aGUgZXhhY3QgZXJyb3IgbWVzc2FnZXMNCj4gYW5kIGp1c3QgY2hlY2tzIHRoZSBlcnJvciBj
bGFzcyBpcyBzb21ldGhpbmcgdGhhdCBzaG91bGQgYmUgZml4ZWQgaW4gYQ0KPiBmb2xsb3ctdXAg
cGF0Y2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29t
Pg0KPiAtLS0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDMwIHwgMzIgKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMDMw
IGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzAzMA0KPiBpbmRleCBjNjMxMWQxODI1Li4yY2Y4ZDU0ZGM1
IDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMvMDMwDQo+ICsrKyBiL3Rlc3RzL3Fl
bXUtaW90ZXN0cy8wMzANCj4gQEAgLTE1NCw3ICsxNTQsNyBAQCBjbGFzcyBUZXN0U2luZ2xlRHJp
dmUoaW90ZXN0cy5RTVBUZXN0Q2FzZSk6DQo+ICAgY2xhc3MgVGVzdFBhcmFsbGVsT3BzKGlvdGVz
dHMuUU1QVGVzdENhc2UpOg0KPiAgICAgICBudW1fb3BzID0gNCAjIE51bWJlciBvZiBwYXJhbGxl
bCBibG9jay1zdHJlYW0gb3BlcmF0aW9ucw0KPiAgICAgICBudW1faW1ncyA9IG51bV9vcHMgKiAy
ICsgMQ0KPiAtICAgIGltYWdlX2xlbiA9IG51bV9vcHMgKiA1MTIgKiAxMDI0DQo+ICsgICAgaW1h
Z2VfbGVuID0gbnVtX29wcyAqIDQgKiAxMDI0ICogMTAyNA0KPiAgICAgICBpbWdzID0gW10NCj4g
ICANCj4gICAgICAgZGVmIHNldFVwKHNlbGYpOg0KPiBAQCAtMTc2LDExICsxNzYsMTEgQEAgY2xh
c3MgVGVzdFBhcmFsbGVsT3BzKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAgICAgICAgICAgIyBQ
dXQgZGF0YSBpbnRvIHRoZSBpbWFnZXMgd2UgYXJlIGNvcHlpbmcgZGF0YSBmcm9tDQo+ICAgICAg
ICAgICBvZGRfaW1nX2luZGV4ZXMgPSBbeCBmb3IgeCBpbiByZXZlcnNlZChyYW5nZShzZWxmLm51
bV9pbWdzKSkgaWYgeCAlIDIgPT0gMV0NCj4gICAgICAgICAgIGZvciBpIGluIHJhbmdlKGxlbihv
ZGRfaW1nX2luZGV4ZXMpKToNCj4gLSAgICAgICAgICAgICMgQWx0ZXJuYXRlIGJldHdlZW4gMjU2
S0IgYW5kIDUxMktCLg0KPiArICAgICAgICAgICAgIyBBbHRlcm5hdGUgYmV0d2VlbiAyTUIgYW5k
IDRNQi4NCj4gICAgICAgICAgICAgICAjIFRoaXMgd2F5IGpvYnMgd2lsbCBub3QgZmluaXNoIGlu
IHRoZSBzYW1lIG9yZGVyIHRoZXkgd2VyZSBjcmVhdGVkDQo+IC0gICAgICAgICAgICBudW1fa2Ig
PSAyNTYgKyAyNTYgKiAoaSAlIDIpDQo+ICsgICAgICAgICAgICBudW1fbWIgPSAyICsgMiAqIChp
ICUgMikNCj4gICAgICAgICAgICAgICBxZW11X2lvKCctZicsIGlvdGVzdHMuaW1nZm10LA0KPiAt
ICAgICAgICAgICAgICAgICAgICAnLWMnLCAnd3JpdGUgLVAgMHhGRiAlZGsgJWRrJyAlIChpICog
NTEyLCBudW1fa2IpLA0KPiArICAgICAgICAgICAgICAgICAgICAnLWMnLCAnd3JpdGUgLVAgMHhG
RiAlZE0gJWRNJyAlIChpICogNCwgbnVtX21iKSwNCj4gICAgICAgICAgICAgICAgICAgICAgIHNl
bGYuaW1nc1tvZGRfaW1nX2luZGV4ZXNbaV1dKQ0KPiAgIA0KPiAgICAgICAgICAgIyBBdHRhY2gg
dGhlIGRyaXZlIHRvIHRoZSBWTQ0KPiBAQCAtMjEzLDYgKzIxMywxMCBAQCBjbGFzcyBUZXN0UGFy
YWxsZWxPcHMoaW90ZXN0cy5RTVBUZXN0Q2FzZSk6DQo+ICAgICAgICAgICAgICAgcmVzdWx0ID0g
c2VsZi52bS5xbXAoJ2Jsb2NrLXN0cmVhbScsIGRldmljZT1ub2RlX25hbWUsIGpvYl9pZD1qb2Jf
aWQsIGJhc2U9c2VsZi5pbWdzW2ktMl0sIHNwZWVkPTUxMioxMDI0KQ0KPiAgICAgICAgICAgICAg
IHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4gICANCj4gKyAgICAgICAg
Zm9yIGpvYiBpbiBwZW5kaW5nX2pvYnM6DQo+ICsgICAgICAgICAgICByZXN1bHQgPSBzZWxmLnZt
LnFtcCgnYmxvY2stam9iLXNldC1zcGVlZCcsIGRldmljZT1qb2IsIHNwZWVkPTApDQo+ICsgICAg
ICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+ICsNCj4gICAg
ICAgICAgICMgV2FpdCBmb3IgYWxsIGpvYnMgdG8gYmUgZmluaXNoZWQuDQo+ICAgICAgICAgICB3
aGlsZSBsZW4ocGVuZGluZ19qb2JzKSA+IDA6DQo+ICAgICAgICAgICAgICAgZm9yIGV2ZW50IGlu
IHNlbGYudm0uZ2V0X3FtcF9ldmVudHMod2FpdD1UcnVlKToNCj4gQEAgLTI2MCw2ICsyNjQsOSBA
QCBjbGFzcyBUZXN0UGFyYWxsZWxPcHMoaW90ZXN0cy5RTVBUZXN0Q2FzZSk6DQo+ICAgICAgICAg
ICByZXN1bHQgPSBzZWxmLnZtLnFtcCgnYmxvY2stY29tbWl0JywgZGV2aWNlPSdkcml2ZTAnLCBi
YXNlPXNlbGYuaW1nc1swXSwgdG9wPXNlbGYuaW1nc1sxXSwgam9iX2lkPSdjb21taXQtbm9kZTAn
KQ0KPiAgICAgICAgICAgc2VsZi5hc3NlcnRfcW1wKHJlc3VsdCwgJ2Vycm9yL2NsYXNzJywgJ0dl
bmVyaWNFcnJvcicpDQo+ICAgDQo+ICsgICAgICAgIHJlc3VsdCA9IHNlbGYudm0ucW1wKCdibG9j
ay1qb2Itc2V0LXNwZWVkJywgZGV2aWNlPSdzdHJlYW0tbm9kZTQnLCBzcGVlZD0wKQ0KPiArICAg
ICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+ICsNCj4gICAgICAg
ICAgIHNlbGYud2FpdF91bnRpbF9jb21wbGV0ZWQoZHJpdmU9J3N0cmVhbS1ub2RlNCcpDQo+ICAg
ICAgICAgICBzZWxmLmFzc2VydF9ub19hY3RpdmVfYmxvY2tfam9icygpDQo+ICAgDQo+IEBAIC0y
ODksNiArMjk2LDkgQEAgY2xhc3MgVGVzdFBhcmFsbGVsT3BzKGlvdGVzdHMuUU1QVGVzdENhc2Up
Og0KPiAgICAgICAgICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ2Jsb2NrLXN0cmVhbScsIGRldmlj
ZT0nZHJpdmUwJywgYmFzZT1zZWxmLmltZ3NbNV0sIGpvYl9pZD0nc3RyZWFtLWRyaXZlMCcpDQo+
ICAgICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAnZXJyb3IvY2xhc3MnLCAnR2VuZXJp
Y0Vycm9yJykNCj4gICANCj4gKyAgICAgICAgcmVzdWx0ID0gc2VsZi52bS5xbXAoJ2Jsb2NrLWpv
Yi1zZXQtc3BlZWQnLCBkZXZpY2U9J2NvbW1pdC1ub2RlMycsIHNwZWVkPTApDQo+ICsgICAgICAg
IHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4gKw0KPiAgICAgICAgICAg
c2VsZi53YWl0X3VudGlsX2NvbXBsZXRlZChkcml2ZT0nY29tbWl0LW5vZGUzJykNCj4gICANCj4g
ICAgICAgIyBTaW1pbGFyIHRvIHRlc3Rfb3ZlcmxhcHBpbmdfMiwgYnV0IGhlcmUgYmxvY2stY29t
bWl0IGRvZXNuJ3QgdXNlIHRoZSAndG9wJyBwYXJhbWV0ZXIuDQo+IEBAIC0zMDksNiArMzE5LDkg
QEAgY2xhc3MgVGVzdFBhcmFsbGVsT3BzKGlvdGVzdHMuUU1QVGVzdENhc2UpOg0KPiAgICAgICAg
ICAgc2VsZi5hc3NlcnRfcW1wKGV2ZW50LCAnZGF0YS90eXBlJywgJ2NvbW1pdCcpDQo+ICAgICAg
ICAgICBzZWxmLmFzc2VydF9xbXBfYWJzZW50KGV2ZW50LCAnZGF0YS9lcnJvcicpDQo+ICAgDQo+
ICsgICAgICAgIHJlc3VsdCA9IHNlbGYudm0ucW1wKCdibG9jay1qb2Itc2V0LXNwZWVkJywgZGV2
aWNlPSdjb21taXQtZHJpdmUwJywgc3BlZWQ9MCkNCj4gKyAgICAgICAgc2VsZi5hc3NlcnRfcW1w
KHJlc3VsdCwgJ3JldHVybicsIHt9KQ0KPiArDQo+ICAgICAgICAgICByZXN1bHQgPSBzZWxmLnZt
LnFtcCgnYmxvY2stam9iLWNvbXBsZXRlJywgZGV2aWNlPSdjb21taXQtZHJpdmUwJykNCj4gICAg
ICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4gICANCj4gQEAg
LTMyMSwxMyArMzM0LDE4IEBAIGNsYXNzIFRlc3RQYXJhbGxlbE9wcyhpb3Rlc3RzLlFNUFRlc3RD
YXNlKToNCj4gICAgICAgICAgIHNlbGYuYXNzZXJ0X25vX2FjdGl2ZV9ibG9ja19qb2JzKCkNCj4g
ICANCj4gICAgICAgICAgICMgQ29tbWl0IGZyb20gbm9kZTIgaW50byBub2RlMA0KPiAtICAgICAg
ICByZXN1bHQgPSBzZWxmLnZtLnFtcCgnYmxvY2stY29tbWl0JywgZGV2aWNlPSdkcml2ZTAnLCB0
b3A9c2VsZi5pbWdzWzJdLCBiYXNlPXNlbGYuaW1nc1swXSkNCj4gKyAgICAgICAgcmVzdWx0ID0g
c2VsZi52bS5xbXAoJ2Jsb2NrLWNvbW1pdCcsIGRldmljZT0nZHJpdmUwJywNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdG9wPXNlbGYuaW1nc1syXSwgYmFzZT1zZWxmLmltZ3NbMF0s
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNwZWVkPTEwMjQqMTAyNCkNCj4gICAg
ICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4gICANCj4gICAg
ICAgICAgICMgU3RyZWFtIGZyb20gbm9kZTIgaW50byBub2RlNA0KPiAgICAgICAgICAgcmVzdWx0
ID0gc2VsZi52bS5xbXAoJ2Jsb2NrLXN0cmVhbScsIGRldmljZT0nbm9kZTQnLCBiYXNlX25vZGU9
J25vZGUyJywgam9iX2lkPSdub2RlNCcpDQo+ICAgICAgICAgICBzZWxmLmFzc2VydF9xbXAocmVz
dWx0LCAnZXJyb3IvY2xhc3MnLCAnR2VuZXJpY0Vycm9yJykNCj4gICANCj4gKyAgICAgICAgcmVz
dWx0ID0gc2VsZi52bS5xbXAoJ2Jsb2NrLWpvYi1zZXQtc3BlZWQnLCBkZXZpY2U9J2RyaXZlMCcs
IHNwZWVkPTApDQo+ICsgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7
fSkNCj4gKw0KPiAgICAgICAgICAgc2VsZi53YWl0X3VudGlsX2NvbXBsZXRlZCgpDQo+ICAgICAg
ICAgICBzZWxmLmFzc2VydF9ub19hY3RpdmVfYmxvY2tfam9icygpDQo+ICAgDQo+IEBAIC0zNzgs
NiArMzk2LDEwIEBAIGNsYXNzIFRlc3RQYXJhbGxlbE9wcyhpb3Rlc3RzLlFNUFRlc3RDYXNlKToN
Cj4gICAgICAgICAgIHJlc3VsdCA9IHNlbGYudm0ucW1wKCdibG9jay1jb21taXQnLCBkZXZpY2U9
J2RyaXZlMCcsIGJhc2U9c2VsZi5pbWdzWzVdLCBzcGVlZD0xMDI0KjEwMjQpDQo+ICAgICAgICAg
ICBzZWxmLmFzc2VydF9xbXAocmVzdWx0LCAncmV0dXJuJywge30pDQo+ICAgDQo+ICsgICAgICAg
IGZvciBqb2IgaW4gWydkcml2ZTAnLCAnbm9kZTQnXToNCj4gKyAgICAgICAgICAgIHJlc3VsdCA9
IHNlbGYudm0ucW1wKCdibG9jay1qb2Itc2V0LXNwZWVkJywgZGV2aWNlPWpvYiwgc3BlZWQ9MCkN
Cj4gKyAgICAgICAgICAgIHNlbGYuYXNzZXJ0X3FtcChyZXN1bHQsICdyZXR1cm4nLCB7fSkNCj4g
Kw0KPiAgICAgICAgICAgIyBXYWl0IGZvciBhbGwgam9icyB0byBiZSBmaW5pc2hlZC4NCj4gICAg
ICAgICAgIHBlbmRpbmdfam9icyA9IFsnbm9kZTQnLCAnZHJpdmUwJ10NCj4gICAgICAgICAgIHdo
aWxlIGxlbihwZW5kaW5nX2pvYnMpID4gMDoNCj4gDQoNClRlc3RlZC1ieTogQW5kcmV5IFNoaW5r
ZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQotLSANCldpdGggdGhlIGJl
c3QgcmVnYXJkcywNCkFuZHJleSBTaGlua2V2aWNoDQo=

