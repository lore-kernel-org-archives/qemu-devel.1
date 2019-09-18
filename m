Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E14FC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D7D218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="5sJbO1ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D7D218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjQl-0005BU-VP
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEe-0000UG-W3
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEd-0002d2-OZ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:44 -0400
Received: from mail-eopbgr700101.outbound.protection.outlook.com
 ([40.107.70.101]:49633 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEd-0002bn-Ib
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlzHei6JJAIz8XHbV/URPV3b3v1UWWn3j/uoq9IQWSZNUHGGXa47lyVmMoIY8boII6QQG01RO/3ns6CYOJVMyUa4fS7/NoEGAP4t98D3xC4eoDmbCFbfMUzf93sZexOhLNn1/h/wNBL4tTT9qH58eHSZJ+ymHf3lQwGDlHHqaBj1/dQQD9wRDePonEVO+Ld9t7Jc+Jl3qHxmr9wIO5fbZSNc2urgz4qpyqXMeXQQvuPWls6QRpxCPLz9UQrSs1NzKCtNxfHGEXzpxcsPqg6N9J9jIP+dwyruQBD9ZohvpXMT4TKMWkAjaSjE9ViD6bbyB6DOXcucrf3zMPANtOFuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpkEAhjUBJN5+ZVIUazlzofX3SXyUQXSnl7WITZRu5o=;
 b=D8BbI6u83e8qOQQwJaPs5dufvLRgbsVa17NHN3p0H+kJs3MhOgsEBN0AyJSKsdLvf1sF7iEEUrpZLFgFmfLm3eCDODbWtv1/QX5bug0lplNzriRmpiSHXVkIHqYri8QYwT7olGmjXGYtmouEAdQ/UHJR5mlb62O8m6YD5VColw6Edxli589gLeI8O6B3DdhRkab7NCkBWl+cCmeiEmVK+bCSXnjwNyBj9edQzKqLmy4rIJOg04SGlmYqUQ+sbMGTSI6wfM2xHidSKT3RAs9WYXWdANIXd1u7mrOYY3s331608OTiFdq2OdL7kPmt9S3i5OQiTycZ/w/iutmpQYmVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpkEAhjUBJN5+ZVIUazlzofX3SXyUQXSnl7WITZRu5o=;
 b=5sJbO1ijFi9qfGsMkIG7YdUbwnfHoVeLjopYMMgxPeoHb0qNSqJK8fHqrhwuukwo81xOARgw5zYw0Dz3pgxX2HX/cYS5OdJJyUudgsJZ06oePnQ13UCoPE/a1jl4fZQMy+C+nclqRSLUDGnpIFonYkMgFK8X/K/oMCFEGlpn32k=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:42 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:42 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 15/22] fuzz: Add target/fuzz makefile rules
Thread-Index: AQHVbneNYJpjK54Mx0qJT8VRNItNog==
Date: Wed, 18 Sep 2019 23:19:42 +0000
Message-ID: <20190918231846.22538-16-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6b284d7-6e57-4b1a-8542-08d73c8eaf75
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3016F1A48B64DA14D1ED7E61BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:397;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TWNa7U1KOptnJPi74njIVYP8eLNvo6knUBJIuT948IIbnpvfh2lLkN3WoWo7G2T/9EQbrZmqBFepxTIPCf378EPGUfHYXmbLBugU4C3UyptznwrAJmvcktjGSJmu5Hyyz3bphTiMi+lzbk6LUMN5KyDlKVG59CJ7Me8alH7QRj0GAhHRNsQerD33cC3UoyB6PmdBLSSydTOTDOc5tw0Y1fs2pcHwpNvN5oKL3zM0PQmv2SvSdPcg7vm4HHbIcv6lmXc6UslyO86mY29DQkzuL57bXSLz+WaDjCpjDc8gLTScNDfJxgY1aRKS/1vzR8qoKjEhBT6n29rlGCp/U75izdLUQehJN9Z38XdgX7p+I+aI6xehKUmBBUTVKX1YNAtENx4pammuOt1wD/MuUBy8MQfjkvht7FCXVCcIVI9kATQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b284d7-6e57-4b1a-8542-08d73c8eaf75
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:42.5470 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEfQ/hLjObUl/r6F64Ipb1TXfcHAoxoVRTU1ds0DmKr5pP2mb+B9RQJyMqhPZ+hG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.101
Subject: [Qemu-devel] [PATCH v3 15/22] fuzz: Add target/fuzz makefile rules
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 Makefile        | 12 +++++++++++-
 Makefile.objs   |  6 +++++-
 Makefile.target |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 3a43492340..5e5033a500 100644
--- a/Makefile
+++ b/Makefile
@@ -426,6 +426,7 @@ dummy :=3D $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
+                softmmu-obj-y \
                 common-obj-m \
                 ui-obj-y \
                 ui-obj-m \
@@ -463,7 +464,16 @@ $(SOFTMMU_ALL_RULES): $(crypto-obj-y)
 $(SOFTMMU_ALL_RULES): $(io-obj-y)
 $(SOFTMMU_ALL_RULES): config-all-devices.mak
 $(SOFTMMU_ALL_RULES): $(edk2-decompressed)
-$(SOFTMMU_ALL_RULES): $(softmmu-main-y)
+$(SOFTMMU_ALL_RULES): $(softmmu-obj-y)
+
+SOFTMMU_FUZZ_RULES=3D$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
+$(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(block-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(chardev-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(crypto-obj-y)
+$(SOFTMMU_FUZZ_RULES): $(io-obj-y)
+$(SOFTMMU_FUZZ_RULES): config-all-devices.mak
+$(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
=20
 SOFTMMU_FUZZ_RULES=3D$(filter %-softmmu/fuzz, $(TARGET_DIRS_RULES))
 $(SOFTMMU_FUZZ_RULES): $(authz-obj-y)
diff --git a/Makefile.objs b/Makefile.objs
index bb1cfa05ef..99ea6b66de 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -87,9 +87,13 @@ common-obj-$(CONFIG_FDT) +=3D device_tree.o
=20
 common-obj-y +=3D qapi/
=20
-softmmu-main-y =3D main.o
 endif
=20
+ifneq ($(CONFIG_FUZZ),y)
+softmmu-obj-y =3D main.o
+endif
+
+
 #######################################################################
 # Target-independent parts used in system and user emulation
 common-obj-y +=3D cpus-common.o
diff --git a/Makefile.target b/Makefile.target
index 6065989964..f3efe3debd 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -194,6 +194,7 @@ all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(chardev=
-obj-y)
 all-obj-$(CONFIG_USER_ONLY) +=3D $(crypto-user-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
+all-obj-$(CONFIG_SOFTMMU) +=3D $(softmmu-obj-y)
=20
 ifdef CONFIG_SOFTMMU
 $(QEMU_PROG_BUILD): config-devices.mak
--=20
2.23.0


