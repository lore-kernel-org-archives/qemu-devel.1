Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBB6C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0442183F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B7g7Q2iP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OShhFyBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0442183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35776 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfhx-00050v-22
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:26:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfg0-0003O9-U0
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffP-0002CL-Eu
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:23:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffO-00027f-9Y; Fri, 19 Apr 2019 22:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727027; x=1587263027;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=VhlFS4wWGVfvKnjFYtcxDbBd75J46iCic0zcDF/h6UM=;
	b=B7g7Q2iPK1wzxuUcnEnvudbN4gh6FpFUH6kHt6f2dlN1ffUBnu32tuBq
	uFmmKAsv4pASCa9P+Y78B2mEgFOooMm90P4P8ZvCEyUjQtnRI0BkyRgAn
	udYSvTZEuFybBlW1JLAKGmnwHXhZGDtRMqjjj13RxHqEvqycoxz0A1SZd
	qNINuo2UMZjTJB/DFawTzNivO0q82Bby3GfeFSt/5lI6Yw/Nxc7GCvem+
	kdRGsPBC4KLCDepfez8hAWRejtA4vKETH9iuvs/lLqxYQmEaet2QoOJ47
	LY2dng6Uf9QRRr+PBAgwNClaufh2n0OeAZ63UROJ2bE68Qaw5KbQuU01w A==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617866"
Received: from mail-by2nam03lp2053.outbound.protection.outlook.com (HELO
	NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.53])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:23:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VhlFS4wWGVfvKnjFYtcxDbBd75J46iCic0zcDF/h6UM=;
	b=OShhFyBAmiP+L0OzFfAS2n9Y/m/MCtMIupOEmvsFq34+9aN2sk5fkFZl/etZ1zL6sixEXuvuZ809YerD5sGvB8G9pCtx7U+qp2Pkd/ScC1eahDxY1EuSP4JXizzYYpHfNhNATFH5g1esSw4lDxhc4cDt8yKdmo20Dh5oznDrtBA=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB3943.namprd04.prod.outlook.com (52.135.215.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Sat, 20 Apr 2019 02:23:45 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:23:45 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 1/6] linux-user/riscv: Add the CPU type as a comment
Thread-Index: AQHU9yAU2SbW/ZkF0ECJ7bcQE6RRZw==
Date: Sat, 20 Apr 2019 02:23:44 +0000
Message-ID:
 <7d7b75ffdb42418d9c949eff7e35aa9d5ecf504a.1555726824.git.alistair.francis@wdc.com>
References: <cover.1555726824.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555726824.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48)
	To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b089df7d-5404-4a65-5070-08d6c5373674
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB3943; 
x-ms-traffictypediagnostic: BYAPR04MB3943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB3943C0ECFD2235117A82A90A90200@BYAPR04MB3943.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(14454004)(446003)(2501003)(6486002)(53936002)(6436002)(50226002)(97736004)(5660300002)(4326008)(305945005)(71200400001)(86362001)(81166006)(8936002)(7736002)(8676002)(71190400001)(73956011)(68736007)(6512007)(4744005)(25786009)(66946007)(81156014)(66446008)(64756008)(66476007)(66556008)(2906002)(256004)(6116002)(3846002)(36756003)(478600001)(72206003)(99286004)(44832011)(52116002)(66066001)(76176011)(110136005)(386003)(6506007)(102836004)(26005)(186003)(316002)(118296001)(54906003)(2616005)(486006)(476003)(11346002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3943;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TZwwzOQhhZ/O2a+6qlW5YZ3uNrcV4kJHwiZfmY9Jhg7/jd/l0rAUML4YaONRUXlQr+X7TE1aFn1biib/uyd4GpnrA6jnAVhutjA92Cv8pg0ebipP1a4sl1EJ9GY5uRMjfMBIwq2V0iGKIGYjhPr1tyUnEP9HRe4h42YXLaQ25S7fadcykVg4QmUS6p4oCTJL60k+Oikf3QxpSkOxRRMQqLVX7RApaioxuZb6l+s2PfZUfdkHGJWzhSptDQjMh5SS04BBBuYQ10aJgSZ5n50YWhTp4eG9AdaZ86RxIrZ4hS03W0KTsAiDaKMKXAbB19zPRtEe9GxuFnu1i5V9teCS0g2nUD95uSH5TYmvQptbpSdcyx+IGR0jNb3fkv5X+DYy1lCZwNptaEg/xX+mUkzDeFq1dSpv40Iu4vn/ZYHrNR8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b089df7d-5404-4a65-5070-08d6c5373674
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:23:45.0301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 1/6] linux-user/riscv: Add the CPU type as a
 comment
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
	"imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190420022344.Clz1Vj3H3KH4p7Gf17zg-L0SWATszaFcAyu8es4J4Jo@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogbGludXgtdXNlci9yaXNjdi90YXJnZXRfZWxmLmggfCAxICsNCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvcmlzY3YvdGFy
Z2V0X2VsZi5oIGIvbGludXgtdXNlci9yaXNjdi90YXJnZXRfZWxmLmgNCmluZGV4IGE2NzE2YTZh
YWMuLjlkZDY1NjUyZWUgMTAwNjQ0DQotLS0gYS9saW51eC11c2VyL3Jpc2N2L3RhcmdldF9lbGYu
aA0KKysrIGIvbGludXgtdXNlci9yaXNjdi90YXJnZXRfZWxmLmgNCkBAIC05LDYgKzksNyBAQA0K
ICNkZWZpbmUgUklTQ1ZfVEFSR0VUX0VMRl9IDQogc3RhdGljIGlubGluZSBjb25zdCBjaGFyICpj
cHVfZ2V0X21vZGVsKHVpbnQzMl90IGVmbGFncykNCiB7DQorICAgIC8qIFRZUEVfUklTQ1ZfQ1BV
X0FOWSAqLw0KICAgICByZXR1cm4gImFueSI7DQogfQ0KICNlbmRpZg0KLS0gDQoyLjIxLjANCg0K

