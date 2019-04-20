Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1791DC282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C292121855
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hYtm8+iC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DHsFMxul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C292121855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35770 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfhn-0004iS-Vu
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:26:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffx-0003O2-Qj
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffj-0002MV-B7
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:24:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38653)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHffh-0002Lj-R8; Fri, 19 Apr 2019 22:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727046; x=1587263046;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=1gn9wSg2UBktimUbFrZvmmomEWaUXQomWIeKjSp4d7g=;
	b=hYtm8+iCUoRXk/XF6or5m2G7iUNjOI76FUzBes3J3g3DtIY+15+m31Tg
	Y22DhOHzhM+EXsZKGzjgpf4SQTTQRC6t2PbaafGb1iyT4kMBXa0WJnzma
	x4xV5V/8Gjtqz2TILVDFV9jLQtbzztI8pj0T9IBYfyJCwZS23OM7per3T
	XAxAIj6ZDejt/W+v8+mYLvX29+Tw+eXRu7HCjmCs5Ym9VCThOPvX4NIWV
	bOi7bJRO3J1I0cpv5VZctKkc0ollilZ9oGn+0LpnoK+XpJNBRure82F/4
	0KAmIpZDLi+OjT8H4xG7yJcJSDFxZkT9YfnYBGdAJhm5ZCvG77vzjTmWE Q==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="111349338"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO
	NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:24:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=1gn9wSg2UBktimUbFrZvmmomEWaUXQomWIeKjSp4d7g=;
	b=DHsFMxulUJY4BhWStUWHjKjcbYyS4+S3lLaOnIBkQR90hD1bXBra2HWJnDtPY6lYABVmeI3/nfIRxA0Xdg9glcZVraN1glkNv9ucH+T2B9djV0WT1FeS2zniBsHDPUBQyqpTXXZVZYyrRuiNU3e8tWZOdWpAeSSbSwZy4TlurMc=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB3943.namprd04.prod.outlook.com (52.135.215.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.12; Sat, 20 Apr 2019 02:24:01 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:24:01 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 3/6] target/riscv: Create settable CPU properties
Thread-Index: AQHU9yAdZ6R2Nezjh0+0qUGEnhK5Jw==
Date: Sat, 20 Apr 2019 02:24:01 +0000
Message-ID:
 <ba45fab51cb3d73f872c7070dc988c5e441b3930.1555726824.git.alistair.francis@wdc.com>
References: <cover.1555726824.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555726824.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR02CA0041.namprd02.prod.outlook.com
	(2603:10b6:a03:54::18) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b5dd19e-ec4a-457b-e1bf-08d6c5374034
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB3943; 
x-ms-traffictypediagnostic: BYAPR04MB3943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB39430AE3000209E7644BA17690200@BYAPR04MB3943.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(979002)(366004)(376002)(396003)(136003)(39860400002)(346002)(199004)(189003)(14454004)(446003)(2501003)(6486002)(53936002)(6436002)(50226002)(97736004)(5660300002)(4326008)(305945005)(71200400001)(86362001)(81166006)(8936002)(7736002)(8676002)(71190400001)(73956011)(68736007)(6512007)(25786009)(66946007)(81156014)(66446008)(64756008)(66476007)(66556008)(2906002)(256004)(6116002)(3846002)(36756003)(478600001)(72206003)(99286004)(44832011)(52116002)(66066001)(76176011)(110136005)(386003)(6506007)(102836004)(26005)(186003)(316002)(118296001)(54906003)(2616005)(486006)(476003)(11346002)(969003)(989001)(999001)(1009001)(1019001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3943;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BLITDjVj+TFME0F7W9rGbqYFFyYbMKB/PLTauU1UUFOrHntEd7tnNBzwgOpY0SHkQwtVLz+dtY9M5dUbG52LE7jf/DE4s53GXOHNfZpHbIwD5jIQ7cOU3NM5g8hCGwsNvh+xBGR3k4jinE2Bjdq4lS6sw07MXrCODyNrP5MULTcaHgj+QgDfYCwo/UMPlgLMk3czGoFb84oXysiGrsFrCy0Hsn2zzEPm/+PQ6T9bBD+UgalkAfBEFO9WOJgw2yLkevArjNbcosICq8zJ3hxA1urvtcd59rQXCX5GFxqf289fIXGkLWwWaIyHx81BRrrdVJWgnKg8czhLP6xukwX4kzF8zWhA6tcIfiC92JJyE0OBcJUl5xthsQDEtbVTcTnAWrA6seyMQ4sRYXhrN6B3GDb2XLwfw0+6BCZWnCXDG6g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5dd19e-ec4a-457b-e1bf-08d6c5374034
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:24:01.3876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 3/6] target/riscv: Create settable CPU
 properties
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
Message-ID: <20190420022401.pjp-vo_YcIqa2kL8CJD-0NtrTngY_KDqLplGX4cjSw8@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdS5jIHwgNDkgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KIHRhcmdldC9yaXNjdi9jcHUuaCB8ICA4ICsrKysrKysr
DQogMiBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS90YXJn
ZXQvcmlzY3YvY3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCmluZGV4IGQ2MWJjZTZkNTUuLjhm
MTRmYjhhMWYgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1LmMNCisrKyBiL3RhcmdldC9y
aXNjdi9jcHUuYw0KQEAgLTIyLDYgKzIyLDcgQEANCiAjaW5jbHVkZSAiY3B1LmgiDQogI2luY2x1
ZGUgImV4ZWMvZXhlYy1hbGwuaCINCiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KKyNpbmNsdWRl
ICJody9xZGV2LXByb3BlcnRpZXMuaCINCiAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCIN
CiANCiAvKiBSSVNDLVYgQ1BVIGRlZmluaXRpb25zICovDQpAQCAtMjk2LDcgKzI5NywxMSBAQCBz
dGF0aWMgdm9pZCByaXNjdl9jcHVfZGlzYXNfc2V0X2luZm8oQ1BVU3RhdGUgKnMsIGRpc2Fzc2Vt
YmxlX2luZm8gKmluZm8pDQogc3RhdGljIHZvaWQgcmlzY3ZfY3B1X3JlYWxpemUoRGV2aWNlU3Rh
dGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KIHsNCiAgICAgQ1BVU3RhdGUgKmNzID0gQ1BVKGRldik7
DQorICAgIFJJU0NWQ1BVICpjcHUgPSBSSVNDVl9DUFUoZGV2KTsNCisgICAgQ1BVUklTQ1ZTdGF0
ZSAqZW52ID0gJmNwdS0+ZW52Ow0KICAgICBSSVNDVkNQVUNsYXNzICptY2MgPSBSSVNDVl9DUFVf
R0VUX0NMQVNTKGRldik7DQorICAgIGludCBwcml2X3ZlcnNpb24gPSBQUklWX1ZFUlNJT05fMV8x
MF8wOw0KKyAgICBpbnQgdXNlcl92ZXJzaW9uID0gVVNFUl9WRVJTSU9OXzJfMDJfMDsNCiAgICAg
RXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQogDQogICAgIGNwdV9leGVjX3JlYWxpemVmbihjcywg
JmxvY2FsX2Vycik7DQpAQCAtMzA1LDYgKzMxMCw0MSBAQCBzdGF0aWMgdm9pZCByaXNjdl9jcHVf
cmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQogICAgICAgICByZXR1cm47
DQogICAgIH0NCiANCisgICAgaWYgKGNwdS0+Y2ZnLnByaXZfc3BlYykgew0KKyAgICAgICAgaWYg
KCFnX3N0cmNtcDAoY3B1LT5jZmcucHJpdl9zcGVjLCAidjEuMTAuMCIpKSB7DQorICAgICAgICAg
ICAgcHJpdl92ZXJzaW9uID0gUFJJVl9WRVJTSU9OXzFfMTBfMDsNCisgICAgICAgIH0gZWxzZSBp
ZiAoIWdfc3RyY21wMChjcHUtPmNmZy5wcml2X3NwZWMsICJ2MS45LjEiKSkgew0KKyAgICAgICAg
ICAgIHByaXZfdmVyc2lvbiA9IFBSSVZfVkVSU0lPTl8xXzA5XzE7DQorICAgICAgICB9IGVsc2Ug
ew0KKyAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwNCisgICAgICAgICAgICAgICAgICAgICAg
ICJVbnN1cHBvcnRlZCBwcml2aWxlZ2Ugc3BlYyB2ZXJzaW9uICclcyciLA0KKyAgICAgICAgICAg
ICAgICAgICAgICAgY3B1LT5jZmcucHJpdl9zcGVjKTsNCisgICAgICAgICAgICByZXR1cm47DQor
ICAgICAgICB9DQorICAgIH0NCisNCisgICAgaWYgKGNwdS0+Y2ZnLnVzZXJfc3BlYykgew0KKyAg
ICAgICAgaWYgKCFnX3N0cmNtcDAoY3B1LT5jZmcudXNlcl9zcGVjLCAidjIuMDIuMCIpKSB7DQor
ICAgICAgICAgICAgdXNlcl92ZXJzaW9uID0gVVNFUl9WRVJTSU9OXzJfMDJfMDsNCisgICAgICAg
IH0gZWxzZSB7DQorICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgIlVuc3VwcG9ydGVkIHVzZXIgc3BlYyB2ZXJzaW9uICclcyciLA0KKyAgICAgICAg
ICAgICAgICAgICAgICAgY3B1LT5jZmcudXNlcl9zcGVjKTsNCisgICAgICAgICAgICByZXR1cm47
DQorICAgICAgICB9DQorICAgIH0NCisNCisgICAgc2V0X3ZlcnNpb25zKGVudiwgdXNlcl92ZXJz
aW9uLCBwcml2X3ZlcnNpb24pOw0KKyAgICBzZXRfcmVzZXR2ZWMoZW52LCBERUZBVUxUX1JTVFZF
Qyk7DQorDQorICAgIGlmIChjcHUtPmNmZy5tbXUpIHsNCisgICAgICAgIHNldF9mZWF0dXJlKGVu
diwgUklTQ1ZfRkVBVFVSRV9NTVUpOw0KKyAgICB9DQorDQorICAgIGlmIChjcHUtPmNmZy5wbXAp
IHsNCisgICAgICAgIHNldF9mZWF0dXJlKGVudiwgUklTQ1ZfRkVBVFVSRV9QTVApOw0KKyAgICB9
DQorDQogICAgIHJpc2N2X2NwdV9yZWdpc3Rlcl9nZGJfcmVnc19mb3JfZmVhdHVyZXMoY3MpOw0K
IA0KICAgICBxZW11X2luaXRfdmNwdShjcyk7DQpAQCAtMzI2LDYgKzM2NiwxNCBAQCBzdGF0aWMg
Y29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfcmlzY3ZfY3B1ID0gew0KICAgICAudW5t
aWdyYXRhYmxlID0gMSwNCiB9Ow0KIA0KK3N0YXRpYyBQcm9wZXJ0eSByaXNjdl9jcHVfcHJvcGVy
dGllc1tdID0gew0KKyAgICBERUZJTkVfUFJPUF9TVFJJTkcoInByaXZfc3BlYyIsIFJJU0NWQ1BV
LCBjZmcucHJpdl9zcGVjKSwNCisgICAgREVGSU5FX1BST1BfU1RSSU5HKCJ1c2VyX3NwZWMiLCBS
SVNDVkNQVSwgY2ZnLnVzZXJfc3BlYyksDQorICAgIERFRklORV9QUk9QX0JPT0woIm1tdSIsIFJJ
U0NWQ1BVLCBjZmcubW11LCB0cnVlKSwNCisgICAgREVGSU5FX1BST1BfQk9PTCgicG1wIiwgUklT
Q1ZDUFUsIGNmZy5wbXAsIHRydWUpLA0KKyAgICBERUZJTkVfUFJPUF9FTkRfT0ZfTElTVCgpLA0K
K307DQorDQogc3RhdGljIHZvaWQgcmlzY3ZfY3B1X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmMs
IHZvaWQgKmRhdGEpDQogew0KICAgICBSSVNDVkNQVUNsYXNzICptY2MgPSBSSVNDVl9DUFVfQ0xB
U1MoYyk7DQpAQCAtMzY2LDYgKzQxNCw3IEBAIHN0YXRpYyB2b2lkIHJpc2N2X2NwdV9jbGFzc19p
bml0KE9iamVjdENsYXNzICpjLCB2b2lkICpkYXRhKQ0KICNlbmRpZg0KICAgICAvKiBGb3Igbm93
LCBtYXJrIHVubWlncmF0YWJsZTogKi8NCiAgICAgY2MtPnZtc2QgPSAmdm1zdGF0ZV9yaXNjdl9j
cHU7DQorICAgIGRjLT5wcm9wcyA9IHJpc2N2X2NwdV9wcm9wZXJ0aWVzOw0KIH0NCiANCiBjaGFy
ICpyaXNjdl9pc2Ffc3RyaW5nKFJJU0NWQ1BVICpjcHUpDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jp
c2N2L2NwdS5oIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQppbmRleCAyMGJjZTg3NDJlLi42MzIxOTgz
NTg0IDEwMDY0NA0KLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdS5oDQorKysgYi90YXJnZXQvcmlzY3Yv
Y3B1LmgNCkBAIC0yMjQsNiArMjI0LDE0IEBAIHR5cGVkZWYgc3RydWN0IFJJU0NWQ1BVIHsNCiAg
ICAgQ1BVU3RhdGUgcGFyZW50X29iajsNCiAgICAgLyo8IHB1YmxpYyA+Ki8NCiAgICAgQ1BVUklT
Q1ZTdGF0ZSBlbnY7DQorDQorICAgIC8qIENvbmZpZ3VyYXRpb24gU2V0dGluZ3MgKi8NCisgICAg
c3RydWN0IHsNCisgICAgICAgIGNoYXIgKnByaXZfc3BlYzsNCisgICAgICAgIGNoYXIgKnVzZXJf
c3BlYzsNCisgICAgICAgIGJvb2wgbW11Ow0KKyAgICAgICAgYm9vbCBwbXA7DQorICAgIH0gY2Zn
Ow0KIH0gUklTQ1ZDUFU7DQogDQogc3RhdGljIGlubGluZSBSSVNDVkNQVSAqcmlzY3ZfZW52X2dl
dF9jcHUoQ1BVUklTQ1ZTdGF0ZSAqZW52KQ0KLS0gDQoyLjIxLjANCg0K

