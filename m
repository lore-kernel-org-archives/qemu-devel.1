Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBDDC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1A820820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X3wbXE7n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ye12pCOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1A820820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEMYr-0002BV-6m
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 19:23:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMVA-0007i8-DC
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMNq-0001iE-Th
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:12:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMNg-00015Q-Bt; Wed, 10 Apr 2019 19:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1554937909; x=1586473909;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=tbqoCDILpxcBCCuIoVd8GeoVvBiRJEO+FeM67kvU/KQ=;
	b=X3wbXE7nLqWJXUuBW1yLZgklLsEBAILzN6yTEliC2dJY+qhveol+6JL/
	TNUUgb1PGx0uOiummj/5SXfKuaSUkpZnqiLggY68gtovasmWOxYkQlPli
	B/179y+Qr9bIkEFbnFnSJOFpfVA2nQpTrkdFBiBsYJE6AnA9NkuCaXqwy
	4ndau++9RR8ZGez9ej4Alk+CrXnpvnJQeZF/zxHEs8ls5Bs8V40jHFYI1
	/UwhsG6nbsD23/VC/ZFRM9znlGjM3WwrsX4sFeiU3eoGLPRlIwkLgncFF
	DR7d6ZfPeykV2UmwvWFV6P2X3yG66F8EzbIuLFIvbGp7ylJnq5opC8VLW A==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; d="scan'208";a="105472601"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO
	NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
	by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:10:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=tbqoCDILpxcBCCuIoVd8GeoVvBiRJEO+FeM67kvU/KQ=;
	b=Ye12pCOUv0L9sqpXWbAHCk+PxsXfecnPf5HJ6HbE3Ns6g4pwxXHWpAUEQSFn9cZLoxV/8m5/8JThlTINHLbTCjtFbzaFQYQZrhvF4mK4SDSCe7zoxCgVd4RT7iUcOxjapRxfGn0fqCRE+D/34cBJA4xi+qQpjW2zvIxW7CCl1P4=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5334.namprd04.prod.outlook.com (20.178.50.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Wed, 10 Apr 2019 23:10:43 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1771.021;
	Wed, 10 Apr 2019 23:10:43 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH for 4.1 v3 4/6] riscv: virt: Allow specifying a CPU via
	commandline
Thread-Index: AQHU7/Kf57Dc9HHL00uEkHQd6kr7/A==
Date: Wed, 10 Apr 2019 23:10:42 +0000
Message-ID:
 <a832ae5e252c58c1ac4dd99d7d164fdb0de70f10.1554937288.git.alistair.francis@wdc.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1554937288.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR01CA0005.prod.exchangelabs.com (2603:10b6:a02:80::18)
	To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f37cfa8-0176-44ee-1f9b-08d6be09c153
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5334; 
x-ms-traffictypediagnostic: BYAPR04MB5334:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5334984D569034A3AD1CC954902E0@BYAPR04MB5334.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(99286004)(11346002)(8936002)(14454004)(2616005)(4744005)(6486002)(305945005)(6436002)(478600001)(97736004)(14444005)(446003)(71190400001)(118296001)(2501003)(66066001)(476003)(4326008)(256004)(44832011)(71200400001)(486006)(86362001)(102836004)(186003)(36756003)(81156014)(72206003)(3846002)(8676002)(25786009)(386003)(6506007)(5660300002)(53936002)(7736002)(50226002)(106356001)(105586002)(2906002)(68736007)(6116002)(54906003)(26005)(316002)(6512007)(81166006)(110136005)(52116002)(76176011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5334;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jmakVeVbvoiud9nXyl7vT1IR/NInsID0TQiGeRDSr6y7dshf32qSspdu5V9CBqdevDrJLGEb4G7759eqSUPiJ3NYrntg+s2CZgSvFig06/SG428mtV6PKiYq9kTj/9U2fuD59F7TTRkASBHklH569hnwedgd2EXVTBhazuDxM3ullVSxBhjlpEMwydJrNQ+oCezRX7qdmtQuIjghiFPRBpBW9QdOdd7PR0N21dWE1VC8cTP/A4sYVOWTyTvpaupHO5T4xtbFxoZRb3RfDdGUeqwPYKh4IE9L3rzud6Vhw3neu2egatkPVoasF0G5Mw0s9Z2+2KxIXrkjUFZB6eLx/EEatIZlficQbjFUROewtg2uPugkqXZakQs5WAI20WUO3rebRP8uwmGRrAEWi8OvPZPQ2fSnnJk+aFqFRGUJkS0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f37cfa8-0176-44ee-1f9b-08d6be09c153
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 23:10:42.9869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH for 4.1 v3 4/6] riscv: virt: Allow specifying a
 CPU via commandline
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
	Alistair Francis <Alistair.Francis@wdc.com>,
	"ijc@hellion.org.uk" <ijc@hellion.org.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410231042.Ln5KtTswoK9Z_FoHOHwTzXXLDD_G5zUi15E7iKVbE4Q@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogaHcvcmlzY3YvdmlydC5jIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9ody9yaXNjdi92aXJ0LmMg
Yi9ody9yaXNjdi92aXJ0LmMNCmluZGV4IGZjNGM2YjMwNmUuLjViMjVmMDI4YWQgMTAwNjQ0DQot
LS0gYS9ody9yaXNjdi92aXJ0LmMNCisrKyBiL2h3L3Jpc2N2L3ZpcnQuYw0KQEAgLTQwMCw3ICs0
MDAsNyBAQCBzdGF0aWMgdm9pZCByaXNjdl92aXJ0X2JvYXJkX2luaXQoTWFjaGluZVN0YXRlICpt
YWNoaW5lKQ0KICAgICAvKiBJbml0aWFsaXplIFNPQyAqLw0KICAgICBvYmplY3RfaW5pdGlhbGl6
ZV9jaGlsZChPQkpFQ1QobWFjaGluZSksICJzb2MiLCAmcy0+c29jLCBzaXplb2Yocy0+c29jKSwN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9SSVNDVl9IQVJUX0FSUkFZLCAmZXJy
b3JfYWJvcnQsIE5VTEwpOw0KLSAgICBvYmplY3RfcHJvcGVydHlfc2V0X3N0cihPQkpFQ1QoJnMt
PnNvYyksIFZJUlRfQ1BVLCAiY3B1LXR5cGUiLA0KKyAgICBvYmplY3RfcHJvcGVydHlfc2V0X3N0
cihPQkpFQ1QoJnMtPnNvYyksIG1hY2hpbmUtPmNwdV90eXBlLCAiY3B1LXR5cGUiLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpOw0KICAgICBvYmplY3RfcHJvcGVy
dHlfc2V0X2ludChPQkpFQ1QoJnMtPnNvYyksIHNtcF9jcHVzLCAibnVtLWhhcnRzIiwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCkBAIC01MjYsNiArNTI2LDcg
QEAgc3RhdGljIHZvaWQgcmlzY3ZfdmlydF9ib2FyZF9tYWNoaW5lX2luaXQoTWFjaGluZUNsYXNz
ICptYykNCiAgICAgbWMtPmRlc2MgPSAiUklTQy1WIFZpcnRJTyBCb2FyZCAoUHJpdmlsZWdlZCBJ
U0EgdjEuMTApIjsNCiAgICAgbWMtPmluaXQgPSByaXNjdl92aXJ0X2JvYXJkX2luaXQ7DQogICAg
IG1jLT5tYXhfY3B1cyA9IDg7IC8qIGhhcmRjb2RlZCBsaW1pdCBpbiBCQkwgKi8NCisgICAgbWMt
PmRlZmF1bHRfY3B1X3R5cGUgPSBWSVJUX0NQVTsNCiB9DQogDQogREVGSU5FX01BQ0hJTkUoInZp
cnQiLCByaXNjdl92aXJ0X2JvYXJkX21hY2hpbmVfaW5pdCkNCi0tIA0KMi4yMS4wDQoNCg==

