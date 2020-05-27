Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CC7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7058620787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rRSrolA7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dneh+Xbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7058620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdoyj-0008FH-LY
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqS-0003ap-Gz; Wed, 27 May 2020 01:43:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqQ-0003aK-He; Wed, 27 May 2020 01:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590558194; x=1622094194;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=71k64XgqGteG7ZyqAGlaQXsbwFH9BcGQOEGSJ56v3kk=;
 b=rRSrolA7jU/8JNdFXv5ruqvu9DiBjjtMxLHQzjBTsOX5M0KFjLcr2uPQ
 RaR6b20Rk2vt2Eck1Slfi+bMt5hP93hVL2nVaQ+ofbVW65WFMONfBFI5C
 yh7PvdPB8tc/U4KtcGAp2nv8qfaVFIjrl4DA0bEO+OUvR+iKUuUprKZkf
 YJKq3j/3wpPT8SrLmzWeBuaSdf7pi2793ek9OFRe3NnFBop3WnUXIYs2F
 VBIeuc5/bWet7H0kJhBCjWeweHLWiN5dgbqeeb0orNrZa1tSNnB4No2K7
 rBJlP3eYEUtle6fuN6zAqnnEREAgYA4R/yw4POndNR4UYtQ1PBnL6Bj69 g==;
IronPort-SDR: oaUWV2gIM379Sw2xVxA1Fin6mqxJvjW7tzD+0ZG7FEiGruo0tePZcAK8Zq+VMmsKxc+tg5j9cC
 rDbme2W+pzJESVk1Y4H1qIy7cyggYQGVsHJCalTRFcEr6wzx/lRWLrSP3jwxs82wMbGsrSrcQg
 GuwAuBsBiqts5UOMDXra6fP5JP9zmVFmqnvJMPNw8l4NdkypWBvHKZVNITJySGtBhi3B3NOJ+Y
 mQoqkP5Mom7GjOECv41Fa7pY91bFxDAgLJ5RMg2puO0QrMSr2A6RC78mbjDOVN49TIQxnyxWq1
 GRc=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; d="scan'208";a="247638097"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 13:43:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih7WVvIHd5zVlTitOalsMYAq80W2qlvVKCTzrL7wXnj5kW7XdNPS55cIY8hTUMoh8unYxDWj7CLWUxaCgm5/FJL/fx1/utZH2AgO8BscIFf4U4DI3NXLh6v0PLLdfrRImN46oEO0RvvtVmVgR/zCd252WT3GA2YMdbvcjuqak49lAi+XPqtpZTlPV7RT2dxRuKW74dAG99PaWsU+AZxOyZW9oShHpZzZfeZ8p2wM3cqHmFK9UwdjAUCCWVnnMMPXs2gE70moD5vtzYOqj1sqeSQ69Sc6rZUMpVXm2X7JXQbtFBnoFbOmU9zQSdQMKlVoTcasaniqJ3jvuPizOvbtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU3dolJXg3xGpenztYhvyzkjOaW3wk6bS10vb8P2ndo=;
 b=mO/MT6C7CtOMwppZWhhDcux28zsuyLAUbSf4R/29jnIzUvdOovaaAjXm4SL1wmvy4lT6fXP1Do4jaQWJ7jceDLY/fjr7IDCByND5HMLtpFnx+h9OMPDdqa1uzdSISJuPuxbtVs9O6PJUtOlfffQktR2hewCsLoe/DoWVCKvM6TXHyE7h6vUpF/vKeznhc6FsFHBb2ItWB2R3YqU5GvLKq6EwQtcsddtcJbraJ3ed31CwlVZBkFoV8BnGq4ki6ToB2vXAOz7JhKcZiHl6QKxxJu19++U27dHUGk6DU6CR+hSWR+z+KjmMXSl1HY6LQPIs4Jkor5jAa1U37lkndXjsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU3dolJXg3xGpenztYhvyzkjOaW3wk6bS10vb8P2ndo=;
 b=dneh+XbhLtcKNVmdQxjH8Wy7UTMpOqg5jzyWlTB30d++VDRf7wG4PF/unRGo1+Ydgzrg6eOwjnXwpKFh398x/jm1i7s1DR+iFROBPsrQMHjmDEOKOq6bBEZB4hsJ3EtP++lbZHAcFo3qMQXi33PpLFZSLVmNxjIdd4VPa4KhWbc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6923.namprd04.prod.outlook.com (2603:10b6:5:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 05:43:12 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 05:43:11 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 3/5] hw/riscv: spike: Allow creating multiple sockets
Date: Wed, 27 May 2020 11:12:24 +0530
Message-Id: <20200527054226.232103-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200527054226.232103-1-anup.patel@wdc.com>
References: <20200527054226.232103-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::20) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.30.5) by
 MAXPR0101CA0058.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Wed, 27 May 2020 05:43:07 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d292e72-79e6-4389-26d4-08d80200d7ab
X-MS-TrafficTypeDiagnostic: DM6PR04MB6923:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB692394FBCC0E212451CE3BF98DB10@DM6PR04MB6923.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GI4wyiJxE/ovacxdWOvJYXO4AIRgcDztqHwg0NZ+UltjLVMdWY3DSP6t1PmYYUeMS6h8wIjUw7PxEl9iYeXKE4v78ZS+6waoUUUXX3nCG9E76jkMMlIGQPbwE9fRv5CPlAM4Ezu6lkk72wJIr7K1RFGzc7lxyTpn6fnQAQQG+ubSggfTfrM7sWRIVUWwhfqxr17rpuW4p7T1wMashs9vnCJXlzCNuBLnayyzlFSc16HxKYIgPhcEmmNgXum4xuRaaz3BKmW/jLbXHUwBeaXu4Gm7fTippSQxHHQ9Nk7A95BrQCf9+QUKZjo2ReMHVxVuj4cpVQRXkvn7F2GWNHWtzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(1006002)(110136005)(6666004)(316002)(1076003)(8676002)(30864003)(2616005)(5660300002)(956004)(8886007)(8936002)(36756003)(44832011)(4326008)(54906003)(186003)(16526019)(478600001)(26005)(66556008)(2906002)(55236004)(66476007)(7696005)(55016002)(86362001)(52116002)(66946007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: LqJIHpfmxt8QR4tMvLi05fS/XM4uF0FZf5YFIzLi0iPPoc0VEqxeJa9cjB8QVk37ingC20Q+GjMOX3tiOB+FZPXK+mbIidA1X15BfMTB9tSBI/LvomNAGRVxr2IjUhUvHGEqvdpeKZ05Lkxs5msjgfZqLbzx/pca4vkZzDyEUoZNULoP0d7RWq54P2Xds6mkfUPD4tGyZjBOVZ8ywcL5RPIew3YoI35H/7M9gAnOo+XK831B5x44VnxRkeUa8bYxKmffYika/U+RsNW6HrNDqaGTiqZ8ltjZhazRmhr4AwhpQ2yaSxb4bjmQX+3Uh45bQIJu2h3H5B0d/r1HxJBLHI+ubolJJVop/+tfLF3gBCpa5xEHrlZUZe6nKuHPsRK4jyyfAZ0F6PwPVzKalDxBiYHWbD3CjPpPVF2VI4YNly2JAfQ3BD1NnOGWRJ+FslFS7Sf5Ukz7zHPhU32cutXPHfK+8u2n5AWARQviKF/xmZ4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d292e72-79e6-4389-26d4-08d80200d7ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 05:43:11.8656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Kf/TPJjhMAV5zYqXabiob+cl9mJcDAHJq9LNGGtgoM7JpX1iEnw2zTzHDZYETxKdR5dRqwRz9MyCbz+DLlU1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6923
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=409226bd6=Anup.Patel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:42:59
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
Each RISC-V spike machine socket is a set of HARTs and a CLINT instance.
Other peripherals are shared between all RISC-V spike machine sockets.
We also update RISC-V spike machine device tree to treat each socket as
a NUMA node.

The number of sockets in RISC-V spike machine can be specified using
the "sockets=" sub-option of QEMU "-smp" command-line option. By
default, only one socket RISC-V spike machine will be created.

Currently, we only allow creating upto maximum 4 sockets but this
limit can be changed in future.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/spike.c         | 210 ++++++++++++++++++++++++---------------
 include/hw/riscv/spike.h |   6 +-
 2 files changed, 136 insertions(+), 80 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index d5e0103d89..e0bff23a23 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -64,9 +64,11 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
-    int cpu;
-    uint32_t *cells;
-    char *nodename;
+    int cpu, socket;
+    uint32_t *clint_cells;
+    unsigned long clint_addr;
+    uint32_t cpu_phandle, intc_phandle, phandle = 1;
+    char *name, *clint_name, *clust_name, *core_name, *cpu_name, *intc_name;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -88,68 +90,87 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-    nodename = g_strdup_printf("/memory@%lx",
-        (long)memmap[SPIKE_DRAM].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+    name = g_strdup_printf("/memory@%lx", (long)memmap[SPIKE_DRAM].base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_cells(fdt, name, "reg",
         memmap[SPIKE_DRAM].base >> 32, memmap[SPIKE_DRAM].base,
         mem_size >> 32, mem_size);
-    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
-    g_free(nodename);
+    qemu_fdt_setprop_string(fdt, name, "device_type", "memory");
+    g_free(name);
 
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
         SIFIVE_CLINT_TIMEBASE_FREQ);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
+    qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
 
-    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
-        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
-        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        char *isa = riscv_isa_string(&s->soc.harts[cpu]);
-        qemu_fdt_add_subnode(fdt, nodename);
+    for (socket = (s->num_socs - 1); socket >= 0; socket--) {
+        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
+        qemu_fdt_add_subnode(fdt, clust_name);
+
+        clint_cells =  g_new0(uint32_t, s->soc[socket].num_harts * 4);
+
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
-    }
+            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
+            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
+            g_free(name);
+            qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
+            qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
+            qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
+                s->soc[socket].hartid_base + cpu);
+            qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
+            qemu_fdt_setprop_cell(fdt, cpu_name, "numa-node-id", socket);
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
+        clint_addr = memmap[SPIKE_CLINT].base +
+            (memmap[SPIKE_CLINT].size * socket);
+        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
+        qemu_fdt_add_subnode(fdt, clint_name);
+        qemu_fdt_setprop_string(fdt, clint_name, "compatible", "riscv,clint0");
+        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
+            0x0, clint_addr, 0x0, memmap[SPIKE_CLINT].size);
+        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
+            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
+        qemu_fdt_setprop_cell(fdt, clint_name, "numa-node-id", socket);
+
+        g_free(clint_name);
+        g_free(clint_cells);
+        g_free(clust_name);
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
@@ -160,23 +181,50 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
 static void spike_board_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = spike_memmap;
-
     SpikeState *s = g_new0(SpikeState, 1);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     int i;
+    char *soc_name;
     unsigned int smp_cpus = machine->smp.cpus;
+    unsigned int base_hartid, cpus_per_socket;
 
-    /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-                            &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    /* Figure-out number of sockets */
+    s->num_socs = (machine->smp.sockets_specified) ? machine->smp.sockets : 1;
+
+    /* Limit the number of sockets */
+    if (SPIKE_SOCKETS_MAX < s->num_socs) {
+        s->num_socs = SPIKE_SOCKETS_MAX;
+    }
+
+    /* Initialize socket */
+    for (i = 0; i < s->num_socs; i++) {
+        base_hartid = i * (smp_cpus / s->num_socs);
+        if (i == (s->num_socs - 1)) {
+            cpus_per_socket = smp_cpus - base_hartid;
+        } else {
+            cpus_per_socket = smp_cpus / s->num_socs;
+        }
+        soc_name = g_strdup_printf("soc%d", i);
+        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
+            sizeof(s->soc[i]), TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
+        g_free(soc_name);
+        object_property_set_str(OBJECT(&s->soc[i]),
+            machine->cpu_type, "cpu-type", &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]),
+            base_hartid, "hartid-base", &error_abort);
+        object_property_set_int(OBJECT(&s->soc[i]),
+            cpus_per_socket, "num-harts", &error_abort);
+        object_property_set_bool(OBJECT(&s->soc[i]),
+            true, "realized", &error_abort);
+
+        /* Core Local Interruptor (timer and IPI) for each socket */
+        sifive_clint_create(
+            memmap[SPIKE_CLINT].base + i * memmap[SPIKE_CLINT].size,
+            memmap[SPIKE_CLINT].size, base_hartid, cpus_per_socket,
+            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
+    }
 
     /* register system main memory (actual RAM) */
     memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
@@ -249,12 +297,8 @@ static void spike_board_init(MachineState *machine)
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
@@ -268,6 +312,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    s->num_socs = 1;
+
     if (!qtest_enabled()) {
         info_report("The Spike v1.10.0 machine has been deprecated. "
                     "Please use the generic spike machine and specify the ISA "
@@ -275,13 +321,14 @@ static void spike_v1_10_0_board_init(MachineState *machine)
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
@@ -339,7 +386,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -358,6 +406,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    s->num_socs = 1;
+
     if (!qtest_enabled()) {
         info_report("The Spike v1.09.1 machine has been deprecated. "
                     "Please use the generic spike machine and specify the ISA "
@@ -365,13 +415,14 @@ static void spike_v1_09_1_board_init(MachineState *machine)
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
@@ -425,7 +476,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
         "};\n";
 
     /* build config string with supplied memory size */
-    char *isa = riscv_isa_string(&s->soc.harts[0]);
+    char *isa = riscv_isa_string(&s->soc[0].harts[0]);
     char *config_string = g_strdup_printf(config_string_tmpl,
         (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
         (uint64_t)memmap[SPIKE_DRAM].base,
@@ -448,7 +499,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -476,7 +528,7 @@ static void spike_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Spike Board";
     mc->init = spike_board_init;
-    mc->max_cpus = 8;
+    mc->max_cpus = SPIKE_CPUS_MAX;
     mc->is_default = true;
     mc->default_cpu_type = SPIKE_V1_10_0_CPU;
 }
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index dc770421bc..7f3d8a58d7 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -22,12 +22,16 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 
+#define SPIKE_CPUS_MAX 8
+#define SPIKE_SOCKETS_MAX 4
+
 typedef struct {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
-    RISCVHartArrayState soc;
+    unsigned int num_socs;
+    RISCVHartArrayState soc[SPIKE_SOCKETS_MAX];
     void *fdt;
     int fdt_size;
 } SpikeState;
-- 
2.25.1


