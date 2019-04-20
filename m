Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF86C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BD221479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 02:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TEQj2zQt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="N6moZOYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BD221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHfq2-0003rv-B3
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 22:34:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfiq-0006Hz-OM
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfik-0003gs-BT
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 22:27:16 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0062c52f7=Alistair.Francis@wdc.com>)
	id 1hHfif-0003bL-OG; Fri, 19 Apr 2019 22:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1555727230; x=1587263230;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-transfer-encoding:mime-version;
	bh=d/IYhuTFMO3/mr+fsk8ZNdjcuTzrDixwIK7bYk93PJQ=;
	b=TEQj2zQtzlDdJCnWsLdE7AcN/Q5wiXmAmuttxI92AeW0V0eU4fmL8Qcn
	tDsVcqhfczNQuyLHCQah8VIW/vYWFw3yXQuBaPT3hAyYWG1/pUMPFVaGc
	mgI3kRdjw1UMmhmNG2iAsaJmTjv9bUZ3ggBEeQK7l0iKZzrwuoYFUQZs8
	I81m+kV2+03SEsuBGtj0EFzffaB9/JJJ6N0IHp7o6aSQ6s1iigQck6LCQ
	Clpec3PPRbWlmyUYvU42z4WdjR0TK4OYXnD2aj1uEhnoNRYcNY2SVSokp
	ilO67sLaIX5SBQqAH2c0lMWmp1wLc17SNcmxW748KxmcYsK8yuL16SrPK w==;
X-IronPort-AV: E=Sophos;i="5.60,372,1549900800"; d="scan'208";a="107617964"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO
	NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
	by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2019 10:27:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=d/IYhuTFMO3/mr+fsk8ZNdjcuTzrDixwIK7bYk93PJQ=;
	b=N6moZOYQGmeq8N3jWCQG3UAqmoRDNbmsggezclrjLYHVqhLGvU7qIItAuW9z6VdhVwC4ZUkE34ywkeZx91lzw25uXfdoLmymEYvQ5sg6Vgg58J5p9vStQQWhB7xB73jwhn1kiIKyqw6gWfXPhTA3XxA8j/d7yv/v6UcVlHkqQs8=
Received: from BYAPR04MB4901.namprd04.prod.outlook.com (52.135.232.206) by
	BYAPR04MB5319.namprd04.prod.outlook.com (20.178.49.208) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1813.14; Sat, 20 Apr 2019 02:27:02 +0000
Received: from BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c]) by BYAPR04MB4901.namprd04.prod.outlook.com
	([fe80::44e8:bd21:17b:348c%4]) with mapi id 15.20.1813.011;
	Sat, 20 Apr 2019 02:27:02 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
	<qemu-riscv@nongnu.org>
Thread-Topic: [PATCH v1 3/8] target/riscv: Improve the scause logic
Thread-Index: AQHU9yCJPKmYsNg3LEKmYdjgGIsHVg==
Date: Sat, 20 Apr 2019 02:27:02 +0000
Message-ID:
 <d32a88fc0506a7bc1cae31c2fdf1448d2469e9d3.1555727081.git.alistair.francis@wdc.com>
References: <cover.1555727081.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1555727081.git.alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: BYAPR05CA0020.namprd05.prod.outlook.com
	(2603:10b6:a03:c0::33) To BYAPR04MB4901.namprd04.prod.outlook.com
	(2603:10b6:a03:4f::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Alistair.Francis@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffd65299-c3d4-44b7-7718-08d6c537ac4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:BYAPR04MB5319; 
x-ms-traffictypediagnostic: BYAPR04MB5319:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB53192243B4204115F8C30C5390200@BYAPR04MB5319.namprd04.prod.outlook.com>
x-forefront-prvs: 0013079544
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(50226002)(52116002)(6486002)(14454004)(446003)(6436002)(76176011)(476003)(486006)(3846002)(6116002)(97736004)(2616005)(7736002)(81156014)(8676002)(478600001)(8936002)(72206003)(386003)(6506007)(81166006)(102836004)(26005)(186003)(36756003)(316002)(6512007)(44832011)(53936002)(68736007)(66066001)(118296001)(25786009)(4326008)(305945005)(99286004)(54906003)(2906002)(11346002)(110136005)(2501003)(256004)(64756008)(14444005)(66446008)(66556008)(73956011)(66946007)(4744005)(66476007)(71200400001)(5660300002)(71190400001)(86362001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5319;
	H:BYAPR04MB4901.namprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jNT34oIHpOA1jMBvR1WUdXJrJwaN4He6NpapGIvl8LnOfHtxTZU32ebq7V++r/1ykyWKW+tA2G6YEJytCNr9aBp0JyrhZQlBKEHam5Y4SeOIcXGfpTMTh07rM4JLQY6xwzkag6VNfgJp/vYSMAatBfYIAXYf+nxQNhtW3pCF8BgmZmnJ8EIxOrwkG+qndu5nXPHJ973vqm4AzvctiQghfqiKl/CDgohIQtMrcgB574KvOyq0TL0Yvf6xMVTDiA481GPvzELxlBrop5MprXa9Rzt0B0mw93Azx3hoAxfCt9Kh1G+d46GbESrUQ8rV3Ii1FL/rnI4o5k8GwiZBg65i2/2RU/ZyTG/eaG0n7jNV1byGWLBfs/bQ1dlNsOeJBvHqrjDvgvuER3ZZLUo9wjRfbtlEXw6/r6ITROyDnVDMVfE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd65299-c3d4-44b7-7718-08d6c537ac4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2019 02:27:02.6682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5319
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 3/8] target/riscv: Improve the scause logic
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
Message-ID: <20190420022702.U04GXTC0T8aByxW_ab9qtNzAgVTMNMwuDXdTSTuhNVU@z>

Tm8gZnVuY3Rpb25hbCBjaGFuZ2UsIGp1c3QgbWFraW5nIHRoZSBjb2RlIGVhc2llciB0byByZWFk
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdk
Yy5jb20+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jIHwgMiArLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCmluZGV4
IDU4MmQ1OGFhZDkuLmU3ZDlkZDk1Y2MgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2hl
bHBlci5jDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQpAQCAtNTI1LDcgKzUyNSw3
IEBAIHZvaWQgcmlzY3ZfY3B1X2RvX2ludGVycnVwdChDUFVTdGF0ZSAqY3MpDQogICAgICAgICBz
ID0gc2V0X2ZpZWxkKHMsIE1TVEFUVVNfU1BQLCBlbnYtPnByaXYpOw0KICAgICAgICAgcyA9IHNl
dF9maWVsZChzLCBNU1RBVFVTX1NJRSwgMCk7DQogICAgICAgICBlbnYtPm1zdGF0dXMgPSBzOw0K
LSAgICAgICAgZW52LT5zY2F1c2UgPSBjYXVzZSB8IH4oKCh0YXJnZXRfdWxvbmcpLTEpID4+IGFz
eW5jKTsNCisgICAgICAgIGVudi0+c2NhdXNlID0gY2F1c2UgfCAoKHRhcmdldF91bG9uZylhc3lu
YyA8PCAoVEFSR0VUX0xPTkdfQklUUyAtIDEpKTsNCiAgICAgICAgIGVudi0+c2VwYyA9IGVudi0+
cGM7DQogICAgICAgICBlbnYtPnNiYWRhZGRyID0gdHZhbDsNCiAgICAgICAgIGVudi0+cGMgPSAo
ZW52LT5zdHZlYyA+PiAyIDw8IDIpICsNCi0tIA0KMi4yMS4wDQoNCg==

