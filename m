Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6190FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100EE20787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ctp3K9Kx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sIu2xOwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100EE20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdovm-0003ik-74
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqd-0003x8-QE; Wed, 27 May 2020 01:43:27 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqa-0003aK-93; Wed, 27 May 2020 01:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590558204; x=1622094204;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ARONbspMbdJkqwXu541gKVEiGwk7yaXClWIWIjNXbdg=;
 b=Ctp3K9Kx/dAfVYvwSqYfgHl2Z0NYpAtYbqXqc/cntSLsYQ1focWWQSf1
 Nk/FxOnEoS3EG7B0xJ8QqJMjc4/Jd6QJ0Rqp07zstPzILvQ7lp3oAqMd9
 GHhhloiWrNwEeOby1qcXN/avh7qFNk+l7Ri9I+7lXZzysxPwQAhXoF/1O
 FWzcUP6EjSH8i/uN1xQ1gTjPijXQTxqtvp4QWIL0Ewb7+BzInWUGYo1TH
 HiM9FHcUx/sM8DFo5k2xgAm7uKclgmjTqHMRLCCT6J6VMfSlHIXpYIIcg
 MxVQ/M8AmdEDKf92xNJZQ2gnCYdBc70ANpQeQz9Wwkr83pk/cQqSr76jq g==;
IronPort-SDR: Ak+Bk+cFrMyCYPe784Nn5POf3RsVzZCAtHcLIf/PskRYONroO2Os8ZrHzwk049G46a5L5keceR
 cUX9DmRgy/ml28fLCheJfFe/P2dQOao2spUWW9BLAfaAd/ELulpEKI7ASMUlx39Q0DTQq67HLc
 u6Hg9AU34UjilwI7zbIw82GPtpFVtRo8ck1j6Uos2lc313O8NLE9M3gw7w1rTxvZeDB53ibLLl
 V9Qm8ppKWUcT4Z3asutY1Ll7ej31ndnFqr5FBS8KoqVuFEOVP0S0d5+CQQVpk3oL9LlpkjGaPA
 9Ng=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; d="scan'208";a="247638110"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 13:43:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKIaYC55p6BBharsrPAsWLF0qtkhA7N7QsV3z70eaxFgyG+fQZG2XxkvBNhhy9xjYe6zGTahddobMoRW6aqidws7JgzAF3+S+xA6Cw8fsdJTQW3Ec4bpUkgc1RN8j6PwH7ajwr0+XhhAi4YvDPJKWxkJoQlbFFXpQcXFQzg6jg2VMTMWRMvKuwwG8OJ/s0zhtSc69DpHD1QjBc9+n9cxOHhh1cE4ccAWkoGm2ytm8yXkU6Td7YRkJP0HVyc2U4YKxdJsPDZatIiNEdHxSWml8CnUsBPKxAyJpljinOM9cVIbNjOV8OHnpnBl0FD4Nive2VzYIUQIvPbkRKt6mf0m7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeGR7JWbGx7VTKIqPsE7IzkUgnW6JFInjiZuvEDPijg=;
 b=NKVg489SSOtYmd57406C6KrZQKpLWc87uphQr/uIu5i8TP/uXpxpLbQNB8hGNDa+wxn7nINpkTRJ03Ua5f3yjH7hpDyCdNiPAGdMNiVCdIcUH0nVfMxIfUH97hxhDVKSuCJmppOjn+8paq90E0R7F44MTi7UY9Eq2+4YFYYzOnNbdc2POSngDSA9dGFjtH40wwLj1Qwzp0Nb6nKKlk14ay4d67G2S/L1063DGG9dwuYw4eSS+WudDA7F4OXPdj++1U6vqYXS85ZxipNfsxBXMYPNjvTJEzkfqd9oJmDhnUY9A4mtSvOetzfM0zBnILyz6JnKcEdx6MI4YiUA85fpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeGR7JWbGx7VTKIqPsE7IzkUgnW6JFInjiZuvEDPijg=;
 b=sIu2xOwWcILSuA9Y/OFGjbyKuM6aA7Zmig/fYpxxfHOPZsAkYjr7dBS00boFfa63vhJcnF4eh9VwSVNzVbTXd42jJCbPn9wnCwOEsJsiBOTTDlCfHvzuy/Lpf2EQ+XJrwD3eYI7M/4raHd6/Uo4y/HV6YIWylXuSGJKiHCaSf44=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6923.namprd04.prod.outlook.com (2603:10b6:5:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 05:43:21 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 05:43:21 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 5/5] hw/riscv: virt: Allow creating multiple sockets
Date: Wed, 27 May 2020 11:12:26 +0530
Message-Id: <20200527054226.232103-6-anup.patel@wdc.com>
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
 Transport; Wed, 27 May 2020 05:43:16 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab18b043-989e-47d3-48b4-08d80200dd52
X-MS-TrafficTypeDiagnostic: DM6PR04MB6923:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB692365C19CCA975C8DE259408DB10@DM6PR04MB6923.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:459;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrPWc/G2B14uW0QW+M0W7ZHSEChlUmCUTdzqZ4yCcZeqQoNtZC4lCkPkPnPIKilTASQ2PWyCVAtxcnelSsNO8ix9iC3DizHZ5OLSgvSWlLQPpufTN9WQHWk4ZLjXsFoaMX9HURaiBtK5Hbly7rZVKEFwx3zPuRGVs8+KnsJcrQhlp0hjJjZD2atM/sqbDJi0gDuO+fG3xVUQ/ZfBDeowUvyskl5j5EJ2UoXL039ogvBJ/F82jI7ERx6JB9c2PILPF3DyE47p3/Oi/KvX7sjLFfwkOd2jmSL7H/nhT+laTak+7X8MYeG27rkNGhdgahdvAu/W3dBcvuxpJDlSJzbQjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(1006002)(110136005)(6666004)(316002)(1076003)(8676002)(30864003)(2616005)(5660300002)(956004)(8886007)(8936002)(36756003)(44832011)(4326008)(54906003)(186003)(16526019)(478600001)(26005)(66556008)(2906002)(55236004)(66476007)(7696005)(55016002)(86362001)(52116002)(66946007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZoTIJo+tJDNv1iMC5J04EZc6pjzJ7pO8rDVj3crdBBh7qy8cfkoukIrwBH+X5srQdPWfEQk4mVMQ1ebXrmCspk37TvvaiuKLBcwRkZcpb5bN60acy0LDw+2Fk394B02Yw6Wgkyrrh5yNWPe9mANREVH/53eBVwV005aD86XtvkkuLXXr1U/dRu0yQElmIBGCxPZu0L8k57qABICdaC2v9ucArlKeRIFik0yj8I9LedGEggsTW0PDjAiqV482K2W1ivNKlGE01YxEAXj35cM2bvytd3TKmPTQzQMqZuWId5vcgXy7n+syw65ciYhuQMiuxNj4NMPbjqn+ZP4qSXTEBDbxIJBTpyMQ4ZEn/FGGR7mNtgqMC36iV7dJ01o00PGv5PYvXga/By7ZASnWv6zV6h+HKMXLyrZZmkbwAuFGPRb8acaXlqDpzpqe/koAAbrG4BlJ0dIQT2IKUm0JOoAjOaQJNGPO7UiMtjpEAzPNJcI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab18b043-989e-47d3-48b4-08d80200dd52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 05:43:21.3965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbaGd1wDZgt7e+sgNs0qKNFlqTEQHvWWSQGxy+6B2gipyJ8GEtFF/Lsi1gEdzBoHrv40rNedSgfLyAYlVmIQgA==
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

We extend RISC-V virt machine to allow creating a multi-socket machine.
Each RISC-V virt machine socket is a set of HARTs, a CLINT instance,
and a PLIC instance. Other peripherals are shared between all RISC-V
virt machine sockets. We also update RISC-V virt machine device tree
to treat each socket as a NUMA node.

The number of sockets in RISC-V virt machine can be specified using
the "sockets=" sub-option of QEMU "-smp" command-line option. By
default, only one socket RISC-V virt machine will be created.

Currently, we only allow creating upto maximum 4 sockets but this
limit can be changed in future.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/virt.c         | 498 ++++++++++++++++++++++------------------
 include/hw/riscv/virt.h |  10 +-
 2 files changed, 284 insertions(+), 224 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 421815081d..0c04a5493b 100644
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
@@ -182,10 +182,15 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
-    int cpu, i;
-    uint32_t *cells;
-    char *nodename;
-    uint32_t plic_phandle, test_phandle, phandle = 1;
+    int i, cpu, socket;
+    uint32_t *clint_cells, *plic_cells;
+    unsigned long clint_addr, plic_addr;
+    uint32_t plic_phandle[VIRT_SOCKETS_MAX];
+    uint32_t cpu_phandle, intc_phandle, test_phandle;
+    uint32_t phandle = 1, plic_mmio_phandle = 1;
+    uint32_t plic_pcie_phandle = 1, plic_virtio_phandle = 1;
+    char *name, *cpu_name, *core_name, *intc_name;
+    char *clint_name, *plic_name, *clust_name;
     hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
 
@@ -206,231 +211,235 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
     qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
 
-    nodename = g_strdup_printf("/memory@%lx",
+    name = g_strdup_printf("/memory@%lx",
         (long)memmap[VIRT_DRAM].base);
-    qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_cells(fdt, name, "reg",
         memmap[VIRT_DRAM].base >> 32, memmap[VIRT_DRAM].base,
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
+
+    for (socket = (s->num_socs - 1); socket >= 0; socket--) {
+        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
+        qemu_fdt_add_subnode(fdt, clust_name);
+
+        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
+        clint_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
+
+        for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
+            cpu_phandle = phandle++;
 
-    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
-        int cpu_phandle = phandle++;
-        int intc_phandle;
-        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
-        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        char *isa = riscv_isa_string(&s->soc.harts[cpu]);
-        qemu_fdt_add_subnode(fdt, nodename);
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
+        clint_addr = memmap[VIRT_CLINT].base +
+            (memmap[VIRT_CLINT].size * socket);
+        clint_name = g_strdup_printf("/soc/clint@%lx", clint_addr);
+        qemu_fdt_add_subnode(fdt, clint_name);
+        qemu_fdt_setprop_string(fdt, clint_name, "compatible", "riscv,clint0");
+        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
+            0x0, clint_addr, 0x0, memmap[VIRT_CLINT].size);
+        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
+            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
+        qemu_fdt_setprop_cell(fdt, clint_name, "numa-node-id", socket);
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
+        qemu_fdt_setprop_cell(fdt, plic_name, "numa-node-id", socket);
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
-    }
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
@@ -478,21 +487,92 @@ static void riscv_virt_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    char *plic_hart_config;
+    char *plic_hart_config, *soc_name;
     size_t plic_hart_config_len;
     target_ulong start_addr = memmap[VIRT_DRAM].base;
-    int i;
+    int i, j;
     unsigned int smp_cpus = machine->smp.cpus;
+    unsigned int base_hartid, cpus_per_socket;
+    DeviceState *mmio_plic, *virtio_plic, *pcie_plic;
+
+    /* Figure-out number of sockets */
+    s->num_socs = (machine->smp.sockets_specified) ? machine->smp.sockets : 1;
+
+    /* Limit the number of sockets */
+    if (VIRT_SOCKETS_MAX < s->num_socs) {
+        s->num_socs = VIRT_SOCKETS_MAX;
+    }
 
     /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-                            &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
+    mmio_plic = virtio_plic = pcie_plic = NULL;
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
+        /* Per-socket CLINT */
+        sifive_clint_create(
+            memmap[VIRT_CLINT].base + i * memmap[VIRT_CLINT].size,
+            memmap[VIRT_CLINT].size, base_hartid, cpus_per_socket,
+            SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
+
+        /* Per-socket PLIC hart topology configuration string */
+        plic_hart_config_len =
+            (strlen(VIRT_PLIC_HART_CONFIG) + 1) * cpus_per_socket;
+        plic_hart_config = g_malloc0(plic_hart_config_len);
+        for (j = 0; j < cpus_per_socket; j++) {
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
@@ -571,38 +651,14 @@ static void riscv_virt_board_init(MachineState *machine)
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
@@ -611,14 +667,14 @@ static void riscv_virt_board_init(MachineState *machine)
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
 
@@ -628,8 +684,6 @@ static void riscv_virt_board_init(MachineState *machine)
                                   drive_get(IF_PFLASH, 0, i));
     }
     virt_flash_map(s, system_memory);
-
-    g_free(plic_hart_config);
 }
 
 static void riscv_virt_machine_instance_init(Object *obj)
@@ -642,7 +696,7 @@ static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "RISC-V VirtIO board";
     mc->init = riscv_virt_board_init;
-    mc->max_cpus = 8;
+    mc->max_cpus = VIRT_CPUS_MAX;
     mc->default_cpu_type = VIRT_CPU;
     mc->pci_allow_0_address = true;
 }
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e69355efaf..d634f2d140 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -23,6 +23,9 @@
 #include "hw/sysbus.h"
 #include "hw/block/flash.h"
 
+#define VIRT_CPUS_MAX 8
+#define VIRT_SOCKETS_MAX 4
+
 #define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
 #define RISCV_VIRT_MACHINE(obj) \
     OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_MACHINE)
@@ -32,8 +35,9 @@ typedef struct {
     MachineState parent;
 
     /*< public >*/
-    RISCVHartArrayState soc;
-    DeviceState *plic;
+    unsigned int num_socs;
+    RISCVHartArrayState soc[VIRT_SOCKETS_MAX];
+    DeviceState *plic[VIRT_SOCKETS_MAX];
     PFlashCFI01 *flash[2];
 
     void *fdt;
@@ -74,6 +78,8 @@ enum {
 #define VIRT_PLIC_ENABLE_STRIDE 0x80
 #define VIRT_PLIC_CONTEXT_BASE 0x200000
 #define VIRT_PLIC_CONTEXT_STRIDE 0x1000
+#define VIRT_PLIC_SIZE(__num_context) \
+    (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
 #define FDT_PCI_ADDR_CELLS    3
 #define FDT_PCI_INT_CELLS     1
-- 
2.25.1


