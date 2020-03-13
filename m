Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FC2C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A68206B1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PHUDE5H6";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="j5zciuJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A68206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCq87-0005jY-Mg
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 15:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCq5o-00039e-3X
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCq5m-0007n8-PC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:35:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=03412eee96=coreyw7@fb.com>)
 id 1jCq5k-0007Zr-83; Fri, 13 Mar 2020 15:35:32 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DIp3xI005468; Fri, 13 Mar 2020 12:35:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=facebook;
 bh=t+tsdsMESYSPPzE9hGgLMGxXqbjjTmXYWD8B3SRoV8s=;
 b=PHUDE5H67KX3EdQ1CIiCiNCJnUUy/w9eS+tlIQQV72nORLeRB9w3xzFG5xi36//tOsdp
 sN6G+soKx4dZd+Q39a+wXi5RL0kSCY9Tk25qzEaG8cHt7w7TLTQXtliejksLUh5Evt6W
 CK5CPDmQtP/5uT2wIwAyo9X8flzsOsEo9t4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 2yqt80wvv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 13 Mar 2020 12:35:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 13 Mar 2020 12:35:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbfP8xnaXOV5DfidnpXBRkUU9VG/imIf5jlR9+bTWEt6mBpt2MQeMG/VwO7a5mFNiekf/mNZ+2YQ6g4BahU3niLk7bho9PSxJy/F1dyALeHxRnmyh7pNM7vEOJlRXrwerZYWvGV2HR5X+YSan/QVCy5AUmCEteLWjUMG+ZjhxMvqZnCkVPn8erNB5ug5oBvae4PKIUcCqW4xxe+cmtlOqPI49dJP236W0ptWZ/7eo8ekdwukMmmSkQMlORTps14sopQyBiHO37S5k+fpTR0MhJFN/i9u5nPn+igw/WmJfJYumUZa3+iaEfoJR9f3+MK9IBaWGuTZo2oqrZo47zEdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+tsdsMESYSPPzE9hGgLMGxXqbjjTmXYWD8B3SRoV8s=;
 b=OHW1lTbUXKbltqHTedacICb8sD6TmVJd5o58xK7jF+Rgytb+Dx9WgACLKcYhNHksUPyityAzhs1T1i2O9m3JL/kZ6qWWw05rnCwvXbjWdLps2dssx/kXD9J8VK9TPjtujHDeAN4fnH5dTMP15eW1d+VEi6nOYY3OvtQnAhFaOyJTJlTx8fkKe3UjyvPzplXaGIk79JQEoZqX5MXb5vbUf3/RLp/sjdXT6px8BNHK56ImW9Y/fjoBzKgkN9anOCPtX+0tdWPRFu2VZPAQB8vOYh9CeVk5NwB+MgMW0dAg0wbbhEDRue32RUGVXskn32Vyo73EyOf4VToNo8u8Yq4nGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+tsdsMESYSPPzE9hGgLMGxXqbjjTmXYWD8B3SRoV8s=;
 b=j5zciuJBG+cmzMo0xZaAal8cmEh4UuM/PsFwxc3P5U8XyPJN/gMlbGbQp56nE07FJmEoHc1+RcrK/beZHGFbYySu22fZFKhkg3IW6HRo8xBUWDX2XJ4IRcqfgv3IXq1nn+SUZxCZpNPXdqPWbhT8fySe7UVhNSUEj2Ned0rHTfc=
Received: from MW3PR15MB4041.namprd15.prod.outlook.com (2603:10b6:303:47::20)
 by MW3PR15MB4027.namprd15.prod.outlook.com (2603:10b6:303:4f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Fri, 13 Mar
 2020 19:35:21 +0000
Received: from MW3PR15MB4041.namprd15.prod.outlook.com
 ([fe80::c110:c47c:2e3b:af31]) by MW3PR15MB4041.namprd15.prod.outlook.com
 ([fe80::c110:c47c:2e3b:af31%5]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 19:35:21 +0000
From: Corey Wharton <coreyw7@fb.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH v2 2/2] target/riscv: Add a sifive-e34 cpu type
Date: Fri, 13 Mar 2020 12:34:29 -0700
Message-Id: <20200313193429.8035-3-coreyw7@fb.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313193429.8035-1-coreyw7@fb.com>
References: <20200313193429.8035-1-coreyw7@fb.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR21CA0060.namprd21.prod.outlook.com
 (2603:10b6:300:db::22) To MW3PR15MB4041.namprd15.prod.outlook.com
 (2603:10b6:303:47::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from coreyw7-fedora-MJ09BKJM.thefacebook.com
 (2620:10d:c090:500::7:96c0) by MWHPR21CA0060.namprd21.prod.outlook.com
 (2603:10b6:300:db::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.6 via Frontend
 Transport; Fri, 13 Mar 2020 19:35:20 +0000
X-Mailer: git-send-email 2.21.1
X-Originating-IP: [2620:10d:c090:500::7:96c0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f409c4-6c64-466e-8684-08d7c785aacc
X-MS-TrafficTypeDiagnostic: MW3PR15MB4027:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR15MB40271F4B77CD05E888B93EFC93FA0@MW3PR15MB4027.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(396003)(39860400002)(366004)(346002)(199004)(66476007)(54906003)(66556008)(66946007)(81156014)(316002)(8676002)(2906002)(81166006)(8936002)(5660300002)(1076003)(186003)(36756003)(16526019)(478600001)(2616005)(6512007)(6506007)(6486002)(4326008)(86362001)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW3PR15MB4027;
 H:MW3PR15MB4041.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XH3q7Gfls5ZgPOW8n3+vkPBOnH40f3Y6dNdbsVnoesgR4j6BvLC1xZJi65/H6bztxEsUpiGqUBZkvUP1daPZ/F5int3/epgQkJajkVS7sKRn+R34MR6ZZS8EZcQV8D18Sl5zHRgZ4N0VktsBcisdiQ0Eg9oHUkBzh4g8ofnDpc8/MTUKOF9c1r0OpywLtexKa+qNVn4/BSrsCeHpswrLoGaWbBUzuI1JQYEC4Db8f0y+oopMe5wHW0CTTi+X13lfZUzp4pdj2MTYlVZiFFkmVhoM0hhJ8bBaU2gtLZg0XNTrB7omoreuyc/wDXX8agmo8Ii7C1Qw71SSdfeLfqdP5J9JML4Pw+feyqRDRLGrwst0hAzcWmxIqcFJVhE8tmtQXLGsQazfneaZgqaP7z2LtEZ4G99ndoHs0KqU9U8mPGXJPwZnSZbQwKpcfBlcR6/4
X-MS-Exchange-AntiSpam-MessageData: EVT9+Ov+BvANyIa4MDi4rroierOjjxVs/pAf7tDulh974ZVAx3vi7b2dk8lBPZhvwyidaOZUJEXDpTZmkDEXLFHj2YIGbopBJ8xCBhrRK5JXe1ZqLuXevVc2uTYsTAEOlZ45PEP/1lLRGs5xNwnSRuc0Irn9lKdxZhxOWSdTHZMmLnAghJZIoEvTBY//jaGA
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f409c4-6c64-466e-8684-08d7c785aacc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 19:35:21.0723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HwhSY5/tApKhtlW3T9VjEhJhmBqkxfot0+7rylH7glFCzDWvMB/bDVPiwih5C8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4027
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_08:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=887 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003130090
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Corey Wharton <coreyw7@fb.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sifive-e34 cpu type is the same as the sifive-e31 with the
single precision floating-point extension enabled.

Signed-off-by: Corey Wharton <coreyw7@fb.com>
---
v2: Added missing RVU flag

 target/riscv/cpu.c | 10 ++++++++++
 target/riscv/cpu.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c0b7023100..1ae9d085b8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -164,6 +164,15 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
     set_feature(env, RISCV_FEATURE_PMP);
 }
 
+static void rv32imafcu_nommu_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    set_misa(env, RV32 | RVI | RVM | RVA | RVF | RVC | RVU);
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


