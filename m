Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719E2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3282074B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MRgocWOH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TyhVZZZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3282074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0kKf-00027j-ER
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 07:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=47218c038=Anup.Patel@wdc.com>)
 id 1k0kGO-0005Ho-UE; Wed, 29 Jul 2020 07:28:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=47218c038=Anup.Patel@wdc.com>)
 id 1k0kGM-0001rW-5N; Wed, 29 Jul 2020 07:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596022125; x=1627558125;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=e50FjJH9uwXlMNKJAOy+HYiki8Pod1mdylF2n7eqmUU=;
 b=MRgocWOHTWG9xY4B4BSO2mtq2tFr+eD7fsuOLagH+BcLWBw8QJ8uJJpm
 G7V8QfbzTiXY/tMsaDCNAeHklCKfxVNaVYUDV3Fk+qtxYfzuGo62oufjW
 Hm20i37TB29MboHaAjfGSLV2Ql4r27eyAVlXRbPMPGUChmEMvvqrTc9V9
 ZjEG49+lvsA+K387++swoWtBUnFhSMOH5/12qs2KC6N0tLYzg3t7nhT5l
 NXmESju+dnpUm6Kb5iYGTlD0Kux7rndy0TUIvj1oR3NIeHZHZtMk9a6C8
 LXpVa9zJcw8GgVCbzHSBTGfdxm7gcapKgL/YEpJS1svaDBnenkH3NN5BB Q==;
IronPort-SDR: 5YrV8jiF3m8hbrQomPaS05SMh0Ri954VynltwRQVTKMPIYSrKkTmUHu4ryYQ/p+iF0l04nOL57
 KC1KwKQNeOWd9Eep6+E+U+UWeENNyKYbX8qHlM1K2xMtdd0991vB4OCgpvV40UCuKO+bYTYKpA
 GSQ0YbwlmdpFbcNpwEmsjnG00tDonNmqkFP+AR/HXZONaN4y7o0CSVHufkweUwkrijtoNbbe3e
 u+eBOj5JMIykXk1GWlUiPLG+em914/ijZCaAtg14cph0uOIxIDVF1w7ngy76SkpQJKyHqQf7/N
 y74=
X-IronPort-AV: E=Sophos;i="5.75,410,1589212800"; d="scan'208";a="143644198"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2020 19:28:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ei4E8w40m7ITNJt+SSMoq4OS/MDUR6IIwZDgLzZRvbRzRhyvLjJGYM87D5SV7UQQ3rZK9XHLZDZZvvLam4YCicWgTXXlJ1dK6hayaBLXSUwpDrDB1pad4xrX0tAhHv03tfXgO8hkwWLQ5ZBASfsXecyVCA9B+qdoRhcZtlhQVLx2PFLFPYgb0Kf5y7igJz4gdCZ4DdWPNf4eKo60CYpbM6Q2SiGnG2R6aRSJu2My19/Bs1CiicUC6DTmk5O70DUkqhPd6ksTQm0Isv+czIeUXIk8U3hnn2VJRW9yXIZ/IlmR1No9HhHChNTDEdW0CVkwbNNfL7/Tf0dciI4JooWSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6/MNSpdtXBXAJdj/SCoTexXObfJ4XCKq+mQ+4Rhpdk=;
 b=TpzLs5Y9DnqeJlbi2oHxM0D1eMRihlMK2yvgiiZCSsTdpJx5DnqS13C1MpmTc/pEbdgctTov5S0BeYU02jBcycsqqD87DoueQSGKY1fJfW85oNUEusNMuTL+sGRpCQta62LOvb8Z3hvcSxiOdasU7YyezKIu59MmeO/SgNft9m7Dbkn/V37FMrj/ZDhexUuNNlb+krHJgiMtjX3k8VnsIg72t0ow/TPndFZJXL17J1RG2VLSQuvrexS+2cwXup69i9zmXThc8PzOmYgtYzwWlWDzDPMHO4wwmIHocefaerMmMnm8CihzcLxx/pKkfCGljI6btDg6ySvwAl1llpPKsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6/MNSpdtXBXAJdj/SCoTexXObfJ4XCKq+mQ+4Rhpdk=;
 b=TyhVZZZVI9lObFhbWdQaiYRVThttgoXhKTbzU7aHKhK70d4uAmqdjYtmGnoztxQE13rZmsdiGQ6s7O5QDMJ+09e8ayIlPdUBrhZW9LA36hl5BqDne9wgyCHaKKzEFIZJGLtreaOYUuYtn1sbiOBwOelj0pFOhhN41qttawq1Eds=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5753.namprd04.prod.outlook.com (2603:10b6:5:167::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 11:28:43 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 11:28:43 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 3/3] target/riscv: Update MTINST/HTINST CSR in
 riscv_cpu_do_interrupt()
Date: Wed, 29 Jul 2020 16:58:01 +0530
Message-Id: <20200729112801.108985-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729112801.108985-1-anup.patel@wdc.com>
References: <20200729112801.108985-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::36) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.56.183.175) by
 BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Wed, 29 Jul 2020 11:28:39 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.56.183.175]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf5f1004-d8b8-4a4d-9fb8-08d833b28c6b
X-MS-TrafficTypeDiagnostic: DM6PR04MB5753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5753FEC35B6BF53F0AD0C1528D700@DM6PR04MB5753.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkEN2A31v5MaIsNFZasHDZg6qiCcMey76GfFo5Iu0MFYDLWrDCyAcCszkMneXGBYTH/vOnEZ0SplO/Bln1nOwrJbldVaq8ieG+pb1rx+BXKalt7OBr1aOHlXW8ezB5R1DB9puSMIFgWSIKWrcp7Pci73hyjBOwBYiDExJsZbBqLlMt5eiiONam7H2U/Gi08R3+7qJAMxUC5crZ4maZsjPln8XS536FuTIjDBZYsk94Aocw78bKqzS39Nwrq+uaAkJzzwCdFD1cefdMgKIxDeXXKSp4lm95gPK3xTdJeMN2MZC30D/cJoZgjG3oXMtBJ6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(4326008)(36756003)(956004)(2616005)(52116002)(8886007)(110136005)(2906002)(83380400001)(7696005)(55016002)(8676002)(44832011)(186003)(66946007)(316002)(26005)(54906003)(16526019)(8936002)(86362001)(15650500001)(66556008)(5660300002)(6666004)(1076003)(478600001)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vzm+Xy4/CogUyoSnT/MJ4APIJ2oKmGMQ3ba/m+4c6TNyaVSk2rcOXtPFA5mdOEfmzByKNJKP76/TFqe39rOnULkrOtCLDdMZ1dBbqhYbynXoGCRQOm7mEs0Y+EccbLjixdBalBxrHbf8dyk+SSnml0LJfnVoil3kqwQGZUhnZhCdL+HtaArZ+j74PIr9wjh9OoyKl7ppVzYw5ps5JmE087WplsVXeuAXG1nUACy9g8/HHLnPL+ESYJqnlC4HzCvwvUwwQEz/ugPxxpY4L58lyMkCnq6riD9cQedgzshdT5NEDNDyTQ8/tRrgpiws5i6KmU1ieIKDntVh1021EScbBv1PHPQqqg2bGaeB77Zt/EVOZq61Tc+kGaV2CqRBePsKCw4VGiNVsADjTtJW0GiJq1XwvzVFiv48V7Jg3kh5TVUNqkLbirDQhCHWYUo5hAP7r/LBoDjkbSf45xST1GuNTjm+l8CIW0dC2TU0h8XqRl6iPK76exWwLJa4RVw1MvbM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf5f1004-d8b8-4a4d-9fb8-08d833b28c6b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 11:28:43.0541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBlMwB1wKe4Pj3KMaxXofMlnXP/rIeiNDpha3w9WxPMWDFG5WvZIoulZgIhDW0Q0xkaFxWGM4N2ChOe+XPc33A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5753
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=47218c038=Anup.Patel@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 07:28:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When RISCV_FEATURE_TINST feature is enabled, we should write
transformed instruction encoding of the trapped instruction
in MTINST/HTINST CSR at time of taking trap.

We update riscv_cpu_do_interrupt() as-per above.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 target/riscv/cpu_helper.c | 166 +++++++++++++++++++++++++++++++++++++-
 target/riscv/instmap.h    |  41 ++++++++++
 2 files changed, 204 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e4bd45d66a..97ae23ad2b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -22,6 +22,7 @@
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "instmap.h"
 #include "tcg/tcg-op.h"
 #include "trace.h"
 
@@ -820,6 +821,151 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 #endif
 }
 
+static target_ulong riscv_transformed_insn(CPURISCVState *env,
+                                           int xlen, target_ulong insn)
+{
+    target_ulong xinsn = 0;
+
+    if ((insn & 0x3) != 0x3) {
+        /* Transform 16bit instruction into 32bit instruction */
+        switch (GET_C_OP(insn)) {
+        case OPC_RISC_C_OP_QUAD0: /* Quadrant 0 */
+            switch (GET_C_FUNC(insn)) {
+            case OPC_RISC_C_FUNC_FLD_LQ:
+                if (xlen != 128) { /* C.FLD (RV32/64) */
+                    xinsn = OPC_RISC_FLD;
+                    xinsn = SET_RD(xinsn, GET_C_RS2S(insn));
+                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
+                    xinsn = SET_I_IMM(xinsn, GET_C_LD_IMM(insn));
+                }
+                break;
+            case OPC_RISC_C_FUNC_LW: /* C.LW */
+                xinsn = OPC_RISC_LW;
+                xinsn = SET_RD(xinsn, GET_C_RS2S(insn));
+                xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
+                xinsn = SET_I_IMM(xinsn, GET_C_LW_IMM(insn));
+                break;
+            case OPC_RISC_C_FUNC_FLW_LD:
+                if (xlen == 32) { /* C.FLW (RV32) */
+                    xinsn = OPC_RISC_FLW;
+                    xinsn = SET_RD(xinsn, GET_C_RS2S(insn));
+                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
+                    xinsn = SET_I_IMM(xinsn, GET_C_LW_IMM(insn));
+                } else { /* C.LD (RV64/RV128) */
+                    xinsn = OPC_RISC_LD;
+                    xinsn = SET_RD(xinsn, GET_C_RS2S(insn));
+                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
+                    xinsn = SET_I_IMM(xinsn, GET_C_LD_IMM(insn));
+                }
+                break;
+            case OPC_RISC_C_FUNC_FSD_SQ:
+                if (xlen != 128) { /* C.FSD (RV32/64) */
+                    xinsn = OPC_RISC_FSD;
+                    xinsn = SET_RS2(xinsn, GET_C_RS2S(insn));
+                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
+                    xinsn = SET_S_IMM(xinsn, GET_C_SD_IMM(insn));
+                }
+                break;
+            case OPC_RISC_C_FUNC_SW: /* C.SW */
+                xinsn = OPC_RISC_SW;
+                xinsn = SET_RS2(xinsn, GET_C_RS2S(insn));
+                xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
+                xinsn = SET_S_IMM(xinsn, GET_C_SW_IMM(insn));
+                break;
+            case OPC_RISC_C_FUNC_FSW_SD:
+                if (xlen == 32) { /* C.FSW (RV32) */
+                    xinsn = OPC_RISC_FSW;
+                    xinsn = SET_RS2(xinsn, GET_C_RS2S(insn));
+                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
+                    xinsn = SET_S_IMM(xinsn, GET_C_SW_IMM(insn));
+                } else { /* C.SD (RV64/RV128) */
+                    xinsn = OPC_RISC_SD;
+                    xinsn = SET_RS2(xinsn, GET_C_RS2S(insn));
+                    xinsn = SET_RS1(xinsn, GET_C_RS1S(insn));
+                    xinsn = SET_S_IMM(xinsn, GET_C_SD_IMM(insn));
+                }
+                break;
+            default:
+                break;
+            }
+            break;
+        case OPC_RISC_C_OP_QUAD2: /* Quadrant 2 */
+            switch (GET_C_FUNC(insn)) {
+            case OPC_RISC_C_FUNC_FLDSP_LQSP:
+                if (xlen != 128) { /* C.FLDSP (RV32/64) */
+                    xinsn = OPC_RISC_FLD;
+                    xinsn = SET_RD(xinsn, GET_C_RD(insn));
+                    xinsn = SET_RS1(xinsn, 2);
+                    xinsn = SET_I_IMM(xinsn, GET_C_LDSP_IMM(insn));
+                }
+                break;
+            case OPC_RISC_C_FUNC_LWSP: /* C.LWSP */
+                xinsn = OPC_RISC_LW;
+                xinsn = SET_RD(xinsn, GET_C_RD(insn));
+                xinsn = SET_RS1(xinsn, 2);
+                xinsn = SET_I_IMM(xinsn, GET_C_LWSP_IMM(insn));
+                break;
+            case OPC_RISC_C_FUNC_FLWSP_LDSP:
+                if (xlen == 32) { /* C.FLWSP (RV32) */
+                    xinsn = OPC_RISC_FLW;
+                    xinsn = SET_RD(xinsn, GET_C_RD(insn));
+                    xinsn = SET_RS1(xinsn, 2);
+                    xinsn = SET_I_IMM(xinsn, GET_C_LWSP_IMM(insn));
+                } else { /* C.LDSP (RV64/RV128) */
+                    xinsn = OPC_RISC_LD;
+                    xinsn = SET_RD(xinsn, GET_C_RD(insn));
+                    xinsn = SET_RS1(xinsn, 2);
+                    xinsn = SET_I_IMM(xinsn, GET_C_LDSP_IMM(insn));
+                }
+                break;
+            case OPC_RISC_C_FUNC_FSDSP_SQSP:
+                if (xlen != 128) { /* C.FSDSP (RV32/64) */
+                    xinsn = OPC_RISC_FSD;
+                    xinsn = SET_RS2(xinsn, GET_C_RS2(insn));
+                    xinsn = SET_RS1(xinsn, 2);
+                    xinsn = SET_S_IMM(xinsn, GET_C_SDSP_IMM(insn));
+                }
+                break;
+            case OPC_RISC_C_FUNC_SWSP: /* C.SWSP */
+                xinsn = OPC_RISC_SW;
+                xinsn = SET_RS2(xinsn, GET_C_RS2(insn));
+                xinsn = SET_RS1(xinsn, 2);
+                xinsn = SET_S_IMM(xinsn, GET_C_SWSP_IMM(insn));
+                break;
+            case 7:
+                if (xlen == 32) { /* C.FSWSP (RV32) */
+                    xinsn = OPC_RISC_FSW;
+                    xinsn = SET_RS2(xinsn, GET_C_RS2(insn));
+                    xinsn = SET_RS1(xinsn, 2);
+                    xinsn = SET_S_IMM(xinsn, GET_C_SWSP_IMM(insn));
+                } else { /* C.SDSP (RV64/RV128) */
+                    xinsn = OPC_RISC_SD;
+                    xinsn = SET_RS2(xinsn, GET_C_RS2(insn));
+                    xinsn = SET_RS1(xinsn, 2);
+                    xinsn = SET_S_IMM(xinsn, GET_C_SDSP_IMM(insn));
+                }
+                break;
+            default:
+                break;
+            }
+            break;
+        default:
+            break;
+        }
+
+        /*
+         * Clear Bit1 of transformed instruction to indicate that
+         * original insruction was a 16bit instruction
+         */
+        xinsn &= ~((target_ulong)0x2);
+    } else {
+        /* No need to transform 32bit (or wider) instructions */
+        xinsn = insn;
+    }
+
+    return xinsn;
+}
+
 /*
  * Handle Traps
  *
@@ -842,6 +988,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
     target_ulong deleg = async ? env->mideleg : env->medeleg;
     target_ulong tval = 0;
+    target_ulong tinst = 0;
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
 
@@ -849,20 +996,31 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* set tval to badaddr for traps with address information */
         switch (cause) {
         case RISCV_EXCP_INST_GUEST_PAGE_FAULT:
-        case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
-        case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
             force_hs_execp = true;
             /* fallthrough */
         case RISCV_EXCP_INST_ADDR_MIS:
         case RISCV_EXCP_INST_ACCESS_FAULT:
+        case RISCV_EXCP_INST_PAGE_FAULT:
+            tval = env->badaddr;
+            break;
+        case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
+        case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
+            force_hs_execp = true;
+            /* fallthrough */
         case RISCV_EXCP_LOAD_ADDR_MIS:
         case RISCV_EXCP_STORE_AMO_ADDR_MIS:
         case RISCV_EXCP_LOAD_ACCESS_FAULT:
         case RISCV_EXCP_STORE_AMO_ACCESS_FAULT:
-        case RISCV_EXCP_INST_PAGE_FAULT:
         case RISCV_EXCP_LOAD_PAGE_FAULT:
         case RISCV_EXCP_STORE_PAGE_FAULT:
             tval = env->badaddr;
+            if (riscv_feature(env, RISCV_FEATURE_TINST)) {
+#if defined(TARGET_RISCV32)
+                tinst = riscv_transformed_insn(env, 32, env->trap_insn);
+#elif defined(TARGET_RISCV64)
+                tinst = riscv_transformed_insn(env, 64, env->trap_insn);
+#endif
+            }
             break;
         case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
         case RISCV_EXCP_ILLEGAL_INST:
@@ -955,6 +1113,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->sepc = env->pc;
         env->sbadaddr = tval;
         env->htval = htval;
+        env->htinst = tinst;
         env->pc = (env->stvec >> 2 << 2) +
             ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_S);
@@ -994,6 +1153,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->mepc = env->pc;
         env->mbadaddr = tval;
         env->mtval2 = mtval2;
+        env->mtinst = tinst;
         env->pc = (env->mtvec >> 2 << 2) +
             ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_M);
diff --git a/target/riscv/instmap.h b/target/riscv/instmap.h
index 40b6d2b64d..f4ee686c78 100644
--- a/target/riscv/instmap.h
+++ b/target/riscv/instmap.h
@@ -316,6 +316,12 @@ enum {
 #define GET_RS2(inst)  extract32(inst, 20, 5)
 #define GET_RD(inst)   extract32(inst, 7, 5)
 #define GET_IMM(inst)  sextract64(inst, 20, 12)
+#define SET_RS1(inst, val)  deposit32(inst, 15, 5, val)
+#define SET_RS2(inst, val)  deposit32(inst, 20, 5, val)
+#define SET_RD(inst, val)   deposit32(inst, 7, 5, val)
+#define SET_I_IMM(inst, val)  deposit32(inst, 20, 12, val)
+#define SET_S_IMM(inst, val)  \
+    deposit32(deposit32(inst, 7, 5, val), 25, 7, (val) >> 5)
 
 /* RVC decoding macros */
 #define GET_C_IMM(inst)             (extract32(inst, 2, 5) \
@@ -346,6 +352,8 @@ enum {
                                     | (extract32(inst, 5, 1) << 6))
 #define GET_C_LD_IMM(inst)          ((extract16(inst, 10, 3) << 3) \
                                     | (extract16(inst, 5, 2) << 6))
+#define GET_C_SW_IMM(inst)          GET_C_LW_IMM(inst)
+#define GET_C_SD_IMM(inst)          GET_C_LD_IMM(inst)
 #define GET_C_J_IMM(inst)           ((extract32(inst, 3, 3) << 1) \
                                     | (extract32(inst, 11, 1) << 4) \
                                     | (extract32(inst, 2, 1) << 5) \
@@ -366,4 +374,37 @@ enum {
 #define GET_C_RS1S(inst)            (8 + extract16(inst, 7, 3))
 #define GET_C_RS2S(inst)            (8 + extract16(inst, 2, 3))
 
+#define GET_C_FUNC(inst)           extract32(inst, 13, 3)
+#define GET_C_OP(inst)             extract32(inst, 0, 2)
+
+enum {
+    /* RVC Quadrants */
+    OPC_RISC_C_OP_QUAD0 = 0x0,
+    OPC_RISC_C_OP_QUAD1 = 0x1,
+    OPC_RISC_C_OP_QUAD2 = 0x2
+};
+
+enum {
+    /* RVC Quadrant 0 */
+    OPC_RISC_C_FUNC_ADDI4SPN = 0x0,
+    OPC_RISC_C_FUNC_FLD_LQ = 0x1,
+    OPC_RISC_C_FUNC_LW = 0x2,
+    OPC_RISC_C_FUNC_FLW_LD = 0x3,
+    OPC_RISC_C_FUNC_FSD_SQ = 0x5,
+    OPC_RISC_C_FUNC_SW = 0x6,
+    OPC_RISC_C_FUNC_FSW_SD = 0x7
+};
+
+enum {
+    /* RVC Quadrant 2 */
+    OPC_RISC_C_FUNC_SLLI_SLLI64 = 0x0,
+    OPC_RISC_C_FUNC_FLDSP_LQSP = 0x1,
+    OPC_RISC_C_FUNC_LWSP = 0x2,
+    OPC_RISC_C_FUNC_FLWSP_LDSP = 0x3,
+    OPC_RISC_C_FUNC_JR_MV_EBREAK_JALR_ADD = 0x4,
+    OPC_RISC_C_FUNC_FSDSP_SQSP = 0x5,
+    OPC_RISC_C_FUNC_SWSP = 0x6,
+    OPC_RISC_C_FUNC_FSWSP_SDSP = 0x7
+};
+
 #endif
-- 
2.25.1


