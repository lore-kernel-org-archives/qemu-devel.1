Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81A5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F46207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hb51fB4g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NshSjaVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F46207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIhA-0005RP-JC
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=41059f22b=Anup.Patel@wdc.com>)
 id 1jeIcU-0007ob-5q; Thu, 28 May 2020 09:30:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=41059f22b=Anup.Patel@wdc.com>)
 id 1jeIcP-0001OZ-7Q; Thu, 28 May 2020 09:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590672647; x=1622208647;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ukJUlNUWRS69earel4LLjUfXHN8vYo8n1fNX0O3nFGs=;
 b=Hb51fB4gBRSgJhIWEf9QfncoTp1bK+MdT5yvBTEyzahcJNAo3w0JvUF4
 CwzpJUskVKwisT5larj9nG2oKvBvh9fDaAAH/bWO95BadEGNdG1NOizsv
 OXjz93FYTVsY3UGNCcq32H2CGuYW+/TBVj/XvP8rhNo4NtLJhDnQgSKFF
 oy8kuUdg0BarEP0GJLCRg3LkvMvbVEB2PeLQR4onrrh2VB66/uOk/Qktk
 IfYK8O9XnDiRp8JYXBeqDb932GSCyisSrXIXD5mUrqem0lVHV8YWW+xgV
 40Sa2gZS8KW0BfWTWfeqa7ky79RfyrQLcZgb8er+2VQMUlfrWcXfPh0Sg w==;
IronPort-SDR: qKgWzuUkveUfSAy3VcWJmSqHuFhDOFCS5jLStUywD/ZCyi9UVlP4XvPmr1mSoLq9KjLBwmyzMl
 VudVRfh0xYF6PymdMKuuAij1LQFG87LuL0AZpdyW8wCdfGG9sEnr9u2wGLtd7RM/X584nsOZOV
 zMkYPF2wx3ZdH+/FFVW6NH2oMPOkTu8aeMQV4TeSYL5AZTXOlcDDc23a2cvxsO2A6/lnyNB0Wd
 ZqWzq0l5ZbAfuipSN/zEchnVJyHkTQUFZA6/dl46dQAU+Gbo2/efHj5XiqJELXS20H0x4s8Edo
 Hxc=
X-IronPort-AV: E=Sophos;i="5.73,444,1583164800"; d="scan'208";a="241528825"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 21:31:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ip6ccj3Vy6bo+b8ewcb839tEU6dP5eLBtPDszx19UfgccG76abJJXG7E5uTlojQ0Q4DYKMzb8XTIOKVWZUOgiKwfpVXQHIozVyxe49TQclcydXE6c90Tm5QcBJg/hDyjISpmSDxLnbvhpE+uvrknZbKxsbioDVGj73Edt3uc6hf48h/S7sY+6VFcuW6JkamfUqUHLpajJrBb2P9hsVaRNIIpVW8xpBxFoxU4Me8jYEuyLeW7inBfnqIOgYOWHujZFmRuU9kStZzhXeaTVZ0wsxwYiHrnsVGLJ+fDJvcp1Di+Y/hw7H71NswxSDrRW8WWqr3xKtUNzbqz+EyYsQRwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXvM8wM0A7M64eNgAmUAqC9I6Vn+xIzT3t15B/7lntA=;
 b=PlJTyDHNC7q+I5g8wSO3kflOuNr/I8lyofM0hpENCKzPcqRazL5HZ7waaNiUUDSm6P/4LRZaf/FmH6Oh7V1A3LkVRw/dC3mWfT7WO6cwQjdGhEwweHFrKxwJx2ed7BJIw8wu428aVbPBbvl7bYKh7lJNOCskhJoecUclcXkGjwVMbH1ON5pzAkad3W9P6zIqkUIN7EEw50u/47PGRc8cYyv9MbE4Iv5inD+sXs3c9xrSxfYD367QGxogm2ySKaK0CtsCZHHbZxkZ3pkSLceI1GJoQVhk/N2690vY0uMQG6fEp9xPnrdzEmHjc0EiXbqy0ahCpkjPs0UUYeGovpn6eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXvM8wM0A7M64eNgAmUAqC9I6Vn+xIzT3t15B/7lntA=;
 b=NshSjaVjHqzIACI0nth9JqlzMUGY5t6C7aVeg0SxJj0cijckJnojupCF3aKX9C6gX0onbyP3CSE05WOMm9zWkmXtq28Qd5OUX9xzCzk3LP7soPG2fTLhzAA1eVZutYX2XUM20wRf5Qq9lBlsdZnmNRlllpuSNwbdkLizJNQc3qs=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6204.namprd04.prod.outlook.com (2603:10b6:5:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 13:30:40 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 13:30:40 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v4 4/4] hw/riscv: virt: Allow creating multiple NUMA sockets
Date: Thu, 28 May 2020 18:59:59 +0530
Message-Id: <20200528132959.47773-5-anup.patel@wdc.com>
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
 15.20.3045.18 via Frontend Transport; Thu, 28 May 2020 13:30:37 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.63.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a99bae2f-b5b3-4960-462d-08d8030b5022
X-MS-TrafficTypeDiagnostic: DM6PR04MB6204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6204B2B5F80328FC5DF397898D8E0@DM6PR04MB6204.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:152;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LObUFWJaEGX4S2xMrq97pGXy1mEnSNPrdGlNYPLXh3ZtPpBPqE9/ab3zUO8Kxh1cvSPj03u9pBRXAZ3NntXpcz5FzGe/5Qgq4Zlj9iO5Fmyt+j0cGr0etXgyK/t5UUbiiDQYIFmAtglQ6/PRkcssabG/emoQBMMW0kpRPFUogWj/e3gDUb3q9oUD2bQLJXoN1i0/tK+1Edpvee7LDv83QdgAKsL40gKNp0t9q2cF+xRH8SxTwWgbn8YyRuDD4WeVf6z1xQjpITnII/JT6X3fWQoo9KaQT8Fs/4HZkYx+HVgWh1wlb+vCLFdKG028WJCt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(956004)(26005)(55016002)(44832011)(478600001)(55236004)(2616005)(5660300002)(7696005)(16526019)(52116002)(186003)(8936002)(30864003)(8676002)(1076003)(86362001)(8886007)(66556008)(66946007)(66476007)(316002)(83380400001)(4326008)(54906003)(110136005)(36756003)(6666004)(1006002)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ud9KJ3Q8IWwn9u4Mt9H8L/gdd398EcVyvEqKRWU7kMYOKfubV+t3VUAVGStEHxNqApV5g+AXwo/FfvSCKD1FWctQe6rNUOtYqHKvgkFSRyyfo7IzWmV5unAIU5MXTkXvz7WDga34nln9AvxM+kxEa4Y5eBqO26uAWpfzCIQ1N5f9CN9d1qd8xFvFM+n02j0iKKPqdesbwpkOjhoEsBNYaDk/5TdkCwj9Gfe8FET5omcivKD6AOhfoXNzNIjqcep+OKppXluNuchUA792vScezJ46mpFYbmtsnAeZayEtK027Gwe87Q/52n/onm2wJ95z7eLoaakk+l2TK3jTBMY8epqahRQOdCnOXw9P7JT5mbH2cKMkPzW9xzESEkU6VEnR6j/RCNGz7b3Q7pvb0RsYP9b4vsECV4L2wNM141jSexQEOj3BjUdN2UfEsihuuqyJVgGfT97FcxE5oECbmyN6g2BQ5/NrwL0U2jvIkaRCKRA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99bae2f-b5b3-4960-462d-08d8030b5022
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 13:30:39.9660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiyui3ooBjdu5BwInkQ2jcqAqez0ys1NGLLHuOVBxY2O3kM1NnUyO2C9Y7hYnkKubRWz8fTJ9cXfrS3fTr1PhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6204
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=41059f22b=Anup.Patel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 09:30:42
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We extend RISC-V virt machine to allow creating a multi-socket machine.
Each RISC-V virt machine socket is a NUMA node having a set of HARTs,
a memory instance, a CLINT instance, and a PLIC instance. Other devices
are shared between all RISC-V virt machine sockets. We also update the
generated device tree accordingly.

By default, NUMA multi-socket support is disabled for RISC-V virt
machine. To enable it, users can use "-numa" command-line options
of QEMU.

Example1: For two NUMA nodes with 4 CPUs each, append following
to command-line options: "-smp 8 -numa node -numa node"

Example2: For two NUMA nodes with 3 and 5 CPUs, append following
to command-line options: "-smp 8 -numa node,cpus=0-2 -numa node,3-7"

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/virt.c         | 634 +++++++++++++++++++++++++---------------
 include/hw/riscv/virt.h |  13 +-
 2 files changed, 408 insertions(+), 239 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 421815081d..18af426be3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -60,7 +60,7 @@ static const struct MemmapEntry {
     [VIRT_TEST] =        {   0x100000,        0x1000 },
     [VIRT_RTC] =         {   0x101000,        0x1000 },
     [VIRT_CLINT] =       {  0x2000000,       0x10000 },
-    [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
+    [VIRT_PLIC] =        {  0xc000000, VIRT_PLIC_SIZE(VIRT_CPUS_MAX * 2) },
     [VIRT_UART0] =       { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
     [VIRT_FLASH] =       { 0x20000000,     0x4000000 },
@@ -182,10 +182,17 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
-    int cpu, i;
-    uint32_t *cells;
-    char *nodename;
-    uint32_t plic_phandle, test_phandle, phandle = 1;
+    int i, j, idx, cpu, socket;
+    MachineState *mc = MACHINE(s);
+    uint32_t dist_matrix_size;
+    uint32_t *clint_cells, *plic_cells, *dist_matrix;
+    unsigned long clint_addr, plic_addr;
+    uint32_t plic_phandle[MAX_NODES];
+    uint32_t cpu_phandle, intc_phandle, test_phandle;
+    uint32_t phandle = 1, plic_mmio_phandle = 1;
+    uint32_t plic_pcie_phandle = 1, plic_virtio_phandle = 1;
+    char *mem_name, *cpu_name, *core_name, *intc_name;
+    char *name, *clint_name, *plic_name, *clust_name;
     hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
 
@@ -206,231 +213,267 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-    nodename = g_strdup_printf("/memory@%lx",
-        (long)memmap[VIRT_DRAM].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        memmap[VIRT_DRAM].base >> 32, memmap[VIRT_DRAM].base,
-        mem_size >> 32, mem_size);
-    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-    g_free(nodename);
-
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
                           SIFIVE_CLINT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
+    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
+
+    for (socket = (s->num_socs - 1); socket >= 0; socket--) {
+        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
+        qemu_fdt_add_subnode(fdt, clust_name);
+
+        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
+        clint_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
 
-    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
-        int cpu_phandle = phandle++;
-        int intc_phandle;
-        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
-        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        char *isa = riscv_isa_string(&s->soc.harts[cpu]);
-        qemu_fdt_add_subnode(fdt, nodename);
+        for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
+            cpu_phandle = phandle++;
+
+            cpu_name = g_strdup_printf("/cpus/cpu@%d",
+                s->soc[socket].hartid_base + cpu);
+            qemu_fdt_add_subnode(fdt, cpu_name);
 #if defined(TARGET_RISCV32)
-        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv32");
+            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv32");
 #else
-        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
 #endif
-        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
-        qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
-        qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
-        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
-        qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
-        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
-        intc_phandle = phandle++;
-        qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandle);
-        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
-        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
-        g_free(isa);
-        g_free(intc);
-        g_free(nodename);
-    }
+            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
+            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
+            g_free(name);
+            qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
+            qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
+            qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
+                s->soc[socket].hartid_base + cpu);
+            qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
+            if (s->numa_enabled) {
+                qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket);
+            }
+            qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
+
+            intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
+            qemu_fdt_add_subnode(fdt, intc_name);
+            intc_phandle = phandle++;
+            qemu_fdt_setprop_cell(fdt, intc_name, "phandle", intc_phandle);
+            qemu_fdt_setprop_string(fdt, intc_name, "compatible",
+                "riscv,cpu-intc");
+            qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NULL, 0);
+            qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1);
+
+            clint_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+            clint_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
+            clint_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
+            clint_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
+
+            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
+            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
+            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
+
+            core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
+            qemu_fdt_add_subnode(fdt, core_name);
+            qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+
+            g_free(core_name);
+            g_free(intc_name);
+            g_free(cpu_name);
+        }
 
-    /* Add cpu-topology node */
-    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
-    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map/cluster0");
-    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
-        char *core_nodename = g_strdup_printf("/cpus/cpu-map/cluster0/core%d",
-                                              cpu);
-        char *cpu_nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
-        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, cpu_nodename);
-        qemu_fdt_add_subnode(fdt, core_nodename);
-        qemu_fdt_setprop_cell(fdt, core_nodename, "cpu", intc_phandle);
-        g_free(core_nodename);
-        g_free(cpu_nodename);
+        mem_name = g_strdup_printf("/memory@%lx",
+            (long)memmap[VIRT_DRAM].base + s->mem_offset[socket]);
+        qemu_fdt_add_subnode(fdt, mem_name);
+        qemu_fdt_setprop_cells(fdt, mem_name, "reg",
+            (memmap[VIRT_DRAM].base + s->mem_offset[socket]) >> 32,
+            memmap[VIRT_DRAM].base + s->mem_offset[socket],
+            s->mem_size[socket] >> 32, s->mem_size[socket]);
+        qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
+        if (s->numa_enabled) {
+            qemu_fdt_setprop_cell(fdt, mem_name, "numa-node-id", socket);
+        }
+        g_free(mem_name);
+
+        clint_addr = memmap[VIRT_CLINT].base +
+            (memmap[VIRT_CLINT].size * socket);
+        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
+        qemu_fdt_add_subnode(fdt, clint_name);
+        qemu_fdt_setprop_string(fdt, clint_name, "compatible", "riscv,clint0");
+        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
+            0x0, clint_addr, 0x0, memmap[VIRT_CLINT].size);
+        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
+            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
+        if (s->numa_enabled) {
+            qemu_fdt_setprop_cell(fdt, clint_name, "numa-node-id", socket);
+        }
+        g_free(clint_name);
+
+        plic_phandle[socket] = phandle++;
+        plic_addr = memmap[VIRT_PLIC].base + (memmap[VIRT_PLIC].size * socket);
+        plic_name = g_strdup_printf("/soc/plic@%lx", plic_addr);
+        qemu_fdt_add_subnode(fdt, plic_name);
+        qemu_fdt_setprop_cell(fdt, plic_name,
+            "#address-cells", FDT_PLIC_ADDR_CELLS);
+        qemu_fdt_setprop_cell(fdt, plic_name,
+            "#interrupt-cells", FDT_PLIC_INT_CELLS);
+        qemu_fdt_setprop_string(fdt, plic_name, "compatible", "riscv,plic0");
+        qemu_fdt_setprop(fdt, plic_name, "interrupt-controller", NULL, 0);
+        qemu_fdt_setprop(fdt, plic_name, "interrupts-extended",
+            plic_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
+        qemu_fdt_setprop_cells(fdt, plic_name, "reg",
+            0x0, plic_addr, 0x0, memmap[VIRT_PLIC].size);
+        qemu_fdt_setprop_cell(fdt, plic_name, "riscv,ndev", VIRTIO_NDEV);
+        if (s->numa_enabled) {
+            qemu_fdt_setprop_cell(fdt, plic_name, "numa-node-id", socket);
+        }
+        qemu_fdt_setprop_cell(fdt, plic_name, "phandle", plic_phandle[socket]);
+        g_free(plic_name);
+
+        g_free(clint_cells);
+        g_free(plic_cells);
+        g_free(clust_name);
     }
 
-    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
-    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
-        nodename =
-            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
-        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-        g_free(nodename);
+    for (socket = 0; socket < s->num_socs; socket++) {
+        if (socket == 0) {
+            plic_mmio_phandle = plic_phandle[socket];
+            plic_virtio_phandle = plic_phandle[socket];
+            plic_pcie_phandle = plic_phandle[socket];
+        }
+        if (socket == 1) {
+            plic_virtio_phandle = plic_phandle[socket];
+            plic_pcie_phandle = plic_phandle[socket];
+        }
+        if (socket == 2) {
+            plic_pcie_phandle = plic_phandle[socket];
+        }
     }
-    nodename = g_strdup_printf("/soc/clint@%lx",
-        (long)memmap[VIRT_CLINT].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[VIRT_CLINT].base,
-        0x0, memmap[VIRT_CLINT].size);
-    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
-    g_free(cells);
-    g_free(nodename);
-
-    plic_phandle = phandle++;
-    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
-    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
-        nodename =
-            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
-        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
-        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
-        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
-        g_free(nodename);
+
+    if (s->numa_enabled && mc->numa_state->have_numa_distance) {
+        dist_matrix_size = s->num_socs * s->num_socs * 3 * sizeof(uint32_t);
+        dist_matrix = g_malloc0(dist_matrix_size);
+
+        for (i = 0; i < s->num_socs; i++) {
+            for (j = 0; j < s->num_socs; j++) {
+                idx = (i * s->num_socs + j) * 3;
+                dist_matrix[idx + 0] = cpu_to_be32(i);
+                dist_matrix[idx + 1] = cpu_to_be32(j);
+                dist_matrix[idx + 2] =
+                    cpu_to_be32(mc->numa_state->nodes[i].distance[j]);
+            }
+        }
+
+        qemu_fdt_add_subnode(fdt, "/distance-map");
+        qemu_fdt_setprop_string(fdt, "/distance-map", "compatible",
+                                "numa-distance-map-v1");
+        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
+                         dist_matrix, dist_matrix_size);
+        g_free(dist_matrix);
     }
-    nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
-        (long)memmap[VIRT_PLIC].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
-                          FDT_PLIC_ADDR_CELLS);
-    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
-                          FDT_PLIC_INT_CELLS);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
-    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[VIRT_PLIC].base,
-        0x0, memmap[VIRT_PLIC].size);
-    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
-    qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
-    plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
-    g_free(cells);
-    g_free(nodename);
 
     for (i = 0; i < VIRTIO_COUNT; i++) {
-        nodename = g_strdup_printf("/virtio_mmio@%lx",
+        name = g_strdup_printf("/soc/virtio_mmio@%lx",
             (long)(memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size));
-        qemu_fdt_add_subnode(fdt, nodename);
-        qemu_fdt_setprop_string(fdt, nodename, "compatible", "virtio,mmio");
-        qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        qemu_fdt_add_subnode(fdt, name);
+        qemu_fdt_setprop_string(fdt, name, "compatible", "virtio,mmio");
+        qemu_fdt_setprop_cells(fdt, name, "reg",
             0x0, memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
             0x0, memmap[VIRT_VIRTIO].size);
-        qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
-        qemu_fdt_setprop_cell(fdt, nodename, "interrupts", VIRTIO_IRQ + i);
-        g_free(nodename);
+        qemu_fdt_setprop_cell(fdt, name, "interrupt-parent",
+            plic_virtio_phandle);
+        qemu_fdt_setprop_cell(fdt, name, "interrupts", VIRTIO_IRQ + i);
+        g_free(name);
     }
 
-    nodename = g_strdup_printf("/soc/pci@%lx",
+    name = g_strdup_printf("/soc/pci@%lx",
         (long) memmap[VIRT_PCIE_ECAM].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
-                          FDT_PCI_ADDR_CELLS);
-    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
-                          FDT_PCI_INT_CELLS);
-    qemu_fdt_setprop_cell(fdt, nodename, "#size-cells", 0x2);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible",
-                            "pci-host-ecam-generic");
-    qemu_fdt_setprop_string(fdt, nodename, "device_type", "pci");
-    qemu_fdt_setprop_cell(fdt, nodename, "linux,pci-domain", 0);
-    qemu_fdt_setprop_cells(fdt, nodename, "bus-range", 0,
-                           memmap[VIRT_PCIE_ECAM].size /
-                               PCIE_MMCFG_SIZE_MIN - 1);
-    qemu_fdt_setprop(fdt, nodename, "dma-coherent", NULL, 0);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg", 0, memmap[VIRT_PCIE_ECAM].base,
-                           0, memmap[VIRT_PCIE_ECAM].size);
-    qemu_fdt_setprop_sized_cells(fdt, nodename, "ranges",
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELLS);
+    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CELLS);
+    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-generic");
+    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
+    qemu_fdt_setprop_cell(fdt, name, "linux,pci-domain", 0);
+    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
+        memmap[VIRT_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
+    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cells(fdt, name, "reg", 0,
+        memmap[VIRT_PCIE_ECAM].base, 0, memmap[VIRT_PCIE_ECAM].size);
+    qemu_fdt_setprop_sized_cells(fdt, name, "ranges",
         1, FDT_PCI_RANGE_IOPORT, 2, 0,
         2, memmap[VIRT_PCIE_PIO].base, 2, memmap[VIRT_PCIE_PIO].size,
         1, FDT_PCI_RANGE_MMIO,
         2, memmap[VIRT_PCIE_MMIO].base,
         2, memmap[VIRT_PCIE_MMIO].base, 2, memmap[VIRT_PCIE_MMIO].size);
-    create_pcie_irq_map(fdt, nodename, plic_phandle);
-    g_free(nodename);
+    create_pcie_irq_map(fdt, name, plic_pcie_phandle);
+    g_free(name);
 
     test_phandle = phandle++;
-    nodename = g_strdup_printf("/test@%lx",
+    name = g_strdup_printf("/soc/test@%lx",
         (long)memmap[VIRT_TEST].base);
-    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_add_subnode(fdt, name);
     {
         const char compat[] = "sifive,test1\0sifive,test0\0syscon";
-        qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof(compat));
+        qemu_fdt_setprop(fdt, name, "compatible", compat, sizeof(compat));
     }
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+    qemu_fdt_setprop_cells(fdt, name, "reg",
         0x0, memmap[VIRT_TEST].base,
         0x0, memmap[VIRT_TEST].size);
-    qemu_fdt_setprop_cell(fdt, nodename, "phandle", test_phandle);
-    test_phandle = qemu_fdt_get_phandle(fdt, nodename);
-    g_free(nodename);
-
-    nodename = g_strdup_printf("/reboot");
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-reboot");
-    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
-    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
-    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_RESET);
-    g_free(nodename);
-
-    nodename = g_strdup_printf("/poweroff");
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "syscon-poweroff");
-    qemu_fdt_setprop_cell(fdt, nodename, "regmap", test_phandle);
-    qemu_fdt_setprop_cell(fdt, nodename, "offset", 0x0);
-    qemu_fdt_setprop_cell(fdt, nodename, "value", FINISHER_PASS);
-    g_free(nodename);
-
-    nodename = g_strdup_printf("/uart@%lx",
-        (long)memmap[VIRT_UART0].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "ns16550a");
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+    qemu_fdt_setprop_cell(fdt, name, "phandle", test_phandle);
+    test_phandle = qemu_fdt_get_phandle(fdt, name);
+    g_free(name);
+
+    name = g_strdup_printf("/soc/reboot");
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-reboot");
+    qemu_fdt_setprop_cell(fdt, name, "regmap", test_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, name, "value", FINISHER_RESET);
+    g_free(name);
+
+    name = g_strdup_printf("/soc/poweroff");
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "syscon-poweroff");
+    qemu_fdt_setprop_cell(fdt, name, "regmap", test_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "offset", 0x0);
+    qemu_fdt_setprop_cell(fdt, name, "value", FINISHER_PASS);
+    g_free(name);
+
+    name = g_strdup_printf("/soc/uart@%lx", (long)memmap[VIRT_UART0].base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "ns16550a");
+    qemu_fdt_setprop_cells(fdt, name, "reg",
         0x0, memmap[VIRT_UART0].base,
         0x0, memmap[VIRT_UART0].size);
-    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 3686400);
-    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
-    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", UART0_IRQ);
+    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", plic_mmio_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "interrupts", UART0_IRQ);
 
     qemu_fdt_add_subnode(fdt, "/chosen");
-    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
+    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", name);
     if (cmdline) {
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
-    g_free(nodename);
-
-    nodename = g_strdup_printf("/rtc@%lx",
-        (long)memmap[VIRT_RTC].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible",
-        "google,goldfish-rtc");
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+    g_free(name);
+
+    name = g_strdup_printf("/soc/rtc@%lx", (long)memmap[VIRT_RTC].base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "google,goldfish-rtc");
+    qemu_fdt_setprop_cells(fdt, name, "reg",
         0x0, memmap[VIRT_RTC].base,
         0x0, memmap[VIRT_RTC].size);
-    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
-    qemu_fdt_setprop_cell(fdt, nodename, "interrupts", RTC_IRQ);
-    g_free(nodename);
-
-    nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
-    qemu_fdt_add_subnode(s->fdt, nodename);
-    qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "cfi-flash");
-    qemu_fdt_setprop_sized_cells(s->fdt, nodename, "reg",
+    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", plic_mmio_phandle);
+    qemu_fdt_setprop_cell(fdt, name, "interrupts", RTC_IRQ);
+    g_free(name);
+
+    name = g_strdup_printf("/soc/flash@%" PRIx64, flashbase);
+    qemu_fdt_add_subnode(s->fdt, name);
+    qemu_fdt_setprop_string(s->fdt, name, "compatible", "cfi-flash");
+    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
                                  2, flashbase, 2, flashsize,
                                  2, flashbase + flashsize, 2, flashsize);
-    qemu_fdt_setprop_cell(s->fdt, nodename, "bank-width", 4);
-    g_free(nodename);
+    qemu_fdt_setprop_cell(s->fdt, name, "bank-width", 4);
+    g_free(name);
 }
 
-
 static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
                                           hwaddr ecam_base, hwaddr ecam_size,
                                           hwaddr mmio_base, hwaddr mmio_size,
@@ -471,37 +514,128 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     return dev;
 }
 
-static void riscv_virt_board_init(MachineState *machine)
+static void riscv_virt_board_init(MachineState *mc)
 {
     const struct MemmapEntry *memmap = virt_memmap;
-    RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(mc);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    char *plic_hart_config;
+    char *plic_hart_config, *soc_name;
     size_t plic_hart_config_len;
     target_ulong start_addr = memmap[VIRT_DRAM].base;
-    int i;
-    unsigned int smp_cpus = machine->smp.cpus;
-
-    /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-                            &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    DeviceState *mmio_plic, *virtio_plic, *pcie_plic;
+    unsigned int i, j, base_hartid, hart_count;
+    uint64_t mem_offset;
+
+    /* Populate socket details based on NUMA options */
+    s->num_socs = mc->numa_state->num_nodes;
+    if (!s->num_socs) {
+        s->numa_enabled = false;
+        s->num_socs = 1;
+        s->mem_offset[0] = 0;
+        s->mem_size[0] = mc->ram_size;
+    } else {
+        s->numa_enabled = true;
+        s->num_socs = mc->numa_state->num_nodes;
+        mem_offset = 0;
+        for (i = 0; i < s->num_socs; i++) {
+            s->mem_offset[i] = mem_offset;
+            s->mem_size[i] = mc->numa_state->nodes[i].node_mem;
+            mem_offset += s->mem_size[i];
+        }
+    }
+
+    /* Initialize sockets */
+    mmio_plic = virtio_plic = pcie_plic = NULL;
+    for (i = 0; i < s->num_socs; i++) {
+        if (s->numa_enabled) {
+            base_hartid = mc->smp.cpus;
+            hart_count = 0;
+            for (j = 0; j < mc->smp.cpus; j++) {
+                if (mc->possible_cpus->cpus[j].props.node_id != i) {
+                    continue;
+                }
+                if (j < base_hartid) {
+                    base_hartid = j;
+                }
+                hart_count++;
+            }
+        } else {
+            base_hartid = 0;
+            hart_count = mc->smp.cpus;
+        }
+
+        soc_name = g_strdup_printf("soc%d", i);
+        object_initialize_child(OBJECT(mc), soc_name, &s->soc[i],
+            sizeof(s->soc[i]), TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
+        g_free(soc_name);
+        object_property_set_str(OBJECT(&s->soc[i]),
+            mc->cpu_type, "cpu-type", &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]),
+            base_hartid, "hartid-base", &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]),
+            hart_count, "num-harts", &error_abort);
+        object_property_set_bool(OBJECT(&s->soc[i]),
+            true, "realized", &error_abort);
+
+        /* Per-socket CLINT */
+        sifive_clint_create(
+            memmap[VIRT_CLINT].base + i * memmap[VIRT_CLINT].size,
+            memmap[VIRT_CLINT].size, base_hartid, hart_count,
+            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
+
+        /* Per-socket PLIC hart topology configuration string */
+        plic_hart_config_len =
+            (strlen(VIRT_PLIC_HART_CONFIG) + 1) * hart_count;
+        plic_hart_config = g_malloc0(plic_hart_config_len);
+        for (j = 0; j < hart_count; j++) {
+            if (j != 0) {
+                strncat(plic_hart_config, ",", plic_hart_config_len);
+            }
+            strncat(plic_hart_config, VIRT_PLIC_HART_CONFIG,
+                plic_hart_config_len);
+            plic_hart_config_len -= (strlen(VIRT_PLIC_HART_CONFIG) + 1);
+        }
+
+        /* Per-socket PLIC */
+        s->plic[i] = sifive_plic_create(
+            memmap[VIRT_PLIC].base + i * memmap[VIRT_PLIC].size,
+            plic_hart_config, base_hartid,
+            VIRT_PLIC_NUM_SOURCES,
+            VIRT_PLIC_NUM_PRIORITIES,
+            VIRT_PLIC_PRIORITY_BASE,
+            VIRT_PLIC_PENDING_BASE,
+            VIRT_PLIC_ENABLE_BASE,
+            VIRT_PLIC_ENABLE_STRIDE,
+            VIRT_PLIC_CONTEXT_BASE,
+            VIRT_PLIC_CONTEXT_STRIDE,
+            memmap[VIRT_PLIC].size);
+        g_free(plic_hart_config);
+
+        /* Try to use different PLIC instance based device type */
+        if (i == 0) {
+            mmio_plic = s->plic[i];
+            virtio_plic = s->plic[i];
+            pcie_plic = s->plic[i];
+        }
+        if (i == 1) {
+            virtio_plic = s->plic[i];
+            pcie_plic = s->plic[i];
+        }
+        if (i == 2) {
+            pcie_plic = s->plic[i];
+        }
+    }
 
     /* register system main memory (actual RAM) */
     memory_region_init_ram(main_mem, NULL, "riscv_virt_board.ram",
-                           machine->ram_size, &error_fatal);
+                           mc->ram_size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[VIRT_DRAM].base,
         main_mem);
 
     /* create device tree */
-    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    create_fdt(s, memmap, mc->ram_size, mc->kernel_cmdline);
 
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
@@ -509,17 +643,17 @@ static void riscv_virt_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
-    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+    riscv_find_and_load_firmware(mc, BIOS_FILENAME,
                                  memmap[VIRT_DRAM].base, NULL);
 
-    if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
+    if (mc->kernel_filename) {
+        uint64_t kernel_entry = riscv_load_kernel(mc->kernel_filename,
                                                   NULL);
 
-        if (machine->initrd_filename) {
+        if (mc->initrd_filename) {
             hwaddr start;
-            hwaddr end = riscv_load_initrd(machine->initrd_filename,
-                                           machine->ram_size, kernel_entry,
+            hwaddr end = riscv_load_initrd(mc->initrd_filename,
+                                           mc->ram_size, kernel_entry,
                                            &start);
             qemu_fdt_setprop_cell(s->fdt, "/chosen",
                                   "linux,initrd-start", start);
@@ -571,38 +705,14 @@ static void riscv_virt_board_init(MachineState *machine)
                           memmap[VIRT_MROM].base + sizeof(reset_vec),
                           &address_space_memory);
 
-    /* create PLIC hart topology configuration string */
-    plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
-    plic_hart_config = g_malloc0(plic_hart_config_len);
-    for (i = 0; i < smp_cpus; i++) {
-        if (i != 0) {
-            strncat(plic_hart_config, ",", plic_hart_config_len);
-        }
-        strncat(plic_hart_config, VIRT_PLIC_HART_CONFIG, plic_hart_config_len);
-        plic_hart_config_len -= (strlen(VIRT_PLIC_HART_CONFIG) + 1);
-    }
-
-    /* MMIO */
-    s->plic = sifive_plic_create(memmap[VIRT_PLIC].base,
-        plic_hart_config, 0,
-        VIRT_PLIC_NUM_SOURCES,
-        VIRT_PLIC_NUM_PRIORITIES,
-        VIRT_PLIC_PRIORITY_BASE,
-        VIRT_PLIC_PENDING_BASE,
-        VIRT_PLIC_ENABLE_BASE,
-        VIRT_PLIC_ENABLE_STRIDE,
-        VIRT_PLIC_CONTEXT_BASE,
-        VIRT_PLIC_CONTEXT_STRIDE,
-        memmap[VIRT_PLIC].size);
-    sifive_clint_create(memmap[VIRT_CLINT].base,
-        memmap[VIRT_CLINT].size, 0, smp_cpus,
-        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
+    /* SiFive Test MMIO device */
     sifive_test_create(memmap[VIRT_TEST].base);
 
+    /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
         sysbus_create_simple("virtio-mmio",
             memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
-            qdev_get_gpio_in(DEVICE(s->plic), VIRTIO_IRQ + i));
+            qdev_get_gpio_in(DEVICE(virtio_plic), VIRTIO_IRQ + i));
     }
 
     gpex_pcie_init(system_memory,
@@ -611,14 +721,14 @@ static void riscv_virt_board_init(MachineState *machine)
                          memmap[VIRT_PCIE_MMIO].base,
                          memmap[VIRT_PCIE_MMIO].size,
                          memmap[VIRT_PCIE_PIO].base,
-                         DEVICE(s->plic), true);
+                         DEVICE(pcie_plic), true);
 
     serial_mm_init(system_memory, memmap[VIRT_UART0].base,
-        0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
+        0, qdev_get_gpio_in(DEVICE(mmio_plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     sysbus_create_simple("goldfish_rtc", memmap[VIRT_RTC].base,
-        qdev_get_gpio_in(DEVICE(s->plic), RTC_IRQ));
+        qdev_get_gpio_in(DEVICE(mmio_plic), RTC_IRQ));
 
     virt_flash_create(s);
 
@@ -628,8 +738,54 @@ static void riscv_virt_board_init(MachineState *machine)
                                   drive_get(IF_PFLASH, 0, i));
     }
     virt_flash_map(s, system_memory);
+}
+
+static CpuInstanceProperties
+riscv_virt_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
+}
+
+static int64_t
+riscv_virt_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    int64_t nidx = 0;
+
+    if (ms->numa_state->num_nodes) {
+        nidx = idx / (ms->smp.cpus / ms->numa_state->num_nodes);
+        if (ms->numa_state->num_nodes <= nidx) {
+            nidx = ms->numa_state->num_nodes - 1;
+        }
+    }
+
+    return nidx;
+}
+
+static const CPUArchIdList *riscv_virt_possible_cpu_arch_ids(MachineState *ms)
+{
+    int n;
+    unsigned int max_cpus = ms->smp.max_cpus;
+
+    if (ms->possible_cpus) {
+        assert(ms->possible_cpus->len == max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len = max_cpus;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].type = ms->cpu_type;
+        ms->possible_cpus->cpus[n].arch_id = n;
+        ms->possible_cpus->cpus[n].props.has_thread_id = true;
+        ms->possible_cpus->cpus[n].props.thread_id = n;
+    }
 
-    g_free(plic_hart_config);
+    return ms->possible_cpus;
 }
 
 static void riscv_virt_machine_instance_init(Object *obj)
@@ -642,9 +798,13 @@ static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "RISC-V VirtIO board";
     mc->init = riscv_virt_board_init;
-    mc->max_cpus = 8;
+    mc->max_cpus = VIRT_CPUS_MAX;
     mc->default_cpu_type = VIRT_CPU;
     mc->pci_allow_0_address = true;
+    mc->possible_cpu_arch_ids = riscv_virt_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props = riscv_virt_cpu_index_to_props;
+    mc->get_default_cpu_node_id = riscv_virt_get_default_cpu_node_id;
+    mc->numa_mem_supported = true;
 }
 
 static const TypeInfo riscv_virt_machine_typeinfo = {
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e69355efaf..61e6dfd454 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -22,6 +22,9 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 #include "hw/block/flash.h"
+#include "sysemu/numa.h"
+
+#define VIRT_CPUS_MAX 8
 
 #define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
 #define RISCV_VIRT_MACHINE(obj) \
@@ -32,8 +35,12 @@ typedef struct {
     MachineState parent;
 
     /*< public >*/
-    RISCVHartArrayState soc;
-    DeviceState *plic;
+    bool numa_enabled;
+    unsigned int num_socs;
+    uint64_t mem_offset[MAX_NODES];
+    uint64_t mem_size[MAX_NODES];
+    RISCVHartArrayState soc[MAX_NODES];
+    DeviceState *plic[MAX_NODES];
     PFlashCFI01 *flash[2];
 
     void *fdt;
@@ -74,6 +81,8 @@ enum {
 #define VIRT_PLIC_ENABLE_STRIDE 0x80
 #define VIRT_PLIC_CONTEXT_BASE 0x200000
 #define VIRT_PLIC_CONTEXT_STRIDE 0x1000
+#define VIRT_PLIC_SIZE(__num_context) \
+    (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
 #define FDT_PCI_ADDR_CELLS    3
 #define FDT_PCI_INT_CELLS     1
-- 
2.25.1


