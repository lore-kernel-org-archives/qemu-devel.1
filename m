Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3DDC1975A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAB6206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j0b+BBHZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ONOZsRGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAB6206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCYes-0004ab-CO
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCYcM-0000nE-Af
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=03412eee96=coreyw7@fb.com>) id 1jCYcL-0005PO-7s
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:56:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=03412eee96=coreyw7@fb.com>)
 id 1jCYcI-0005Ib-O1; Thu, 12 Mar 2020 20:55:58 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02D0qD8S025628; Thu, 12 Mar 2020 17:55:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : content-type : mime-version; s=facebook;
 bh=z5i76bGEffOQrMkoMBClRukxuQsLtxLA5shXKZlaPV4=;
 b=j0b+BBHZz7Ui3FkuXTh72/pm85V4xexBsS4nNMugIdAjkJnauiXRULnglbxH0EGNepmG
 PV2ffjhV4l9GiuNcS3FWoY8VreRXYqcGc7MD0XUvBX35Te6woTcqJn82yeV3BE/TDTGv
 uQ1Yx8SI+igXajEd1N4QUDgTUakivtE+KH0= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com with ESMTP id 2yqt80sp8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 12 Mar 2020 17:55:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 12 Mar 2020 17:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTiuculLNhXt2BQzVLKG4PDOrFe6k/hdro1Qnw76NGfuf2J1n50IPnZfpoBXEUVl1bUSax1f/fVXqU7AaTvGIXccj9KBhmm3e8rTov0YHPIARYBC+FjmjFkIUJFemSLR87BLH/ox2OjrMdaf45c8lTBa+Jv140cxk80vV2MnuW0s0mYFwhj/cqG1s5x8dzmA9yCJR8X/Hduw5Mmhf1si72E4FmmE45pxfEeC8QxKvU2uag3GOD0Mkoi/8yqzsGaxDsZiPvMf/Wz8qmjZIWJ2inFIz6n28rteeTD1GzbvugzPCC4WlFQjjyIND7pP2nDsf8tK+7bJmnSEwZe1zs17iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5i76bGEffOQrMkoMBClRukxuQsLtxLA5shXKZlaPV4=;
 b=bW+932d+A6XzXwbf58BFF60co7goFvTrMOOuBhFfgARuoG8s8YcSe6B3LGCd9xeqaaX5QEjBogi00dLWc3OD/9luuwBTv0tDfls1lKFzpjBrCu9VhCAMf6dmp+zrROFs4SPvhVeTwUjha2qHpzdhXUNLNc7sbQ05QPduTZUZ199O1dEh5BBAsoZ45p3BBC4yBanSwgT/wa3VKeEmctbJdWN7coXmLPDmYQ/fEtEEx+Jf/IZEienirF4b5w6fRg9NU/+x9gkr9019X9lLgRDeiwQO+mzbai7dJjmGo3YddKtM2rkt5EFCH4vaRlQcPkpdUwif6fv7Qq3bj5vQqWcmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5i76bGEffOQrMkoMBClRukxuQsLtxLA5shXKZlaPV4=;
 b=ONOZsRGKtLXUOmbECM3TLdtkCfRXi4hvgOWwvPNzmkggeA6uvP1iToLmrBBANYLU5uubVHFaV5gLisK1WFnF9lw5wRBx+nlGeSwuc+DxEsYVTnPBYkjC6HIjCnjmjgKDWpLYEpZZqf3f7UJG+def1ltBcMFl7H0UFUZIA1g1ozU=
Received: from BLAPR15MB4035.namprd15.prod.outlook.com (2603:10b6:208:27b::8)
 by BLAPR15MB3796.namprd15.prod.outlook.com (2603:10b6:208:254::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Fri, 13 Mar
 2020 00:55:32 +0000
Received: from BLAPR15MB4035.namprd15.prod.outlook.com
 ([fe80::1005:cae:8f47:227c]) by BLAPR15MB4035.namprd15.prod.outlook.com
 ([fe80::1005:cae:8f47:227c%7]) with mapi id 15.20.2814.007; Fri, 13 Mar 2020
 00:55:32 +0000
From: Corey Wharton <coreyw7@fb.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH 1/2] riscv: sifive_e: Support changing CPU type
Date: Thu, 12 Mar 2020 17:55:07 -0700
Message-Id: <20200313005508.1906-2-coreyw7@fb.com>
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
 Transport; Fri, 13 Mar 2020 00:55:30 +0000
X-Mailer: git-send-email 2.21.1
X-Originating-IP: [2620:10d:c090:500::5:9b25]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 505aeb05-5904-4f78-5259-08d7c6e93b35
X-MS-TrafficTypeDiagnostic: BLAPR15MB3796:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BLAPR15MB3796ED370D7D77C420D3C97293FA0@BLAPR15MB3796.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:112;
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
X-Microsoft-Antispam-Message-Info: r6KBaR2g/bRHMwnu7xqMvh/kcy01eA8qQFGXeG9sCnPdIwi3QJmI6CjvHFt+k0NuV/2+UYKBD4PvCT/iTuUOfY+2jFlqGw+NU+ZTOftk2dMdw/6Q4hYa/9kMQRXKmH3fxOumrbNLpOHK3F3GMZVgbB0z3JHW3dzL7Vr9eS5QsscMYhcqErxku5tR5rT0Ruxz2tvfM05GCXY04Yun9+4kIu6Ipw89Mc8CDohWHvFCQw3u64u4cDIFMNeVOV7VmpVX5HoONRTPVzoT8cDavbfhTmGqjoGpMK7BK3hAp3IiG6MnBbIEQboo29JoyG/Hu6yqVN/xTckVnj1RwtuKLuIXINc65h1jEsiLUGhSgxGTEVc35cs4tal8PUlkgC2VrWzASmXzpwHsELj5Y8mWUa0/pomJwOXo0RRHorWDh/iaBxLLeelqlTt8avrnlFmkpGzX
X-MS-Exchange-AntiSpam-MessageData: BWjNfV95m/cz5Sgn6XHx2kh3OdJhe9jApnabEidNJthmuJ3bihemHo8pxR8yoASvlDNMJWxpCDv8DGo4I7B4GfL3Cls73tcNj+8VXx89Td1Xx7oL+VEYZglVeT9RQxdDPfBKYc9teth5MzePRWTVLSte5uAkt8IHHp997M90+oHB11TvwpTRs6Jd8h9wds1a
X-MS-Exchange-CrossTenant-Network-Message-Id: 505aeb05-5904-4f78-5259-08d7c6e93b35
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 00:55:32.1275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmDAzG8DVxa3KIxYb9uDEvIc5EnYSkI7ZzzZ5j/BHOLR6MF3orm8G2Qf3bTo7z6y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3796
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-12_19:2020-03-11,
 2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=923 mlxscore=0
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

Allows the CPU to be changed from the default via the -cpu command
line option.

Signed-off-by: Corey Wharton <coreyw7@fb.com>
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


