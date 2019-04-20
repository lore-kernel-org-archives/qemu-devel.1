Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E39C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868E321479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="I4yXAht+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BQzTJ1hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868E321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHflH-0008AM-Od
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:29:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiU-0005wY-4Y
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiT-0003YT-1a
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:26:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiS-0003Wi-M0; Fri, 19 Apr 2019 22:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727217; x=1587263217;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=yvD+6WxzQdhty5tIxrzVSjqvUmtXB8CBeyBr3dRv+q8=;
	b=I4yXAht+dtvv6OiQ+viMUMqOEkhscdlb/f1LN9vXKYp0ujvU9KiLAgHJ
	ceNQv88Q0GgtPPcjTen01URVLCgPu3YMnMhmr9tNrtstoJKTo167Cr/+e
	NQMtdP4NxRsgNOXbE89+m5IsPJXco9VZZ4ZfsEB8EUeuVfnlcuaVFNIOh
	vlde0SNN519vLZ2wATPUxFNxnUOfC7RATEKE4Yxwoo4egqRx5SN8FmLOQ
	pvm0iH1Jhdsz3c5BKmi46CowLrto3nXO+UqQ+atXjTBcjhcGhGtMxT8mQ
	6fT8JZLKIH1Zh7IX9PYVk5KPNDDme2SArG2DOX4slvOI793FEEsbCbWZZ g==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617960"
Received: from mail-cys01nam02lp2058.outbound.protection.outlook.com (HELO
	NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.58])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:26:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=yvD+6WxzQdhty5tIxrzVSjqvUmtXB8CBeyBr3dRv+q8=;
	b=BQzTJ1hr2YTIX3+oT0ZoWZBq2hKnQeE/JxBBYMhixyfuoBOhYRy4usDPe7Zyn4ClVUFQ2ACGad4I5PiAU0tmwaso1vV5eIxpsjQ81xDGJ+YyJul6Zro8M60ObdgFGg53Ll9CjOfc0XmH6VQ7Jbc072zM2r10Q5i2vu75xKmi/L4=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5319.namprd04.prod.outlook.com (20.178.49.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Sat, 20 Apr 2019 02:26:52 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:26:52 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 1/8] target/riscv: Mark privilege level 2 as reserved
Thread-Index: AQHU9yCAAoiHNBQwukCITR9Gn2+zXA==
Date: Sat, 20 Apr 2019 02:26:45 +0000
Message-ID:
 <ab34b0e532abd2a106797afda50cb81e7ee4bcd9.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR02CA0010.namprd02.prod.outlook.com
	(2603:10b6:a02:ee::23) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5284f1e-8e7f-46e7-eb97-08d6c537a261
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5319; 
x-ms-traffictypediagnostic: BYAPR04MB5319:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5319C3C60DBE9A224EB5B53190200@BYAPR04MB5319.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(50226002)(52116002)(6486002)(14454004)(446003)(6436002)(76176011)(476003)(486006)(3846002)(6116002)(97736004)(2616005)(7736002)(81156014)(8676002)(478600001)(8936002)(72206003)(386003)(6506007)(81166006)(102836004)(26005)(186003)(36756003)(316002)(6512007)(44832011)(53936002)(68736007)(66066001)(118296001)(25786009)(4326008)(305945005)(99286004)(54906003)(2906002)(11346002)(110136005)(2501003)(256004)(64756008)(14444005)(66446008)(66556008)(6666004)(73956011)(66946007)(4744005)(66476007)(71200400001)(5660300002)(71190400001)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5319;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0HzMvpTdVp1wGY/s0cmskK4UV0TPahf9/7DMSMXNq3gxMI7OYIb5lDjuXXFUdjejPiWwuyCSVWmilugUdU3u//Y4uFOIY8BZOrQjMjAtDezxy6zcKLzMYsPIDioYzo3W54f7gntKqwEUIG/xvkyktty0ZkqGQJHaQ6oGIjITpMbGrR3V6KUvVRbMApL3xzGm0mfkkbhjP0ewATMDhO2576zgp0FD505x73kVKo1MNhSF8g/t4zlzQEj1EiPSu6K+EpREuiEGnxeP/jBnbobF0/+ZWOGCSkIeTpYP4q7vblpx2Tt5hFdcvTAn0NWga7MZnprhoSTnujQHqgu5SjVJQTu85hgBSNyV45Cbys//A7H0l0ohPvBHUsU+fpVVeGb+Cv2gQY87A1bnhnCjsCmCxGIeRsMlWmHGcwq5g3ghkmY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5284f1e-8e7f-46e7-eb97-08d6c537a261
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:26:46.0034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5319
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 1/8] target/riscv: Mark privilege level 2 as
 reserved
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
Message-ID: <20190420022645.MnrEgTOlAc_S-lKmZhkz66A98gcUd44RtMrDyGXDqIk@z>

U2lnbmVkLW9mZi1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29t
Pg0KLS0tDQogdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvcmlz
Y3YvY3B1X2JpdHMuaCBiL3RhcmdldC9yaXNjdi9jcHVfYml0cy5oDQppbmRleCA3MTgwZmNjZjU0
Li45NDVhYThkYmI4IDEwMDY0NA0KLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCisrKyBi
L3RhcmdldC9yaXNjdi9jcHVfYml0cy5oDQpAQCAtMzgzLDcgKzM4Myw3IEBADQogLyogUHJpdmls
ZWdlIG1vZGVzICovDQogI2RlZmluZSBQUlZfVSAwDQogI2RlZmluZSBQUlZfUyAxDQotI2RlZmlu
ZSBQUlZfSCAyDQorI2RlZmluZSBQUlZfSCAyIC8qIFJlc2VydmVkICovDQogI2RlZmluZSBQUlZf
TSAzDQogDQogLyogUlYzMiBzYXRwIENTUiBmaWVsZCBtYXNrcyAqLw0KLS0gDQoyLjIxLjANCg0K

