Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3EBC282DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 11:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2852190B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 11:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YMwTFWhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2852190B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHRWp-0005sY-9X
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 07:17:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHRV7-0004pn-K5
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHRTw-0003Ht-4v
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 07:15:01 -0400
Received: from mail-eopbgr30091.outbound.protection.outlook.com
	([40.107.3.91]:23685
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hHRTu-0003GG-CJ; Fri, 19 Apr 2019 07:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=rEX5QXzeFT/mjO4kB2tOp5SxjaCDRkpn5MMxaszHcKw=;
	b=YMwTFWhMYUdix8qdOP6l7WZBTBYfwy5ioGl4J2HUisTYgvlLVc/W5Xd8Km+Lm1Epqm6Tyczi1o6fCnhxQaUc00kUO2jYIcGKsT+Hdj7l/x+moDF0HdmeoLsLGVDoy+abmhFabWNrM7YunIuOIKR5tqoE+FaYFVDv8dhGfTN4bQw=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3675.eurprd08.prod.outlook.com (20.177.120.157) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.11; Fri, 19 Apr 2019 11:14:54 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.013;
	Fri, 19 Apr 2019 11:14:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 1/2] block/io: bdrv_pdiscard: support
	int64_t bytes parameter
Thread-Index: AQHU9QWqzKxJuu8zTEuedG+QHV3ZwaZAbyOAgALpCIA=
Date: Fri, 19 Apr 2019 11:14:54 +0000
Message-ID: <a99918ba-d077-90d3-ee6d-fd5c95090b63@virtuozzo.com>
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
	<20190417100929.39943-2-vsementsov@virtuozzo.com>
	<dd1f30c4-e6ab-6481-ae34-412fa8533a5f@redhat.com>
In-Reply-To: <dd1f30c4-e6ab-6481-ae34-412fa8533a5f@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0049.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::38)
	To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190419141451525
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa23ce94-65e9-449a-aa4c-08d6c4b83f99
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3675; 
x-ms-traffictypediagnostic: DB7PR08MB3675:
x-microsoft-antispam-prvs: <DB7PR08MB3675308429315E42BBE86E0EC1270@DB7PR08MB3675.eurprd08.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(39840400004)(136003)(366004)(346002)(376002)(199004)(189003)(3846002)(6116002)(81156014)(6246003)(11346002)(486006)(5660300002)(81166006)(8676002)(446003)(86362001)(305945005)(7736002)(14454004)(66066001)(2201001)(66476007)(66556008)(316002)(53546011)(2616005)(110136005)(386003)(476003)(99286004)(54906003)(6506007)(31696002)(52116002)(76176011)(68736007)(186003)(71190400001)(102836004)(4326008)(97736004)(6486002)(71200400001)(14444005)(25786009)(478600001)(31686004)(2906002)(6512007)(36756003)(229853002)(2501003)(8936002)(53936002)(26005)(256004)(6436002)(66446008)(64756008)(66946007)(73956011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3675;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sHk/0Wn8jg7PpJSwg1DZTlMxVtKP+dv1hvsOKEHC0QaHUd8u+P24RiHs3c7hvdGQPBg1hdjnshbwrcedKPscvRx3u2x+0qDGsVvIqbiqgn8kCktZbnQnRObc+3Ln8NnlagLGAKSULbBvbZjwZtqyB+mTQ48hMk30E26ydBLMlgeaHVBhPoJh4Mnq1EMScoRJpqXWNiDj+e5iqy3gtLsqb39K6UoZoJNlwmSV/tAOR0VRaLP+mlm+EweuWDCQ4cxRnWckAUfDbgptybu4PE1atxUw77TrNnZbC3MFsnVghW3oEkNl56euhnvAlwBX1DDa7MUdbTfN4xlMdDK5U+gg18zbmJKa8Z3W3Op987StlT3in+fP6JNmZyoGQgJRX5uWpYrv7ipfo+EA/HQc096mrp0r5KCDIeQ9cTOWlxyKCtE=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <04A5FFE82F20464688018A4C36C65EBE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa23ce94-65e9-449a-aa4c-08d6c4b83f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 11:14:54.3488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3675
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.91
Subject: Re: [Qemu-devel] [PATCH 1/2] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
	Denis Lunev <den@virtuozzo.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419111454.O5JT5W5d6v4E12Ct23GLx7Srb4UI-Sv5E-HGl6yTelM@z>

MTcuMDQuMjAxOSAxNzo0OCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gNC8xNy8xOSA1OjA5IEFN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gVGhpcyBmaXhlcyBhdCBs
ZWFzdCBvbmUgb3ZlcmZsb3cgaW4gcWNvdzJfcHJvY2Vzc19kaXNjYXJkcy4NCj4gDQo+IEl0J3Mg
d29ydGggY2FsbGluZyBvdXQgaG93IGxvbmcgdGhlIHByb2JsZW0gb2YgcGFzc2luZyA+MkcgZGlz
Y2FyZA0KPiByZXF1ZXN0cyBoYXMgYmVlbiBwcmVzZW50IChteSByZXBseSB0byB0aGUgY292ZXIg
bGV0dGVyIHRyYWNrZWQgZG93bg0KPiAwYjkxOWZhZSBhcyB0cmFja2luZyBhIDY0LWJpdCBkaXNj
YXJkIHJlZ2lvbiBidXQgcGFzc2luZyBpdCB0bw0KPiBiZHJ2X2Rpc2NhcmQoKSB3aGljaCB0b29r
IGFuIGludCBzZWN0b3JzOyBJJ20gbm90IHN1cmUgaWYgbGF0ZXIgY2hhbmdlcw0KPiB0byBieXRl
LWJhc2VkIHJhdGhlciB0aGFuIHNlY3Rvci1iYXNlZCBtYWRlIGEgZGlmZmVyZW5jZSkuDQo+IA0K
PiANCj4+IEBAIC0yNjY0LDE0ICsyNjY0LDE1IEBAIHN0YXRpYyB2b2lkIGNvcm91dGluZV9mbiBi
ZHJ2X3BkaXNjYXJkX2NvX2VudHJ5KHZvaWQgKm9wYXF1ZSkNCj4+ICAgICAgIGFpb193YWl0X2tp
Y2soKTsNCj4+ICAgfQ0KPj4gICANCj4+IC1pbnQgY29yb3V0aW5lX2ZuIGJkcnZfY29fcGRpc2Nh
cmQoQmRydkNoaWxkICpjaGlsZCwgaW50NjRfdCBvZmZzZXQsIGludCBieXRlcykNCj4+ICtpbnQg
Y29yb3V0aW5lX2ZuIGJkcnZfY29fcGRpc2NhcmQoQmRydkNoaWxkICpjaGlsZCwgaW50NjRfdCBv
ZmZzZXQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludDY0X3QgYnl0
ZXMpDQo+PiAgIHsNCj4+ICAgICAgIEJkcnZUcmFja2VkUmVxdWVzdCByZXE7DQo+PiAgICAgICBp
bnQgbWF4X3BkaXNjYXJkLCByZXQ7DQo+PiAgICAgICBpbnQgaGVhZCwgdGFpbCwgYWxpZ247DQo+
PiAgICAgICBCbG9ja0RyaXZlclN0YXRlICpicyA9IGNoaWxkLT5iczsNCj4+ICAgDQo+PiAtICAg
IGlmICghYnMgfHwgIWJzLT5kcnYpIHsNCj4+ICsgICAgaWYgKCFicyB8fCAhYnMtPmRydiB8fCAh
YmRydl9pc19pbnNlcnRlZChicykpIHsNCj4gDQo+IFRoaXMgY2hhbmdlIHNlZW1zIHVucmVsYXRl
ZD8gT2gsIGl0J3MgYmVjYXVzZSB5b3UgYXJlIGlubGluaW5nIHRoZSByZXN0DQo+IG9mIHdoYXQg
YmRydl9jaGVja19ieXRlX3JlcXVlc3QgdXNlZCB0byBkby4NCj4gDQo+PiAgICAgICAgICAgcmV0
dXJuIC1FTk9NRURJVU07DQo+PiAgICAgICB9DQo+PiAgIA0KPj4gQEAgLTI2NzksOSArMjY4MCw4
IEBAIGludCBjb3JvdXRpbmVfZm4gYmRydl9jb19wZGlzY2FyZChCZHJ2Q2hpbGQgKmNoaWxkLCBp
bnQ2NF90IG9mZnNldCwgaW50IGJ5dGVzKQ0KPj4gICAgICAgICAgIHJldHVybiAtRVBFUk07DQo+
PiAgICAgICB9DQo+PiAgIA0KPj4gLSAgICByZXQgPSBiZHJ2X2NoZWNrX2J5dGVfcmVxdWVzdChi
cywgb2Zmc2V0LCBieXRlcyk7DQo+PiAtICAgIGlmIChyZXQgPCAwKSB7DQo+PiAtICAgICAgICBy
ZXR1cm4gcmV0Ow0KPiANCj4gSWYgd2Uga2VlcCB0aGlzIGNhbGwgaW4gcGxhY2UsIHdlIGNhbiBm
bGFnIGlmIHRoZXJlIHdlcmUgYW55IG90aGVyDQo+IGNhbGxlcnMgdGhhdCB3ZXJlIHBhc3Npbmcg
dHJ1bmNhdGVkIDY0LWJpdCBxdWFudGl0aWVzLiBCdXQgSSBhbHNvIGFncmVlDQo+IHRoYXQgbm93
IHRoYXQgd2UgYXJlIHN3aXRjaGluZyB0byBhIDY0LWJpdCBpbnRlcmZhY2UsIHdlIG5vIGxvbmdl
ciBoYXZlDQo+IHRvIGNoZWNrIHdoZXRoZXIgY2FsbGVycyB3ZXJlIHByb3Blcmx5IGxpbWl0aW5n
IHRoZWlyIHJlcXVlc3RzLg0KPiANCj4gSG1tIC0gSSBqdXN0IHJlYWxpemVkIHRoYXQgYmRydl9j
aGVja19ieXRlX3JlcXVlc3QoKSB0YWtlcyBhIHNpemVfdA0KPiAocmF0aGVyIHRoYW4gaW50NjRf
dCkgc2l6ZSBhcmd1bWVudCAtIGNvdWxkIHRoaXMgcmVzdWx0IGluIGFueSBvdGhlcg0KPiB0cnVu
Y2F0aW9ucyBvbiBhIDMyLWJpdCBwbGF0Zm9ybSB0aGF0IGRvbid0IGFmZmVjdCA2NC1iaXQgcGxh
dGZvcm1zPw0KPiANCj4+IEBAIC0yNzExLDEyICsyNzExLDEzIEBAIGludCBjb3JvdXRpbmVfZm4g
YmRydl9jb19wZGlzY2FyZChCZHJ2Q2hpbGQgKmNoaWxkLCBpbnQ2NF90IG9mZnNldCwgaW50IGJ5
dGVzKQ0KPj4gICAgICAgICAgIGdvdG8gb3V0Ow0KPj4gICAgICAgfQ0KPj4gICANCj4+IC0gICAg
bWF4X3BkaXNjYXJkID0gUUVNVV9BTElHTl9ET1dOKE1JTl9OT05fWkVSTyhicy0+YmwubWF4X3Bk
aXNjYXJkLCBJTlRfTUFYKSwNCj4+ICsgICAgbWF4X3BkaXNjYXJkID0gUUVNVV9BTElHTl9ET1dO
KE1JTl9OT05fWkVSTyhicy0+YmwubWF4X3BkaXNjYXJkLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJEUlZfUkVRVUVTVF9NQVhfQllURVMpLA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFsaWduKTsNCj4gDQo+IFRo
aXMgY2hhbmdlIGlzIGEgbm8tb3AsIHNpbmNlIEJEUlZfUkVRVUVTVF9NQVhfQllURVMgaXMgYWxy
ZWFkeSBJTlRfTUFYDQo+IGFsaWduZWQgZG93biB0byBzZWN0b3Igc2l6ZSwgYW5kIGFsaWduIGlz
IGF0IGxlYXN0IHNlY3RvciBzaXplLg0KDQpJdCdzIGEgcGFydCBvZiBpbmxpbmluZyBiZHJ2X2No
ZWNrX2J5dGVfcmVxdWVzdCB0b28uDQpJdCdzIE1JTihTSVpFX01BWCwgSU5UX01BWCkuLiBpcyBp
dCBwb3NzaWJsZSBmb3Igc2l6ZSB0byBsZXNzIHRoYW4gaW50PyBzZWVtcyBub3QNCg0KPiANCj4+
ICAgICAgIGFzc2VydChtYXhfcGRpc2NhcmQgPj0gYnMtPmJsLnJlcXVlc3RfYWxpZ25tZW50KTsN
Cj4+ICAgDQo+PiAgICAgICB3aGlsZSAoYnl0ZXMgPiAwKSB7DQo+PiAtICAgICAgICBpbnQgbnVt
ID0gYnl0ZXM7DQo+PiArICAgICAgICBpbnQ2NF90IG51bSA9IGJ5dGVzOw0KPj4gICANCj4+ICAg
ICAgICAgICBpZiAoaGVhZCkgew0KPj4gICAgICAgICAgICAgICAvKiBNYWtlIHNtYWxsIHJlcXVl
c3RzIHRvIGdldCB0byBhbGlnbm1lbnQgYm91bmRhcmllcy4gKi8NCj4+IEBAIC0yNzc4LDcgKzI3
NzksNyBAQCBvdXQ6DQo+PiAgICAgICByZXR1cm4gcmV0Ow0KPj4gICB9DQo+PiAgIA0KPj4gLWlu
dCBiZHJ2X3BkaXNjYXJkKEJkcnZDaGlsZCAqY2hpbGQsIGludDY0X3Qgb2Zmc2V0LCBpbnQgYnl0
ZXMpDQo+PiAraW50IGJkcnZfcGRpc2NhcmQoQmRydkNoaWxkICpjaGlsZCwgaW50NjRfdCBvZmZz
ZXQsIGludDY0X3QgYnl0ZXMpDQo+PiAgIHsNCj4+ICAgICAgIENvcm91dGluZSAqY287DQo+PiAg
ICAgICBEaXNjYXJkQ28gcndjbyA9IHsNCj4+DQo+IA0KPiBJJ20gbm90IHN1cmUgdGhlIHBhdGNo
IGlzIHBlcmZlY3QsIGJ1dCBJIGRlZmluaXRlbHkgYWdyZWUgdGhhdCB3ZSB3YW50DQo+IHRvIHN1
cHBvcnQgNjQtYnl0ZSBkaXNjYXJkIGxlbmd0aCAod2hlcmUgdGhlIGJsb2NrIGxheWVyIGZyYWdt
ZW50cyB0aGUNCj4gcmVxdWVzdCBhcyBuZWVkZWQpIHJhdGhlciB0aGFuIHRoZSBjdXJyZW50IDMy
LWJ5dGUgZGlzY2FyZCBsZW5ndGggKHdoZXJlDQo+IGNhbGxlcnMgaGF2ZSB0byBiZSBjYXJlZnVs
IHRvIG5vdCBzdWZmZXIgZnJvbSB0cnVuY2F0aW9uKS4NCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpWbGFkaW1pcg0K

