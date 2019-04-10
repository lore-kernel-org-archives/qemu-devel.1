Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62639C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2830220820
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 23:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U5UOfX4e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iCusMDvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2830220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39059 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEMYy-0002Gt-Ck
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 19:23:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMV9-0007i8-Ev
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMNu-0001kh-4X
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 19:12:03 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=996be2310=Alistair.Francis@wdc.com>)
	id 1hEMNr-000102-0f; Wed, 10 Apr 2019 19:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1554937919; x=1586473919;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=VhlFS4wWGVfvKnjFYtcxDbBd75J46iCic0zcDF/h6UM=;
	b=U5UOfX4e/GNc/j7MUT3OtAgPmtT808rQHhbPaqDLs0lxHJMDa9MKGdM7
	HR4wWi6ZNmMpTc+72Jo3D142DXW+dSXgIZ+JS9UyoBgskE6FHE4deOdKG
	oAmDYVelIgDLDb7sNaUkIMQfyjm1vzSCqJMoSmyCr5wWbmst6K4c9InMa
	ijbh2iVHmndZ3lIxsL53P+0hI36iI7sjHcnHMgZqmdeyBI9YR+IFBHT31
	QdBoOLXE5laZkuUvdtV9/IdVDFZ7u5GNS4U/bHKveL56SO4M8F3ISrPJi
	dR+PZGdT2p1trzXOdSga/s2ZN+LiW0DibQnQ7ouE+3NRZavCA0RfXnYM6 A==;
X-IronPort-AV: E=Sophos;i="5.60,335,1549900800"; d="scan'208";a="106823580"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO
	NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
	by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2019 07:10:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=VhlFS4wWGVfvKnjFYtcxDbBd75J46iCic0zcDF/h6UM=;
	b=iCusMDvE0PYdLh1ucYsAL6p42vk3nkvhsk5aBUhUGeeepC5mwcE2ZRJg9IsVnxNAc1X/wBVrnlS4YppyipNALWwwuZlP0RUuBOL1rty3P0aNS6pMvSyBwpYVGkkg78fR3hbNy00eTiVoUbOIi7MrlUdETg57d9eXoNNbVQHeFVU=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5334.namprd04.prod.outlook.com (20.178.50.11) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.21; Wed, 10 Apr 2019 23:10:16 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1771.021;
	Wed, 10 Apr 2019 23:10:16 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH for 4.1 v3 1/6] linux-user/riscv: Add the CPU type as a
	comment
Thread-Index: AQHU7/KP3Y4mDg+ShUiCDIO6MaZqaA==
Date: Wed, 10 Apr 2019 23:10:16 +0000
Message-ID:
 <bf389e5bbe7326a47182fd363fd87d03c7189d01.1554937288.git.alistair.francis@wdc.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1554937288.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR01CA0013.prod.exchangelabs.com (2603:10b6:a02:80::26)
	To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 198307a9-7c4f-4117-bcf4-08d6be09b163
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5334; 
x-ms-traffictypediagnostic: BYAPR04MB5334:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5334A38689F9F40FA2EAFBA1902E0@BYAPR04MB5334.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(99286004)(11346002)(8936002)(14454004)(2616005)(4744005)(6486002)(305945005)(6436002)(478600001)(97736004)(446003)(71190400001)(118296001)(2501003)(66066001)(476003)(4326008)(256004)(44832011)(71200400001)(486006)(86362001)(102836004)(186003)(36756003)(81156014)(72206003)(3846002)(8676002)(25786009)(386003)(6506007)(5660300002)(53936002)(7736002)(50226002)(106356001)(105586002)(2906002)(68736007)(6116002)(54906003)(26005)(316002)(6512007)(81166006)(110136005)(52116002)(76176011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5334;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YzDCSSM2FyYTyPeF7t4P1uh0VE73I87DnlKno4imYGtr2JcpRmI2CjS7FhfjtV/yhDDcwYVNPm2XzOXZHqp0YgUeNn/kWbdxupQcgvEQY51j7Qoy9J8SfwlsYBXkmaMqgh3DRljEVJ1fCUbU3R/5RpMim3uVyfjLfAtjdE5qFDap8+OyVuRKZUSC0mYa1PovnJZzCmmeUP5TC0LNjudZg0I3WMsXWIGYZXFCX5CpeGXdzNFs5tKMk/mHpA8yYngUIpAsP2f2DO4FmE5TN/FmAQWiXhbxFpceSmUs4oMN/P6RfD7rrF9C7SxeVrHoEdMbx9ZI66yh2g8ZFKvyNoroY0AnSwje0TsnVSpdPYjm2I5isClxpJRrA2GxxsfF5idetnRTyzG3pgsPPuZz7BfuP7FDuOSrxjAxSUOC5WOPRAI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198307a9-7c4f-4117-bcf4-08d6be09b163
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 23:10:16.3162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5334
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH for 4.1 v3 1/6] linux-user/riscv: Add the CPU
 type as a comment
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
Message-ID: <20190410231016.hzuFD7F20k1EznhCUHzNvrbnvWnDkGOvJ5cpWzZFd-I@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogbGludXgtdXNlci9yaXNjdi90YXJnZXRfZWxmLmggfCAxICsNCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvcmlzY3YvdGFy
Z2V0X2VsZi5oIGIvbGludXgtdXNlci9yaXNjdi90YXJnZXRfZWxmLmgNCmluZGV4IGE2NzE2YTZh
YWMuLjlkZDY1NjUyZWUgMTAwNjQ0DQotLS0gYS9saW51eC11c2VyL3Jpc2N2L3RhcmdldF9lbGYu
aA0KKysrIGIvbGludXgtdXNlci9yaXNjdi90YXJnZXRfZWxmLmgNCkBAIC05LDYgKzksNyBAQA0K
ICNkZWZpbmUgUklTQ1ZfVEFSR0VUX0VMRl9IDQogc3RhdGljIGlubGluZSBjb25zdCBjaGFyICpj
cHVfZ2V0X21vZGVsKHVpbnQzMl90IGVmbGFncykNCiB7DQorICAgIC8qIFRZUEVfUklTQ1ZfQ1BV
X0FOWSAqLw0KICAgICByZXR1cm4gImFueSI7DQogfQ0KICNlbmRpZg0KLS0gDQoyLjIxLjANCg0K

