Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82798C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3758D20644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pqT49xYC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nulhDyOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3758D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZ6G-0003xF-DL
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:11:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ4N-0002fM-Jt
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ4L-0007DA-QG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:09:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:40813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLZ4H-0007BY-0U; Tue, 30 Apr 2019 16:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556654989; x=1588190989;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=ZFAYi9wA7dxHwRHgzYhuh7lW918wFpfzj6T56gVNAOk=;
	b=pqT49xYCWuxY8BEi8x8GWcKLoiThU46iQIsDX4lmvGNTF0MyYDMBH7cq
	Vdv9B9jR+EqsGaq23fX0Z0uPwmriOeo7Ux3NEJWUPPK9RelgLsi3sh5es
	UFrLaBDpcjwGTRea/YvtDlHmkyfd45ZcVUg24DEyUvjMTzczvS0iDv1YC
	4iuKUpUsWfL/UyDqfEY/UPnExLkRdRyc8Yk3UlF4s+5cu/bJ/QTpHvdwm
	B9c2Xly53/kBThpBEKrSKWftLbqyPRf/2YkBpHYJ0wBdzBxscUdvVBFHj
	zVznPyhgtgesJfdS2/rQhW9xUwYxocQ3WGm7W21xbZYSFzYTvkEKUag1u Q==;
X-IronPort-AV: E=Sophos;i="5.60,414,1549900800"; d="scan'208";a="206404401"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO
	NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 04:09:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ZFAYi9wA7dxHwRHgzYhuh7lW918wFpfzj6T56gVNAOk=;
	b=nulhDyOQh+01s4tg+J+wpbVCutatKOLOQMu+B0aaTbe/cebCJ8bz7KlCY2dXdyNglunozNP1GJehTw2sm1nfurz6xeU+v5/i1X90JimaJ62g60nVbmpxvUQSwVjl9d1QOGNFbfO4rv6sskWvxb6kTjCONBxhiU39HgrKaSVrIak=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5672.namprd04.prod.outlook.com (20.179.57.22) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 20:09:30 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66]) by
	BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::4d89:bbf8:952c:3d66%5]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 20:09:30 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build warnings
Thread-Index: AQHU/5CeAn8+swhxLEm3vV4pJevVaQ==
Date: Tue, 30 Apr 2019 20:09:29 +0000
Message-ID:
 <6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
References: <cover.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556650594.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR11CA0054.namprd11.prod.outlook.com
	(2603:10b6:a03:80::31) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f3c5bc3-6642-47b8-6d84-08d6cda7c0c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5672; 
x-ms-traffictypediagnostic: BYAPR04MB5672:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB56721EC99C8A12278759186F903A0@BYAPR04MB5672.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(99286004)(4326008)(50226002)(71190400001)(71200400001)(7736002)(305945005)(316002)(14444005)(256004)(44832011)(186003)(36756003)(8936002)(6436002)(54906003)(2501003)(11346002)(102836004)(2906002)(26005)(6486002)(446003)(486006)(476003)(2616005)(5660300002)(8676002)(25786009)(6116002)(81156014)(81166006)(72206003)(3846002)(86362001)(66066001)(478600001)(73956011)(6512007)(66556008)(118296001)(66446008)(14454004)(66476007)(66946007)(64756008)(68736007)(53936002)(76176011)(97736004)(52116002)(2351001)(386003)(6506007)(5640700003)(6916009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5672;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4EGSBdhNdC8V3EgM1aw954vW7034A09KhWsGsWVG48VO3IHEbINCXrOXF+kUNxDJDq3MNBTaq6C2LJ/11Ce73vhg8ycDCLB/8KeNFr9V12BJFWQeYNDprGm61MOZKExmR0DF7hmvMC4J9owsrbbOzJ8ffDj9VOdDiCoK0kJrGshV+oqZC0y0cKkI7eG2yyOOV9YvUGASDtmpUAGi3jfCMnczJZm3huayCAanHXCsHLd9GRvULcLrRUePhjQ+W5j94iyG/5KJuddem0fp2GQVLoRyoXH+8Ao7ged6xY10aKQJPSfEYplDQz0muJWP+ph0xOn1nj50sl+U2Jdj/Ghre/KrXZN0fkVo14y4/xPYe17WcIgYgwRwVsO3DiWmzHfo9pYr6r1QuzRyrTYYhsLOrLuCBm00RY4vHxTQteJdCrI=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <6A83FF89C78ED949B2F2FF24B129CC78@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3c5bc3-6642-47b8-6d84-08d6cda7c0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:09:29.9587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5672
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
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
Message-ID: <20190430200929.sxD7UUdwTdrz_U1o-ssN-KHJE64q6rzwL2nq-GcxzdA@z>

Rml4IHRoaXMgd2FybmluZyB3aGVuIGJ1aWxkaW5nIHdpdGggR0NDOSBvbiBGZWRvcmEgMzA6DQpJ
biBmdW5jdGlvbiDigJhzdHJuY3B54oCZLA0KICAgIGlubGluZWQgZnJvbSDigJhmaWxsX3BzaW5m
b+KAmSBhdCAvaG9tZS9hbGlzdGFpci9xZW11L2xpbnV4LXVzZXIvZWxmbG9hZC5jOjMyMDg6MTIs
DQogICAgaW5saW5lZCBmcm9tIOKAmGZpbGxfbm90ZV9pbmZv4oCZIGF0IC9ob21lL2FsaXN0YWly
L3FlbXUvbGludXgtdXNlci9lbGZsb2FkLmM6MzM5MDo1LA0KICAgIGlubGluZWQgZnJvbSDigJhl
bGZfY29yZV9kdW1w4oCZIGF0IC9ob21lL2FsaXN0YWlyL3FlbXUvbGludXgtdXNlci9lbGZsb2Fk
LmM6MzUzOTo5Og0KL3Vzci9pbmNsdWRlL2JpdHMvc3RyaW5nX2ZvcnRpZmllZC5oOjEwNjoxMDog
ZXJyb3I6IOKAmF9fYnVpbHRpbl9zdHJuY3B54oCZIHNwZWNpZmllZCBib3VuZCAxNiBlcXVhbHMg
ZGVzdGluYXRpb24gc2l6ZSBbLVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQ0KICAxMDYgfCAg
IHJldHVybiBfX2J1aWx0aW5fX19zdHJuY3B5X2NoayAoX19kZXN0LCBfX3NyYywgX19sZW4sIF9f
Ym9zIChfX2Rlc3QpKTsNCiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KLS0tDQogbGludXgt
dXNlci9lbGZsb2FkLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9lbGZsb2FkLmMgYi9s
aW51eC11c2VyL2VsZmxvYWQuYw0KaW5kZXggYzFhMjYwMjFmOC4uY2JiN2ZjMTBmYSAxMDA2NDQN
Ci0tLSBhL2xpbnV4LXVzZXIvZWxmbG9hZC5jDQorKysgYi9saW51eC11c2VyL2VsZmxvYWQuYw0K
QEAgLTMyMDYsNyArMzIwNiw3IEBAIHN0YXRpYyBpbnQgZmlsbF9wc2luZm8oc3RydWN0IHRhcmdl
dF9lbGZfcHJwc2luZm8gKnBzaW5mbywgY29uc3QgVGFza1N0YXRlICp0cykNCiAgICAgICogdGhp
cyBmaWVsZCBpcyBub3QgTlVMLXRlcm1pbmF0ZWQuDQogICAgICAqLw0KICAgICAodm9pZCkgc3Ry
bmNweShwc2luZm8tPnByX2ZuYW1lLCBiYXNlX2ZpbGVuYW1lLA0KLSAgICAgICAgICAgICAgICAg
ICBzaXplb2YocHNpbmZvLT5wcl9mbmFtZSkpOw0KKyAgICAgICAgICAgICAgICAgICBzaXplb2Yo
cHNpbmZvLT5wcl9mbmFtZSkgLSAxKTsNCiANCiAgICAgZ19mcmVlKGJhc2VfZmlsZW5hbWUpOw0K
ICAgICBic3dhcF9wc2luZm8ocHNpbmZvKTsNCkBAIC0zMzg5LDcgKzMzODksNyBAQCBzdGF0aWMg
aW50IGZpbGxfbm90ZV9pbmZvKHN0cnVjdCBlbGZfbm90ZV9pbmZvICppbmZvLA0KICAgICAgICAg
ICAgICAgc2l6ZW9mICgqaW5mby0+cHJzdGF0dXMpLCBpbmZvLT5wcnN0YXR1cyk7DQogICAgIGZp
bGxfcHNpbmZvKGluZm8tPnBzaW5mbywgdHMpOw0KICAgICBmaWxsX25vdGUoJmluZm8tPm5vdGVz
WzFdLCAiQ09SRSIsIE5UX1BSUFNJTkZPLA0KLSAgICAgICAgICAgICAgc2l6ZW9mICgqaW5mby0+
cHNpbmZvKSwgaW5mby0+cHNpbmZvKTsNCisgICAgICAgICAgICAgIHNpemVvZigqaW5mby0+cHNp
bmZvKSAtIDEsIGluZm8tPnBzaW5mbyk7DQogICAgIGZpbGxfYXV4dl9ub3RlKCZpbmZvLT5ub3Rl
c1syXSwgdHMpOw0KICAgICBpbmZvLT5udW1ub3RlID0gMzsNCiANCi0tIA0KMi4yMS4wDQoNCg==

