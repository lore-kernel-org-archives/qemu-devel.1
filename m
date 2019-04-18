Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CCCC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 17:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA0E2171F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 17:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P4Kz3XGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA0E2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44537 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHAVr-0000oS-Ew
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 13:07:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHASa-0007AH-Qh
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hHAOk-0005iu-Nx
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 13:00:31 -0400
Received: from mail-eopbgr50138.outbound.protection.outlook.com
	([40.107.5.138]:28733
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hHAOi-0005ct-L8; Thu, 18 Apr 2019 13:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=wqvg7JdjUOMvLhAUkgyBuD4UUo+kvBc6GdA9f+vI0x4=;
	b=P4Kz3XGldIHAkzrl+8GLv360+vQADyerVwMYThvRhiN1R53dmiELou4uXp9punjuJehJDdoAPqF27GnB6VZ0DGr8cQvFDjR3jAh1bgk+uRY54/jOyvfmy+EZn3e/uDzjlXeF1urn+9dwr3lFE2vCVMErQnwkjL30asVjfHzlZI8=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3050.eurprd08.prod.outlook.com (52.134.110.16) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Thu, 18 Apr 2019 17:00:20 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Thu, 18 Apr 2019 17:00:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 0/3] qemu-img: Allow rebase with no input
	base
Thread-Index: AQHU8hOZBPDFXraAfkSD/PJ5F8DVG6ZCLD6A
Date: Thu, 18 Apr 2019 17:00:20 +0000
Message-ID: <c3f01ebe-37f7-d1d8-8bcd-45df37d80ff6@virtuozzo.com>
References: <20180713111424.23670-1-mreitz@redhat.com>
	<9afddacb-ca54-6ac3-1c02-b8916a08fcd3@redhat.com>
In-Reply-To: <9afddacb-ca54-6ac3-1c02-b8916a08fcd3@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0149.eurprd05.prod.outlook.com
	(2603:10a6:7:28::36) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190418200017821
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94676120-24a8-41c6-bf7c-08d6c41f56bd
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3050; 
x-ms-traffictypediagnostic: DB7PR08MB3050:
x-microsoft-antispam-prvs: <DB7PR08MB30504D12AF1593199A8B505FC1260@DB7PR08MB3050.eurprd08.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(136003)(346002)(366004)(396003)(376002)(199004)(189003)(52116002)(54906003)(36756003)(31696002)(2616005)(97736004)(53936002)(26005)(476003)(2906002)(3846002)(186003)(68736007)(25786009)(102836004)(6246003)(316002)(53546011)(6436002)(256004)(110136005)(386003)(6506007)(2501003)(8936002)(31686004)(4326008)(76176011)(6486002)(7736002)(478600001)(8676002)(5660300002)(229853002)(81156014)(81166006)(305945005)(14454004)(71200400001)(71190400001)(446003)(11346002)(86362001)(99286004)(6116002)(66066001)(486006)(6512007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3050;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JVihT/WH9CNgQwbZPiSFj1XfncsoqUISSVcqt4lJWpoYKvwskZQu0hd7MPT55rLUa/zMLFTsR5r+O+4lB3QdrTPXYHUCgRpuevboEsKgrA+BwgReU4TirUrGyHqPzWV4biTVWdrjb4JSeNhXaLOM3a2IzHbVjvuzpzjul/2eBonLbK+9ksRqFaIl1OoKY/HfnCcDJhJRQBz3FpHNiBMDjVUVFOFvAQo8XAbBy54SmuBJ6dsNPeCGyS89k5UXw0ajeN6/jzpn+8y81vxN28S30VTwE6hOs/xXTSD/QcE/zRWOzQU3f1n+uJ08wsBOEJek3JLjjngNA7ixJBBNZOkcgytd6miMEBeOVBDnUqBgXGlUll36lkvbqeYVFKX830Lm08tYwoDx3UGjpWaS9qMkVHwI7Gu5ohrmsV7c/4LIdzw=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <BA4895436BFCD94996182B50876BEBE2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94676120-24a8-41c6-bf7c-08d6c41f56bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 17:00:20.1652 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.138
Subject: Re: [Qemu-devel] [PATCH 0/3] qemu-img: Allow rebase with no input
 base
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418170020.e-r9D_QX6JQExqEdWg1tEWpTqzf9_ELd6ca8is667ig@z>

MTMuMDQuMjAxOSAxOToxMSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBQaW5nIGFnYWluDQo+IA0KPiAo
SSBmZWVsIGxpa2UgSSBqdXN0IG5lZWQgdG8gc3RhcnQgbWVyZ2luZyB1bnJldmlld2VkIHBhdGNo
ZXMgdW50aWwgSQ0KPiBicmVhayBzb21ldGhpbmcgKGNhbid0IHRha2UgdGhhdCBsb25nKSBzbyB5
b3UgZ2V0IHNvIHNjYXJlZCBvZiBteQ0KPiBwYXRjaGVzIHRoYXQgeW91IGF0IGxlYXN0IHJlZnVz
ZSB0aGVtIG91dHJpZ2h0KQ0KDQpDb3VsZCB5b3UgcmVzZW5kIGJlZm9yZT8NCg0KPiANCj4gT24g
MTMuMDcuMTggMTM6MTQsIE1heCBSZWl0eiB3cm90ZToNCj4+IFRoaXMgc2VyaWVzIGFsbG93cyB1
c2luZyBxZW11LWltZyByZWJhc2Ugb24gaW1hZ2VzIHRoYXQgZG8gbm90IGhhdmUgYQ0KPj4gYmFj
a2luZyBmaWxlLiAgUmlnaHQgbm93LCB0aGlzIGZhaWxzIHdpdGggdGhlIHJhdGhlciBjcnlwdGlj
IGVycm9yDQo+PiBtZXNzYWdlOg0KPj4NCj4+ICQgcWVtdS1pbWcgcmViYXNlIC1iIGJhc2UucWNv
dzIgZm9vLnFjb3cyDQo+PiBxZW11LWltZzogQ291bGQgbm90IG9wZW4gb2xkIGJhY2tpbmcgZmls
ZSAnJzogVGhlICdmaWxlJyBibG9jayBkcml2ZXIgcmVxdWlyZXMgYSBmaWxlIG5hbWUNCj4+DQo+
PiBZZWFoLCB3ZWxsLCBPSy4NCj4+DQo+PiBXaXRoIGhvdyByZWJhc2UgY3VycmVudGx5IHdvcmtz
LCB0aGlzIHdvdWxkIGxlYWQgdG8gdGhlIG92ZXJsYXkgYmVpbmcNCj4+IGZpbGxlZCB3aXRoIHpl
cm9lcywgaG93ZXZlci4gIFRoaXMgaXMgd2hlcmUgcGF0Y2ggMiBjb21lcyBpbiBhbmQgaW5zdGVh
ZA0KPj4gbWFrZXMgcmViYXNlIHVzZSBibGtfcHdyaXRlX3plcm9lcygpIHdoZW5ldmVyIGl0IGhh
bmRsZXMgYW4gYXJlYSBwYXN0DQo+PiB0aGUgaW5wdXTigJlzIGJhY2tpbmcgZmlsZeKAmXMgRU9G
Lg0KPj4NCj4+IChOb3RlIHRoYXQgYWRkaXRpb25hbGx5IHdlIGNvdWxkIHRyeSB0byBwdW5jaCBo
b2xlcyBpbiB0aGUgb3ZlcmxheQ0KPj4gd2hlbmV2ZXIgaXQgbWF0Y2hlcyB0aGUgbmV3IGJhY2tp
bmcgZmlsZSwgYnV0IHRoYXTigJlzIHNvbWV0aGluZyBJ4oCZbGwgcHV0DQo+PiBvZmYgZm9yIGxh
dGVyLiAgKFdlIGRvbuKAmXQgZXZlbiBoYXZlIGEgcmVsaWFibGUgbWV0aG9kIGZvciBwdW5jaGlu
ZyBob2xlcw0KPj4gaW50byBhbiBvdmVybGF5IHlldCwgYWx0aG91Z2ggSSB3b3VsZCBsaWtlIHRv
IGhhdmUgc3VjaCBiZWNhdXNlIGl0IGNvdWxkDQo+PiBtYWtlIGFjdGl2ZSBjb21taXQgbW9yZSBl
ZmZpY2llbnQuKSkNCj4+DQo+Pg0KPj4gQW5kIHBhdGNoIDMgYWRkcyB0aGUgdXN1YWwgdGVzdC4N
Cj4+DQo+Pg0KPj4gTWF4IFJlaXR6ICgzKToNCj4+ICAgIHFlbXUtaW1nOiBBbGxvdyByZWJhc2Ug
d2l0aCBubyBpbnB1dCBiYXNlDQo+PiAgICBxZW11LWltZzogVXNlIHplcm8gd3JpdGVzIGFmdGVy
IHNvdXJjZSBiYWNraW5nIEVPRg0KPj4gICAgaW90ZXN0czogQWRkIHRlc3QgZm9yIHJlYmFzZSB3
aXRob3V0IGlucHV0IGJhc2UNCj4+DQo+PiAgIHFlbXUtaW1nLmMgICAgICAgICAgICAgICAgIHwg
NzIgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4+ICAgdGVzdHMvcWVt
dS1pb3Rlc3RzLzAyNCAgICAgfCA3MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzAyNC5vdXQgfCAzNyArKysrKysrKysrKysrKysr
KysrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDE1MCBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlv
bnMoLSkNCj4+DQo+IA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

