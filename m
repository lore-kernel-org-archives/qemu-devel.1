Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578CAC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF5F20820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RkYA69IF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lILdiVdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF5F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39121 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEMbV-0004MX-Cn
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 19:26:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMVC-0007jM-C1
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMMh-00016X-Rg
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:10:54 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7061)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMMT-0000k9-EP; Wed, 10 Apr 2019 19:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1554937833; x=1586473833;
	h=from:to:cc:subject:date:message-id:
	content-transfer-encoding:mime-version;
	bh=Yvr0O4FtafJ8gAdn89JClrAHF4H+Sb53vWwATLBbbIg=;
	b=RkYA69IF6gRfTQCT5FWHABnYavZadEeQQY2/Wswh2vV1LCiUELYP3GA7
	yDavoILuV7sxXhK/xEFGKJFgSR6XWb5katsHhTjMkEOtfXogQS/F1zcF5
	H73G1/8NsG/OLsmmbA0MlPPUiI99U8AZjgMcG3sx0qnPH3eUXfk9JuDwV
	7PfAsOCkan27uWINzXnhuupELV/HCNX/3T79uisn6s/DiA7crqoM5kqMc
	ZEAcTAQ0dPAXAJdPMvfZznFNh35geqex3M1/qX2p0pOkUwyxysZ1EVqHR
	kTjYi/c2gJ0y2iDAghtKc/QVWym4OlTz5+dNlFKBwBJ5YRIMy0CH00IJ0 Q==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; d="scan'208";a="211278017"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO
	NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
	by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:10:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Yvr0O4FtafJ8gAdn89JClrAHF4H+Sb53vWwATLBbbIg=;
	b=lILdiVdvyIPIkCuS7f5sMcFGmv89wzhAq6cuJcQj5SOlnC326kwzWXCG2rd5o6bikIMQLs3Jw1Le2WLVxumHi12VRE7e/XSwI6zq/2Z+W6JorUNXBdVRsyl3d9/lOY1TI5Yy2zBeyj+a3riYxjx0WO0t/d2X4LKzc+955Du3XhI=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5334.namprd04.prod.outlook.com (20.178.50.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Wed, 10 Apr 2019 23:10:07 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1771.021;
	Wed, 10 Apr 2019 23:10:07 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH for 4.1 v3 0/6]  RISC-V: Allow specifying CPU ISA via
	command line
Thread-Index: AQHU7/KJ9bD8BBGVqE+5iaip6Q1AVg==
Date: Wed, 10 Apr 2019 23:10:07 +0000
Message-ID: <cover.1554937288.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR05CA0089.namprd05.prod.outlook.com
	(2603:10b6:a03:e0::30) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d80a4e6a-aba9-4fdb-05c5-08d6be09ac0d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5334; 
x-ms-traffictypediagnostic: BYAPR04MB5334:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB53343F3FA85847DF2F2EF0D9902E0@BYAPR04MB5334.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(99286004)(8936002)(14454004)(2616005)(6486002)(305945005)(6436002)(478600001)(97736004)(71190400001)(2501003)(66066001)(476003)(4326008)(256004)(44832011)(71200400001)(486006)(86362001)(102836004)(186003)(36756003)(81156014)(72206003)(3846002)(8676002)(25786009)(386003)(6506007)(5660300002)(53936002)(7736002)(50226002)(106356001)(105586002)(2906002)(68736007)(6116002)(54906003)(26005)(316002)(6512007)(81166006)(110136005)(52116002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5334;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UyT9ExQvQhWCPxT9oOK/swrVlKoZMjCoyZd5GQ7hcsfppFLF5N/0eO/UZz7feVHtXt433ERKomhkSdHbsVF8IPnGoK5hBNdm+1bcyU6D0SuXRYHZC0NRA/1i312xUIPjJfdt4BqoCgTvYnyxPEhLIh8xeGG/f070cOfyYXHnOvsZn8OGgg1tF2UVSodjXW3gv1pmbW/u8R2K/AXHD1jjhMkRJ0GVCQ9mCrHoDFx50MG0u6i4SQxez9IBOUp4sDBJeS3cAq8zgn5vLbYkCmw4hqMOthFFWGzD0q5SwilrQEnGB6os1BiTHhp5dym/hS+r3eqAgqHEtQ1j11f8l5odkvPn/8aDAO/FDIfa0Pz7CEboQB8S8PPVBGtLUz8tWwsh3z3lCV53FRHTBZl8CHtwfIjoI97k3Yhq+7zxWgYwBLI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80a4e6a-aba9-4fdb-05c5-08d6be09ac0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 23:10:07.3563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH for 4.1 v3 0/6] RISC-V: Allow specifying CPU
 ISA via command line
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
Message-ID: <20190410231007.9dDvi9nUQSJBLY2iBBrMwNDj4u0PiO8U563Ieb8n8x0@z>

VGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBhIGdlbmVyaWMgUklTQy1WIENQVSB0aGF0IGNhbiBiZSBn
ZW5lcmF0ZWQgYXQgcnVuDQp0aW1lIGJhc2VkIG9uIHRoZSBJU0Egc3RyaW5nIHNwZWNpZmllZCB0
byBRRU1VIHZpYSB0aGUgLWNwdSBhcmd1bWVudC4gVGhpcw0KaXMgc3VwcG9ydGVkIG9uIHRoZSB2
aXJ0IGFuZCBzcGlrZSBib2FyZHMgYWxsb3dpbmcgdXNlcnMgdG8gc3BlY2lmeSB0aGUNCg0KUklT
Qy1WIGV4dGVuc2lvbnMgYXMgd2VsbCBhcyB0aGUgSVNBIHZlcnNpb24uDQpBcyBwYXJ0IG9mIHRo
ZSBjb252ZXJzaW9uIHdlIGhhdmUgZGVwcmVjYXRlZCB0aGUgdmVyc2lvbiBzcGVjaWZpIFNwaWtl
DQptYWNoaW5lcy4NCg0KdjM6DQogLSBFbnN1cmUgYSBtaW5pbWFsIGxlbmd0aCBzbyB3ZSBkb24n
dCBydW4gb2ZmIHRoZSBlbmQgb2YgdGhlIHN0cmluZy4NCiAtIERvbid0IHBhcnNlIHRoZSBydjMy
L3J2NjQgaW4gdGhlIHJpc2N2X2dlbmVyYXRlX2NwdV9pbml0KCkgbG9vcA0KdjI6DQogLSBLZWVw
IHRoZSBhbnkgQ1BVIGZvciBsaW51eC11c2VyDQoNCkFsaXN0YWlyIEZyYW5jaXMgKDYpOg0KICBs
aW51eC11c2VyL3Jpc2N2OiBBZGQgdGhlIENQVSB0eXBlIGFzIGEgY29tbWVudA0KICB0YXJnZXQv
cmlzY3Y6IEZhbGwgYmFjayB0byBnZW5lcmF0aW5nIGEgUklTQy1WIENQVQ0KICB0YXJnZXQvcmlz
Y3Y6IENyZWF0ZSBzZXR0YWJsZSBDUFUgcHJvcGVydGllcw0KICByaXNjdjogdmlydDogQWxsb3cg
c3BlY2lmeWluZyBhIENQVSB2aWEgY29tbWFuZGxpbmUNCiAgdGFyZ2V0L3Jpc2N2OiBSZW1vdmUg
dGhlIGdlbmVyaWMgbm8gTU1VIENQVXMNCiAgcmlzY3Y6IEFkZCBhIGdlbmVyaWMgc3Bpa2UgbWFj
aGluZQ0KDQogaHcvcmlzY3Yvc3Bpa2UuYyAgICAgICAgICAgICAgfCAxMDYgKysrKysrKysrKysr
KysrKysrKysrKystDQogaHcvcmlzY3YvdmlydC5jICAgICAgICAgICAgICAgfCAgIDMgKy0NCiBs
aW51eC11c2VyL3Jpc2N2L3RhcmdldF9lbGYuaCB8ICAgMSArDQogdGFyZ2V0L3Jpc2N2L2NwdS5j
ICAgICAgICAgICAgfCAxNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KIHRh
cmdldC9yaXNjdi9jcHUuaCAgICAgICAgICAgIHwgIDEyICsrLQ0KIDUgZmlsZXMgY2hhbmdlZCwg
MjYyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yMS4wDQoNCg==

