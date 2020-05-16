Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B62C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 06:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D6C2065C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 06:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ROBMQdsL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TGbENDis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D6C2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZqUJ-0002HF-K0
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 02:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=398f0481b=Anup.Patel@wdc.com>)
 id 1jZqSl-0000OT-Pp; Sat, 16 May 2020 02:38:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=398f0481b=Anup.Patel@wdc.com>)
 id 1jZqSj-0001eJ-LM; Sat, 16 May 2020 02:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589611104; x=1621147104;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=naRE2A+iZ9jdKKHFzWNUkgdn0/47HhZlNnOO9tCSwro=;
 b=ROBMQdsLBzJsrmY4Njmr4WTxNT9JHH50AHU6CXD2L7ucNewqZxq/h8RA
 9UwJ1TwVtvyQJCreB0PcSUed9R2v9pReyjXgbSVdvlTP0wsS/Az2A939k
 wBeggdQredp51INl/ergiqc86fdggs/Z/oulk9X/Icl9KTDJXiaknSa14
 WwGhNGWNG84pjkdzbRmEFJpQMWY3fLztqf+s27E7fphgnrgjDS0vauWT1
 lzhaNYMU+VMQ/PB/esOgdpvRcf7K/MWL+gfKVQf+t67CigQ81CSLERO7x
 xxSdnfSHjUf4C4ye3NDVVoFqPZ/o9qx7qC40bYCMHoKTZaSciOguF1Nwj g==;
IronPort-SDR: Cf0Ueb5nMq/1+PKrzSeRVbaQx4KSh+vcVRANOAtDRTlJySTZKTjIrnIOlWN0zPcjHaDmvDh2G2
 lGWGsIz+xzqAkwS+93GFHyk9hCam57cYJEGVdAxb9OsPXQ7s3bhg1t4bISkMqlpwK1O09vWNYX
 Ym5/6XbxOwG0yijfSjsaDN9kPMKLDgj/ejKl6H/sTUT6t3MxKraUdQvNNfwSokmBlZXALf0rnj
 e6PUEUAFtDo3Z1UbQBzZrXvvj6+fEiAl78tM6aFfMdTPsWMIZf46JE4sovWvvBvXghemzmIj/i
 w8M=
X-IronPort-AV: E=Sophos;i="5.73,398,1583164800"; d="scan'208";a="240555178"
Received: from mail-sn1nam04lp2051.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.51])
 by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 14:38:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNdztSbjkbvYba60HJVxU0GdYKzrXFGm10tJv2GyPm1gYJHWwSLAwK2tO/p+/bS2/hC2WYSiuiXGw96S30Vc7EU6ftr0XfjOWEbgsBmgAVQjtsFiDpG9i1MPS9XRzA9yzg3nN1MZoGNUadNlL5AAwJv38nFnRjYSYdM8JqVZnku/uZMbAlkiz0fs/xuvtTWihnErnTdKypNrSYMyGNnUz8j/e6fnmY6G0PdX94zVq6Z0ZKsYo+Sa3dkoBCGb6ELPLrWy9RhcQBsir87uRlng062A971tRVA3KTlvIOCwwVDMTsKMAkmJIJLzraXjwmfMzqSkCdnMN0Qm0SxfVnHRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osvLFx/xX2GrjMRLWbTNdRY3x6zQuZQaA2hsGgIuUiA=;
 b=IDQVbEPFNvpWvzQTaMwS5K6zNoiMizRek/1oiMMozohJ7oIMz1afe7gqiRKkajdR7RW6nJn3y4Covjjhg/ZSUocZsONUFlfc1BZMwkzRp3eIxBmlEwrt1DI8gTSoUVXlKmmIqYe2ishgQkFVIySshI+XKpwaDzHFrK0ZRkbfbCbPkmHUA0K/laiajBeRYjCXeo3H5UU287JDizthc7UVVZ36uM93wUERrwuZN+ul98qFy6x1YN8wIbB+6P+0cbkpTvVPcdPSiMjlrF3Qa4eCNIuGu9qnQa7PQ5M8dkyrjzoWXWAuvhAGw7jnBBDzKjnXzSxm8zgVBHOQbSc3Qmc00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osvLFx/xX2GrjMRLWbTNdRY3x6zQuZQaA2hsGgIuUiA=;
 b=TGbENDisxrVObTKwEiOrZ8yTCK5XB/qFS57p9PERz8n/MzBEwMf4YAH3HGYrWCoGmdAQwRlu8kyvRFo0SpNa3rKWCY344BsmT+AhAK90/p53dpcTWg2ygcbcRG0BsUymlDXmguaWETB8Syt4H2lh0XKBVbzZcP/HoDjiyv5SICQ=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4539.namprd04.prod.outlook.com (2603:10b6:5:2c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Sat, 16 May
 2020 06:38:18 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2979.033; Sat, 16 May 2020
 06:38:18 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 2/4] hw/riscv: spike: Allow creating multiple sockets
Date: Sat, 16 May 2020 12:07:44 +0530
Message-Id: <20200516063746.18296-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200516063746.18296-1-anup.patel@wdc.com>
References: <20200516063746.18296-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::27) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (49.207.60.36) by
 MAXPR01CA0109.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.25 via Frontend Transport; Sat, 16 May 2020 06:38:14 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.60.36]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ebf73ae-54c0-460c-9568-08d7f963b7f3
X-MS-TrafficTypeDiagnostic: DM6PR04MB4539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB453906E84476823D07ED21C18DBA0@DM6PR04MB4539.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 040513D301
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLVS3nxiF6r8uFIX26FHyGayZDS8SpelHFTGQUvfmuBnlFsmUjf2+hCu82Jfjg32d40qo3zunz4CRllbhdiXRQkgNvTnKFe+K5iIMvhnboWrtoDjMC1Hsc4339Npzgg4k/FTUImqvGuDC2naMcbYforEaqhjdNu/zo78415y24SsWHbo80Mvu43eLTBBZOLpkgOrlAYjPq1h4BnP0k9ImeSn5AnwysGE9eKDY3htlss8n4I7p4SyJ9XV7+uMggG0VeoSndG1NWVYq7b7FV0yyzV3dFnJr/p4DDc6MguSynHvrHtM4ZROHj3+WeWDctRthz5iJU3kM4u7Qk77AuHZ9w/2CaDYhcLmv1nZBRnPf2AS7anPlqqOqIknPyRZSeDRVr6sVnD8ulj1/jANbF6+T5e34Ceo69bWEqpsXjsCl5UA7qPcN2jjA4OP6s5bkPN0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(6666004)(1006002)(2906002)(8676002)(30864003)(36756003)(8936002)(44832011)(26005)(54906003)(86362001)(7696005)(52116002)(55236004)(110136005)(1076003)(16526019)(186003)(316002)(5660300002)(66946007)(8886007)(55016002)(66476007)(66556008)(478600001)(956004)(4326008)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ei5PypnS7cIgw2altPvHNSv7LjMKP8Zhp3+YJ8gMeVU9vodCGo9uAvgsl0mN8gzDRWf434r7wTHRlLYzjjHrLbiAZcftN8SSH9ksT4TB7u2YhT6JilxUE2X7+zK3T1HQ9/HFTbvqX79Rw5lz6BFzFZ8wY0GqczJ/zXicOBSlHnTMQ8Dbx2iSKLh4jxLS83VFeR79wed0W5BUfqvR12oCxNN7hPDmv1/YWC8zYDHJUd2HLRXcpl2BJwnZ+AUTgK1SwX4yYX3bnd+yN7dE7iTVy+k/RunGBrToEvypCNXWfDdtFdRbLqJr+2CiXRrF8p9Exhj/lY70KVijOQNj24Z5XDWlGJ2uq6pOSbQYKnCieQWbJBUhWjy8CMaELjGwuwGsWFgY6JStOjj7uybhSZwzLh5lewbd3STX7wkqpzd1pCAQuOao17pyx/hkFZlPlGuv33Fj+HoIdNB3eQcFL9OzVVXkOOoskq/yVa8FWbWyHEE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebf73ae-54c0-460c-9568-08d7f963b7f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 06:38:18.3454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5ANIaDa5kmv+Lk6p3TxQzFLSJsf2l/y47k28Iu0ZWKR5Ol6W+p8Pco1Yq6mGnsDrXFlU/tmqChfGSTf5ksSfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4539
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=398f0481b=Anup.Patel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 02:38:11
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

Currently, we only allow creating upto maximum 4 sockets with minimum
2 HARTs per socket. In future, this limits can be changed.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/spike.c         | 206 ++++++++++++++++++++++++---------------
 include/hw/riscv/spike.h |   8 +-
 2 files changed, 133 insertions(+), 81 deletions(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index d5e0103d89..f63c57a87c 100644
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
@@ -88,68 +90,85 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
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
+        clust_name = g_strdup_printf("/cpus/cpu-map/cluster0%d", socket);
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
@@ -160,23 +179,51 @@ static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
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
+    unsigned int base_hartid, cpus_per_socket;
+
+    s->num_socs = machine->smp.sockets;
+
+    /* Ensure minumum required CPUs per socket */
+    if ((smp_cpus / s->num_socs) < SPIKE_CPUS_PER_SOCKET_MIN)
+        s->num_socs = 1;
+
+    /* Limit the number of sockets */
+    if (SPIKE_SOCKETS_MAX < s->num_socs)
+        s->num_socs = SPIKE_SOCKETS_MAX;
+
+    /* Initialize socket */
+    for (i = 0; i < s->num_socs; i++) {
+        base_hartid = i * (smp_cpus / s->num_socs);
+        if (i == (s->num_socs - 1))
+            cpus_per_socket = smp_cpus - base_hartid;
+        else
+            cpus_per_socket = smp_cpus / s->num_socs;
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
@@ -249,12 +296,7 @@ static void spike_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
-
-    /* Core Local Interruptor (timer and IPI) */
-    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
-        false);
+    htif_mm_init(system_memory, mask_rom, &s->soc[0].harts[0].env, serial_hd(0));
 }
 
 static void spike_v1_10_0_board_init(MachineState *machine)
@@ -268,6 +310,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    s->num_socs = 1;
+
     if (!qtest_enabled()) {
         info_report("The Spike v1.10.0 machine has been deprecated. "
                     "Please use the generic spike machine and specify the ISA "
@@ -275,13 +319,13 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     }
 
     /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+    object_initialize_child(OBJECT(machine), "soc", &s->soc[0], sizeof(s->soc[0]),
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
@@ -339,7 +383,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom, &s->soc[0].harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -358,6 +402,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    s->num_socs = 1;
+
     if (!qtest_enabled()) {
         info_report("The Spike v1.09.1 machine has been deprecated. "
                     "Please use the generic spike machine and specify the ISA "
@@ -365,13 +411,13 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     }
 
     /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
+    object_initialize_child(OBJECT(machine), "soc", &s->soc[0], sizeof(s->soc[0]),
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
@@ -425,7 +471,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
         "};\n";
 
     /* build config string with supplied memory size */
-    char *isa = riscv_isa_string(&s->soc.harts[0]);
+    char *isa = riscv_isa_string(&s->soc[0].harts[0]);
     char *config_string = g_strdup_printf(config_string_tmpl,
         (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
         (uint64_t)memmap[SPIKE_DRAM].base,
@@ -448,7 +494,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
                           &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom, &s->soc[0].harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -476,7 +522,7 @@ static void spike_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Spike Board";
     mc->init = spike_board_init;
-    mc->max_cpus = 8;
+    mc->max_cpus = SPIKE_CPUS_MAX;
     mc->is_default = true;
     mc->default_cpu_type = SPIKE_V1_10_0_CPU;
 }
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index dc770421bc..04a9f593b5 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -22,12 +22,18 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 
+#define SPIKE_SOCKETS_MAX 4
+#define SPIKE_CPUS_PER_SOCKET_MIN 2
+#define SPIKE_CPUS_PER_SOCKET_MAX 4
+#define SPIKE_CPUS_MAX (SPIKE_SOCKETS_MAX * SPIKE_CPUS_PER_SOCKET_MAX)
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


