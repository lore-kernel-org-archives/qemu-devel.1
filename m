Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F400C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4404520857
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 07:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TuY7KSNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4404520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60602 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGIWn-0005Fp-Js
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 03:29:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGIVy-0004wA-VO
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGIVx-0007lm-V9
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:28:22 -0400
Received: from mail-eopbgr140097.outbound.protection.outlook.com
	([40.107.14.97]:46145
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hGIVv-0007jS-GP; Tue, 16 Apr 2019 03:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Bl7cod1+KPYDXCecKoDF8og+6Tx7Kwb3u+jTwq+W4aw=;
	b=TuY7KSNzX33PUxJ6im+AqGrcFyaLe/YrT98O50R5LrHaF2ZWotFQ8wp7YJCGHTtlBXag629Qxz7Yek4w3/HwOiyoRnhOLiADaiyq0UQXQCjsvwbjtE5tbOIAE/L5zFQTqeTR+BiKuXinzDbT4KsilNkOZS+aQr5U+3Qu419bbDo=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3243.eurprd08.prod.outlook.com (52.134.111.17) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.17; Tue, 16 Apr 2019 07:28:14 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Tue, 16 Apr 2019 07:28:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 00/10] qcow2: encryption threads
Thread-Index: AQHU6WoB+NIZnh166UOvlio9dNC4LKY+eQ+A
Date: Tue, 16 Apr 2019 07:28:14 +0000
Message-ID: <40daf835-2481-e11e-dcdb-421f7063c566@virtuozzo.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190402153730.54145-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0012.EURP189.PROD.OUTLOOK.COM
	(2603:10a6:3:8b::22) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190416102811692
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dd2a933-86a7-45d5-0d54-08d6c23d164d
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DB7PR08MB3243; 
x-ms-traffictypediagnostic: DB7PR08MB3243:
x-microsoft-antispam-prvs: <DB7PR08MB3243C8D9EB13F2349BB9C2D6C1240@DB7PR08MB3243.eurprd08.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(39840400004)(396003)(136003)(366004)(376002)(199004)(189003)(478600001)(81166006)(68736007)(81156014)(52116002)(2906002)(106356001)(6436002)(76176011)(25786009)(105586002)(71190400001)(66066001)(256004)(97736004)(8676002)(6246003)(14444005)(36756003)(3846002)(6116002)(31696002)(53936002)(4326008)(8936002)(86362001)(71200400001)(305945005)(7736002)(6512007)(446003)(5660300002)(476003)(11346002)(2616005)(486006)(102836004)(386003)(316002)(14454004)(229853002)(31686004)(110136005)(186003)(26005)(6506007)(54906003)(2501003)(99286004)(6486002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3243;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 58hvzVFCspPHl0wgS4eqCVzUJiGpHh5OkYLwR64elUM0Buznbw96wOW7MVbq4OuI0VQ/FBmwEwPppRvNK+T0SGB3jGzSUTBRrOUQe5QqZzYU/+0EGt2HvybJ/q933bp7wUG76QvDdSkNRMvKW/Qm65YZ+w7g2VcDKMdK8Qm5SWwhpUqD+kTYJrdOuny/UoncZaQ8oew0OUITYPYxc6tbd9wZ2BgSRb3efPYr7QImtBR/1muqQDUxF2+UiZ6HAAdj6nyhctaCNHKl1WwzQw5S5/dR1c+xEujgMt2ZKaFpliU0HlSN/XqVG60j3GWqNumX3WTNFIXWZ3Zv6gO27ByVelbxUZNN5Lxnfn2uT7zzzZMAKCKzSD2Rcz+nuW7hrcdQBY3M7kQoxhTKJnnHM+wLJzRHbjWUqP4hJTEdT3gmYq0=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <A8F2CFE192A966479E1F3B7823C497BF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd2a933-86a7-45d5-0d54-08d6c23d164d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 07:28:14.5498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3243
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.97
Subject: Re: [Qemu-devel] [PATCH v5 00/10] qcow2: encryption threads
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
	"berto@igalia.com" <berto@igalia.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416072814.eTl0l0RCd2xMhZCQQscWymRfc6o5Swm78-0MyrbJ6Y8@z>

cGluZw0KDQowMi4wNC4yMDE5IDE4OjM3LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiB2NTogcmViYXNlIG9uIG1hc3Rlciwgc29tZSBjb25mbGljdHMgcmVzb2x2ZWQgZHVl
IHRvIGRhdGEtZmlsZSBmZWF0dXJlDQo+IA0KPiAwMTogbmV3IHBhdGNoLCBqdXN0IG1vdmUgdGVz
dCBmcm9tIGNvdmVyIGxldHRlciB0byBhIGZpbGUuIEkgcmVhbGx5IGhvcGUgdGhhdCBpdA0KPiAg
ICAgIHdpbGwgbm90IGhhbmcgdGhlIHdob2xlIHNlcmllcywgc28sIGlmIHdlIGRvbid0IHdhbnQg
aXQgYXMgaXMgb3Igd2l0aCByZWFsbHkNCj4gICAgICB0aW55IGltcHJvdmVtZW50cywgSSdkIHBy
ZWZlciB0byBza2lwIGl0IGFuZCBxdWV1ZSAwMi0xMCBmaXJzdC4NCj4gMDk6ICJ0cnVlIiBwYXJh
bWV0ZXIgYWRkZWQgdG8gbW92ZWQgcWNvdzJfcHJlX3dyaXRlX292ZXJsYXBfY2hlY2soKSBjYWxs
IGR1ZSB0bw0KPiAgICAgIHJlYmFzZSBvbiBtYXN0ZXIgKGJvdGggYmVmb3JlIGFuZCBhZnRlciBw
YXRjaCkuIFNlZW1zIE9LLCBzbyBrZWVwIEFsYmVydG8ncyByLWIuDQo+IA0KPiBwZXJmb3JtYW5j
ZToNCj4gDQo+IGFmdGVyIDAxOg0KPiAgICMgLi90ZXN0cy9wZXJmL2Jsb2NrL3Fjb3cyL2NvbnZl
cnQtdG8tZW5jcnlwdGVkIC9zc2Qvc3JjLnJhdyAvc3NkL2RzdC5lbmMucWNvdzINCj4gMTQuMTgN
Cj4gICAjIC4vdGVzdHMvcGVyZi9ibG9jay9xY293Mi9jb252ZXJ0LXRvLWVuY3J5cHRlZCAvc3Nk
L3NyYy5yYXcgL3NzZC9kc3QuZW5jLnFjb3cyIC1XDQo+IDEzLjc3DQo+IA0KPiBhZnRlciAxMDoN
Cj4gICAjIC4vdGVzdHMvcGVyZi9ibG9jay9xY293Mi9jb252ZXJ0LXRvLWVuY3J5cHRlZCAvc3Nk
L3NyYy5yYXcgL3NzZC9kc3QuZW5jLnFjb3cyDQo+IDE0LjM1DQo+ICAgIyAuL3Rlc3RzL3BlcmYv
YmxvY2svcWNvdzIvY29udmVydC10by1lbmNyeXB0ZWQgL3NzZC9zcmMucmF3IC9zc2QvZHN0LmVu
Yy5xY293MiAtVw0KPiA1LjYyDQo+IA0KPiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICgx
MCk6DQo+ICAgIHRlc3RzL3BlcmY6IFRlc3QgcWVtdS1pbWcgY29udmVydCBmcm9tIHJhdyB0byBl
bmNyeXB0ZWQgcWNvdzINCj4gICAgcWNvdzIuaDogYWRkIG1pc3NpbmcgaW5jbHVkZQ0KPiAgICBx
Y293MjogYWRkIHNlcGFyYXRlIGZpbGUgZm9yIHRocmVhZGVkIGRhdGEgcHJvY2Vzc2luZyBmdW5j
dGlvbnMNCj4gICAgcWNvdzItdGhyZWFkczogdXNlIHRocmVhZF9wb29sX3N1Ym1pdF9jbw0KPiAg
ICBxY293Mi10aHJlYWRzOiBxY293Ml9jb19kb19jb21wcmVzczogcHJvdGVjdCBxdWV1aW5nIGJ5
IG11dGV4DQo+ICAgIHFjb3cyLXRocmVhZHM6IHNwbGl0IG91dCBnZW5lcmljIHBhdGgNCj4gICAg
cWNvdzI6IHFjb3cyX2NvX3ByZWFkdjogaW1wcm92ZSBsb2NraW5nDQo+ICAgIHFjb3cyOiBxY293
Ml9jb19wcmVhZHY6IHNraXAgdXNpbmcgaGRfcWlvdiB3aGVuIHBvc3NpYmxlDQo+ICAgIHFjb3cy
OiBiZHJ2X2NvX3B3cml0ZXY6IG1vdmUgZW5jcnlwdGlvbiBjb2RlIG91dCBvZiB0aGUgbG9jaw0K
PiAgICBxY293MjogZG8gZW5jcnlwdGlvbiBpbiB0aHJlYWRzDQo+IA0KPiAgIGJsb2NrL3Fjb3cy
LmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjAgKy0NCj4gICBibG9jay9xY293
Mi1iaXRtYXAuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxIC0NCj4gICBibG9jay9xY293
Mi1jYWNoZS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxIC0NCj4gICBibG9jay9xY293
Mi1jbHVzdGVyLmMgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICstDQo+ICAgYmxvY2svcWNv
dzItcmVmY291bnQuYyAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAtDQo+ICAgYmxvY2svcWNv
dzItc25hcHNob3QuYyAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAtDQo+ICAgYmxvY2svcWNv
dzItdGhyZWFkcy5jICAgICAgICAgICAgICAgICAgICAgICB8IDI2OCArKysrKysrKysrKysrKysr
KysrDQo+ICAgYmxvY2svcWNvdzIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDI3
NSArKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGJsb2NrL01ha2VmaWxlLm9ianMgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gICB0ZXN0cy9wZXJmL2Jsb2NrL3Fjb3cyL2NvbnZl
cnQtdG8tZW5jcnlwdGVkIHwgIDQ4ICsrKysNCj4gICAxMCBmaWxlcyBjaGFuZ2VkLCAzODkgaW5z
ZXJ0aW9ucygrKSwgMjM2IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBibG9j
ay9xY293Mi10aHJlYWRzLmMNCj4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvcGVyZi9ibG9j
ay9xY293Mi9jb252ZXJ0LXRvLWVuY3J5cHRlZA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=

