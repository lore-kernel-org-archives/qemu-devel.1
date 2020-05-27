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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E9DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E9920787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KbUVEnYc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TUPFFFjz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E9920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdou5-0000vn-1B
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqP-0003Sa-H5; Wed, 27 May 2020 01:43:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqN-0003aK-St; Wed, 27 May 2020 01:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590558191; x=1622094191;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=sSqGlJPyiLOwhchFkyjStDMtmdm0MCiEZbacK8pKJE0=;
 b=KbUVEnYcyn03gvfazw3ZWhbuvnj9vbrGByvQu/3N/FnPgCIxP3moDCRn
 akIdEeYHVder4SK5FcXWY39QJzkOqfEpiGIjQBycnBgcTgXQJUgs8YENR
 fsZE8Xqe7pQaTUXqYuL50/MXbnP7cjR9u+Rs6g20uS42VTn5WFYMuuCyE
 KfZC8f6BF30+Eo2NNzVidUWvRxMelEcp7bMGCHiJg18mhV92SH1EzBTZN
 Coq5Ky/ZkLSG08sTujPmxp12jc2Ul+PAaDGW70Nz7G9BrQDVGBCipdaa5
 rF3clPPsq3ayayDCIvOqk3Iyr7LJOovbtsbSjfCxw2CdCYpD0TJuI2H3z w==;
IronPort-SDR: RAMfV5sKd1slPBgZ0JXKobV0ixjA7ccPLgTg49Y1bZoUf93O7WwJSIUUd3QlcfWLOeAgsm4BA1
 p5zpv41wYl06pQhPKy65TuhKd7myYfu4FQmxCtYC94A9v1i6H1iM0X6cP1ukQv3CFjre4WDwe7
 t/EWPhh6QQJcaog3rLmg6SfvH8wC2VfB21CvBHzMTkhsPWnOGlZZSO+/qsAVa2mBASUs8XAwXH
 1w8R7O+BvORsgnDwTtAIHE1MSTSevLLSae/hLaZ21EP6F8m9C2S1hPVGy+LQdmZY5iJGvS9SSP
 72U=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; d="scan'208";a="247638086"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 13:43:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tit3B27c7dRI7rnHnsPeG6Zbc1pe+Ali5OKpQc/7IAnEgaNghqKk1weri3B12GBIgBm8r55ku4xo/mHJbg0YXeVbvFP+Iasex1FgjSQOeKDcCeuNyWzM+nyAyzXmYlU6YvAJ/ucOWvcsnAIQXze4OYEX9Q6K9RWoS3Be6vuG6co+M/QAXedaoYa7yHFg7Rd0twbl3R6T40EAwRCfJwrjfBjmAWbZ0feQb+B2YtLySaN6C2TYohSXhaq3UwgYSxJIaK0lZG+3J1d/NEW3f5QlSYbUyqgIqSOnUCDmXWoe9vc4YuBM5OGGPZoesoMIIXJhR/XzvuIQMR2T5GaFHoI7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30cdLqImbqcIFjUhNWNk2GJsaBjYaHjzY9RV4JtRyPU=;
 b=f++2eQampbQxp4sFkY/wHdQ0dRsCy/F5n2OUMIMRk56SIsjFo0YWM6Jg90yGdLzpBzafq7cr4SDEeSARu8XSNLwai/IFPeKqPkDFSS1oAlqrerfWrTut7cv8QsZtT3Y/UIOtOxiF1q279evLpvDFZk8M5lKNDjeUyq6pqyEx3oWBLESPhQOzwHkVxWl/JnIaulozmPxEjtOAHe6c8BC0z5wnveNgNemrHaDz2ZXpUOM4QBjm+TgyM4TXDJY3CX5ZTnqjwIZlwwcvF2/q5xRGwKp6vuzfZVgTMkJU8Tp7IEO89rzVPpJNDeSAbakv9LR5BvOc4a12OA/GFEECt2ybCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30cdLqImbqcIFjUhNWNk2GJsaBjYaHjzY9RV4JtRyPU=;
 b=TUPFFFjzjZLr5T6XhSNUdS3/rarpxxG596M9CR4xrtf3AZsMV0gIgwLV0Gs/4e5MjTZFrCHZod7ADN7y8xoJLDlmxDK/ZsAplxjNmdeLeM4ok6Mji4frIR+ClNLFgf4DoEVUHgXwDoCufMvtKqO3BwuwD4FSJW8XmNBDo8Umb+A=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6923.namprd04.prod.outlook.com (2603:10b6:5:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 05:43:07 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 05:43:07 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 2/5] hw/riscv: Allow creating multiple instances of CLINT
Date: Wed, 27 May 2020 11:12:23 +0530
Message-Id: <20200527054226.232103-3-anup.patel@wdc.com>
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
 Transport; Wed, 27 May 2020 05:43:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 482bcf74-1469-4f74-cf56-08d80200d52e
X-MS-TrafficTypeDiagnostic: DM6PR04MB6923:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB692317F620436017FFA7A10A8DB10@DM6PR04MB6923.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3az90a3N5uLgjbKz9L6GtVcZAv3LF1j7WowcQBNvZjANQVWW0SsH7REV9VaNOSVcBbsPXFTdyH3PGyPlDMRW7T7djeQS2wItP4DDhb0erpC5jKQ0PXnnwPx7syWR4UOUDDL6SzQpPQ3G4U2weR5yDn/LnVQrguQ9KYbgL+BFKT6c07O2J5UBWH61P0GF2Q6RvDUP7UwB6RQFDEqKkjbREkUuSJxQ/WGxwhZVOmhdjCi143VUlzrGEt1eUWbIG8TCkHUzmfokgrI8tOhxTiUrSQSNynCT9UJ0umKvbRMqabdN54OhOWR5UzFVjN8he2Zcdda8yuY+JhmmDHoXWWqFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(1006002)(110136005)(6666004)(316002)(1076003)(8676002)(2616005)(5660300002)(956004)(8886007)(8936002)(36756003)(44832011)(4326008)(54906003)(186003)(16526019)(478600001)(26005)(66556008)(2906002)(55236004)(66476007)(7696005)(55016002)(86362001)(52116002)(66946007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: d8dWW2jJ3tqjUUkrGEeSLZ3nT8eNsoFHzZuaetOtVqVo5X64UUVN+GkxK7W9ejXiMY2RnkpBnuCwASedFuUBYU5ZoZ/hojSr6GDdWDxrvE0RE5h1a4b7O0x4UViAmh9/pZi8g3X6OkWizNNl4xIqIjOeKkv16fC24AUSjm0hDvDfvJKp+CCg4TuUe2qsXocYdHekrLSKuSdnCFtN/7Lg1Q2j/uEa1ax4ihqma2HG8dIW+1K09gt9zaVug3N1SKSPFjYki1DHNMzi5q+r+o45prNQ7bmhrh/MZ5aLytdTRk4nT3Lloyc2vU+uy99+GjB9gsbla0r/ZJhk7QXQUCFDfy/u/lLWkVBap0Eo38DMW7mtepUDFvliASDzhVgLonGlZsILIX65bHrSu8HKsutDjOY7J83Hh1NEKav00tjkY/zw+/4WxUoFPu5m/NWObDDSArx/9IikyZASWDfq5ZKKpERxEAUvjb7DIRseh76TZ5o=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482bcf74-1469-4f74-cf56-08d80200d52e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 05:43:07.4854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heOyR3YpjYm1S7IYONHGMd0BXsTJ6jmgCU0tJaOsBufKIili9uy2KnVIFwaD+wozKasrqp1fmyg0j68Zrd6XIw==
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


