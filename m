Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C5C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D693721479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Aso8Pd91";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ctvno8hB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D693721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35966 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHftD-0006Ef-7G
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:38:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfl5-0008Mh-Eo
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfl4-0004sK-Hh
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:29:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffw-0002Qo-RJ; Fri, 19 Apr 2019 22:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727061; x=1587263061;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=jsHhhF06ccnOxaXimd0kePpFsqTeg4jvhXdO1Ic3wBA=;
	b=Aso8Pd91ppcuW0lqPIVDGc5mdmrYwWQmThTJfBup29r2Gjan6jerxNUs
	1qKWpn+AEpZNaGAVkl2tcgwNja8pIUTAs62CGnOOG78vjazA74BUOeDEO
	ytKY3CPbpp1rjZXiJkKn2onvuKSATkkxOa3l5oXp6G3WYxoHR7175BVDK
	e39tS+NKw0Hp071H0nddV7n6wxANfGFRWUYGiedISjZ9w8a4/xWzCvaCF
	cfOg3sqr4I1raTpMUh5akV7r1CPfusOANkF0PN7WENrPGUMj6OgQnDhj7
	/IsGPE75abmA1XhPJ2hjl8t2pQfWwzWxSZgFy2muTroee3znJ5WtXM5CB A==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617887"
Received: from mail-by2nam03lp2052.outbound.protection.outlook.com (HELO
	NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.52])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:24:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=jsHhhF06ccnOxaXimd0kePpFsqTeg4jvhXdO1Ic3wBA=;
	b=Ctvno8hBXitqnMZiaRj+2QijNUoT2ffp0YrqW35IGIu7HdWQtyF7JJ0qMnKqkyFOIorHyTVVz4w0QPf8vAVDP7S5KDbL5AYfRVNFzH+WVDK2IUxofEhCBb0pHIIADj7z3v9yAe9k/HpuzuPOVgSYOZZ3tAXEi/u25CBQBWKmIZc=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB3943.namprd04.prod.outlook.com (52.135.215.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Sat, 20 Apr 2019 02:24:18 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:24:18 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 5/6] target/riscv: Deprecate the generic no MMU CPUs
Thread-Index: AQHU9yAnlKI1qdQGC0el4C8lJCcPPA==
Date: Sat, 20 Apr 2019 02:24:18 +0000
Message-ID:
 <e327e7d2a5e0fd44b6f81c454fc830b18daa9365.1555726824.git.alistair.francis@wdc.com>
References: <cover.1555726824.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555726824.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR05CA0045.namprd05.prod.outlook.com
	(2603:10b6:a03:74::22) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10eb3264-cd20-4a51-e417-08d6c5374a49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB3943; 
x-ms-traffictypediagnostic: BYAPR04MB3943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB3943A22B68F8D20D47ECFA1C90200@BYAPR04MB3943.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(14454004)(446003)(2501003)(6486002)(53936002)(6436002)(50226002)(97736004)(5660300002)(4326008)(305945005)(71200400001)(86362001)(81166006)(8936002)(7736002)(8676002)(71190400001)(73956011)(68736007)(6512007)(4744005)(25786009)(66946007)(81156014)(66446008)(64756008)(66476007)(66556008)(2906002)(256004)(6116002)(3846002)(36756003)(478600001)(72206003)(99286004)(44832011)(52116002)(66066001)(76176011)(110136005)(386003)(6506007)(102836004)(26005)(186003)(316002)(118296001)(54906003)(2616005)(486006)(476003)(11346002)(41533002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3943;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pkLmHQOjnlhtsQl8qvxlPeDTWtuY8kGnYOAn0QnL/TQSP2V+HfESlYUufO9T3ic4R9/q4qv6rviE1rLTHgBe0xGMjhiZ+bYHVRLafijVPwOtE2fzXx7IW20zjlwOwYuKr4lvzFIArkWDGucbqaoHK03myTNBqltAtKS6F66UwlzBMWBXg76vHPLE86xcr8FX8y/+Qed6XXqStzss+lJkmmXXmrvxtMQlph/cYheLCIee1PrtIU4339BMMCyipKFgfmB+ZLtuPh4CPp7iHJlfvUDWsIZoXyzcBt9n/dRnwzQ+xNqfQyyVJsP5eFhHPg0Bob+uczEXIC0h9v1c3aq1D6xeYjx3C9AgHgYEIzfO9BFZW1GXiQwMHsl0DH0KxSxTzFsgL2C1iYj/fJjlEH/KSTIY2vhUWz0fdxB5pnvC69Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10eb3264-cd20-4a51-e417-08d6c5374a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:24:18.2815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 5/6] target/riscv: Deprecate the generic no
 MMU CPUs
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
Message-ID: <20190420022418.wEbBQrKO8ZvJg1kyWG_wPOhN5yFSbdlB7Utsu00l290@z>

VGhlc2UgY2FuIG5vdyBiZSBzcGVjaWZpZWQgdmlhIHRoZSBjb21tYW5kIGxpbmUgc28gd2Ugbm8g
bG9uZ2VyIG5lZWQNCnRoZXNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxh
bGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQotLS0NCiBxZW11LWRlcHJlY2F0ZWQudGV4aSB8IDYg
KysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
cWVtdS1kZXByZWNhdGVkLnRleGkgYi9xZW11LWRlcHJlY2F0ZWQudGV4aQ0KaW5kZXggOTJjZTkw
OWU1MC4uZDAxZmRmOTkwNyAxMDA2NDQNCi0tLSBhL3FlbXUtZGVwcmVjYXRlZC50ZXhpDQorKysg
Yi9xZW11LWRlcHJlY2F0ZWQudGV4aQ0KQEAgLTEzNyw2ICsxMzcsMTIgQEAgZm91ciBDUFVzIGFy
ZTogYGBydjMyZ2NzdS12MS45LjFgYCwgYGBydjMyZ2NzdS12MS4xMC4wYGAsIGBgcnY2NGdjc3Ut
djEuOS4xYGAgYW4NCiBgYHJ2NjRnY3N1LXYxLjEwLjBgYC4gSW5zdGVhZCB0aGUgdmVyc2lvbiBj
YW4gYmUgc3BlY2lmaWVkIHZpYSB0aGUgQ1BVIGBgcHJpdl9zcGVjYGANCiBvcHRpb24gd2hlbiB1
c2luZyB0aGUgYGBydjMyYGAgb3IgYGBydjY0YGAgQ1BVcy4NCiANCitAc3Vic2VjdGlvbiBSSVND
LVYgSVNBIENQVXMgKHNpbmNlIDQuMSkNCisNCitUaGUgUklTQy1WIG5vIE1NVSBjcHVzIGhhdmUg
YmVlbiBkZXBjcmVhdGVkLiBUaGUgdHdvIENQVXM6IGBgcnYzMmltYWN1LW5vbW11YGAgYW5kDQor
YGBydjY0aW1hY3Utbm9tbXVgYCBzaG91bGQgbm8gbG9uZ2VyIGJlIHVzZWQuIEluc3RlYWQgdGhl
IE1NVSBzdGF0dXMgY2FuIGJlIHNwZWNpZmllZA0KK3ZpYSB0aGUgQ1BVIGBgbW11YGAgb3B0aW9u
IHdoZW4gdXNpbmcgdGhlIGBgcnYzMmBgIG9yIGBgcnY2NGBgIENQVXMuDQorDQogQHNlY3Rpb24g
U3lzdGVtIGVtdWxhdG9yIGRldmljZXMNCiANCiBAc3Vic2VjdGlvbiBibHVldG9vdGggKHNpbmNl
IDMuMSkNCi0tIA0KMi4yMS4wDQoNCg==

