Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FFCC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835F024670
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="WJw9IZmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835F024670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79IM-0006OW-PR
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j79Ep-00044K-6k
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j79Eo-0003k6-6V
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:49:23 -0500
Received: from mail-co1nam11on2115.outbound.protection.outlook.com
 ([40.107.220.115]:56929 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j79En-0003aU-VI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:49:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvnyzwhOEUO7N0s7pYl/w9neKhbDjk5WGmpVxY4K6L44HWAA7Vf0vrKFcsSxOK0b+juiJNHbF1NXA0bHaCKyCGYSckbVpsyRS7MW1ZQ7tw12SHlzjUBabuCV3Ci0o7dK1fn1PtuMpvGqekQCcxgiM+nkSYsF/UgyphrHCmaIM3S2bgDB2vY3uxhvqna+rqysx65Qys5+Yhy+dPSfqNNP/UxztZxDbvRS38jp/XQ8sLqX+REE9KSV/nLi6wM+R0F2IW/NBtaSTwWyu3d9s70n8Ru1TCl55gYrsfMOTvcZ0xf7tLSaKLqP0mrVYV/ysG7c0MT7Gpp/HgKj4xC47nuMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOo4eWzIHR3GcM+6rLde/wJqNJRcf387MJzAqEDmTs4=;
 b=Rhbks9cqHHX4DWDERRG77S3fKw6HoM6+54b0lTelSvZacDUI3D/TPDmGH2g1voQFpTA8tKv/ADoVb4pK6s/oVEpc1nUCr2yZ/Uney07fD43u7JMDARQpr8b/H3rC8fY/pFXr06NfeLjBbXk/BB1t0IdmCBkDqTmkBnuIlP+ufz16P7Z4tzPsvW1Nq6iISZjTQJFdf65jhBotrKvxXiGm+8dUfTHbJkm3eKgX7w118e7TuF1fmtXBM3X0AYH7DWcj5Ai9rjlB6YUIS0StE0bQjRUXkyJik0P4btq3YiSDou/xBT4n0FBH9Yz8MVJrV7V4CWnQ3nH9PvCQonEu3JA7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOo4eWzIHR3GcM+6rLde/wJqNJRcf387MJzAqEDmTs4=;
 b=WJw9IZmJSEaPEeVQa8bNVJG1ZKRZX88QQqAcE/h6q8+KTQVXbXV/F8/LumGGaysFzS+ic/szD15QctL7e3oRTIKIhzge/FnjatmweZt3p9W8+QEXtMkuKUqGQPJfqk0R8u2kj+qdEEw/q8xtLbgNNeLUBP4wUJ/xc+Gx9AsJ54E=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3503.namprd03.prod.outlook.com (2603:10b6:805:41::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 02:49:16 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::b8d5:18df:ab51:2d7b%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 02:49:15 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] fuzz: fix typos in linker-script comments
Date: Wed, 26 Feb 2020 21:48:54 -0500
Message-ID: <20200227024856.23777-2-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227024856.23777-1-alxndr@bu.edu>
References: <20200227024856.23777-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0111.namprd02.prod.outlook.com
 (2603:10b6:208:35::16) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0111.namprd02.prod.outlook.com (2603:10b6:208:35::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 02:49:14 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4da0782-f78f-4447-e28e-08d7bb2fa213
X-MS-TrafficTypeDiagnostic: SN6PR03MB3503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3503C134381AE313C76CC806BAEB0@SN6PR03MB3503.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(346002)(396003)(39850400004)(366004)(136003)(189003)(199004)(36756003)(26005)(8676002)(6486002)(16526019)(186003)(4744005)(4326008)(478600001)(52116002)(6916009)(786003)(316002)(81156014)(81166006)(1076003)(86362001)(2906002)(54906003)(7696005)(6666004)(5660300002)(2616005)(66946007)(956004)(66556008)(66476007)(8936002)(75432002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3503;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fulhl8VWrYtrksozSm8O2+TgO2i1glzk5zwY2i5sfsYd6HrdI8VWP8GZnZUJWPZdKMKeVvxRd+qvKI2k5BV9HBhl5ByYgiO1kAJTaZnKADujJBjuuvMPdaazjSPII2KVHuvh1TW2W4QomoEpI2+nK+Z7jgEtI6Ko91r2xaNxy1NUHTznvmRkfIKjxVfNbgnoxpGGjQXrtbXlfGCv7VPZqLJvs8L3o2ZdI4IE2XOhiQe31w7XxfoSDH+p/6zrE6kEfSI2npcNNF7t9SoAA8675ZvOTH5Df1HcFFu8BY4vrtgldgaE0ajis3z1B3UNCQ+o0/uhyYzVQBip+hzipUwDWHJiCwR72dIdbBJ4oCe1JUAaJYNL5Ob9c8OAo+tyNLr384OlXxIarz4SESUE+gDiBauQEpNKGhtsVPFRYzRqMm3IpLeGiWgdDkcNBf4b37wV
X-MS-Exchange-AntiSpam-MessageData: SIyWHfWypGF/kFGnF80rmoajzOo2iecrkLmiNLi2uLN2K2FI9y4ocGk9A27nsTGQ2gz1D6GvhOtsKx6UZsxFIF/mRz0Gkl9/Yfp6N4uRu0W8sb8b/7DR2ENMZVbhDKQSixmsYSvKvyJF2R7F3qRAvg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e4da0782-f78f-4447-e28e-08d7bb2fa213
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 02:49:15.5662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Kj3yCkfwUzsubrwAcq0AYtRMZuUEbhtS/pDj4Mw7c22Vp7Eib+U39uGpcSjjREu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3503
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.115
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fork_fuzz.ld | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/fuzz/fork_fuzz.ld b/tests/qtest/fuzz/fork_fuzz.ld
index b23a59f194..b5aad06f20 100644
--- a/tests/qtest/fuzz/fork_fuzz.ld
+++ b/tests/qtest/fuzz/fork_fuzz.ld
@@ -1,5 +1,5 @@
 /* We adjust linker script modification to place all of the stuff that nee=
ds to
- * persist across fuzzing runs into a contiguous seciton of memory. Then, =
it is
+ * persist across fuzzing runs into a contiguous section of memory. Then, =
it is
  * easy to re-map the counter-related memory as shared.
 */
=20
@@ -32,6 +32,6 @@ SECTIONS
       __FUZZ_COUNTERS_END =3D .;
   }
 }
-/* Dont overwrite the SECTIONS in the default linker script. Instead inser=
t the
+/* Don't overwrite the SECTIONS in the default linker script. Instead inse=
rt the
  * above into the default script */
 INSERT AFTER .data;
--=20
2.25.0


