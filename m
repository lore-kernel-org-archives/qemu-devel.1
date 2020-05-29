Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC95C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDF9207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UHKN6JOg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="O3kQPHrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDF9207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedVf-00043u-UJ
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=411e18819=Anup.Patel@wdc.com>)
 id 1jedUB-0002Jt-EE; Fri, 29 May 2020 07:47:39 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=411e18819=Anup.Patel@wdc.com>)
 id 1jedU8-00074G-Aj; Fri, 29 May 2020 07:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590752857; x=1622288857;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=tin4Z3I5T5L6XJr4+RzoDa51bZ9dBU4UMizRsiTzzQk=;
 b=UHKN6JOgEjsTnx2xAnRvDCZm3CXD2K1rB7c3z7Pn5kzmW2Y2ucTrDUVq
 PMjd1lpxxTQ/pg29srfmaNFod+78yX7YMdXWhM6w65gAfIFnA7Iw9Y4Cl
 jXrMUBZXGchTILr9tlGG0UTLdMCaJurvufensij932vtp0mnmVEDhTEWS
 YF+kv+UYlbVbnbGpMcYSUM+mtSMYJt0YYQiAS/65eUB2HrhjWY5Hrqr58
 zL9WquCcMi4Gi8vd2rOLUCCXREDQ01vEcqpmkJHNMu4N4K9Hzkk31YYsh
 3LbbgV613jw/fLsuZRD0gTYaJN4AvCUVuZVuNNKoP2U1lsKiqQRuCVqmy Q==;
IronPort-SDR: pzNw8DvEqdA5EzyvzM2Z4jqbZ5uGQi0sU6Rt1BI/n4fNZW+25OphuNN6fzmikLtTaQHVBrgh6u
 f94cZjhxLVTMFK6/3GpGSvpsJNKXDOKZcO8DqOIAZprtvt437b72Gmhk/ubZ1HEzEgFKmiD58E
 VbUNoneZh7K5UftMTk6AY1UUhtRMOqqaE3QdiaI24r2MS6jVecDG6ITyEE+BRZs5A3MKzu/f5M
 4ogtB3Me5JYb2TjAPwe0MhU/QM9NUCSvZ1MqXSThOLdu0IT2KnNDBNZxC+PQ/YZo1pIS/0J/ML
 /Yo=
X-IronPort-AV: E=Sophos;i="5.73,448,1583164800"; d="scan'208";a="143123954"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 19:47:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+Z5dBMGH0VdMWkvTrfvZ7AKtYQU9FdAFXtXzVjUVUtxB5ItKAaUsCv2FpGa2gPCLq3bdDwO9Vrwsh0NVud28rNoMfL8YHd10Trpsiqx3X7y8Gu+kGobcF3SiBIqELh+OFRkO8Rf+RhQAqPPXwaeYrlm5c8Z+wF7FaGahCvA4adDrH6kQRXX/NU3XtbwLcT+Vs11zWm/KuFb2+/INKE14Y7hbdjnRzJNl98Vhwxn5z85FGRr6RoJYOBQAFskXGr3nJKbjyD3KAGOKgbQLH/ZZUpOBvNoiXsao7c+PDosJQHpYw2x5OrKVnjj2pVXNxsDgLeCQAW2Bch3q4RaHTP6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FFXfz9dWdFSnHbkURxZnQJgCjvEUyVQ2KwKa/qurt0=;
 b=jvKtc9WrjJwPFrHA+NavsGlBi7waG4Frq7ceakTyoTGIvGdWF6WGbsMnvSorThNub/H+UrmM8mKdMGp1ul1QrSmqbRGy4+35PKCRkUvImvzXEA0i6reMFM0oSRr06suMq3fWuep/74ISPu853imXt/CSnYn0x2rm6anaEDzCgFBjvWlv+zWIwaJF1MFgFLImpzK9ZhFXpSCyZPnL58ej9qPEl9tsYMGjzpJIX+swuM88BttS4blNhYm+JQgf0JhgAsI0V3SgN0HHDN7QoY2OuRknYsgSuPcAqiF/g50SEUsTPDRdUV/OFVHW1Ab7FLsujWpLQmhnXsr20AdahnUNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FFXfz9dWdFSnHbkURxZnQJgCjvEUyVQ2KwKa/qurt0=;
 b=O3kQPHrE8Jmxo+YTrn6tsiCQF/TZnaBaCokXR+fBQqtlBqVc9oaIsH1Fo51hsY6xiQcjlp1zZferiZJfdhwjmG9uZ1/qtntJ1xhYoZLdJsZnI3xEy5viHeU+3f20PwWkQH/L8yiLsZzpO+gQUS8So2zgbPtTzc+VDdPiVpf5wcg=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB7019.namprd04.prod.outlook.com (2603:10b6:5:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 11:47:30 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 11:47:30 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v5 4/5] hw/riscv: spike: Allow creating multiple NUMA sockets
Date: Fri, 29 May 2020 17:16:40 +0530
Message-Id: <20200529114641.121332-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200529114641.121332-1-anup.patel@wdc.com>
References: <20200529114641.121332-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::19) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (106.51.109.153) by
 MAXPR01CA0101.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 11:47:26 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.109.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed1a961e-1086-45e7-b4dd-08d803c61160
X-MS-TrafficTypeDiagnostic: DM6PR04MB7019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB7019AA3EEA314695EC7E06FF8D8F0@DM6PR04MB7019.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NUGUPJ1SnckKPnzrxUQ4uUeiNiDzCfDUR3ylgFUdiBT1ytHh8wWc6iYhhkaA+8DsV2o7I5QN/g/836MKiDffCEkH83pEDH7M7s8XXIrg95/5bd+Ypa1UNna0SDN4+wFG5v4HjoMbwt8/hJZgN/dDUXHntVnogZgDAMVsJXkRf/BdhN6BgH6WjhCtoglFjMB0jiVDe2I6HSyL9kV4XsnfUWsdUUFvd2IrKEfOL7pkXPnz6b8cdsVVv+/vjcHn+0/CwlKLzH1LzyxXgoiO8fF4snMzFMLOytREod2Gwol3VsyZz3uCXI675oLVnI54uwm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(8936002)(83380400001)(8886007)(2906002)(186003)(478600001)(6666004)(316002)(1006002)(36756003)(54906003)(55016002)(1076003)(30864003)(110136005)(66946007)(26005)(16526019)(956004)(86362001)(2616005)(66476007)(66556008)(5660300002)(7696005)(52116002)(4326008)(55236004)(44832011)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UTnwRArkfMVoZzq5gL+y1Aq+qwpkyMFbA0l73TZrmDehlDCIHOi8xQKJs4BnmcpKQL2JvR1QbElWn1WCmW5tfUK6Obs2G6qAJoPI4JI1PvZ09U4h34mP3BONZHy0MC0iNoXkHvWIs5nCn5rEOzkxQfEJ6fU0OhJsbQUq98ceeIz12u6+djXDz/9+t0wBdn/Fw5vt4NguzLARAqzsZHmfyb78ua1Y+ke5HkpXqifCdFVmBsyOYBrqOZ1B0SiuvH1/GsImWyavthEjkhdH4GU96Ce1z1cJkc9goMQVHA7+tZq9polEAZUkZC2eDtHiTbNv1kSNmXCxz6H/TEhPsAo/m67CKEJsf0DMsFGuyuxQjWdwQJD+4kp0vMCUQV18daIfJMdww2sq8+9PkJOUmM90LzpzNd0HV943JsHj4eXhpXjE7qPKKggDwDoqURFOYBAxC2dn5GOHKaV1oEm67rRYIu17X8trwbue/Ie35lMUBlg=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1a961e-1086-45e7-b4dd-08d803c61160
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 11:47:30.7210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCjo5C4MVfapmgl4J1GHrmzyA4tUkB5yjPmSPt26ib0YzIJ40MjWQr/fBsOdhE0HDiqFKyBzi4egdKDmQFDvIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7019
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=411e18819=Anup.Patel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 07:47:33
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
---
 hw/riscv/spike.c         | 268 ++++++++++++++++++++++++++-------------
 include/hw/riscv/spike.h |  11 +-
 2 files changed, 187 insertions(+), 92 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index d5e0103d89..b8373eb1eb 100644
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
+    char *soc_name;
+    int i, base_hartid, hart_count;
 
-    /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-                            &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
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
@@ -249,12 +313,8 @@ static void spike_board_init(MachineState *machine)
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
@@ -275,13 +335,14 @@ static void spike_v1_10_0_board_init(MachineState *machine)
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
@@ -339,7 +400,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -365,13 +427,14 @@ static void spike_v1_09_1_board_init(MachineState *machine)
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
@@ -425,7 +488,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
         "};\n";
 
     /* build config string with supplied memory size */
-    char *isa = riscv_isa_string(&s->soc.harts[0]);
+    char *isa = riscv_isa_string(&s->soc[0].harts[0]);
     char *config_string = g_strdup_printf(config_string_tmpl,
         (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
         (uint64_t)memmap[SPIKE_DRAM].base,
@@ -448,7 +511,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom,
+                 &s->soc[0].harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -472,15 +536,39 @@ static void spike_v1_10_0_machine_init(MachineClass *mc)
     mc->max_cpus = 1;
 }
 
-static void spike_machine_init(MachineClass *mc)
+DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
+DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
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
+    mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
+    mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
+    mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
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
index dc770421bc..c55fdf4d24 100644
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


