Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE07C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF92C207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rYH3m99s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZOroaLT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF92C207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduxY-0003cq-2S
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jduuw-0007kf-96; Wed, 27 May 2020 08:12:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jduuu-0004C6-T2; Wed, 27 May 2020 08:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590581556; x=1622117556;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=fcl2/s4taLYbTTKslRBqqC8oTwWKwM22EGfD/3R2t9E=;
 b=rYH3m99snAo50+fHa0Cn6mYzAgzdZivI4sGTJ2w3E24DEBkP4GDAlxpm
 IAM7pXPqBRu2JQtcXYcMsCK8ioGrndU8KP5tKfsBD8uLFe9vOl4C9s2Dw
 mv8j61Hblq3IppTlT8NC7633LKG+iISnG7ona3Og3wfEnrnGLTsIYWbua
 5Omiz3EnAtIqWTiLX6YQyDigFugKjZo+PkfdIXd4YgqvY4z989L4gVr2k
 h8PE/XYjJAR8Au4F09sL5zM7TNJV5ReStof1PxiYLyNHxmjm6LDpB5lfa
 Aavw/E+cF2tZSCo2g/aCA6DyxXFWCkzh6NL31JzWpdURL25mKYVGlKndR Q==;
IronPort-SDR: QrNoyaQ39HDzPRGRlfmpxVs7o7Q0Y/bx/spbqYy1xovlDUdB9A4ksOjhXTxyzvXH3a3aHlPtPl
 KyhS6exuvtxsox7n7RVvsPFK2G+mF1C+q0nt+IwT0y/P0BITiks0Pfv4vHypD+VZYydKzc40Y1
 GRhuUMArPA7eOY1ijQSVv0zUYT2/fwhrRd/w0w56TRUYRfgd13z+lOeQCuuKphdfmPUOLxn+ZD
 oXZ2xLiHqGYk5KyhRxvMplVXJzOJSQBfjy7dmY+0p//a9BQaCDFbxxsxZNJ8p07PmqOgmSpb/R
 gRg=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; d="scan'208";a="241425845"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 20:12:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HssL3d/4ay3OvpUblHWelKZQ82XjLvuHclvk0e/7Knil2D+QwAJyHyRjT6F4mzixyzA1eihYERp/+ZAFHkodN7EoCC1Mfh+sVEZdPMYKDvNz2g4TtKK9EAqH/IKkSulXmNGVLG5Sr98vO21eMsKZeBj3hmGJ7i0PheRhyBSxoBccS5m+jVfM0UqbYZB4QE1LGaOh9QbCOH4KN1Zz0kwgLU+XshRCOvPT0rMPQmvdGnL3IXTBonPWCuSOqhbf3uXfWlsbQzzm6tX4uZXa6RLXln1No8eSOYe1EGy4HHedXq9kRCvoIxX8YiRM6fZ7b8f/Jtl/gnm/+lRMiGy7mZ/ADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSqZwf+oGC6GnqJHzn0BQlbEQMiydC/gkmw6w1nYSYI=;
 b=cKWVR2cPp05mAIPrhg/EOR1IoxkAkSlYAjOI7EOG40t/wYYytiWd0XnpiuFh5GcPmoHWUsqsd56DUIW1exESLDNfMl5RMQ5154Tk8lbn2ZL5jnVqvQHOg6P0/gq/fMI4DXrBF7L0BVXGW6E6sAfF90ZVWZ2FBurQIfvD7Hx19jZo3HS9lwhPMyvL2c36xsFGHwl2x4rWjVitLGHEe5THW3mk0bP8mhxofPy+D47pcNKySB8WlCspHx/QCUXHdBl+q0gC5omHdRlHmOGszfXqyU45l8CKzHtO0lwwgkiPyjsGlxbwSBIeasiLj27lnn+AqPQeieq7kLWV7Zwco/SLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSqZwf+oGC6GnqJHzn0BQlbEQMiydC/gkmw6w1nYSYI=;
 b=ZOroaLT+mYIJ5sHZKnyaMi8zr3oAi1fErtjM8z3Z/R1nJVJzt3F8D5kJFsYuovdvf1pmgg6zl9U0XUWDawOqUZg393dKUSUTxQqG1UwVGbMeiHfYcbPwsFzS2Q6L5MI/EF41/pmERzsO3XSAFhMRCKW/fmZrZh9Cq2yZB37UNag=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4473.namprd04.prod.outlook.com (2603:10b6:5:2e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 12:12:13 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.030; Wed, 27 May 2020
 12:12:13 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 3/4] hw/riscv: Allow creating multiple instances of PLIC
Date: Wed, 27 May 2020 17:41:30 +0530
Message-Id: <20200527121131.251007-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200527121131.251007-1-anup.patel@wdc.com>
References: <20200527121131.251007-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::27) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.5) by
 MA1PR0101CA0065.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend
 Transport; Wed, 27 May 2020 12:12:10 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4e65185-a427-47f9-7c88-08d8023730b2
X-MS-TrafficTypeDiagnostic: DM6PR04MB4473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB44735CB5E2915D3799C546F18DB10@DM6PR04MB4473.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3CdPZA7BiiGbnGrT6BrG3mU5LqWyGpIvV+HJynNSW6Fo9QKtTuxcAo3MsjeKJn8AXRfIP9eGNwwR1Jw1KoDWRxrg8AnkMD3SWtHGU8BVBIvv7zwnHHDxAFjHJnW8PFQnu8dFQ2Fp8ixNYEvU3/mZsSZyrhPoGwuB0pSfWZCk4KiSuB/m0AcaLPpGVSIg54KOF24LWgn4NJfYiSyExLyswwXHlERyh+N+320VxVDbNCFrpjt4fdhQ1B6e0t96uy5H1SCLVdA8eSAYwoT3DAPi+E9deCk5XySbeSKA//ZUB6Qn8/lK4qXEKHiQlK/kSVWA/w1U4JzVb7SgQytaceBvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(83380400001)(36756003)(5660300002)(55236004)(44832011)(1006002)(16526019)(6666004)(186003)(66946007)(8886007)(316002)(2616005)(110136005)(54906003)(52116002)(7696005)(66476007)(66556008)(86362001)(956004)(2906002)(1076003)(55016002)(8676002)(8936002)(478600001)(26005)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6Fx2+ZrHhuUHLVZdbSOZTRZjqC7SlMZX1nCxUIGska1cihNiAvWy9yPNF+tKlUF0FR8nU4pWtmIrUb0Gd3EajF6dUsCdMGg+9isiRRTCwD1PQnQ+1ZpSevtaeY/gDWZHDI2F/6nKzI3ttdZ8d7mvSqEOdc7CDRv0ClliCZFDfV+DrefCBmeYfnsMiPLKMgpMhY/rxbMnsre71VBGK2/Ux6FO2LsJcu+ZqZgV1CPZkSc1BFnshU4SOn8lyGkAsv3Qqojbub7M5rnhvksPTy6fTIsGUxdx0CyxykAVKsnHn5ilZyyRaWcwzwMPDd5cFje8KKFzSAAbTGyRBHNswC5d5oOvGWh8TCtRNnsQBwuGLEvH87uG1sJ4xzKW4dhfx1mySLChXvM3jrbgJStbA7o9JbvV0BEBy3yGOv0HDORqR+f9+Cbauvt+L+1xD6nFy4h7l6tVxaqzuejwVTRrCqjUKnDUyjAclQ81nY84c+fAwjc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e65185-a427-47f9-7c88-08d8023730b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 12:12:13.8144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: key3Ow76DUA9s0z15pBbroXhsRUg1vPuuiOMGYWn/N2zYtPo4W2pksH7AmpP3wUmnf1WppjlWdQ2R4fnJdYvbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4473
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=409226bd6=Anup.Patel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 06:55:51
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


