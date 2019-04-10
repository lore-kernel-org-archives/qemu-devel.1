Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BE3C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E5D20820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iAA88j1l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FvTeeykG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E5D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39033 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEMWd-0000Rz-Cu
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 19:21:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMV3-0007i8-Bv
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMOA-0001zX-Ig
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:12:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20591)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMO5-00012F-NC; Wed, 10 Apr 2019 19:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1554937934; x=1586473934;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=8US91+wrcXdFSsSG/aFlw54dANhJAyMsmteQebGTF+4=;
	b=iAA88j1l+zRxAaJgFFP8P0seutwys6Dts2h0/6qVthLM13Yvf98OGF/z
	b/OmBW9wKdQO5xnoR9LcocVa+Ai8D2Cq/yHGe8kdxozqwyTvtp2Tl8lCl
	2QtvLuhna4RIlEDMsKBsoQbmjVlaqlQ1TCxZcSacYBE50dPoESsPE+7+E
	ynpEscolhavRqv2YH+mKw98gQig73z1JDEoubM3nYw2OMle7nytIXUltP
	0NbpmdQgk+gV39OTmM5TjuHRrGaCPQD3DKCyefKPRL07fzbIgZLWgBEGi
	943+CUKvFwSzBBwTZcfmvrgvRc1GJVeqYHptA0x2jq24YT4dyuRWmcT/h w==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; d="scan'208";a="106823596"
Received: from mail-bn3nam04lp2058.outbound.protection.outlook.com (HELO
	NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.58])
	by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:10:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=8US91+wrcXdFSsSG/aFlw54dANhJAyMsmteQebGTF+4=;
	b=FvTeeykG1Xx7zWEZTP7grgj9w6ONyanE8ccQMczPRRq83ScutCIdKttJMfHnYfxvPYO6R86dk3gB+SWM0y6EhGjq/HIgjfQKYYGP4JKIa9sn/r5DVSSfLbEox5gWbH6qkiudBHdUOoBuiRLBx8vq58g+nR9fVFpJkzTq5u10mIs=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5334.namprd04.prod.outlook.com (20.178.50.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Wed, 10 Apr 2019 23:10:34 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1771.021;
	Wed, 10 Apr 2019 23:10:34 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH for 4.1 v3 3/6] target/riscv: Create settable CPU
	properties
Thread-Index: AQHU7/KZVDqEvlpNvEG7d4RwzPYOrA==
Date: Wed, 10 Apr 2019 23:10:34 +0000
Message-ID:
 <101609f0bfeb395344729ef4189103c1831e069b.1554937288.git.alistair.francis@wdc.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1554937288.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR04CA0017.namprd04.prod.outlook.com
	(2603:10b6:a03:40::30) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16529355-dd07-4011-88f6-08d6be09bc09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5334; 
x-ms-traffictypediagnostic: BYAPR04MB5334:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5334DBACC5CB24DD546F2543902E0@BYAPR04MB5334.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(99286004)(11346002)(8936002)(14454004)(2616005)(6486002)(305945005)(6436002)(478600001)(97736004)(446003)(71190400001)(118296001)(2501003)(66066001)(476003)(4326008)(256004)(44832011)(71200400001)(486006)(86362001)(102836004)(186003)(36756003)(81156014)(72206003)(3846002)(8676002)(25786009)(386003)(6506007)(5660300002)(53936002)(7736002)(50226002)(106356001)(105586002)(2906002)(68736007)(6116002)(54906003)(26005)(316002)(6512007)(81166006)(110136005)(52116002)(76176011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5334;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qo1ZaRDgOHTER0kDlIPo9whlr8Ds18Wgna5I4JsGfrF0fRYvW7u9KJLJSUPah+uattuYawX2vkHCZlGH++mlOx5nlgEBSm8aDvKfzAbvBA6YYcsw0gWm7rr2an7FUvlOiTf90n3gbvuypEMQLUaUXbFFlWW9k3KPn60WCtJK6nfnVeIZRkW2xty9NY1C9c9p2J+i036Hh6LqsC7Cgi3lY1HaDgZFrT2c+2kxnOStyr0GF18O2KCYVKyCrqjEjjvLCYrih/nGPYZ5DaBqmJ4/WuqyGKg9cdd8fZGPnMbpYc84u+Yy53Y2ELVLKxGvQK3GxJrH7yd5nWif0zsQRBEK3F419elqfeIs1OcMZLdFMVDkvyvMQZYb43/VeQfYOvzTcAnVCYCIv4uqAJ8uVdumQVTlzfES5ywyvbebx+UWYPw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16529355-dd07-4011-88f6-08d6be09bc09
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 23:10:34.1360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH for 4.1 v3 3/6] target/riscv: Create settable
 CPU properties
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
Message-ID: <20190410231034.Om0_ziXK7KxVqLupgEUcaHJ4-oy98zRZEmME2-oCGH8@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdS5jIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLQ0KIHRhcmdldC9yaXNjdi9jcHUuaCB8ICA4ICsrKysrKysN
CiAyIGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCmluZGV4
IDI3YmU5ZTQxMmEuLmM3OTJiYWNkMjQgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMN
CisrKyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KQEAgLTIzLDYgKzIzLDcgQEANCiAjaW5jbHVkZSAi
Y3B1LmgiDQogI2luY2x1ZGUgImV4ZWMvZXhlYy1hbGwuaCINCiAjaW5jbHVkZSAicWFwaS9lcnJv
ci5oIg0KKyNpbmNsdWRlICJody9xZGV2LXByb3BlcnRpZXMuaCINCiAjaW5jbHVkZSAibWlncmF0
aW9uL3Ztc3RhdGUuaCINCiANCiAvKiBSSVNDLVYgQ1BVIGRlZmluaXRpb25zICovDQpAQCAtMTkx
LDEyICsxOTIsOSBAQCBzdGF0aWMgdm9pZCByaXNjdl9nZW5lcmF0ZV9jcHVfaW5pdChPYmplY3Qg
Km9iaikNCiAgICAgfQ0KIA0KICAgICBzZXRfbWlzYShlbnYsIHJ2eGxlbiB8IHRhcmdldF9taXNh
KTsNCi0gICAgc2V0X3ZlcnNpb25zKGVudiwgVVNFUl9WRVJTSU9OXzJfMDJfMCwgUFJJVl9WRVJT
SU9OXzFfMTBfMCk7DQotICAgIHNldF9yZXNldHZlYyhlbnYsIERFRkFVTFRfUlNUVkVDKTsNCi0g
ICAgc2V0X2ZlYXR1cmUoZW52LCBSSVNDVl9GRUFUVVJFX01NVSk7DQotICAgIHNldF9mZWF0dXJl
KGVudiwgUklTQ1ZfRkVBVFVSRV9QTVApOw0KIH0NCiANCisNCiBzdGF0aWMgdm9pZCByaXNjdl9h
bnlfY3B1X2luaXQoT2JqZWN0ICpvYmopDQogew0KICAgICBDUFVSSVNDVlN0YXRlICplbnYgPSAm
UklTQ1ZfQ1BVKG9iaiktPmVudjsNCkBAIC0zOTQsNyArMzkyLDExIEBAIHN0YXRpYyB2b2lkIHJp
c2N2X2NwdV9kaXNhc19zZXRfaW5mbyhDUFVTdGF0ZSAqcywgZGlzYXNzZW1ibGVfaW5mbyAqaW5m
bykNCiBzdGF0aWMgdm9pZCByaXNjdl9jcHVfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJv
ciAqKmVycnApDQogew0KICAgICBDUFVTdGF0ZSAqY3MgPSBDUFUoZGV2KTsNCisgICAgUklTQ1ZD
UFUgKmNwdSA9IFJJU0NWX0NQVShkZXYpOw0KKyAgICBDUFVSSVNDVlN0YXRlICplbnYgPSAmY3B1
LT5lbnY7DQogICAgIFJJU0NWQ1BVQ2xhc3MgKm1jYyA9IFJJU0NWX0NQVV9HRVRfQ0xBU1MoZGV2
KTsNCisgICAgaW50IHByaXZfdmVyc2lvbiA9IFBSSVZfVkVSU0lPTl8xXzEwXzA7DQorICAgIGlu
dCB1c2VyX3ZlcnNpb24gPSBVU0VSX1ZFUlNJT05fMl8wMl8wOw0KICAgICBFcnJvciAqbG9jYWxf
ZXJyID0gTlVMTDsNCiANCiAgICAgY3B1X2V4ZWNfcmVhbGl6ZWZuKGNzLCAmbG9jYWxfZXJyKTsN
CkBAIC00MDMsNiArNDA1LDM5IEBAIHN0YXRpYyB2b2lkIHJpc2N2X2NwdV9yZWFsaXplKERldmlj
ZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCiAgICAgICAgIHJldHVybjsNCiAgICAgfQ0KIA0K
KyAgICBpZiAoY3B1LT5jZmcucHJpdl9zcGVjKSB7DQorICAgICAgICBpZiAoIWdfc3RyY21wMChj
cHUtPmNmZy5wcml2X3NwZWMsICJ2MS4xMC4wIikpIHsNCisgICAgICAgICAgICBwcml2X3ZlcnNp
b24gPSBQUklWX1ZFUlNJT05fMV8xMF8wOw0KKyAgICAgICAgfSBlbHNlIGlmICghZ19zdHJjbXAw
KGNwdS0+Y2ZnLnByaXZfc3BlYywgInYxLjkuMSIpKSB7DQorICAgICAgICAgICAgcHJpdl92ZXJz
aW9uID0gUFJJVl9WRVJTSU9OXzFfMDlfMTsNCisgICAgICAgIH0gZWxzZSB7DQorICAgICAgICAg
ICAgZXJyb3JfcmVwb3J0KCJVbnN1cHBvcnRlZCBwcml2aWxlZ2Ugc3BlYyB2ZXJzaW9uICclcyci
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICBjcHUtPmNmZy5wcml2X3NwZWMpOw0KKyAgICAg
ICAgICAgIGV4aXQoMSk7DQorICAgICAgICB9DQorICAgIH0NCisNCisgICAgaWYgKGNwdS0+Y2Zn
LnVzZXJfc3BlYykgew0KKyAgICAgICAgaWYgKCFnX3N0cmNtcDAoY3B1LT5jZmcudXNlcl9zcGVj
LCAidjIuMDIuMCIpKSB7DQorICAgICAgICAgICAgdXNlcl92ZXJzaW9uID0gVVNFUl9WRVJTSU9O
XzJfMDJfMDsNCisgICAgICAgIH0gZWxzZSB7DQorICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJV
bnN1cHBvcnRlZCB1c2VyIHNwZWMgdmVyc2lvbiAnJXMnIiwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgY3B1LT5jZmcudXNlcl9zcGVjKTsNCisgICAgICAgICAgICBleGl0KDEpOw0KKyAgICAg
ICAgfQ0KKyAgICB9DQorDQorICAgIHNldF92ZXJzaW9ucyhlbnYsIHVzZXJfdmVyc2lvbiwgcHJp
dl92ZXJzaW9uKTsNCisgICAgc2V0X3Jlc2V0dmVjKGVudiwgREVGQVVMVF9SU1RWRUMpOw0KKw0K
KyAgICBpZiAoY3B1LT5jZmcubW11KSB7DQorICAgICAgICBzZXRfZmVhdHVyZShlbnYsIFJJU0NW
X0ZFQVRVUkVfTU1VKTsNCisgICAgfQ0KKw0KKyAgICBpZiAoY3B1LT5jZmcucG1wKSB7DQorICAg
ICAgICBzZXRfZmVhdHVyZShlbnYsIFJJU0NWX0ZFQVRVUkVfUE1QKTsNCisgICAgfQ0KKw0KICAg
ICByaXNjdl9jcHVfcmVnaXN0ZXJfZ2RiX3JlZ3NfZm9yX2ZlYXR1cmVzKGNzKTsNCiANCiAgICAg
cWVtdV9pbml0X3ZjcHUoY3MpOw0KQEAgLTQyNCw2ICs0NTksMTQgQEAgc3RhdGljIGNvbnN0IFZN
U3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX3Jpc2N2X2NwdSA9IHsNCiAgICAgLnVubWlncmF0YWJs
ZSA9IDEsDQogfTsNCiANCitzdGF0aWMgUHJvcGVydHkgcmlzY3ZfY3B1X3Byb3BlcnRpZXNbXSA9
IHsNCisgICAgREVGSU5FX1BST1BfU1RSSU5HKCJwcml2X3NwZWMiLCBSSVNDVkNQVSwgY2ZnLnBy
aXZfc3BlYyksDQorICAgIERFRklORV9QUk9QX1NUUklORygidXNlcl9zcGVjIiwgUklTQ1ZDUFUs
IGNmZy51c2VyX3NwZWMpLA0KKyAgICBERUZJTkVfUFJPUF9CT09MKCJtbXUiLCBSSVNDVkNQVSwg
Y2ZnLm1tdSwgdHJ1ZSksDQorICAgIERFRklORV9QUk9QX0JPT0woInBtcCIsIFJJU0NWQ1BVLCBj
ZmcucG1wLCB0cnVlKSwNCisgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwNCit9Ow0KKw0K
IHN0YXRpYyB2b2lkIHJpc2N2X2NwdV9jbGFzc19pbml0KE9iamVjdENsYXNzICpjLCB2b2lkICpk
YXRhKQ0KIHsNCiAgICAgUklTQ1ZDUFVDbGFzcyAqbWNjID0gUklTQ1ZfQ1BVX0NMQVNTKGMpOw0K
QEAgLTQ2NCw2ICs1MDcsNyBAQCBzdGF0aWMgdm9pZCByaXNjdl9jcHVfY2xhc3NfaW5pdChPYmpl
Y3RDbGFzcyAqYywgdm9pZCAqZGF0YSkNCiAjZW5kaWYNCiAgICAgLyogRm9yIG5vdywgbWFyayB1
bm1pZ3JhdGFibGU6ICovDQogICAgIGNjLT52bXNkID0gJnZtc3RhdGVfcmlzY3ZfY3B1Ow0KKyAg
ICBkYy0+cHJvcHMgPSByaXNjdl9jcHVfcHJvcGVydGllczsNCiB9DQogDQogY2hhciAqcmlzY3Zf
aXNhX3N0cmluZyhSSVNDVkNQVSAqY3B1KQ0KZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUu
aCBiL3RhcmdldC9yaXNjdi9jcHUuaA0KaW5kZXggNDUzMTA4YTg1NS4uYmM4NzdkODEwNyAxMDA2
NDQNCi0tLSBhL3RhcmdldC9yaXNjdi9jcHUuaA0KKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQpA
QCAtMjI2LDYgKzIyNiwxNCBAQCB0eXBlZGVmIHN0cnVjdCBSSVNDVkNQVSB7DQogICAgIENQVVN0
YXRlIHBhcmVudF9vYmo7DQogICAgIC8qPCBwdWJsaWMgPiovDQogICAgIENQVVJJU0NWU3RhdGUg
ZW52Ow0KKw0KKyAgICAvKiBDb25maWd1cmF0aW9uIFNldHRpbmdzICovDQorICAgIHN0cnVjdCB7
DQorICAgICAgICBjaGFyICpwcml2X3NwZWM7DQorICAgICAgICBjaGFyICp1c2VyX3NwZWM7DQor
ICAgICAgICBib29sIG1tdTsNCisgICAgICAgIGJvb2wgcG1wOw0KKyAgICB9IGNmZzsNCiB9IFJJ
U0NWQ1BVOw0KIA0KIHN0YXRpYyBpbmxpbmUgUklTQ1ZDUFUgKnJpc2N2X2Vudl9nZXRfY3B1KENQ
VVJJU0NWU3RhdGUgKmVudikNCi0tIA0KMi4yMS4wDQoNCg==

