Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25649C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D6620820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YH1b1jFF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Iah+QIsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D6620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39031 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEMWc-0000QM-L5
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 19:21:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMV1-0007jM-3C
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMPB-0002cF-Vc
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:13:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMP3-000102-9k; Wed, 10 Apr 2019 19:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1554937993; x=1586473993;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=uUPkWOcH1kBmDEJ/qYius5i+2srCWZ636K70YvYZtYk=;
	b=YH1b1jFFun985djxtvt0hIjJC21tmzPIq0UUTaDMYjTade3kV/Gh7wrl
	eeEpz6s3ZQNJnHdB06+joUoi96dFSMAWRTKka7hXCKWdpjLImd0r0MS54
	xUen1qj4/jHUmgVzX5T57Ti8kHXbeu9CJwHN5aQV+mI6PKt/m+QrA0cAx
	4fSY5CmsQ09VChmOGpnf3CzDT6qzzf4jKV/Xxd9vYwe1yVvtPOi2v7Di4
	EyNB7EAIbrfI7etKOaxrw4rXCyr6NDD19eYv+CNMmZIei0bwFjxlma6qR
	HVVOF78gbqM6Fyln68+azlUBzqdnRQeXwu+cgfsRFfrF5AyhMQyQQzUBP w==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; d="scan'208";a="106823624"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO
	NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
	by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:11:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=uUPkWOcH1kBmDEJ/qYius5i+2srCWZ636K70YvYZtYk=;
	b=Iah+QIsf2uJhZfoEk5ZSzziwOmek50CuhvygROgwsJR6BRBTPNTxEGLIiaepu+8NmoJfYdlNCcrLnVOozy71pO6b5vP/R+XV5eP98kUNlt5yn9uV0F8bVQG5iBO4VV2amMnx2Fd7aa/YCMJJDmWc18fElDdwCX2RYoiC/50nDlE=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5334.namprd04.prod.outlook.com (20.178.50.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Wed, 10 Apr 2019 23:11:00 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1771.021;
	Wed, 10 Apr 2019 23:11:00 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH for 4.1 v3 6/6] riscv: Add a generic spike machine
Thread-Index: AQHU7/KpU18yrVox40Gs1T+H8rjZ+g==
Date: Wed, 10 Apr 2019 23:11:00 +0000
Message-ID:
 <9043c3a6bc54faa98ed9fedc0c6c929c993a0bf9.1554937288.git.alistair.francis@wdc.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1554937288.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR08CA0015.namprd08.prod.outlook.com
	(2603:10b6:a03:100::28) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efc286c0-f9d4-4163-6c4a-08d6be09cbe1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5334; 
x-ms-traffictypediagnostic: BYAPR04MB5334:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB533413738B2C42C137A8A7A2902E0@BYAPR04MB5334.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(99286004)(11346002)(8936002)(14454004)(2616005)(6486002)(305945005)(6436002)(478600001)(97736004)(14444005)(446003)(71190400001)(118296001)(2501003)(66066001)(476003)(4326008)(256004)(44832011)(71200400001)(486006)(86362001)(102836004)(186003)(36756003)(81156014)(72206003)(3846002)(8676002)(25786009)(386003)(6506007)(5660300002)(53936002)(7736002)(50226002)(106356001)(105586002)(2906002)(68736007)(6116002)(54906003)(26005)(316002)(6512007)(81166006)(110136005)(52116002)(76176011)(41533002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5334;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PULP7o8J/TpqX2a62eZYu+B8bYbRgNKIZ70DVUT0Qip6fECZcbHTCm+BvlXXBVjyCFezh7lG19LHqmMoxPhnSe0CCsFz7MxFVhSN9FS6djHCJCSXm/71b+q5khW+tZG8uicQPRUBUE6jhk2e0/2SZf0Lq6+IJyfn+JnaofrwalQ7UNxgx0G96dEBGOrgh2ejb1okOKR6dplaZQxVAlPHaME9IlM27zDq9HR07s+xtJiisFDIphqTRKL273Pf/4bbEghrGwDYPI1x9+yTEuSEJ22I85PNiGze/+1MpjmRMmHR+QCgJTVs/++ftKPf0rKAQPVqKf9kvVOoIEGbnnVtXBuXr4ttm2+FfRUxpjdncCQTRz30rTaXlkgU9StmX9NPIcw1EMLWdguISfoQnjMUZJi0A3xFGynWjHxFpEypCwY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc286c0-f9d4-4163-6c4a-08d6be09cbe1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 23:11:00.7007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH for 4.1 v3 6/6] riscv: Add a generic spike
 machine
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
Message-ID: <20190410231100.tt7lJKQJdpo5P8Tz9QP_N_CRDym8NipAa6Fvd0vxknM@z>

QWRkIGEgZ2VuZXJpYyBzcGlrZSBtYWNoaW5lIChub3QgdGllZCB0byBhIHZlcnNpb24pIGFuZCBk
ZXByZWNhdGUgdGhlDQpzcGlrZSBtYWhpbmVzIHRoYXQgYXJlIHRpZWQgdG8gYSBzcGVjaWZpYyB2
ZXJzaW9uLiBBcyB3ZSBjYW4gbm93IHNwZWNpZnkNCnRoZSBDUFUgdmlhIHRoZSBjb21tYW5kIGxp
bmUgd2Ugbm8gbG9uZGVyIG5lZWQgc3BlY2lmaWMgdmVyc2lvbnMgb2YgdGhlDQpzcGlrZSBtYWNo
aW5lcy4NCg0KU2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNp
c0B3ZGMuY29tPg0KLS0tDQogaHcvcmlzY3Yvc3Bpa2UuYyB8IDEwNiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMDUgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvcmlzY3Yvc3Bpa2Uu
YyBiL2h3L3Jpc2N2L3NwaWtlLmMNCmluZGV4IDJhMDAwYTU4MDAuLjlkM2Y3Y2VjNGQgMTAwNjQ0
DQotLS0gYS9ody9yaXNjdi9zcGlrZS5jDQorKysgYi9ody9yaXNjdi9zcGlrZS5jDQpAQCAtMzks
NiArMzksNyBAQA0KICNpbmNsdWRlICJjaGFyZGV2L2NoYXIuaCINCiAjaW5jbHVkZSAic3lzZW11
L2FyY2hfaW5pdC5oIg0KICNpbmNsdWRlICJzeXNlbXUvZGV2aWNlX3RyZWUuaCINCisjaW5jbHVk
ZSAic3lzZW11L3F0ZXN0LmgiDQogI2luY2x1ZGUgImV4ZWMvYWRkcmVzcy1zcGFjZXMuaCINCiAj
aW5jbHVkZSAiZWxmLmgiDQogDQpAQCAtMTYwLDcgKzE2MSw4OSBAQCBzdGF0aWMgdm9pZCBjcmVh
dGVfZmR0KFNwaWtlU3RhdGUgKnMsIGNvbnN0IHN0cnVjdCBNZW1tYXBFbnRyeSAqbWVtbWFwLA0K
ICAgICAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUoZmR0LCAiL2Nob3NlbiIpOw0KICAgICAgICAg
cWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcoZmR0LCAiL2Nob3NlbiIsICJib290YXJncyIsIGNtZGxp
bmUpOw0KICAgICB9DQotIH0NCit9DQorDQorc3RhdGljIHZvaWQgc3Bpa2VfYm9hcmRfaW5pdChN
YWNoaW5lU3RhdGUgKm1hY2hpbmUpDQorew0KKyAgICBjb25zdCBzdHJ1Y3QgTWVtbWFwRW50cnkg
Km1lbW1hcCA9IHNwaWtlX21lbW1hcDsNCisNCisgICAgU3Bpa2VTdGF0ZSAqcyA9IGdfbmV3MChT
cGlrZVN0YXRlLCAxKTsNCisgICAgTWVtb3J5UmVnaW9uICpzeXN0ZW1fbWVtb3J5ID0gZ2V0X3N5
c3RlbV9tZW1vcnkoKTsNCisgICAgTWVtb3J5UmVnaW9uICptYWluX21lbSA9IGdfbmV3KE1lbW9y
eVJlZ2lvbiwgMSk7DQorICAgIE1lbW9yeVJlZ2lvbiAqbWFza19yb20gPSBnX25ldyhNZW1vcnlS
ZWdpb24sIDEpOw0KKyAgICBpbnQgaTsNCisNCisgICAgLyogSW5pdGlhbGl6ZSBTT0MgKi8NCisg
ICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQoT0JKRUNUKG1hY2hpbmUpLCAic29jIiwgJnMtPnNv
Yywgc2l6ZW9mKHMtPnNvYyksDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfUklT
Q1ZfSEFSVF9BUlJBWSwgJmVycm9yX2Fib3J0LCBOVUxMKTsNCisgICAgb2JqZWN0X3Byb3BlcnR5
X3NldF9zdHIoT0JKRUNUKCZzLT5zb2MpLCBtYWNoaW5lLT5jcHVfdHlwZSwgImNwdS10eXBlIiwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCisgICAgb2JqZWN0
X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5zb2MpLCBzbXBfY3B1cywgIm51bS1oYXJ0cyIs
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQorICAgIG9iamVj
dF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1QoJnMtPnNvYyksIHRydWUsICJyZWFsaXplZCIsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQorDQorICAgIC8qIHJl
Z2lzdGVyIHN5c3RlbSBtYWluIG1lbW9yeSAoYWN0dWFsIFJBTSkgKi8NCisgICAgbWVtb3J5X3Jl
Z2lvbl9pbml0X3JhbShtYWluX21lbSwgTlVMTCwgInJpc2N2LnNwaWtlLnJhbSIsDQorICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbWFjaGluZS0+cmFtX3NpemUsICZlcnJvcl9mYXRhbCk7DQor
ICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihzeXN0ZW1fbWVtb3J5LCBtZW1tYXBbU1BJ
S0VfRFJBTV0uYmFzZSwNCisgICAgICAgIG1haW5fbWVtKTsNCisNCisgICAgLyogY3JlYXRlIGRl
dmljZSB0cmVlICovDQorICAgIGNyZWF0ZV9mZHQocywgbWVtbWFwLCBtYWNoaW5lLT5yYW1fc2l6
ZSwgbWFjaGluZS0+a2VybmVsX2NtZGxpbmUpOw0KKw0KKyAgICAvKiBib290IHJvbSAqLw0KKyAg
ICBtZW1vcnlfcmVnaW9uX2luaXRfcm9tKG1hc2tfcm9tLCBOVUxMLCAicmlzY3Yuc3Bpa2UubXJv
bSIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtbWFwW1NQSUtFX01ST01dLnNpemUs
ICZlcnJvcl9mYXRhbCk7DQorICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihzeXN0ZW1f
bWVtb3J5LCBtZW1tYXBbU1BJS0VfTVJPTV0uYmFzZSwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG1hc2tfcm9tKTsNCisNCisgICAgaWYgKG1hY2hpbmUtPmtlcm5lbF9maWxlbmFt
ZSkgew0KKyAgICAgICAgbG9hZF9rZXJuZWwobWFjaGluZS0+a2VybmVsX2ZpbGVuYW1lKTsNCisg
ICAgfQ0KKw0KKyAgICAvKiByZXNldCB2ZWN0b3IgKi8NCisgICAgdWludDMyX3QgcmVzZXRfdmVj
WzhdID0gew0KKyAgICAgICAgMHgwMDAwMDI5NywgICAgICAgICAgICAgICAgICAvKiAxOiAgYXVp
cGMgIHQwLCAlcGNyZWxfaGkoZHRiKSAqLw0KKyAgICAgICAgMHgwMjAyODU5MywgICAgICAgICAg
ICAgICAgICAvKiAgICAgYWRkaSAgIGExLCB0MCwgJXBjcmVsX2xvKDFiKSAqLw0KKyAgICAgICAg
MHhmMTQwMjU3MywgICAgICAgICAgICAgICAgICAvKiAgICAgY3NyciAgIGEwLCBtaGFydGlkICAq
Lw0KKyNpZiBkZWZpbmVkKFRBUkdFVF9SSVNDVjMyKQ0KKyAgICAgICAgMHgwMTgyYTI4MywgICAg
ICAgICAgICAgICAgICAvKiAgICAgbHcgICAgIHQwLCAyNCh0MCkgKi8NCisjZWxpZiBkZWZpbmVk
KFRBUkdFVF9SSVNDVjY0KQ0KKyAgICAgICAgMHgwMTgyYjI4MywgICAgICAgICAgICAgICAgICAv
KiAgICAgbGQgICAgIHQwLCAyNCh0MCkgKi8NCisjZW5kaWYNCisgICAgICAgIDB4MDAwMjgwNjcs
ICAgICAgICAgICAgICAgICAgLyogICAgIGpyICAgICB0MCAqLw0KKyAgICAgICAgMHgwMDAwMDAw
MCwNCisgICAgICAgIG1lbW1hcFtTUElLRV9EUkFNXS5iYXNlLCAgICAgLyogc3RhcnQ6IC5kd29y
ZCBEUkFNX0JBU0UgKi8NCisgICAgICAgIDB4MDAwMDAwMDAsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC8qIGR0YjogKi8NCisgICAgfTsNCisNCisgICAgLyogY29weSBp
biB0aGUgcmVzZXQgdmVjdG9yIGluIGxpdHRsZV9lbmRpYW4gYnl0ZSBvcmRlciAqLw0KKyAgICBm
b3IgKGkgPSAwOyBpIDwgc2l6ZW9mKHJlc2V0X3ZlYykgPj4gMjsgaSsrKSB7DQorICAgICAgICBy
ZXNldF92ZWNbaV0gPSBjcHVfdG9fbGUzMihyZXNldF92ZWNbaV0pOw0KKyAgICB9DQorICAgIHJv
bV9hZGRfYmxvYl9maXhlZF9hcygibXJvbS5yZXNldCIsIHJlc2V0X3ZlYywgc2l6ZW9mKHJlc2V0
X3ZlYyksDQorICAgICAgICAgICAgICAgICAgICAgICAgICBtZW1tYXBbU1BJS0VfTVJPTV0uYmFz
ZSwgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsNCisNCisgICAgLyogY29weSBpbiB0aGUgZGV2aWNl
IHRyZWUgKi8NCisgICAgaWYgKGZkdF9wYWNrKHMtPmZkdCkgfHwgZmR0X3RvdGFsc2l6ZShzLT5m
ZHQpID4NCisgICAgICAgICAgICBtZW1tYXBbU1BJS0VfTVJPTV0uc2l6ZSAtIHNpemVvZihyZXNl
dF92ZWMpKSB7DQorICAgICAgICBlcnJvcl9yZXBvcnQoIm5vdCBlbm91Z2ggc3BhY2UgdG8gc3Rv
cmUgZGV2aWNlLXRyZWUiKTsNCisgICAgICAgIGV4aXQoMSk7DQorICAgIH0NCisgICAgcWVtdV9m
ZHRfZHVtcGR0YihzLT5mZHQsIGZkdF90b3RhbHNpemUocy0+ZmR0KSk7DQorICAgIHJvbV9hZGRf
YmxvYl9maXhlZF9hcygibXJvbS5mZHQiLCBzLT5mZHQsIGZkdF90b3RhbHNpemUocy0+ZmR0KSwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgIG1lbW1hcFtTUElLRV9NUk9NXS5iYXNlICsgc2l6
ZW9mKHJlc2V0X3ZlYyksDQorICAgICAgICAgICAgICAgICAgICAgICAgICAmYWRkcmVzc19zcGFj
ZV9tZW1vcnkpOw0KKw0KKyAgICAvKiBpbml0aWFsaXplIEhUSUYgdXNpbmcgc3ltYm9scyBmb3Vu
ZCBpbiBsb2FkX2tlcm5lbCAqLw0KKyAgICBodGlmX21tX2luaXQoc3lzdGVtX21lbW9yeSwgbWFz
a19yb20sICZzLT5zb2MuaGFydHNbMF0uZW52LCBzZXJpYWxfaGQoMCkpOw0KKw0KKyAgICAvKiBD
b3JlIExvY2FsIEludGVycnVwdG9yICh0aW1lciBhbmQgSVBJKSAqLw0KKyAgICBzaWZpdmVfY2xp
bnRfY3JlYXRlKG1lbW1hcFtTUElLRV9DTElOVF0uYmFzZSwgbWVtbWFwW1NQSUtFX0NMSU5UXS5z
aXplLA0KKyAgICAgICAgc21wX2NwdXMsIFNJRklWRV9TSVBfQkFTRSwgU0lGSVZFX1RJTUVDTVBf
QkFTRSwgU0lGSVZFX1RJTUVfQkFTRSk7DQorfQ0KIA0KIHN0YXRpYyB2b2lkIHNwaWtlX3YxXzEw
XzBfYm9hcmRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQogew0KQEAgLTE3Miw2ICsyNTUs
MTIgQEAgc3RhdGljIHZvaWQgc3Bpa2VfdjFfMTBfMF9ib2FyZF9pbml0KE1hY2hpbmVTdGF0ZSAq
bWFjaGluZSkNCiAgICAgTWVtb3J5UmVnaW9uICptYXNrX3JvbSA9IGdfbmV3KE1lbW9yeVJlZ2lv
biwgMSk7DQogICAgIGludCBpOw0KIA0KKyAgICBpZiAoIXF0ZXN0X2VuYWJsZWQoKSkgew0KKyAg
ICAgICAgaW5mb19yZXBvcnQoIlRoZSBTcGlrZSB2MS4xMC4wIG1hY2hpbmUgaGFzIGJlZW4gZGVw
cmVjZWF0ZWQuICINCisgICAgICAgICAgICAgICAgICAgICJQbGVhc2UgdXNlIHRoZSBkZW5lcmlj
IHNwaWtlIG1hY2hpbmUgYW5kIHNwZWNpZnkgdGhlIElTQSAiDQorICAgICAgICAgICAgICAgICAg
ICAidmVyc2lvbnMgdXNpbmcgLWNwdS4iKTsNCisgICAgfQ0KKw0KICAgICAvKiBJbml0aWFsaXpl
IFNPQyAqLw0KICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChPQkpFQ1QobWFjaGluZSksICJz
b2MiLCAmcy0+c29jLCBzaXplb2Yocy0+c29jKSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgVFlQRV9SSVNDVl9IQVJUX0FSUkFZLCAmZXJyb3JfYWJvcnQsIE5VTEwpOw0KQEAgLTI1NCw2
ICszNDMsMTIgQEAgc3RhdGljIHZvaWQgc3Bpa2VfdjFfMDlfMV9ib2FyZF9pbml0KE1hY2hpbmVT
dGF0ZSAqbWFjaGluZSkNCiAgICAgTWVtb3J5UmVnaW9uICptYXNrX3JvbSA9IGdfbmV3KE1lbW9y
eVJlZ2lvbiwgMSk7DQogICAgIGludCBpOw0KIA0KKyAgICBpZiAoIXF0ZXN0X2VuYWJsZWQoKSkg
ew0KKyAgICAgICAgaW5mb19yZXBvcnQoIlRoZSBTcGlrZSB2MS4wOS4xIG1hY2hpbmUgaGFzIGJl
ZW4gZGVwcmVjZWF0ZWQuICINCisgICAgICAgICAgICAgICAgICAgICJQbGVhc2UgdXNlIHRoZSBk
ZW5lcmljIHNwaWtlIG1hY2hpbmUgYW5kIHNwZWNpZnkgdGhlIElTQSAiDQorICAgICAgICAgICAg
ICAgICAgICAidmVyc2lvbnMgdXNpbmcgLWNwdS4iKTsNCisgICAgfQ0KKw0KICAgICAvKiBJbml0
aWFsaXplIFNPQyAqLw0KICAgICBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZChPQkpFQ1QobWFjaGlu
ZSksICJzb2MiLCAmcy0+c29jLCBzaXplb2Yocy0+c29jKSwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgVFlQRV9SSVNDVl9IQVJUX0FSUkFZLCAmZXJyb3JfYWJvcnQsIE5VTEwpOw0KQEAg
LTM1OSw4ICs0NTQsMTcgQEAgc3RhdGljIHZvaWQgc3Bpa2VfdjFfMTBfMF9tYWNoaW5lX2luaXQo
TWFjaGluZUNsYXNzICptYykNCiAgICAgbWMtPmRlc2MgPSAiUklTQy1WIFNwaWtlIEJvYXJkIChQ
cml2aWxlZ2VkIElTQSB2MS4xMCkiOw0KICAgICBtYy0+aW5pdCA9IHNwaWtlX3YxXzEwXzBfYm9h
cmRfaW5pdDsNCiAgICAgbWMtPm1heF9jcHVzID0gMTsNCit9DQorDQorc3RhdGljIHZvaWQgc3Bp
a2VfbWFjaGluZV9pbml0KE1hY2hpbmVDbGFzcyAqbWMpDQorew0KKyAgICBtYy0+ZGVzYyA9ICJS
SVNDLVYgU3Bpa2UgQm9hcmQiOw0KKyAgICBtYy0+aW5pdCA9IHNwaWtlX2JvYXJkX2luaXQ7DQor
ICAgIG1jLT5tYXhfY3B1cyA9IDE7DQogICAgIG1jLT5pc19kZWZhdWx0ID0gMTsNCisgICAgbWMt
PmRlZmF1bHRfY3B1X3R5cGUgPSBTUElLRV9WMV8xMF8wX0NQVTsNCiB9DQogDQogREVGSU5FX01B
Q0hJTkUoInNwaWtlX3YxLjkuMSIsIHNwaWtlX3YxXzA5XzFfbWFjaGluZV9pbml0KQ0KIERFRklO
RV9NQUNISU5FKCJzcGlrZV92MS4xMCIsIHNwaWtlX3YxXzEwXzBfbWFjaGluZV9pbml0KQ0KK0RF
RklORV9NQUNISU5FKCJzcGlrZSIsIHNwaWtlX21hY2hpbmVfaW5pdCkNCi0tIA0KMi4yMS4wDQoN
Cg==

