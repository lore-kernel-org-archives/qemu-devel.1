Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E54C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B6C20776
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e4ov34RF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SfNNTmIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B6C20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl2ED-0004NX-UV
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 23:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4298fe783=Anup.Patel@wdc.com>)
 id 1jl2Bp-0000T2-C6; Mon, 15 Jun 2020 23:23:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4298fe783=Anup.Patel@wdc.com>)
 id 1jl2Bm-0007dC-KE; Mon, 15 Jun 2020 23:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592277787; x=1623813787;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=itsAG0XTfmOAR7BnB4P9RjBCGIUIt6WWIMNonLcsJHs=;
 b=e4ov34RF9GTHAWZMomrxnIv3TmWACQr85aJ6276lFADcwwC7cLYCyYUV
 gIyHYlI7tioFEXCP9zlciz9tGjEysX2+Ii5NtxYPqSnO4dtfQDtNrcV+h
 qezpW5G6vQkaScYPrxWXSU7wywpzXSNtKHY4XQHl/jG2VxUJQ+e97eteV
 AxWUyjW/foCoYl07AU1Ye0AatEx9wWwOIpTXlHh+lY30mqPIkVUtSxczQ
 ftm0AwTXIVZjody+Y4ZPV0XWF6KmPTEaAeDRvJ8UROu51EZSVcdVc43Vm
 3QkdirDTOpt+05kjumvwfL4Ljv86LHyOfufNSpOdMPuNoXNhCrei9tLD/ A==;
IronPort-SDR: iUCwg690IM2VtgM0wyWWjXrv0+hXnQiiyRxCl14El2m8nz4RHxX2Ig+3n3Zc7y5h6Z628qKGJh
 K/XjPfa0k5pw3fHLyHp9Zj1a+ASSL3Wt8/9gtdmde26SOX6/AL2j3YK0phmJ9WZVcYbXs70qBG
 7QnzuoKvPSA+CP093N+jgqqlqA9l8ycKvGYdDFibU1j7O5BRWlx0NseVJU9YNhdzEDXslAO4Qt
 2FPrZIWS2SBgllSh74jbW8h+s6EbS2BFpEKZ3iniFZlE9gbbBNozzOvFLzB4vrXE8D2vf3ta+0
 JhE=
X-IronPort-AV: E=Sophos;i="5.73,517,1583164800"; d="scan'208";a="141476254"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 11:23:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHNAYWXLoXy6n66OnT3A7zDhAt5C0muhH4WLPAyEG0T6ugmw+p5qu6uaS3fWd/NkwlHiebDJBXx9yq2dd7J/eTNj/mWDBrrbOb4UWHyHaXFQ7H8e+Kr1hfzMSIuKnsnrGSnsLZRvEU1JHM0ZkPhXtFKayXjHBpZbhfmsA4v5HIyHHA0ehMUjfSyXOIenfy+WVAkIXKop9+JrN9oJeGwobXoaGJJZB6ySRduQHFQIetNR/vxRsyLTquWeeK9/kjH69U7dD7HzciHLTPyXNZmAclsvr9SqAkQ5RypKiJEYxMtqdqt6bqtRAF9nQ0p07Jw/AUSbwFq8J52zsan2JjQC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1UoFnBMHGDFo/lhpDYAeBqAxyZVXWgqXdU7eGZ82Gc=;
 b=ckNWY01ajzzeT31tfR4A5IHP7lqGdh0VktqxqS6MZXMPQFZKDma5LjQ6cEQjzdLqwU/rYrVJLLunGIpnhs6nKrHJmT0saXzMq+1lyq4UyGakFhhLpND445x7K9UYI5drnvKcEQtUjwsWVEnD6OgXgoGlr25+PSt3roSzbgCyEgkeIln/YvXLl8Mz5fzaHaL2BsKKn0zIONXN9H9howBpnozs49N8mVbcK2d4VjEed2iliB9rkk+8FhCSlRZZAgiV5Ah4CDIV3VeTNxsQ5QOe9yVB/sCLTRxw7JesqtJUNQO5EKpPFi4lPAk/w6Jo+Y+Y0r1qIOlH0uvCdAc1O+ksNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1UoFnBMHGDFo/lhpDYAeBqAxyZVXWgqXdU7eGZ82Gc=;
 b=SfNNTmIzoPx5PZ2ya2HI4/L9VoB1yugKGS9QVk7zq6zDYNOAheoSxR8Ea0gJsmUAqNpNQSHa39skXulLHJeP5IWTajIvbjGv/eSJFH5TPXTr6XfFrXSDU6vQeGkAj+beUI3y71LzIE8kksZcEZdYcWuBb840P6z/BUYCuqDu/YM=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4123.namprd04.prod.outlook.com (2603:10b6:5:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 03:23:02 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 03:23:02 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v6 2/5] hw/riscv: Allow creating multiple instances of PLIC
Date: Tue, 16 Jun 2020 08:52:26 +0530
Message-Id: <20200616032229.766089-3-anup.patel@wdc.com>
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
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 03:22:58 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.171.201.92]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 022e3d58-5fb9-4f26-8023-08d811a49361
X-MS-TrafficTypeDiagnostic: DM6PR04MB4123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB41235F4790F726B9AB0BEE828D9D0@DM6PR04MB4123.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9A/aPqAQMgVorHQJuO3YBajFLUJyfnrmrP2fs593DyQcnZvabQT2sxsbrNjnsqG37uyk41m1Vf0Yony37r3ZTDgcK3LGzwGtZsrGW94RRB9iJRpZ6+/LSobx60oIcFoBNTSupXLdzUhedzGA1KCW+ff8W8I54kpXuLqWYRSlOTN0/ax3InaYYbDw6ox5z3BGGnIdAqlLaxKHBAX6fvh+asuLP0S8H94U+CjTKH3IR0bp8qtQvzqo7qUzuk8MA3yGRvSAVRm8OnlgZ+E/Okrlp5W0APbh2b1/6jQfnxpyIlJsa7nrWIYlfxNyGj6YypFOiPNFvPCRAB4XrRogxos6Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(66946007)(2616005)(66476007)(66556008)(8936002)(956004)(2906002)(316002)(54906003)(478600001)(6666004)(186003)(44832011)(55016002)(36756003)(7696005)(52116002)(83380400001)(26005)(8676002)(4326008)(86362001)(16526019)(1076003)(8886007)(110136005)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ieziY19S9e8NoXb/nX6q9uN4Ql980guah7kX65LDnRloueVoTMttFHFyCxT5S3Bd84nChsfPcrqEBNou9qs2VAWlEWOj9XKiM/7T+iQm7z8Ueki09EE9c6VKa8GZNffsvyFAnxkFwoJ1ti4TvnvhwY+g11ywe49DSy/i06P3NZGIGO7XMWRe77M24TQ8edrUgD/pbCGBztyDM8qBIl4yhInSS/5TXBGqnxbsAV+3+oc9KSw8LT8qXHI4oABcTUO/fRJknbDkMsqOc/ZmUoA7WEnCmuBBdNh4voUHzLUrw3R07I1+hX+q+x/AlFUyf+Ut5ucJnPzNZoHs+MEAiUEJcMboyaWSNwMTqU9lGaUYjo3IShtYlMADYYZaWC9PXYQFivoxl/3Ba7lJIW7VocWK0M5V6DWg9Toh6dyEMzMNG06E3Itc+Sd2n/u3nBXFTEfJygsKnq1zTSVinEJ4yAtqeLb93zGx+V/vxz4YgZbxvSE=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022e3d58-5fb9-4f26-8023-08d811a49361
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 03:23:02.2421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbfR2NDhmSdmBXnWAS8HhhTL5hrc3LFLCPfZe3niLC02ZchzpGy4r5wci9F2s9GcYg7w0hqg4iJduHZ6UeRKdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4123
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=4298fe783=Anup.Patel@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 23:23:03
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
index 041c400261..35dc43d620 100644
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


