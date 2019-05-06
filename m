Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C6C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AA42053B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 15:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EnCRFYxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AA42053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNfLF-0005QH-D9
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 11:15:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNfKN-0004zw-5t
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNfKM-0007Xw-4v
	for qemu-devel@nongnu.org; Mon, 06 May 2019 11:14:51 -0400
Received: from mail-eopbgr120133.outbound.protection.outlook.com
	([40.107.12.133]:62739
	helo=FRA01-PR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNfKJ-0007W7-1h; Mon, 06 May 2019 11:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=7BTOe2GZxPjw9WOvh6j4wpCBcMrihRwXb6uauYWg5cg=;
	b=EnCRFYxMqsibHtkNbz1nRBgHU0G7GRot3MjraWkaToCABoAZe/g1O3KnLd715oxkeaHF+IrPCJvQ/Xt1Xa21VW+Z9SKdd7elgWhCD/Ioha446b3LIwI0IBT4jBPQeiZIcJNt2LQIokJjFfDvtSa1D1Ht1A3NDjZud4OTYpcM6k8=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4794.eurprd08.prod.outlook.com (52.133.109.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Mon, 6 May 2019 15:14:44 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 15:14:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 for 4.1 0/2] avoid lseek on block_status
Thread-Index: AQHU7ifR38W67XMkcUq/V5mfMlS/raZeYIuA
Date: Mon, 6 May 2019 15:14:43 +0000
Message-ID: <21dd438f-1e95-d704-e990-d11b3e16e373@virtuozzo.com>
References: <20190408162617.258535-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190408162617.258535-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0202CA0023.eurprd02.prod.outlook.com
	(2603:10a6:3:8c::33) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190506181441617
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f0b316c-44db-41d1-418e-08d6d2359199
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4794; 
x-ms-traffictypediagnostic: PR2PR08MB4794:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <PR2PR08MB479405183A0AAA3A834ACE35C1300@PR2PR08MB4794.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(39840400004)(136003)(346002)(396003)(189003)(199004)(66066001)(6512007)(66946007)(102836004)(6306002)(73956011)(186003)(8676002)(81156014)(81166006)(68736007)(36756003)(6246003)(26005)(8936002)(71190400001)(71200400001)(53936002)(31686004)(386003)(107886003)(6506007)(76176011)(25786009)(2906002)(31696002)(476003)(86362001)(3846002)(6116002)(4326008)(446003)(316002)(54906003)(478600001)(11346002)(64756008)(99286004)(256004)(2616005)(66446008)(110136005)(66556008)(66476007)(305945005)(5660300002)(2501003)(52116002)(966005)(6436002)(486006)(7736002)(229853002)(6486002)(14454004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4794;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: na/0cg7BdrQ0JIYWfOEY4PQLg6Bm6INDV3hIXmAYMOeMu0OgNfdUwGyM2k/v+rMSCtljiYdqC02LcXs+EECawQtASY5egyrDUxBD4hlCILlq6PBvPUJH6pYnLzdaALhNi4eXT1He2lVBIkh6MnhQt1GRCL/xub9I2N3Rzf+r3w8jSpYwOZskghZerwMseTpMnDykjFkl7yZt6CNi5rKLPrmN7zMH4Bc/U9CupBlN0irRu271jBQTgd5VC/frTirIL18fSAVYRluruUWKB6Ml29xwTnTW7n7pMYTEgeZS0fEqlcX56xTxC0hhcA7dikDPg+9Eay4WYNykYnNowiUjozDge9stgC64NVAfPl2SKszyfo+DxlCXRj5aKsiF6SDKLl1+jX/YPRxJYsV/hXV6l3mn6ZI+7Gpciu/8Zg8AevY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58F4907B28DE6C4BAE9B2B5FA0DD9C11@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0b316c-44db-41d1-418e-08d6d2359199
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 15:14:44.0265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4794
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.12.133
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

cGluZzINCg0KSGkhDQoNCk15IGFwcHJvYWNoIG9mIGFkZGluZyBwZXJmIHRlc3QgZGlzbGlrZWQg
YnkgTWF4IGluIG90aGVyIHRocmVhZCwgc28NCjAxIG1heSBiZSBqdXN0IHNraXBwZWQuDQoNCldo
YXQgYWJvdXQgMDI/DQoNCjA4LjA0LjIwMTkgMTk6MjYsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgd3JvdGU6DQo+IEhpIQ0KPiANCj4gSXQncyBhIGNvbnRpbnVhdGlvbiBmb3INCj4gIltQ
QVRDSF0gcWNvdzI6IGF2b2lkIGxzZWVrIG9uIGJsb2NrX3N0YXR1cyBpZiBwb3NzaWJsZSINCj4g
aHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDEvbXNn
MDY1OTguaHRtbA0KPiANCj4gcGVyZm9ybWFuY2UgcmVzdWx0cyBmb3IgYmxvY2stc3RhdHVzIG9u
IHRtcGZzIFt0ZXN0cyBvcmlnaW5hbGx5IGJ5IEtldmluLA0KPiBub3cgdGhleSBhcmUgaW4gMDFd
Og0KPiANCj4gLi90ZXN0cy9wZXJmL2Jsb2NrL3Fjb3cyL2NvbnZlcnQtYmxvY2tzdGF0dXMgL3Jh
bWRpc2sveA0KPiANCj4gYWZ0ZXIgMDE6DQo+IA0KPiBwbGFpbjogODEuNzcNCj4gZm9yd2FyZDog
ODIuNjENCj4gcHJlYWxsb2M6IDAuMDENCj4gDQo+IGFmdGVyIDAyOg0KPiANCj4gcGxhaW46IDAu
MTINCj4gZm9yd2FyZDogMC4xMg0KPiBwcmVhbGxvYzogMC4wMQ0KPiANCj4gdjI6DQo+ICAgMDE6
IG5ldw0KPiAgIDAyOiBbbW9zdGx5IGJ5IEtldmluJ3MgY29tbWVudHNdDQo+ICAgICAgIC0gcmV3
cml0dGVuIHRvIGdvIHRocm91Z2ggbmV3IGZsYWcgQkRSVl9CTE9DS19SRUNVUlNFDQo+ICAgICAg
IC0gbmV2ZXIgcmV0cnkgZGV0ZWN0aW9uIGlmIGZhaWxlZCBmb3IgZmlyc3QgdGltZQ0KPiAgICAg
ICAtIHJld3JpdGUgZGV0ZWN0aW9uIHRvIGRvIGxlc3MgaXRlcmF0aW9ucyBhbmQgdG8gYmUgbW9y
ZSBzaW1wbGUNCj4gDQo+ICAgICAgIGlvdGVzdHMgMTAyIGJlaGF2aW9yIGNoYW5nZWQgW2FuZCBu
b3Qgc3VyZSBhYm91dCBvdGhlciB0d28gb25lcw0KPiAgICAgICBpbiBjb21wYXJpc29uIHdpdGgg
djEsIGJ1dCBpdCBzZWVtcyBpdCBkb2Vzbid0IG1hdHRlcl0NCj4gDQo+ICAgICAgIGFsc28sIHBh
dGNoIHN1YmplY3QgY2hhbmdlZCwgYXMgbm93IGl0J3MgYSBnZW5lcmljIGNoYW5nZSBmb3INCj4g
ICAgICAgYmxvY2sgbGF5ZXINCj4gDQo+IA0KPiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
ICgyKToNCj4gICAgdGVzdHMvcGVyZjogVGVzdCBsc2VlayBpbmZsdWVuY2Ugb24gcWNvdzIgYmxv
Y2stc3RhdHVzDQo+ICAgIGJsb2NrOiBhdm9pZCByZWN1cnNpdmUgYmxvY2tfc3RhdHVzIGNhbGwg
aWYgcG9zc2libGUNCj4gDQo+ICAgYmxvY2svcWNvdzIuaCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDQgKysNCj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmggICAgICAgICAgICAgICAg
ICAgICAgfCAgOCArKy0NCj4gICBibG9jay9pby5jICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgOSArKy0NCj4gICBibG9jay9xY293Mi1yZWZjb3VudC5jICAgICAgICAgICAgICAg
ICAgICAgfCAzMiArKysrKysrKysrDQo+ICAgYmxvY2svcWNvdzIuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMTEgKysrKw0KPiAgIHRlc3RzL3BlcmYvYmxvY2svcWNvdzIvY29udmVy
dC1ibG9ja3N0YXR1cyB8IDcxICsrKysrKysrKysrKysrKysrKysrKysNCj4gICB0ZXN0cy9xZW11
LWlvdGVzdHMvMTAyICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIHRlc3RzL3FlbXUt
aW90ZXN0cy8xMDIub3V0ICAgICAgICAgICAgICAgICB8ICAzICstDQo+ICAgdGVzdHMvcWVtdS1p
b3Rlc3RzLzE0MS5vdXQgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICB0ZXN0cy9xZW11LWlv
dGVzdHMvMTQ0Lm91dCAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIDEwIGZpbGVzIGNoYW5n
ZWQsIDEzOCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEw
MDc1NSB0ZXN0cy9wZXJmL2Jsb2NrL3Fjb3cyL2NvbnZlcnQtYmxvY2tzdGF0dXMNCj4gDQoNCg0K
LS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

