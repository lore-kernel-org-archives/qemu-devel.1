Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E906C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98F321479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NrbmbXK5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fiq5BZti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98F321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35876 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfmx-0001Pp-WA
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:31:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfj4-0006XD-TE
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfj3-0003wL-Na
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfj2-0003t8-3d; Fri, 19 Apr 2019 22:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727253; x=1587263253;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=EyShUaY3YtexDjDwIp1N7ntB/ze11x64g0jH4G3HcN8=;
	b=NrbmbXK5BFQPyNuvaP3idmNPuZTUNI+5gNEX8LSao4oO65xBag6RvyMw
	muebDJGGaV4MooaQApTWRcJUjf4+OuHZA6mWmr/E5Ce4s2dER/Tp75pVU
	mRlyNyJyJYWHGzEboJtvMl7NwuB+JT3c5e+ZqJy39LZ6Qr/MBHfAIPej0
	MUXsSIC6hBCpKTqDip2DU/tvGGOvoxjlmer7125YhxTtLOMZoN7GUgnwc
	+U5VuKWhtN4fisG7wHp6v8tgBkF50y1D/6QY0kkxCI/VF/px/JCO5xfi2
	olEUtQ7MGv/GiKp7cIO+PBdQWAgGoDmlvRfYtZmIonwrXpgpKyCDmiriB w==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617969"
Received: from mail-bn3nam01lp2057.outbound.protection.outlook.com (HELO
	NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.57])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:27:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=EyShUaY3YtexDjDwIp1N7ntB/ze11x64g0jH4G3HcN8=;
	b=fiq5BZtivOhKHtN+qpqO1TpokW9j14fG237bVp8YbCCd3+JIIYcJqnRi1156oT8Sh6jw/aWaZMfaTg19Og8BaepItKMzqePOc+g6LhiGd49C2j9lxrA9drIDTj3kvmvegljdF41G9BHNrsM4MfrGrkcRFk9iqGM4jd2X4UKNWv0=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5319.namprd04.prod.outlook.com (20.178.49.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Sat, 20 Apr 2019 02:27:27 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:27:27 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 6/8] target/riscv: Add Hypervisor CSR macros
Thread-Index: AQHU9yCYhwD0w/8RPkqGpcTxuH6BXw==
Date: Sat, 20 Apr 2019 02:27:26 +0000
Message-ID:
 <68ede3d1b281db3709a35c525e21ce1fed8c966a.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR05CA0027.namprd05.prod.outlook.com
	(2603:10b6:a03:c0::40) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7347cf56-0bd3-42e2-6161-08d6c537bac8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5319; 
x-ms-traffictypediagnostic: BYAPR04MB5319:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB53191CDC68C330F2B224465190200@BYAPR04MB5319.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(50226002)(52116002)(6486002)(14454004)(446003)(6436002)(76176011)(476003)(486006)(3846002)(6116002)(97736004)(2616005)(7736002)(81156014)(8676002)(478600001)(8936002)(72206003)(386003)(6506007)(81166006)(102836004)(26005)(186003)(36756003)(316002)(6512007)(44832011)(53936002)(68736007)(66066001)(118296001)(25786009)(4326008)(305945005)(99286004)(54906003)(2906002)(11346002)(110136005)(2501003)(256004)(64756008)(66446008)(66556008)(73956011)(66946007)(4744005)(66476007)(71200400001)(5660300002)(71190400001)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5319;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i0B7LyV5X2SyHMMfevsdP51OR9oAcnxy1tIjQ1RD+fWL4CHxYrlxv6c1NXwT7gOp6CKTtVHCFKgGsafRxhLCzo0e78GEng9/dxCPv58/3XrgAuBBUO7D0YJF0d5yEv0xlmKaVcxl4tRhAO9+fgAZHe0hSzHBuMr1Ga+lKibX/7BhPvXo+Eb30Cl7CdrmRDLHrNBcewtazaTx3vO9p4rNBdn3y18N+GpQ9nFZ0kMclfmzMx6Tji0sv36vVyRv2vsqytVop6pBS3Uymt6wO2bt5Sbd/QY2Sz/Sq1lf5HAshFi3Guo5utThZO89mqzHnySlL0+xLjOPrbCHa7fiDi4CFtSPmjNtg6/NYUTiA/iRk8ItNncaDS9KwTWwaDF92OI3JBnd80acMOFiD172LhhJt5r3IqjLV72eJxh1Wp0SruU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7347cf56-0bd3-42e2-6161-08d6c537bac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:27:26.9893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5319
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 6/8] target/riscv: Add Hypervisor CSR macros
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
Message-ID: <20190420022726.7oO-GVvS7RR5KN4LSG6u60In9Ea3iwx9sqBIxw7iM5g@z>

QWRkIHRoZSAxLjEwLjEgSHlwZXJ2aXNvciBDU1JzIGFuZCByZW1vdmUgdGhlIDEuOS4xIHNwZWMg
dmVyc2lvbnMuDQoNClNpZ25lZC1vZmYtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZy
YW5jaXNAd2RjLmNvbT4NCi0tLQ0KIHRhcmdldC9yaXNjdi9jcHVfYml0cy5oIHwgOSArKysrKyst
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggYi90YXJnZXQvcmlzY3YvY3B1X2Jp
dHMuaA0KaW5kZXggZmU3MTY0NzU0Yi4uNTJjMjE2OTk3NyAxMDA2NDQNCi0tLSBhL3RhcmdldC9y
aXNjdi9jcHVfYml0cy5oDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2JpdHMuaA0KQEAgLTIwMiw2
ICsyMDIsMTIgQEANCiAjZGVmaW5lIENTUl9EUEMgICAgICAgICAgICAgMHg3YjENCiAjZGVmaW5l
IENTUl9EU0NSQVRDSCAgICAgICAgMHg3YjINCiANCisvKiBIcGVydmlzb3IgQ1NScyAqLw0KKyNk
ZWZpbmUgQ1NSX0hTVEFUVVMgICAgICAgICAweGEwMA0KKyNkZWZpbmUgQ1NSX0hFREVMRUcgICAg
ICAgICAweGEwMg0KKyNkZWZpbmUgQ1NSX0hJREVMRUcgICAgICAgICAweGEwMw0KKyNkZWZpbmUg
Q1NSX0hHQVRQICAgICAgICAgICAweGE4MA0KKw0KIC8qIFBlcmZvcm1hbmNlIENvdW50ZXJzICov
DQogI2RlZmluZSBDU1JfTUhQTUNPVU5URVIzICAgIDB4YjAzDQogI2RlZmluZSBDU1JfTUhQTUNP
VU5URVI0ICAgIDB4YjA0DQpAQCAtMjkyLDkgKzI5OCw2IEBADQogI2RlZmluZSBDU1JfTUhQTUNP
VU5URVIzMUggIDB4YjlmDQogDQogLyogTGVnYWN5IEh5cGVydmlzb3IgVHJhcCBTZXR1cCAocHJp
diB2MS45LjEpICovDQotI2RlZmluZSBDU1JfSFNUQVRVUyAgICAgICAgIDB4MjAwDQotI2RlZmlu
ZSBDU1JfSEVERUxFRyAgICAgICAgIDB4MjAyDQotI2RlZmluZSBDU1JfSElERUxFRyAgICAgICAg
IDB4MjAzDQogI2RlZmluZSBDU1JfSElFICAgICAgICAgICAgIDB4MjA0DQogI2RlZmluZSBDU1Jf
SFRWRUMgICAgICAgICAgIDB4MjA1DQogDQotLSANCjIuMjEuMA0KDQo=

