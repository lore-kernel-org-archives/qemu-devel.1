Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E87A20721
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EFa6ssGp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E/kQpaCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E87A20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIda-0001Oo-FG
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=41059f22b=Anup.Patel@wdc.com>)
 id 1jeIcJ-0007gJ-8r; Thu, 28 May 2020 09:30:40 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=41059f22b=Anup.Patel@wdc.com>)
 id 1jeIcG-0001CO-5x; Thu, 28 May 2020 09:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590672636; x=1622208636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=esvbG8mwyfuf8XW2HxsiBnuLQxTMUq0Obayx/hsdVcc=;
 b=EFa6ssGpsRMB82oUBx16cUu+SZl6B+eW8AGF6oAFVyk9hKKuJLNJcK2x
 uY3uQhsHFM6zIzWj2Vo6Z9/yf2bWab94yuIdWekl29jkiYhYziF1UWJSU
 TPgLDC1wxsLQfc5CCXdWd3ujxsYWNPhQ8pgi5KAdmFYlw0pujFQxZLC72
 qf3bQkDFfMjSXqB7KvGVZDJfn8e2OB5PeNU2kJHXW+WAb2hg3s1E6Rkil
 tfuXCtL8/It9DeDqoYn6Hkb4nmp41lxrVBM2bHiAu5/GiEZufClk93728
 vIq8wpF8z0oeRdamFjDJ9IA5xdWZHQv0pVoTWv4mGndWqpusKd6HL59aR Q==;
IronPort-SDR: h0lHD64mLzfI/CI97oGk1VkX5vz2xwfvhNqazgpEiQIt9hs9ngsH0SUFvwQt+goRcttd+RAiwV
 ZEmyXcoTkNkEsxW0XiOMiQj/wdVIjSWdjXxY9La01WXob5aVTkqCjI53leDokI+TR6kRZSZCt+
 PM6kS0sm4wURAEu382Ak2vwOT4bZ6ZNY01XLs9uq56WZfa3jF8wNDg+rxlGrFT4Obor4KTPbld
 EwWs1/dqxwiztbpKTi/GndkEvM4dSIjlgOhvB50nfmAPvRNYF4xPeWYfr2N/uKnv+wvMpBDkVP
 pbM=
X-IronPort-AV: E=Sophos;i="5.73,444,1583164800"; d="scan'208";a="143036560"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 21:30:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy2T+BnifTq3OpRk2ANUmq9VVHHdTtEEyc9eXQtg4PaTYZ1f6csOpbU7CoqohVUJi6NY/LlxYQ61dUQyThfXQGdMhOcAYqMq44p5VlmAK/IHVvLZxO8JL795mS9LIU0amPWWvWC1H8UMqltB/GZkzfaEG9uSDRTTM6Mf3v3SWaTVKbtHGfKPACPNct0ZXDG/tDyp7ePN+4l0bse658503kc/wh2LvI3xwViCvRHyXF86BlZ23qBuArYdPob0mokTIl1VIjfUKdXud5WUM2Jq4iQoq2fr5lpIzEMs1qw/0upeKbdQUCXN6Q+8BH1NlYYEvYfHpjf+UPKhAq1GcuKgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWS+d247xFZXDb66J8uxkh46EXespExk7s1Y15FDEf0=;
 b=S4ZlJHHOgt2mm+vMHuAnjCWmqUGevK3I3cVngBirnCmeyrsuvIrOPMfKXKBWmgC5nk4IHsNYjv3O7IUgjZfDPnF2MzH9J+C67inqbnD4hjJ/KXd1rm3QGbtYRZmPdYpyj9v8skJb49EOwx9HLLbgb38omWnZjDTnTblYiOk92JOv9vw/wdVkeUtJu45uw8jC05dmTmjY5LnQgbNFbshOjrgJZP/sSHwCUf5MYG3dpKZ0FPIqYDnpOKmZHPMKOLzdtbdxnyRdJKDm9vOCjW3GRf/iarVSLWjvJenLUKg1IT7P93uwj2Tpjuib5ZnkyctXV1i/FeKqlJBZ7EwtbhX/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWS+d247xFZXDb66J8uxkh46EXespExk7s1Y15FDEf0=;
 b=E/kQpaCNDIDCXFAGflyEvw/Ugohdz1Cx1Pk3PXD+MYQTkR8yuAVZUeaeu7IPkb62p0HkPB15nkVzo42GFqyGXZvonCMlztEAE3XQD4DgMghjqB+ZocWaff/T1bjXzcpHwM8z98erO5bGWKULcjwYFtE5ZRy4+1ntkpGq+35OKK4=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6204.namprd04.prod.outlook.com (2603:10b6:5:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 13:30:32 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 13:30:32 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v4 2/4] hw/riscv: spike: Allow creating multiple NUMA sockets
Date: Thu, 28 May 2020 18:59:57 +0530
Message-Id: <20200528132959.47773-3-anup.patel@wdc.com>
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
 15.20.3045.18 via Frontend Transport; Thu, 28 May 2020 13:30:29 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.63.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f3ccc6c3-b88a-49ce-2e3c-08d8030b4bbb
X-MS-TrafficTypeDiagnostic: DM6PR04MB6204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB62049C2697818DF45DDE9EB18D8E0@DM6PR04MB6204.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8Guwp6ibPXCXHW+pRyIG8As6HUsNIJLPYwHZp3lW4qx6Y31Z4sLR9MGJLCUCV867OLfwL5XOeN6WtiTucX6sc3DUDCRz/me6DJWil+cBVHJ691/1f9Tcz3oJT/Y2bIQB1Zspel1Fz82lw5RwSguX+Iem19r8muOc+5zHoH45904XKT9xSGKeeuQ/iIP0gIw6NmwYYcCT72dKhJ/ONqg9ATA6D/Rf4cGhXLBaEEOnONAgZ4Q4elKEJDSutp2HR5juFkGh4WmCpDi2KTzQ5LgJL9gBB4UHmpp1wsvJPPoVxt+HbJoK8UhBBLKBly1PPEg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(956004)(26005)(55016002)(44832011)(478600001)(55236004)(2616005)(5660300002)(7696005)(16526019)(52116002)(186003)(8936002)(30864003)(8676002)(1076003)(86362001)(8886007)(66556008)(66946007)(66476007)(316002)(83380400001)(4326008)(54906003)(110136005)(36756003)(6666004)(1006002)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OayT0MCLvKPiKM/1BHQ6x531VnAe0NPyfiMsxBySv4KjHl1OvodQmkKbNPHUDJgQecc95el8Dyxo4+NQSMRy8ewD/j19DAlDhrjIbmdiF+15m8hpcG6F7WHiThy38pMK1Pbw0K80OJhhMwWH9DrHIcWL+V0LWhK5mZF/F1VmTQBcZtckAmY8CCuIm8SXphlBkoSbmUGFgxehPjo1AXumuZiu/4HABbWg5HTzKtuDbsli0MMEfOTxy5AcrRwe+AwVgnaHpwhe/eyiZ2XebBkCmnK9ceVqh0h0XiYHrWKbVpQvBLysi3kuASunuVjXAPkMkpL0gcLCWT6Pgc/lIFCdZoCzZDvYB4Yb70a26/ihLq0CzGOdaKDII/CIkEA6A/gYxMxpJkuA5t1sp3EsO/CnkFHwFps7B/IkSqJ1ZGPILzZ0zZXP2rXv3u0XJxQoE03w/Di55RmAtTNJv0Z6ipy9t8jlN2+u+EMTMTCCS0lOTlM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ccc6c3-b88a-49ce-2e3c-08d8030b4bbb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 13:30:32.7674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hz3NIwhAMaoZf5BuHV2iP1hdXsg2wU6QjMtT0jf28kgrrApH3mPMcAEJt7mL/KhIEmDrWer16dZyYjs4Y2cPKg==
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
Cc: Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We extend RISC-V spike machine to allow creating a multi-socket machine.
Each RISC-V spike machine socket is a NUMA node having a set of HARTs,
a memory instance, and a CLINT instance. Other devices are shared
between all RISC-V spike machine sockets. We also update the generated
device tree accordingly.

By default, NUMA multi-socket support is disabled for RISC-V spike
machine. To enable it, users can use "-numa" command-line options
of QEMU.

Example1: For two NUMA nodes with 4 CPUs each, append following
to command-line options: "-smp 8 -numa node -numa node"

Example2: For two NUMA nodes with 3 and 5 CPUs, append following
to command-line options: "-smp 8 -numa node,cpus=0-2 -numa node,3-7"

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/spike.c         | 381 +++++++++++++++++++++++++++++----------
 include/hw/riscv/spike.h |  15 +-
 2 files changed, 296 insertions(+), 100 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index d5e0103d89..b1923442b6 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -64,9 +64,14 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
-    int cpu;
-    uint32_t *cells;
-    char *nodename;
+    unsigned long clint_addr;
+    int i, j, idx, cpu, socket;
+    MachineState *mc = MACHINE(s);
+    uint32_t dist_matrix_size;
+    uint32_t *clint_cells, *dist_matrix;
+    uint32_t cpu_phandle, intc_phandle, phandle = 1;
+    char *name, *mem_name, *clint_name, *clust_name;
+    char *core_name, *cpu_name, *intc_name;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -88,68 +93,118 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-    nodename = g_strdup_printf("/memory@%lx",
-        (long)memmap[SPIKE_DRAM].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        memmap[SPIKE_DRAM].base >> 32, memmap[SPIKE_DRAM].base,
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
+        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
 
-    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
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
-        qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", 1);
-        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
-        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
-        g_free(isa);
-        g_free(intc);
-        g_free(nodename);
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
+            core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
+            qemu_fdt_add_subnode(fdt, core_name);
+            qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+
+            g_free(core_name);
+            g_free(intc_name);
+            g_free(cpu_name);
+        }
+
+        mem_name = g_strdup_printf("/memory@%lx",
+            (long)memmap[SPIKE_DRAM].base + s->mem_offset[socket]);
+        qemu_fdt_add_subnode(fdt, mem_name);
+        qemu_fdt_setprop_cells(fdt, mem_name, "reg",
+            (memmap[SPIKE_DRAM].base + s->mem_offset[socket]) >> 32,
+            memmap[SPIKE_DRAM].base + s->mem_offset[socket],
+            s->mem_size[socket] >> 32, s->mem_size[socket]);
+        qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
+        if (s->numa_enabled) {
+            qemu_fdt_setprop_cell(fdt, mem_name, "numa-node-id", socket);
+        }
+        g_free(mem_name);
+
+        clint_addr = memmap[SPIKE_CLINT].base +
+            (memmap[SPIKE_CLINT].size * socket);
+        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
+        qemu_fdt_add_subnode(fdt, clint_name);
+        qemu_fdt_setprop_string(fdt, clint_name, "compatible", "riscv,clint0");
+        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
+            0x0, clint_addr, 0x0, memmap[SPIKE_CLINT].size);
+        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
+            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
+        if (s->numa_enabled) {
+            qemu_fdt_setprop_cell(fdt, clint_name, "numa-node-id", socket);
+        }
+
+        g_free(clint_name);
+        g_free(clint_cells);
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
-    nodename = g_strdup_printf("/soc/clint@%lx",
-        (long)memmap[SPIKE_CLINT].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
-        0x0, memmap[SPIKE_CLINT].base,
-        0x0, memmap[SPIKE_CLINT].size);
-    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
-        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
-    g_free(cells);
-    g_free(nodename);
 
     if (cmdline) {
         qemu_fdt_add_subnode(fdt, "/chosen");
@@ -157,35 +212,82 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     }
 }
 
-static void spike_board_init(MachineState *machine)
+static void spike_board_init(MachineState *mc)
 {
     const struct MemmapEntry *memmap = spike_memmap;
-
-    SpikeState *s = g_new0(SpikeState, 1);
+    SpikeState *s = SPIKE_MACHINE(mc);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    int i;
-    unsigned int smp_cpus = machine->smp.cpus;
+    char *soc_name;
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
 
-    /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-                            &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    /* Initialize sockets */
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
+        /* Core Local Interruptor (timer and IPI) for each socket */
+        sifive_clint_create(
+            memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
+            memmap[SPIKE_CLINT].size, base_hartid, hart_count,
+            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
+    }
 
     /* register system main memory (actual RAM) */
     memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
-                           machine->ram_size, &error_fatal);
+                           mc->ram_size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SPIKE_DRAM].base,
         main_mem);
 
     /* create device tree */
-    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    create_fdt(s, memmap, mc->ram_size, mc->kernel_cmdline);
 
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv.spike.mrom",
@@ -193,18 +295,18 @@ static void spike_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
                                 mask_rom);
 
-    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+    riscv_find_and_load_firmware(mc, BIOS_FILENAME,
                                  memmap[SPIKE_DRAM].base,
                                  htif_symbol_callback);
 
-    if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
+    if (mc->kernel_filename) {
+        uint64_t kernel_entry = riscv_load_kernel(mc->kernel_filename,
                                                   htif_symbol_callback);
 
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
@@ -249,12 +351,8 @@ static void spike_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
-
-    /* Core Local Interruptor (timer and IPI) */
-    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
-        false);
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
 }
 
 static void spike_v1_10_0_board_init(MachineState *machine)
@@ -268,6 +366,12 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    s->num_socs = 1;
+    s->numa_enabled = false;
+    s->num_socs = 1;
+    s->mem_offset[0] = 0;
+    s->mem_size[0] = machine->ram_size;
+
     if (!qtest_enabled()) {
         info_report("The Spike v1.10.0 machine has been deprecated. "
                     "Please use the generic spike machine and specify the ISA "
@@ -275,13 +379,14 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     }
 
     /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                            &s->soc[0], sizeof(s->soc[0]),
                             TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), SPIKE_V1_10_0_CPU, "cpu-type",
+    object_property_set_str(OBJECT(&s->soc[0]), SPIKE_V1_10_0_CPU, "cpu-type",
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
+    object_property_set_int(OBJECT(&s->soc[0]), smp_cpus, "num-harts",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
+    object_property_set_bool(OBJECT(&s->soc[0]), true, "realized",
                             &error_abort);
 
     /* register system main memory (actual RAM) */
@@ -339,7 +444,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -358,6 +464,12 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    s->num_socs = 1;
+    s->numa_enabled = false;
+    s->num_socs = 1;
+    s->mem_offset[0] = 0;
+    s->mem_size[0] = machine->ram_size;
+
     if (!qtest_enabled()) {
         info_report("The Spike v1.09.1 machine has been deprecated. "
                     "Please use the generic spike machine and specify the ISA "
@@ -365,13 +477,14 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     }
 
     /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+    object_initialize_child(OBJECT(machine), "soc",
+                            &s->soc[0], sizeof(s->soc[0]),
                             TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), SPIKE_V1_09_1_CPU, "cpu-type",
+    object_property_set_str(OBJECT(&s->soc[0]), SPIKE_V1_09_1_CPU, "cpu-type",
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
+    object_property_set_int(OBJECT(&s->soc[0]), smp_cpus, "num-harts",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
+    object_property_set_bool(OBJECT(&s->soc[0]), true, "realized",
                             &error_abort);
 
     /* register system main memory (actual RAM) */
@@ -425,7 +538,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
         "};\n";
 
     /* build config string with supplied memory size */
-    char *isa = riscv_isa_string(&s->soc.harts[0]);
+    char *isa = riscv_isa_string(&s->soc[0].harts[0]);
     char *config_string = g_strdup_printf(config_string_tmpl,
         (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
         (uint64_t)memmap[SPIKE_DRAM].base,
@@ -448,7 +561,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -472,15 +586,86 @@ static void spike_v1_10_0_machine_init(MachineClass *mc)
     mc->max_cpus = 1;
 }
 
-static void spike_machine_init(MachineClass *mc)
+DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
+DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
+
+static CpuInstanceProperties
+spike_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
+}
+
+static int64_t spike_get_default_cpu_node_id(const MachineState *ms, int idx)
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
+static const CPUArchIdList *spike_possible_cpu_arch_ids(MachineState *ms)
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
+
+    return ms->possible_cpus;
+}
+
+static void spike_machine_instance_init(Object *obj)
+{
+}
+
+static void spike_machine_class_init(ObjectClass *oc, void *data)
 {
-    mc->desc = "RISC-V Spike Board";
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Spike board";
     mc->init = spike_board_init;
-    mc->max_cpus = 8;
+    mc->max_cpus = SPIKE_CPUS_MAX;
     mc->is_default = true;
     mc->default_cpu_type = SPIKE_V1_10_0_CPU;
+    mc->possible_cpu_arch_ids = spike_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props = spike_cpu_index_to_props;
+    mc->get_default_cpu_node_id = spike_get_default_cpu_node_id;
+    mc->numa_mem_supported = true;
 }
 
-DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
-DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
-DEFINE_MACHINE("spike", spike_machine_init)
+static const TypeInfo spike_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("spike"),
+    .parent     = TYPE_MACHINE,
+    .class_init = spike_machine_class_init,
+    .instance_init = spike_machine_instance_init,
+    .instance_size = sizeof(SpikeState),
+};
+
+static void spike_machine_init_register_types(void)
+{
+    type_register_static(&spike_machine_typeinfo);
+}
+
+type_init(spike_machine_init_register_types)
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index dc770421bc..ec4fc9f799 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -21,13 +21,24 @@
 
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
+#include "sysemu/numa.h"
+
+#define SPIKE_CPUS_MAX 8
+
+#define TYPE_SPIKE_MACHINE MACHINE_TYPE_NAME("spike")
+#define SPIKE_MACHINE(obj) \
+    OBJECT_CHECK(SpikeState, (obj), TYPE_SPIKE_MACHINE)
 
 typedef struct {
     /*< private >*/
-    SysBusDevice parent_obj;
+    MachineState parent;
 
     /*< public >*/
-    RISCVHartArrayState soc;
+    bool numa_enabled;
+    unsigned int num_socs;
+    uint64_t mem_offset[MAX_NODES];
+    uint64_t mem_size[MAX_NODES];
+    RISCVHartArrayState soc[MAX_NODES];
     void *fdt;
     int fdt_size;
 } SpikeState;
-- 
2.25.1


