Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F4AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C5B20756
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 03:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pneEY6CY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bw22knvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C5B20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl2Co-0001oi-Ga
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 23:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4298fe783=Anup.Patel@wdc.com>)
 id 1jl2Bo-0000SV-8t; Mon, 15 Jun 2020 23:23:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4298fe783=Anup.Patel@wdc.com>)
 id 1jl2Bi-0007be-QC; Mon, 15 Jun 2020 23:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592277782; x=1623813782;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=2/4gAOfhZqEKuUFJczqRipmnJlmMg873gQNyX6WrV+w=;
 b=pneEY6CYW/3fF1BKYwlFLK5/3veOgsZ3eHY4E34Bb2lhRV24Xag6qzqS
 D87VNu7d2cZpzL+Z51LOC/zh5t5Mc2bxIPCIkjcDNjBTg5yrBOEwXRdmi
 2UFStc0L6DlDSxP2Q72L8XK3zIYmoMrHI7KEhLX/hOLscbQwEbRJnocUF
 yK04Modr/NmeQNwirZ8yFUHXenrNTBlaF1AKm976EuIMCNXWcUBQ0kmC4
 FyLRvDUAqxAC7wVhhrr6o8duh+be/4mU2krIsTUwdJdzkjLrTylpKA0Ws
 tFnRykkuryryCZ4iNZa8pEBkwnrUKzT0riu+0avrANm2IDU3eFx3hJ/mv g==;
IronPort-SDR: 23nPPYk4/Ta9VOOkq8wTT2DHMN4/SwniWIu1WbZt3ZDuRRbWFLHiW6y5hzW8Mys9/dXJP+f4M0
 nv6uf//lrGgSxdkyjejmOgeuDDEKReA8LxvVz0/Nq1eNYMzP6EGl5n3H+h7HImyWt7+4ipRV1h
 C9LOWy4tKb6OYV3wKUnBWUaf7+NT7AO8DO+erlNdpCpKA8nTc77AtnDtioogjshluwC63lUoRv
 iyErkP0vXZXHfBPi816N3u59mUAZY9+VmSd61OIF6ColZKHoMxT1LyscvC01KchIWTMFEsEEK2
 nyA=
X-IronPort-AV: E=Sophos;i="5.73,517,1583164800"; d="scan'208";a="140088524"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 11:22:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoMqZUaUSAyDoFw2JvTw9d0xYmgxtnV31qAGJo6AztOhrpt9ba0ryVoDOU25B9i/0jvFFJSqDu5q/Rtmys12qz8CPrplt6e3ti/QT/N/CRLKneyTqKQLUiOaJlbsKuhaWmn/X3NCu+7C/fvTG5b0Egb+tgrVdWwF0hm3HJW2cXzqfPxGcje5+QwpSOtiRtRRiZ8zr9WQvRSTiJDEZxqT06PwWwsfuhhEikIOxMSOeB5hCXz4FVfurFhuPDZWU5eerIKxz58aXO9aXCucfgtX6n6Oxu5QzgUc+BPIITVmTbZRVrawuS1HHmpk0HsGMXheDai2v9s58wtYrzVMz02Snw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE4PtQUtuBhdFtTA7wq0v7JDakws5ugoQdoLlYDQklA=;
 b=TFq+uI7MgemkThGuFZTGoxxxZQXfWPLReeALwZIQrfai8ZJ/QU9C84qfMf4vJM6racCjRWKMcQd4BGw2+krVQlaZiIjmRQ4Ing6gy1WIv4Tm4NziEkFJAY5zlx/L6x2E/+QjFbj6GnQmg/acMlIkkW+PJNqSN3JRUI5mZX8TDwuteE1kI0zKtcuI4xwVcmMrBdzlXnAxu5+vwiQwPTMH0Z2g+N8in/ex38MXNjcC1z4Zj6zfG94P0a71I/TNjlAScEPcPGnvI9XtXDBKPZA2esXqPWg+qdl+ZTbYIPZ7hOYMhbVUc7z/AA6KQp68g/ifvYlwoGxJYVxyGmH6TOONsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BE4PtQUtuBhdFtTA7wq0v7JDakws5ugoQdoLlYDQklA=;
 b=bw22knvk5JYcH4w9A5YSCg3JoNC4+E61Orxf1DmreyWGGYwYPSvoNpup85tWiThNVOU81b8a5D9Fy/yHXKWXQDPOegM8M02am7tXIiyJnRvfobbq6lIJlYrWo6VCC03L/O0gTkuD96XjEraaFqvNsTBdvVgerHpbA1gN1J4SpRE=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4123.namprd04.prod.outlook.com (2603:10b6:5:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 03:22:58 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 03:22:58 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v6 1/5] hw/riscv: Allow creating multiple instances of CLINT
Date: Tue, 16 Jun 2020 08:52:25 +0530
Message-Id: <20200616032229.766089-2-anup.patel@wdc.com>
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
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 03:22:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [122.171.201.92]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3471103-c3f7-4ef5-7c91-08d811a49117
X-MS-TrafficTypeDiagnostic: DM6PR04MB4123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB4123FC19C4FA469938A52A998D9D0@DM6PR04MB4123.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWjaOFRsA7ALJFbmf5cIwGL2b3G/tJ+m5W14M8aA2NOH/Sz15DCBvG59qv3N7GSXP95gv7+EfDKh7aVS+smnLAu15M77fIxiGFsBFEIBUWFBOpT+P6BMXQKLlE89ymcYaTrKegjhrmsdCEEUvosnPvCmtttTjXAbCcb2ZTRFHtFkZ/vDlDomk1DV2QOmn+2GIG21rkn38nYauxrn02qxYDOIrx1xx3maiNR5aD8omjs9WWcdzepdaVYifKe6xAKb1DHOwmIZ5JmpkJriXc+jh7cwOtj2ssKp5nogao4M2F5tIIxnqSX1yP+jnzDVYwBFQqOaTP/upvXeq2v8b9EifA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(66946007)(2616005)(66476007)(66556008)(8936002)(956004)(2906002)(316002)(54906003)(478600001)(6666004)(186003)(44832011)(55016002)(36756003)(7696005)(52116002)(83380400001)(26005)(8676002)(4326008)(86362001)(16526019)(1076003)(8886007)(110136005)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CbXM8B9RZ5Ltf/h2OKleSZfxfh6YLISwEpUUL2zATnXBhWIKX5yopyS0zWXshDrM9diTbXmtepHH+ofNGD7kz9qmKFpDxbu3HTqvVvKuHrKjLZ4wkN/jwR1SGp4ezaKnwZmbACiYj3KriTevxYZ/vimisjSKT1Yl9QBU0AwhK8L2OSHEg47UFCGeYYtMAWyvAakyr2p6GoRW4RGEke4SDYqpwQbi0P+v5IHU+ZK0A13+MVBL96vZZu40NTY92yU88rNxwTU/JGM0dZQdpwGN87FTjro4Ku8y/usIHMF1Ra6vvoQdY7/UmZWNwJFIDFe9Z4Ljrr7PpT2NbLkmWEHLLJdssYu/G2yeSNDnpR/IdgWruhR6x3j2gMdK5PSHy4KzL6hFUjNE+R+8Or8KLUXQ2F7SmEIzF3AjYTS/qC8sN9GEuRrVyiZWTG2W9DTNIo1IBwi0Lf6ihf31REb5nSYdTmkRboCRK0lRIvgewe6GLMs=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3471103-c3f7-4ef5-7c91-08d811a49117
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 03:22:58.1727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6q2ThMlKaB9qoXlAhvXa+CmDZG58vxxop/Wxq8IVLmua4H7/wp+jUczumTf1atWWp9oj5zypGBDNjH2tYYP+yA==
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
 hw/riscv/spike.c                |  2 +-
 hw/riscv/virt.c                 |  2 +-
 include/hw/riscv/sifive_clint.h |  7 ++++---
 6 files changed, 20 insertions(+), 15 deletions(-)

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
index 7bbbdb5036..a3db885ffa 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -253,7 +253,7 @@ static void spike_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        0, smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
         false);
 }
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 7ce28895bc..041c400261 100644
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


