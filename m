Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5A0C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8207F206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tXdiyIaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8207F206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52122 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he1wV-0006WR-Fg
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 14:37:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43355)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1he1cZ-0005MN-1l
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1he1PB-0003vb-2i
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:03:47 -0400
Received: from mail-eopbgr720059.outbound.protection.outlook.com
 ([40.107.72.59]:35920 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1he1PA-0003qK-RN
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbpJByXe8UVRoPZUY5MWG+IL03tk3wsG/xLAPkJgKkQ=;
 b=tXdiyIaABtQdKw6uNgoBfm8GO3Tmx8kK3nd12frpqITnhZbg+yx3L23KNDP80fk1vXoQOZCuWGSx9s46pqhIITlIQz4rANHYdAnrLa0OWXMDtmG0zHZTNB1+VGwCJ+m+KxjzIG3Yhxoezr3O4Bkk+yUWTp2bdbf9APuOngS6ANc=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3260.namprd12.prod.outlook.com (20.179.105.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.15; Thu, 20 Jun 2019 18:03:21 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::b9c1:b235:fff3:dba2]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::b9c1:b235:fff3:dba2%6]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 18:03:21 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v1 07/12] target/i386: sev: do not create launch
 context for an incoming guest
Thread-Index: AQHVJ5Jwr64n84eiuEmsG1k/ZeRP+g==
Date: Thu, 20 Jun 2019 18:03:18 +0000
Message-ID: <20190620180247.8825-8-brijesh.singh@amd.com>
References: <20190620180247.8825-1-brijesh.singh@amd.com>
In-Reply-To: <20190620180247.8825-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:4:15::11) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b758ffe-87fb-4739-1534-08d6f5a992ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DM6PR12MB3260; 
x-ms-traffictypediagnostic: DM6PR12MB3260:
x-microsoft-antispam-prvs: <DM6PR12MB326052A544F44417623E3A22E5E40@DM6PR12MB3260.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(376002)(136003)(39860400002)(346002)(199004)(189003)(2351001)(53936002)(486006)(2616005)(11346002)(81156014)(8676002)(6436002)(446003)(5640700003)(50226002)(6512007)(476003)(102836004)(6916009)(99286004)(2501003)(6486002)(76176011)(8936002)(52116002)(81166006)(316002)(186003)(6506007)(26005)(478600001)(256004)(3846002)(2906002)(386003)(66066001)(14454004)(54906003)(6116002)(305945005)(25786009)(1076003)(66946007)(66556008)(73956011)(64756008)(66446008)(71190400001)(71200400001)(4744005)(68736007)(36756003)(6666004)(66476007)(5660300002)(7736002)(86362001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3260;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gZ9PfAcP/H0jaHvAhsoQbNi48oMIBwYi1Gl6igBrFoMBBo1sGFgrXjDuOTCNN46Jc+YYZvRm+r1+oGgZkae3RRfmXUYNhH4rRE43WtWfkbSR6m1bd0q1PABR9qqeYR5vQpHv2ekgt079bHEcuEeDd1v0uAo/N/tUFZI+YfHqQkQfpUZBJYcNNf9a+YPC8L45bnl6zax8QOSphVmsjd0eA5RRhc0i7ZNCVuxshLaJYNN962dfjyWBhT0nZJZnJCttZRWQj2O9PwxRbik84dRS/Qsx9qJc2Dhjc+QGZqKpkW5FYUoHK9VFof9DecZHbQUAmZ3Ld/q8e5hmIHb2sZcgYMkzxJCQk/Rg4cdXvKRqWF8hDvFC1zBVLt2qvsp7FE90VZAzcTcjYKcI4l8LDBamxQOj/8KqJkNfW7ZwTGqwlZk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b758ffe-87fb-4739-1534-08d6f5a992ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 18:03:18.5922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3260
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.59
Subject: [Qemu-devel] [RFC PATCH v1 07/12] target/i386: sev: do not create
 launch context for an incoming guest
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIExBVU5DSF9TVEFSVCBpcyB1c2VkIGZvciBjcmVhdGluZyBhbiBlbmNyeXB0aW9uIGNvbnRl
eHQgdG8gZW5jcnlwdA0KbmV3bHkgY3JlYXRlZCBndWVzdCwgZm9yIGFuIGluY29taW5nIGd1ZXN0
IHRoZSBSRUNFSVZFX1NUQVJUIHNob3VsZCBiZQ0KdXNlZC4NCg0KU2lnbmVkLW9mZi1ieTogQnJp
amVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KLS0tDQogdGFyZ2V0L2kzODYvc2V2
LmMgfCAxNCArKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvc2V2LmMgYi90YXJn
ZXQvaTM4Ni9zZXYuYw0KaW5kZXggZGQzODE0ZTI1Zi4uMWIwNWZjZjlhOSAxMDA2NDQNCi0tLSBh
L3RhcmdldC9pMzg2L3Nldi5jDQorKysgYi90YXJnZXQvaTM4Ni9zZXYuYw0KQEAgLTc4OSwxMCAr
Nzg5LDE2IEBAIHNldl9ndWVzdF9pbml0KGNvbnN0IGNoYXIgKmlkKQ0KICAgICAgICAgZ290byBl
cnI7DQogICAgIH0NCiANCi0gICAgcmV0ID0gc2V2X2xhdW5jaF9zdGFydChzKTsNCi0gICAgaWYg
KHJldCkgew0KLSAgICAgICAgZXJyb3JfcmVwb3J0KCIlczogZmFpbGVkIHRvIGNyZWF0ZSBlbmNy
eXB0aW9uIGNvbnRleHQiLCBfX2Z1bmNfXyk7DQotICAgICAgICBnb3RvIGVycjsNCisgICAgLyoN
CisgICAgICogVGhlIExBVU5DSCBjb250ZXh0IGlzIHVzZWQgZm9yIG5ldyBndWVzdCwgaWYgaXRz
IGFuIGluY29taW5nIGd1ZXN0DQorICAgICAqIHRoZW4gUkVDRUlWRSBjb250ZXh0IHdpbGwgYmUg
Y3JlYXRlZCBhZnRlciB0aGUgY29ubmVjdGlvbiBpcyBlc3RhYmxpc2hlZC4NCisgICAgICovDQor
ICAgIGlmICghcnVuc3RhdGVfY2hlY2soUlVOX1NUQVRFX0lOTUlHUkFURSkpIHsNCisgICAgICAg
IHJldCA9IHNldl9sYXVuY2hfc3RhcnQocyk7DQorICAgICAgICBpZiAocmV0KSB7DQorICAgICAg
ICAgICAgZXJyb3JfcmVwb3J0KCIlczogZmFpbGVkIHRvIGNyZWF0ZSBlbmNyeXB0aW9uIGNvbnRl
eHQiLCBfX2Z1bmNfXyk7DQorICAgICAgICAgICAgZ290byBlcnI7DQorICAgICAgICB9DQogICAg
IH0NCiANCiAgICAgcmFtX2Jsb2NrX25vdGlmaWVyX2FkZCgmc2V2X3JhbV9ub3RpZmllcik7DQot
LSANCjIuMTcuMQ0KDQo=

