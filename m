Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7931C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91E0D208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 12:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AUSrP4e2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E0D208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47271 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQWIj-0004h7-QI
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 08:12:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGp-0003Lq-46
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1hQWGn-00022i-EW
	for qemu-devel@nongnu.org; Tue, 14 May 2019 08:10:58 -0400
Received: from mail-eopbgr10138.outbound.protection.outlook.com
	([40.107.1.138]:29223
	helo=EUR02-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1hQWGh-0001va-M3; Tue, 14 May 2019 08:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
	s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=gt0hMf9ZBXik+jmEEgrHy5mPCOkpE2mno2OKBrXALZI=;
	b=AUSrP4e2+5epaejg2i6+e5FgrrX1iQx4Wf56KdX/54y2LHdzvODrmJVlEtJyfkR1cxaFHSgWstqTUrSvakHa7klwRVrCYUkMJiK00ZWSeVv46rkyDURn27f4Z8nBEUnVv54WMtz3Z+XnUfHUFWdejijDok+qe3+Ip8FmJcoEqwk=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
	VI1PR08MB4573.eurprd08.prod.outlook.com (20.178.126.206) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.16; Tue, 14 May 2019 12:10:45 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900]) by VI1PR08MB4078.eurprd08.prod.outlook.com
	([fe80::8ce8:ffb4:fe9:4900%3]) with mapi id 15.20.1878.024;
	Tue, 14 May 2019 12:10:45 +0000
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v7 4/9] ide: account UNMAP (TRIM) operations
Thread-Index: AQHVCk4OQluzFK8n80WAwbR9XUOfMQ==
Date: Tue, 14 May 2019 12:10:44 +0000
Message-ID: <20190514121015.32190-5-anton.nefedov@virtuozzo.com>
References: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20190514121015.32190-1-anton.nefedov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0701CA0057.eurprd07.prod.outlook.com
	(2603:10a6:3:9e::25) To VI1PR08MB4078.eurprd08.prod.outlook.com
	(2603:10a6:803:e5::28)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=anton.nefedov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c29e3bd-1c47-40c6-28be-08d6d865311d
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:VI1PR08MB4573; 
x-ms-traffictypediagnostic: VI1PR08MB4573:
x-microsoft-antispam-prvs: <VI1PR08MB45734EACF595DDE8A0E3D87FF8080@VI1PR08MB4573.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:51;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(386003)(6506007)(102836004)(305945005)(5640700003)(6436002)(66946007)(26005)(316002)(7736002)(6512007)(64756008)(66446008)(66556008)(107886003)(66476007)(73956011)(76176011)(11346002)(446003)(2906002)(6486002)(476003)(2616005)(3846002)(6916009)(25786009)(4326008)(2351001)(186003)(53936002)(6116002)(44832011)(486006)(86362001)(71190400001)(71200400001)(52116002)(50226002)(256004)(66066001)(2501003)(1076003)(5660300002)(68736007)(8676002)(99286004)(14454004)(478600001)(36756003)(8936002)(81156014)(81166006)(54906003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4573;
	H:VI1PR08MB4078.eurprd08.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Eg8lXzqGvfwXy7S5wFJ/ARKGLHWxshL1WoaEUTXSgIU+7S4NMF9MBr9Z+RkD3Irdi6ws3ZAJ7F10RtSEDX5ZY2QOwWYPpNyJpbMkKroozVDNG7GXKrf8c0FbXQHkKCKSNtGTAMCiMtTvGNFL+0PzUvGN5o6cLfS78b0Z07MLW6eqtQOpIGU8LVq1SmFafuLWsCvBz0ptINtOYzayL9bSQ3e+UYrUeZqk4f6imMaaL4p6ux3Qj2NYIhiQojWAbTmGYzov4Ww3fsk6viIwC/9dCIA8CgKFCm0UCMfDkMltS4Au+7YfHYuUm3xjhndYu210ix8J/Wf11Zb105rT4NO+6nqewWcfphbMyHHMhZ/oINw7QpouNONV0xkL96QxMR3HmXgQPHlkcLei5xRx1sbAjAr1tmI6rsCBl8ASsCLbRQ4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c29e3bd-1c47-40c6-28be-08d6d865311d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 12:10:44.9356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4573
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.138
Subject: [Qemu-devel] [PATCH v7 4/9] ide: account UNMAP (TRIM) operations
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
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	"berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	Anton Nefedov <anton.nefedov@virtuozzo.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2lnbmVkLW9mZi1ieTogQW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRvdkB2aXJ0dW96em8uY29t
Pg0KUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbT4NCi0tLQ0KIGh3L2lkZS9jb3JlLmMgfCAxMiArKysrKysrKysrKysNCiAx
IGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaWRlL2Nv
cmUuYyBiL2h3L2lkZS9jb3JlLmMNCmluZGV4IDZhZmFkZjg5NGYuLjNhN2FjOTM3NzcgMTAwNjQ0
DQotLS0gYS9ody9pZGUvY29yZS5jDQorKysgYi9ody9pZGUvY29yZS5jDQpAQCAtNDQxLDYgKzQ0
MSwxNCBAQCBzdGF0aWMgdm9pZCBpZGVfaXNzdWVfdHJpbV9jYih2b2lkICpvcGFxdWUsIGludCBy
ZXQpDQogICAgIFRyaW1BSU9DQiAqaW9jYiA9IG9wYXF1ZTsNCiAgICAgSURFU3RhdGUgKnMgPSBp
b2NiLT5zOw0KIA0KKyAgICBpZiAoaW9jYi0+aSA+PSAwKSB7DQorICAgICAgICBpZiAocmV0ID49
IDApIHsNCisgICAgICAgICAgICBibG9ja19hY2N0X2RvbmUoYmxrX2dldF9zdGF0cyhzLT5ibGsp
LCAmcy0+YWNjdCk7DQorICAgICAgICB9IGVsc2Ugew0KKyAgICAgICAgICAgIGJsb2NrX2FjY3Rf
ZmFpbGVkKGJsa19nZXRfc3RhdHMocy0+YmxrKSwgJnMtPmFjY3QpOw0KKyAgICAgICAgfQ0KKyAg
ICB9DQorDQogICAgIGlmIChyZXQgPj0gMCkgew0KICAgICAgICAgd2hpbGUgKGlvY2ItPmogPCBp
b2NiLT5xaW92LT5uaW92KSB7DQogICAgICAgICAgICAgaW50IGogPSBpb2NiLT5qOw0KQEAgLTQ1
OCwxMCArNDY2LDE0IEBAIHN0YXRpYyB2b2lkIGlkZV9pc3N1ZV90cmltX2NiKHZvaWQgKm9wYXF1
ZSwgaW50IHJldCkNCiAgICAgICAgICAgICAgICAgfQ0KIA0KICAgICAgICAgICAgICAgICBpZiAo
IWlkZV9zZWN0X3JhbmdlX29rKHMsIHNlY3RvciwgY291bnQpKSB7DQorICAgICAgICAgICAgICAg
ICAgICBibG9ja19hY2N0X2ludmFsaWQoYmxrX2dldF9zdGF0cyhzLT5ibGspLCBCTE9DS19BQ0NU
X1VOTUFQKTsNCiAgICAgICAgICAgICAgICAgICAgIGlvY2ItPnJldCA9IC1FSU5WQUw7DQogICAg
ICAgICAgICAgICAgICAgICBnb3RvIGRvbmU7DQogICAgICAgICAgICAgICAgIH0NCiANCisgICAg
ICAgICAgICAgICAgYmxvY2tfYWNjdF9zdGFydChibGtfZ2V0X3N0YXRzKHMtPmJsayksICZzLT5h
Y2N0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvdW50IDw8IEJEUlZfU0VD
VE9SX0JJVFMsIEJMT0NLX0FDQ1RfVU5NQVApOw0KKw0KICAgICAgICAgICAgICAgICAvKiBHb3Qg
YW4gZW50cnkhIFN1Ym1pdCBhbmQgZXhpdC4gICovDQogICAgICAgICAgICAgICAgIGlvY2ItPmFp
b2NiID0gYmxrX2Fpb19wZGlzY2FyZChzLT5ibGssDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzZWN0b3IgPDwgQkRSVl9TRUNUT1JfQklUUywNCi0tIA0K
Mi4xNy4xDQoNCg==

