Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64748C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B9E020721
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gk7jU89R";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ovfAwnLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B9E020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIg0-0004GH-An
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=41059f22b=Anup.Patel@wdc.com>)
 id 1jeIcP-0007hx-1V; Thu, 28 May 2020 09:30:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=41059f22b=Anup.Patel@wdc.com>)
 id 1jeIcK-0001G2-Lj; Thu, 28 May 2020 09:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590672641; x=1622208641;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=fcl2/s4taLYbTTKslRBqqC8oTwWKwM22EGfD/3R2t9E=;
 b=gk7jU89RiCPBfXACucqn8KO/xzeNuuCuZ9QyiUyFVZ8WQB9do85SSEDm
 g913n7WWbKSao6cs5A87keT5eNhrE8RfaSGoWjYjGsTnu+RIUzGjZAGuI
 LkM6Kn/aXqdCoLYquD54ALDpPlDBlElFtj7hpcLLMSBFOm21Du+g8jRna
 rvT4xjUFRTAR1E9t1ybVAUFe8iAXJLdQSwWVxQZloKHEdKu/jgOouRnco
 g5yf2AGUveeN8tQ63xQw2bxfwGg90AwY5zwa/p5VGZ46O/9DHLnOjvk+c
 iLDe0N0iJlLDX+qfsqEIS/mikzz+c5PtsCxUa9rkNJQu0RgqsX7q0C9wx g==;
IronPort-SDR: wep/JWX9WjFsMjPBS7xrFTy9a/WD1LqUfINHgfn7LoRSx/SEjKQ4yROrB10VAt9cbT0IKkkGz/
 +2sc+akEsPQVT5D2jx8NFvMO6t+SN9XOz4yBvMd2x8BXAM8R7WJhh1Nj2XNmSzZs5WUlp/v/IK
 zQMRbFjW8H96d81WHNFAtATEJybascK+RkPPOEa7zc1EpW1spRHFQDK+EHu1YC8isU7XuevjHp
 TJreLpxY+EH2dJHn4V9RvxH7sa+b6WWjnG6zfKt3+xYfwni9tAZU7cH71Bgf8M6SM5XpYvqPho
 nI4=
X-IronPort-AV: E=Sophos;i="5.73,444,1583164800"; d="scan'208";a="143036566"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 21:30:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3Vn2MfrESTEq6mrwtVxkXFCaItPCXlvMTEJj6/+bX8xzfGqybzGJoV45+NWHsRoUJFsGEFdNWRCvNfK3Pg7fPtVCgZ5IaoLx/lwBlyF137eHTKbcEzREfpyhp0QST1/I2XPoj3sjp9RJhfnjDIVpEIH6u0ZfoCMLcmWGaWoM3INh9lT038oPLUeBi2B3Lo+qOWntrc4NACz1iJ76W7hKEQ1WrlFTUqjxOK7KTod1gNq+XYWwC8W3CZQ3xZt+sMcoKkDAMkY0K/uzLTtUowWHutKlH+SCRbHAX8dtjRmQ2BfPt+806oUkhBMDMG6Cu2pnZ5OsFx2xmXq1Rs522Odeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSqZwf+oGC6GnqJHzn0BQlbEQMiydC/gkmw6w1nYSYI=;
 b=RYapNSoB+cVEs+ZORU7gO94mf3Uo6X42wPxATIIUVm9xBJQmozVpaCAs15O/2e/rCsbo1i8jnl2cCABdaYFsWlFM0tphak0Yy1pa4BEQDfHCDOUAo4ztSv12TJjjGlwDL2AItTG+XzzTOQl1tseaakKo/5bGzMCoqC/KIBkrjW3GirFiLN0tKnUPvzqjvI7GuMTZE6k0NLIcC1izsk8ZJj8mvQRJVFh+KX+LdoirBF/L3rZQWOmXViM+Bp2tIlnMhUywrFdFzmIybqwL/Ry5fjbhaqqhr1ZkpuesWlF0HJcH9FgvnowA5oL1uINodFjsxEj129Nt4gvob1eSJc8h7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSqZwf+oGC6GnqJHzn0BQlbEQMiydC/gkmw6w1nYSYI=;
 b=ovfAwnLpmoYFQmHTgZKT1KoY4ocJjfbI7eOk0ku885zJB2kSoTXWvqCkWXbq8POo4G2Rwlye/nYLAbsSAjkpR3twFvQ3KI75/RgctrJtHGzSVjmA4iA0p3Rz3rE7oDKXMDRXGb1qrnFEujpbppmdWj0zopLCA7I/u5Nd8mHMopE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6204.namprd04.prod.outlook.com (2603:10b6:5:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 13:30:36 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 13:30:36 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v4 3/4] hw/riscv: Allow creating multiple instances of PLIC
Date: Thu, 28 May 2020 18:59:58 +0530
Message-Id: <20200528132959.47773-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528132959.47773-1-anup.patel@wdc.com>
References: <20200528132959.47773-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::36) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.63.107) by
 MAXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Thu, 28 May 2020 13:30:33 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.63.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a774c4b1-f8d4-4fe4-c96e-08d8030b4e24
X-MS-TrafficTypeDiagnostic: DM6PR04MB6204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB62047B1E60A5BCEE2CE9BC918D8E0@DM6PR04MB6204.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AhqRxEIovqZ6/mh8Dqm5dbTHCp+eA8L96157C91MGqXtawpKbMHqZv70kGGzBS7eIYUnnVsJovAE/cTDk2pN8bNbjvzg+zhu1t81s8YSiNZUttXwAmicmckWGmePHMQ4QvgfnQtJa60uAY9Xhr/+k09Bne3Pe2CsaK/Gc+tBiX6WR0TC32jEre0pmZqTlfCa72exR6eqIQ1DyPXYXZIvCEGXzatnO6WNPuzYiPNEupGpXbWUqH36sE4aeL+dFepCLnFVVekfCQHZCBEv+kHSkZO2kWxxyqDY/MdE6ZHvZNsAiU9vY7+Lft+kNAGfE9Wzkne1gllF4V5E78TcZkVfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(956004)(26005)(55016002)(44832011)(478600001)(55236004)(2616005)(5660300002)(7696005)(16526019)(52116002)(186003)(8936002)(8676002)(1076003)(86362001)(8886007)(66556008)(66946007)(66476007)(316002)(83380400001)(4326008)(54906003)(110136005)(36756003)(6666004)(1006002)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: H5pYC+A0zmO+fYeNJUUjir39OguHKpqkvLHbzBWjeQFAohbxXVleix1YibWDZDE9wdIA6d4rMOiRLd4mtHkwtwGPmkU+slnmUO4GB7zLQ6XIml6/DrNtbEcmO2Y2mP5RrGv/zuooTXo8YSiC1JrNZh/wN41DRO14cI46qcST/YTxrE1M+YMQ0DXl4LFVBrFFbuzP2Gr/d3gF1wmMoAf2VL0xW+hHm9O1EjRuWTz5vQXoTfFunLOtYUH55ysjJFJfY4ikyX9D7yF+BwTxgtBSAQXQZoNv6GMoBNfB+LjhEsWgkJ2EePzZ1AvlojbF5Oe47Y8JDSxjv6Bcyyedh+ZiBw2Sb4722elf93FUq8NRMeDRE9/lqhjEFWUIyNyBYlfNbEfE00ewQh4FPMP6o0PzIc5rjsOts82u/Qkj1U7dxV1VG1ugLkoSLWVwXFT30p5t0+iPPOOqtoxgcZ2i/xKO4OouiI+5kMghNZeUhRus6U0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a774c4b1-f8d4-4fe4-c96e-08d8030b4e24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 13:30:36.5771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DNEfbXCDcQWFDGUxA7Cz4LutU4Re3Qc48hV5epqQKpxTSyd4auua1C6GTvRi1+9S8m+L9VXByeXpg/vMr8xgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6204
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=41059f22b=Anup.Patel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 09:30:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Anup Patel <anup.patel@wdc.com>, qemu-riscv@nongnu.org,
 Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmerdabbelt@google.com>,
 qemu-devel@nongnu.org, Atish Patra <atish.patra@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We extend PLIC emulation to allow multiple instances of PLIC in
a QEMU RISC-V machine. To achieve this, we remove first HART id
zero assumption from PLIC emulation.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c            |  2 +-
 hw/riscv/sifive_plic.c         | 24 +++++++++++++-----------
 hw/riscv/sifive_u.c            |  2 +-
 hw/riscv/virt.c                |  2 +-
 include/hw/riscv/sifive_plic.h | 12 +++++++-----
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 1c3b37d0ba..bd122e71ae 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -152,7 +152,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
-        (char *)SIFIVE_E_PLIC_HART_CONFIG,
+        (char *)SIFIVE_E_PLIC_HART_CONFIG, 0,
         SIFIVE_E_PLIC_NUM_SOURCES,
         SIFIVE_E_PLIC_NUM_PRIORITIES,
         SIFIVE_E_PLIC_PRIORITY_BASE,
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index c1e04cbb98..f88bb48053 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -352,6 +352,7 @@ static const MemoryRegionOps sifive_plic_ops = {
 
 static Property sifive_plic_properties[] = {
     DEFINE_PROP_STRING("hart-config", SiFivePLICState, hart_config),
+    DEFINE_PROP_UINT32("hartid-base", SiFivePLICState, hartid_base, 0),
     DEFINE_PROP_UINT32("num-sources", SiFivePLICState, num_sources, 0),
     DEFINE_PROP_UINT32("num-priorities", SiFivePLICState, num_priorities, 0),
     DEFINE_PROP_UINT32("priority-base", SiFivePLICState, priority_base, 0),
@@ -400,10 +401,12 @@ static void parse_hart_config(SiFivePLICState *plic)
     }
     hartid++;
 
-    /* store hart/mode combinations */
     plic->num_addrs = addrid;
+    plic->num_harts = hartid;
+
+    /* store hart/mode combinations */
     plic->addr_config = g_new(PLICAddr, plic->num_addrs);
-    addrid = 0, hartid = 0;
+    addrid = 0, hartid = plic->hartid_base;
     p = plic->hart_config;
     while ((c = *p++)) {
         if (c == ',') {
@@ -429,8 +432,6 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
-    unsigned int smp_cpus = ms->smp.cpus;
     SiFivePLICState *plic = SIFIVE_PLIC(dev);
     int i;
 
@@ -451,8 +452,8 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
      * lost a interrupt in the case a PLIC is attached. The SEIP bit must be
      * hardware controlled when a PLIC is attached.
      */
-    for (i = 0; i < smp_cpus; i++) {
-        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(i));
+    for (i = 0; i < plic->num_harts; i++) {
+        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(plic->hartid_base + i));
         if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
             error_report("SEIP already claimed");
             exit(1);
@@ -488,16 +489,17 @@ type_init(sifive_plic_register_types)
  * Create PLIC device.
  */
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
-    uint32_t num_sources, uint32_t num_priorities,
-    uint32_t priority_base, uint32_t pending_base,
-    uint32_t enable_base, uint32_t enable_stride,
-    uint32_t context_base, uint32_t context_stride,
-    uint32_t aperture_size)
+    uint32_t hartid_base, uint32_t num_sources,
+    uint32_t num_priorities, uint32_t priority_base,
+    uint32_t pending_base, uint32_t enable_base,
+    uint32_t enable_stride, uint32_t context_base,
+    uint32_t context_stride, uint32_t aperture_size)
 {
     DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_PLIC);
     assert(enable_stride == (enable_stride & -enable_stride));
     assert(context_stride == (context_stride & -context_stride));
     qdev_prop_set_string(dev, "hart-config", hart_config);
+    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
     qdev_prop_set_uint32(dev, "num-sources", num_sources);
     qdev_prop_set_uint32(dev, "num-priorities", num_priorities);
     qdev_prop_set_uint32(dev, "priority-base", priority_base);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c193761916..53e48e2ff5 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -586,7 +586,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
-        plic_hart_config,
+        plic_hart_config, 0,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
         SIFIVE_U_PLIC_PRIORITY_BASE,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 51afe7e23b..421815081d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -584,7 +584,7 @@ static void riscv_virt_board_init(MachineState *machine)
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[VIRT_PLIC].base,
-        plic_hart_config,
+        plic_hart_config, 0,
         VIRT_PLIC_NUM_SOURCES,
         VIRT_PLIC_NUM_PRIORITIES,
         VIRT_PLIC_PRIORITY_BASE,
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index 4421e81249..ace76d0f1b 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -48,6 +48,7 @@ typedef struct SiFivePLICState {
     /*< public >*/
     MemoryRegion mmio;
     uint32_t num_addrs;
+    uint32_t num_harts;
     uint32_t bitfield_words;
     PLICAddr *addr_config;
     uint32_t *source_priority;
@@ -58,6 +59,7 @@ typedef struct SiFivePLICState {
 
     /* config */
     char *hart_config;
+    uint32_t hartid_base;
     uint32_t num_sources;
     uint32_t num_priorities;
     uint32_t priority_base;
@@ -70,10 +72,10 @@ typedef struct SiFivePLICState {
 } SiFivePLICState;
 
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
-    uint32_t num_sources, uint32_t num_priorities,
-    uint32_t priority_base, uint32_t pending_base,
-    uint32_t enable_base, uint32_t enable_stride,
-    uint32_t context_base, uint32_t context_stride,
-    uint32_t aperture_size);
+    uint32_t hartid_base, uint32_t num_sources,
+    uint32_t num_priorities, uint32_t priority_base,
+    uint32_t pending_base, uint32_t enable_base,
+    uint32_t enable_stride, uint32_t context_base,
+    uint32_t context_stride, uint32_t aperture_size);
 
 #endif
-- 
2.25.1


