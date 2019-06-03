Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7C4C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB6125EAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vvyx8Sr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB6125EAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34825 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmX8-0000f7-NG
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:57:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXmLS-0007ds-ID
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hXm6h-0000Wp-Q4
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:30:33 -0400
Received: from mail-ve1eur02on071a.outbound.protection.outlook.com
	([2a01:111:f400:fe06::71a]:64832
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hXm6b-0000Cc-Ix; Mon, 03 Jun 2019 08:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=g76GAh6EFwGJVi9aIAF6O4S/pIVWVHktHKFDY6oVxj4=;
	b=Vvyx8Sr5h5UDdrJ8XzXdBaY12T8IWYgJMWNrIZUypwZpZXc3WKzoJMovtjSuzKIwkU1TgHEgoDCLuDuUEXOEXzfBIkznvipWgKbEoJpfZobt+xMaKhcsCgFUOWoyAe8r/ZJd9UrsGKS8n82r8IQUPx2QhS1fzxxig13FnHB68DY=
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com (52.134.126.11) by
	AM0PR08MB4516.eurprd08.prod.outlook.com (20.179.36.76) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.22; Mon, 3 Jun 2019 12:30:21 +0000
Received: from AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8]) by
	AM0PR08MB2961.eurprd08.prod.outlook.com
	([fe80::8d90:32ae:bdd6:48e8%7]) with mapi id 15.20.1943.018;
	Mon, 3 Jun 2019 12:30:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
	<qemu-block@nongnu.org>
Thread-Topic: ping Re: [PATCH v5 0/3] Fix overflow bug in qcow2 discard
Thread-Index: AQHU+dQTIRtQy84OJ0+wrrxOKT4l3aZ1sJyAgBRr6QA=
Date: Mon, 3 Jun 2019 12:30:21 +0000
Message-ID: <88b122de-aa79-0606-4718-1f2d9e543454@virtuozzo.com>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<4d40c6f9-36c3-076e-16e2-84b8344704b1@virtuozzo.com>
In-Reply-To: <4d40c6f9-36c3-076e-16e2-84b8344704b1@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0036.eurprd07.prod.outlook.com
	(2603:10a6:7:66::22) To AM0PR08MB2961.eurprd08.prod.outlook.com
	(2603:10a6:208:66::11)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190603153011949
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de4f1622-265f-4a3f-5ea2-08d6e81f3e9d
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:AM0PR08MB4516; 
x-ms-traffictypediagnostic: AM0PR08MB4516:
x-microsoft-antispam-prvs: <AM0PR08MB4516EC946AC0CF213109420EC1140@AM0PR08MB4516.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(136003)(376002)(396003)(39850400004)(346002)(189003)(199004)(478600001)(7736002)(66476007)(5660300002)(66946007)(73956011)(4744005)(6512007)(68736007)(66556008)(305945005)(66446008)(64756008)(486006)(25786009)(476003)(14454004)(71200400001)(2501003)(6436002)(2616005)(11346002)(31686004)(6486002)(256004)(66066001)(71190400001)(446003)(316002)(110136005)(4326008)(6506007)(386003)(54906003)(81166006)(81156014)(8936002)(8676002)(31696002)(102836004)(86362001)(99286004)(6116002)(52116002)(2906002)(186003)(53936002)(76176011)(36756003)(3846002)(26005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB4516;
	H:AM0PR08MB2961.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +jiHfdT1Eg2t8l2sJwK09Kq7NS8GcgGOp6O+yKn3hlp/cgLNdEunBjG6t9dLoW0V4P4ae0M/vdq6hco/B260PZ13cPGNLlwkpqYSMliGC4tGKg+F2OEAs1ziCzNu+6WV3FQst02Wl6EMYdLb/FLJne4bYpuwW0js//DvIFCyZYkrdxMuVnQEwZ4Znz3B+CfRdiny1rWoNTUBklAn/3INim+xJ7mBod9/b9AT0DiAMFxgA3zpOo1ifFg95IR2KiVGy/xgymIvfQf8lRYwYb7trY/XKI2+7x0P62pbaBR9E92F3dKTyODYZ6uuIw/AW5Qn5mOZiZoSoBlAPOc/nD8rDHGz2mW1uEXRVXQWjaXBoFGwJro8ydSTozFYr7Kl2avlnEpWqamm0LIUJ4zXcHaKx0Fh/2mLf/hZkayTnNVGe78=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA7B8D2FE0FAFD4B80E5E9CF7D492D0A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4f1622-265f-4a3f-5ea2-08d6e81f3e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:30:21.5432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsementsov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4516
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe06::71a
Subject: [Qemu-devel] ping Re: [PATCH v5 0/3] Fix overflow bug in qcow2
 discard
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

cGluZyAyMS4wNS4yMDE5IDEyOjM4LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3Rl
Og0KPiBwaW5nDQo+IA0KPiAyMy4wNC4yMDE5IDE1OjU3LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dp
ZXZza2l5IHdyb3RlOg0KPj4gdjU6IGJ5IEtldmluJ3MgY29tbWVudHMNCj4+IDAyOiBhZGQgY2hl
Y2sgZm9yIGludmFsaWQgQGJ5dGVzIHBhcmFtZXRlciwgZHJvcCByLWINCj4+IDAzOiBtb3ZlIGZy
b20gcWVtdS1pbWcgaW5mbyB0byBxZW11LWltZyBtYXAgLWYgcmF3LCBkcm9wIHItYiBhbmQgdC1i
DQo+Pg0KPj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAoMyk6DQo+PiDCoMKgIGJsb2Nr
L3Fjb3cyLXJlZmNvdW50OiBhZGQgdHJhY2UtcG9pbnQgdG8gcWNvdzJfcHJvY2Vzc19kaXNjYXJk
cw0KPj4gwqDCoCBibG9jay9pbzogYmRydl9wZGlzY2FyZDogc3VwcG9ydCBpbnQ2NF90IGJ5dGVz
IHBhcmFtZXRlcg0KPj4gwqDCoCBpb3Rlc3RzOiB0ZXN0IGJpZyBxY293MiBzaHJpbmsNCj4+DQo+
PiDCoCBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmjCoMKgwqDCoMKgIHzCoCA0ICstLQ0KPj4gwqAgYmxv
Y2svaW8uY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTYgKysrKy0tLS0tDQo+
PiDCoCBibG9jay9xY293Mi1yZWZjb3VudC5jwqDCoMKgwqAgfMKgIDcgKysrLQ0KPj4gwqAgYmxv
Y2svdHJhY2UtZXZlbnRzwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArKw0KPj4gwqAgdGVzdHMvcWVt
dS1pb3Rlc3RzLzI1MMKgwqDCoMKgIHwgNzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+IMKgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNTAub3V0IHwgMjMgKysrKysrKysr
KysrDQo+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXDCoMKgIHzCoCAxICsNCj4+IMKgIDcg
ZmlsZXMgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPj4gwqAg
Y3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL3FlbXUtaW90ZXN0cy8yNTANCj4+IMKgIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjUwLm91dA0KPj4NCj4gDQo+IA0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

