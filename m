Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F62BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C67D207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JeSSix/g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oYQ4yXJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C67D207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0kHX-0006TL-ET
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 07:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=47218c038=Anup.Patel@wdc.com>)
 id 1k0kGH-0005AJ-Im; Wed, 29 Jul 2020 07:28:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=47218c038=Anup.Patel@wdc.com>)
 id 1k0kGE-0001pU-Ed; Wed, 29 Jul 2020 07:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596022118; x=1627558118;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=O9q0lziQmErYW67NNpuYOugAfNuDIgqzBmwVWx4B+Oo=;
 b=JeSSix/gXNyDRawWevRB08jwjt6BDTyh6ectXsLzK7pdmxgYtwn5AdIG
 Cy58Xdn30ko0kskh+q1sH0xH19jv44w5fk4UkzHFn6Cjt0X6PWpcEuGNR
 BwF5dsnvXw6VKaC40/6kP5bnCMLLDeMNaILTWOAfc61KNluHNUrsrdHZE
 Q24VXf4RoOow+pyxdqzPCui3YttJL0h5AuL23KNNm6eG23kQTHLDqqXha
 XeJD0i3BZrsrmmmYYYbgCBki9bo8VUxhQ5aVoVcgOHx37z0fPanH9ptLW
 H2GRSxZqgsQQ5wZVne5gXw8u1CTAz1CJobtGZ1OvHxELGQ8tDpgGQCDCJ g==;
IronPort-SDR: P0F/atC95s201mSUoJJgSKtJH7lH7pJq/7treVUOPvpdMt4tuPhBm5UsM9nlw5Y7Gzltok4Fkm
 O3j+GZ1wuA2U6QXkuEzzhScT9CWJOUmFm46sHPg+Kbb8gWK/OqFKO6xZyz+bD7dnami+1j2o0S
 pVaPc+V5sOS+zB2++cLlUzMHpxRlPUWH8q7m/H8XxNw08/lNENIvymGL94eStlJ3a6TD0kIUqM
 I33OYumSshU8RCKIeZnXk6MffOBHIO1Exa22dZoZuSbmQPfdykxcosm60LCff2jE8OEIHQKSFT
 gY4=
X-IronPort-AV: E=Sophos;i="5.75,410,1589212800"; d="scan'208";a="143644185"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2020 19:28:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBi7CByvhmYXlHCgnA70/+fU3MQsnSi0qdiJclzUkuXCmvejPsMSBpcgGnz+MFZZDjI7VPgf8vZg2Gmf8wa7zFPHTDTHlRPAe4H2N3QsU+tkbx6GQEe229G5R32wirWtjP+BRDZD5q7PYq9WCNAwI03Ly0NEr6CPE76s8Hub2W48LBPpU2mj+CXWDpfXKo1QkMWDYpxcvJQqvOjkQverSOqMIzyrDYOiqqj/kSnaPVjhu4uSYHGUh4tTvWPF7xs/I51fyzw0ACJQ2vOuy2rcmi5MSA6Bhq0Jon2f0iIFmT9OPhcdJhowsYaLckjq7sl9UwBtWwIObI2axCOyxjD8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj6gqpC3nsGj1KbwccBpw/cmuIwLQCeyi0Jl+MGuCvQ=;
 b=N9a98Ci58em9qeWnJtRYLUkkRO0yTMpk52Qg/RUfbwe7T4awXP7nSpAkCqcUV7lOEefGHS5sz0NUbO0Q6uDxMxdOkNgTrC34i0QOHXZa0smTr9MDpEK9kja6UZ2urMrnhF35qDzAHPE6Pp94MAwQL5YlvzKjoQXEI/VWL03yugSAajEIXKZ3WqmIDEG4foUF2WzJsJJ5uSq336Zt5Yr10ddbL0YCwFstWV8BEDaMwzH5BjCYr0L3giWk+DusB6piGbXM72ygx7E3wRRO59vV16RSpPJXjc8LzvDTOZcl4NxFYUGYI50l65kxapzaK+wrTsOV5W1BvxZLtxUPTFxeRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj6gqpC3nsGj1KbwccBpw/cmuIwLQCeyi0Jl+MGuCvQ=;
 b=oYQ4yXJfSfgiT5+X6lTqrPsexNq6pb+v8qpqlZSuqYRxbwxpf3nUAVYmA7wYy269w3hCUL7+nfl2FcVPBwEO2TH5E5yRZEMbm8hXpdwWatKmc1hs541swUiSaS1u0BVCSWq22EMcF1Nwk0ThyWRNhnN0fbae0ItNqg68Hug/ylM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5753.namprd04.prod.outlook.com (2603:10b6:5:167::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 11:28:34 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 11:28:34 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 1/3] target/riscv: Optional feature to provide trapped
 instruction in CSRs
Date: Wed, 29 Jul 2020 16:57:59 +0530
Message-Id: <20200729112801.108985-2-anup.patel@wdc.com>
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
 15.20.3239.17 via Frontend Transport; Wed, 29 Jul 2020 11:28:30 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.56.183.175]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d466722-dda5-457f-182e-08d833b2875f
X-MS-TrafficTypeDiagnostic: DM6PR04MB5753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB57532DDFB7583E30E993CF218D700@DM6PR04MB5753.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gk5+275I2k9ITeJn/oMtfIk8+LS8MgObGtfTpcNhN+i47qjK1iVn37oJdWjaLK4HYDIuEECk9Suhl7/nMlW6ZpIeBOX9/YpCdgMQ+r9FbqPst6c8eV1W9kJwiVH7Bg/z8KXNhEXL2tP/iS7s+HNQjdOrjbfvgopCeWdEnRdfC8468UtIbKkAXtI+mT++LZkOIKmGWHLjQi8TSwyrafOfFvx0+oSQhVV2K5VJ6wEWuHg9BWBaZfTC2Ps6H5pxzY8TRH1kg2OOycOZm6bJl7mA2+M1pLy5D18uxMgdx3P/rOBUBYITGYqa9iLAVSQrjZU/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(4326008)(36756003)(956004)(2616005)(52116002)(8886007)(110136005)(2906002)(83380400001)(7696005)(55016002)(8676002)(44832011)(186003)(66946007)(316002)(26005)(54906003)(16526019)(8936002)(86362001)(66556008)(5660300002)(6666004)(1076003)(478600001)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tZPafMqQXMds8dyt1Gj/jmVtlua8L0bqlaxTC1/KOPTSK/dg2UYM+7/SZMvJg7uaJr/R+3twPey4J5ZivAsLVW0ETih/CQM8IVX+rqd1drEv/Wyzbx/XZgjDRsnlLqyg6qksGHFsKLJpenRko3c9c0uObjAIfMORcKxXIj+ZSYe+6mLPWyiyv+f3vprU9V0zmej+WqH4rQy4BEUg5E8BwacFDhtE4inkpckNE3C1n5wo0uiehTykNq05xIDwiS4mKZvW9VZ7a/aigR74nI7dItafrQ6uSz48YahNH8F0JDNKOGJVr86IbSIRPlWV7E5yTaDUjYUcJR7VPYCb6Gdw2aY0sFVXaftpbVsv3kFWdKWHAAcZZJBkRioD0Xn+vqfmyL2RlAOvtYxjso7x1lZGsS1AYkaBqwS88lieZey6HOUZyGG1mtuev9BPzcBncJSrgaOpAlwKjZhp9DbGGfeoSjmyKGYhMFFjlNLZo5brUFpHJg418+0I/4YYPOTSRyto
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d466722-dda5-457f-182e-08d833b2875f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 11:28:34.4224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVXsO8YCqSAkp/kAvJZUMNDr1wYjOD05YWdDs1ePTteo1wJQC5vWVA0ZlzQbSuUZuDOXh971VdeP2ESa9IaLQA==
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

The RISC-V spec allows implementations to provide trapped instruction
opcode in MTVAL/STVAL CSR for illegal/virtual instruction traps. This
is totally optional and most RISC-V implementations always set zero
in the MTVAL/STVAL CSR for illegal/virtual instruction traps.

When trapped instruction opcode is available in MTVAL/STVAL CSR, the
M-mode runtime firmware (and Hypervisors) can skip unprivlege access
for reading trapped instruction opcode which in-turn will speed-up
the illegal/virtual instruction trap handling.

This patch implements RISCV_FEATURE_TINST feature which when enabled
provides original trapped instruction opcode in MTVAL/STVAL CSRs for
illegal/virtual instruction trap.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 target/riscv/cpu.c        |  7 +++++++
 target/riscv/cpu.h        | 11 ++++++++++-
 target/riscv/cpu_helper.c |  6 ++++++
 target/riscv/translate.c  | 14 +++++++++++++-
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eeb91f8513..ec098e445e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -317,6 +317,7 @@ void restore_state_to_opc(CPURISCVState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
     env->pc = data[0];
+    env->trap_insn = data[1];
 }
 
 static void riscv_cpu_reset(DeviceState *dev)
@@ -332,6 +333,7 @@ static void riscv_cpu_reset(DeviceState *dev)
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     env->mcause = 0;
     env->pc = env->resetvec;
+    env->trap_insn = 0;
 #endif
     cs->exception_index = EXCP_NONE;
     env->load_res = -1;
@@ -387,6 +389,10 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         set_feature(env, RISCV_FEATURE_PMP);
     }
 
+    if (cpu->cfg.tinst) {
+        set_feature(env, RISCV_FEATURE_TINST);
+    }
+
     /* If misa isn't set (rv32 and rv64 machines) set it here */
     if (!env->misa) {
         /* Do some ISA extension error checking */
@@ -487,6 +493,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
+    DEFINE_PROP_BOOL("tinst", RISCVCPU, cfg.tinst, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1bb5271511..33984539d7 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -26,6 +26,12 @@
 
 #define TCG_GUEST_DEFAULT_MO 0
 
+/*
+ * RISC-V-specific extra insn start words:
+ * 1: Original instruction opcode
+ */
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
 #define TYPE_RISCV_CPU "riscv-cpu"
 
 #define RISCV_CPU_TYPE_SUFFIX "-" TYPE_RISCV_CPU
@@ -70,7 +76,8 @@
 enum {
     RISCV_FEATURE_MMU,
     RISCV_FEATURE_PMP,
-    RISCV_FEATURE_MISA
+    RISCV_FEATURE_MISA,
+    RISCV_FEATURE_TINST
 };
 
 #define PRIV_VERSION_1_10_0 0x00011000
@@ -97,6 +104,7 @@ struct CPURISCVState {
     target_ulong frm;
 
     target_ulong badaddr;
+    target_ulong trap_insn;
     target_ulong guest_phys_fault_addr;
 
     target_ulong priv_ver;
@@ -264,6 +272,7 @@ typedef struct RISCVCPU {
         char *user_spec;
         bool mmu;
         bool pmp;
+        bool tinst;
     } cfg;
 } RISCVCPU;
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index eccd80cfef..e4bd45d66a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -864,6 +864,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_STORE_PAGE_FAULT:
             tval = env->badaddr;
             break;
+        case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
+        case RISCV_EXCP_ILLEGAL_INST:
+            if (riscv_feature(env, RISCV_FEATURE_TINST)) {
+                tval = env->trap_insn;
+            }
+            break;
         default:
             break;
         }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1d973b62e9..03954bff62 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -56,6 +56,8 @@ typedef struct DisasContext {
        to reset this known value.  */
     int frm;
     bool ext_ifencei;
+    /* TCG op of the current insn_start.  */
+    TCGOp *insn_start;
 } DisasContext;
 
 #ifdef TARGET_RISCV64
@@ -717,6 +719,13 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode_insn16.inc.c"
 
+static inline void decode_save_opc(DisasContext *ctx, target_ulong opc)
+{
+    assert(ctx->insn_start != NULL);
+    tcg_set_insn_start_param(ctx->insn_start, 1, opc);
+    ctx->insn_start = NULL;
+}
+
 static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
 {
     /* check for compressed insn */
@@ -724,6 +733,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
         if (!has_ext(ctx, RVC)) {
             gen_exception_illegal(ctx);
         } else {
+            decode_save_opc(ctx, opcode);
             ctx->pc_succ_insn = ctx->base.pc_next + 2;
             if (!decode_insn16(ctx, opcode)) {
                 /* fall back to old decoder */
@@ -734,6 +744,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
         uint32_t opcode32 = opcode;
         opcode32 = deposit32(opcode32, 16, 16,
                              translator_lduw(env, ctx->base.pc_next + 2));
+        decode_save_opc(ctx, opcode32);
         ctx->pc_succ_insn = ctx->base.pc_next + 4;
         if (!decode_insn32(ctx, opcode32)) {
             gen_exception_illegal(ctx);
@@ -773,7 +784,8 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start(ctx->base.pc_next, 0);
+    ctx->insn_start = tcg_last_op();
 }
 
 static bool riscv_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
-- 
2.25.1


