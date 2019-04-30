Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C55BC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:31:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FD72087B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KrnD4gc3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FY1uu/Hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FD72087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLcDd-00051a-Tg
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:31:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAy-0002jy-54
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAo-0005x5-FJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:28:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:16200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=01690f4a8=Alistair.Francis@wdc.com>)
	id 1hLcAm-0005vC-KC; Tue, 30 Apr 2019 19:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1556666909; x=1588202909;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=93qqYGoM2ecY5vFl0HSJ9ujc3avEN9JpEd+kFvUyPv0=;
	b=KrnD4gc3Pggh8nwiqbd5+64/itujhTW1MUWdfdrXYrKwjaTN9Z5gQTSy
	Xml+oMvNDGLCjN3+df0Gv02CLQ9jL9LlEXrgpJVwYT60R1xg1gqGzPFmf
	lpPiMTZkB9pFfg1Zc7cSwtrBir6ex900fu6XMpNe3RcnYnQR+lL+4/swl
	7uDNYdP5ABZa/2Cg68oyRqcHZX+hGzDV11a/6OeDKexjSUrV0FdhSwqG/
	BxAfnN0Fb081f45neknc4u+OSWXb27LDcVCb8ijbtv00zHRt8gG92aTst
	JeuJyOQ22YA2sdDbaoFMne8B0oYzqlUj5nCU3L5LtNhpvppVNQMjs7HI1 A==;
X-IronPort-AV: E=Sophos;i="5.60,415,1549900800"; d="scan'208";a="107219009"
Received: from mail-bn3nam01lp2051.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.51])
	by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 07:28:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=93qqYGoM2ecY5vFl0HSJ9ujc3avEN9JpEd+kFvUyPv0=;
	b=FY1uu/Hmqbq16ipgOMxmXyHAOHhodPJbXDEuCXja3das8sCwDwtKIFvA14JAmo0NMSysXZYIAQe70Uzm3rH/O7+RnixDXn8RHVIsbBxCll/A0nwOjMMIZPBq7WPZgcoxAhlF94vDGJmgV7lpJ3j1aMDOBvYrXnd8julscmpQayk=
Received: from DM6PR04MB4908.namprd04.prod.outlook.com (20.176.109.81) by
	DM6PR04MB6217.namprd04.prod.outlook.com (20.178.224.88) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.10; Tue, 30 Apr 2019 23:28:22 +0000
Received: from DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2]) by DM6PR04MB4908.namprd04.prod.outlook.com
	([fe80::9ba:6028:ae27:7d2%2]) with mapi id 15.20.1835.015;
	Tue, 30 Apr 2019 23:28:22 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 1/5] util/qemu-sockets: Fix GCC 9 build warnings
Thread-Index: AQHU/6xmI5QzeU/lqky3NVrWQUvreA==
Date: Tue, 30 Apr 2019 23:28:22 +0000
Message-ID:
 <002f222d86322a66276de39cb29796acffe384c1.1556666645.git.alistair.francis@wdc.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1556666645.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR05CA0076.namprd05.prod.outlook.com
	(2603:10b6:a03:e0::17) To DM6PR04MB4908.namprd04.prod.outlook.com
	(2603:10b6:5:19::17)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 368f992b-0752-47f1-f154-08d6cdc38928
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR04MB6217; 
x-ms-traffictypediagnostic: DM6PR04MB6217:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM6PR04MB6217B3B7A69A1C14A91B4417903A0@DM6PR04MB6217.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(5640700003)(8936002)(6436002)(53936002)(73956011)(316002)(54906003)(14454004)(81156014)(6486002)(6916009)(81166006)(68736007)(8676002)(186003)(26005)(3846002)(66446008)(6116002)(66476007)(64756008)(7736002)(6512007)(66946007)(305945005)(102836004)(2906002)(66556008)(5660300002)(386003)(446003)(6506007)(66066001)(44832011)(2501003)(2351001)(11346002)(50226002)(478600001)(36756003)(486006)(476003)(2616005)(76176011)(4326008)(52116002)(14444005)(99286004)(71190400001)(71200400001)(256004)(118296001)(72206003)(86362001)(25786009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR04MB6217;
	H:DM6PR04MB4908.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IasIo6pJU0qD4goeCIbpGv9qkgjefuslzSMH9zpJbYQZz3Gyjqu8Qtlj7Rr/HPLFbVS2Jj69XSTHkIbCn83ZsIOMkeHEHLnzIST8nund1cGrSPkRc3DxpBcsirjQjOtmouPn066EBM/GjVGkh6P/wWzj58y/OL6FtG49wbE+fZqJDig+dEy2gAJaHTpzVscjFnpG62r2byS24L+MqOu6RAs6h9o1VvMgdeE63hNbKPPur28JmP8dnJqJTsm4WSWCtR6rWajDySGjTqoqXKUB3T6jlOhVLiDG6cAoVtTdmbyTHk8OkI50lXJOF0IvAPBtQPZB9/ptJ7rkdofHOyq7oYN8ux5q2elEhs0zJQw8DMUcpjVUBeBIOPs3+fVKQZl3MrSmopJ9iru+ptnOjEXxsC8o2DNxEQR2X8J0wzhYClc=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <7DACA981F99FAD42A18EF4D27F084E13@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368f992b-0752-47f1-f154-08d6cdc38928
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 23:28:22.4673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6217
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v2 1/5] util/qemu-sockets: Fix GCC 9 build
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
Message-ID: <20190430232822.UwfqilnwQ0xciozGob8KJkRdv8vfttK4EXMfqEPKhCs@z>

Rml4IHRoaXMgd2FybmluZyB3aGVuIGJ1aWxkaW5nIHdpdGggR0NDOSBvbiBGZWRvcmEgMzA6DQpJ
biBmdW5jdGlvbiDigJhzdHJuY3B54oCZLA0KICAgIGlubGluZWQgZnJvbSDigJh1bml4X2Nvbm5l
Y3Rfc2FkZHIuaXNyYS4w4oCZIGF0IHV0aWwvcWVtdS1zb2NrZXRzLmM6OTI1OjU6DQovdXNyL2lu
Y2x1ZGUvYml0cy9zdHJpbmdfZm9ydGlmaWVkLmg6MTA2OjEwOiBlcnJvcjog4oCYX19idWlsdGlu
X3N0cm5jcHnigJkgc3BlY2lmaWVkIGJvdW5kIDEwOCBlcXVhbHMgZGVzdGluYXRpb24gc2l6ZSBb
LVdlcnJvcj1zdHJpbmdvcC10cnVuY2F0aW9uXQ0KICAxMDYgfCAgIHJldHVybiBfX2J1aWx0aW5f
X19zdHJuY3B5X2NoayAoX19kZXN0LCBfX3NyYywgX19sZW4sIF9fYm9zIChfX2Rlc3QpKTsNCiAg
ICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4NCkluIGZ1bmN0aW9uIOKAmHN0cm5jcHnigJksDQogICAgaW5s
aW5lZCBmcm9tIOKAmHVuaXhfbGlzdGVuX3NhZGRyLmlzcmEuMOKAmSBhdCB1dGlsL3FlbXUtc29j
a2V0cy5jOjg4MDo1Og0KDQpTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFp
ci5mcmFuY2lzQHdkYy5jb20+DQotLS0NCiB1dGlsL3FlbXUtc29ja2V0cy5jIHwgNCArKy0tDQog
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL3V0aWwvcWVtdS1zb2NrZXRzLmMgYi91dGlsL3FlbXUtc29ja2V0cy5jDQppbmRleCA5
NzA1MDUxNjkwLi44YzMzMjI5NThmIDEwMDY0NA0KLS0tIGEvdXRpbC9xZW11LXNvY2tldHMuYw0K
KysrIGIvdXRpbC9xZW11LXNvY2tldHMuYw0KQEAgLTgyOSw3ICs4MjksNyBAQCBzdGF0aWMgaW50
IHVuaXhfbGlzdGVuX3NhZGRyKFVuaXhTb2NrZXRBZGRyZXNzICpzYWRkciwNCiAgICAgc3RydWN0
IHNvY2thZGRyX3VuIHVuOw0KICAgICBpbnQgc29jaywgZmQ7DQogICAgIGNoYXIgKnBhdGhidWYg
PSBOVUxMOw0KLSAgICBjb25zdCBjaGFyICpwYXRoOw0KKyAgICBjb25zdCBjaGFyICpwYXRoIFFF
TVVfTk9OU1RSSU5HOw0KIA0KICAgICBzb2NrID0gcWVtdV9zb2NrZXQoUEZfVU5JWCwgU09DS19T
VFJFQU0sIDApOw0KICAgICBpZiAoc29jayA8IDApIHsNCkBAIC05MjIsNyArOTIyLDcgQEAgc3Rh
dGljIGludCB1bml4X2Nvbm5lY3Rfc2FkZHIoVW5peFNvY2tldEFkZHJlc3MgKnNhZGRyLCBFcnJv
ciAqKmVycnApDQogDQogICAgIG1lbXNldCgmdW4sIDAsIHNpemVvZih1bikpOw0KICAgICB1bi5z
dW5fZmFtaWx5ID0gQUZfVU5JWDsNCi0gICAgc3RybmNweSh1bi5zdW5fcGF0aCwgc2FkZHItPnBh
dGgsIHNpemVvZih1bi5zdW5fcGF0aCkpOw0KKyAgICBtZW1jcHkodW4uc3VuX3BhdGgsIHNhZGRy
LT5wYXRoLCBNSU4oc3RybGVuKHNhZGRyLT5wYXRoKSwgc2l6ZW9mKHVuLnN1bl9wYXRoKSkpOw0K
IA0KICAgICAvKiBjb25uZWN0IHRvIHBlZXIgKi8NCiAgICAgZG8gew0KLS0gDQoyLjIxLjANCg0K

