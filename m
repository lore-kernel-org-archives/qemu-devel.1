Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EEC10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED5920820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="phgnm8pH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Pe0MZN1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED5920820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39061 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEMZ0-0002Iu-63
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 19:23:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMVA-0007jM-1X
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMNq-0001iJ-Tp
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:12:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMNg-0000yF-Cl; Wed, 10 Apr 2019 19:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1554937908; x=1586473908;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=+5E3HuMPpgPWZVNHr7cnMoYJBKKTpSGQ9wDj3jayeAA=;
	b=phgnm8pH1fmVuSKcdRlVk1GYxGKflZcuyoz8XRQNVhh43PmvkrLwsrQ/
	dw9tN1a3ePtUKqyV2yZgmCIudoHTowudMJ5gSYknYyaVswL+oKaGcvEd4
	5kfXmPQzr4xm58lfPjMHPjJBpQDtrQFmmSn3OO8DbGbDPy68rhSy6HHJA
	vuTq+jeRu6k3WNMXoSudywkTWmGGD1iEXjrMbAHP4/c4LaF9vypYb3mUL
	1sWHQgj1NPSWbjr/ijAF/wpRgbhWsSE3hKGifTd9lCfuuQmrbFTDV/E+X
	IvbYoT+ipqnl3VIJ5JcHkYlGCsbJWEX1eS6HJdmMYH/Wbual9T0h55lke Q==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; d="scan'208";a="107205876"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO
	NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
	by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:10:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=+5E3HuMPpgPWZVNHr7cnMoYJBKKTpSGQ9wDj3jayeAA=;
	b=Pe0MZN1IL39k7KBLQO2+YGolx+tk5alt4s6SsZlZNpg4hu1opAKrrjDJDwB+BUCObycLZfeS4eE37ZEHKL0Z2xrKnmIF2F1wAiO1uL27m00uGftbOu7CRoEKujZkGlrK9MyXDlPt0naRM1gTQPkE65oRUCYDq44p0md5MFy6Mi0=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5334.namprd04.prod.outlook.com (20.178.50.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Wed, 10 Apr 2019 23:10:25 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1771.021;
	Wed, 10 Apr 2019 23:10:25 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH for 4.1 v3 2/6] target/riscv: Fall back to generating a
	RISC-V CPU
Thread-Index: AQHU7/KUeywJFduBUU2FCQ0yom2eQA==
Date: Wed, 10 Apr 2019 23:10:25 +0000
Message-ID:
 <efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1554937288.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BY5PR13CA0023.namprd13.prod.outlook.com
	(2603:10b6:a03:180::36) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de7438ed-fb20-43a8-0696-08d6be09b6b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5334; 
x-ms-traffictypediagnostic: BYAPR04MB5334:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5334489689F87E2E1278CA1E902E0@BYAPR04MB5334.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(99286004)(11346002)(8936002)(14454004)(2616005)(6486002)(305945005)(6436002)(478600001)(97736004)(14444005)(446003)(71190400001)(118296001)(2501003)(66066001)(476003)(4326008)(256004)(44832011)(71200400001)(486006)(86362001)(102836004)(186003)(36756003)(81156014)(72206003)(3846002)(8676002)(25786009)(386003)(6506007)(5660300002)(53936002)(7736002)(50226002)(106356001)(105586002)(2906002)(68736007)(6116002)(54906003)(26005)(316002)(6512007)(81166006)(110136005)(52116002)(76176011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5334;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s5Agq2vgv8Xt0/VsHQgMIP1iaN22Gl2OgDPeoOLsDpW4VG7X4WF4SfOHoajlvbcgWn8nGFU1Y8rhD0fWKNOqFT8TWaYMhYVYWT2J3lXJbWnLBeee95UUv1b6Bl/5CFvfvbppRpym1Ei+s4TXKXCOXNqnNeJDlJ6ENGW1SZR1XU+YasHHkkeFftWt1qSqg77Dvtlv2TQ/WdP0LLeAv6WxAjfhFQQvHtT4Wndhb2T5tHhNZSsW3TB1qt95nkU34O7ZZCaSZPnytZf/JqcF3NFmhxquXLcIXdkSIOVb4oGWQENE3uUs6wR85r+XABM/cU+GBGjtdX0cgicwH01tDWqQFWVSyOsPXRMZgKoFJmX+kQuCVU8cMzIX8Hm/jIDMTgCBnJh0IUJnoKFV9ZzYLDgIOKv3ziLPnpU7QTyHqDFsKq4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7438ed-fb20-43a8-0696-08d6be09b6b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 23:10:25.1631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH for 4.1 v3 2/6] target/riscv: Fall back to
 generating a RISC-V CPU
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
Message-ID: <20190410231025.2qFMKDyE-rht-w1ldqovkGJquHL2qfVxC5IEaA42cFU@z>

SWYgYSB1c2VyIHNwZWNpZmllcyBhIENQVSB0aGF0IHdlIGRvbid0IHVuZGVyc3RhbmQgdGhlbiB3
ZSB3YW50IHRvIGZhbGwNCmJhY2sgdG8gYSBDUFUgZ2VuZXJhdGVkIGZyb20gdGhlIElTQSBzdHJp
bmcuDQoNCkF0IHRoZSBtb21lbnQgdGhlIGdlbmVyYXRlZCBDUFUgaXMgYXNzdW1lZCB0byBiZSBh
IHByaXZsZWRnZSBzcGVjDQp2ZXJzaW9uIDEuMTAgQ1BVIHdpdGggYW4gTU1VLiBUaGlzIGNhbiBi
ZSBjaGFuZ2VkIGluIHRoZSBmdXR1cmUuDQoNClNpZ25lZC1vZmYtYnk6IEFsaXN0YWlyIEZyYW5j
aXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCi0tLQ0KdjM6DQogLSBFbnN1cmUgYSBtaW5p
bWFsIGxlbmd0aCBzbyB3ZSBkb24ndCBydW4gb2ZmIHRoZSBlbmQgb2YgdGhlIHN0cmluZy4NCiAt
IERvbid0IHBhcnNlIHRoZSBydjMyL3J2NjQgaW4gdGhlIGxvb3ANCiB0YXJnZXQvcmlzY3YvY3B1
LmMgfCAxMDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQog
dGFyZ2V0L3Jpc2N2L2NwdS5oIHwgICAyICsNCiAyIGZpbGVzIGNoYW5nZWQsIDEwMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmMg
Yi90YXJnZXQvcmlzY3YvY3B1LmMNCmluZGV4IGQ2MWJjZTZkNTUuLjI3YmU5ZTQxMmEgMTAwNjQ0
DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMNCisrKyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KQEAg
LTE5LDYgKzE5LDcgQEANCiANCiAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KICNpbmNsdWRlICJx
ZW11L2xvZy5oIg0KKyNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KICNpbmNsdWRlICJj
cHUuaCINCiAjaW5jbHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KICNpbmNsdWRlICJxYXBpL2Vycm9y
LmgiDQpAQCAtMTAzLDYgKzEwNCw5OSBAQCBzdGF0aWMgdm9pZCBzZXRfcmVzZXR2ZWMoQ1BVUklT
Q1ZTdGF0ZSAqZW52LCBpbnQgcmVzZXR2ZWMpDQogI2VuZGlmDQogfQ0KIA0KK3N0YXRpYyB2b2lk
IHJpc2N2X2dlbmVyYXRlX2NwdV9pbml0KE9iamVjdCAqb2JqKQ0KK3sNCisgICAgUklTQ1ZDUFUg
KmNwdSA9IFJJU0NWX0NQVShvYmopOw0KKyAgICBDUFVSSVNDVlN0YXRlICplbnYgPSAmY3B1LT5l
bnY7DQorICAgIFJJU0NWQ1BVQ2xhc3MgKm1jYyA9IFJJU0NWX0NQVV9HRVRfQ0xBU1MoY3B1KTsN
CisgICAgY29uc3QgY2hhciAqcmlzY3ZfY3B1ID0gbWNjLT5pc2Ffc3RyOw0KKyAgICB0YXJnZXRf
dWxvbmcgdGFyZ2V0X21pc2EgPSAwOw0KKyAgICB0YXJnZXRfdWxvbmcgcnZ4bGVuID0gMDsNCisg
ICAgaW50IGk7DQorICAgIGJvb2wgdmFsaWQgPSBmYWxzZTsNCisNCisgICAgLyoNCisgICAgICog
V2UgbmVlZCBhdCBsZWFzdCA1IGNoYXJlY3RlcnMgZm9yIHRoZSBzdHJpbmcgdG8gYmUgdmFsaWQu
IENoZWNrIHRoYXQNCisgICAgICogbm93IHNvIHdlIGNhbiBiZSBsYXppZXIgbGF0ZXIuDQorICAg
ICAqLw0KKyAgICBpZiAoc3RybGVuKHJpc2N2X2NwdSkgPCA1KSB7DQorICAgICAgICBlcnJvcl9y
ZXBvcnQoIiclcycgZG9lcyBub3QgYXBwZWFyIHRvIGJlIGEgdmFsaWQgUklTQy1WIElTQSBzdHJp
bmciLA0KKyAgICAgICAgICAgICAgICAgICAgIHJpc2N2X2NwdSk7DQorICAgICAgICBleGl0KDEp
Ow0KKyAgICB9DQorDQorICAgIGlmIChyaXNjdl9jcHVbMF0gPT0gJ3InICYmIHJpc2N2X2NwdVsx
XSA9PSAndicpIHsNCisgICAgICAgIC8qIFN0YXJ0cyB3aXRoICJydiIgKi8NCisgICAgICAgIGlm
IChyaXNjdl9jcHVbMl0gPT0gJzMnICYmIHJpc2N2X2NwdVszXSA9PSAnMicpIHsNCisgICAgICAg
ICAgICB2YWxpZCA9IHRydWU7DQorICAgICAgICAgICAgcnZ4bGVuID0gUlYzMjsNCisgICAgICAg
IH0NCisgICAgICAgIGlmIChyaXNjdl9jcHVbMl0gPT0gJzYnICYmIHJpc2N2X2NwdVszXSA9PSAn
NCcpIHsNCisgICAgICAgICAgICB2YWxpZCA9IHRydWU7DQorICAgICAgICAgICAgcnZ4bGVuID0g
UlY2NDsNCisgICAgICAgIH0NCisgICAgfQ0KKw0KKyAgICBpZiAoIXZhbGlkKSB7DQorICAgICAg
ICBlcnJvcl9yZXBvcnQoIiclcycgZG9lcyBub3QgYXBwZWFyIHRvIGJlIGEgdmFsaWQgUklTQy1W
IENQVSIsDQorICAgICAgICAgICAgICAgICAgICAgcmlzY3ZfY3B1KTsNCisgICAgICAgIGV4aXQo
MSk7DQorICAgIH0NCisNCisgICAgZm9yIChpID0gNDsgaSA8IHN0cmxlbihyaXNjdl9jcHUpOyBp
KyspIHsNCisgICAgICAgIHN3aXRjaCAocmlzY3ZfY3B1W2ldKSB7DQorICAgICAgICBjYXNlICdp
JzoNCisgICAgICAgICAgICBpZiAodGFyZ2V0X21pc2EgJiBSVkUpIHsNCisgICAgICAgICAgICAg
ICAgZXJyb3JfcmVwb3J0KCJJIGFuZCBFIGV4dGVuc2lvbnMgYXJlIGluY29tcGF0aWJsZSIpOw0K
KyAgICAgICAgICAgICAgICBleGl0KDEpOw0KKyAgICAgICAgICAgIH0NCisgICAgICAgICAgICB0
YXJnZXRfbWlzYSB8PSBSVkk7DQorICAgICAgICAgICAgY29udGludWU7DQorICAgICAgICBjYXNl
ICdlJzoNCisgICAgICAgICAgICBpZiAodGFyZ2V0X21pc2EgJiBSVkkpIHsNCisgICAgICAgICAg
ICAgICAgZXJyb3JfcmVwb3J0KCJJIGFuZCBFIGV4dGVuc2lvbnMgYXJlIGluY29tcGF0aWJsZSIp
Ow0KKyAgICAgICAgICAgICAgICBleGl0KDEpOw0KKyAgICAgICAgICAgIH0NCisgICAgICAgICAg
ICB0YXJnZXRfbWlzYSB8PSBSVkU7DQorICAgICAgICAgICAgY29udGludWU7DQorICAgICAgICBj
YXNlICdnJzoNCisgICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVkkgfCBSVk0gfCBSVkEgfCBS
VkYgfCBSVkQ7DQorICAgICAgICAgICAgY29udGludWU7DQorICAgICAgICBjYXNlICdtJzoNCisg
ICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVk07DQorICAgICAgICAgICAgY29udGludWU7DQor
ICAgICAgICBjYXNlICdhJzoNCisgICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVkE7DQorICAg
ICAgICAgICAgY29udGludWU7DQorICAgICAgICBjYXNlICdmJzoNCisgICAgICAgICAgICB0YXJn
ZXRfbWlzYSB8PSBSVkY7DQorICAgICAgICAgICAgY29udGludWU7DQorICAgICAgICBjYXNlICdk
JzoNCisgICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVkQ7DQorICAgICAgICAgICAgY29udGlu
dWU7DQorICAgICAgICBjYXNlICdjJzoNCisgICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVkM7
DQorICAgICAgICAgICAgY29udGludWU7DQorICAgICAgICBjYXNlICdzJzoNCisgICAgICAgICAg
ICB0YXJnZXRfbWlzYSB8PSBSVlM7DQorICAgICAgICAgICAgY29udGludWU7DQorICAgICAgICBj
YXNlICd1JzoNCisgICAgICAgICAgICB0YXJnZXRfbWlzYSB8PSBSVlU7DQorICAgICAgICAgICAg
Y29udGludWU7DQorICAgICAgICBkZWZhdWx0Og0KKyAgICAgICAgICAgIHdhcm5fcmVwb3J0KCJR
RU1VIGRvZXMgbm90IHN1cHBvcnQgdGhlICVjIGV4dGVuc2lvbiIsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgcmlzY3ZfY3B1W2ldKTsNCisgICAgICAgICAgICBjb250aW51ZTsNCisgICAgICAg
IH0NCisgICAgfQ0KKw0KKyAgICBzZXRfbWlzYShlbnYsIHJ2eGxlbiB8IHRhcmdldF9taXNhKTsN
CisgICAgc2V0X3ZlcnNpb25zKGVudiwgVVNFUl9WRVJTSU9OXzJfMDJfMCwgUFJJVl9WRVJTSU9O
XzFfMTBfMCk7DQorICAgIHNldF9yZXNldHZlYyhlbnYsIERFRkFVTFRfUlNUVkVDKTsNCisgICAg
c2V0X2ZlYXR1cmUoZW52LCBSSVNDVl9GRUFUVVJFX01NVSk7DQorICAgIHNldF9mZWF0dXJlKGVu
diwgUklTQ1ZfRkVBVFVSRV9QTVApOw0KK30NCisNCiBzdGF0aWMgdm9pZCByaXNjdl9hbnlfY3B1
X2luaXQoT2JqZWN0ICpvYmopDQogew0KICAgICBDUFVSSVNDVlN0YXRlICplbnYgPSAmUklTQ1Zf
Q1BVKG9iaiktPmVudjsNCkBAIC0xNzgsNiArMjcyLDcgQEAgc3RhdGljIHZvaWQgcnY2NGltYWN1
X25vbW11X2NwdV9pbml0KE9iamVjdCAqb2JqKQ0KIHN0YXRpYyBPYmplY3RDbGFzcyAqcmlzY3Zf
Y3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hhciAqY3B1X21vZGVsKQ0KIHsNCiAgICAgT2JqZWN0
Q2xhc3MgKm9jOw0KKyAgICBSSVNDVkNQVUNsYXNzICptY2M7DQogICAgIGNoYXIgKnR5cGVuYW1l
Ow0KICAgICBjaGFyICoqY3B1bmFtZTsNCiANCkBAIC0xODgsNyArMjgzLDEwIEBAIHN0YXRpYyBP
YmplY3RDbGFzcyAqcmlzY3ZfY3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hhciAqY3B1X21vZGVs
KQ0KICAgICBnX2ZyZWUodHlwZW5hbWUpOw0KICAgICBpZiAoIW9jIHx8ICFvYmplY3RfY2xhc3Nf
ZHluYW1pY19jYXN0KG9jLCBUWVBFX1JJU0NWX0NQVSkgfHwNCiAgICAgICAgIG9iamVjdF9jbGFz
c19pc19hYnN0cmFjdChvYykpIHsNCi0gICAgICAgIHJldHVybiBOVUxMOw0KKyAgICAgICAgLyog
Tm8gQ1BVIGZvdW5kLCB0cnkgdGhlIGdlbmVyaWMgQ1BVIGFuZCBwYXNzIGluIHRoZSBJU0Egc3Ry
aW5nICovDQorICAgICAgICBvYyA9IG9iamVjdF9jbGFzc19ieV9uYW1lKFRZUEVfUklTQ1ZfQ1BV
X0dFTik7DQorICAgICAgICBtY2MgPSBSSVNDVl9DUFVfQ0xBU1Mob2MpOw0KKyAgICAgICAgbWNj
LT5pc2Ffc3RyID0gZ19zdHJkdXAoY3B1X21vZGVsKTsNCiAgICAgfQ0KICAgICByZXR1cm4gb2M7
DQogfQ0KQEAgLTQ0MCw2ICs1MzgsNyBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8gcmlzY3ZfY3B1
X3R5cGVfaW5mb3NbXSA9IHsNCiAgICAgICAgIC5jbGFzc19pbml0ID0gcmlzY3ZfY3B1X2NsYXNz
X2luaXQsDQogICAgIH0sDQogICAgIERFRklORV9DUFUoVFlQRV9SSVNDVl9DUFVfQU5ZLCAgICAg
ICAgICAgICAgcmlzY3ZfYW55X2NwdV9pbml0KSwNCisgICAgREVGSU5FX0NQVShUWVBFX1JJU0NW
X0NQVV9HRU4sICAgICAgICAgICAgICByaXNjdl9nZW5lcmF0ZV9jcHVfaW5pdCksDQogI2lmIGRl
ZmluZWQoVEFSR0VUX1JJU0NWMzIpDQogICAgIERFRklORV9DUFUoVFlQRV9SSVNDVl9DUFVfUlYz
MkdDU1VfVjFfMDlfMSwgcnYzMmdjc3VfcHJpdjFfMDlfMV9jcHVfaW5pdCksDQogICAgIERFRklO
RV9DUFUoVFlQRV9SSVNDVl9DUFVfUlYzMkdDU1VfVjFfMTBfMCwgcnYzMmdjc3VfcHJpdjFfMTBf
MF9jcHVfaW5pdCksDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5oIGIvdGFyZ2V0L3Jp
c2N2L2NwdS5oDQppbmRleCAyMGJjZTg3NDJlLi40NTMxMDhhODU1IDEwMDY0NA0KLS0tIGEvdGFy
Z2V0L3Jpc2N2L2NwdS5oDQorKysgYi90YXJnZXQvcmlzY3YvY3B1LmgNCkBAIC00OCw2ICs0OCw3
IEBADQogI2RlZmluZSBDUFVfUkVTT0xWSU5HX1RZUEUgVFlQRV9SSVNDVl9DUFUNCiANCiAjZGVm
aW5lIFRZUEVfUklTQ1ZfQ1BVX0FOWSAgICAgICAgICAgICAgUklTQ1ZfQ1BVX1RZUEVfTkFNRSgi
YW55IikNCisjZGVmaW5lIFRZUEVfUklTQ1ZfQ1BVX0dFTiAgICAgICAgICAgICAgUklTQ1ZfQ1BV
X1RZUEVfTkFNRSgicnYqIikNCiAjZGVmaW5lIFRZUEVfUklTQ1ZfQ1BVX1JWMzJHQ1NVX1YxXzA5
XzEgUklTQ1ZfQ1BVX1RZUEVfTkFNRSgicnYzMmdjc3UtdjEuOS4xIikNCiAjZGVmaW5lIFRZUEVf
UklTQ1ZfQ1BVX1JWMzJHQ1NVX1YxXzEwXzAgUklTQ1ZfQ1BVX1RZUEVfTkFNRSgicnYzMmdjc3Ut
djEuMTAuMCIpDQogI2RlZmluZSBUWVBFX1JJU0NWX0NQVV9SVjMySU1BQ1VfTk9NTVUgIFJJU0NW
X0NQVV9UWVBFX05BTUUoInJ2MzJpbWFjdS1ub21tdSIpDQpAQCAtMjExLDYgKzIxMiw3IEBAIHR5
cGVkZWYgc3RydWN0IFJJU0NWQ1BVQ2xhc3Mgew0KICAgICAvKjwgcHVibGljID4qLw0KICAgICBE
ZXZpY2VSZWFsaXplIHBhcmVudF9yZWFsaXplOw0KICAgICB2b2lkICgqcGFyZW50X3Jlc2V0KShD
UFVTdGF0ZSAqY3B1KTsNCisgICAgY29uc3QgY2hhciAqaXNhX3N0cjsNCiB9IFJJU0NWQ1BVQ2xh
c3M7DQogDQogLyoqDQotLSANCjIuMjEuMA0KDQo=

