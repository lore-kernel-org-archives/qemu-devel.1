Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354A8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E611A207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ryOZLy0e";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vUDuCATw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E611A207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jedVa-0003sf-T5
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=411e18819=Anup.Patel@wdc.com>)
 id 1jedTv-000263-Hd; Fri, 29 May 2020 07:47:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=411e18819=Anup.Patel@wdc.com>)
 id 1jedTt-0006LV-Nm; Fri, 29 May 2020 07:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590752841; x=1622288841;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=sSqGlJPyiLOwhchFkyjStDMtmdm0MCiEZbacK8pKJE0=;
 b=ryOZLy0ehOhz+Sz1fTILLMQivvs018WHD5OzYx5VodqFw2mr97+7gnG1
 dpB9Ze7ynfNfxCYtqFiTOt2iTR1YswLh/wYtJ9ewN5tfNYR6WsNMrtx4R
 zNtRa8BB8Wry9MM39FrhyVJ2/62vBSFgoCmYfFmoxEEtGiasDL3bZG36G
 PG2ZR9VXH9uqZv9nVdo1Ydl4piQ/ILGim9TTezHBi0ONJ//7n4lNl5ugd
 sbDEOgzU+ngDubIX3vBYptHF5dLh1UTYcfdo4G4awt+fisj9I3XUt40pI
 YqRSoq/jXTqY90HMUMaw8Ogjw00yiqSrAy/1S3QggC4P7RBfn6MY2DOZ0 w==;
IronPort-SDR: mNzcE1wCJiUfXzBuFQ6x0d7RS6b6R/yrtjuAfl65/5nG44paFzAiuzusud8h8+ATY77APEX7ge
 Z4EVB/uusnzTxO0n27ipNK7nSlAP/lDTs1X3At9TZiHlm35gfYzHWtZB+Rk823eq8nJ9uQliKd
 0eVNVv7zR+7QKYouIuU0CQfBH0tl1ZTAOt1M5WPfMDwXUkb4kJPhoX359fsI4f1V73w5/nuFJc
 OnwkybijWvP+/cJedHROzIxm3MMJSzkYdiqsuv2ljrhgCIVnKaOwmcD8FbaFXGjBL0FBrrRzn6
 mbs=
X-IronPort-AV: E=Sophos;i="5.73,448,1583164800"; d="scan'208";a="247863256"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 19:47:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkMg5jhnL3Z+5RchzPac9X336gyRNGoBeeqW25eVhDdE3m9b8WoVr+6mH9R0Nx6zvTBed7Rs1ncRe8ESEUT1QiReR9CMzu1EuPpJDojpc31wb41gr8yBojr3IseKulbchQDIawh5U9TjfwGQIpV/XM5avMbBgQ79z6JySZFze+vnbb/2KEs6mQbldKDEXay+fDnI/e9gNnmIvcKdXYMXCXgKXYsSleqR8S8bKi0KhZ+Pp+idCjjjJqfzNMEi0JhtQNxzSQTT4S2vffJZNJDHuXXBHV4Elnt5jLwch8OVOHTIdKTlmhj+XutRHHWyE2erbQMG2WKoACsJwiNBiGw8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30cdLqImbqcIFjUhNWNk2GJsaBjYaHjzY9RV4JtRyPU=;
 b=Dzc6gRo3PpkFA/snN2P25Tjox03ebV/CBZ3RaoM4Csm8imVV3ZSM3L30YSHl3N7ucUqnkT0nh4UQE8IJ9JReiyrssScfY379Y4PjYW/YbCuD0QtG7Q+1Rhwx3BtboiYSZLFlBTVf8l7u93gCACg7g/xv+uniOqdoDNkHx2/wNO4uAiKKTTufBfYolt/I4zzgUT0z/3E7gYRmT82u/Q70JkVl6Tb2LB0eZlQ6mH7l/el88TGv1renuNSNb4RYkO6eYaFij3H/WRZrup5hEZ4B2s8VFbBKBycDGLyt7lPrCJLpmw0UDjtMLVcE0VA6y0IgzAeR38EAMQWpPXYAj0Mseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30cdLqImbqcIFjUhNWNk2GJsaBjYaHjzY9RV4JtRyPU=;
 b=vUDuCATwKTx7F7IaUW3V7UAhJvxXOKnZyK2V/hVIp6SZSB8319/N/myYR3vjJdLUxcuLfzTkS1f7wkdL3hDVMX338ad3Rt0kcGVrRtnPMMjmjckVpXth4nJ1lgUXsHr2bW6Oic9v4B1iVmPFKlpHfwtl52lSt1BgKRiWdHtEdgc=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB7019.namprd04.prod.outlook.com (2603:10b6:5:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 11:47:17 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 11:47:17 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v5 1/5] hw/riscv: Allow creating multiple instances of CLINT
Date: Fri, 29 May 2020 17:16:37 +0530
Message-Id: <20200529114641.121332-2-anup.patel@wdc.com>
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
 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 11:47:13 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.109.153]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3517cb5b-adef-4da2-567d-08d803c609c8
X-MS-TrafficTypeDiagnostic: DM6PR04MB7019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB7019AE7DA590D78188C3FE178D8F0@DM6PR04MB7019.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErnHmGlWufXIYZkReyXu5EuHLgsZWkBF/ycN5EuzwO7ZlHf+VWkKxlFtoIAY4Hvzv0ENKEptzGGJCH/3f01EPU9hIp7FTcoVMxgwC4QjnWO/jY2Mg65wBQOrUDY2AUrthCv/vUfxbxgKvFlqOvzMriVjjIO3vob1NOH5y0f0ROYFHAhSy9orUtWD+YtTuohEA68LndNZhjkfVCLpk4SZsTVXgtCSzJiscgx1FllhXQge1W1QB1D+bqRJhAXD2gBto4843fb5YvI/CrpCJzbxg4bi/8fIDWBYty9tSRXzHKL7Li4FtcuLaeLiKOcaXAgxWmj5xRqj7+crcoRXYixYOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(8936002)(83380400001)(8886007)(2906002)(186003)(478600001)(6666004)(316002)(1006002)(36756003)(54906003)(55016002)(1076003)(110136005)(66946007)(26005)(16526019)(956004)(86362001)(2616005)(66476007)(66556008)(5660300002)(7696005)(52116002)(4326008)(55236004)(44832011)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /XbE7VeMdUSZOVSEMNSjgdyNb09vSvYHZ7yg8/ec5fzYcA0tT4Farc+4Go7lncf3h1FZ41aRLT7IXd+jjT3cXf8itJZMtpSUrmaNCSbhTYthUBwTTscDaQ+OoKGhCJkNPC/wVVlhe9I41OgcC36yjp5NG6QZFQjUER4CooZ7GqdD9mvwoqpJ1kWA0oy+vvwjjioDps6am0WOzFrl6Z0PM1nGeBIeGyzRmvGuQCx9bpYMvHfwuNEEw+SPgou+POUvvEmUssLqEYjBWmWB6asK8/CVsJbDX1nnTLn5busfnivzslaGnW9QpA2gytapaM4W3niQ4nH9Uy5VdgQeuiwG2SQkRrB+/E6DwKO29HtadYldXqm9qFM208sR7Wr8EWPTY+eGpvou/ve/aTRT9QJbnGkraORVafrPxMF7BTWc/re4J9ASO/xZzWpsfncZJYs4mAiCkibw5hsm9rok+1q8jUAt7oIAo00OhIqptNIvwUxYbZULO5GE1XeaZQcYFzgo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3517cb5b-adef-4da2-567d-08d803c609c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 11:47:17.7775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUK9UgMytg6t2MTf3+nVdJM23uDFvxDf8v99xIMX+015gA/L2DC5RPyK929hZGGJ7djWdbDXzUrFHHl8JkU0NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7019
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=411e18819=Anup.Patel@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 07:47:15
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


