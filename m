Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B19C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD28320850
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rz/TY/31";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IJMYGihe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD28320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEMWi-0000Wn-19
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 19:21:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMV8-0007jM-VP
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMNz-0001nF-NE
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:12:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMNt-00019X-94; Wed, 10 Apr 2019 19:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1554937921; x=1586473921;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=DjKD7cpMge4SvSYHv8hgsIO640+8XOJ8VMVQrAciRLs=;
	b=Rz/TY/319IqGOOQe8tttZmsLHLEKi5yLYuMnyHknxtPTzVhKBDAWDFrz
	j63c6+v+C2/hkKNQg8X/KxnX/Zj/4trm0dz4SfHz/K54mUVgk9cWVHnpL
	N/sGnGy+i/PGswg40VkhuDjHJKXWx93ji8WI3NCLKXN/KeOvt+vPbvwvT
	aVyFKuB5hT17MV4X23BD6sTStFBhqprKEqqeFLwnxqYF46f6AkmT0ejGd
	HovrAusvB1W4/UuXSXvWSIJtc/EHFpBEUWJUfvMhyBpmSbO7gFZ3kNt+w
	mqC9/wXaFr8JM/C99o67JZqLDOSxPnHgMPjZIjeSHxohJx7Dt4UruTyHB A==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; d="scan'208";a="106823615"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO
	NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
	by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:10:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=DjKD7cpMge4SvSYHv8hgsIO640+8XOJ8VMVQrAciRLs=;
	b=IJMYGihe8ZDBndZrbjgVkIQqTicgFG6ij9RV09LkP6hGrCcgbXz0Yf+zDErhiB8zM5tNsfRkrsJDVtFvJTOudoT1dEPOmHOX8xVutBSCKHRLHmc+7tyaNT+PVUlSd+cyWuRpvC7PWWHm2NpJG08LLiQCAYzA/RHOwUUEhseLl3I=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5334.namprd04.prod.outlook.com (20.178.50.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Wed, 10 Apr 2019 23:10:52 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1771.021;
	Wed, 10 Apr 2019 23:10:52 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH for 4.1 v3 5/6] target/riscv: Remove the generic no MMU
	CPUs
Thread-Index: AQHU7/Kk0WHFPQ2/oUeDzGcSQbqUZQ==
Date: Wed, 10 Apr 2019 23:10:52 +0000
Message-ID:
 <749f3773e5b9d199ecd25909043fde40747e992f.1554937288.git.alistair.francis@wdc.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1554937288.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR03CA0009.namprd03.prod.outlook.com
	(2603:10b6:a02:a8::22) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e0164a4-5417-425d-682a-08d6be09c6bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5334; 
x-ms-traffictypediagnostic: BYAPR04MB5334:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5334CF93C3729A4A9E51D66C902E0@BYAPR04MB5334.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(99286004)(11346002)(8936002)(14454004)(2616005)(6486002)(305945005)(6436002)(478600001)(97736004)(446003)(71190400001)(118296001)(2501003)(66066001)(476003)(4326008)(256004)(44832011)(71200400001)(486006)(86362001)(102836004)(186003)(36756003)(81156014)(72206003)(3846002)(8676002)(25786009)(386003)(6506007)(5660300002)(53936002)(7736002)(50226002)(106356001)(105586002)(2906002)(68736007)(6116002)(54906003)(26005)(316002)(6512007)(81166006)(110136005)(52116002)(76176011)(41533002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5334;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BIFB2SXT8Q2nsLCbw6D+MK8rVK6dXLpDspNJuvxNn5FrTXwDc6BCItDVuUtJUkk+sXSssH7mCGbNftK4hTo0VVGsaxOkdHZJq7O/LOE+bxcXHv6Jl6ky8efrSwyckr/dKOy3ShyOTWwbHkoalnE8sAWWQeRPPndZ+Bds5cZpdE8WGahAUP8yJjn+EX5Z22jYKpWqtkfhDHOa542ZVeiBgAU2TfXt2I3OgoYN60vsycu9RyYjaxCmnlqZKkfv2n5ji6XLiGrelLF6//CH8BadrTQorHNJFLrns4qdDX/t4yh/dy6f672lf55p+l8StNTtBM/KqovCJJ/ts+U3UAOg+QIyh/xllNoTTP0HtO+/X7upwZf5FM7C0oq8f27MfHC1Mrlts6LopBgSG0xKdyCXabYOrKW2REXGJePmUcUfXbc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0164a4-5417-425d-682a-08d6be09c6bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 23:10:52.0379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH for 4.1 v3 5/6] target/riscv: Remove the
 generic no MMU CPUs
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
Message-ID: <20190410231052.jLNQ-nT-UppZEmaMvfpl0mQSjV7ue1rYIwZRLe9M54A@z>

VGhlc2UgY2FuIG5vdyBiZSBzcGVjaWZpZWQgdmlhIHRoZSBjb21tYW5kIGxpbmUgc28gd2Ugbm8g
bG9uZ2VyIG5lZWQNCnRoZXNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxh
bGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1LmMgfCAyIC0t
DQogdGFyZ2V0L3Jpc2N2L2NwdS5oIHwgMiAtLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNCBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuYyBiL3RhcmdldC9yaXNjdi9j
cHUuYw0KaW5kZXggYzc5MmJhY2QyNC4uOWJhNzdhMTk4MyAxMDA2NDQNCi0tLSBhL3RhcmdldC9y
aXNjdi9jcHUuYw0KKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQpAQCAtNTg2LDEzICs1ODYsMTEg
QEAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIHJpc2N2X2NwdV90eXBlX2luZm9zW10gPSB7DQogI2lm
IGRlZmluZWQoVEFSR0VUX1JJU0NWMzIpDQogICAgIERFRklORV9DUFUoVFlQRV9SSVNDVl9DUFVf
UlYzMkdDU1VfVjFfMDlfMSwgcnYzMmdjc3VfcHJpdjFfMDlfMV9jcHVfaW5pdCksDQogICAgIERF
RklORV9DUFUoVFlQRV9SSVNDVl9DUFVfUlYzMkdDU1VfVjFfMTBfMCwgcnYzMmdjc3VfcHJpdjFf
MTBfMF9jcHVfaW5pdCksDQotICAgIERFRklORV9DUFUoVFlQRV9SSVNDVl9DUFVfUlYzMklNQUNV
X05PTU1VLCAgcnYzMmltYWN1X25vbW11X2NwdV9pbml0KSwNCiAgICAgREVGSU5FX0NQVShUWVBF
X1JJU0NWX0NQVV9TSUZJVkVfRTMxLCAgICAgICBydjMyaW1hY3Vfbm9tbXVfY3B1X2luaXQpLA0K
ICAgICBERUZJTkVfQ1BVKFRZUEVfUklTQ1ZfQ1BVX1NJRklWRV9VMzQsICAgICAgIHJ2MzJnY3N1
X3ByaXYxXzEwXzBfY3B1X2luaXQpDQogI2VsaWYgZGVmaW5lZChUQVJHRVRfUklTQ1Y2NCkNCiAg
ICAgREVGSU5FX0NQVShUWVBFX1JJU0NWX0NQVV9SVjY0R0NTVV9WMV8wOV8xLCBydjY0Z2NzdV9w
cml2MV8wOV8xX2NwdV9pbml0KSwNCiAgICAgREVGSU5FX0NQVShUWVBFX1JJU0NWX0NQVV9SVjY0
R0NTVV9WMV8xMF8wLCBydjY0Z2NzdV9wcml2MV8xMF8wX2NwdV9pbml0KSwNCi0gICAgREVGSU5F
X0NQVShUWVBFX1JJU0NWX0NQVV9SVjY0SU1BQ1VfTk9NTVUsICBydjY0aW1hY3Vfbm9tbXVfY3B1
X2luaXQpLA0KICAgICBERUZJTkVfQ1BVKFRZUEVfUklTQ1ZfQ1BVX1NJRklWRV9FNTEsICAgICAg
IHJ2NjRpbWFjdV9ub21tdV9jcHVfaW5pdCksDQogICAgIERFRklORV9DUFUoVFlQRV9SSVNDVl9D
UFVfU0lGSVZFX1U1NCwgICAgICAgcnY2NGdjc3VfcHJpdjFfMTBfMF9jcHVfaW5pdCkNCiAjZW5k
aWYNCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmggYi90YXJnZXQvcmlzY3YvY3B1LmgN
CmluZGV4IGJjODc3ZDgxMDcuLjY4MDZmNjAyYjUgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3Yv
Y3B1LmgNCisrKyBiL3RhcmdldC9yaXNjdi9jcHUuaA0KQEAgLTUxLDEwICs1MSw4IEBADQogI2Rl
ZmluZSBUWVBFX1JJU0NWX0NQVV9HRU4gICAgICAgICAgICAgIFJJU0NWX0NQVV9UWVBFX05BTUUo
InJ2KiIpDQogI2RlZmluZSBUWVBFX1JJU0NWX0NQVV9SVjMyR0NTVV9WMV8wOV8xIFJJU0NWX0NQ
VV9UWVBFX05BTUUoInJ2MzJnY3N1LXYxLjkuMSIpDQogI2RlZmluZSBUWVBFX1JJU0NWX0NQVV9S
VjMyR0NTVV9WMV8xMF8wIFJJU0NWX0NQVV9UWVBFX05BTUUoInJ2MzJnY3N1LXYxLjEwLjAiKQ0K
LSNkZWZpbmUgVFlQRV9SSVNDVl9DUFVfUlYzMklNQUNVX05PTU1VICBSSVNDVl9DUFVfVFlQRV9O
QU1FKCJydjMyaW1hY3Utbm9tbXUiKQ0KICNkZWZpbmUgVFlQRV9SSVNDVl9DUFVfUlY2NEdDU1Vf
VjFfMDlfMSBSSVNDVl9DUFVfVFlQRV9OQU1FKCJydjY0Z2NzdS12MS45LjEiKQ0KICNkZWZpbmUg
VFlQRV9SSVNDVl9DUFVfUlY2NEdDU1VfVjFfMTBfMCBSSVNDVl9DUFVfVFlQRV9OQU1FKCJydjY0
Z2NzdS12MS4xMC4wIikNCi0jZGVmaW5lIFRZUEVfUklTQ1ZfQ1BVX1JWNjRJTUFDVV9OT01NVSAg
UklTQ1ZfQ1BVX1RZUEVfTkFNRSgicnY2NGltYWN1LW5vbW11IikNCiAjZGVmaW5lIFRZUEVfUklT
Q1ZfQ1BVX1NJRklWRV9FMzEgICAgICAgUklTQ1ZfQ1BVX1RZUEVfTkFNRSgic2lmaXZlLWUzMSIp
DQogI2RlZmluZSBUWVBFX1JJU0NWX0NQVV9TSUZJVkVfRTUxICAgICAgIFJJU0NWX0NQVV9UWVBF
X05BTUUoInNpZml2ZS1lNTEiKQ0KICNkZWZpbmUgVFlQRV9SSVNDVl9DUFVfU0lGSVZFX1UzNCAg
ICAgICBSSVNDVl9DUFVfVFlQRV9OQU1FKCJzaWZpdmUtdTM0IikNCi0tIA0KMi4yMS4wDQoNCg==

