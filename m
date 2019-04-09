Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F90C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB7A920874
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FLllNAWv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CQFK94Lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB7A920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50825 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE0be-0000J4-8e
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:56:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=99569c54a=Alistair.Francis@wdc.com>)
	id 1hE0aP-0007lW-8b
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=99569c54a=Alistair.Francis@wdc.com>)
	id 1hE0aO-0002AR-9Q
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:55:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=99569c54a=Alistair.Francis@wdc.com>)
	id 1hE0aN-0001vk-9w
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1554854128; x=1586390128;
	h=from:to:cc:subject:date:message-id:content-id:
	content-transfer-encoding:mime-version;
	bh=11ZBHMYSPfI1RHFWPMcoklnbVRf07pQjxTBUyaSyfxk=;
	b=FLllNAWvpQzchaER9e8AZY/vzwWWFgPAingaMIWIZGKS3jByw8MR3443
	q9eIsL7ySQT3na0hRfHztfBdVt8eTnGXW6PZvYyHeO3NimMd/Gr7Eyk5L
	5ia/uBMxs3V6GYAwJKbag8DwUa8sQoP/6rPRwwLEcSitfHn8WR+H/OfXy
	52ta9Gpr54wmH0jdxJjroHOWHsp/C2aNP7cMWIZq2AUZ5FiwbTToLhBIz
	qqUF+8nqWXer7DSauioEOBaXp52v7x19gvz4myWZBBxmFAdddDK6zdq0n
	90d7EoCBK+ox9izyO1PXVq09/Tn9LuEcKZn97Do2Uoa1Sd3iz6zcOyXWm g==;
X-IronPort-AV: E=Sophos;i="5.60,331,1549900800"; d="scan'208";a="110433609"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO
	NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
	by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2019 07:55:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=11ZBHMYSPfI1RHFWPMcoklnbVRf07pQjxTBUyaSyfxk=;
	b=CQFK94LcRlK7OpiqkXgJLwwX1mXx+PazTJT4PvT8XsZ9AA3I73PqmqExbUrK6VIXeQ0iNqPCiAnZeJFxt5Gyx39c5F1OXvhVexP1FcSheo+45tPO68yJox7C+bULjkmJF74irncM7Gyeb05axwdGO8bRDigBC/NPSbkhSv/UXlU=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB3943.namprd04.prod.outlook.com (52.135.215.18) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Tue, 9 Apr 2019 23:55:16 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1771.021;
	Tue, 9 Apr 2019 23:55:16 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"peter.maydell@linaro.org" <peter.maydell@linaro.org>
Thread-Topic: [PULL 0/1] device-tree queue
Thread-Index: AQHU7y+tOU+muZ/qr0eI0BV9aGsp9A==
Date: Tue, 9 Apr 2019 23:55:15 +0000
Message-ID: <20190409235401.12671-1-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR05CA0076.namprd05.prod.outlook.com
	(2603:10b6:a03:e0::17) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c74eb282-6920-439e-d219-08d6bd46cffd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB3943; 
x-ms-traffictypediagnostic: BYAPR04MB3943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB394379031DE6C0E367698253902D0@BYAPR04MB3943.namprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(2616005)(52116002)(99286004)(81166006)(71190400001)(476003)(5660300002)(3846002)(68736007)(6486002)(486006)(110136005)(105586002)(2906002)(6116002)(54906003)(6512007)(106356001)(6506007)(14454004)(478600001)(72206003)(44832011)(86362001)(66066001)(8676002)(26005)(71200400001)(97736004)(1076003)(4744005)(305945005)(102836004)(8936002)(50226002)(4326008)(6436002)(36756003)(316002)(2501003)(186003)(53936002)(25786009)(7736002)(81156014)(386003)(256004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3943;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NwNKPH8VkcVBqDlok8PeAKB4BqQD8x3aC8JyMxvOzLF/f4/ankMzzAKmMWsjeTEL4S5aw37O6T+refX24Z9hwdhVaEv3/k8GJ3gb7lspcjMcIptkZ02Jo24UHPSeO5GJw3Jl1cMO7ZlPVafPCrKdrgriwR0tlkVD2ENiNXgqQiisufO+7fUyWHnKKhr+DcpFZaGYjcICBw4ZK6fg2mSsAmfnFO3uRlrlAJQfeJ2lybc190ITGOwHh1NQF/HjN4YvXdrfLoH+oKq2hdxT0cc8fu4Asmec4JzRXb7kTRkM9Jsq4R5vnAXhlixBuaWE7WnTloTcVN7bUVd+9PN+Plpo6vMYwdgD0dInMrKJuSpoTU/+zv5eS+NiDFOkn2rGgoUR78pqnnsU1IxaZCOeNySZvPpkFciSMI/BwZXKEwREUZ8=
Content-Type: text/plain; charset="UTF-8"
Content-ID: <F9D2EA38144F7D4490D0BBB6A1380B84@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74eb282-6920-439e-d219-08d6bd46cffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 23:55:15.9916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PULL 0/1] device-tree queue
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
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409235515.Tx1-KSoGLo_LOdi3WqmJ_McXLUEEX9ECTWdA9NNyHuA@z>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBmMTUxZjhhY2E1Y2Y1ZGEyNGY2ZWI3
NDNhNTVhMjIzMzA5MWFlNTMyOg0KDQogIG1pZ3JhdGlvbi9yYW0uYzogRml4IHVzZS1hZnRlci1m
cmVlIGluIG11bHRpZmRfcmVjdl91bmZpbGxfcGFja2V0KCkgKDIwMTktMDQtMDkgMjA6NDY6MzQg
KzAxMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdp
dEBnaXRodWIuY29tOmFsaXN0YWlyMjMvcWVtdS5naXQgdGFncy9wdWxsLWRldmljZS10cmVlLTIw
MTkwNDA5LTENCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDA2NWU2Mjk4YTc1MTY0
YjQzNDc2ODJiNjMzODFkYmU3NTJjMmIxNTY6DQoNCiAgZGV2aWNlX3RyZWU6IEZpeCBpbnRlZ2Vy
IG92ZXJmbG93aW5nIGluIGxvYWRfZGV2aWNlX3RyZWUoKSAoMjAxOS0wNC0wOSAxNjozNTo0MCAt
MDcwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KU2luZ2xlIGRldmljZSB0cmVlIGZpeCBmb3IgNC4wDQoNCkEgc2lu
Z2xlIHBhdGNoIHRvIGF2b2lkIGFuIG92ZXJmbG93IHdoZW4gbG9hZGluZyBkZXZpY2UgdHJlZXMu
DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCk1hcmt1cyBBcm1icnVzdGVyICgxKToNCiAgICAgIGRldmljZV90cmVlOiBG
aXggaW50ZWdlciBvdmVyZmxvd2luZyBpbiBsb2FkX2RldmljZV90cmVlKCkNCg0KIGRldmljZV90
cmVlLmMgfCA0ICsrKysNCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo=

