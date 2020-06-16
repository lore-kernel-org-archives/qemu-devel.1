Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12813C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C523B20756
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hi61cfIQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vny72X3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C523B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl2Cu-00020M-2X
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 23:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4298fe783=Anup.Patel@wdc.com>)
 id 1jl2Bu-0000e9-VK; Mon, 15 Jun 2020 23:23:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4298fe783=Anup.Patel@wdc.com>)
 id 1jl2Bs-0007eJ-0k; Mon, 15 Jun 2020 23:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592277791; x=1623813791;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ezECuzNS0IoOqxWV/2ws7/kITKDf8Sw3Hg7/34rQsgc=;
 b=hi61cfIQoBPV99LdlqI9oacg9x9307YICreC09lx/XYAmsDuQimkZCf9
 hEKb4VVOhw2wZwljEePfg0GfiUNM6MItfCbfQWk/EugiwJBlCNTcleMTQ
 D1DqLzG4lC0yBs6EGmtDD6nzqsJ/TUgxQ98bCKTDV/A1i25IiAxritoiy
 4d4+qBj7krn+SKhzh3AV/xMiPZ9vNjdR1AQLPORoVC7Bj9cOG8d90jW9O
 3f7f1XFdLHZySRIaisBXsuXWeryXOkGs0ZJB+xC5Ri1jitnw8G/fBQt/h
 JxVYUpDofzs3We2OFMGYA1kDTcR9rAExfF2yBe8OD8LPPhEooEiLHGFQH g==;
IronPort-SDR: c4UPZLOYzB+WPkLce3avfGy0vLI0UwDTjK4YbUaScZx/3FvlbqPMct8Q+Ko9x9ruHeZrMhBTBm
 PF8b5GgCOWsDLH18gQcoBd8EERpUBJJoTEIrCxkQ5ReUs/iAYNkbIYbJR2Zrb8G7OoUJoQFi3r
 VfPpOxd3FwS0jklfonCIRQOOqZR3TlH3sWGqjnnNiUWVgbXB1lgc9zYNiFyK+npLWcTSC4hhYf
 rFqbI53opCOIgCWOeXXnaKgzo6g4rN12upl23nduRbo65jI94/gTDXeqmRkGV5IK+/t+0a/KFi
 ef8=
X-IronPort-AV: E=Sophos;i="5.73,517,1583164800"; d="scan'208";a="140088540"
Received: from mail-cys01nam02lp2059.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.59])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 11:23:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goFWR6Yj+TBnanDUgyvJTZ8jlx82+ubwl773Sfr0aXd/mGJV1Fl0ME/beibr4lZye3H0pijwmY3K5z+eNCVvaTj86djQ3N4wnLgCSUugdXZiVfU2mxJWG9OEZg9hnIpv47McHZiUUAhoKnToX4QDSRjvmeG79H5PEJn/LOuMjl6B5Qn+IhaM4ZlWQDP135U7VOZbk8pEzO1Gq9pbqajeHIuR/bowvyCZNQnNrNDBh5Xz8eoNlVCGnnuJXGQqLCsbMvpdca5JBLCDs01XsY9bqMX8GKBUzzgMZJYNSGf5ypjCAPdBMvq8B6nQ4eo79gsa6CjTOoX9OULkeyVevDsPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt5N3ZRIuVPuxPFlhyqyFOzvUgP2Ab2b7m19eXpTG1g=;
 b=oJEiU9W3Y74Xenhq9Y/DDksgCK/SuuUmfP40KHYP6o5aReBaP9s/8P++JMSzUcFGcYYXDAr7vx6otzW7MFaarhRC4MKpwDXtXvsPeVT3R03O3tu5gls10tBz4k4X2bChCSRIOFo9NwFc+QFAGROo4PSqCzKRUMLYrLbCtz+IX64R62RjvMP1/68L6WnpwqoOL8VkdjJS5fWG6x+GAyJ8qlIMatzAoYNNs5m5j9+QJWRe+eETa4RVLzNfHkcQwWCDv3V2q8MTOFpGHd8VsImF4Ff9NzgkAlZ9xNWK2VwVq9Z1DV8wY01lPVykFco63wrbR1kxSvlaWFKhcL+4d6wvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vt5N3ZRIuVPuxPFlhyqyFOzvUgP2Ab2b7m19eXpTG1g=;
 b=vny72X3lSsd01Vy3oX2nga2BBDfZ82ZaK8DmsrRfMeXZc5cFIgmZTg9ewtzCnekd7x8IcNSws76NuVijQlzEyJtH8A4w3Y3kpS3BKIdPrZr/7kwUnmwq1FyuElcsKfsXOVDLF0ShtfXeO/0Wr4Xmaepdd2Zi5uwSO0ORdJ7sLD4=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4123.namprd04.prod.outlook.com (2603:10b6:5:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 03:23:09 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 03:23:09 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v6 4/5] hw/riscv: spike: Allow creating multiple NUMA sockets
Date: Tue, 16 Jun 2020 08:52:28 +0530
Message-Id: <20200616032229.766089-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616032229.766089-1-anup.patel@wdc.com>
References: <20200616032229.766089-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.201.92) by
 MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 03:23:06 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.171.201.92]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b0457a30-4c58-49ee-ecb1-08d811a49783
X-MS-TrafficTypeDiagnostic: DM6PR04MB4123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB41230DA8E52ED58E40EB83B78D9D0@DM6PR04MB4123.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSPsLe6rG2cBMQR209ssHx8NSfJ/mKw3ngmLC22EplgZTmpqWC7xRd96CfvGhbwcL8TPzFd4l8qU5vA7EaZUPo9bUswyCknBz/VBkdDsZl134r592im5ZW7sQaQvgj7DBAzDBRBSzhtDryg+9jKrbS91rE1sIZyNfCNlRxe97UzieFYWcEX+XQqD4ARx3kB88kaWHFhILJ2h5nLrrlliHJHesbe31nSseu7aaK9lX0HXpEyEsDdiXT9hw/4L2uouGbfUaizShC07euYYeqDOT6fSFlRzjxOskx372bsz5if9GyORphifr6I/X432rCDhG7144RcqwU4tj86lecJndg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(66946007)(2616005)(66476007)(66556008)(8936002)(956004)(2906002)(316002)(54906003)(478600001)(6666004)(186003)(44832011)(55016002)(36756003)(7696005)(52116002)(83380400001)(26005)(8676002)(4326008)(86362001)(30864003)(16526019)(1076003)(8886007)(110136005)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: zBfwQbzVVhoSSzxlwZh5VvQ8iapCMzDoIjjVzjUzB74+W/30xId7FoDEqxHtvSDq2Zg+kIC97D895kxrcmqVHfkynyNBH7mnfxZJcfhQSVFV6XiGhdeoW4kGmQTTMJ5FXclEy43g5qt9n36hVAXNlaSpHmRPe86wS0dx50HFomV71RGa7q9lvst5WTcNTiyWoP+56CxyBvM5KsCSGVQ3AQwInk972EcerY77+N6ht1opd42rrHnMquzzyb5CqMwg/VLZxfYgwvqQpR9aUDKivz/6DcaHjeeUS3EjBFueKkFlwVeXm9Oje5mvD38fSnlDZQ1TkTAAMptwip5uK5EAL5npFu7iaJaKqaMiceE3Eg5QPL9kynHHU5a2upr1CHp7UeKoiN11c2xjBLrbrYnfs/59bUHz3I/O9nkGEEUpvQE74FBSN02NypZjIL2L7I6SqA8JBjzxyOErPQfrfLew27esUI7cVUxoFBDdsI6pMAc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0457a30-4c58-49ee-ecb1-08d811a49783
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 03:23:09.1646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpIul438m/90bk6jxVPOWKp/eftWk9VA57kAsWXbsJhHiKeIIiOKykwBbO0DkBU2luK0Mogws/CehbwqqdnggQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4123
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4298fe783=Anup.Patel@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 23:23:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

We extend RISC-V spike machine to allow creating a multi-socket
machine. Each RISC-V spike machine socket is a NUMA node having
a set of HARTs, a memory instance, and a CLINT instance. Other
devices are shared between all sockets. We also update the
generated device tree accordingly.

By default, NUMA multi-socket support is disabled for RISC-V spike
machine. To enable it, users can use "-numa" command-line options
of QEMU.

Example1: For two NUMA nodes with 2 CPUs each, append following
to command-line options: "-smp 4 -numa node -numa node"

Example2: For two NUMA nodes with 1 and 3 CPUs, append following
to command-line options:
"-smp 4 -numa node -numa node -numa cpu,node-id=0,core-id=0 \
-numa cpu,node-id=1,core-id=1 -numa cpu,node-id=1,core-id=2 \
-numa cpu,node-id=1,core-id=3"

The maximum number of sockets in a RISC-V spike machine is 8
but this limit can be changed in future.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
---
 hw/riscv/spike.c         | 237 ++++++++++++++++++++++++++-------------
 include/hw/riscv/spike.h |  11 +-
 2 files changed, 169 insertions(+), 79 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index a3db885ffa..29e7270035 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -36,6 +36,7 @@
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/spike.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/numa.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
@@ -64,9 +65,14 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
-    int cpu;
-    uint32_t *cells;
-    char *nodename;
+    uint64_t addr, size;
+    unsigned long clint_addr;
+    int cpu, socket;
+    MachineState *mc = MACHINE(s);
+    uint32_t *clint_cells;
+    uint32_t cpu_phandle, intc_phandle, phandle = 1;
+    char *name, *mem_name, *clint_name, *clust_name;
+    char *core_name, *cpu_name, *intc_name;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -88,68 +94,91 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
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
+    for (socket = (riscv_socket_count(mc) - 1); socket >= 0; socket--) {
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
-    }
+            name = riscv_isa_string(&s->soc[socket].harts[cpu]);
+            qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
+            g_free(name);
+            qemu_fdt_setprop_string(fdt, cpu_name, "compatible", "riscv");
+            qemu_fdt_setprop_string(fdt, cpu_name, "status", "okay");
+            qemu_fdt_setprop_cell(fdt, cpu_name, "reg",
+                s->soc[socket].hartid_base + cpu);
+            qemu_fdt_setprop_string(fdt, cpu_name, "device_type", "cpu");
+            riscv_socket_fdt_write_id(mc, fdt, cpu_name, socket);
+            qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle);
 
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
+        addr = memmap[SPIKE_DRAM].base + riscv_socket_mem_offset(mc, socket);
+        size = riscv_socket_mem_size(mc, socket);
+        mem_name = g_strdup_printf("/memory@%lx", (long)addr);
+        qemu_fdt_add_subnode(fdt, mem_name);
+        qemu_fdt_setprop_cells(fdt, mem_name, "reg",
+            addr >> 32, addr, size >> 32, size);
+        qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
+        riscv_socket_fdt_write_id(mc, fdt, mem_name, socket);
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
+        riscv_socket_fdt_write_id(mc, fdt, clint_name, socket);
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
+
+    riscv_socket_fdt_write_distance_matrix(mc, fdt);
 
     if (cmdline) {
         qemu_fdt_add_subnode(fdt, "/chosen");
@@ -160,23 +189,58 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
 static void spike_board_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = spike_memmap;
-
-    SpikeState *s = g_new0(SpikeState, 1);
+    SpikeState *s = SPIKE_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
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
+    char *soc_name;
+    int i, base_hartid, hart_count;
+
+    /* Check socket count limit */
+    if (SPIKE_SOCKETS_MAX < riscv_socket_count(machine)) {
+        error_report("number of sockets/nodes should be less than %d",
+            SPIKE_SOCKETS_MAX);
+        exit(1);
+    }
+
+    /* Initialize sockets */
+    for (i = 0; i < riscv_socket_count(machine); i++) {
+        if (!riscv_socket_check_hartids(machine, i)) {
+            error_report("discontinuous hartids in socket%d", i);
+            exit(1);
+        }
+
+        base_hartid = riscv_socket_first_hartid(machine, i);
+        if (base_hartid < 0) {
+            error_report("can't find hartid base for socket%d", i);
+            exit(1);
+        }
+
+        hart_count = riscv_socket_hart_count(machine, i);
+        if (hart_count < 0) {
+            error_report("can't find hart count for socket%d", i);
+            exit(1);
+        }
+
+        soc_name = g_strdup_printf("soc%d", i);
+        object_initialize_child(OBJECT(machine), soc_name, &s->soc[i],
+            sizeof(s->soc[i]), TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
+        g_free(soc_name);
+        object_property_set_str(OBJECT(&s->soc[i]),
+            machine->cpu_type, "cpu-type", &error_abort);
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
@@ -249,21 +313,40 @@ static void spike_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
+}
 
-    /* Core Local Interruptor (timer and IPI) */
-    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
-        false);
+static void spike_machine_instance_init(Object *obj)
+{
 }
 
-static void spike_machine_init(MachineClass *mc)
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
+    mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
+    mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
+    mc->numa_mem_supported = true;
+}
+
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
 }
 
-DEFINE_MACHINE("spike", spike_machine_init)
+type_init(spike_machine_init_register_types)
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index 1cd72b85d6..b0a18a9c94 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -22,12 +22,19 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 
+#define SPIKE_CPUS_MAX 8
+#define SPIKE_SOCKETS_MAX 8
+
+#define TYPE_SPIKE_MACHINE MACHINE_TYPE_NAME("spike")
+#define SPIKE_MACHINE(obj) \
+    OBJECT_CHECK(SpikeState, (obj), TYPE_SPIKE_MACHINE)
+
 typedef struct {
     /*< private >*/
-    SysBusDevice parent_obj;
+    MachineState parent;
 
     /*< public >*/
-    RISCVHartArrayState soc;
+    RISCVHartArrayState soc[SPIKE_SOCKETS_MAX];
     void *fdt;
     int fdt_size;
 } SpikeState;
-- 
2.25.1


