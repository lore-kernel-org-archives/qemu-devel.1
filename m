Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0295FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B647720657
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gF9T1tm7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WZhzxhGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B647720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduvt-0000yJ-Rk
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jduus-0007di-A0; Wed, 27 May 2020 08:12:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jduuq-00048D-Eo; Wed, 27 May 2020 08:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590581532; x=1622117532;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=sSqGlJPyiLOwhchFkyjStDMtmdm0MCiEZbacK8pKJE0=;
 b=gF9T1tm7fjLkYmVAnXE1YoTCoyaqxYO+3FGl/7FzkhxX+hiMhspqetGN
 3xwTIA3pK6TIIkmM9T9JF9ckq9FCsNiwFOYMaDC+0NAfM83v3y3/C8ong
 obfP2GnuBrKv/XonmwA4ZSm0plZ4O4NICnCU2yc7pIg/Gqy+FhVn+dhjb
 KUcpiv2ablhBC/dnIFPFyyjpS63JIrVT32QJdpde1ROmW7DHxkDXuZSs3
 71LYA6nU+GFp5rAPsp54C6s7DXC8PdvilPToN6eyWeP4Y5c4xcAkdkT6W
 3UMyO5nALM43GcdsxGpDn0Up6M4CtuwRNgtdINkLqSNkroIfwgfbktrqV Q==;
IronPort-SDR: 1WhRtylJGCaTWxEETrrzpYsSkslN8NvZTUlslHm5wkAfsZ9H+UXUps+Pxt0WHhZ29yFTh+nvOv
 v21j/8sxTm7Ijil83ZjvZBRRHs+XG/6HTvSPydt6yKDRTF/H3EZ2IgXtBEdnK2Gx3YTorC7QA3
 nWGhlAtewq9bzc23V098v6R4ndZsg0kPcVg8sUi+feIcUcHzEnXOpuqkfH5a79dMtwqWTpD1Hd
 iaqR2pCDSHl9RdPu5ftcx3eUQogh4CWK1zkyUp+GSfDYf8+Yw10v2qR+CVbz9pQ3Qzc4qQ2eCE
 Y/M=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; d="scan'208";a="138613398"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 20:12:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1MDwuVjR1uFfgUD5b1/s+qlZDSGNv0xq2746BoYluY12oaMsAGOSh3Ky/157b3w2R5pS5eGbeLXcRVaRhKIzaxk69tECmRHPcaKAEZ8XKVC+ubTb2SbUFwLAHgYm/+lGVG5VKu5pGyCfZyk89gynQ6zqqqMUh7c8EtZP/Td4MkMOvsb6xznrBUY1gCCt5qx24CVcKZwawWP8cyGZuQ/xIwhA7Wfh5n+v+rjhAC5IiHakiEsC/UuV3PrClrjNzecdTUxN1CCeUw0Ivpq1GK/hnftP4qTVcvYOl2nnOuv+gpgz1pXfStPEIHfX0tjYR9214P29rXP/Q+k2DG+W7m3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30cdLqImbqcIFjUhNWNk2GJsaBjYaHjzY9RV4JtRyPU=;
 b=TwDD80Zqa469qU0+bFG1zC3tR0wj2gZZBib9bKMjCjGeG3SH0cv4/OXJT7CT6kj9RFb+rQv1QNwKJB6/lBwlU1ls9fX6bKU8mmkEfeXieLWuPWnDwyT73yXj2Iav8w2aOkO4XAaEEdfXaFh1Av3GI2eT5aSjxaXj7pYrmuDrQXIZCOKWb4AnYyb3bC277u/5u1HLtVJAVJBXLO674jxeIsGortJKqlW6CKdYqAhlk3vyRM0zfC/vvJiOCVFGlHl4gh0jzg5NJCsVQ0FQmuH+Sq1AvYfWJADIbzYNzpwCGHWn1iJzEs7+ODtpbglgys9QTizgIDg0dIFhmStbvinr1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30cdLqImbqcIFjUhNWNk2GJsaBjYaHjzY9RV4JtRyPU=;
 b=WZhzxhGJ/9mVXxZcIVoyBTtGmRnd9p5KcV4vwz9sm3oQTDcnQvZ4/59WNwWlfdyjhi6xyrbXSLeFrg0RkDU6b5gJ8Bt9Z1jhpSL0XyROMPQoSjli0g5F4ZFDuYNuwgaSII0jhPRdLuBH7TOfUwubXirvZdmRdj919IpjnmPWiSk=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4473.namprd04.prod.outlook.com (2603:10b6:5:2e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 12:12:06 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.030; Wed, 27 May 2020
 12:12:06 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v3 1/4] hw/riscv: Allow creating multiple instances of CLINT
Date: Wed, 27 May 2020 17:41:28 +0530
Message-Id: <20200527121131.251007-2-anup.patel@wdc.com>
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
 Transport; Wed, 27 May 2020 12:12:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01af233f-dac6-474a-b282-08d802372c2d
X-MS-TrafficTypeDiagnostic: DM6PR04MB4473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4473CA411DC3226444FFE2098DB10@DM6PR04MB4473.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Th98oDh1tZhE+pf1ApxKM/XdBHT2N90PjuKrGNI3wG9fc7UKDL/uPq2kuXGp7gEcOVDnXHxEJ8rJA94fGqkdik7J4xF8QaKh61Z9baPbexPrT91WP+mHt3el/B/LCGPTtfv4KDE9DjEiWKsUn57/B6afjcZ4bkcFnlKdTM3vB/UEnzWbH2CgJQDfTZwV4SwLcID7acVJPB1e4wHrdbNR5M66pnjrmS7/Brkr0QRewJOTJi2xN8/n+YOV9J6ltNw7WZvLWZuPUiLdBybQ9/wmrnAvrAj6R1z6yPdur/tpOB269a12GJn7FFRURcVJueSh6A7knoRdy/MuRUh+CuTxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(83380400001)(36756003)(5660300002)(55236004)(44832011)(1006002)(16526019)(6666004)(186003)(66946007)(8886007)(316002)(2616005)(110136005)(54906003)(52116002)(7696005)(66476007)(66556008)(86362001)(956004)(2906002)(1076003)(55016002)(8676002)(8936002)(478600001)(26005)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EZ5dO9GBNf9AIRBRRhL+brA77ix4lVORORJFFG1oSg2xN8BLljF2NeMDistn4CVOHRh6uWOMZsTrN1WayBSRlxZNEiv2YYzyDxQTydhI6aKUEfzEKXIEhAStLYY3Ozt7TKHqONeVAXjzD8CWloPJetmGBZ7JGl5V+7+cIxEbFX+GogMBsDE0H6bhvt2FeAFiFrIgXO00/4KIpUB/CkiH+M9vY/PusQ9X0vV6BoiU+B5BMrOzTo7do2SBaV4yutp7926G6sXawElymQcRbPJtgK0hsokXlrkANFY7xel8Jfv68LoeUKobwvH7+tX5Z5n8+eaasQZioARcww9rdM0RinXv2j4LBijI2fLK/+J4xgTMlFrPzRUUSZgrO4PFcblAkv/qnlkVx2lsdyzinAWjKZ9tFtM/w84+huzfeAXlizofXghvS4PY/lok+SBN8QVTxVdPM8abP5iHN3M40MZlYhYFCwiuKm2rlWaZVujZfY4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01af233f-dac6-474a-b282-08d802372c2d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 12:12:06.2383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1dIhKWWgIDQOrvIDXkxBrbRy00ffAdvQ3LNJ5RGiJ0PUBU8QRE1o4LXLp/o8CgNZjgmxuYq641Cz+q/2j0SJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4473
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=409226bd6=Anup.Patel@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 08:12:06
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
Cc: Palmer Dabbelt <palmerdabbelt@google.com>, qemu-riscv@nongnu.org,
 Anup Patel <anup@brainfault.org>, Anup Patel <anup.patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <atish.patra@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We extend CLINT emulation to allow multiple instances of CLINT in
a QEMU RISC-V machine. To achieve this, we remove first HART id
zero assumption from CLINT emulation.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 hw/riscv/sifive_clint.c         | 20 ++++++++++++--------
 hw/riscv/sifive_e.c             |  2 +-
 hw/riscv/sifive_u.c             |  2 +-
 hw/riscv/spike.c                |  6 +++---
 hw/riscv/virt.c                 |  2 +-
 include/hw/riscv/sifive_clint.h |  7 ++++---
 6 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index e933d35092..7d713fd743 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -78,7 +78,7 @@ static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
     SiFiveCLINTState *clint = opaque;
     if (addr >= clint->sip_base &&
         addr < clint->sip_base + (clint->num_harts << 2)) {
-        size_t hartid = (addr - clint->sip_base) >> 2;
+        size_t hartid = clint->hartid_base + ((addr - clint->sip_base) >> 2);
         CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
         if (!env) {
@@ -91,7 +91,8 @@ static uint64_t sifive_clint_read(void *opaque, hwaddr addr, unsigned size)
         }
     } else if (addr >= clint->timecmp_base &&
         addr < clint->timecmp_base + (clint->num_harts << 3)) {
-        size_t hartid = (addr - clint->timecmp_base) >> 3;
+        size_t hartid = clint->hartid_base +
+            ((addr - clint->timecmp_base) >> 3);
         CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
         if (!env) {
@@ -128,7 +129,7 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
 
     if (addr >= clint->sip_base &&
         addr < clint->sip_base + (clint->num_harts << 2)) {
-        size_t hartid = (addr - clint->sip_base) >> 2;
+        size_t hartid = clint->hartid_base + ((addr - clint->sip_base) >> 2);
         CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
         if (!env) {
@@ -141,7 +142,8 @@ static void sifive_clint_write(void *opaque, hwaddr addr, uint64_t value,
         return;
     } else if (addr >= clint->timecmp_base &&
         addr < clint->timecmp_base + (clint->num_harts << 3)) {
-        size_t hartid = (addr - clint->timecmp_base) >> 3;
+        size_t hartid = clint->hartid_base +
+            ((addr - clint->timecmp_base) >> 3);
         CPUState *cpu = qemu_get_cpu(hartid);
         CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
         if (!env) {
@@ -185,6 +187,7 @@ static const MemoryRegionOps sifive_clint_ops = {
 };
 
 static Property sifive_clint_properties[] = {
+    DEFINE_PROP_UINT32("hartid-base", SiFiveCLINTState, hartid_base, 0),
     DEFINE_PROP_UINT32("num-harts", SiFiveCLINTState, num_harts, 0),
     DEFINE_PROP_UINT32("sip-base", SiFiveCLINTState, sip_base, 0),
     DEFINE_PROP_UINT32("timecmp-base", SiFiveCLINTState, timecmp_base, 0),
@@ -226,13 +229,13 @@ type_init(sifive_clint_register_types)
 /*
  * Create CLINT device.
  */
-DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
-    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
-    bool provide_rdtime)
+DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
+    uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
+    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime)
 {
     int i;
     for (i = 0; i < num_harts; i++) {
-        CPUState *cpu = qemu_get_cpu(i);
+        CPUState *cpu = qemu_get_cpu(hartid_base + i);
         CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
         if (!env) {
             continue;
@@ -246,6 +249,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
     }
 
     DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_CLINT);
+    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
     qdev_prop_set_uint32(dev, "num-harts", num_harts);
     qdev_prop_set_uint32(dev, "sip-base", sip_base);
     qdev_prop_set_uint32(dev, "timecmp-base", timecmp_base);
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index b53109521e..1c3b37d0ba 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -163,7 +163,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         SIFIVE_E_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_E_PLIC].size);
     sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
-        memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
+        memmap[SIFIVE_E_CLINT].size, 0, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
     create_unimplemented_device("riscv.sifive.e.aon",
         memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 4299bdf480..c193761916 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -602,7 +602,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
-        memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
+        memmap[SIFIVE_U_CLINT].size, 0, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
 
     object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index d0c4843712..d5e0103d89 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -253,7 +253,7 @@ static void spike_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
         false);
 }
 
@@ -343,7 +343,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
         false);
 }
 
@@ -452,7 +452,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
         false);
 
     g_free(config_string);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c695a44979..51afe7e23b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -595,7 +595,7 @@ static void riscv_virt_board_init(MachineState *machine)
         VIRT_PLIC_CONTEXT_STRIDE,
         memmap[VIRT_PLIC].size);
     sifive_clint_create(memmap[VIRT_CLINT].base,
-        memmap[VIRT_CLINT].size, smp_cpus,
+        memmap[VIRT_CLINT].size, 0, smp_cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
     sifive_test_create(memmap[VIRT_TEST].base);
 
diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
index 4a720bfece..9f5fb3d31d 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -33,6 +33,7 @@ typedef struct SiFiveCLINTState {
 
     /*< public >*/
     MemoryRegion mmio;
+    uint32_t hartid_base;
     uint32_t num_harts;
     uint32_t sip_base;
     uint32_t timecmp_base;
@@ -40,9 +41,9 @@ typedef struct SiFiveCLINTState {
     uint32_t aperture_size;
 } SiFiveCLINTState;
 
-DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
-    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
-    bool provide_rdtime);
+DeviceState *sifive_clint_create(hwaddr addr, hwaddr size,
+    uint32_t hartid_base, uint32_t num_harts, uint32_t sip_base,
+    uint32_t timecmp_base, uint32_t time_base, bool provide_rdtime);
 
 enum {
     SIFIVE_SIP_BASE     = 0x0,
-- 
2.25.1


