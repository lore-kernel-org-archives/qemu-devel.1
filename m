Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B08C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B140B21855
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qBCN9QWx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BIJPkPmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B140B21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35902 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfpR-0003Mn-Us
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:34:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfj9-0006cH-Ty
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfj8-0003yz-SZ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfj8-0003t8-EW; Fri, 19 Apr 2019 22:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727259; x=1587263259;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=K4Kvrz/j8HNzqz5+WWgZJQxNceE4NLdO3mJ8GLMWWHc=;
	b=qBCN9QWxZlbN2ALAxajx2l9mpqRZ1Nja5ECmB3XcV4xfBpGVTj0G+ukZ
	fEo3XR/BBVfvQm2W9ONLWmf29d4yUZ/fpeCcvrzthFiG8pwmwrVoIIfgT
	cjXjk/0f2Ud13m9okIYKlTSzZMo0GsrjwFn4L/BzxOhNQjdUNmYJ06XUB
	D8+YZ8lLJkLxKVAzu/nEnJV/A/Yir4sZ2B6Y8li23nosk/d91Nve+iGDw
	aYGSrqYXicLH5c10TXm/K4yZKuQIdponxdmE1+t8DER4V2tKrrO3kUQTQ
	F3a4Hn8M/K0A0MDxbzbpTQijfdpgpjVR8cI/sCWDimcy9wlQ5ZYShcymM w==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617973"
Received: from mail-bn3nam01lp2052.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.52])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:27:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=K4Kvrz/j8HNzqz5+WWgZJQxNceE4NLdO3mJ8GLMWWHc=;
	b=BIJPkPmr99pBoIaCjrStt7BHhGPILMctqv4raCfhT1xqJ4rYi1Zc4+gNsW7gRoNjLJLlwHDn0G27e5xYUwXlfPgGRKcAchdDJs7gK6AFppijWqMyjwGrT6DaxQWMDnxIkX5ZpNJmE4w5fn8LgfgqdhELXsxfYeYu2rdpi89v1+k=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5319.namprd04.prod.outlook.com (20.178.49.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Sat, 20 Apr 2019 02:27:35 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:27:35 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 7/8] target/riscv: Add the HSTATUS register masks
Thread-Index: AQHU9yCd9DDS05lKtkqdW1tD5SRAVg==
Date: Sat, 20 Apr 2019 02:27:35 +0000
Message-ID:
 <fee652e087d5bed01cccc67950cc49bf05268157.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR08CA0010.namprd08.prod.outlook.com
	(2603:10b6:a03:100::23) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76660d64-6af8-48a8-794b-08d6c537bfd6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5319; 
x-ms-traffictypediagnostic: BYAPR04MB5319:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5319B62BCE3D7454D4F84CD690200@BYAPR04MB5319.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(50226002)(52116002)(6486002)(14454004)(446003)(6436002)(76176011)(476003)(486006)(3846002)(6116002)(97736004)(2616005)(7736002)(81156014)(8676002)(478600001)(8936002)(72206003)(386003)(6506007)(81166006)(102836004)(26005)(186003)(36756003)(316002)(6512007)(44832011)(53936002)(68736007)(66066001)(118296001)(25786009)(4326008)(305945005)(99286004)(54906003)(2906002)(11346002)(110136005)(2501003)(256004)(64756008)(66446008)(66556008)(73956011)(66946007)(4744005)(66476007)(71200400001)(5660300002)(71190400001)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5319;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gFFXL5hOWDUW7BkKanWwiVPt+rEeuflfM+ENZ5xxRX2voxUlvE2FkVzYXn4d03ZfsndRLk7zHE2dPIQetXhegc05jvMmiuqRtOBrTckuIzQe4ExmW3sJhciWZVNFMSXuUwOiTfBPQkEtCEqEgD6CoQjwOwXYHpIQxTDStwbFbEctq3bzf4MytWCVxp32BMflRIx8rswAFsyHe+6MTDUyItnt26rklOwDcOhW119PQ0wZk7hwPo4WfmMuiegsV7S2MhyWWiiHaC3lKHRNKjAUekulHeqPtKpaYjHiiOg94lswrH3Iu9YejCAPCSNLtDk9KjkjM4SZiUhvLL2CE7gQMtGWZiSOho4jTIwAN2Yv0Yj6DGkLUjOovWyCW87W7y/h703ZrJ/eWmG09VggMdFAqWqFnMC7XPUJh21oCnI+CSc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76660d64-6af8-48a8-794b-08d6c537bfd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:27:35.5573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5319
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 7/8] target/riscv: Add the HSTATUS register
 masks
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
Message-ID: <20190420022735.qS5SnUKZsE_y-2O_g-iOaGNofgkkkGHBX41pGi_1AwY@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggfCAxOCArKysrKysrKysrKysrKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L2NwdV9iaXRzLmggYi90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KaW5kZXggNTJjMjE2
OTk3Ny4uYTE3OTEzN2JjMSAxMDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oDQor
KysgYi90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KQEAgLTM4Miw2ICszODIsMjQgQEANCiAjZGVm
aW5lIFNTVEFUVVNfU0QgU1NUQVRVUzY0X1NEDQogI2VuZGlmDQogDQorLyogaHN0YXR1cyBDU1Ig
Yml0cyAqLw0KKyNkZWZpbmUgSFNUQVRVU19TUFJWICAgICAgICAgMHgwMDAwMDAwMQ0KKyNkZWZp
bmUgSFNUQVRVU19TVEwgICAgICAgICAgMHgwMDAwMDA0MA0KKyNkZWZpbmUgSFNUQVRVU19TUFYg
ICAgICAgICAgMHgwMDAwMDA4MA0KKyNkZWZpbmUgSFNUQVRVU19TUDJQICAgICAgICAgMHgwMDAw
MDEwMA0KKyNkZWZpbmUgSFNUQVRVU19TUDJWICAgICAgICAgMHgwMDAwMDIwMA0KKyNkZWZpbmUg
SFNUQVRVU19WVFZNICAgICAgICAgMHgwMDEwMDAwMA0KKyNkZWZpbmUgSFNUQVRVU19WVFNSICAg
ICAgICAgMHgwMDQwMDAwMA0KKw0KKyNkZWZpbmUgSFNUQVRVUzMyX1dQUkkgICAgICAgMHhGRjhG
Rjg3RQ0KKyNkZWZpbmUgSFNUQVRVUzY0X1dQUkkgICAgICAgMHhGRkZGRkZGRkZGOEZGODdFVUxM
DQorDQorI2lmIGRlZmluZWQoVEFSR0VUX1JJU0NWMzIpDQorI2RlZmluZSBIU1RBVFVTX1dQUkkg
SFNUQVRVUzMyX1dQUkkNCisjZWxpZiBkZWZpbmVkKFRBUkdFVF9SSVNDVjY0KQ0KKyNkZWZpbmUg
SFNUQVRVU19XUFJJIEhTVEFUVVM2NF9XUFJJDQorI2VuZGlmDQorDQogLyogUHJpdmlsZWdlIG1v
ZGVzICovDQogI2RlZmluZSBQUlZfVSAwDQogI2RlZmluZSBQUlZfUyAxDQotLSANCjIuMjEuMA0K
DQo=

