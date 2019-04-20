Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618F0C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B9721479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mWO3zno+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aD/5D1su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B9721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfmv-0001NN-9K
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:31:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiy-0006Pg-AK
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfix-0003sD-5X
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:28 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiw-0003nR-C3; Fri, 19 Apr 2019 22:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727247; x=1587263247;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=HmPVIQhkcRPoVWYGP8u5VazDlePLh3+93P2aoqioBGg=;
	b=mWO3zno+6x8chW9yfbEXEySmX6iesWNeZoym7tfEL60Xb7g5g9xNkvs2
	5vsgaZw6qIByTXcgzuaVfjZSRsYpDPkXibne6DCX5IZu07QZu+PKlXrlO
	HDW/5r90I6N0JPS+Fjs/2zjVZvvekksZsVxBNca3xy1kTWIUuWP6Dq9UK
	5OG8Zv4VNtSHnjPfu6LKW2MgTmbliFSXM1KbmL7kEORWUuzuTK+OHZrDE
	EKoOhAh8hszKIm+cDZRijMSnnGgsm38EKnERo0e8BgzLSZj4M9Hur4AIn
	rJRJDwN8QcK1rVOEwQfJCmY85fLpjtaAX72s+8qUbKSVKtspaA8ja/Nyw Q==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617966"
Received: from mail-bn3nam01lp2056.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.56])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:27:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=HmPVIQhkcRPoVWYGP8u5VazDlePLh3+93P2aoqioBGg=;
	b=aD/5D1suK4GFS2GMOQMbdhsdgGwj1iEsgRYtDvc/H3lEqhPNxLfyYr+vU5fIOGq9t/HQ9nD9MMM6NQTkohRyndgSNBbe4/QuX50jj8PWX6qZ9eKyjCRH9vkokrAcxwOMtwRubqOQZzbPavdTNS9etV37wUTImEtvNP8mwheL67M=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5319.namprd04.prod.outlook.com (20.178.49.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Sat, 20 Apr 2019 02:27:18 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:27:18 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 5/8] target/riscv: Allow setting mstatus virtulisation
	bits
Thread-Index: AQHU9yCTVrT81EhUwUeZOxz5rxQAEA==
Date: Sat, 20 Apr 2019 02:27:18 +0000
Message-ID:
 <3627cb54d89661d53ffc70535af4811977e1daea.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR08CA0003.namprd08.prod.outlook.com
	(2603:10b6:a03:100::16) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a8500c5-681a-4d4c-a4f8-08d6c537b5dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5319; 
x-ms-traffictypediagnostic: BYAPR04MB5319:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB53196A275AEC63DA968E13BD90200@BYAPR04MB5319.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(50226002)(52116002)(6486002)(14454004)(446003)(6436002)(76176011)(476003)(486006)(3846002)(6116002)(97736004)(2616005)(7736002)(81156014)(8676002)(478600001)(8936002)(72206003)(386003)(6506007)(81166006)(102836004)(26005)(186003)(36756003)(316002)(6512007)(44832011)(53936002)(68736007)(66066001)(118296001)(25786009)(4326008)(305945005)(99286004)(54906003)(2906002)(11346002)(110136005)(2501003)(256004)(64756008)(66446008)(66556008)(73956011)(66946007)(66476007)(71200400001)(5660300002)(71190400001)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5319;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nTQVLtMeLM1sffemRbPgUOFTwIwMmbAZaxsnXFzOpEmmHCf06BBGmYyJU9CULylGF5iYZdnWqYopiboP/BECWJ0MSNO2LfXEWeJIK+Yh69lYH+bXm9l5nspv3wybsXNjOEZtYtgfkJlFjtXbkaNveOUYZeoV5jUKTmfGm8TDZzC+VjteyD4N0U/KTvGeXN9XTwNbOxK+fCGfd+BAK5FA8qDAqsJZaoSzltXnFyJJPYO8XvFopRqB2aGLuY1/vYKjC8us1I3iNrIqGPqKszyPUDAq+8uTntwgPU/za45dO+CM5hdbp/G7ALkbP18QuYeVuQL/rR62pL45HFO8EXMKpgSB5lPXdf36YaF7vo+nnGq1+7Oid2sVIctySyjnzUPpzEVv52kA+QO0j8Wlv7GAHPSCrgiBlxZPw4vfqfo1ms0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8500c5-681a-4d4c-a4f8-08d6c537b5dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:27:18.6724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5319
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 5/8] target/riscv: Allow setting mstatus
 virtulisation bits
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
Message-ID: <20190420022718.E8VsX-V2bYzlmnTS1mr_9xgFBduBhkxKyKeTfxeLff0@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2Nzci5jIHwgMTcgKysrKysrKystLS0tLS0tLS0NCiAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L3Jpc2N2L2Nzci5jIGIvdGFyZ2V0L3Jpc2N2L2Nzci5jDQppbmRleCBmOWQ4ZDE1
MGUwLi5lNmQ2OGE5OTU2IDEwMDY0NA0KLS0tIGEvdGFyZ2V0L3Jpc2N2L2Nzci5jDQorKysgYi90
YXJnZXQvcmlzY3YvY3NyLmMNCkBAIC0yOTAsNyArMjkwLDYgQEAgc3RhdGljIGludCB3cml0ZV9t
c3RhdHVzKENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLCB0YXJnZXRfdWxvbmcgdmFsKQ0K
IHsNCiAgICAgdGFyZ2V0X3Vsb25nIG1zdGF0dXMgPSBlbnYtPm1zdGF0dXM7DQogICAgIHRhcmdl
dF91bG9uZyBtYXNrID0gMDsNCi0gICAgdGFyZ2V0X3Vsb25nIG1wcCA9IGdldF9maWVsZCh2YWws
IE1TVEFUVVNfTVBQKTsNCiANCiAgICAgLyogZmx1c2ggdGxiIG9uIG1zdGF0dXMgZmllbGRzIHRo
YXQgYWZmZWN0IFZNICovDQogICAgIGlmIChlbnYtPnByaXZfdmVyIDw9IFBSSVZfVkVSU0lPTl8x
XzA5XzEpIHsNCkBAIC0zMDUsNyArMzA0LDcgQEAgc3RhdGljIGludCB3cml0ZV9tc3RhdHVzKENQ
VVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLCB0YXJnZXRfdWxvbmcgdmFsKQ0KICAgICAgICAg
ICAgICAgICBNU1RBVFVTX1ZNIDogMCk7DQogICAgIH0NCiAgICAgaWYgKGVudi0+cHJpdl92ZXIg
Pj0gUFJJVl9WRVJTSU9OXzFfMTBfMCkgew0KLSAgICAgICAgaWYgKCh2YWwgXiBtc3RhdHVzKSAm
IChNU1RBVFVTX01YUiB8IE1TVEFUVVNfTVBQIHwNCisgICAgICAgIGlmICgodmFsIF4gbXN0YXR1
cykgJiAoTVNUQVRVU19NWFIgfCBNU1RBVFVTX01QUCB8IE1TVEFUVVNfTVBWIHwNCiAgICAgICAg
ICAgICAgICAgTVNUQVRVU19NUFJWIHwgTVNUQVRVU19TVU0pKSB7DQogICAgICAgICAgICAgdGxi
X2ZsdXNoKENQVShyaXNjdl9lbnZfZ2V0X2NwdShlbnYpKSk7DQogICAgICAgICB9DQpAQCAtMzEz
LDEzICszMTIsMTMgQEAgc3RhdGljIGludCB3cml0ZV9tc3RhdHVzKENQVVJJU0NWU3RhdGUgKmVu
diwgaW50IGNzcm5vLCB0YXJnZXRfdWxvbmcgdmFsKQ0KICAgICAgICAgICAgIE1TVEFUVVNfU1BQ
IHwgTVNUQVRVU19GUyB8IE1TVEFUVVNfTVBSViB8IE1TVEFUVVNfU1VNIHwNCiAgICAgICAgICAg
ICBNU1RBVFVTX01QUCB8IE1TVEFUVVNfTVhSIHwgTVNUQVRVU19UVk0gfCBNU1RBVFVTX1RTUiB8
DQogICAgICAgICAgICAgTVNUQVRVU19UVzsNCi0gICAgfQ0KLQ0KLSAgICAvKiBzaWxlbnR5IGRp
c2NhcmQgbXN0YXR1cy5tcHAgd3JpdGVzIGZvciB1bnN1cHBvcnRlZCBtb2RlcyAqLw0KLSAgICBp
ZiAobXBwID09IFBSVl9IIHx8DQotICAgICAgICAoIXJpc2N2X2hhc19leHQoZW52LCBSVlMpICYm
IG1wcCA9PSBQUlZfUykgfHwNCi0gICAgICAgICghcmlzY3ZfaGFzX2V4dChlbnYsIFJWVSkgJiYg
bXBwID09IFBSVl9VKSkgew0KLSAgICAgICAgbWFzayAmPSB+TVNUQVRVU19NUFA7DQorI2lmIGRl
ZmluZWQoVEFSR0VUX1JJU0NWNjQpDQorICAgICAgICAgICAgLyoNCisgICAgICAgICAgICAgKiBS
VjMyOiBNUFYgYW5kIE1UTCBhcmUgbm90IGluIG1zdGF0dXMuIFRoZSBjdXJyZW50IHBsYW4gaXMg
dG8NCisgICAgICAgICAgICAgKiBhZGQgdGhlbSB0byBtc3RhdHVzaC4gRm9yIG5vdywgd2UganVz
dCBkb24ndCBzdXBwb3J0IGl0Lg0KKyAgICAgICAgICAgICAqLw0KKyAgICAgICAgICAgIG1hc2sg
fD0gTVNUQVRVU19NUFAgfCBNU1RBVFVTX01QVjsNCisjZW5kaWYNCiAgICAgfQ0KIA0KICAgICBt
c3RhdHVzID0gKG1zdGF0dXMgJiB+bWFzaykgfCAodmFsICYgbWFzayk7DQotLSANCjIuMjEuMA0K
DQo=

