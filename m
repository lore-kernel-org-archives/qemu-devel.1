Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91316C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 22:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B512082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 22:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EEYUZ8QS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZLZV7eZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B512082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNmS3-0000ES-Fj
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 18:51:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0220d2d68=Alistair.Francis@wdc.com>)
	id 1hNmQy-0007QI-2z
	for qemu-devel@nongnu.org; Mon, 06 May 2019 18:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0220d2d68=Alistair.Francis@wdc.com>)
	id 1hNmQu-0003vI-6B
	for qemu-devel@nongnu.org; Mon, 06 May 2019 18:50:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0220d2d68=Alistair.Francis@wdc.com>)
	id 1hNmQq-0003qg-NO; Mon, 06 May 2019 18:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1557183001; x=1588719001;
	h=from:to:cc:subject:date:message-id:
	content-transfer-encoding:mime-version;
	bh=HuqwoaBI1bZMAqgfuNhaSr2Z8EelzZlAfxJnYjvK4V8=;
	b=EEYUZ8QSAYx4OSngY+yJWcLbqQu46gCv83Yw6WIYb94MsnEd8i1jR7oc
	xqwDoB8nkSCFNaqHiciEnV+eYg2H9zhs/f+gSgAH4LvMDL42bYLV1c2bb
	TCqmLP6dYOVXk7LovW9gZlQHz/8jrZcnyin4f3Jhki9X8UpTHkkPrLUMr
	qam57QIn7WbfCdEm+tsR+OUDQEleb6Un7oC60Gp8bVomHmSwHzB2yVTJ1
	TCxhj5L246/jg+ZQtGkqtq2k8TKpWf8esg5fymFJHgkqwU9a2oXaTLiNj
	CJgirLF4BirW/aImTFIi8eETEkxfp6iLAUfZj25vnC+/HrjXZ0maIfDr3 Q==;
X-IronPort-AV: E=Sophos;i="5.60,439,1549900800"; d="scan'208";a="109363130"
Received: from mail-by2nam03lp2056.outbound.protection.outlook.com (HELO
	NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.56])
	by ob1.hgst.iphmx.com with ESMTP; 07 May 2019 06:49:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=HuqwoaBI1bZMAqgfuNhaSr2Z8EelzZlAfxJnYjvK4V8=;
	b=ZLZV7eZGXPs24xpPLu8HRZqzVKn2L8/qRo9XANtKCbpLGY+S9ZIJcyFgRyvC4Wk22Vob1sjH1q8ALScs7e7ntyqdXldpv3D4dyD4FPQCeCkwhp3lAo5x0aG+YPYqT5HT4TSsYhV8TNidsf+RhyFs5asosjeWGkPDNAVrVFWLx34=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB6087.namprd04.prod.outlook.com (20.178.234.33) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.11; Mon, 6 May 2019 22:49:53 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66%5]) with mapi id 15.20.1856.012;
	Mon, 6 May 2019 22:49:53 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 1/1] target/riscv: Allow setting ISA extensions via
	CPU props
Thread-Index: AQHVBF4EAhJoj72DVUSbv3b62S3Vmg==
Date: Mon, 6 May 2019 22:49:53 +0000
Message-ID: <a95544549f6205d1da5c9efa69fed4f9a89f5866.1557182815.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR07CA0029.namprd07.prod.outlook.com
	(2603:10b6:a02:bc::42) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f35b306-b616-4704-b696-08d6d27526fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB6087; 
x-ms-traffictypediagnostic: BYAPR04MB6087:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB608764A6571C1CD66557038990300@BYAPR04MB6087.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:330;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(7736002)(110136005)(478600001)(71190400001)(4326008)(316002)(68736007)(305945005)(71200400001)(54906003)(118296001)(50226002)(2501003)(8936002)(8676002)(81166006)(25786009)(81156014)(72206003)(36756003)(66556008)(64756008)(66446008)(66946007)(66476007)(73956011)(26005)(102836004)(6506007)(186003)(5660300002)(486006)(386003)(44832011)(476003)(2616005)(53936002)(256004)(14444005)(66066001)(2906002)(6116002)(3846002)(6512007)(52116002)(99286004)(14454004)(86362001)(6486002)(6436002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6087;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5xIdQCE658GrKYKnBdyiHyYVUdR1VTDO5UOJ5YIhhOHwDDf0Brva3SlYsS28b+hScob/0V8RkWBZb9+kHP5FA8N/y9Aj8Z3gn/fXQ6lgS/mQ/VU3jpnoSPWF6awdkhfcCE4eAhEgEgbkscKqr8axvMtFv8MiKYY9yGxMYa29/WJdkK8NikTzON9DOPvzU7XoiF7Qywiszz37YXXG7I1I7DOwDXy+ETGnhRXrqCkz+tPCKI+xALgRfAtJLUZDITL5owYJrNDUmIOquSCeluqtNO/C4UCFUvXGA+EXFhnxRDzugazZBEkTOwJieIm83xagkxDctZKYtRfJG+lTptV6eObThTTSs18FraOTRh+/vcy5DAHYGQMbA45F9JbopN3B7RcL1gBToJKADYEht5xrkSkcDDioGxpqVTg0llQU9TA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f35b306-b616-4704-b696-08d6d27526fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 22:49:53.4227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6087
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 1/1] target/riscv: Allow setting ISA
 extensions via CPU props
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
Cc: "alistair23@gmail.com" <alistair23@gmail.com>,
	"palmer@sifive.com" <palmer@sifive.com>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhpcyBwYXRjaCBhbGxvd3MgdXMgdG8gZW5hYmxlL2Rpc2FibGUgdGhlIFJJU0MtViBJU0EgZXh0
ZW5zaW9ucyBmcm9tDQp0aGUgUUVNVSBjb21tYW5kIGxpbmUuIFRoaXMgd29ya3Mgd2l0aCB0aGUg
cnYzMiBhbmQgcnY2NCBtYWNoaW5lcy4gVGhlDQppZGVhIGlzIHRoYXQgaW4gdGhlIGZ1dHVyZSB3
ZSBjYW4gbm93IGFkZCBleHRlbnNpb25zIGFuZCBsZWF2ZSB0aGVtDQpkaXNhYmxlZCBieSBkZWZh
dWx0IHVudGlsIGVuYWJsZWQgYnkgdGhlIHVzZXIuDQoNClNpZ25lZC1vZmYtYnk6IEFsaXN0YWly
IEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCi0tLQ0KQmFzZWQtb246IDxjb3Zl
ci4xNTU1NzI2ODI0LmdpdC5hbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNClRoaXMgaXMgYmFz
ZWQgb24gbXkgcHJldmlvdXMgc2VyaWVzOiAiUklTQy1WOiBBZGQgcHJvcGVydGllcyB0byB0aGUN
CkNQVXMiIHdoaWNoIGhhcyBiZWVuIG1lcmdlZCBpbnRvIHRoZSBSSVNDLVYgdHJlZS4NCg0KIHRh
cmdldC9yaXNjdi9jcHUuYyB8IDcwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0NCiB0YXJnZXQvcmlzY3YvY3B1LmggfCAxMSArKysrKysrKw0KIDIgZmlsZXMg
Y2hhbmdlZCwgNzkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L3RhcmdldC9yaXNjdi9jcHUuYyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KaW5kZXggMmRiMTczODAx
Zi4uNDFhZmVkMzE0MCAxMDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi9jcHUuYw0KKysrIGIvdGFy
Z2V0L3Jpc2N2L2NwdS5jDQpAQCAtMjMsNiArMjMsNyBAQA0KICNpbmNsdWRlICJjcHUuaCINCiAj
aW5jbHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQorI2lu
Y2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQogI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGll
cy5oIg0KICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KIA0KQEAgLTExOCw3ICsxMTks
OCBAQCBzdGF0aWMgdm9pZCByaXNjdl9hbnlfY3B1X2luaXQoT2JqZWN0ICpvYmopDQogc3RhdGlj
IHZvaWQgcmlzY3ZfYmFzZTMyX2NwdV9pbml0KE9iamVjdCAqb2JqKQ0KIHsNCiAgICAgQ1BVUklT
Q1ZTdGF0ZSAqZW52ID0gJlJJU0NWX0NQVShvYmopLT5lbnY7DQotICAgIHNldF9taXNhKGVudiwg
UlYzMiB8IFJWSSB8IFJWTSB8IFJWQSB8IFJWRiB8IFJWRCB8IFJWQyB8IFJWUyB8IFJWVSk7DQor
ICAgIC8qIFdlIHNldCB0aGlzIGluIHRoZSByZWFsaXNlIGZ1bmN0aW9uICovDQorICAgIHNldF9t
aXNhKGVudiwgMCk7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIHJ2MzJnY3N1X3ByaXYxXzA5XzFfY3B1
X2luaXQoT2JqZWN0ICpvYmopDQpAQCAtMTU1LDcgKzE1Nyw4IEBAIHN0YXRpYyB2b2lkIHJ2MzJp
bWFjdV9ub21tdV9jcHVfaW5pdChPYmplY3QgKm9iaikNCiBzdGF0aWMgdm9pZCByaXNjdl9iYXNl
NjRfY3B1X2luaXQoT2JqZWN0ICpvYmopDQogew0KICAgICBDUFVSSVNDVlN0YXRlICplbnYgPSAm
UklTQ1ZfQ1BVKG9iaiktPmVudjsNCi0gICAgc2V0X21pc2EoZW52LCBSVjY0IHwgUlZJIHwgUlZN
IHwgUlZBIHwgUlZGIHwgUlZEIHwgUlZDIHwgUlZTIHwgUlZVKTsNCisgICAgLyogV2Ugc2V0IHRo
aXMgaW4gdGhlIHJlYWxpc2UgZnVuY3Rpb24gKi8NCisgICAgc2V0X21pc2EoZW52LCAwKTsNCiB9
DQogDQogc3RhdGljIHZvaWQgcnY2NGdjc3VfcHJpdjFfMDlfMV9jcHVfaW5pdChPYmplY3QgKm9i
aikNCkBAIC0zMTQsNiArMzE3LDcgQEAgc3RhdGljIHZvaWQgcmlzY3ZfY3B1X3JlYWxpemUoRGV2
aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KICAgICBSSVNDVkNQVUNsYXNzICptY2MgPSBS
SVNDVl9DUFVfR0VUX0NMQVNTKGRldik7DQogICAgIGludCBwcml2X3ZlcnNpb24gPSBQUklWX1ZF
UlNJT05fMV8xMF8wOw0KICAgICBpbnQgdXNlcl92ZXJzaW9uID0gVVNFUl9WRVJTSU9OXzJfMDJf
MDsNCisgICAgdGFyZ2V0X3Vsb25nIHRhcmdldF9taXNhID0gMDsNCiAgICAgRXJyb3IgKmxvY2Fs
X2VyciA9IE5VTEw7DQogDQogICAgIGNwdV9leGVjX3JlYWxpemVmbihjcywgJmxvY2FsX2Vycik7
DQpAQCAtMzU3LDYgKzM2MSw1OCBAQCBzdGF0aWMgdm9pZCByaXNjdl9jcHVfcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQogICAgICAgICBzZXRfZmVhdHVyZShlbnYsIFJJ
U0NWX0ZFQVRVUkVfUE1QKTsNCiAgICAgfQ0KIA0KKyAgICAvKiBJZiBtaXNhIGlzbid0IHNldCAo
cnYzMiBhbmQgcnY2NCBtYWNoaW5lcykgc2V0IGl0IGhlcmUgKi8NCisgICAgaWYgKCFlbnYtPm1p
c2EpIHsNCisgICAgICAgIC8qIERvIHNvbWUgSVNBIGV4dGVuc2lvbiBlcnJvciBjaGVja2luZyAq
Lw0KKyAgICAgICAgaWYgKGNwdS0+Y2ZnLmV4dF9pICYmIGNwdS0+Y2ZnLmV4dF9lKSB7DQorICAg
ICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLA0KKyAgICAgICAgICAgICAgICAgICAgICAgIkkgYW5k
IEUgZXh0ZW5zaW9ucyBhcmUgaW5jb21wYXRpYmxlIik7DQorICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm47DQorICAgICAgIH0NCisNCisgICAgICAgaWYgKGNwdS0+Y2ZnLmV4dF9nICYmICEo
Y3B1LT5jZmcuZXh0X2kgJiBjcHUtPmNmZy5leHRfbSAmDQorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNwdS0+Y2ZnLmV4dF9hICYgY3B1LT5jZmcuZXh0X2YgJg0KKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjcHUtPmNmZy5leHRfZCkpIHsNCisgICAgICAgICAgICB3YXJu
X3JlcG9ydCgiU2V0dGluZyBHIHdpbGwgYWxzbyBzZXQgSU1BRkQiKTsNCisgICAgICAgICAgICBj
cHUtPmNmZy5leHRfaSA9IHRydWU7DQorICAgICAgICAgICAgY3B1LT5jZmcuZXh0X20gPSB0cnVl
Ow0KKyAgICAgICAgICAgIGNwdS0+Y2ZnLmV4dF9hID0gdHJ1ZTsNCisgICAgICAgICAgICBjcHUt
PmNmZy5leHRfZiA9IHRydWU7DQorICAgICAgICAgICAgY3B1LT5jZmcuZXh0X2QgPSB0cnVlOw0K
KyAgICAgICAgfQ0KKw0KKyAgICAgICAgLyogU2V0IHRoZSBJU0EgZXh0ZW5zaW9ucywgY2hlY2tz
IHNob3VsZCBoYXZlIGhhcHBlbmVkIGFib3ZlICovDQorICAgICAgICBpZiAoY3B1LT5jZmcuZXh0
X2kpIHsNCisgICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVkk7DQorICAgICAgICB9DQorICAg
ICAgICBpZiAoY3B1LT5jZmcuZXh0X2UpIHsNCisgICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBS
VkU7DQorICAgICAgICB9DQorICAgICAgICBpZiAoY3B1LT5jZmcuZXh0X20pIHsNCisgICAgICAg
ICAgICB0YXJnZXRfbWlzYSB8PSBSVk07DQorICAgICAgICB9DQorICAgICAgICBpZiAoY3B1LT5j
ZmcuZXh0X2EpIHsNCisgICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVkE7DQorICAgICAgICB9
DQorICAgICAgICBpZiAoY3B1LT5jZmcuZXh0X2YpIHsNCisgICAgICAgICAgICB0YXJnZXRfbWlz
YSB8PSBSVkY7DQorICAgICAgICB9DQorICAgICAgICBpZiAoY3B1LT5jZmcuZXh0X2QpIHsNCisg
ICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVkQ7DQorICAgICAgICB9DQorICAgICAgICBpZiAo
Y3B1LT5jZmcuZXh0X2MpIHsNCisgICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVkM7DQorICAg
ICAgICB9DQorICAgICAgICBpZiAoY3B1LT5jZmcuZXh0X3MpIHsNCisgICAgICAgICAgICB0YXJn
ZXRfbWlzYSB8PSBSVlM7DQorICAgICAgICB9DQorICAgICAgICBpZiAoY3B1LT5jZmcuZXh0X3Up
IHsNCisgICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVlU7DQorICAgICAgICB9DQorDQorICAg
ICAgICBzZXRfbWlzYShlbnYsIFJWWExFTiB8IHRhcmdldF9taXNhKTsNCisgICAgfQ0KKw0KICAg
ICByaXNjdl9jcHVfcmVnaXN0ZXJfZ2RiX3JlZ3NfZm9yX2ZlYXR1cmVzKGNzKTsNCiANCiAgICAg
cWVtdV9pbml0X3ZjcHUoY3MpOw0KQEAgLTM3OSw2ICs0MzUsMTYgQEAgc3RhdGljIGNvbnN0IFZN
U3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX3Jpc2N2X2NwdSA9IHsNCiB9Ow0KIA0KIHN0YXRpYyBQ
cm9wZXJ0eSByaXNjdl9jcHVfcHJvcGVydGllc1tdID0gew0KKyAgICBERUZJTkVfUFJPUF9CT09M
KCJpIiwgUklTQ1ZDUFUsIGNmZy5leHRfaSwgdHJ1ZSksDQorICAgIERFRklORV9QUk9QX0JPT0wo
ImUiLCBSSVNDVkNQVSwgY2ZnLmV4dF9lLCBmYWxzZSksDQorICAgIERFRklORV9QUk9QX0JPT0wo
ImciLCBSSVNDVkNQVSwgY2ZnLmV4dF9nLCB0cnVlKSwNCisgICAgREVGSU5FX1BST1BfQk9PTCgi
bSIsIFJJU0NWQ1BVLCBjZmcuZXh0X20sIHRydWUpLA0KKyAgICBERUZJTkVfUFJPUF9CT09MKCJh
IiwgUklTQ1ZDUFUsIGNmZy5leHRfYSwgdHJ1ZSksDQorICAgIERFRklORV9QUk9QX0JPT0woImYi
LCBSSVNDVkNQVSwgY2ZnLmV4dF9mLCB0cnVlKSwNCisgICAgREVGSU5FX1BST1BfQk9PTCgiZCIs
IFJJU0NWQ1BVLCBjZmcuZXh0X2QsIHRydWUpLA0KKyAgICBERUZJTkVfUFJPUF9CT09MKCJjIiwg
UklTQ1ZDUFUsIGNmZy5leHRfYywgdHJ1ZSksDQorICAgIERFRklORV9QUk9QX0JPT0woInMiLCBS
SVNDVkNQVSwgY2ZnLmV4dF9zLCB0cnVlKSwNCisgICAgREVGSU5FX1BST1BfQk9PTCgidSIsIFJJ
U0NWQ1BVLCBjZmcuZXh0X3UsIHRydWUpLA0KICAgICBERUZJTkVfUFJPUF9TVFJJTkcoInByaXZf
c3BlYyIsIFJJU0NWQ1BVLCBjZmcucHJpdl9zcGVjKSwNCiAgICAgREVGSU5FX1BST1BfU1RSSU5H
KCJ1c2VyX3NwZWMiLCBSSVNDVkNQVSwgY2ZnLnVzZXJfc3BlYyksDQogICAgIERFRklORV9QUk9Q
X0JPT0woIm1tdSIsIFJJU0NWQ1BVLCBjZmcubW11LCB0cnVlKSwNCmRpZmYgLS1naXQgYS90YXJn
ZXQvcmlzY3YvY3B1LmggYi90YXJnZXQvcmlzY3YvY3B1LmgNCmluZGV4IDY3ZDI3ZjQ1ZjYuLjk4
MDVlNjUwNjUgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1LmgNCisrKyBiL3RhcmdldC9y
aXNjdi9jcHUuaA0KQEAgLTIyOSw2ICsyMjksMTcgQEAgdHlwZWRlZiBzdHJ1Y3QgUklTQ1ZDUFUg
ew0KIA0KICAgICAvKiBDb25maWd1cmF0aW9uIFNldHRpbmdzICovDQogICAgIHN0cnVjdCB7DQor
ICAgICAgICBib29sIGV4dF9pOw0KKyAgICAgICAgYm9vbCBleHRfZTsNCisgICAgICAgIGJvb2wg
ZXh0X2c7DQorICAgICAgICBib29sIGV4dF9tOw0KKyAgICAgICAgYm9vbCBleHRfYTsNCisgICAg
ICAgIGJvb2wgZXh0X2Y7DQorICAgICAgICBib29sIGV4dF9kOw0KKyAgICAgICAgYm9vbCBleHRf
YzsNCisgICAgICAgIGJvb2wgZXh0X3M7DQorICAgICAgICBib29sIGV4dF91Ow0KKw0KICAgICAg
ICAgY2hhciAqcHJpdl9zcGVjOw0KICAgICAgICAgY2hhciAqdXNlcl9zcGVjOw0KICAgICAgICAg
Ym9vbCBtbXU7DQotLSANCjIuMjEuMA0KDQo=

