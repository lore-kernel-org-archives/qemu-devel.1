Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB179C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B56321479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="em3H+YNI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UCFhqVlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B56321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35900 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfpJ-0003Hz-Q9
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:34:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiy-0006Pf-9u
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiw-0003r3-DB
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiu-0003bL-0q; Fri, 19 Apr 2019 22:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727244; x=1587263244;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=KYgkWVv3K+7b5++g31S6N/taT737miEvtdeuDvG/xNM=;
	b=em3H+YNI/Bi8GUOcF0e5MiCD1G6SZUbgJn3jcnUtdpd3e/o4h5u99eQt
	mt5D80Jgo/o9PXXJhPGOCKC+ScufZDRCXXZnw158MuWqFmGLbFbMD1lK6
	qTHQ5WJmLnDArqpvhy1bfqbnQO2s9MURTUCoDLm7qr00eqJm9i5/uGzfh
	L40r5TAk5sUS0uI7/aRrZF/IgSV4E4ApNXWUaYUtRPI6ug7vIr7hx5fXh
	YB40wfUCvI8dtmYjpx3QzMxSjFHNaCc6zkly2Kr4YBtI58tuz2QyTE3SC
	yLM98/pOsa8ymwWCy0D4x3TA1+GIrKH7Q++lecbEnFtgjdEFGme7fk2yr w==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617965"
Received: from mail-bn3nam01lp2058.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.58])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:27:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=KYgkWVv3K+7b5++g31S6N/taT737miEvtdeuDvG/xNM=;
	b=UCFhqVlZhZC61ENLqf0D7fRwwfTDTt9/cMKu06z8hit8TkygdA0Rcc2QNTLocpWwS+vtOWnRlZQEOJqcGySIBs5Xz0HOXJr9/KTmcDIK+ZnHrxeKNu0FCpchoS1km2GL2bGE/RNqERRQpvwyxKFGynkNAwsaQ9rZS+ncodydDuY=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5319.namprd04.prod.outlook.com (20.178.49.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Sat, 20 Apr 2019 02:27:10 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:27:10 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 4/8] target/riscv: Add the MPV and MTL mstatus bits
Thread-Index: AQHU9yCO0d8tvYuUxkiKpuzvdvchWA==
Date: Sat, 20 Apr 2019 02:27:10 +0000
Message-ID:
 <0ce46ddcaf8009df9a4f53aa7516455c1dda016d.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR02CA0003.namprd02.prod.outlook.com
	(2603:10b6:a02:ee::16) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9bfff9c-6630-4837-b91c-08d6c537b113
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5319; 
x-ms-traffictypediagnostic: BYAPR04MB5319:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB53196BA97ADCA6B3F0BA16B890200@BYAPR04MB5319.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(50226002)(52116002)(6486002)(14454004)(446003)(6436002)(76176011)(476003)(486006)(3846002)(6116002)(97736004)(2616005)(7736002)(81156014)(8676002)(478600001)(8936002)(72206003)(386003)(6506007)(81166006)(102836004)(26005)(186003)(36756003)(316002)(6512007)(44832011)(53936002)(68736007)(66066001)(118296001)(25786009)(4326008)(305945005)(99286004)(54906003)(2906002)(11346002)(110136005)(2501003)(256004)(64756008)(66446008)(66556008)(73956011)(66946007)(66476007)(71200400001)(5660300002)(71190400001)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5319;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DZIcR47O1FjJ9zwGrMXxWAVDczTJj1ysR+KNgnhqw8OOEbKT/zElUswCNdGSqvpzv5qL4fikD5bOw3R5/ECwpmWvmlxXWkZWuCVsjSRkX4suZ/4z2i4s3Q+uV+aU0VP0fnnesYZYuvIXWjAma/kPJntQ/w0XnMkfv5bQi0rEygr4G8yHxhveWMJkXuhUVWGWov5Rq2hFvW/uOl51Fzr+Ac2TiLT4+T9fw0QT33Ebx5rj/592o8WdxTUx+MhMVeTzy0Qpz3hmdNVMUQs1SpRzVAh4enawAN14yGkok7DVihcK/I0qnOIT//hqcv6shPHzTQADbCEZU5BzagvcSieSyVF+8Ps2VBLHsBWzQjEz2oWFgj7/kVFqrSJM0XG6VQ7yk38zwDFP+eqh35yAHN+aSfwIjEJwuu8lBypnDzpiYc4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bfff9c-6630-4837-b91c-08d6c537b113
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:27:10.6618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5319
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 4/8] target/riscv: Add the MPV and MTL
 mstatus bits
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
Message-ID: <20190420022710.bAkg-u1v4Omckn1YRh2ivyDEhP_fvXjMPYSSt_eDCcY@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggfCA1ICsrLS0tDQogMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3Rhcmdl
dC9yaXNjdi9jcHVfYml0cy5oIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCmluZGV4IDk0NWFh
OGRiYjguLmZlNzE2NDc1NGIgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0K
KysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCkBAIC0zMTYsMTQgKzMxNiwxMSBAQA0KIC8q
IG1zdGF0dXMgQ1NSIGJpdHMgKi8NCiAjZGVmaW5lIE1TVEFUVVNfVUlFICAgICAgICAgMHgwMDAw
MDAwMQ0KICNkZWZpbmUgTVNUQVRVU19TSUUgICAgICAgICAweDAwMDAwMDAyDQotI2RlZmluZSBN
U1RBVFVTX0hJRSAgICAgICAgIDB4MDAwMDAwMDQNCiAjZGVmaW5lIE1TVEFUVVNfTUlFICAgICAg
ICAgMHgwMDAwMDAwOA0KICNkZWZpbmUgTVNUQVRVU19VUElFICAgICAgICAweDAwMDAwMDEwDQog
I2RlZmluZSBNU1RBVFVTX1NQSUUgICAgICAgIDB4MDAwMDAwMjANCi0jZGVmaW5lIE1TVEFUVVNf
SFBJRSAgICAgICAgMHgwMDAwMDA0MA0KICNkZWZpbmUgTVNUQVRVU19NUElFICAgICAgICAweDAw
MDAwMDgwDQogI2RlZmluZSBNU1RBVFVTX1NQUCAgICAgICAgIDB4MDAwMDAxMDANCi0jZGVmaW5l
IE1TVEFUVVNfSFBQICAgICAgICAgMHgwMDAwMDYwMA0KICNkZWZpbmUgTVNUQVRVU19NUFAgICAg
ICAgICAweDAwMDAxODAwDQogI2RlZmluZSBNU1RBVFVTX0ZTICAgICAgICAgIDB4MDAwMDYwMDAN
CiAjZGVmaW5lIE1TVEFUVVNfWFMgICAgICAgICAgMHgwMDAxODAwMA0KQEAgLTMzNSw2ICszMzIs
OCBAQA0KICNkZWZpbmUgTVNUQVRVU19UVk0gICAgICAgICAweDAwMTAwMDAwIC8qIHNpbmNlOiBw
cml2LTEuMTAgKi8NCiAjZGVmaW5lIE1TVEFUVVNfVFcgICAgICAgICAgMHgyMDAwMDAwMCAvKiBz
aW5jZTogcHJpdi0xLjEwICovDQogI2RlZmluZSBNU1RBVFVTX1RTUiAgICAgICAgIDB4NDAwMDAw
MDAgLyogc2luY2U6IHByaXYtMS4xMCAqLw0KKyNkZWZpbmUgTVNUQVRVU19NVEwgICAgICAgICAw
eDQwMDAwMDAwMDBVTEwNCisjZGVmaW5lIE1TVEFUVVNfTVBWICAgICAgICAgMHg4MDAwMDAwMDAw
VUxMDQogDQogI2RlZmluZSBNU1RBVFVTNjRfVVhMICAgICAgIDB4MDAwMDAwMDMwMDAwMDAwMFVM
TA0KICNkZWZpbmUgTVNUQVRVUzY0X1NYTCAgICAgICAweDAwMDAwMDBDMDAwMDAwMDBVTEwNCi0t
IA0KMi4yMS4wDQoNCg==

