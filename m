Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561D6C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8DA21479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ev1FE81J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jNX50Kkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8DA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfrx-0005Vn-BB
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:36:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfjJ-0006kf-3i
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfjI-00045I-9x
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfjH-00044i-B5; Fri, 19 Apr 2019 22:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727268; x=1587263268;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=J7I4423ihyshSLrpJhMthxeHoJaEQpRuUgOBKuHYFbI=;
	b=Ev1FE81JTB3yyZvffp2Bg3I/Lvd/x8bxPiVlINSPvK+GMrAsX0uJVChD
	2BoBPoVFRvBomT7B+CX7GwtMebtafQCPwk6rlwucqttYVsVejnJ6NUxin
	cMMzu+UffxwHgOr8e0tJw+MSEZxozXojZLQ+M6Y2t+QAAoRQeQVQMZ1nA
	l5jGkafe9B2aqiuOngKHLLKtR3yUmdk9RpPia3fZSKk+PdgcW/nDyWuj2
	nrSon+hSX/wYqqSRfgmagaq1DU2ANQ1lHdA0SAJ4BperNhwWAcUiZsjub
	hw6qE3ZIxZk/0UCpevcEG8fNgvAPhCBlf5OkLRP1bso8NUu5+P0nJK9DU A==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617999"
Received: from mail-bn3nam01lp2056.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.56])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:27:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=J7I4423ihyshSLrpJhMthxeHoJaEQpRuUgOBKuHYFbI=;
	b=jNX50Kkc5TLhjhAyS7uXZ8bz8jXToGSy5pdHL9umlQX5OXelfPopGon+7S5F8GMDIj0SEPiAqulT0vNoJYWIg63EkC2gzF2ZW4Dsi+2BZM01oqnHKjBMrFeNRUeTS0le9phmbZ23c0G+N5o7RXTSS8295883+T83MoHipIg+pSI=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5319.namprd04.prod.outlook.com (20.178.49.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Sat, 20 Apr 2019 02:27:44 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:27:44 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 8/8] target/riscv: Add the HGATP register masks
Thread-Index: AQHU9yCiCAsAIdrtYEmKBbky+tM4/g==
Date: Sat, 20 Apr 2019 02:27:43 +0000
Message-ID:
 <b91bacd428706e5cb44e4db83c75f7a03d6fae2b.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR05CA0002.namprd05.prod.outlook.com
	(2603:10b6:a03:c0::15) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66232298-fecb-4e2e-7b7c-08d6c537c4e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5319; 
x-ms-traffictypediagnostic: BYAPR04MB5319:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5319526CA5E548A2A384277490200@BYAPR04MB5319.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(50226002)(52116002)(6486002)(14454004)(446003)(6436002)(76176011)(476003)(486006)(3846002)(6116002)(97736004)(2616005)(7736002)(81156014)(8676002)(478600001)(8936002)(72206003)(386003)(6506007)(81166006)(102836004)(26005)(186003)(36756003)(316002)(6512007)(44832011)(53936002)(68736007)(66066001)(118296001)(25786009)(4326008)(305945005)(99286004)(54906003)(2906002)(11346002)(110136005)(2501003)(256004)(64756008)(66446008)(66556008)(73956011)(66946007)(4744005)(66476007)(71200400001)(5660300002)(71190400001)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5319;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ooP5CuqNuqBQRrPfyA3Qsuw4Vui5goeMarQdbN2X77LJajD9IXYSLiCYyY/NFo8FuKg9YEwyxJkdX4zvqIXnV6khAQczOItI5axMBzZWm12sMAL/urU7AeyEwZ9dxFueU1X6a1CpqS6uiL3vdzQBfBeQ37BQhGjFeT3z7yGux3d8TonrQIXSnRnr0NvZiL/XQ20UT6E/1iejXxeW8BLslRBWfGyrPzVjZE9RmgGOAU98wH2U56ZKSHUfT/i2tGCYeJNJkyT6wfz3GPxXh0MGle9BCvvGLO2MjvBqUythy2nZmXvKrIYb/O6EOrKYv2NX+2JzRchaJbusJTcrk9PqqLWIFwMxY8zrptH9j52pn63FFJnm9pHQgvsVqNx9K5sIJFHTwia3sKqXVQ9cbFS5TXLT+Cr30ZeBA8YAH9jV8/8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66232298-fecb-4e2e-7b7c-08d6c537c4e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:27:43.9032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5319
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 8/8] target/riscv: Add the HGATP register
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
Message-ID: <20190420022743.Q7F8t0w5dCjf5zUq9FIBhQqlZrc2HVLv2WIM8dWi0ic@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggfCAxMSArKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yv
Y3B1X2JpdHMuaCBiL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oDQppbmRleCBhMTc5MTM3YmMxLi5k
YzlkNTNkNGJlIDEwMDY0NA0KLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCisrKyBiL3Rh
cmdldC9yaXNjdi9jcHVfYml0cy5oDQpAQCAtMjA4LDYgKzIwOCwxNyBAQA0KICNkZWZpbmUgQ1NS
X0hJREVMRUcgICAgICAgICAweGEwMw0KICNkZWZpbmUgQ1NSX0hHQVRQICAgICAgICAgICAweGE4
MA0KIA0KKyNpZiBkZWZpbmVkKFRBUkdFVF9SSVNDVjMyKQ0KKyNkZWZpbmUgSEdBVFBfTU9ERSAg
ICAgICAgICAgU0FUUDMyX01PREUNCisjZGVmaW5lIEhHQVRQX0FTSUQgICAgICAgICAgIFNBVFAz
Ml9BU0lEDQorI2RlZmluZSBIR0FUUF9QUE4gICAgICAgICAgICBTQVRQMzJfUFBODQorI2VuZGlm
DQorI2lmIGRlZmluZWQoVEFSR0VUX1JJU0NWNjQpDQorI2RlZmluZSBIR0FUUF9NT0RFICAgICAg
ICAgICBTQVRQNjRfTU9ERQ0KKyNkZWZpbmUgSEdBVFBfQVNJRCAgICAgICAgICAgU0FUUDY0X0FT
SUQNCisjZGVmaW5lIEhHQVRQX1BQTiAgICAgICAgICAgIFNBVFA2NF9QUE4NCisjZW5kaWYNCisN
CiAvKiBQZXJmb3JtYW5jZSBDb3VudGVycyAqLw0KICNkZWZpbmUgQ1NSX01IUE1DT1VOVEVSMyAg
ICAweGIwMw0KICNkZWZpbmUgQ1NSX01IUE1DT1VOVEVSNCAgICAweGIwNA0KLS0gDQoyLjIxLjAN
Cg0K

