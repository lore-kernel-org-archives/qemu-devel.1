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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1086AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A6020721
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qo0o1/7M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="h5a1HAed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A6020721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIen-0003Ke-1f
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=41059f22b=Anup.Patel@wdc.com>)
 id 1jeIcH-0007fp-8u; Thu, 28 May 2020 09:30:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=41059f22b=Anup.Patel@wdc.com>)
 id 1jeIcD-0001G2-EQ; Thu, 28 May 2020 09:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590672634; x=1622208634;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=sSqGlJPyiLOwhchFkyjStDMtmdm0MCiEZbacK8pKJE0=;
 b=Qo0o1/7MmLd0wvTYdN3I1BHQK+bWBI1ufO/b7Ih9o6ial4GbCibSdieN
 dw0pRNYeNaABbU7KUs/8b5is1/22H/FsUa/rncHPlmc9UNqc93a6BGiIf
 tpkZutJKghYrEor8wOmq3FBZ8vzA6g5V7TqdQp6dF1DcM5svb9o1Ze+4Q
 3hJHm21BDxUW2IKuRKPwv0HzwkoTeQ5X1T2QnakbixKI16IVz5J6oUpdt
 HU8YwwZKwbFMLUVY0RTZe8xJICYlG6CXlER2L1rpLMDvWoOwTJRxthFlz
 Za9Yj67PfX7b1nRYBumUcJfN0bUDSZbd1+r/1yqocO1fFAjjQIpc7ARbh g==;
IronPort-SDR: 0GRbNwkfWkKwuOLxQAqpLAKoW8F+AyA3jLoE8UqATktkF3mN1vFJOyGrN8xZHTgtOLJxSQg/Pz
 2zSpyfQOIT7XpNwmAJws09Nx3HqIyjm9M99GM8WdmyBziW63BWhomJVBh3yRCZY2Yt1iFRF/rm
 N5f92rjUrEqnj9XQFjwomUPK3FsS4Y+TCa7OulKNK7TZVQeY8DhAkqB6XFb49ApMXhI+6g0u7Y
 zHXroNq/hfQNS2El0+VRUVRIGx4blAO+zkMH5hYfN2YT5zAUZgNQ33P2qBMZS9UHCOMjuxUQrV
 f5s=
X-IronPort-AV: E=Sophos;i="5.73,444,1583164800"; d="scan'208";a="143036553"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 21:30:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnKTyQY4KNt398JSe72gsOHA2tUPREg0pNWdKaM4gJN8WtQIyxIIgZm9MAqkcDLKHGjmJAHhKBVcq95EtJpT1f5ZYj2eS70YHmPVrt7H2fCRE6y6+ysYBPZJys4NGQ5eKgJ7pnlxErL6Igz/GtKWz3el9eMgnvc8CkIP02NsJCdOIwiNT/dr7kQjtVjrBn/IG77zpeXxnGK5+CBr23R9wf0X5jG9gcxEli4I+rTIX7jif4YQ8h3ykyVCe9bFj5u3gnHMtgIr3v52x3KmTz7BBNd1iGQbA2YiXb4DSEHXhEwku/laSTAGIknVduEbbVrZT8PSrIDrtr7txyqQghF+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30cdLqImbqcIFjUhNWNk2GJsaBjYaHjzY9RV4JtRyPU=;
 b=K43SsZUtJhe5flYv6peiI8l3SsO22huEONjkf8/9K+fc9HNJIH00XU/O4sP49MMyoZ/2JklwqcIbUGikXrovl/r2d1BWKRNbdgSwlM4lieFj/d+Ak9uK7zumWmxAUtjaAudOX0Gls96EqE8u7B8fCqFxkGK0aE46+ZxSldtUUGgSR31DDSQJzHVOprl+jisYh+VfNp8bhteytYHujobUWui/ssXgnrNaJ6eVuOf4ahR7Qga+PA0QZUkIq18Si2zINOfpc7q6W51oRnSqGGWG5fcBl5aqRsYmS3l/wEBYAbhRfL4aFckAxOP4bkDEJwVZgrLV8zoHF1DgqHXtsKbvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30cdLqImbqcIFjUhNWNk2GJsaBjYaHjzY9RV4JtRyPU=;
 b=h5a1HAeda5i+7jZn9dkpCrxl9Y3vcVfcWtlAnO8W1HUqE1sApP9K5845fCyePvXi73XVhizq7WR6m13efiLGYy57rkxpV8zZQ7nhKQ3yqPArYxpnn/7Evta8VCTNBuFFormHa0tCdlsCbFXB56e8jmqlKNJLDCWFAJdd+gn5fGs=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6204.namprd04.prod.outlook.com (2603:10b6:5:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 13:30:29 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 13:30:29 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v4 1/4] hw/riscv: Allow creating multiple instances of CLINT
Date: Thu, 28 May 2020 18:59:56 +0530
Message-Id: <20200528132959.47773-2-anup.patel@wdc.com>
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
 15.20.3045.18 via Frontend Transport; Thu, 28 May 2020 13:30:25 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [49.207.63.107]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f900eb52-f560-4796-2392-08d8030b49ae
X-MS-TrafficTypeDiagnostic: DM6PR04MB6204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB62049E7CA9C82687A680BC7B8D8E0@DM6PR04MB6204.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9UemQtFO+apGkBSQgc5QDZADuzwQ4W3oY5clWa8fksIKMTF5i/aMB8lk5aGgXbkVno1fmHq8RkUgHiRqb3G7IW4U1aAApYaiOsWwudHGUjIkq6pDlfevmBSGU0OKLBYS2r3vsJIcS5v1yjo7tmvuPf9snr3BaK9ZKrFNofgNjo/NQWGupF7+d6VKQOn90/Jg7EMMpVtxU4QlDvIEwVCC0YILm/Lmz4xOhZbkWbZAPABbSuxuocNIyxA3NWFUvId4oQI/+VZKhcWvBbMZHZWVKtiJUoeNUaS9LnM+g9WaOHZhYlHZeas4qQ+x2vKsBEZ/lPz6ic0DsLNi/K0U4yTAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(956004)(26005)(55016002)(44832011)(478600001)(55236004)(2616005)(5660300002)(7696005)(16526019)(52116002)(186003)(8936002)(8676002)(1076003)(86362001)(8886007)(66556008)(66946007)(66476007)(316002)(83380400001)(4326008)(54906003)(110136005)(36756003)(6666004)(1006002)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ab12aRv3R+q28FhvNyGAZrZlKW2UhidyS4KwEPvg8M/DZoZVpZQ3T12fqjxxXs9Aq1dhigq2fmcvRRyJ1MzbVSfWWC8ZE0cTRKXGZiTza0vTxqF3c8nb3hEnY/+ivEAEfUCRyezRb+ISig7LtMGoUlJJEHZqDYgsFrfrBpStMwH9X6DGLCtozQJk44xY9mmVRpD8P7/qIYUfV3n/Fe/NCaUCfLOr8Qm2fJOJQE/ToOBM6P4BKt4gmgw3eqKJ+0sRkn88kxTE+jY4ye/hpdfZyFFbMT7gFP/JLi6JAjEJNH7Qg5goc8hMrU3mr4hUXVNj3FkFEIjHbl82nZn78L5PRF3VdObpJHUJaiQohxkwRVBfrEjt0tAg/5I+Oql9ueftE/Rn/fna7LBYq9lQ9GusSXUftmkYJ5eBQKhEHSvWTdqQ5yAuMpCbhHt+T13U1sNblqsgPbWwq+jvQSUHbf1/A5LZOMWIwJlWtgtKp5vvK6I=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f900eb52-f560-4796-2392-08d8030b49ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 13:30:29.1885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBcnav+3qXZca2L3r/M/A5yqBD67jaXAq3Bw/SYTuO9nPC7Eb9A82GMEn0dld5PtH3r/If4TymWdz6ZNRqfBHA==
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


