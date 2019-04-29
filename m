Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61653C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 04:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274572087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 04:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="M0+5Jt8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274572087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKyIa-0006eO-Ec
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 00:53:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hKyHN-0005wU-4V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 00:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hKy8E-0004Ae-J8
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 00:43:12 -0400
Received: from mail-eopbgr120131.outbound.protection.outlook.com
	([40.107.12.131]:36095
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hKy8E-0004AA-27
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 00:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=iS0fGSYXDq2cz27uTYQf7O3KhpaZI0P/KP7c0wbux7M=;
	b=M0+5Jt8ItlXFAw1CKbwWsOuO2oZB8g4+M7oTHLrSazXVsCUNlpF9q2hSamRD8jDxqopyxaVGx8rXDUXEPkJWTy/D9/ubwUUokkF7I3SAKrYgSl7fcG+KR8dphf7rCqON0yD/i5oxM7XtMYD4EkGT/yJ4YXCDZK6jfHCIHL2AUbU=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4905.eurprd08.prod.outlook.com (52.133.108.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Mon, 29 Apr 2019 04:43:06 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Mon, 29 Apr 2019 04:43:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Thread-Topic: [PATCH] trace: fix runstate tracing
Thread-Index: AQHU/BnM0hnfPx/fNEyBHjg8M7/yw6ZSk9wA
Date: Mon, 29 Apr 2019 04:43:06 +0000
Message-ID: <79d19dc9-f312-bb19-3895-781e48e21056@virtuozzo.com>
References: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
In-Reply-To: <20190426102115.30002-1-yury-kotov@yandex-team.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR02CA0097.eurprd02.prod.outlook.com
	(2603:10a6:7:29::26) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190429074304026
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 594b1232-d071-4666-81d8-08d6cc5d2bd5
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4905; 
x-ms-traffictypediagnostic: PR2PR08MB4905:
x-microsoft-antispam-prvs: <PR2PR08MB4905D30E7CA311C3BD2C6A9BC1390@PR2PR08MB4905.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(396003)(346002)(39830400003)(136003)(199004)(189003)(6436002)(6512007)(97736004)(66946007)(53936002)(26005)(66446008)(66476007)(66556008)(6506007)(186003)(229853002)(66066001)(6486002)(386003)(31696002)(4744005)(305945005)(478600001)(7736002)(64756008)(73956011)(86362001)(486006)(2616005)(11346002)(102836004)(476003)(71190400001)(71200400001)(14454004)(446003)(8936002)(81166006)(81156014)(8676002)(6116002)(99286004)(76176011)(316002)(31686004)(3846002)(110136005)(6246003)(36756003)(68736007)(256004)(14444005)(2906002)(52116002)(25786009)(4326008)(5660300002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4905;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fYICsibXRvRxbHxjdZX8qv4rCGJTuYM+Cv8GNJ13qmtGRt3mzaMNuycDslL26HbXOTu+wnUbI2brBJT4ivAZlhr/vgaGM04TxuB8FuI5LRWEFbiD1/cSHAm48ki/DntKuXgeLM6QaOb1gG1TcGg3oQ+GyrdXUpryaomnZyAtrrbTHsbrNXbMsIOuxaJVjodgkJf/+8qxrSNeOC6A9gyx5oZLBoF3xgc6+wk/rLq+/zJIhIy4/MeFi3f0/J0EgJQMw6s/2BacQ/zFfkoORvnd1aXTCgwp7RmIJZvbKwC3miB/RAWaXGfgXu6Kby7SBk8eQ2EUxc5iMjzOLOHvy57k0x6exRLmnQlASPWHGZ8x/irhLJdtdz9OON5IfvNEeSpKFS5H8XumGjyS0MvRMVhf5p0qj0yakP0DGhs5Pk+MtRY=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <CBBD6E7B70AB8743A18F514BBC486E35@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594b1232-d071-4666-81d8-08d6cc5d2bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 04:43:06.2884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4905
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.131
Subject: Re: [Qemu-devel] [PATCH] trace: fix runstate tracing
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429044306.HjIs_nanmnFNQeu_NizPrLoFz_XczV0j1ZBh0IC2Mxw@z>

T29wcywgbXkgZmF1bHQsIHNvcnJ5OiggVGhhbmsgeW91IGZvciBmaXhpbmchDQoNCk1heSBiZSBh
ZGRlZCwgdGhhdCBpdCBpcyBicm9rZW4gc2luY2UgZmYxMmUzYWUzZDAuDQoNClJldmlld2VkLWJ5
OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5jb20+
DQoNCjI2LjA0LjIwMTkgMTM6MjEsIFl1cnkgS290b3Ygd3JvdGU6DQo+IFNpZ25lZC1vZmYtYnk6
IFl1cnkgS290b3YgPHl1cnkta290b3ZAeWFuZGV4LXRlYW0ucnU+DQo+IC0tLQ0KPiAgIHZsLmMg
fCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdmwuYyBiL3ZsLmMNCj4gaW5kZXggZmY1ZGZiNmZiYy4uYWQ5
YjE4MWU1NyAxMDA2NDQNCj4gLS0tIGEvdmwuYw0KPiArKysgYi92bC5jDQo+IEBAIC03MjUsNyAr
NzI1LDcgQEAgdm9pZCBydW5zdGF0ZV9zZXQoUnVuU3RhdGUgbmV3X3N0YXRlKQ0KPiAgICAgICBh
c3NlcnQobmV3X3N0YXRlIDwgUlVOX1NUQVRFX19NQVgpOw0KPiAgIA0KPiAgICAgICB0cmFjZV9y
dW5zdGF0ZV9zZXQoY3VycmVudF9ydW5fc3RhdGUsIFJ1blN0YXRlX3N0cihjdXJyZW50X3J1bl9z
dGF0ZSksDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIG5ld19zdGF0ZSwgUnVuU3RhdGVfc3Ry
KGN1cnJlbnRfcnVuX3N0YXRlKSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG5ld19zdGF0
ZSwgUnVuU3RhdGVfc3RyKG5ld19zdGF0ZSkpOw0KPiAgIA0KPiAgICAgICBpZiAoY3VycmVudF9y
dW5fc3RhdGUgPT0gbmV3X3N0YXRlKSB7DQo+ICAgICAgICAgICByZXR1cm47DQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

