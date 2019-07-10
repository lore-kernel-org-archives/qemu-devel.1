Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9500FC74A3E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B8B20693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R5gKf0IJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B8B20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJAo-0005mG-NR
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57172)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7P-0001aK-9j
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlJ7N-0002SV-8F
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:11 -0400
Received: from mail-eopbgr790080.outbound.protection.outlook.com
 ([40.107.79.80]:1472 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlJ7M-0002MZ-Vs
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8uge0AoXxCn7HhHZpXoVTV/1NtO/YqS3QW46+orWF4=;
 b=R5gKf0IJPfTrW2Ok+M3rHK8m9OmhjrrydKioCLysM7YA4pT/DVNZpXCCr5vpsm9L3ZHOh2w298CC7uAL6kO8sWL/AofMBqtdjEw3hPKcFuYPRvC2GqmbX/M6z1KQvjfzlPrPO3ZnX7aH6i4bqglzF/afMtxfuJ9316oboZaO37Y=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3820.namprd12.prod.outlook.com (10.255.173.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Wed, 10 Jul 2019 20:23:07 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 20:23:07 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v2 07/13] target/i386: sev: do not create launch context
 for an incoming guest
Thread-Index: AQHVN11HJRKfeyUcOEyRbk+hnT3d+g==
Date: Wed, 10 Jul 2019 20:23:04 +0000
Message-ID: <20190710202219.25939-8-brijesh.singh@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
In-Reply-To: <20190710202219.25939-1-brijesh.singh@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM3PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:0:54::30) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bde2da0-5ff3-4a87-9264-08d7057469be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3820; 
x-ms-traffictypediagnostic: DM6PR12MB3820:
x-microsoft-antispam-prvs: <DM6PR12MB3820FFA75627561B836169DAE5F00@DM6PR12MB3820.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(256004)(8936002)(2616005)(1076003)(316002)(476003)(81166006)(478600001)(54906003)(81156014)(2351001)(8676002)(486006)(25786009)(6436002)(6486002)(6666004)(4326008)(66476007)(66946007)(4744005)(446003)(53936002)(50226002)(71190400001)(66446008)(68736007)(6506007)(14454004)(386003)(5660300002)(36756003)(66066001)(186003)(6512007)(99286004)(305945005)(102836004)(26005)(2501003)(11346002)(64756008)(52116002)(5640700003)(66556008)(76176011)(86362001)(6116002)(6916009)(3846002)(7736002)(71200400001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3820;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: euPratxahNQuJSGJeZxWPFXSB06x3oDRfZig8bskwQS4B+3tUCY6e7nsMKTkdvpC8r9WGfOr0Amo0+1WaH7Wh5sigNIlpzHJLiSoD9gCXAeLbIpRiX8TIYOu7OXvYUeLPK0KWaSrKnZieURX8R0iMrlfNFjb6eV3ylowH+fjDJQXubtoROnfBvjdy9B6brmu0Gie0ivC4E5U2bnpXHl2ieRiA+HblNpiLfp8PIfwwYm/o5bbdzR2364V5ZZUtddOHVamrf7nlk2WsuUybx3kcGDJdsSxQS+xQP033Qc3/8dTShcJQG8d7k2W72NoY4qrhNpZUS6ewwDnZx/1+7g8m44UsbGh5JLY9L0Mu3cUZ1x3VScFKUl2hUYiD4X65hv/6qw5BiLElWy6IsGGrAhqedG3MRBllAVUXd0Rur3YAE8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bde2da0-5ff3-4a87-9264-08d7057469be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 20:23:04.9054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3820
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.80
Subject: [Qemu-devel] [PATCH v2 07/13] target/i386: sev: do not create
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The LAUNCH_START is used for creating an encryption context to encrypt
newly created guest, for an incoming guest the RECEIVE_START should be
used.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 target/i386/sev.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 6dbdc3cdf1..49baf8fef0 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -789,10 +789,16 @@ sev_guest_init(const char *id)
         goto err;
     }
=20
-    ret =3D sev_launch_start(s);
-    if (ret) {
-        error_report("%s: failed to create encryption context", __func__);
-        goto err;
+    /*
+     * The LAUNCH context is used for new guest, if its an incoming guest
+     * then RECEIVE context will be created after the connection is establ=
ished.
+     */
+    if (!runstate_check(RUN_STATE_INMIGRATE)) {
+        ret =3D sev_launch_start(s);
+        if (ret) {
+            error_report("%s: failed to create encryption context", __func=
__);
+            goto err;
+        }
     }
=20
     ram_block_notifier_add(&sev_ram_notifier);
--=20
2.17.1


