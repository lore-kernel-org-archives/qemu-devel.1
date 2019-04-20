Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409CDC282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A3F21479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AYtMIdXP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Bn5ywpfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A3F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35816 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfkS-0007UM-Ot
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:29:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfgH-0003ft-J1
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfgG-0002bd-Bz
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:24:41 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffv-0002QE-5u; Fri, 19 Apr 2019 22:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727110; x=1587263110;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=wGLmzXY8ln9aDL3Bg8Ndtbb2YnNj4WFChx31WkfF5+w=;
	b=AYtMIdXPDuC82cXm26d0VSkKOATZTWUJG+8GiCZaVsZXY6L1K4/qXY2Z
	DAg15oYIlues38mK44AefJnHgcPDnrfGYb9RdZjKZ8IIwYdjJDst+ahdq
	K7mgT29xqX7R1RPw2TFwwPWiipCN2b6yEskYLHJbhjte2i1XEIep3IhSI
	EZHHMs6OfJ7NHqKrWjzlJjAVfS94/D5Dulff+IRRuYmfsz3Aq0K+KzRkD
	rs57EEjnqeP+4g7if8IVEZxhqH0qwSHU/zyIjY2M+Yt0wSXTPWA82pcIE
	ygAM7qQo1OkNLQhdXfEHnSLFxTvJVwUV3/2J9hHQrkgrsP26mbwoqegZV w==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="205476513"
Received: from mail-by2nam03lp2054.outbound.protection.outlook.com (HELO
	NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.54])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:25:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=wGLmzXY8ln9aDL3Bg8Ndtbb2YnNj4WFChx31WkfF5+w=;
	b=Bn5ywpfA3e1D0sGTuQcdaVMH1JNtwVTCrMFReb7MfZyzo70S8mKIWWAkn/Vgr/uvdQvjZvz1gGkp69lfW9NWpO4UAvGafbq67/tPRMh9w+TziRgcSpcYpKVofYtoqlO022hLhlI7mkMuetnOL5mKrsD8a+CMNa/hsQCm+Kb1WPM=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB3943.namprd04.prod.outlook.com (52.135.215.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Sat, 20 Apr 2019 02:24:10 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:24:10 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 4/6] target/riscv: Add a base 32 and 64 bit CPU
Thread-Index: AQHU9yAix5tSgPliOECOn528JVIbEQ==
Date: Sat, 20 Apr 2019 02:24:09 +0000
Message-ID:
 <b7d82f751e7d224a0984f47ec7e76a6f7e8a2290.1555726824.git.alistair.francis@wdc.com>
References: <cover.1555726824.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555726824.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR01CA0067.prod.exchangelabs.com (2603:10b6:a03:94::44)
	To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 758795e9-25ab-40e9-61eb-08d6c5374554
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB3943; 
x-ms-traffictypediagnostic: BYAPR04MB3943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB3943396B3AC0C58AB48D2CA090200@BYAPR04MB3943.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(14454004)(446003)(2501003)(6486002)(53936002)(6436002)(50226002)(97736004)(5660300002)(4326008)(305945005)(71200400001)(86362001)(81166006)(8936002)(7736002)(8676002)(71190400001)(73956011)(68736007)(6512007)(25786009)(66946007)(81156014)(66446008)(64756008)(66476007)(66556008)(2906002)(256004)(6116002)(3846002)(36756003)(478600001)(72206003)(99286004)(44832011)(52116002)(66066001)(76176011)(110136005)(386003)(6506007)(102836004)(26005)(186003)(316002)(118296001)(54906003)(2616005)(486006)(476003)(11346002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3943;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ufdSwiKEDE2P9YZnbiHtynUV1cI88YscvrfqMToXfp924J+HmA4fQ8rcu5wEUtZfG5m8ME5wDMj/kYzmMgWYgTl70BuiZ285/hXgp8gKn7fvnklgyGD9TzbPUdiRO17Q55SVmh96G7GAoXKRM0snSvpDoHxHHU874e8NU4veP1U6GSLRDPEG7PkG2+sAswo97qN/dnNmnSmAdTIloEY1U1iV5wP9yNh/jxJT7HTrAq6ygnQHHQPrckfRE9KVWN5D7mauLchX7nak7BWHeJujd4dGRapXNhMV2ezsBGkaxuP/mXWuhoGl8bH3U2WtVzAsW98/+mRxmaWrofiDorOMK3hpUotrnGYmZt27jXsiP7+hUZktdyhRDLbYPmRLHRY/GDmZjaLMP7pb9xoazN/X4hbPbD+AtRb3Hv6T9rBPIcI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758795e9-25ab-40e9-61eb-08d6c5374554
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:24:09.9316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 4/6] target/riscv: Add a base 32 and 64 bit
 CPU
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
Message-ID: <20190420022409.W4QyfSNILafUvNLtpsMyi9-EE1cPVHPG6sVJSAYByxs@z>

QXQgdGhlIHNhbWUgdGltZSBkZXByZWNhdGUgdGhlIElTQSBzdHJpbmcgQ1BVcy4NCg0KSXQgaXMg
ZG9idGZ1bCBhbnlvbmUgc3BlY2lmaWVzIHRoZSBDUFVzLCBidXQgd2UgYXJlIGtlZXBpbmcgdGhl
bSBmb3IgdGhlDQpTcGlrZSBtYWNoaW5lICh3aGljaCBpcyBhYm91dCB0byBiZSBkZXByZWF0ZWQp
IHNvIHdlIG1heSBhcyB3ZWxsIGp1c3QNCm1hcmsgdGhlbSBhcyBkZXByZWNhdGVkLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQot
LS0NCiBpbmNsdWRlL2h3L3Jpc2N2L3ZpcnQuaCB8ICA0ICsrLS0NCiBxZW11LWRlcHJlY2F0ZWQu
dGV4aSAgICB8ICA5ICsrKysrKysrKw0KIHRhcmdldC9yaXNjdi9jcHUuYyAgICAgIHwgMTQgKysr
KysrKysrKysrKysNCiB0YXJnZXQvcmlzY3YvY3B1LmggICAgICB8ICAyICsrDQogNCBmaWxlcyBj
aGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9ody9yaXNjdi92aXJ0LmggYi9pbmNsdWRlL2h3L3Jpc2N2L3ZpcnQuaA0KaW5kZXgg
NTY4NzY0YjU3MC4uZDAxYTFhODVjNCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcmlzY3Yvdmly
dC5oDQorKysgYi9pbmNsdWRlL2h3L3Jpc2N2L3ZpcnQuaA0KQEAgLTc0LDkgKzc0LDkgQEAgZW51
bSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZEVF9QTElDX0FERFJfQ0VMTFMg
KyBGRFRfUExJQ19JTlRfQ0VMTFMpDQogDQogI2lmIGRlZmluZWQoVEFSR0VUX1JJU0NWMzIpDQot
I2RlZmluZSBWSVJUX0NQVSBUWVBFX1JJU0NWX0NQVV9SVjMyR0NTVV9WMV8xMF8wDQorI2RlZmlu
ZSBWSVJUX0NQVSBUWVBFX1JJU0NWX0NQVV9CQVNFMzINCiAjZWxpZiBkZWZpbmVkKFRBUkdFVF9S
SVNDVjY0KQ0KLSNkZWZpbmUgVklSVF9DUFUgVFlQRV9SSVNDVl9DUFVfUlY2NEdDU1VfVjFfMTBf
MA0KKyNkZWZpbmUgVklSVF9DUFUgVFlQRV9SSVNDVl9DUFVfQkFTRTY0DQogI2VuZGlmDQogDQog
I2VuZGlmDQpkaWZmIC0tZ2l0IGEvcWVtdS1kZXByZWNhdGVkLnRleGkgYi9xZW11LWRlcHJlY2F0
ZWQudGV4aQ0KaW5kZXggODQyZTcxYjExZC4uOTJjZTkwOWU1MCAxMDA2NDQNCi0tLSBhL3FlbXUt
ZGVwcmVjYXRlZC50ZXhpDQorKysgYi9xZW11LWRlcHJlY2F0ZWQudGV4aQ0KQEAgLTEyOCw2ICsx
MjgsMTUgQEAgVGhlIGBgYWNsX3Nob3cnJywgYGBhY2xfcmVzZXQnJywgYGBhY2xfcG9saWN5Jycs
IGBgYWNsX2FkZCcnLCBhbmQNCiBgYGFjbF9yZW1vdmUnJyBjb21tYW5kcyBhcmUgZGVwcmVjYXRl
ZCB3aXRoIG5vIHJlcGxhY2VtZW50LiBBdXRob3JpemF0aW9uDQogZm9yIFZOQyBzaG91bGQgYmUg
cGVyZm9ybWVkIHVzaW5nIHRoZSBwbHVnZ2FibGUgUUF1dGhaIG9iamVjdHMuDQogDQorQHNlY3Rp
b24gU3lzdGVtIGVtdWxhdG9yIENQVVMNCisNCitAc3Vic2VjdGlvbiBSSVNDLVYgSVNBIENQVXMg
KHNpbmNlIDQuMSkNCisNCitUaGUgUklTQy1WIGNwdXMgd2l0aCB0aGUgSVNBIHZlcnNpb24gaW4g
dGhlIENQVSBuYW1lIGhhdmUgYmVlbiBkZXBjcmVhdGVkLiBUaGUNCitmb3VyIENQVXMgYXJlOiBg
YHJ2MzJnY3N1LXYxLjkuMWBgLCBgYHJ2MzJnY3N1LXYxLjEwLjBgYCwgYGBydjY0Z2NzdS12MS45
LjFgYCBhbmQNCitgYHJ2NjRnY3N1LXYxLjEwLjBgYC4gSW5zdGVhZCB0aGUgdmVyc2lvbiBjYW4g
YmUgc3BlY2lmaWVkIHZpYSB0aGUgQ1BVIGBgcHJpdl9zcGVjYGANCitvcHRpb24gd2hlbiB1c2lu
ZyB0aGUgYGBydjMyYGAgb3IgYGBydjY0YGAgQ1BVcy4NCisNCiBAc2VjdGlvbiBTeXN0ZW0gZW11
bGF0b3IgZGV2aWNlcw0KIA0KIEBzdWJzZWN0aW9uIGJsdWV0b290aCAoc2luY2UgMy4xKQ0KZGlm
ZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuYyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KaW5kZXgg
OGYxNGZiOGExZi4uYTM0MzFkNjZhMyAxMDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi9jcHUuYw0K
KysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQpAQCAtMTE0LDYgKzExNCwxMiBAQCBzdGF0aWMgdm9p
ZCByaXNjdl9hbnlfY3B1X2luaXQoT2JqZWN0ICpvYmopDQogDQogI2lmIGRlZmluZWQoVEFSR0VU
X1JJU0NWMzIpDQogDQorc3RhdGljIHZvaWQgcmlzY3ZfYmFzZTMyX2NwdV9pbml0KE9iamVjdCAq
b2JqKQ0KK3sNCisgICAgQ1BVUklTQ1ZTdGF0ZSAqZW52ID0gJlJJU0NWX0NQVShvYmopLT5lbnY7
DQorICAgIHNldF9taXNhKGVudiwgUlYzMiB8IFJWSSB8IFJWTSB8IFJWQSB8IFJWRiB8IFJWRCB8
IFJWQyB8IFJWUyB8IFJWVSk7DQorfQ0KKw0KIHN0YXRpYyB2b2lkIHJ2MzJnY3N1X3ByaXYxXzA5
XzFfY3B1X2luaXQoT2JqZWN0ICpvYmopDQogew0KICAgICBDUFVSSVNDVlN0YXRlICplbnYgPSAm
UklTQ1ZfQ1BVKG9iaiktPmVudjsNCkBAIC0xNDUsNiArMTUxLDEyIEBAIHN0YXRpYyB2b2lkIHJ2
MzJpbWFjdV9ub21tdV9jcHVfaW5pdChPYmplY3QgKm9iaikNCiANCiAjZWxpZiBkZWZpbmVkKFRB
UkdFVF9SSVNDVjY0KQ0KIA0KK3N0YXRpYyB2b2lkIHJpc2N2X2Jhc2U2NF9jcHVfaW5pdChPYmpl
Y3QgKm9iaikNCit7DQorICAgIENQVVJJU0NWU3RhdGUgKmVudiA9ICZSSVNDVl9DUFUob2JqKS0+
ZW52Ow0KKyAgICBzZXRfbWlzYShlbnYsIFJWNjQgfCBSVkkgfCBSVk0gfCBSVkEgfCBSVkYgfCBS
VkQgfCBSVkMgfCBSVlMgfCBSVlUpOw0KK30NCisNCiBzdGF0aWMgdm9pZCBydjY0Z2NzdV9wcml2
MV8wOV8xX2NwdV9pbml0KE9iamVjdCAqb2JqKQ0KIHsNCiAgICAgQ1BVUklTQ1ZTdGF0ZSAqZW52
ID0gJlJJU0NWX0NQVShvYmopLT5lbnY7DQpAQCAtNDkwLDEyICs1MDIsMTQgQEAgc3RhdGljIGNv
bnN0IFR5cGVJbmZvIHJpc2N2X2NwdV90eXBlX2luZm9zW10gPSB7DQogICAgIH0sDQogICAgIERF
RklORV9DUFUoVFlQRV9SSVNDVl9DUFVfQU5ZLCAgICAgICAgICAgICAgcmlzY3ZfYW55X2NwdV9p
bml0KSwNCiAjaWYgZGVmaW5lZChUQVJHRVRfUklTQ1YzMikNCisgICAgREVGSU5FX0NQVShUWVBF
X1JJU0NWX0NQVV9CQVNFMzIsICAgICAgICAgICByaXNjdl9iYXNlMzJfY3B1X2luaXQpLA0KICAg
ICBERUZJTkVfQ1BVKFRZUEVfUklTQ1ZfQ1BVX1JWMzJHQ1NVX1YxXzA5XzEsIHJ2MzJnY3N1X3By
aXYxXzA5XzFfY3B1X2luaXQpLA0KICAgICBERUZJTkVfQ1BVKFRZUEVfUklTQ1ZfQ1BVX1JWMzJH
Q1NVX1YxXzEwXzAsIHJ2MzJnY3N1X3ByaXYxXzEwXzBfY3B1X2luaXQpLA0KICAgICBERUZJTkVf
Q1BVKFRZUEVfUklTQ1ZfQ1BVX1JWMzJJTUFDVV9OT01NVSwgIHJ2MzJpbWFjdV9ub21tdV9jcHVf
aW5pdCksDQogICAgIERFRklORV9DUFUoVFlQRV9SSVNDVl9DUFVfU0lGSVZFX0UzMSwgICAgICAg
cnYzMmltYWN1X25vbW11X2NwdV9pbml0KSwNCiAgICAgREVGSU5FX0NQVShUWVBFX1JJU0NWX0NQ
VV9TSUZJVkVfVTM0LCAgICAgICBydjMyZ2NzdV9wcml2MV8xMF8wX2NwdV9pbml0KQ0KICNlbGlm
IGRlZmluZWQoVEFSR0VUX1JJU0NWNjQpDQorICAgIERFRklORV9DUFUoVFlQRV9SSVNDVl9DUFVf
QkFTRTY0LCAgICAgICAgICAgcmlzY3ZfYmFzZTY0X2NwdV9pbml0KSwNCiAgICAgREVGSU5FX0NQ
VShUWVBFX1JJU0NWX0NQVV9SVjY0R0NTVV9WMV8wOV8xLCBydjY0Z2NzdV9wcml2MV8wOV8xX2Nw
dV9pbml0KSwNCiAgICAgREVGSU5FX0NQVShUWVBFX1JJU0NWX0NQVV9SVjY0R0NTVV9WMV8xMF8w
LCBydjY0Z2NzdV9wcml2MV8xMF8wX2NwdV9pbml0KSwNCiAgICAgREVGSU5FX0NQVShUWVBFX1JJ
U0NWX0NQVV9SVjY0SU1BQ1VfTk9NTVUsICBydjY0aW1hY3Vfbm9tbXVfY3B1X2luaXQpLA0KZGlm
ZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuaCBiL3RhcmdldC9yaXNjdi9jcHUuaA0KaW5kZXgg
NjMyMTk4MzU4NC4uYTJjMWE5YWYwYSAxMDA2NDQNCi0tLSBhL3RhcmdldC9yaXNjdi9jcHUuaA0K
KysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQpAQCAtNDgsNiArNDgsOCBAQA0KICNkZWZpbmUgQ1BV
X1JFU09MVklOR19UWVBFIFRZUEVfUklTQ1ZfQ1BVDQogDQogI2RlZmluZSBUWVBFX1JJU0NWX0NQ
VV9BTlkgICAgICAgICAgICAgIFJJU0NWX0NQVV9UWVBFX05BTUUoImFueSIpDQorI2RlZmluZSBU
WVBFX1JJU0NWX0NQVV9CQVNFMzIgICAgICAgICAgIFJJU0NWX0NQVV9UWVBFX05BTUUoInJ2MzIi
KQ0KKyNkZWZpbmUgVFlQRV9SSVNDVl9DUFVfQkFTRTY0ICAgICAgICAgICBSSVNDVl9DUFVfVFlQ
RV9OQU1FKCJydjY0IikNCiAjZGVmaW5lIFRZUEVfUklTQ1ZfQ1BVX1JWMzJHQ1NVX1YxXzA5XzEg
UklTQ1ZfQ1BVX1RZUEVfTkFNRSgicnYzMmdjc3UtdjEuOS4xIikNCiAjZGVmaW5lIFRZUEVfUklT
Q1ZfQ1BVX1JWMzJHQ1NVX1YxXzEwXzAgUklTQ1ZfQ1BVX1RZUEVfTkFNRSgicnYzMmdjc3UtdjEu
MTAuMCIpDQogI2RlZmluZSBUWVBFX1JJU0NWX0NQVV9SVjMySU1BQ1VfTk9NTVUgIFJJU0NWX0NQ
VV9UWVBFX05BTUUoInJ2MzJpbWFjdS1ub21tdSIpDQotLSANCjIuMjEuMA0KDQo=

