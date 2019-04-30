Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE4CC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0FAA2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="F2THHZ91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FAA2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42793 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLQ15-0002Pq-5Y
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:29:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLPq8-0001iV-Gg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLPbW-0002B8-UK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:03:16 -0400
Received: from mail-eopbgr120132.outbound.protection.outlook.com
	([40.107.12.132]:8352
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hLPbU-00028e-UK; Tue, 30 Apr 2019 06:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=FGEwhdE1ckFSsd9ZDtvAFvYU32EqI8Q5Rq0ZITtGjTQ=;
	b=F2THHZ91JntwJ6tUlceebsjsK660n0+GrCfZmATSWG6aTTdFaWa7uQK0nafhKz/JW0Vhqdy5fE0OXC5S75uymRKwtQjCKgyCc8rSQnu1HShcfJsKbw3UVQpJO2SXq6p2Pe0pCkurtCBG6RYazdrfD8UdWUvirhx3eweRpYBOEHY=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4731.eurprd08.prod.outlook.com (52.133.107.79) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Tue, 30 Apr 2019 10:03:08 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 10:03:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
	int64_t bytes parameter
Thread-Index: AQHU+dQTJjmZ8S/hNEmSdHPIyBb8w6ZUeWeAgAAKwAA=
Date: Tue, 30 Apr 2019 10:03:08 +0000
Message-ID: <4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<20190423125706.26989-3-vsementsov@virtuozzo.com>
	<20190430092437.jbecehdkqa4zdavd@steredhat>
In-Reply-To: <20190430092437.jbecehdkqa4zdavd@steredhat>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0002.eurprd07.prod.outlook.com
	(2603:10a6:7:67::12) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190430130306139
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ffd5b71-ab89-4dbb-abf0-08d6cd530bde
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4731; 
x-ms-traffictypediagnostic: PR2PR08MB4731:
x-microsoft-antispam-prvs: <PR2PR08MB47318843DF82C8E3342EF73DC13A0@PR2PR08MB4731.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(71190400001)(7736002)(305945005)(6486002)(14454004)(53936002)(8676002)(6506007)(386003)(99286004)(256004)(5660300002)(8936002)(26005)(6512007)(68736007)(229853002)(86362001)(14444005)(478600001)(71200400001)(6436002)(36756003)(102836004)(81166006)(81156014)(31696002)(446003)(2906002)(476003)(6246003)(186003)(2616005)(66066001)(52116002)(25786009)(31686004)(66446008)(6116002)(97736004)(316002)(64756008)(66556008)(66476007)(76176011)(54906003)(4326008)(3846002)(11346002)(66946007)(486006)(6916009)(73956011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4731;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JYbDCVYyIbjPLu462cMEh74ZbfVw8zudZyNiW5brIcKTo3Js8CpcKzNe3q7rCsYuZVZ3Et+yhKyhEdMp/YlWPqtltWxTcNuFk8pYSf2DLM2zdL2n35EuHyXirZjn7o4MCrNAVFqrETzBtdkx0tK575/pxouBjO3lvucgsiN1ghw4BAI1+ot8a8BOt4xZKwnrji8kZhyZwwbde2rXWcLoR2cegE07iuKZJ2A4pvZFkAKlylRmBltrGyCJhYsR3GRIM7en/ee46revHRKv2+cihqPhpk93j/9aQpztvHYYq9EkNaGVf0tOttVA4t/iPP03XKnNCJbb0nC1ddAxDo+JJxTSWx51Btp7qBZhWinSgcJjb0dRNu1VGo51PbPHJC+KwDlvYhp8ljil3r0zDw+M0O2UgkK97mt+5QIwh5Hox/w=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <0D5930E6165D1446B5843BC93F12F60C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffd5b71-ab89-4dbb-abf0-08d6cd530bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 10:03:08.7017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4731
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.132
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
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
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430100308.GXlW4SsMYCzLZxjUOHWLwnjQc-WhAzNTI1DfmHvkN-A@z>

MzAuMDQuMjAxOSAxMjoyNCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOg0KPiBPbiBUdWUsIEFw
ciAyMywgMjAxOSBhdCAwMzo1NzowNVBNICswMzAwLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IHdyb3RlOg0KPj4gVGhpcyBmaXhlcyBhdCBsZWFzdCBvbmUgb3ZlcmZsb3cgaW4gcWNvdzJf
cHJvY2Vzc19kaXNjYXJkcywgd2hpY2gNCj4+IHBhc3NlcyA2NGJpdCByZWdpb24gbGVuZ3RoIHRv
IGJkcnZfcGRpc2NhcmQgd2hlcmUgYnl0ZXMgKG9yIHNlY3RvcnMgaW4NCj4+IHRoZSBwYXN0KSBw
YXJhbWV0ZXIgaXMgaW50IHNpbmNlIGl0cyBpbnRyb2R1Y3Rpb24gaW4gMGI5MTlmYWUuDQo+Pg0K
Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNv
dkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvYmxvY2svYmxvY2suaCB8ICA0
ICsrLS0NCj4+ICAgYmxvY2svaW8uYyAgICAgICAgICAgIHwgMTYgKysrKysrKystLS0tLS0tLQ0K
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmggYi9pbmNsdWRlL2Jsb2Nr
L2Jsb2NrLmgNCj4+IGluZGV4IGM3YTI2MTk5YWEuLjY5ZmExODg2N2UgMTAwNjQ0DQo+PiAtLS0g
YS9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmgNCj4+ICsrKyBiL2luY2x1ZGUvYmxvY2svYmxvY2suaA0K
Pj4gQEAgLTQzMiw4ICs0MzIsOCBAQCB2b2lkIGJkcnZfZHJhaW5fYWxsKHZvaWQpOw0KPj4gICAg
ICAgQUlPX1dBSVRfV0hJTEUoYmRydl9nZXRfYWlvX2NvbnRleHQoYnNfKSwgICAgICAgICAgICAg
IFwNCj4+ICAgICAgICAgICAgICAgICAgICAgIGNvbmQpOyB9KQ0KPj4gICANCj4+IC1pbnQgYmRy
dl9wZGlzY2FyZChCZHJ2Q2hpbGQgKmNoaWxkLCBpbnQ2NF90IG9mZnNldCwgaW50IGJ5dGVzKTsN
Cj4+IC1pbnQgYmRydl9jb19wZGlzY2FyZChCZHJ2Q2hpbGQgKmNoaWxkLCBpbnQ2NF90IG9mZnNl
dCwgaW50IGJ5dGVzKTsNCj4+ICtpbnQgYmRydl9wZGlzY2FyZChCZHJ2Q2hpbGQgKmNoaWxkLCBp
bnQ2NF90IG9mZnNldCwgaW50NjRfdCBieXRlcyk7DQo+PiAraW50IGJkcnZfY29fcGRpc2NhcmQo
QmRydkNoaWxkICpjaGlsZCwgaW50NjRfdCBvZmZzZXQsIGludDY0X3QgYnl0ZXMpOw0KPj4gICBp
bnQgYmRydl9oYXNfemVyb19pbml0XzEoQmxvY2tEcml2ZXJTdGF0ZSAqYnMpOw0KPj4gICBpbnQg
YmRydl9oYXNfemVyb19pbml0KEJsb2NrRHJpdmVyU3RhdGUgKmJzKTsNCj4+ICAgYm9vbCBiZHJ2
X3VuYWxsb2NhdGVkX2Jsb2Nrc19hcmVfemVybyhCbG9ja0RyaXZlclN0YXRlICpicyk7DQo+PiBk
aWZmIC0tZ2l0IGEvYmxvY2svaW8uYyBiL2Jsb2NrL2lvLmMNCj4+IGluZGV4IGRmYzE1M2I4ZDgu
LjE2YjZjNWQ4NTUgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9pby5jDQo+PiArKysgYi9ibG9jay9p
by5jDQo+PiBAQCAtMjY1Myw3ICsyNjUzLDcgQEAgaW50IGJkcnZfZmx1c2goQmxvY2tEcml2ZXJT
dGF0ZSAqYnMpDQo+PiAgIHR5cGVkZWYgc3RydWN0IERpc2NhcmRDbyB7DQo+PiAgICAgICBCZHJ2
Q2hpbGQgKmNoaWxkOw0KPj4gICAgICAgaW50NjRfdCBvZmZzZXQ7DQo+PiAtICAgIGludCBieXRl
czsNCj4+ICsgICAgaW50NjRfdCBieXRlczsNCj4+ICAgICAgIGludCByZXQ7DQo+PiAgIH0gRGlz
Y2FyZENvOw0KPj4gICBzdGF0aWMgdm9pZCBjb3JvdXRpbmVfZm4gYmRydl9wZGlzY2FyZF9jb19l
bnRyeSh2b2lkICpvcGFxdWUpDQo+PiBAQCAtMjY2NCwxNCArMjY2NCwxNSBAQCBzdGF0aWMgdm9p
ZCBjb3JvdXRpbmVfZm4gYmRydl9wZGlzY2FyZF9jb19lbnRyeSh2b2lkICpvcGFxdWUpDQo+PiAg
ICAgICBhaW9fd2FpdF9raWNrKCk7DQo+PiAgIH0NCj4+ICAgDQo+PiAtaW50IGNvcm91dGluZV9m
biBiZHJ2X2NvX3BkaXNjYXJkKEJkcnZDaGlsZCAqY2hpbGQsIGludDY0X3Qgb2Zmc2V0LCBpbnQg
Ynl0ZXMpDQo+PiAraW50IGNvcm91dGluZV9mbiBiZHJ2X2NvX3BkaXNjYXJkKEJkcnZDaGlsZCAq
Y2hpbGQsIGludDY0X3Qgb2Zmc2V0LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQ2NF90IGJ5dGVzKQ0KPj4gICB7DQo+PiAgICAgICBCZHJ2VHJhY2tlZFJlcXVlc3Qg
cmVxOw0KPj4gICAgICAgaW50IG1heF9wZGlzY2FyZCwgcmV0Ow0KPj4gICAgICAgaW50IGhlYWQs
IHRhaWwsIGFsaWduOw0KPj4gICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYnMgPSBjaGlsZC0+YnM7
DQo+PiAgIA0KPj4gLSAgICBpZiAoIWJzIHx8ICFicy0+ZHJ2KSB7DQo+PiArICAgIGlmICghYnMg
fHwgIWJzLT5kcnYgfHwgIWJkcnZfaXNfaW5zZXJ0ZWQoYnMpKSB7DQo+IA0KPiBTaG91bGQgd2Ug
ZGVzY3JpYmUgdGhpcyBjaGFuZ2UgaW4gdGhlIGNvbW1pdCBtZXNzYWdlPw0KDQpIb25lc3RseSwg
ZG9uJ3Qgd2FudCB0byByZXNlbmQgdGhlIHNlcmllcyBmb3IgdGhpcy4NCg0KPiBJSVVDIHlvdSBh
ZGRlZCB0aGlzIGNoZWNrIGJlY2F1c2UgeW91IHJlbW92ZWQgYmRydl9jaGVja19ieXRlX3JlcXVl
c3QoKQ0KPiBiZWxvdywNCj4gDQo+IE1heWJlIHdlIGNhbiBhbHNvIHJlbW92ZSAnIWJzLT5kcnYn
LCBzaW5jZSBpdCBpcyBjaGVja2VkIGluDQo+IGJkcnZfaXNfaW5zZXJ0ZWQoKS4NCg0KSG1tLCBv
biB2NCBLZXZpbiBjb21tZW50ZWQsIHRoYXQgYmRydl9pc19pbnNlcnRlZCBub3QgbmVlZGVkLCBh
bmQsIGFzIEkgdW5kZXJzdGFuZCwgbm90IG9ubHkNCmluIGJkcnZfY29fcGRpc2NhcmQgaXQgc2hv
dWxkIGJlIHJlbW92ZWQsIGJ1dCBpdCBtYXkgYmUgZG9uZSBsYXRlci4gU28sIEknZCBwcmVmZXIg
dG8ga2VlcCBpdA0KYXMgaXMgZm9yIG5vdy4NCg0KPiANCj4+ICAgICAgICAgICByZXR1cm4gLUVO
T01FRElVTTsNCj4+ICAgICAgIH0NCj4+ICAgDQo+PiBAQCAtMjY3OSw5ICsyNjgwLDggQEAgaW50
IGNvcm91dGluZV9mbiBiZHJ2X2NvX3BkaXNjYXJkKEJkcnZDaGlsZCAqY2hpbGQsIGludDY0X3Qg
b2Zmc2V0LCBpbnQgYnl0ZXMpDQo+PiAgICAgICAgICAgcmV0dXJuIC1FUEVSTTsNCj4+ICAgICAg
IH0NCj4+ICAgDQo+PiAtICAgIHJldCA9IGJkcnZfY2hlY2tfYnl0ZV9yZXF1ZXN0KGJzLCBvZmZz
ZXQsIGJ5dGVzKTsNCj4+IC0gICAgaWYgKHJldCA8IDApIHsNCj4+IC0gICAgICAgIHJldHVybiBy
ZXQ7DQo+PiArICAgIGlmIChvZmZzZXQgPCAwIHx8IGJ5dGVzIDwgMCB8fCBieXRlcyA+IElOVDY0
X01BWCAtIG9mZnNldCkgew0KPj4gKyAgICAgICAgcmV0dXJuIC1FSU87DQo+PiAgICAgICB9DQo+
IA0KPiBTaG91bGQgd2UgY2hlY2sgaWYgJ2J5dGVzJyBpcyBncmVhdGVyIHRoYW4NCj4gJ0JEUlZf
UkVRVUVTVF9NQVhfU0VDVE9SUyA8PCBCRFJWX1NFQ1RPUl9CSVRTJz8NCj4gDQoNCk5vLCBhcyB3
ZSBhcmUgY29udHJhcml3aXNlIHRyeWluZyB0byBzdXBwb3J0IGxhcmdlIGJ5dGVzIHBhcmFtZXRl
ciBpbiBiZHJ2X2NvX3BkaXNjYXJkLCB3aGljaCB3aWxsDQpleGNlZWQgbWF4IHJlcXVlc3QuIElm
IEBieXRlcyBpcyBsYXJnZSwgaXQgd2lsbCBiZSBkaXZpZGVkIGludG8gc2V2ZXJhbCBzbWFsbGVy
IHJlcXVlc3RzIGluIHRoZQ0KZm9sbG93aW5nIGxvb3AuDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

