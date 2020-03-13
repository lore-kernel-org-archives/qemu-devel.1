Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444F3C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11ADF20637
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 01:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dEYZB6vo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IesTthM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11ADF20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCYgW-0007zO-68
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 21:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCYcM-0000nS-Ba
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCYcL-0005PZ-9k
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:56:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=03412eee96=coreyw7@fb.com>)
 id 1jCYcI-0005Ia-NO; Thu, 12 Mar 2020 20:55:58 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02D0qD8T025628; Thu, 12 Mar 2020 17:55:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=facebook;
 bh=jblf/wtaZkgMARGaAfEh+OyYkRvrqOM9fxNCdw32ll0=;
 b=dEYZB6voWgx85XPdPx21As2iJoCFHOk7u9xpk0W4RdCKS92BUyLd4QakMAGii35q3jMW
 S433x58HzdouQiJJjM5+iEvdPSmbrBw7x0jVAA3hSgI7J14AiJ+03CNOFBNd6OwgHytL
 FJK7fKJJBM4WwvphTSSAc3Bzo3PcPovrPcE= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com with ESMTP id 2yqt80sp8w-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 12 Mar 2020 17:55:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 12 Mar 2020 17:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT1Sx0sXuQ6GAXh+TkqsEejCq4n7La/a5T94y5w3DlGRqs+FqlmYpATif195O8IBIsKwvgd+eXnXryGRFnu4b2Iyk8zlfeji/O54fR8EJ35AFu8lmjdl3OB+YNyNvdyPAJoKNkOgG0Irga6szRVkdBJfxrR4CSysFbh+RjxmMD66Qq6kEeCOm/2e4o5LSRI7jFALZYk5fG9iik0gujfMRdh1jClrUgoyYC1szZ0WEPLmUMMANxVMgqHoskvD8/x88Ro4m80l1uL8snvtaSUpElCR6PUXAB2N4haBpN3LozfdIG3RSuH6wO9I8HvhS4VpvuCmQdwHXeHeORSvvHV05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jblf/wtaZkgMARGaAfEh+OyYkRvrqOM9fxNCdw32ll0=;
 b=R8JltQC0bDrNom52WGTEK2YOeekB9Sufyiy1zWI39OpQTtQMcmxB68kfXk4RM29gCbKreF8EHlGRAaQrrvVfNTiIvWp35EHmJmUrHDAm8q6q3ZNPDZsasQNBlv5ZP7760+ypMekHyJDvGsismD7CrltpZViXBAaPs07iC0S4+7GYtqOh4wbXjuIDTHzbBL7FT0UQcykfj53TU3lqglpDYDh3B6luRIk2AiRwxDeqhp7oFSqvngnH9h93huGDkIEHX4NMAOalPGy/vqevVhZqoPrvPkPc8PGE6xvnzlGY123veNpQkSyGcbplz6UjghK19GHNoFe3D/EtRqZuQmJjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jblf/wtaZkgMARGaAfEh+OyYkRvrqOM9fxNCdw32ll0=;
 b=IesTthM2zWyEC++GGP+TRAQEBrLfYh76wbAm2rzFCxdBYU/nRD34cc1XfHULT63PQehSCnZIPWXb7ATLdl0shH3WXj+ZHob6oh0VZmx3M8NfgVcroiZYJupZ9a0crYHhM2ZToxAHqL5n1YMbtmw7kqaC/2YvQoYm6uY/vD1+Fmk=
Received: from BLAPR15MB4035.namprd15.prod.outlook.com (2603:10b6:208:27b::8)
 by BLAPR15MB3796.namprd15.prod.outlook.com (2603:10b6:208:254::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Fri, 13 Mar
 2020 00:55:35 +0000
Received: from BLAPR15MB4035.namprd15.prod.outlook.com
 ([fe80::1005:cae:8f47:227c]) by BLAPR15MB4035.namprd15.prod.outlook.com
 ([fe80::1005:cae:8f47:227c%7]) with mapi id 15.20.2814.007; Fri, 13 Mar 2020
 00:55:35 +0000
From: Corey Wharton <coreyw7@fb.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH 2/2] target/riscv: Add a sifive-e34 cpu type
Date: Thu, 12 Mar 2020 17:55:08 -0700
Message-Id: <20200313005508.1906-3-coreyw7@fb.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313005508.1906-1-coreyw7@fb.com>
References: <20200313005508.1906-1-coreyw7@fb.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO1PR15CA0109.namprd15.prod.outlook.com
 (2603:10b6:101:21::29) To BLAPR15MB4035.namprd15.prod.outlook.com
 (2603:10b6:208:27b::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from coreyw7-fedora-MJ09BKJM.thefacebook.com
 (2620:10d:c090:500::5:9b25) by CO1PR15CA0109.namprd15.prod.outlook.com
 (2603:10b6:101:21::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend
 Transport; Fri, 13 Mar 2020 00:55:34 +0000
X-Mailer: git-send-email 2.21.1
X-Originating-IP: [2620:10d:c090:500::5:9b25]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77a798c4-f692-46ac-a407-08d7c6e93d0d
X-MS-TrafficTypeDiagnostic: BLAPR15MB3796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR15MB379698CAFB62D7CB869F4C5A93FA0@BLAPR15MB3796.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(39860400002)(396003)(346002)(366004)(199004)(4326008)(316002)(54906003)(16526019)(186003)(478600001)(36756003)(52116002)(86362001)(2616005)(6512007)(5660300002)(6666004)(8936002)(1076003)(6506007)(2906002)(66476007)(66946007)(6486002)(81166006)(8676002)(81156014)(66556008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BLAPR15MB3796;
 H:BLAPR15MB4035.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fy4o3BV5iymprob7z91osZexv5JywKJxM7ckMAqdrYTMHBva+of3MBdwnkwFNP124jf7At0n2ea7h921tlAAdMRe8IBrCmyKkWbhxEQ2I5YRBqNWxPhq37SULwwh56gTdNIYp1FgVEuxcyoh4opQ0UPO98d/Qi+wiKXD/iuhz4jQQqGm1UKPhHyZURK/6QL3VFRKPfsRvSjaAlYbzr6D5asChjLm2fUb7SAtXTVd5H3e/NcsJQ0q6n42Wu4jPwJd4ujBLImqkCWrUeNvhJyWRmzrAcp/2I81klSx1zL2G/mVakM5K6Om2syIKVnHpJ/WLGJPT5/uKsNqP2hy3ZyyyGG+NbLVoR6LBHzOw6ahwzICwuXIWIZdPJ9/UafouRuVAGWZS2lcF+mj5NjFswcv2OzLP9QPP24VUVfzhO3nMuT3DlMv2qQCxRKWcp1M6zEH
X-MS-Exchange-AntiSpam-MessageData: ppJRxSHmxmQPm0M1ojFI7h/2ETockGg+VkOq+6efl1pCVRgkALu3oztx+SJ31p+oSEx2N2TP1KOZg0TFS9X6BEAx3Gxq21qfgfNg8IuZlVDQwsdJzO8Vyelp9WvYht46I3EcQKiRme9HTw7ptcmMjkuvy/Lpv2JAqx8TuiDgxOX4s+iLEY+TjHVbqOTOaLhC
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a798c4-f692-46ac-a407-08d7c6e93d0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 00:55:35.1791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IM34fHCUW0sMMNaVlMs09JHJJNKZ7+4P6OaS+/OmyQaxqzLYD7UwTKKRmtxsI4re
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3796
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-12_19:2020-03-11,
 2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=822 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130002
X-FB-Internal: deliver
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.145.42
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Corey Wharton <coreyw7@fb.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sifive-e34 cpu type is the same as the sifive-e31 with the
single precision floating-point extension enabled.

Signed-off-by: Corey Wharton <coreyw7@fb.com>
---
 target/riscv/cpu.c | 10 ++++++++++
 target/riscv/cpu.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c0b7023100..d415cd06eb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -164,6 +164,15 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
+static void rv32imafcu_nommu_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC);
+    set_priv_version(env, PRIV_VERSION_1_10_0);
+    set_resetvec(env, DEFAULT_RSTVEC);
+    set_feature(env, RISCV_FEATURE_PMP);
+}
+
 #elif defined(TARGET_RISCV64)
 
 static void riscv_base64_cpu_init(Object *obj)
@@ -609,6 +618,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #if defined(TARGET_RISCV32)
     DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base32_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32imacu_nommu_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32gcsu_priv1_10_0_cpu_init),
     /* Depreacted */
     DEFINE_CPU(TYPE_RISCV_CPU_RV32IMACU_NOMMU,  rv32imacu_nommu_cpu_init),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3dcdf92227..ae5a1d9dce 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -36,6 +36,7 @@
 #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
 #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
+#define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
-- 
2.21.1


