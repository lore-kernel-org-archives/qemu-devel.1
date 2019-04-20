Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D76CC282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2448421479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZGizO37D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TpW2iRE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2448421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfna-0001tv-Do
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:32:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiU-0005x5-P6
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiT-0003Yl-OZ
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:26:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28901)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiT-0003YC-DH; Fri, 19 Apr 2019 22:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727218; x=1587263218;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=MOy3AU4sfrjbQQnW0dYf9xEXccTm7ck8O5ntxUD2yQY=;
	b=ZGizO37Dcc+ktWQOKCz/aMnJxFE7FteYhgcTeEPuk0TPZnht97dKjjHM
	RbQZnKjCbl85ztCOlbv5RKknAmsE1iPSI5NKc+6mD4Q4CCVPI4/wEnaGp
	aHRBl38nyxgNenF6i6MWh5WSFXbPcc4vd2zs22HLGJp9Ei1TTwvCJxF3G
	27hEZ3DN3aNCnT5HSY8bMJjjAAxL0xbdWQMuqPW1PMzv0xxns36KKhYb8
	6vBXMafHhJ8aRXSYqq5YYllvHPDOfkPorTBKacYf6/EfBget0QxKcDD7w
	EZw1E/bHMLX71FABtwHiYFJs0uK18gqUWqtLVeZzOFbi1a8gqcf4VIase w==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617961"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO
	NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:26:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=MOy3AU4sfrjbQQnW0dYf9xEXccTm7ck8O5ntxUD2yQY=;
	b=TpW2iRE2eTBISU8Q4/Z6jTQ09o9UxUgCcqgQhs3uVUmmXxETuavQXePjl96oz6F+06wni8KVE7w7+odGK5wv4K63hNCvZEK7pAe5amvXoOpZFoN3GUz4yELVu5Ct3cwdhleCPnZlyyFCQnd3tulQpRelzQ0saFRy+SrEzOKG18w=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5319.namprd04.prod.outlook.com (20.178.49.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Sat, 20 Apr 2019 02:26:54 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:26:54 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 2/8] target/riscv: Trigger interrupt on MIP update
	asynchronously
Thread-Index: AQHU9yCFJsv+NIOmkUWFP451+t6rHA==
Date: Sat, 20 Apr 2019 02:26:54 +0000
Message-ID:
 <dee02a97e08795eb864dcf497c749a6695c6996f.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BY5PR16CA0034.namprd16.prod.outlook.com
	(2603:10b6:a03:1a0::47) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86fcd585-2d43-4c97-379f-08d6c537a75f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5319; 
x-ms-traffictypediagnostic: BYAPR04MB5319:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5319B234B18FD11B11CF15F690200@BYAPR04MB5319.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(50226002)(52116002)(6486002)(14454004)(446003)(6436002)(76176011)(476003)(486006)(3846002)(6116002)(97736004)(2616005)(7736002)(81156014)(8676002)(478600001)(8936002)(72206003)(386003)(6506007)(81166006)(102836004)(26005)(186003)(36756003)(316002)(6512007)(44832011)(53936002)(68736007)(66066001)(118296001)(25786009)(4326008)(305945005)(99286004)(54906003)(2906002)(11346002)(110136005)(2501003)(256004)(64756008)(14444005)(66446008)(66556008)(73956011)(66946007)(66476007)(71200400001)(5660300002)(71190400001)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5319;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P6LedQWBATWEVYP2G/oICtxSIiaP+DFhWYeZUzBe3R4GEvNlbjayI2NtZwKencz1Z/ZKyXp37yve2gMuxs+Vp4Xooanhm6JKQqiAJR5J+GPfa0/JNAE2Kzjlxc8l19BQgT68j/iGGrG9sU5w9RuTZxEkkRWuCUI20WglBsULZA1feesyBfrqY0Rk6Ta2G8XeRt00Wql2u7okkJNfSouT5ZgfnmU05oCGJAIGyr8oqxsvjEQ6/Hf74WGBtaSXvFwpXD6zhF1jX/O0guVEEaKOAC0UJIno01/ny2TAP9a79wUUPnqazJrWQQ4DEeStnw/PqOupDz8pK9mYtcMTxNexoIhRtn3F9Jn3132Fm+hNdLjZjV4IEsM9mq1qk2Wpj1kEXzuLpPOC8mf+8Q4Nw5THkjBrVeBwv16AYG3hsdGEIDk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fcd585-2d43-4c97-379f-08d6c537a75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:26:54.5345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5319
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 2/8] target/riscv: Trigger interrupt on MIP
 update asynchronously
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
Message-ID: <20190420022654.Qix4xIxBx4qww-iim6LAs2FQ4hv7Tz0CIIXeUDRRogA@z>

VGhlIHJlcXVpcmVtZW50IG9mIGhvbGRpbmcgdGhlIGlvdGhyZWFkX211dGV4IGlzIGJ1cmRlcnNv
bWUgd2hlbg0Kc3dhcHBpbmcgdGhlIGJhY2tncm91bmQgYW5kIGZvcmVncm91bmQgcmVnaXN0ZXJz
IGluIHRoZSBIeXBlcnZpc29yDQpleHRlbnNpb24uIFRvIGF2b2lkIHRoZSByZXF1cmlyZW1lbnQg
bGV0J3Mgc2V0IHRoZSBpbnRlcnJ1cHQNCmFzeW5jaHJvbm91c2x5Lg0KDQpTaWduZWQtb2ZmLWJ5
OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQotLS0NCiB0YXJn
ZXQvcmlzY3YvY3B1X2hlbHBlci5jIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tDQogdGFyZ2V0L3Jpc2N2L2Nzci5jICAgICAgICB8ICAyIC0tDQogMiBmaWxlcyBjaGFuZ2Vk
LCAyNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCmluZGV4IGIx
N2YxNjk2ODEuLjU4MmQ1OGFhZDkgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2hlbHBl
ci5jDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQpAQCAtODIsMTAgKzgyLDMxIEBA
IGludCByaXNjdl9jcHVfY2xhaW1faW50ZXJydXB0cyhSSVNDVkNQVSAqY3B1LCB1aW50MzJfdCBp
bnRlcnJ1cHRzKQ0KICAgICB9DQogfQ0KIA0KLS8qIGlvdGhyZWFkX211dGV4IG11c3QgYmUgaGVs
ZCAqLw0KK3N0cnVjdCBDcHVBc3luY0luZm8gew0KKyAgICB1aW50MzJfdCBuZXdfbWlwOw0KK307
DQorDQorc3RhdGljIHZvaWQgcmlzY3ZfY3B1X3VwZGF0ZV9taXBfaXJxc19hc3luYyhDUFVTdGF0
ZSAqdGFyZ2V0X2NwdV9zdGF0ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJ1bl9vbl9jcHVfZGF0YSBkYXRhKQ0KK3sNCisgICAgQ1BVUklTQ1ZTdGF0ZSAq
ZW52ID0gJlJJU0NWX0NQVSh0YXJnZXRfY3B1X3N0YXRlKS0+ZW52Ow0KKyAgICBSSVNDVkNQVSAq
Y3B1ID0gcmlzY3ZfZW52X2dldF9jcHUoZW52KTsNCisgICAgc3RydWN0IENwdUFzeW5jSW5mbyAq
aW5mbyA9IChzdHJ1Y3QgQ3B1QXN5bmNJbmZvICopIGRhdGEuaG9zdF9wdHI7DQorDQorICAgIGlm
IChpbmZvLT5uZXdfbWlwKSB7DQorICAgICAgICBjcHVfaW50ZXJydXB0KENQVShjcHUpLCBDUFVf
SU5URVJSVVBUX0hBUkQpOw0KKyAgICB9IGVsc2Ugew0KKyAgICAgICAgY3B1X3Jlc2V0X2ludGVy
cnVwdChDUFUoY3B1KSwgQ1BVX0lOVEVSUlVQVF9IQVJEKTsNCisgICAgfQ0KKw0KKyAgICBnX2Zy
ZWUoaW5mbyk7DQorfQ0KKw0KIHVpbnQzMl90IHJpc2N2X2NwdV91cGRhdGVfbWlwKFJJU0NWQ1BV
ICpjcHUsIHVpbnQzMl90IG1hc2ssIHVpbnQzMl90IHZhbHVlKQ0KIHsNCiAgICAgQ1BVUklTQ1ZT
dGF0ZSAqZW52ID0gJmNwdS0+ZW52Ow0KKyAgICBDUFVTdGF0ZSAqY3MgPSBDUFUoY3B1KTsNCisg
ICAgc3RydWN0IENwdUFzeW5jSW5mbyAqaW5mbzsNCiAgICAgdWludDMyX3Qgb2xkLCBuZXcsIGNt
cCA9IGF0b21pY19yZWFkKCZlbnYtPm1pcCk7DQogDQogICAgIGRvIHsNCkBAIC05NCwxMSArMTE1
LDExIEBAIHVpbnQzMl90IHJpc2N2X2NwdV91cGRhdGVfbWlwKFJJU0NWQ1BVICpjcHUsIHVpbnQz
Ml90IG1hc2ssIHVpbnQzMl90IHZhbHVlKQ0KICAgICAgICAgY21wID0gYXRvbWljX2NtcHhjaGco
JmVudi0+bWlwLCBvbGQsIG5ldyk7DQogICAgIH0gd2hpbGUgKG9sZCAhPSBjbXApOw0KIA0KLSAg
ICBpZiAobmV3KSB7DQotICAgICAgICBjcHVfaW50ZXJydXB0KENQVShjcHUpLCBDUFVfSU5URVJS
VVBUX0hBUkQpOw0KLSAgICB9IGVsc2Ugew0KLSAgICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChD
UFUoY3B1KSwgQ1BVX0lOVEVSUlVQVF9IQVJEKTsNCi0gICAgfQ0KKyAgICBpbmZvID0gZ19uZXco
c3RydWN0IENwdUFzeW5jSW5mbywgMSk7DQorICAgIGluZm8tPm5ld19taXAgPSBuZXc7DQorDQor
ICAgIGFzeW5jX3J1bl9vbl9jcHUoY3MsIHJpc2N2X2NwdV91cGRhdGVfbWlwX2lycXNfYXN5bmMs
DQorICAgICAgICAgICAgICAgICAgICAgUlVOX09OX0NQVV9IT1NUX1BUUihpbmZvKSk7DQogDQog
ICAgIHJldHVybiBvbGQ7DQogfQ0KZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jc3IuYyBiL3Rh
cmdldC9yaXNjdi9jc3IuYw0KaW5kZXggZTFkOTFiNmM2MC4uZjlkOGQxNTBlMCAxMDA2NDQNCi0t
LSBhL3RhcmdldC9yaXNjdi9jc3IuYw0KKysrIGIvdGFyZ2V0L3Jpc2N2L2Nzci5jDQpAQCAtNTU1
LDkgKzU1NSw3IEBAIHN0YXRpYyBpbnQgcm13X21pcChDUFVSSVNDVlN0YXRlICplbnYsIGludCBj
c3JubywgdGFyZ2V0X3Vsb25nICpyZXRfdmFsdWUsDQogICAgIHVpbnQzMl90IG9sZF9taXA7DQog
DQogICAgIGlmIChtYXNrKSB7DQotICAgICAgICBxZW11X211dGV4X2xvY2tfaW90aHJlYWQoKTsN
CiAgICAgICAgIG9sZF9taXAgPSByaXNjdl9jcHVfdXBkYXRlX21pcChjcHUsIG1hc2ssIChuZXdf
dmFsdWUgJiBtYXNrKSk7DQotICAgICAgICBxZW11X211dGV4X3VubG9ja19pb3RocmVhZCgpOw0K
ICAgICB9IGVsc2Ugew0KICAgICAgICAgb2xkX21pcCA9IGF0b21pY19yZWFkKCZlbnYtPm1pcCk7
DQogICAgIH0NCi0tIA0KMi4yMS4wDQoNCg==

