Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC66C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:36:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9E7206B1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 19:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="bG/Jlmf2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="E4HF5RdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9E7206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCq6z-0004Eh-9s
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 15:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCq5m-00035y-Cg
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCq5l-0007fz-9o
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 15:35:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=03412eee96=coreyw7@fb.com>)
 id 1jCq5i-0007V8-Ez; Fri, 13 Mar 2020 15:35:30 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02DIoax0025931; Fri, 13 Mar 2020 12:35:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=facebook;
 bh=vgJmTvH4/9qcUWLQtBmLUngExgoUYgw7JXU+3SGgzxA=;
 b=bG/Jlmf29LE3ls+R1qOpXOiSL+wSxJg3Nw33bXQtTZsI0783uxDARtsaUVQwE2eRaIZN
 VYgSDg971fNsNoYGH/cgsvhJN1yDsGhUXK3kt+2Dx5wYDr+WugFSdPq1tqpD0BDNkCaK
 DscQ2aFBJbKMHO7fkZ4ZMcyhVYDUCUBjR78= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 2yqt7fp0cx-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 13 Mar 2020 12:35:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 13 Mar 2020 12:35:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKalEkLAB3EBsLiho4H0uQZ9UOIDLGWpUOa0BHq/QWzHeJKqqfD7t33KdgQEi1TvuROYKQ9BNMjXjHs09nWEIlHcbecKAT+Ay01caxWcxFfEatvbrAjIYmNin498o7xoUvvZS6YJ10Dnx97OkdRSDyi1rLbEuXB8pRv1WAB7KlN/QOJYLBHXHXOhE7S3lAnVQ/g4cB9nZMfoKVahNA33v+mqUFRDEIfAeIIpNXYbx0V1npRdG4IKIzbRD6UF0PXrKw0uZd8hqBR19HVIDgkHnLNe/8KHwaui/h2VLlrzFBKoCOSgtHyMN1+YwoZneyhmXv10BFROQxc94pL/zHD3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgJmTvH4/9qcUWLQtBmLUngExgoUYgw7JXU+3SGgzxA=;
 b=i2DFwGOBIWCK2JJHK6HJ7sgO5ZSz7FS2FymSdqvuB3FZoT8mQLD8t2I1jygdZ39gziVAe0vVgLTyIagDnf+EALX2LuuAmvtzp5zefaaPFdxTwIQ+3mN9k5tMwVCXeSwR4f3KUldkemBGEtCJERFEI5n/HYw7DkbFGDl8rB7KdoOM+5kmorhmZ+/LjKvDLI2NEII0hkPyD+M3jpz53d19sifsLGMawJvlcsf3LIOUwwGAD+7s67WETERM3vFX+V62Z/xBnyniKCQlewFqj9/TDk7GeILJ+Km0GfHHpEUcYzXp9NCX80jX+zKSo1cm3j8K7TYTHRA8O8GADajjzFCi8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgJmTvH4/9qcUWLQtBmLUngExgoUYgw7JXU+3SGgzxA=;
 b=E4HF5RdAh9vBAKndQqpiNpexjfJWfQs5ILnRuHzdn82OxKPDIz+b+rSWXgVmceNareB8GvNe+FNencMEZG0Qczz7j9E7HDAD4zrCA1RlrHesicHTL7TljIYTtuQ+s4UcnUO/IH8RzYENlXfHIiF2zqzADASD99n5ERGVzcbZQWI=
Received: from MW3PR15MB4041.namprd15.prod.outlook.com (2603:10b6:303:47::20)
 by MW3PR15MB3803.namprd15.prod.outlook.com (2603:10b6:303:41::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Fri, 13 Mar
 2020 19:35:19 +0000
Received: from MW3PR15MB4041.namprd15.prod.outlook.com
 ([fe80::c110:c47c:2e3b:af31]) by MW3PR15MB4041.namprd15.prod.outlook.com
 ([fe80::c110:c47c:2e3b:af31%5]) with mapi id 15.20.2814.018; Fri, 13 Mar 2020
 19:35:19 +0000
From: Corey Wharton <coreyw7@fb.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH v2 1/2] riscv: sifive_e: Support changing CPU type
Date: Fri, 13 Mar 2020 12:34:28 -0700
Message-Id: <20200313193429.8035-2-coreyw7@fb.com>
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
 Transport; Fri, 13 Mar 2020 19:35:18 +0000
X-Mailer: git-send-email 2.21.1
X-Originating-IP: [2620:10d:c090:500::7:96c0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88a5c8aa-64d7-4b93-c138-08d7c785a99d
X-MS-TrafficTypeDiagnostic: MW3PR15MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR15MB38039AD9AF1D1C639B0404A693FA0@MW3PR15MB3803.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:112;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(366004)(376002)(136003)(396003)(199004)(186003)(16526019)(66476007)(5660300002)(66556008)(2616005)(66946007)(2906002)(36756003)(8936002)(81156014)(81166006)(8676002)(6506007)(1076003)(6666004)(52116002)(4326008)(478600001)(86362001)(6512007)(54906003)(316002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW3PR15MB3803;
 H:MW3PR15MB4041.namprd15.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TT0xu9RaMPEkLgq6mYc5oXUziVc3f3v+ky67QlB/TpNDgO+XsYgFg2OkqdpTWrLYvEdyhoGTOL3xixK1aR1F/1NTGlgifw2kjmFl1ikfhDC0xKmU18e9HfeUShvDs/D42nYdpovJ7x8bmyWUz7hxiqVaB669luhicc/VdMODOl3fhm2IJ+pzNHxvMyDEhAEmzWd+k3gp6770ApWH++EB+Pi9K4IX4hc0rl75G4ZwX0LYChfRwdbmR5Ld6XM5VGajjrO5KO2CXiuNC/S+I/l8hRQNYByc9IoHH5vfZqAaPv9Iz+jfX/YBdncrMYs4xaagZBZBdulth3iAR4bHP7hIz6/Gy+pQ+GIYq+Q4QijB3TrtctPtW1N5MRoa0Lv3dAiB/CkkXS7Td83pMLELmTGcXwTb+DHS2sYPRbCdo56KgovWtm49IazYqjTVMVzAQ4ZV
X-MS-Exchange-AntiSpam-MessageData: 1yxJtzRbp4gjOow0EPGpWJbd7+R7J915qGhmvT5h0nAn1tQY9I0ymsuIAuHPnCQAYBsBATc1Cn4N8YcTABVdjh4JUyXack1TRiVtnzN66zbnFekwOlcIpOTGzHqWFJa0icdBM5fTMh4RhMJybRb1UogLFWXljz3tJYs/BZFUOBcyc4XuFN0H0GVfumIx3KEh
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a5c8aa-64d7-4b93-c138-08d7c785a99d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 19:35:18.9437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Gl4Ck9b5Kh11atywvWoCE8Aq47l03bOzds96JYjw5sRs5KL+oyMcfNqc3Y64azF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3803
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-13_08:2020-03-12,
 2020-03-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 mlxlogscore=999
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003130090
X-FB-Internal: deliver
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 67.231.153.30
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
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allows the CPU to be changed from the default via the -cpu command
line option.

Signed-off-by: Corey Wharton <coreyw7@fb.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index a254cad489..b0a611adb9 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -123,7 +123,7 @@ static void riscv_sifive_e_soc_init(Object *obj)
     object_initialize_child(obj, "cpus", &s->cpus,
                             sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
                             &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
+    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
                             &error_abort);
@@ -220,6 +220,7 @@ static void riscv_sifive_e_machine_init(MachineClass *mc)
     mc->desc = "RISC-V Board compatible with SiFive E SDK";
     mc->init = riscv_sifive_e_init;
     mc->max_cpus = 1;
+    mc->default_cpu_type = SIFIVE_E_CPU;
 }
 
 DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
-- 
2.21.1


