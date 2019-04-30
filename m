Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33906C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89492075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="acO/ntz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89492075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41575 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLOI8-0004I2-6j
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 04:39:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLOHG-0003yK-LK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLOHF-0000vU-OF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:38:14 -0400
Received: from mail-eopbgr90113.outbound.protection.outlook.com
	([40.107.9.113]:18105
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hLOHC-0000ts-Jd; Tue, 30 Apr 2019 04:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=GWdU0AGlSpzLHsSNLJiRYpVXybu2FRz0WvjAG/+UFsM=;
	b=acO/ntz4VS9amrEe1gpdsE6VKChErt7rQbAhzX/tgNtIcl5c4iONgxIc33TvbTtlJNYgXZmr1yhLPWcrJil5GdGdh9Fc+HSKwL1f3oD/xcNaCXMY7rhnVrX4JxX/ntS2YzrmLLM0YQ7Q9uXK1t23Jonf8qeVUlF7xjEchKQsGqI=
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com (52.133.109.209) by
	PR2PR08MB4762.eurprd08.prod.outlook.com (52.133.108.214) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Tue, 30 Apr 2019 08:38:05 +0000
Received: from PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1]) by
	PR2PR08MB4684.eurprd08.prod.outlook.com
	([fe80::88d7:ecf0:1120:f1a1%3]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 08:38:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve locking
Thread-Index: AQHU6WoBm3ZqDVOSG0aQpHzt+uoXFqZTgO4AgAEMSQA=
Date: Tue, 30 Apr 2019 08:38:04 +0000
Message-ID: <66de1a9a-e9fd-b853-377d-f5acfe51737a@virtuozzo.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-8-vsementsov@virtuozzo.com>
	<44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
In-Reply-To: <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0277.eurprd05.prod.outlook.com
	(2603:10a6:3:fc::29) To PR2PR08MB4684.eurprd08.prod.outlook.com
	(2603:10a6:101:22::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190430113801993
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9568798-9840-4af4-180d-08d6cd4729b9
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:PR2PR08MB4762; 
x-ms-traffictypediagnostic: PR2PR08MB4762:
x-microsoft-antispam-prvs: <PR2PR08MB47623A8A52791868881CDA41C13A0@PR2PR08MB4762.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(396003)(376002)(39850400004)(346002)(136003)(366004)(189003)(199004)(53546011)(97736004)(386003)(31686004)(66476007)(66946007)(64756008)(66556008)(256004)(186003)(8676002)(6506007)(68736007)(102836004)(81166006)(6246003)(26005)(11346002)(14444005)(446003)(4326008)(36756003)(81156014)(486006)(66446008)(73956011)(25786009)(6486002)(6436002)(2201001)(2501003)(229853002)(6116002)(3846002)(31696002)(86362001)(478600001)(316002)(76176011)(52116002)(53936002)(2906002)(8936002)(305945005)(5660300002)(99286004)(7736002)(6512007)(71190400001)(476003)(14454004)(110136005)(54906003)(66066001)(71200400001)(2616005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:PR2PR08MB4762;
	H:PR2PR08MB4684.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:3; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PJjJ9+SLG5R/b4xMNeQcsxBs7MflpBGb2V3lHMjPuCDC41EW7qzOwzm1QmJxu+S0dlY8u44UEnUiZuigW2ocCreDZye2BFeIEFXu2JHlCAgb+u90iJujztGiD5X/YSN6KHmXYIobQj+qJW0j0WRGvYPf4PdLGYti81EOSXr1Eg3Mkfylp1CWRecug+ia0VeOKYnHoXNu7w02+JTcBnLCxENmzT2ahnQ5bcgwojN32Pv8TaZ5jzZGde7fU9ZtTTliyPuiZzaDTgIv4fiiFTQDc1HTXMDeazIC8f6AdpZEAaR4HI/rPBHrnWpZTgJhthzdTe9PiqiuDnYtpHBdRa6wLM7vrFCAWb8nfgcc5I2fRc9H2YW35fqbv78kly+9/Vb/MuqZTc0gAnk1BfvlOv4EJM6OLx9mN++X3PDB4GbcLBU=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <F28A108FD181584DA125271FBD57BF2B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9568798-9840-4af4-180d-08d6cd4729b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 08:38:04.9064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4762
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.9.113
Subject: Re: [Qemu-devel] [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve
 locking
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430083804.NUzxmWQjCq8LEwbb4KERgaYVoYWZKzZAIL_n7ky1uTU@z>

MjkuMDQuMjAxOSAxOTozNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMi4wNC4xOSAxNzozNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEJhY2tncm91bmQ6IGRlY3J5
cHRpb24gd2lsbCBiZSBkb25lIGluIHRocmVhZHMsIHRvIHRha2UgYmVuZWZpdCBvZiBpdCwNCj4+
IHdlIHNob3VsZCBtb3ZlIGl0IG91dCBvZiB0aGUgbG9jayBmaXJzdC4NCj4gDQo+IC4uLndoaWNo
IGlzIHNhZmUgYWZ0ZXIgeW91ciBjb21taXQgYzk3MmZhMTIzYzczNTAxYjQsIEkgcHJlc3VtZS4N
Cj4gDQo+IChBdCBmaXJzdCBnbGFuY2UsIHRoZSBwYXRjaGVkIGxvb2tlZCBhIGJpdCB3ZWlyZCB0
byBtZSBiZWNhdXNlIGl0DQo+IGRvZXNuJ3QgZ2l2ZSBhIHJlYXNvbiB3aHkgZHJvcHBpbmcgdGhl
IGxvY2sgYXJvdW5kDQo+IHFjcnlwdG9fYmxvY2tfZGVjcnlwdCgpIHdvdWxkIGJlIE9LLikNCj4g
DQo+PiBCdXQgbGV0J3MgZ28gZnVydGhlcjogaXQgdHVybnMgb3V0LCB0aGF0IGZvciBsb2NraW5n
IGFyb3VuZCBzd2l0Y2gNCj4+IGNhc2VzIHdlIGhhdmUgb25seSB0d28gdmFyaWFudHM6IHdoZW4g
d2UganVzdCBkbyBtZW1zZXQoMCkgbm90DQo+PiByZWxlYXNpbmcgdGhlIGxvY2sgKGl0IGlzIHVz
ZWxlc3MpIGFuZCB3aGVuIHdlIGFjdHVhbGx5IGNhbiBoYW5kbGUgdGhlDQo+PiB3aG9sZSBjYXNl
IG91dCBvZiB0aGUgbG9jay4gU28sIHJlZmFjdG9yIHRoZSB3aG9sZSB0aGluZyB0byByZWR1Y2UN
Cj4+IGxvY2tlZCBjb2RlIHJlZ2lvbiBhbmQgbWFrZSBpdCBjbGVhbi4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQo+PiBSZXZpZXdlZC1ieTogQWxiZXJ0byBHYXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+
DQo+PiAtLS0NCj4+ICAgYmxvY2svcWNvdzIuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi5j
IGIvYmxvY2svcWNvdzIuYw0KPj4gaW5kZXggNDZlOGUzOWRhNS4uZmNmOTJhN2ViNiAxMDA2NDQN
Cj4+IC0tLSBhL2Jsb2NrL3Fjb3cyLmMNCj4+ICsrKyBiL2Jsb2NrL3Fjb3cyLmMNCj4+IEBAIC0x
OTgzLDYgKzE5ODMsNyBAQCBzdGF0aWMgY29yb3V0aW5lX2ZuIGludCBxY293Ml9jb19wcmVhZHYo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IG9mZnNldCwNCj4+ICAgDQo+PiAgICAgICAg
ICAgcmV0ID0gcWNvdzJfZ2V0X2NsdXN0ZXJfb2Zmc2V0KGJzLCBvZmZzZXQsICZjdXJfYnl0ZXMs
ICZjbHVzdGVyX29mZnNldCk7DQo+IA0KPiBJc24ndCB0aGlzIHRoZSBvbmx5IGZ1bmN0aW9uIGlu
IHRoZSBsb29wIHRoYXQgYWN0dWFsbHkgbmVlZHMgdGhlIGxvY2s/DQo+IFdvdWxkbid0IGl0IG1h
a2UgbW9yZSBzZW5zZSB0byBqdXN0IHRha2UgaXQgYXJvdW5kIHRoaXMgY2FsbD8NCj4gDQoNCkht
bSwgbG9va3MgY29ycmVjdCwgSSdsbCByZXNlbmQuDQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=

