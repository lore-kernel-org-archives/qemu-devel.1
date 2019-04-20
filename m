Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F742C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D47721479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cuJJwekM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C54crRfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D47721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfrM-000540-Fm
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:36:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfl7-0008Oq-L3
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfl6-0004te-9U
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:29:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfg6-0002Wo-1a; Fri, 19 Apr 2019 22:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727070; x=1587263070;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=NkJ/2kU1GSH85AcIFvu8qBgmrltCLrn+8JpmQd0zqAs=;
	b=cuJJwekMZQ6eY7fml9olGWzxIN8+mwy6dLI7M3Y/lNeovJq8wHJ80xhM
	ugkliLbtvbCK/Z4KG0Yfn5akaFkA+/ggu9jBcVLlagoEinaZm+uIt+vTX
	F0+8WjHgIrJb/bD2jrcToCM9drzB21FCq9dzQOEl2j/as85NOEXTrh1G5
	QSxAZqOvUBl5ZuMt22onUAkT9kBLC2TzXNhT4OtjfHbAdqbk6XsxkNdob
	Ker4Wpi/VWzcckPuP4ohfCDOTK9Lh0A6FvnYsxChwZLjwQY+aLnUgAskM
	NqFkMFfIxqfTSx9lUsadR6VzKef+wkVfTcvPOFqH0VC+HyIb41+n5zW0u Q==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="108128384"
Received: from mail-bn3nam04lp2057.outbound.protection.outlook.com (HELO
	NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.57])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:24:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=NkJ/2kU1GSH85AcIFvu8qBgmrltCLrn+8JpmQd0zqAs=;
	b=C54crRfPW8bJbcJ6xaLAkFet0CjqfFeStOzrQ0TTOxsMQGyU0KVvnf7XzlfqqI3WLxe0XuNgZwEZLF0uTOYZc90tY0/qg0iHjXi96kFwEeRlc/BjZhuYhyQ8moBLoFSHD0AFKqut1mwLxdQ0ZOoezy8BgFc+rCnHgS8BqsWtjnU=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB3943.namprd04.prod.outlook.com (52.135.215.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Sat, 20 Apr 2019 02:24:26 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:24:26 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 6/6] riscv: spike: Add a generic spike machine
Thread-Index: AQHU9yAsjMR8QI0juEyy0+sYxzbfvw==
Date: Sat, 20 Apr 2019 02:24:26 +0000
Message-ID:
 <2a8fb0e0822a5daace4ac443cbb1996422d17864.1555726824.git.alistair.francis@wdc.com>
References: <cover.1555726824.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555726824.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR03CA0008.namprd03.prod.outlook.com
	(2603:10b6:a02:a8::21) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 429dab33-9e5f-45ea-57f1-08d6c5374f28
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB3943; 
x-ms-traffictypediagnostic: BYAPR04MB3943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB3943B94D432370D57DD5C51290200@BYAPR04MB3943.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(14454004)(446003)(2501003)(6486002)(53936002)(6436002)(50226002)(97736004)(5660300002)(4326008)(305945005)(71200400001)(86362001)(81166006)(8936002)(7736002)(8676002)(71190400001)(73956011)(68736007)(6512007)(25786009)(66946007)(81156014)(66446008)(64756008)(66476007)(66556008)(2906002)(256004)(14444005)(6116002)(3846002)(36756003)(478600001)(72206003)(99286004)(44832011)(52116002)(66066001)(76176011)(110136005)(386003)(6506007)(102836004)(26005)(186003)(316002)(118296001)(54906003)(2616005)(486006)(476003)(11346002)(41533002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3943;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mnoqi9uj+T9SxtNbj497lrCZ8eLPnqaNI6yKPh8/6b71LlGJGS5nJnlst7+fuH62ts7xZEasT8XJRx7w4oW3TMALjXLl/vc3Pauv9pU6UxsHXehSgNX2iZ1RsRLm/7ryCTsvgr3fenw/2nyooue08gP6imoLsZyI/jzITRb9xUz7TWxn588dGUA5ovlECL6LlwGXseKX1xoPjeFWxq5I1OReo/cpbau66G7G0S8KauEPYyCx61ABK5QbAkphoyf0S3lex6sWWshOfM/L/goR40GKlPmBy/i+n0zOTrPeNf3K53iWWCv6B76aixAqwRbKAJq6Xl1uMT43mGU2kjGYUjcZYLDEpDXBhGyEdtUpnfuQzzukFYjni7Gf9sJcvu1c1ulMv0pk5y684PUHHAANblrsOgM0w6iAj4AjP+JZGD4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429dab33-9e5f-45ea-57f1-08d6c5374f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:24:26.3922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 6/6] riscv: spike: Add a generic spike
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
	"imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190420022426.GeVM-3qYbUTzi-Vbb-5C81S_BsYoG2fgg844ENdvOMo@z>

QWRkIGEgZ2VuZXJpYyBzcGlrZSBtYWNoaW5lIChub3QgdGllZCB0byBhIHZlcnNpb24pIGFuZCBk
ZXByZWNhdGUgdGhlDQpzcGlrZSBtYWhpbmVzIHRoYXQgYXJlIHRpZWQgdG8gYSBzcGVjaWZpYyB2
ZXJzaW9uLiBBcyB3ZSBjYW4gbm93IHNwZWNpZnkNCnRoZSBDUFUgdmlhIHRoZSBjb21tYW5kIGxp
bmUgd2Ugbm8gbG9uZGVyIG5lZWQgc3BlY2lmaWMgdmVyc2lvbnMgb2YgdGhlDQpzcGlrZSBtYWNo
aW5lcy4NCg0KU2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNp
c0B3ZGMuY29tPg0KQWNrZWQtYnk6IElnb3IgTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhhdC5jb20+
DQotLS0NCiBody9yaXNjdi9zcGlrZS5jICAgICB8IDEwNiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystDQogcWVtdS1kZXByZWNhdGVkLnRleGkgfCAgIDYgKysrDQog
MiBmaWxlcyBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvaHcvcmlzY3Yvc3Bpa2UuYyBiL2h3L3Jpc2N2L3NwaWtlLmMNCmluZGV4IDJhMDAw
YTU4MDAuLjViMzNkNGJlM2IgMTAwNjQ0DQotLS0gYS9ody9yaXNjdi9zcGlrZS5jDQorKysgYi9o
dy9yaXNjdi9zcGlrZS5jDQpAQCAtMzksNiArMzksNyBAQA0KICNpbmNsdWRlICJjaGFyZGV2L2No
YXIuaCINCiAjaW5jbHVkZSAic3lzZW11L2FyY2hfaW5pdC5oIg0KICNpbmNsdWRlICJzeXNlbXUv
ZGV2aWNlX3RyZWUuaCINCisjaW5jbHVkZSAic3lzZW11L3F0ZXN0LmgiDQogI2luY2x1ZGUgImV4
ZWMvYWRkcmVzcy1zcGFjZXMuaCINCiAjaW5jbHVkZSAiZWxmLmgiDQogDQpAQCAtMTYwLDcgKzE2
MSw4OSBAQCBzdGF0aWMgdm9pZCBjcmVhdGVfZmR0KFNwaWtlU3RhdGUgKnMsIGNvbnN0IHN0cnVj
dCBNZW1tYXBFbnRyeSAqbWVtbWFwLA0KICAgICAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUoZmR0
LCAiL2Nob3NlbiIpOw0KICAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcoZmR0LCAiL2No
b3NlbiIsICJib290YXJncyIsIGNtZGxpbmUpOw0KICAgICB9DQotIH0NCit9DQorDQorc3RhdGlj
IHZvaWQgc3Bpa2VfYm9hcmRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQorew0KKyAgICBj
b25zdCBzdHJ1Y3QgTWVtbWFwRW50cnkgKm1lbW1hcCA9IHNwaWtlX21lbW1hcDsNCisNCisgICAg
U3Bpa2VTdGF0ZSAqcyA9IGdfbmV3MChTcGlrZVN0YXRlLCAxKTsNCisgICAgTWVtb3J5UmVnaW9u
ICpzeXN0ZW1fbWVtb3J5ID0gZ2V0X3N5c3RlbV9tZW1vcnkoKTsNCisgICAgTWVtb3J5UmVnaW9u
ICptYWluX21lbSA9IGdfbmV3KE1lbW9yeVJlZ2lvbiwgMSk7DQorICAgIE1lbW9yeVJlZ2lvbiAq
bWFza19yb20gPSBnX25ldyhNZW1vcnlSZWdpb24sIDEpOw0KKyAgICBpbnQgaTsNCisNCisgICAg
LyogSW5pdGlhbGl6ZSBTT0MgKi8NCisgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQoT0JKRUNU
KG1hY2hpbmUpLCAic29jIiwgJnMtPnNvYywgc2l6ZW9mKHMtPnNvYyksDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFRZUEVfUklTQ1ZfSEFSVF9BUlJBWSwgJmVycm9yX2Fib3J0LCBOVUxM
KTsNCisgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9zdHIoT0JKRUNUKCZzLT5zb2MpLCBtYWNoaW5l
LT5jcHVfdHlwZSwgImNwdS10eXBlIiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVy
cm9yX2Fib3J0KTsNCisgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9pbnQoT0JKRUNUKCZzLT5zb2Mp
LCBzbXBfY3B1cywgIm51bS1oYXJ0cyIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICZl
cnJvcl9hYm9ydCk7DQorICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1QoJnMtPnNv
YyksIHRydWUsICJyZWFsaXplZCIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJv
cl9hYm9ydCk7DQorDQorICAgIC8qIHJlZ2lzdGVyIHN5c3RlbSBtYWluIG1lbW9yeSAoYWN0dWFs
IFJBTSkgKi8NCisgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbShtYWluX21lbSwgTlVMTCwgInJp
c2N2LnNwaWtlLnJhbSIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgbWFjaGluZS0+cmFt
X3NpemUsICZlcnJvcl9mYXRhbCk7DQorICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihz
eXN0ZW1fbWVtb3J5LCBtZW1tYXBbU1BJS0VfRFJBTV0uYmFzZSwNCisgICAgICAgIG1haW5fbWVt
KTsNCisNCisgICAgLyogY3JlYXRlIGRldmljZSB0cmVlICovDQorICAgIGNyZWF0ZV9mZHQocywg
bWVtbWFwLCBtYWNoaW5lLT5yYW1fc2l6ZSwgbWFjaGluZS0+a2VybmVsX2NtZGxpbmUpOw0KKw0K
KyAgICAvKiBib290IHJvbSAqLw0KKyAgICBtZW1vcnlfcmVnaW9uX2luaXRfcm9tKG1hc2tfcm9t
LCBOVUxMLCAicmlzY3Yuc3Bpa2UubXJvbSIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
bWVtbWFwW1NQSUtFX01ST01dLnNpemUsICZlcnJvcl9mYXRhbCk7DQorICAgIG1lbW9yeV9yZWdp
b25fYWRkX3N1YnJlZ2lvbihzeXN0ZW1fbWVtb3J5LCBtZW1tYXBbU1BJS0VfTVJPTV0uYmFzZSwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hc2tfcm9tKTsNCisNCisgICAgaWYg
KG1hY2hpbmUtPmtlcm5lbF9maWxlbmFtZSkgew0KKyAgICAgICAgbG9hZF9rZXJuZWwobWFjaGlu
ZS0+a2VybmVsX2ZpbGVuYW1lKTsNCisgICAgfQ0KKw0KKyAgICAvKiByZXNldCB2ZWN0b3IgKi8N
CisgICAgdWludDMyX3QgcmVzZXRfdmVjWzhdID0gew0KKyAgICAgICAgMHgwMDAwMDI5NywgICAg
ICAgICAgICAgICAgICAvKiAxOiAgYXVpcGMgIHQwLCAlcGNyZWxfaGkoZHRiKSAqLw0KKyAgICAg
ICAgMHgwMjAyODU5MywgICAgICAgICAgICAgICAgICAvKiAgICAgYWRkaSAgIGExLCB0MCwgJXBj
cmVsX2xvKDFiKSAqLw0KKyAgICAgICAgMHhmMTQwMjU3MywgICAgICAgICAgICAgICAgICAvKiAg
ICAgY3NyciAgIGEwLCBtaGFydGlkICAqLw0KKyNpZiBkZWZpbmVkKFRBUkdFVF9SSVNDVjMyKQ0K
KyAgICAgICAgMHgwMTgyYTI4MywgICAgICAgICAgICAgICAgICAvKiAgICAgbHcgICAgIHQwLCAy
NCh0MCkgKi8NCisjZWxpZiBkZWZpbmVkKFRBUkdFVF9SSVNDVjY0KQ0KKyAgICAgICAgMHgwMTgy
YjI4MywgICAgICAgICAgICAgICAgICAvKiAgICAgbGQgICAgIHQwLCAyNCh0MCkgKi8NCisjZW5k
aWYNCisgICAgICAgIDB4MDAwMjgwNjcsICAgICAgICAgICAgICAgICAgLyogICAgIGpyICAgICB0
MCAqLw0KKyAgICAgICAgMHgwMDAwMDAwMCwNCisgICAgICAgIG1lbW1hcFtTUElLRV9EUkFNXS5i
YXNlLCAgICAgLyogc3RhcnQ6IC5kd29yZCBEUkFNX0JBU0UgKi8NCisgICAgICAgIDB4MDAwMDAw
MDAsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIGR0YjogKi8NCisg
ICAgfTsNCisNCisgICAgLyogY29weSBpbiB0aGUgcmVzZXQgdmVjdG9yIGluIGxpdHRsZV9lbmRp
YW4gYnl0ZSBvcmRlciAqLw0KKyAgICBmb3IgKGkgPSAwOyBpIDwgc2l6ZW9mKHJlc2V0X3ZlYykg
Pj4gMjsgaSsrKSB7DQorICAgICAgICByZXNldF92ZWNbaV0gPSBjcHVfdG9fbGUzMihyZXNldF92
ZWNbaV0pOw0KKyAgICB9DQorICAgIHJvbV9hZGRfYmxvYl9maXhlZF9hcygibXJvbS5yZXNldCIs
IHJlc2V0X3ZlYywgc2l6ZW9mKHJlc2V0X3ZlYyksDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICBtZW1tYXBbU1BJS0VfTVJPTV0uYmFzZSwgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsNCisNCisg
ICAgLyogY29weSBpbiB0aGUgZGV2aWNlIHRyZWUgKi8NCisgICAgaWYgKGZkdF9wYWNrKHMtPmZk
dCkgfHwgZmR0X3RvdGFsc2l6ZShzLT5mZHQpID4NCisgICAgICAgICAgICBtZW1tYXBbU1BJS0Vf
TVJPTV0uc2l6ZSAtIHNpemVvZihyZXNldF92ZWMpKSB7DQorICAgICAgICBlcnJvcl9yZXBvcnQo
Im5vdCBlbm91Z2ggc3BhY2UgdG8gc3RvcmUgZGV2aWNlLXRyZWUiKTsNCisgICAgICAgIGV4aXQo
MSk7DQorICAgIH0NCisgICAgcWVtdV9mZHRfZHVtcGR0YihzLT5mZHQsIGZkdF90b3RhbHNpemUo
cy0+ZmR0KSk7DQorICAgIHJvbV9hZGRfYmxvYl9maXhlZF9hcygibXJvbS5mZHQiLCBzLT5mZHQs
IGZkdF90b3RhbHNpemUocy0+ZmR0KSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgIG1lbW1h
cFtTUElLRV9NUk9NXS5iYXNlICsgc2l6ZW9mKHJlc2V0X3ZlYyksDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAmYWRkcmVzc19zcGFjZV9tZW1vcnkpOw0KKw0KKyAgICAvKiBpbml0aWFsaXpl
IEhUSUYgdXNpbmcgc3ltYm9scyBmb3VuZCBpbiBsb2FkX2tlcm5lbCAqLw0KKyAgICBodGlmX21t
X2luaXQoc3lzdGVtX21lbW9yeSwgbWFza19yb20sICZzLT5zb2MuaGFydHNbMF0uZW52LCBzZXJp
YWxfaGQoMCkpOw0KKw0KKyAgICAvKiBDb3JlIExvY2FsIEludGVycnVwdG9yICh0aW1lciBhbmQg
SVBJKSAqLw0KKyAgICBzaWZpdmVfY2xpbnRfY3JlYXRlKG1lbW1hcFtTUElLRV9DTElOVF0uYmFz
ZSwgbWVtbWFwW1NQSUtFX0NMSU5UXS5zaXplLA0KKyAgICAgICAgc21wX2NwdXMsIFNJRklWRV9T
SVBfQkFTRSwgU0lGSVZFX1RJTUVDTVBfQkFTRSwgU0lGSVZFX1RJTUVfQkFTRSk7DQorfQ0KIA0K
IHN0YXRpYyB2b2lkIHNwaWtlX3YxXzEwXzBfYm9hcmRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hp
bmUpDQogew0KQEAgLTE3Miw2ICsyNTUsMTIgQEAgc3RhdGljIHZvaWQgc3Bpa2VfdjFfMTBfMF9i
b2FyZF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkNCiAgICAgTWVtb3J5UmVnaW9uICptYXNr
X3JvbSA9IGdfbmV3KE1lbW9yeVJlZ2lvbiwgMSk7DQogICAgIGludCBpOw0KIA0KKyAgICBpZiAo
IXF0ZXN0X2VuYWJsZWQoKSkgew0KKyAgICAgICAgaW5mb19yZXBvcnQoIlRoZSBTcGlrZSB2MS4x
MC4wIG1hY2hpbmUgaGFzIGJlZW4gZGVwcmVjYXRlZC4gIg0KKyAgICAgICAgICAgICAgICAgICAg
IlBsZWFzZSB1c2UgdGhlIGdlbmVyaWMgc3Bpa2UgbWFjaGluZSBhbmQgc3BlY2lmeSB0aGUgSVNB
ICINCisgICAgICAgICAgICAgICAgICAgICJ2ZXJzaW9ucyB1c2luZyAtY3B1LiIpOw0KKyAgICB9
DQorDQogICAgIC8qIEluaXRpYWxpemUgU09DICovDQogICAgIG9iamVjdF9pbml0aWFsaXplX2No
aWxkKE9CSkVDVChtYWNoaW5lKSwgInNvYyIsICZzLT5zb2MsIHNpemVvZihzLT5zb2MpLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFX1JJU0NWX0hBUlRfQVJSQVksICZlcnJvcl9h
Ym9ydCwgTlVMTCk7DQpAQCAtMjU0LDYgKzM0MywxMiBAQCBzdGF0aWMgdm9pZCBzcGlrZV92MV8w
OV8xX2JvYXJkX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQ0KICAgICBNZW1vcnlSZWdpb24g
Km1hc2tfcm9tID0gZ19uZXcoTWVtb3J5UmVnaW9uLCAxKTsNCiAgICAgaW50IGk7DQogDQorICAg
IGlmICghcXRlc3RfZW5hYmxlZCgpKSB7DQorICAgICAgICBpbmZvX3JlcG9ydCgiVGhlIFNwaWtl
IHYxLjA5LjEgbWFjaGluZSBoYXMgYmVlbiBkZXByZWNhdGVkLiAiDQorICAgICAgICAgICAgICAg
ICAgICAiUGxlYXNlIHVzZSB0aGUgZ2VuZXJpYyBzcGlrZSBtYWNoaW5lIGFuZCBzcGVjaWZ5IHRo
ZSBJU0EgIg0KKyAgICAgICAgICAgICAgICAgICAgInZlcnNpb25zIHVzaW5nIC1jcHUuIik7DQor
ICAgIH0NCisNCiAgICAgLyogSW5pdGlhbGl6ZSBTT0MgKi8NCiAgICAgb2JqZWN0X2luaXRpYWxp
emVfY2hpbGQoT0JKRUNUKG1hY2hpbmUpLCAic29jIiwgJnMtPnNvYywgc2l6ZW9mKHMtPnNvYyks
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfUklTQ1ZfSEFSVF9BUlJBWSwgJmVy
cm9yX2Fib3J0LCBOVUxMKTsNCkBAIC0zNTksOCArNDU0LDE3IEBAIHN0YXRpYyB2b2lkIHNwaWtl
X3YxXzEwXzBfbWFjaGluZV9pbml0KE1hY2hpbmVDbGFzcyAqbWMpDQogICAgIG1jLT5kZXNjID0g
IlJJU0MtViBTcGlrZSBCb2FyZCAoUHJpdmlsZWdlZCBJU0EgdjEuMTApIjsNCiAgICAgbWMtPmlu
aXQgPSBzcGlrZV92MV8xMF8wX2JvYXJkX2luaXQ7DQogICAgIG1jLT5tYXhfY3B1cyA9IDE7DQor
fQ0KKw0KK3N0YXRpYyB2b2lkIHNwaWtlX21hY2hpbmVfaW5pdChNYWNoaW5lQ2xhc3MgKm1jKQ0K
K3sNCisgICAgbWMtPmRlc2MgPSAiUklTQy1WIFNwaWtlIEJvYXJkIjsNCisgICAgbWMtPmluaXQg
PSBzcGlrZV9ib2FyZF9pbml0Ow0KKyAgICBtYy0+bWF4X2NwdXMgPSAxOw0KICAgICBtYy0+aXNf
ZGVmYXVsdCA9IDE7DQorICAgIG1jLT5kZWZhdWx0X2NwdV90eXBlID0gU1BJS0VfVjFfMTBfMF9D
UFU7DQogfQ0KIA0KIERFRklORV9NQUNISU5FKCJzcGlrZV92MS45LjEiLCBzcGlrZV92MV8wOV8x
X21hY2hpbmVfaW5pdCkNCiBERUZJTkVfTUFDSElORSgic3Bpa2VfdjEuMTAiLCBzcGlrZV92MV8x
MF8wX21hY2hpbmVfaW5pdCkNCitERUZJTkVfTUFDSElORSgic3Bpa2UiLCBzcGlrZV9tYWNoaW5l
X2luaXQpDQpkaWZmIC0tZ2l0IGEvcWVtdS1kZXByZWNhdGVkLnRleGkgYi9xZW11LWRlcHJlY2F0
ZWQudGV4aQ0KaW5kZXggZDAxZmRmOTkwNy4uNzk0NTRiMmQ3ZSAxMDA2NDQNCi0tLSBhL3FlbXUt
ZGVwcmVjYXRlZC50ZXhpDQorKysgYi9xZW11LWRlcHJlY2F0ZWQudGV4aQ0KQEAgLTE2NSw2ICsx
NjUsMTIgQEAgVGhpcyBtYWNoaW5lIHR5cGUgdXNlcyBhbiB1bm1haW50YWluZWQgZmlybXdhcmUs
IGJyb2tlbiBpbiBsb3RzIG9mIHdheXMsDQogYW5kIHVuYWJsZSB0byBzdGFydCBwb3N0LTIwMDQg
b3BlcmF0aW5nIHN5c3RlbXMuIDQwcCBtYWNoaW5lIHR5cGUgc2hvdWxkIGJlDQogdXNlZCBpbnN0
ZWFkLg0KIA0KK0BzdWJzZWN0aW9uIHNwaWtlX3YxLjkuMSBhbmQgc3Bpa2VfdjEuMTAgKHNpbmNl
IDQuMSkNCisNCitUaGUgdmVyc2lvbiBzcGVjaWZpYyBTcGlrZSBtYWNoaW5lcyBoYXZlIGJlZW4g
ZGVwcmVjYXRlZCBpbiBmYXZvdXIgb2YgdGhlDQorZ2VuZXJpYyBgYHNwaWtlYGAgbWFjaGluZS4g
SWYgeW91IG5lZWQgdG8gc3BlY2lmeSBhbiBvbGRlciB2ZXJzaW9uIG9mIHRoZSBSSVNDLVYNCitz
cGVjIHlvdSBjYW4gdXNlIHRoZSBgYC1jcHUgcnY2NGdjc3UscHJpdl9zcGVjPXYxLjkuMWBgIGNv
bW1hbmQgbGluZSBhcmd1bWVudC4NCisNCiBAc2VjdGlvbiBEZXZpY2Ugb3B0aW9ucw0KIA0KIEBz
dWJzZWN0aW9uIEJsb2NrIGRldmljZSBvcHRpb25zDQotLSANCjIuMjEuMA0KDQo=

