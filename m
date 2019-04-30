Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6B2C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B571420644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NdSaIIt8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Oy1xA8Uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B571420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZ62-0003hU-Sy
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:11:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ4C-0002WG-R7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ4B-00079e-Ta
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:28 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ49-00078h-Nr; Tue, 30 Apr 2019 16:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556654978; x=1588190978;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=UOZaOs/B8bleK1zjCn/Dhkn2yUro/O0bzQ/JhKde6Nc=;
	b=NdSaIIt8E0NAyomrw98DR96erhLSulyvGJfKgmJBmulyxvr1QNhlDB03
	wOCdz0a40PvMGrvfj21zyqUcU/k8fQqLH8iOGbTTfTvOYNWr9Gc8mXart
	LN0CgOmBvQI8cVIxXOawNn87GwsXjEe4dryikigDUYa6yYcz2bQmrinhI
	pWsNKoDI4JDoFkh3DDSzeg7iuuinGhqFu7xBJjidaj2TJIGxGp6uuaFxW
	gnjGFYHJiPTPjXezY7GLZ+aQlm59Ly9xh7PZYZdkK+wkgywlacIPOutuI
	cH1LKb30RHEL6mRB5zV1l06GkHi31DCi3+rfd40ff9zhEbNBD3NVgPSEw g==;
X-IronPort-AV: E=Sophos;i="5.60,414,1549900800"; d="scan'208";a="206404379"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO
	NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 04:09:36 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=UOZaOs/B8bleK1zjCn/Dhkn2yUro/O0bzQ/JhKde6Nc=;
	b=Oy1xA8Uzyhoyg1LZ64M5rEbPV6OycBnFEyvvri3EpXkrdacS6iFedaGCiIC31jmb2WbnRLrB5uAN8XibVfqGGfyl3dr6YwxhmYd2oj/zaqGxQa2aoECvKgVzOTgb1usoxdN8bsyQgVlgMGUOuqnfSMatdyVWUGKRN2GBIMwVGMY=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5672.namprd04.prod.outlook.com (20.179.57.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 20:09:22 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66%5]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 20:09:22 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build warnings
Thread-Index: AQHU/5CZaeZVOkuLrEKHRDQVZjm9tg==
Date: Tue, 30 Apr 2019 20:09:21 +0000
Message-ID:
 <66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
References: <cover.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556650594.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR11CA0042.namprd11.prod.outlook.com
	(2603:10b6:a03:80::19) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac681a59-713a-40d3-61c2-08d6cda7bc04
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5672; 
x-ms-traffictypediagnostic: BYAPR04MB5672:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5672D9BA5EFAF4F6DC14BD5B903A0@BYAPR04MB5672.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(99286004)(4326008)(50226002)(71190400001)(71200400001)(7736002)(305945005)(316002)(14444005)(256004)(44832011)(186003)(36756003)(8936002)(6436002)(54906003)(2501003)(11346002)(102836004)(2906002)(26005)(6486002)(446003)(486006)(476003)(2616005)(5660300002)(8676002)(25786009)(6116002)(81156014)(81166006)(72206003)(3846002)(86362001)(66066001)(478600001)(73956011)(6512007)(66556008)(118296001)(66446008)(14454004)(66476007)(66946007)(64756008)(68736007)(53936002)(76176011)(97736004)(52116002)(2351001)(386003)(6506007)(5640700003)(6916009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5672;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HBWWBcifMkYCSS7nLnyiCrPj+i1wQxI0D3ge5eR4ZguPdtHhH26FkeSpQn93n7/r5lA6q2+522z+vm494VbefE+CLOmu/2/ks+sek93tOuEwlfEFl+BUARWjupNnvWyBXlTp+b0EJOdevoOQpBUejvdSO4hYH+FdQeIuPb7uniHvrmz86WtfmIKfoR8ozwWIpqyo3kleLR2n6IxET957lC9jhCF2mZKAFpjWlFESz1h1dX3cyXYWMiZ1c0fjX6xpTEA73DNMcfJ1GRHYSEhvw79H+iI7uqEc2ow8ia0zXZn7GGVQfIKMDpHAKtCLchnAyqxqSOu9ZLEWJroq29dFv4LbkYgszsC+3jH84ToMcsq6WIXHRl1CXdlCnLBzXoAPGZkXmmyzn+eTPAUgMy5BbQgromRe1ziG94LlCOJ4zt0=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <D2A8B247E6C6464DAB913E199DE06298@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac681a59-713a-40d3-61c2-08d6cda7bc04
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:09:21.9982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5672
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	"alistair23@gmail.com" <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430200921.mmSZSitNJEh_n4-lQckdY8whC51kBKIhNuKplRW5w3o@z>

Rml4IHRoaXMgd2FybmluZyB3aGVuIGJ1aWxkaW5nIHdpdGggR0NDOSBvbiBGZWRvcmEgMzA6DQpJ
biBmdW5jdGlvbiDigJhzdHJuY3B54oCZLA0KICAgIGlubGluZWQgZnJvbSDigJhzeXNfdW5hbWXi
gJkgYXQgL2hvbWUvYWxpc3RhaXIvcWVtdS9saW51eC11c2VyL3VuYW1lLmM6OTQ6MzoNCi91c3Iv
aW5jbHVkZS9iaXRzL3N0cmluZ19mb3J0aWZpZWQuaDoxMDY6MTA6IGVycm9yOiDigJhfX2J1aWx0
aW5fc3RybmNweeKAmSBvdXRwdXQgbWF5IGJlIHRydW5jYXRlZCBjb3B5aW5nIDY0IGJ5dGVzIGZy
b20gYSBzdHJpbmcgb2YgbGVuZ3RoIDY0IFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25dDQog
IDEwNiB8ICAgcmV0dXJuIF9fYnVpbHRpbl9fX3N0cm5jcHlfY2hrIChfX2Rlc3QsIF9fc3JjLCBf
X2xlbiwgX19ib3MgKF9fZGVzdCkpOw0KICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KDQpTaWduZWQt
b2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQotLS0N
CiBsaW51eC11c2VyL3VuYW1lLmMgfCA4ICsrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci91bmFtZS5jIGIvbGludXgtdXNl
ci91bmFtZS5jDQppbmRleCAzMTNiNzlkYmFkLi4yOTNiMjIzOGYyIDEwMDY0NA0KLS0tIGEvbGlu
dXgtdXNlci91bmFtZS5jDQorKysgYi9saW51eC11c2VyL3VuYW1lLmMNCkBAIC05MCw2ICs5MCwx
MSBAQCBpbnQgc3lzX3VuYW1lKHN0cnVjdCBuZXdfdXRzbmFtZSAqYnVmKQ0KICAgICogc3RydWN0
IGxpbnV4IGtlcm5lbCB1c2VzKS4NCiAgICAqLw0KIA0KKyNpZiBkZWZpbmVkKENPTkZJR19QUkFH
TUFfRElBR05PU1RJQ19BVkFJTEFCTEUpICYmIFFFTVVfR05VQ19QUkVSRVEoOSwgMCkNCisjcHJh
Z21hIEdDQyBkaWFnbm9zdGljIHB1c2gNCisjcHJhZ21hIEdDQyBkaWFnbm9zdGljIGlnbm9yZWQg
Ii1Xc3RyaW5nb3AtdHJ1bmNhdGlvbiINCisjZW5kaWYNCisNCiAgIG1lbXNldChidWYsIDAsIHNp
emVvZigqYnVmKSk7DQogICBDT1BZX1VUU05BTUVfRklFTEQoYnVmLT5zeXNuYW1lLCB1dHNfYnVm
LnN5c25hbWUpOw0KICAgQ09QWV9VVFNOQU1FX0ZJRUxEKGJ1Zi0+bm9kZW5hbWUsIHV0c19idWYu
bm9kZW5hbWUpOw0KQEAgLTEwMSw2ICsxMDYsOSBAQCBpbnQgc3lzX3VuYW1lKHN0cnVjdCBuZXdf
dXRzbmFtZSAqYnVmKQ0KICNlbmRpZg0KICAgcmV0dXJuICgwKTsNCiANCisjaWYgZGVmaW5lZChD
T05GSUdfUFJBR01BX0RJQUdOT1NUSUNfQVZBSUxBQkxFKSAmJiBRRU1VX0dOVUNfUFJFUkVRKDks
IDApDQorI3ByYWdtYSBHQ0MgZGlhZ25vc3RpYyBwb3ANCisjZW5kaWYNCiAjdW5kZWYgQ09QWV9V
VFNOQU1FX0ZJRUxEDQogfQ0KIA0KLS0gDQoyLjIxLjANCg0K

