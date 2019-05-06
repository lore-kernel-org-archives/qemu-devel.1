Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73EDC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:40:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588C620578
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 16:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TMAEOdMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588C620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59242 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNgex-00018u-Eu
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 12:40:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNgd3-0008Nu-LS
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hNgd2-0003On-Kh
	for qemu-devel@nongnu.org; Mon, 06 May 2019 12:38:13 -0400
Received: from mail-eopbgr90100.outbound.protection.outlook.com
	([40.107.9.100]:51674
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hNgcu-0003Il-TU; Mon, 06 May 2019 12:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=dtxveFmsvXCXIncrAgGJh7A+nn6fzV2RyjpelNmPib0=;
	b=TMAEOdMTH5zVFapmOP9DIlrsH4hkXDuZ/M8S5J2uFeXsXqL1MKKTiAtriOpZuXpQeoZdw44LNq/vaLiOW74Pp9OL1V7yDX4hyO9DApWyB9C4Je4cYNP5Fh+a9f0p6Bjs04qAmk44OM+DA6FhZqj4z/GaT5vV7j+ZaJXAc47KevM=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4796.eurprd08.prod.outlook.com (52.133.109.138) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Mon, 6 May 2019 16:38:02 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::9c35:2e89:30c4:5cc4%3]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 16:38:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 2/5] vdi: Replace bdrv_{read, write}()
	with bdrv_{pread, pwrite}()
Thread-Index: AQHVAEqltmXhES9hPk6eauiGd3322qZeU4wA
Date: Mon, 6 May 2019 16:38:02 +0000
Message-ID: <e5d0505d-9696-2df0-7ce3-c7e28122b5d1@virtuozzo.com>
References: <cover.1556732434.git.berto@igalia.com>
	<f64d9b6b1bc90d45c9be5aae63176b34879182c2.1556732434.git.berto@igalia.com>
In-Reply-To: <f64d9b6b1bc90d45c9be5aae63176b34879182c2.1556732434.git.berto@igalia.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0017.eurprd08.prod.outlook.com
	(2603:10a6:3:bd::27) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190506193800245
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38c76dc2-aa2e-43c3-45a1-08d6d24134bb
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4796; 
x-ms-traffictypediagnostic: PR2PR08MB4796:
x-microsoft-antispam-prvs: <PR2PR08MB4796A0C94223FB9FAE1B4698C1300@PR2PR08MB4796.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(39840400004)(136003)(396003)(346002)(199004)(189003)(25786009)(86362001)(31696002)(8676002)(3846002)(6116002)(99286004)(66066001)(71200400001)(31686004)(478600001)(26005)(71190400001)(316002)(6436002)(6246003)(7736002)(256004)(14454004)(446003)(2616005)(476003)(11346002)(66446008)(73956011)(110136005)(64756008)(66556008)(66476007)(305945005)(54906003)(6486002)(486006)(52116002)(66946007)(186003)(102836004)(229853002)(53936002)(76176011)(5660300002)(386003)(6506007)(81166006)(81156014)(8936002)(2501003)(2906002)(36756003)(6512007)(68736007)(4326008);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4796;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KUiZrK7QhEmQO+J2Jf1VJKsIITFP9Xtl/LlqH40epcS1Gt7s9W3ogev3yx0LpoEF+m8JDQGLg9dQSbdlHBjWaTAX1OZEVRhvJKKYlbTpYNGHq2yxIrF3v034pxWL0i3ynMYC6/4e5Iq0XfrSAJLKy5r8Ejss2OpsI1SU+otXwn72NqnBpavXaDd3BRoChmLgOHkDEBmMA6ZDg2Xyq0ZLY6YkHut3LA1J1oO3/apodsDzPWEetXgqB5/y0xPVlhapX30rxoWWontrpFvaSr1L4/AzHBtned8AhezreD4AC3SAIV07DVBW6vOUiSYfddDZ0QQ/kuzxGy8rWlpPH1gbTGgSMqHqRoVQvMkgcY0ClcQfl9hH0gR5HPMjJIJgHFtBeQ61bOES5stniTZbROpkUduenXkfyUHo1Z4CAo7Zga0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3871CDFCE0A8C4E9FAE69971322F53D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c76dc2-aa2e-43c3-45a1-08d6d24134bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 16:38:02.1721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4796
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.100
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vdi: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
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
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDEuMDUuMjAxOSAyMToxMywgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IFRoZXJlJ3Mgb25seSBh
IGNvdXBsZSBvZiBiZHJ2X3JlYWQoKSBhbmQgYmRydl93cml0ZSgpIGNhbGxzIGxlZnQgaW4NCj4g
dGhlIHZkaSBjb2RlLCBhbmQgdGhleSBjYW4gYmUgdHJpdmlhbGx5IHJlcGxhY2VkIHdpdGggdGhl
IGJ5dGUtYmFzZWQNCj4gYmRydl9wcmVhZCgpIGFuZCBiZHJ2X3B3cml0ZSgpLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQWxiZXJ0byBHYXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+DQo+IC0tLQ0KPiAg
IGJsb2NrL3ZkaS5jIHwgMTUgKysrKysrKysrLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay92
ZGkuYyBiL2Jsb2NrL3ZkaS5jDQo+IGluZGV4IGUxYzQyYWQ3MzIuLjljYWViNTBkZDEgMTAwNjQ0
DQo+IC0tLSBhL2Jsb2NrL3ZkaS5jDQo+ICsrKyBiL2Jsb2NrL3ZkaS5jDQo+IEBAIC0xNzEsNiAr
MTcxLDggQEAgdHlwZWRlZiBzdHJ1Y3Qgew0KPiAgICAgICB1aW50NjRfdCB1bnVzZWQyWzddOw0K
PiAgIH0gUUVNVV9QQUNLRUQgVmRpSGVhZGVyOw0KPiAgIA0KPiArUUVNVV9CVUlMRF9CVUdfT04o
c2l6ZW9mKFZkaUhlYWRlcikgIT0gNTEyKTsNCj4gKw0KPiAgIHR5cGVkZWYgc3RydWN0IHsNCj4g
ICAgICAgLyogVGhlIGJsb2NrIG1hcCBlbnRyaWVzIGFyZSBsaXR0bGUgZW5kaWFuIChldmVuIGlu
IG1lbW9yeSkuICovDQo+ICAgICAgIHVpbnQzMl90ICpibWFwOw0KPiBAQCAtMzg0LDcgKzM4Niw3
IEBAIHN0YXRpYyBpbnQgdmRpX29wZW4oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIFFEaWN0ICpvcHRp
b25zLCBpbnQgZmxhZ3MsDQo+ICAgDQo+ICAgICAgIGxvZ291dCgiXG4iKTsNCj4gICANCj4gLSAg
ICByZXQgPSBiZHJ2X3JlYWQoYnMtPmZpbGUsIDAsICh1aW50OF90ICopJmhlYWRlciwgMSk7DQo+
ICsgICAgcmV0ID0gYmRydl9wcmVhZChicy0+ZmlsZSwgMCwgKHVpbnQ4X3QgKikmaGVhZGVyLCBz
aXplb2YoaGVhZGVyKSk7DQoNCmJkcnZfcHJlYWQgcGFyYW1ldGVyIGJ1ZiBwYXJhbWV0ZXIgaXMg
dm9pZCwgc28gKHVpbnQ4X3QgKikgY29udmVyc2lvbiBpcyBub3QgbmVlZGVkDQooYW5kIGV2ZW4g
Y29uZnVzaW5nKQ0KDQo+ICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICAgICAgICAgICBnb3RvIGZh
aWw7DQo+ICAgICAgIH0NCj4gQEAgLTQ4NCw4ICs0ODYsOCBAQCBzdGF0aWMgaW50IHZkaV9vcGVu
KEJsb2NrRHJpdmVyU3RhdGUgKmJzLCBRRGljdCAqb3B0aW9ucywgaW50IGZsYWdzLA0KPiAgICAg
ICAgICAgZ290byBmYWlsOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgcmV0ID0gYmRydl9yZWFk
KGJzLT5maWxlLCBzLT5ibWFwX3NlY3RvciwgKHVpbnQ4X3QgKilzLT5ibWFwLA0KPiAtICAgICAg
ICAgICAgICAgICAgICBibWFwX3NpemUpOw0KPiArICAgIHJldCA9IGJkcnZfcHJlYWQoYnMtPmZp
bGUsIGhlYWRlci5vZmZzZXRfYm1hcCwgKHVpbnQ4X3QgKilzLT5ibWFwLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgYm1hcF9zaXplICogU0VDVE9SX1NJWkUpOw0KDQphbmQgaGVyZQ0KDQo+ICAg
ICAgIGlmIChyZXQgPCAwKSB7DQo+ICAgICAgICAgICBnb3RvIGZhaWxfZnJlZV9ibWFwOw0KPiAg
ICAgICB9DQo+IEBAIC03MDQsNyArNzA2LDcgQEAgbm9uYWxsb2NhdGluZ193cml0ZToNCj4gICAg
ICAgICAgIGFzc2VydChWRElfSVNfQUxMT0NBVEVEKGJtYXBfZmlyc3QpKTsNCj4gICAgICAgICAg
ICpoZWFkZXIgPSBzLT5oZWFkZXI7DQo+ICAgICAgICAgICB2ZGlfaGVhZGVyX3RvX2xlKGhlYWRl
cik7DQo+IC0gICAgICAgIHJldCA9IGJkcnZfd3JpdGUoYnMtPmZpbGUsIDAsIGJsb2NrLCAxKTsN
Cj4gKyAgICAgICAgcmV0ID0gYmRydl9wd3JpdGUoYnMtPmZpbGUsIDAsIGJsb2NrLCBzaXplb2Yo
VmRpSGVhZGVyKSk7DQoNCm1heWJlLCBtb3JlIHNlbGYtZGVzY3JpcHRpdmU6DQogIHJldCA9IGJk
cnZfcHdyaXRlKGJzLT5maWxlLCAwLCBoZWFkZXIsIHNpemVvZigqaGVhZGVyKSk7DQoNCg0Kd2l0
aCBhdCBsZWFzdCBleHRyYSBjb252ZXJzaW9uIGRyb3BwZWQ6DQpSZXZpZXdlZC1ieTogVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KDQo+ICAg
ICAgICAgICBnX2ZyZWUoYmxvY2spOw0KPiAgICAgICAgICAgYmxvY2sgPSBOVUxMOw0KPiAgIA0K
PiBAQCAtNzIyLDEwICs3MjQsMTEgQEAgbm9uYWxsb2NhdGluZ193cml0ZToNCj4gICAgICAgICAg
IGJhc2UgPSAoKHVpbnQ4X3QgKikmcy0+Ym1hcFswXSkgKyBibWFwX2ZpcnN0ICogU0VDVE9SX1NJ
WkU7DQo+ICAgICAgICAgICBsb2dvdXQoIndpbGwgd3JpdGUgJXUgYmxvY2sgbWFwIHNlY3RvcnMg
c3RhcnRpbmcgZnJvbSBlbnRyeSAldVxuIiwNCj4gICAgICAgICAgICAgICAgICBuX3NlY3RvcnMs
IGJtYXBfZmlyc3QpOw0KPiAtICAgICAgICByZXQgPSBiZHJ2X3dyaXRlKGJzLT5maWxlLCBvZmZz
ZXQsIGJhc2UsIG5fc2VjdG9ycyk7DQo+ICsgICAgICAgIHJldCA9IGJkcnZfcHdyaXRlKGJzLT5m
aWxlLCBvZmZzZXQgKiBTRUNUT1JfU0laRSwgYmFzZSwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgbl9zZWN0b3JzICogU0VDVE9SX1NJWkUpOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAg
cmV0dXJuIHJldDsNCj4gKyAgICByZXR1cm4gcmV0IDwgMCA/IHJldCA6IDA7DQo+ICAgfQ0KPiAg
IA0KPiAgIHN0YXRpYyBpbnQgY29yb3V0aW5lX2ZuIHZkaV9jb19kb19jcmVhdGUoQmxvY2tkZXZD
cmVhdGVPcHRpb25zICpjcmVhdGVfb3B0aW9ucywNCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

