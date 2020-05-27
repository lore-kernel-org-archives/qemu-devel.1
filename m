Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950DEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3DC20787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GuLSEjHg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="go7aV0qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3DC20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdoxV-0006kV-Gf
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqX-0003oc-GS; Wed, 27 May 2020 01:43:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdoqV-0003aK-03; Wed, 27 May 2020 01:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590558199; x=1622094199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=fcl2/s4taLYbTTKslRBqqC8oTwWKwM22EGfD/3R2t9E=;
 b=GuLSEjHgGRSqeZMu4P7HVsO+5FbQTAcnWWE6OKO3/5yA07P9ssLZRzfH
 d23dOAroALwu/WycKXP+vQvPLK3aICydQLgmHrMc3/b07TDsKzHrQR8oM
 hHcpamI7NXKTytJIU0mCpdFrNCQT3wnJk7u6hYfYQ2J0cyfE0Pzhw0kt5
 UJ+Tm4NAQWBYeA307qtt1gmDuSG5ox40B377KIv2YkRqiOl1E7562h13r
 lI8r/AC1KDXCiAjYPxJujEXQcbb4Tk2Lp43b4IEth2B2kEGqBzACBboNu
 jrIIh+iNe/2waPsRSv5lOPtwAJJRyayWX3pMVaLXUaI6ZytODR92+kY2Y Q==;
IronPort-SDR: YXEGalN6fI3VH2cSGd0nHumSyauJf6CDErZiiMrXioGEyVSQmfz/RHbVhA1QiaBlRIcp7gnowC
 02iwX4BmRyjzXVTB7+u/UPyQHdVKKkRBPsxZTRN2uRobQoWpWIYxmdZxw7l2mjfLXJ4uwjaCTZ
 Bi3iPzNSrcsbxETHTKn0940gjLtSfxAelJ2smw/KMU02RN60jvdB5OhlTTxP3WFUHC34SRSNMe
 pmQFzNnjmlDRHdqe6CedV9A+xLMrtc1p9/PY9IaqICgJThN2s/cu3hXV0zBmSq7Q1PnFXVkWAH
 WUE=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; d="scan'208";a="247638104"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 13:43:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhCD5gf5B1gtbUKoi/iLc1z7mgjzRShaTEKzgODb7ykwP4+K5o+gQUUETyXxgKJVdX7ikFemdRU2rT0VqIb6DyGMjWRAebGlorN1RxSkgmoglRZMjgTDwdTnTqOj6NYeBQJ0jhqjfWNO3rjS8PTk4Ff0Mix7i1ZjMBIJVA7++kmZndzQgzcohd4wqTzksM6yHymc5FmO1sH9P+qGt7vriZ/rTt8dQlQQsceVUopmyPrmtlLErp8oMXUFSG29YN8w6MAXlfbrr2w7jabeYnBwjr+MjH2eikQ3wo7T3WwAAllEoWirPEZJjgK+IIJmZdgYgjARROGil5NMKegF/+DIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSqZwf+oGC6GnqJHzn0BQlbEQMiydC/gkmw6w1nYSYI=;
 b=CIr7ia+crK739Y3KE7C++B5yI7v4Z9pq0t4YFX9VydCd+9463tTP4E3+rruLKS9WaM2t1T2WooCCbgS+91/fN7h9S1ZGwj6a4sveEhHnyVh0wy6cjTKpjmEDaQPuRQhxior6+VspL9Y6AEUS6pXJwbzJqy0LBWH1NKG1r9tebW3t47XnulUIYi9istf6Rav4wI669EcKKwwNLEoefbgMAY1mVmkxP/BqOIlQkV4YxSQv1FDPpD0TTAsTgew50Y95FzKKt1AAczSJ4R8kxuwcj2ZltfOuMvK1GGajdPW2RKR/zaeCL7vi93jdwZ9HIO9fplJiCUh3Ba68t7v8h+LEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSqZwf+oGC6GnqJHzn0BQlbEQMiydC/gkmw6w1nYSYI=;
 b=go7aV0qmY9CB3gsRADaXZTt4pMDcWqmFGoNd2XKfTPHfvTuzHWnnQuuh0HstrqHBDrVAmnFmlDQsshhsZDEuA3jpXR2GqVTxNie+0mG6anzw+Buwp8Fjcxgy0wcQ6UoyHcymTf3aWjZWVzBRWDr8Buq3satmcWZqaUmi+9J0+ec=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB6923.namprd04.prod.outlook.com (2603:10b6:5:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 05:43:16 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 05:43:16 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 4/5] hw/riscv: Allow creating multiple instances of PLIC
Date: Wed, 27 May 2020 11:12:25 +0530
Message-Id: <20200527054226.232103-5-anup.patel@wdc.com>
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
 Transport; Wed, 27 May 2020 05:43:12 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [106.51.30.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bd6263b-82e7-4f9e-f850-08d80200da84
X-MS-TrafficTypeDiagnostic: DM6PR04MB6923:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB6923B1E53DD2F04D9BBA58588DB10@DM6PR04MB6923.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ueej5tGJ196S/q9Xflva3kZoiElPpDVHSQfwm5xA4ylvmnbBd4UFAmjld123dVZpDdsObmitFojVphBOeqoBIaoA0/yDF0KF0X2Vte2OXbiDHJeYVVdlc+jJz9TOlesHMgav6e2dUz4OYwqkqvlGex40vcxH/aJrYkpHPHzqAbsHFUnt1PQcbKAnNOQx3zcos5QRNHGxHZBC987FbJSHGd2Ez78t+65B6fTwiT2AGqHcwzBYoQoWeBqrhWh92KuTqwAtCM2bL8fMry6LwpPgJUEleZxwAn+BY+S+7EsTV0MlU3CfxsCkVXQMauIXJZRvTlTPSYB1bbNASaGlVrzIUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(1006002)(110136005)(6666004)(316002)(1076003)(8676002)(2616005)(5660300002)(956004)(8886007)(8936002)(36756003)(44832011)(4326008)(54906003)(186003)(16526019)(478600001)(26005)(66556008)(2906002)(55236004)(66476007)(7696005)(55016002)(86362001)(52116002)(66946007)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: DLvD0w+sK8uSYXIGkjJRCXoeNwtJlqkJThpoelWmv712idYfEw4/hdPfiA7qd0dfnpmfkQNHfD/FNn3CGGVxj2/K7CrHHUc7NSo4w083p77nVi/fXwKZubursX6Gvm/yaui0C1eMXyZzYGUmTA3YxofeqJxn0BIgS9XBTh+JHp/8RtWj5aONwr/k1AMXFTg2vFiE1dOGGFm87SV5aYPR445z1Z4kHHD+cfzMYrpnls/g1cJ9Hi/R+JJgm2FUNdcpDGfpgp7KCpXqiV0lm69d7mP0B3A+2o9s2Hd2tx6wgkvrzgseup1Cs12Y46Z7W2Ii+kAHcLvmeNlWNxDJyKWYM3XfIS7qlh1oy5iAeMEtNnT3BxCcri9DOF9QPYAIHSxrLAlLllM/pMtTzTB43LrEnbSDBTR5x+EGRDL3gCfjNSVwILfUiRHyrxqxIq+564dg05pg148cgYtjEIDhVFFIqNou30bKS+7a8ZJ1b3j6RBA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd6263b-82e7-4f9e-f850-08d80200da84
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 05:43:16.4246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guc3Qk05TjFPBai93rGY4kZwY+Zubo27q3ZJHWGk+p8D2lsacOq6ard2vfgKto5eqE4M3Wm+nz8UR2ct8ikitQ==
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
index 51afe7e23b..421815081d 100644
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


