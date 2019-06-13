Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72D1C46477
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752CC21743
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BiNH5SVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752CC21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRgs-0006TE-8I
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbQJs-0003VP-O8
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hbQJq-0003AJ-Eu
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:03:12 -0400
Received: from mail-eopbgr30100.outbound.protection.outlook.com
 ([40.107.3.100]:50256 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hbQJc-0002oa-Ex; Thu, 13 Jun 2019 10:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cTtnXzIWMM/UpVbNZXwWLVUivd9jNGBVdSHvwuDUH0=;
 b=BiNH5SVImzJG3E6xeA/08AHdsoLDrlpD13NWqXyXyqOt+IPqoEhaM0Ogs7l039buW4swMYXA2RDyjIamh3sqCjG79+Yu9ghvAzKNYkwQ8mozqZGXDKDaCKUetoG7m4BAA0KQimCphTmBq0WSey43POZCtkTNy56LiGzJvZFFeNE=
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com (20.177.110.153) by
 AM0PR08MB3874.eurprd08.prod.outlook.com (20.178.82.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 13 Jun 2019 14:02:37 +0000
Received: from AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76]) by AM0PR08MB3572.eurprd08.prod.outlook.com
 ([fe80::d064:530:c7:ad76%6]) with mapi id 15.20.1987.012; Thu, 13 Jun 2019
 14:02:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v8 2/7] block: swap operation order in bdrv_append
Thread-Index: AQHVFjXGgsNg+PSamkmDUXu0vGswvqaZsBkAgAAExwA=
Date: Thu, 13 Jun 2019 14:02:37 +0000
Message-ID: <b643ce3f-104a-37e6-e373-1cb0de2aaf19@virtuozzo.com>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
 <20190529154654.95870-3-vsementsov@virtuozzo.com>
 <dd3c1d3f-a92a-bbd7-a916-ba7b066ee5dc@redhat.com>
In-Reply-To: <dd3c1d3f-a92a-bbd7-a916-ba7b066ee5dc@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::19)
 To AM0PR08MB3572.eurprd08.prod.outlook.com
 (2603:10a6:208:e1::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190613170234675
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b3db8d1-69b7-4cae-74e5-08d6f007ca2a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:AM0PR08MB3874; 
x-ms-traffictypediagnostic: AM0PR08MB3874:
x-microsoft-antispam-prvs: <AM0PR08MB3874F120B4543DFADA5891B6C1EF0@AM0PR08MB3874.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(396003)(39850400004)(136003)(199004)(189003)(186003)(81156014)(6486002)(26005)(81166006)(6436002)(36756003)(66066001)(229853002)(8676002)(31686004)(486006)(316002)(76176011)(2201001)(102836004)(2906002)(478600001)(2501003)(25786009)(6116002)(6506007)(8936002)(386003)(53546011)(3846002)(14454004)(31696002)(68736007)(66946007)(14444005)(256004)(6512007)(53936002)(86362001)(66476007)(66556008)(64756008)(66446008)(110136005)(54906003)(73956011)(71190400001)(305945005)(99286004)(52116002)(71200400001)(7736002)(11346002)(6246003)(446003)(4326008)(476003)(5660300002)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3874;
 H:AM0PR08MB3572.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IXjWS2/cOa/Hkb6NPiON/vD0BqlL+dRQPFJKrb87sBgQv+4dtvXiRlQ7cGqw+OoRjZg3q4fgNsaojJ4tB2NtbUKKRzkObA+r6QNYLem/BT5SMFKgcRjGW7mbpo4m+3Y0CTZX0CkcTvyFpx29SCSZu8uoSf2ENM5UQbvLd6LcYxtVOzfyVZsjdEzWUXjeopJ8ZD0vF22nZdyidauTxJ5pXxYx+ajQ7u3S0WoQ1TOP66Q7hbK7n+eCQ9F84aI7B5LnhcFU7b/PD/3q9AJJoIlw76qzyzeex//0sd3W+WsvNaOMlaXgiiEf9mnY8t9L7e/aM1VnjiqVpNaVqbJ5/f02Sy1t1boGMCVM3ESEL9oAnxyfzOIiWJEaJ6goTjCS/KWuFT0UTbdcKNe3yYajtRvIsue1Ioby/FUFfYtBdn+zNgg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E705B93C5739A49848954B2EDE922D3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3db8d1-69b7-4cae-74e5-08d6f007ca2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 14:02:37.1338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3874
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.100
Subject: Re: [Qemu-devel] [PATCH v8 2/7] block: swap operation order in
 bdrv_append
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

MTMuMDYuMjAxOSAxNjo0NSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4wNS4xOSAxNzo0Niwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IGJzX3RvcCBwYXJlbnRzIG1h
eSBjb25mbGljdCB3aXRoIGJzX25ldyBiYWNraW5nIGNoaWxkIHBlcm1pc3Npb25zLCBzbw0KPj4g
bGV0J3MgZG8gYmRydl9yZXBsYWNlX25vZGUgZmlyc3QsIGl0IGNvdmVycyBtb3JlIHBvc3NpYmxl
IGNhc2VzLg0KPj4NCj4+IEl0IGlzIG5lZWRlZCBmb3IgZnVydGhlciBpbXBsZW1lbnRhdGlvbiBv
ZiBiYWNrdXAtdG9wIGZpbHRlciwgd2hpY2gNCj4+IGRvbid0IHdhbnQgdG8gc2hhcmUgd3JpdGUg
cGVybWlzc2lvbiBvbiBpdHMgYmFja2luZyBjaGlsZC4NCj4+DQo+PiBTaWRlIGVmZmVjdCBpcyB0
aGF0IHdlIG1heSBzZXQgYmFja2luZyBoZCB3aGVuIGRldmljZSBuYW1lIGlzIGFscmVhZHkNCj4+
IGF2YWlsYWJsZSwgc28gMDg1IGlvdGVzdCBvdXRwdXQgaXMgY2hhbmdlZC4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2suYyAgICAgICAgICAgICAgICAgICAgfCAxMSAr
KysrKysrKy0tLQ0KPj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDg1Lm91dCB8ICAyICstDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ibG9jay5jIGIvYmxvY2suYw0KPj4gaW5kZXggZTZlOTc3MDcwNC4uNTcy
MTZmNDExNSAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrLmMNCj4+ICsrKyBiL2Jsb2NrLmMNCj4+IEBA
IC00MDg4LDIyICs0MDg4LDI3IEBAIHZvaWQgYmRydl9hcHBlbmQoQmxvY2tEcml2ZXJTdGF0ZSAq
YnNfbmV3LCBCbG9ja0RyaXZlclN0YXRlICpic190b3AsDQo+PiAgIHsNCj4+ICAgICAgIEVycm9y
ICpsb2NhbF9lcnIgPSBOVUxMOw0KPj4gICANCj4+IC0gICAgYmRydl9zZXRfYmFja2luZ19oZChi
c19uZXcsIGJzX3RvcCwgJmxvY2FsX2Vycik7DQo+PiArICAgIGJkcnZfcmVmKGJzX3RvcCk7DQo+
PiArDQo+PiArICAgIGJkcnZfcmVwbGFjZV9ub2RlKGJzX3RvcCwgYnNfbmV3LCAmbG9jYWxfZXJy
KTsNCj4+ICAgICAgIGlmIChsb2NhbF9lcnIpIHsNCj4+ICAgICAgICAgICBlcnJvcl9wcm9wYWdh
dGUoZXJycCwgbG9jYWxfZXJyKTsNCj4+ICsgICAgICAgIGVycm9yX3ByZXBlbmQoZXJycCwgIkZh
aWxlZCB0byByZXBsYWNlIG5vZGU6ICIpOw0KPj4gICAgICAgICAgIGdvdG8gb3V0Ow0KPj4gICAg
ICAgfQ0KPj4gICANCj4+IC0gICAgYmRydl9yZXBsYWNlX25vZGUoYnNfdG9wLCBic19uZXcsICZs
b2NhbF9lcnIpOw0KPj4gKyAgICBiZHJ2X3NldF9iYWNraW5nX2hkKGJzX25ldywgYnNfdG9wLCAm
bG9jYWxfZXJyKTsNCj4+ICAgICAgIGlmIChsb2NhbF9lcnIpIHsNCj4+ICsgICAgICAgIGJkcnZf
cmVwbGFjZV9ub2RlKGJzX25ldywgYnNfdG9wLCAmZXJyb3JfYWJvcnQpOw0KPiANCj4gSG0uICBJ
IHNlZSB0aGUgbmVlZCBmb3Igc3dpdGNoaW5nIHRoaXMgc3R1ZmYgYXJvdW5kLCBidXQgdGhpcw0K
PiAmZXJyb3JfYWJvcnQgaXMgbXVjaCBtb3JlIGRpZmZpY3VsdCB0byB2ZXJpZnkgdGhhbiB0aGUg
cHJldmlvdXMgb25lIGZvcg0KPiBiZHJ2X3NldF9iYWNraW5nX2hkKC4uLiwgTlVMTCwgLi4uKS4g
IEkgdGhpbmsgaXQgYXQgbGVhc3Qgd2FycmFudHMgYQ0KPiBjb21tZW50IHdoeSB0aGUgb3JkZXIg
aGFzIHRvIGJlIHRoaXMgd2F5ICh1c2luZyBnaXQgYmxhbWUgaGFzIHRoZQ0KPiBkaXNhZHZhbnRh
Z2Ugb2YgZmFkaW5nIG92ZXIgdGltZSBhcyBvdGhlciBwZW9wbGUgbW9kaWZ5IGEgcGllY2Ugb2YN
Cg0Kc28sIEkgYWx3YXlzIHVzZSBnaXQgbG9nIC1wIC0tIDxmaWxlcGF0aD4gaW5zdGVhZCwgYW5k
IHNlYXJjaCB0aHJvdWdoIGl0KQ0KDQo+IGNvZGUpLCBhbmQgd2h5IHRoaXMgJmVycm9yX2Fib3J0
IGlzIHNhZmUuDQoNCm9rLCB3aWxsIGFkZA0KDQo+IA0KPiBNYXgNCj4gDQo+PiAgICAgICAgICAg
ZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQo+PiAtICAgICAgICBiZHJ2X3NldF9i
YWNraW5nX2hkKGJzX25ldywgTlVMTCwgJmVycm9yX2Fib3J0KTsNCj4+ICsgICAgICAgIGVycm9y
X3ByZXBlbmQoZXJycCwgIkZhaWxlZCB0byBzZXQgYmFja2luZzogIik7DQo+PiAgICAgICAgICAg
Z290byBvdXQ7DQo+PiAgICAgICB9DQo+PiAgIA0KPj4gICAgICAgLyogYnNfbmV3IGlzIG5vdyBy
ZWZlcmVuY2VkIGJ5IGl0cyBuZXcgcGFyZW50cywgd2UgZG9uJ3QgbmVlZCB0aGUNCj4+ICAgICAg
ICAqIGFkZGl0aW9uYWwgcmVmZXJlbmNlIGFueSBtb3JlLiAqLw0KPj4gICBvdXQ6DQo+PiArICAg
IGJkcnZfdW5yZWYoYnNfdG9wKTsNCj4+ICAgICAgIGJkcnZfdW5yZWYoYnNfbmV3KTsNCj4+ICAg
fQ0KPj4gICANCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlvdGVzdHMvMDg1Lm91dCBiL3Rl
c3RzL3FlbXUtaW90ZXN0cy8wODUub3V0DQo+PiBpbmRleCA2ZWRmMTA3ZjU1Li5lNWEyNjQ1YmY1
IDEwMDY0NA0KPj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzA4NS5vdXQNCj4+ICsrKyBiL3Rl
c3RzL3FlbXUtaW90ZXN0cy8wODUub3V0DQo+PiBAQCAtNzQsNyArNzQsNyBAQCBGb3JtYXR0aW5n
ICdURVNUX0RJUi90LklNR0ZNVCcsIGZtdD1JTUdGTVQgc2l6ZT0xMzQyMTc3MjggYmFja2luZ19m
aWxlPVRFU1RfRElSLw0KPj4gICANCj4+ICAgPT09IEludmFsaWQgY29tbWFuZCAtIHNuYXBzaG90
IG5vZGUgdXNlZCBhcyBiYWNraW5nIGhkID09PQ0KPj4gICANCj4+IC17ImVycm9yIjogeyJjbGFz
cyI6ICJHZW5lcmljRXJyb3IiLCAiZGVzYyI6ICJOb2RlICdzbmFwXzExJyBpcyBidXN5OiBub2Rl
IGlzIHVzZWQgYXMgYmFja2luZyBoZCBvZiAnc25hcF8xMicifX0NCj4+ICt7ImVycm9yIjogeyJj
bGFzcyI6ICJHZW5lcmljRXJyb3IiLCAiZGVzYyI6ICJOb2RlICdzbmFwXzExJyBpcyBidXN5OiBu
b2RlIGlzIHVzZWQgYXMgYmFja2luZyBoZCBvZiAndmlydGlvMCcifX0NCj4+ICAgDQo+PiAgID09
PSBJbnZhbGlkIGNvbW1hbmQgLSBzbmFwc2hvdCBub2RlIGhhcyBhIGJhY2tpbmcgaW1hZ2UgPT09
DQo+PiAgIA0KPj4NCj4gDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

