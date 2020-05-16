Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E4CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 06:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8FD2065C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 06:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KtpawRT8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f+qRdbpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8FD2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZqUa-0002SO-5x
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 02:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=398f0481b=Anup.Patel@wdc.com>)
 id 1jZqSs-0000dX-GL; Sat, 16 May 2020 02:38:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=398f0481b=Anup.Patel@wdc.com>)
 id 1jZqSr-0001kK-3s; Sat, 16 May 2020 02:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589611109; x=1621147109;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=YJqbFTB6N1dyCILkzjy1uqRfngljeIzyl/hme1ObWX4=;
 b=KtpawRT8hlBqqymgpxLhhIh15MoXBtzaMqy+sM+2G8aEX9uL3i0XUx5I
 4cC/o96bDA1GaZEO1/U4670tXz1/QVUsoHk3JP7qkkyuVWt7saBO6pmfv
 /TF5/JG8tWdgnTc8XtZGE3hHEtMmINKztdBgqoUcnUxkZy1xwzrAFys/n
 wJEsVINMyAP6Zjf9jcq1bYCPxjd1u0QAN+7cUBCnus34Hz4XnHEoE6PJD
 1bcUyl+9AKuArgWfj3fkcgGS8q3JRuFeMoh6HQlG5VL6TadQ85o/dko66
 +jfNM+ebpJl7a4q40kVabz6ToEdu6+lDh0kuIjejs+vAD1sHI1WuBqP19 A==;
IronPort-SDR: QWf0HBEGlzt7L83uaf0rfMAMnr0dcX3guNcNT1wOqGECxmc4uS4nz6TEIXnq58/hi1s3e44bfw
 kT5pXKWHWOjYMjyUn3/w8qMDN4yeEqlpI/Ek0gABmbEkfwiu55ZR7qvyyJJ4RKe3BJYkYrmJ3B
 /XplvyU3EZgA5W/R1+LPHSQl1Kdwiy/V/Jjkj3tHMioKE2Pbv9VCo4D0xSyD33Nv5DmU2SWcoZ
 ApkQEkFhIivgxyz0Q5LwKaSxkqLNis8uTfizWy1ruPqyzUWGiM2qkfphJNYgB7/RbS6IzMFELY
 bJc=
X-IronPort-AV: E=Sophos;i="5.73,398,1583164800"; d="scan'208";a="142174833"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
 by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 14:38:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBN06uIjc6p0jjpiwlV/nXmK3v+qt9DklE773Pl5++sOZWELg0u7m9a8/UfQuvczbUT38qoKkcaTQkIHAW+u9vR314q5MKoQfiBKyFqpLmG8N1ygbfFsBxoG1MGOLDzXmXpEouTFcv8Zc1HC/+FyzzP5Wwh6FWnsudtQVeNCWv6Rv4NwM5NynoXCq0yWgLQjcsOvGWRTPDpkpNGERy+rj9EM+tX+l32rpv14AtYcLYJH00u0AfrJubd9PSGySVT1X/ByFlEgZasGVYmYSF0MoHJnM9jL18m4uq6FbGp/8xSZoSdVbSk+AbkGz9YqAvETuFr7b5+oNkuZnzTfbqBJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMGeI6ysV/lHuVHxZ2ogliKcPWIVLwWzExzlMhVNoKs=;
 b=DEpKgr9MyxO6XIw9rhUhZMNckontPEMMOGAfxA3cVymIMknPMQi/edMpmfhkXHnXyna7qLw/zO1awhIdMGq6kRBTn5s7+tQCOAsyaDH/oEhtyfveRgZk+rVOJlsg4oHNzRjmruYmMYqhU6rjNjMWpvtnDb9K2EjVh+Obsjdlp9NpqDKtBs6LubdSdHiKYtBwoeNizYs9FK7nW/eqXRx38fSceJzVZT2MVpfQR58drIIZnrC9ouUhCbVNsyBSFZDsUFiA6iht/kl+69sZkX+37f6NYJ13FxkgchdXFtaJeMzIKoPkPExXBKHJmIyOV/qFDCcmNJIHRg38SeBD0px2PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMGeI6ysV/lHuVHxZ2ogliKcPWIVLwWzExzlMhVNoKs=;
 b=f+qRdbpaT7gXunL09dAZCpwWcW59hbUCX6OhXE8lTRAKfOyb2p4kIo35lXqu3fzFILUwmTkvVQEPwvaipB9Kd9aTImKWME3nfG4w8sJPEjSW2mZWuhBSKWDQNmrFxNglmLD9ImkfksEICMa8EGrQavaLxt0qz3IRBErBeexy+T0=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4539.namprd04.prod.outlook.com (2603:10b6:5:2c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Sat, 16 May
 2020 06:38:22 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2979.033; Sat, 16 May 2020
 06:38:22 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 3/4] hw/riscv: Allow creating multiple instances of PLIC
Date: Sat, 16 May 2020 12:07:45 +0530
Message-Id: <20200516063746.18296-4-anup.patel@wdc.com>
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
 15.20.3000.25 via Frontend Transport; Sat, 16 May 2020 06:38:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.60.36]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1ccf4ae-db41-401c-3fa4-08d7f963ba84
X-MS-TrafficTypeDiagnostic: DM6PR04MB4539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB453981AED86AD55154CEB8648DBA0@DM6PR04MB4539.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-Forefront-PRVS: 040513D301
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywkXwkgpgi+demDcxHyvRddgY79WI9S4laGxUKYVGjaVvyBl6cjXv1hu8qVulqzUyBXuKGuYvMn+Tu6U5DZiOaCkY1wxPy7cWKG2aaoykt7r9p3txsrVuP0eFGlz2rja7xbat2L04TP9EWSyzMXmTaD+XTvPevsuzPB5aJ3hZ4laArXV1wnsQRg8kXe3eprKWKmX0HURwATi4/SUfvIyUGR1dpoGXu/EBj+ziCps8pxnvfLpOKZzn7FTS308Z+fVGWaJHo6ahw5xlRN2AyhbUAh8BpkUpXL0yixMq/DtnfHktzduIwbvMj1KzKGnNo1D+OqLrvVgEQasMowK5Hf/2lKrMGZBFI4mjZhsm8/7ppBod4G0MVrc2Hga9jQc6B/bKyJw0UWLMQNfxzgGSwz/qWqv2tYItzYvL1Ovjxq49Ct9pQB8/Mec99TGAlrucGOi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(6666004)(1006002)(2906002)(8676002)(36756003)(8936002)(44832011)(26005)(54906003)(86362001)(7696005)(52116002)(55236004)(110136005)(1076003)(16526019)(186003)(316002)(5660300002)(66946007)(8886007)(55016002)(66476007)(66556008)(478600001)(956004)(4326008)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wWOIF3JNoIFBQXK7wExNfXTPqZAVnc2csnqU0sDri5r0kJ4mgAXTCnJOaI9OzUJDARzZLbndR4ssFh+IVtpk0MlmHIoBZRN0UlOMFKBHJXPPqKcHSU3vOznu9CsGTWpIBvOEBHofDmDsBgwXtEZSYBGQu5O+T4kjM3gIb83ugE08BXWPSpt7jRheiYMdddyPac/ObrT5KTVQUPATvTxHfiV16OjKyqUwc5r3CwtzLSfOjZ1IEePmyi/XpM+LRwykDo8o6H32O549wsSytAqlxvGRHxKfqBdDZz2vtulv9db3LZ/JT+W8+IMQ2UZUSLGnL4nRkFt7oALTjDsb1KkuJs8o0X5ly2R4yOw6rtlnvYwyg2ccJrbgj79U6D82WML3tSOMqnSDtHMuQyC2OWhrci6iRpEurJFNBoj699euq2ty0mZtZAsskWPkrH3QHh2S9uMRuwfVCiTwTaIjo2mT8uKhOCV7DKyt63bFoRQGMtI=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ccf4ae-db41-401c-3fa4-08d7f963ba84
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 06:38:22.4211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTZSo2I3yDtDEJqeOe/GgkI0SWuwP1gK48cj5o7EUvlK+T7nibBb7mUFRJ0kkQmt8St3KOboKudfIgXtWUDKzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4539
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=398f0481b=Anup.Patel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 02:38:26
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

We extend PLIC emulation to allow multiple instances of PLIC in
a QEMU RISC-V machine. To achieve this, we remove first HART id
zero assumption from PLIC emulation.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
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
index 22997fbf13..69dbd7980b 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -585,7 +585,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
-        plic_hart_config,
+        plic_hart_config, 0,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
         SIFIVE_U_PLIC_PRIORITY_BASE,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index dcb8a83b35..f40efcb193 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -585,7 +585,7 @@ static void riscv_virt_board_init(MachineState *machine)
 
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


