Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090A8C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A552080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Dfm3haRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4A552080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPN3-000221-2H
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:48:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLPLq-0001OM-Tc
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLPLo-0007Tz-PU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:47:02 -0400
Received: from mail-pr2fra01on070b.outbound.protection.outlook.com
	([2a01:111:f400:7e18::70b]:23236
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hLPLk-0007MW-1O; Tue, 30 Apr 2019 05:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Y/P0pUjFZmGVNigUGNW3p8UMZpdEnF5Kw+r+oTpMVC0=;
	b=Dfm3haRGZf698Nk5hqy4SoSw+p0K6RE6sv6yGKGxlbHrccH/uZvFY6MM8t1ObFsaP5ckrL0Qp7oxUNOiQ1Z5JIDoWcBA7pv93f9zK3Vk8tjqzaW+PuQkvyFL+yuyWSAOGOcQKMVVbln1endULy6RHNoX7cs1HhwEZquRHkyMya0=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4778.eurprd08.prod.outlook.com (52.133.109.144) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.15; Tue, 30 Apr 2019 09:46:52 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 09:46:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH 0/9] block: buffer-based io
Thread-Index: AQHU+RviZ5ABO6SIx0WfOA0ibhwB5qZUfrYAgAACVYA=
Date: Tue, 30 Apr 2019 09:46:51 +0000
Message-ID: <808ccd2e-56ae-f1c9-3361-efd416ad2465@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
	<20190430093828.gu3b7yjyh447qw6j@steredhat>
In-Reply-To: <20190430093828.gu3b7yjyh447qw6j@steredhat>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::20)
	To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190430124649776
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdcd303e-b931-42fe-8809-08d6cd50c5b5
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4778; 
x-ms-traffictypediagnostic: PR2PR08MB4778:
x-microsoft-antispam-prvs: <PR2PR08MB47782918A24ED671A26784F7C13A0@PR2PR08MB4778.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(396003)(39850400004)(136003)(346002)(376002)(189003)(53754006)(199004)(64756008)(229853002)(68736007)(66446008)(3846002)(66946007)(36756003)(97736004)(66556008)(7736002)(73956011)(6116002)(81166006)(71190400001)(305945005)(486006)(66476007)(71200400001)(8936002)(81156014)(2906002)(6436002)(6486002)(5660300002)(8676002)(53936002)(66066001)(31696002)(14454004)(476003)(11346002)(186003)(4326008)(478600001)(316002)(2616005)(446003)(6916009)(86362001)(52116002)(386003)(31686004)(6512007)(6506007)(25786009)(99286004)(102836004)(76176011)(6246003)(54906003)(26005)(256004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4778;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vD6aMBYIUBSblvIwNIaiWMPLlEvqYKyUz3esWPalASI0lNxKjO9p8miITuP9SzHEVXFX8wZw1BPHV/K5IFIxJa1/sx7vM5jtvW+U717u4nheC1OUQzTeJLzF4MoBCjcyaWejiCv/qOzxKZURfx39kpR3h8pNuUfBLkRIjmHKDLj+8nJMHb7lsb7ZpRJnaTPWCkqifg+TtZykoixCNauCE/fkAk6tVHha9bg5yhUAN+S971q6FMtTi/ehrMvBw+jNsKlvznNuw1QHOYnX501NPacZ0DGfmURZyyCIb0Pegag4+I9BsS1+lhNy73QxZ1GWa1croVeVc76RCikR7o/RFbncqlr+X4FXVvTwbXYKei0jBsSzcnXSWdo2rWIXD9aZnbSVUkjYeNrmO3Ag2pYNHsjtWKwuumfxhDr29ezEnls=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <5CD7D38E64157D46868DFDADBCF63A2A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcd303e-b931-42fe-8809-08d6cd50c5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 09:46:51.9861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4778
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:7e18::70b
Subject: Re: [Qemu-devel] [PATCH 0/9] block: buffer-based io
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
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430094651.dsPZ2ErFzaRu7ZoUJoNTK4Q4EtOZhcEc4IZf0vWhfDo@z>

MzAuMDQuMjAxOSAxMjozOCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOg0KPiBPbiBNb24sIEFw
ciAyMiwgMjAxOSBhdCAwNTo1ODoyOVBNICswMzAwLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IHdyb3RlOg0KPj4gSGkgYWxsIQ0KPj4NCj4+IFdlIG9mdGVuIG5lZWQgdG8gZG8gcmVhZC93
cml0ZSB3aXRoIGJ1ZmZlciwgbm90IHFpb3YuIEluc3RlYWQgb2YNCj4+IGNyZWF0aW5nIHFpb3Yg
aW4gc3VjaCBjYXNlcywgbGV0J3MgaW50cm9kdWNlIGNvcnJlc3BvbmRpbmcgaGVscGVycy4NCj4+
DQo+PiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICg5KToNCj4+ICAgIGJsb2NrOiBpbnRy
b2R1Y2UgYnl0ZS1iYXNlZCBpbyBoZWxwZXJzDQo+PiAgICBibG9jay9xY293MjogdXNlIGJ1ZmZl
ci1iYXNlZCBpbw0KPj4gICAgYmxvY2svcWNvdzogdXNlIGJ1ZmZlci1iYXNlZCBpbw0KPj4gICAg
YmxvY2svcWVkOiB1c2UgYnVmZmVyLWJhc2VkIGlvDQo+PiAgICBibG9jay9wYXJhbGxlbHM6IHVz
ZSBidWZmZXItYmFzZWQgaW8NCj4+ICAgIGJsb2NrL2JhY2t1cDogdXNlIGJ1ZmZlci1iYXNlZCBp
bw0KPj4gICAgYmxvY2svY29tbWl0OiB1c2UgYnVmZmVyLWJhc2VkIGlvDQo+PiAgICBibG9jay9z
dHJlYW06IHVzZSBidWZmZXItYmFzZWQgaW8NCj4+ICAgIHFlbXUtaW1nOiB1c2UgYnVmZmVyLWJh
c2VkIGlvDQo+Pg0KPj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oICAgICAgfCAxNiArKysr
KysrKysrKysrKysrDQo+PiAgIGluY2x1ZGUvc3lzZW11L2Jsb2NrLWJhY2tlbmQuaCB8IDE5ICsr
KysrKysrKysrKysrKysrKysNCj4+ICAgYmxvY2svYmFja3VwLmMgICAgICAgICAgICAgICAgIHwg
MTQgKysrKysrLS0tLS0tLS0NCj4+ICAgYmxvY2svY29tbWl0LmMgICAgICAgICAgICAgICAgIHwg
IDUgKystLS0NCj4+ICAgYmxvY2svcGFyYWxsZWxzLmMgICAgICAgICAgICAgIHwgMTQgKysrKysr
LS0tLS0tLS0NCj4+ICAgYmxvY2svcWNvdy5jICAgICAgICAgICAgICAgICAgIHwgMTkgKysrKysr
LS0tLS0tLS0tLS0tLQ0KPj4gICBibG9jay9xY293Mi5jICAgICAgICAgICAgICAgICAgfCAgOSAr
Ky0tLS0tLS0NCj4+ICAgYmxvY2svcWVkLXRhYmxlLmMgICAgICAgICAgICAgIHwgMTIgKysrKyst
LS0tLS0tDQo+PiAgIGJsb2NrL3FlZC5jICAgICAgICAgICAgICAgICAgICB8ICA2ICsrLS0tLQ0K
Pj4gICBibG9jay9zdHJlYW0uYyAgICAgICAgICAgICAgICAgfCAgNCArLS0tDQo+PiAgIHFlbXUt
aW1nLmMgICAgICAgICAgICAgICAgICAgICB8IDEzICsrKystLS0tLS0tLS0NCj4+ICAgMTEgZmls
ZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKSwgNjIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gLS0g
DQo+PiAyLjE4LjANCj4+DQo+IA0KPiBUaGUgc2VyaWVzIExHVE0gYW5kIG5ldyBoZWxwZXJzIGNv
dWxkIGJlIHZlcnkgdXNlZnVsIQ0KPiANCj4gUmV2aWV3ZWQtYnk6IFN0ZWZhbm8gR2FyemFyZWxs
YSA8c2dhcnphcmVAcmVkaGF0LmNvbT4NCj4gDQoNClRoYW5rcyENCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

