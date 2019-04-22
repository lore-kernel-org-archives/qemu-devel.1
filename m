Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4352DC10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 10:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7EF520811
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 10:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UhcZvFK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7EF520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIVkI-0008E9-WB
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 06:00:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIVj6-0007eq-9W
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 05:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIVj4-0005UG-JZ
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 05:59:04 -0400
Received: from mail-eopbgr60131.outbound.protection.outlook.com
	([40.107.6.131]:46279
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hIViz-0005RJ-C9; Mon, 22 Apr 2019 05:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=WX8a0xOHWUq7Omag+tpeNn5cyC5WAkEF1ChdlGmGJ8A=;
	b=UhcZvFK62WL7vnjmG+4UG4O0WzB6EkJn7NrFW5rycYWX8wH/yt8C7RKlnICFVIoF9Hzb5//MewjY1R+Tym968sz+wiGJPv1LMJz3THhEnpon4fELTIkoOAsMNfQGCipKNHlHq5Jsh6KIP7Oocv3fowrlWvxAelUQBn1G+KGTxmo=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3514.eurprd08.prod.outlook.com (20.177.120.76) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Mon, 22 Apr 2019 09:58:39 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1813.017;
	Mon, 22 Apr 2019 09:58:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 for 4.1 0/2] avoid lseek on block_status
Thread-Index: AQHU7ifR38W67XMkcUq/V5mfMlS/raZIB5UA
Date: Mon, 22 Apr 2019 09:58:38 +0000
Message-ID: <2bd2faa2-adeb-924f-656b-bdce6cd5d164@virtuozzo.com>
References: <20190408162617.258535-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190408162617.258535-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0147.eurprd05.prod.outlook.com
	(2603:10a6:7:28::34) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190422125834247
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bfd83ce-c2a4-44f1-4c75-08d6c709168e
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3514; 
x-ms-traffictypediagnostic: DB7PR08MB3514:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR08MB35147AD4EB44AD9E04437662C1220@DB7PR08MB3514.eurprd08.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(396003)(376002)(39840400004)(346002)(199004)(189003)(26005)(86362001)(102836004)(31696002)(2501003)(76176011)(6512007)(256004)(6506007)(186003)(31686004)(386003)(53936002)(6246003)(966005)(6306002)(68736007)(478600001)(8936002)(107886003)(71190400001)(71200400001)(81166006)(4326008)(25786009)(66066001)(97736004)(81156014)(5660300002)(110136005)(54906003)(316002)(229853002)(7736002)(66476007)(2906002)(11346002)(446003)(14454004)(73956011)(6486002)(2616005)(476003)(52116002)(8676002)(99286004)(6116002)(3846002)(486006)(36756003)(6436002)(305945005)(66556008)(64756008)(66446008)(66946007);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3514;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5WmJg+jvUlzp2aCPvI2vaOeQMEHdzqC/mYzITqDVqFSPCG/BHCMRHZde2PuJtw7WwGKvqc5S044m+uHq3m5Vt7uNNElOP+LHYBiVeoLkch5l5CHsYpYWxdV/X52nr3E/XT4zzzx6S3QnI6jhFcFlsV/iPh0kQzPKkstlwsVxvqdD3imMK4uNVmtdslmGJeOK5cOy8YZiv1Pf/k3GsFFaNFju26+RXDvzaNhH78VT0l+p9IB/ZqTu+aKgj8YDhiy1rAf96hnL5W+zl6MdXKaW9SfCh5uHB89okR9z52Oe+qCVKawKEWLUpCyyh2J9adffMdUIt4HXzoBaJX8Inp8T+ALY9Rqspd/iOAwOjOC3geK70cjBMneAU9A+h/Y2eBscJDKiQpkLLmGtbvfRxepyUU+CsOGyjB/tChfhUJa0+Zk=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <69B6ADC87773E041AD5EEFF7135F136D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfd83ce-c2a4-44f1-4c75-08d6c709168e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 09:58:38.2392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3514
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.131
Subject: Re: [Qemu-devel] [PATCH v2 for 4.1 0/2] avoid lseek on block_status
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
	Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422095838.0d8JP6OmaQ_2Ka1gmjqfTxqBaTJDj9-WR_CU8p8EZPU@z>

cGluZw0KDQowOC4wNC4yMDE5IDE5OjI2LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSENCj4gDQo+IEl0J3MgYSBjb250aW51YXRpb24gZm9yDQo+ICJbUEFUQ0hdIHFj
b3cyOiBhdm9pZCBsc2VlayBvbiBibG9ja19zdGF0dXMgaWYgcG9zc2libGUiDQo+IGh0dHBzOi8v
bGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTAxL21zZzA2NTk4Lmh0
bWwNCj4gDQo+IHBlcmZvcm1hbmNlIHJlc3VsdHMgZm9yIGJsb2NrLXN0YXR1cyBvbiB0bXBmcyBb
dGVzdHMgb3JpZ2luYWxseSBieSBLZXZpbiwNCj4gbm93IHRoZXkgYXJlIGluIDAxXToNCj4gDQo+
IC4vdGVzdHMvcGVyZi9ibG9jay9xY293Mi9jb252ZXJ0LWJsb2Nrc3RhdHVzIC9yYW1kaXNrL3gN
Cj4gDQo+IGFmdGVyIDAxOg0KPiANCj4gcGxhaW46IDgxLjc3DQo+IGZvcndhcmQ6IDgyLjYxDQo+
IHByZWFsbG9jOiAwLjAxDQo+IA0KPiBhZnRlciAwMjoNCj4gDQo+IHBsYWluOiAwLjEyDQo+IGZv
cndhcmQ6IDAuMTINCj4gcHJlYWxsb2M6IDAuMDENCj4gDQo+IHYyOg0KPiAgIDAxOiBuZXcNCj4g
ICAwMjogW21vc3RseSBieSBLZXZpbidzIGNvbW1lbnRzXQ0KPiAgICAgICAtIHJld3JpdHRlbiB0
byBnbyB0aHJvdWdoIG5ldyBmbGFnIEJEUlZfQkxPQ0tfUkVDVVJTRQ0KPiAgICAgICAtIG5ldmVy
IHJldHJ5IGRldGVjdGlvbiBpZiBmYWlsZWQgZm9yIGZpcnN0IHRpbWUNCj4gICAgICAgLSByZXdy
aXRlIGRldGVjdGlvbiB0byBkbyBsZXNzIGl0ZXJhdGlvbnMgYW5kIHRvIGJlIG1vcmUgc2ltcGxl
DQo+IA0KPiAgICAgICBpb3Rlc3RzIDEwMiBiZWhhdmlvciBjaGFuZ2VkIFthbmQgbm90IHN1cmUg
YWJvdXQgb3RoZXIgdHdvIG9uZXMNCj4gICAgICAgaW4gY29tcGFyaXNvbiB3aXRoIHYxLCBidXQg
aXQgc2VlbXMgaXQgZG9lc24ndCBtYXR0ZXJdDQo+IA0KPiAgICAgICBhbHNvLCBwYXRjaCBzdWJq
ZWN0IGNoYW5nZWQsIGFzIG5vdyBpdCdzIGEgZ2VuZXJpYyBjaGFuZ2UgZm9yDQo+ICAgICAgIGJs
b2NrIGxheWVyDQo+IA0KPiANCj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAoMik6DQo+
ICAgIHRlc3RzL3BlcmY6IFRlc3QgbHNlZWsgaW5mbHVlbmNlIG9uIHFjb3cyIGJsb2NrLXN0YXR1
cw0KPiAgICBibG9jazogYXZvaWQgcmVjdXJzaXZlIGJsb2NrX3N0YXR1cyBjYWxsIGlmIHBvc3Np
YmxlDQo+IA0KPiAgIGJsb2NrL3Fjb3cyLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICA0ICsrDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9jay5oICAgICAgICAgICAgICAgICAgICAgIHwg
IDggKystDQo+ICAgYmxvY2svaW8uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDkgKystDQo+ICAgYmxvY2svcWNvdzItcmVmY291bnQuYyAgICAgICAgICAgICAgICAgICAgIHwg
MzIgKysrKysrKysrKw0KPiAgIGJsb2NrL3Fjb3cyLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDExICsrKysNCj4gICB0ZXN0cy9wZXJmL2Jsb2NrL3Fjb3cyL2NvbnZlcnQtYmxvY2tz
dGF0dXMgfCA3MSArKysrKysrKysrKysrKysrKysrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3Rz
LzEwMiAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
MTAyLm91dCAgICAgICAgICAgICAgICAgfCAgMyArLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8x
NDEub3V0ICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE0
NC5vdXQgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICAxMCBmaWxlcyBjaGFuZ2VkLCAxMzgg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVz
dHMvcGVyZi9ibG9jay9xY293Mi9jb252ZXJ0LWJsb2Nrc3RhdHVzDQo+IA0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

