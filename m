Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61754C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB1320821
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P0QlTMD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB1320821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32783 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGJEb-0005n9-4D
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 04:14:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGJDk-0005RC-GC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hGJDh-0002XQ-5P
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:13:36 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
	([40.107.7.109]:61255
	helo=EUR04-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hGJDe-0002VQ-0g; Tue, 16 Apr 2019 04:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=HKjDxFNiBFWmkeKnD+h+c4y7N8d0l0hEju7/Tjgh9rg=;
	b=P0QlTMD6qOrzOOkMklPACAXE6w9gNhZr9xQoLpuInbzUa9iiMWCWL15oSVC5jIqixXNu0M1bCp4Zr12eztZ5SnOPL6EnwJxoIVo9+zB4lgOelxcbrz6P3+apdIDaeWuLRKKNwNUGxVcHA74KrzN44esHxPJOV7gxc9MRWGfhwjA=
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (20.178.46.222) by
	DB7PR08MB3388.eurprd08.prod.outlook.com (20.176.238.93) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.19; Tue, 16 Apr 2019 08:13:25 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949]) by
	DB7PR08MB3851.eurprd08.prod.outlook.com
	([fe80::3c82:5da0:1633:f949%3]) with mapi id 15.20.1792.018;
	Tue, 16 Apr 2019 08:13:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: [PATCH v3 7/7] iotests: Test qemu-img convert -C --salvage
Thread-Index: AQHU8hmBT59lFszKXEWbUVa7Q32DKKY+dFAA
Date: Tue, 16 Apr 2019 08:13:25 +0000
Message-ID: <c923c1c0-e866-9bbc-f351-1c5d861d830d@virtuozzo.com>
References: <20190413165343.9018-1-mreitz@redhat.com>
	<20190413165343.9018-8-mreitz@redhat.com>
In-Reply-To: <20190413165343.9018-8-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0059.eurprd07.prod.outlook.com
	(2603:10a6:3:9e::27) To DB7PR08MB3851.eurprd08.prod.outlook.com
	(2603:10a6:10:7b::30)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190416111322433
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 448d8191-d6c4-4f73-bb5b-08d6c24365fb
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);
	SRVR:DB7PR08MB3388; 
x-ms-traffictypediagnostic: DB7PR08MB3388:
x-microsoft-antispam-prvs: <DB7PR08MB3388F01F062C74C6F837915DC1240@DB7PR08MB3388.eurprd08.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(136003)(39850400004)(346002)(396003)(189003)(199004)(53936002)(476003)(6486002)(11346002)(6512007)(81166006)(107886003)(4326008)(8676002)(2616005)(229853002)(7736002)(110136005)(486006)(26005)(6436002)(14454004)(36756003)(6246003)(386003)(6506007)(81156014)(2501003)(6116002)(3846002)(25786009)(446003)(102836004)(186003)(256004)(54906003)(105586002)(31686004)(76176011)(97736004)(106356001)(99286004)(86362001)(71200400001)(478600001)(5660300002)(305945005)(8936002)(2906002)(68736007)(71190400001)(31696002)(66066001)(316002)(52116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB7PR08MB3388;
	H:DB7PR08MB3851.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c/voNTvwt7gLzV8cMWrTHhPgx2KcqnzYvL8CQlOsHz6q3WAGZ5iEz+FJz7Rm15+vTq9eplwXTfsxn0utuLi5Dsz1dwAx7TWSlEIA1HGd8BxgIYByskzJJh7RCNui4YeIsiowIGhePzpiR1ILPL8RB7y6NAnfjx1r6oQ42UJbFHOuklgFf1dB1cnGzS16vRGMAxKaD+yN4vEvzb1f/9eyi66vDBCpyiUpIJXcVbiLSrqygv5NaC8W5AE8efqzDBRdCoAgiV+zdA7cOi8uU5TUNqyPopA4q4ZDGxbK4aVD8QCdPb9MTXXKRDwwYx68PQXurz2g91bwYUYR6hEoYx+njcdhSOdGwTsTnG7JcmjkHNeiPT4YHd+Aswkl3OK/LYwyxffc4HdP1cAGvoTrDiZMIz844AvPp45ERKATFwKb9bY=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <9D2143B25A15A14C8335426A255FE39A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448d8191-d6c4-4f73-bb5b-08d6c24365fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 08:13:25.2620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3388
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.109
Subject: Re: [Qemu-devel] [PATCH v3 7/7] iotests: Test qemu-img convert -C
 --salvage
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
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416081325.UUuju82B4vqYNTsLp7ewTwWc66cDvCZPDs_q8jV-zIg@z>

MTMuMDQuMjAxOSAxOTo1MywgTWF4IFJlaXR6IHdyb3RlOg0KPiBXZSBkbyBub3Qgc3VwcG9ydCB0
aGlzIGNvbWJpbmF0aW9uICh5ZXQpLCBzbyB0aGlzIHNob3VsZCB5aWVsZCBhbiBlcnJvcg0KPiBt
ZXNzYWdlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNv
bT4NCg0KVGVzdGVkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQogICAgICAgICAgICBbb25seSAtcWNvdzIsIGFzIC1uZnMgLXFjb3cy
IGlzIGFscmVhZHkgYnJva2VuXQ0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KSG1tLCBpbnRlcmVzdGluZywgdGhh
dCB0aGlzIHRlc3QgaXMgZGVmaW5lZCBhcw0KX3N1cHBvcnRlZF9mbXQgcWNvdzINCl9zdXBwb3J0
ZWRfcHJvdG8gZmlsZSBuZnMNCg0KQW5kIG9mIGNvdXJzZSwgaXQgZG9lc24ndCB3b3JrIGZvciAt
cWNvdzIgLW5mcyBjb21iaW5hdGlvbi4uDQoNCj4gLS0tDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3Rz
LzA4MiAgICAgfCAxICsNCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMvMDgyLm91dCB8IDMgKysrDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90
ZXN0cy9xZW11LWlvdGVzdHMvMDgyIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzA4Mg0KPiBpbmRleCBk
MGFmYTQ2ZTlhLi5jNThiMzcxMjdmIDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMv
MDgyDQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wODINCj4gQEAgLTE2Myw2ICsxNjMsNyBA
QCBlY2hvID09PSBjb252ZXJ0OiAtQyBhbmQgb3RoZXIgb3B0aW9ucyA9PT0NCj4gICBydW5fcWVt
dV9pbWcgY29udmVydCAtQyAtUyA0ayAtTyAkSU1HRk1UICIkVEVTVF9JTUciICIkVEVTVF9JTUci
LnRhcmdldA0KPiAgIHJ1bl9xZW11X2ltZyBjb252ZXJ0IC1DIC1TIDhrIC1PICRJTUdGTVQgIiRU
RVNUX0lNRyIgIiRURVNUX0lNRyIudGFyZ2V0DQo+ICAgcnVuX3FlbXVfaW1nIGNvbnZlcnQgLUMg
LWMgLU8gJElNR0ZNVCAiJFRFU1RfSU1HIiAiJFRFU1RfSU1HIi50YXJnZXQNCj4gK3J1bl9xZW11
X2ltZyBjb252ZXJ0IC1DIC0tc2FsdmFnZSAtTyAkSU1HRk1UICIkVEVTVF9JTUciICIkVEVTVF9J
TUciLnRhcmdldA0KPiAgIA0KPiAgIGVjaG8NCj4gICBlY2hvID09PSBhbWVuZDogT3B0aW9ucyBz
cGVjaWZpZWQgbW9yZSB0aGFuIG9uY2UgPT09DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9xZW11LWlv
dGVzdHMvMDgyLm91dCBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wODIub3V0DQo+IGluZGV4IGQzNjkz
OGRhOWIuLjlkNGY3NTc0YzkgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8wODIu
b3V0DQo+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8wODIub3V0DQo+IEBAIC01NTUsNiArNTU1
LDkgQEAgcWVtdS1pbWc6IENhbm5vdCBlbmFibGUgY29weSBvZmZsb2FkaW5nIHdoZW4gLVMgaXMg
dXNlZA0KPiAgIFRlc3Rpbmc6IGNvbnZlcnQgLUMgLWMgLU8gcWNvdzIgVEVTVF9ESVIvdC5xY293
MiBURVNUX0RJUi90LnFjb3cyLnRhcmdldA0KPiAgIHFlbXUtaW1nOiBDYW5ub3QgZW5hYmxlIGNv
cHkgb2ZmbG9hZGluZyB3aGVuIC1jIGlzIHVzZWQNCj4gICANCj4gK1Rlc3Rpbmc6IGNvbnZlcnQg
LUMgLS1zYWx2YWdlIC1PIHFjb3cyIFRFU1RfRElSL3QucWNvdzIgVEVTVF9ESVIvdC5xY293Mi50
YXJnZXQNCj4gK3FlbXUtaW1nOiBDYW5ub3QgdXNlIGNvcHkgb2ZmbG9hZGluZyBpbiBzYWx2YWdp
bmcgbW9kZQ0KPiArDQo+ICAgPT09IGFtZW5kOiBPcHRpb25zIHNwZWNpZmllZCBtb3JlIHRoYW4g
b25jZSA9PT0NCj4gICANCj4gICBUZXN0aW5nOiBhbWVuZCAtZiBmb28gLWYgcWNvdzIgLW8gbGF6
eV9yZWZjb3VudHM9b24gVEVTVF9ESVIvdC5xY293Mg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

