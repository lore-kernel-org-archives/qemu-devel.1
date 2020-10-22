Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CC9C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2582225F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g8E5j1GJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sBkFas71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2582225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVTFE-0004Zl-8k
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=557099d69=Anup.Patel@wdc.com>)
 id 1kVTDl-0003KS-DO; Thu, 22 Oct 2020 01:33:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=557099d69=Anup.Patel@wdc.com>)
 id 1kVTDi-00031Y-IG; Thu, 22 Oct 2020 01:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603344782; x=1634880782;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=UOT+6+YwQKFaGF9dGGePpVcHmQwu3fb313Oke9fBcbo=;
 b=g8E5j1GJ82q3sB4KIn3XaDpVDUT7hCkDel44MO/qFj9qqpNlLSrqcHJt
 SLGrkbDRFX1SWBDwHm7KDz3br7KS2OM6Zvq2m2eZ3p7/WTlfdd6Fjy2Cv
 3Cbi2aysc95ABD3GE11p+nkNBbaiqDh1xpxwVI11n7pNDuTZjauaW64SU
 jxVxkscr6sEIfv532A+fHIne5ppGNI5Qkke8gbsX/rlqEqSKnxFobEhKb
 8Mw5c/G8JrTfoZd4Ubk6MKTYYjoq0OFt8iYrgCTWacq7CFzkUUzl7n9fC
 3XAYtoo2LNgz1quHxjE1NWzrQihJ1F+oBmZWgbR+q2QqpAAUaNFkY4AqT Q==;
IronPort-SDR: xSAGQbDILOOISC04HgMAysvZ9YmgV/pSEd5hCnhh3qviLxg3oM4laa4KynahhEvIF8naN/luun
 hu1p2+SzIBl+4G7g6eqmbkIVECLUq7+NBqomZb3wnq4WsMUuAu9lEDBdSMuJKP5zUaLyNQoRou
 jYCTrjOg/95ibdA4pjNwdQC1DAnMirJ2sxLrFDBNfNYD60QkGmQSSt37FgE3NCuRckDBZTjjwm
 m+OfgT8hWOdWSEJjUSYGYc5Ioo7NLhHVAkksb9OH1VC+9K0p+Kz2bSM+9AkGimlkMCH02gMsyM
 mp0=
X-IronPort-AV: E=Sophos;i="5.77,403,1596470400"; d="scan'208";a="155025555"
Received: from mail-bl2nam02lp2054.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.54])
 by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 13:32:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDS7Gfq86SZ0K3+IFs/k/7lHXyfgrg0x6DOEKqItF577NN+mKZ3uV72bIxwxXdSv2miDL37IqdkRiC8/ZO85vqfmZ5xBXe7H9lJdi4230gG6U7/oY0x58z2T74gXG/8GZovjqTaUo5AKZACzPVxMRn5yyqgN3GL5azqAeg7sFbkp+k4ZnN+zQTlAP9BtyhkieSOxHju3f9+Yq4g7XbV/drJQUQwd4JP5qIKnsZKQlPLis3fWNzHIPR1juxQccStCE/VMg3FESI+UCM3hpc0aVxRMQrASAZkfOERCdqxMBEQvzmDr99616yDbW9rtzS6rKEK9gBLyPVw1Aptoc9IFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/yPYBI3qV0mLaT8Zi4oPUUDkaYwoJSxccurVTac3BI=;
 b=IcJm8XMSqVVgUQPDWtQLIR4HbcFdEWcw+R5lyrBOAbH6sGJ8mQR8jZGESayDNHMrTgGjhaiXlJRpHP0Hd0+2Az7waJiC6jWaxGBNJmyJ8B/4XJ0QnxpqMRYnnB009bTFIQJSbWYq6UMhGTN0/A7UBj9edvVMUk1T4U8kiUOgUPMG3/3e39vfZUmdjPiMzxnkHAIk1/fvV7h8qxu4qKvzdA1j7mkRTzx99Wyhn9Vw9K7XQjUhfYPO+tT72BKgPxFqTqQFHz0hFWUm5/F3rgm4J12cDyaGXzMWlL4lejrMFEcDtscw8KawpivDRZW0DbotDG2Qo9ONTDJ1xvnUOPikWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/yPYBI3qV0mLaT8Zi4oPUUDkaYwoJSxccurVTac3BI=;
 b=sBkFas71sQejjW67La4TUYs7+XSvdaWqR0STNgxiwIL6aTjRBsIVl70Lt9KTwonUXLU1TjRRQBiizk6uM7oUOpZnQ0CISKumYHi3MpcMUbCXwUmT/vqvVSs3yGUpP0w10tf4mE4cPoTudLt12xfUVdRuXLBb36tsjzhUzRuOICw=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR0401MB3509.namprd04.prod.outlook.com (2603:10b6:4:78::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Thu, 22 Oct
 2020 05:32:51 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::d035:e2c6:c11:51dd]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::d035:e2c6:c11:51dd%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 05:32:50 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 1/2] hw/riscv: sifive_u: Allow passing custom DTB
Date: Thu, 22 Oct 2020 11:02:24 +0530
Message-Id: <20201022053225.2596110-1-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.179.78.74]
X-ClientProxiedBy: MA1PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::33) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.78.74) by
 MA1PR01CA0139.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 05:32:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 863e50c2-c25f-44cd-9578-08d8764beaca
X-MS-TrafficTypeDiagnostic: DM5PR0401MB3509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR0401MB3509B3ACBD6015C605B024028D1D0@DM5PR0401MB3509.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:33;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f26FqLwjjiiaWo68J9uQanf7zg3CX4L9eVmI3bfSgxPPC9/6aWR8JPxJIUVAm9wcKcj1Yf4zbjJsW1NgfAOcCknYcSmdwxzGrLJIdtPwq8w+JD7dfUxdrUJlLPXVy6I7/cNR+eseIqEL6phNjRWiOldhPuedzUBkrg9+Lv5En/TmhLFTLFZjsDyNdsctdtSOKon9bZ3iaeingpIGN2CsJxAvsj5Dl92I/GBCPIE6mK5/VWeQTczLo/JqyYZWD0H4syUXwxLJW0w+ujLaq71etJv2ntukIjI+XWEWmRqna/vJ/nOdVF2A01/E9rm5E39DWdq7RcNAaPK8qRqBNHetVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(7696005)(52116002)(4326008)(1076003)(55016002)(6666004)(44832011)(8886007)(110136005)(2906002)(5660300002)(54906003)(83380400001)(316002)(66946007)(26005)(86362001)(2616005)(8936002)(956004)(66556008)(36756003)(478600001)(66476007)(186003)(16526019)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Sk6cTnaPIRg9l5ukdIZDhB25NeKUmixzpD06TF/ymyKW2ARIkWnyAK5nCnImks42wNDq4z5y0OVqtRdPP44YvP3hvx4Fyon7m2X66tFFyueiqg6yTsRc4LtExnaAVshwNnmnJYqGpWcUs4PPMijJ/KLe9BzZbIFECd8y6iJGPFa4hgnX1vxRstDK/GoDWsxfEyBfbkw23cRT6E64jxW+0hgZSgc0pTFq2VsJqH3FUB0DAz0cMVqcRlSBJ64suIfdyPTbfiC6SDpr/LD6cTC5r96OgY4YMvQ0th2sWWeO3htqDC8+zXr7yGgCByaeH09ynBrXyruOhQu/AIhFBSE7Bkg+yuxGTjfRHPTAeYxTntAgR+MQ+4VSbgebH8zCEqEtm8DobL3ppEGHVQSKJZV81LH5SNqOEU9yxQCmkN9W9leJiz1/mqamZNRZd1JK7YoJopOgn/cczvs5NdIMH4DX0g1UADWsSm2ijG44/qgSa0eoCY7dnnjC0ifpYRZw0/APqq78fwHEqOoOVlA1Cafgn2T1lyf7l0W1wdQxrgfBOX6qufSeuRVoQSOhNOuaH0pJcbuxfB5nFdDCqTPCWj+fgkiRGTjwICQLJyThpGMEApRHGLOByu5DNKBmq38TbwRThydawt9H4II7YGljFZgUYQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863e50c2-c25f-44cd-9578-08d8764beaca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 05:32:50.8533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lq2ldipKKPHHLZrixzKlvYLI3+jx454CQOik1bwtiL4SQ5kLYuOxElqTvyCteiKQ2KggpIdGAsgkSyYrJUm6Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3509
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=557099d69=Anup.Patel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 01:32:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend sifive_u machine to allow passing custom DTB using "-dtb"
command-line parameter. This will help users pass modified DTB
or Linux SiFive DTB to sifive_u machine.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 hw/riscv/sifive_u.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6ad975d692..554e38abf0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -100,14 +100,25 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     int cpu;
     uint32_t *cells;
     char *nodename;
+    const char *dtb_filename;
     char ethclk_names[] = "pclk\0hclk";
     uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
 
-    fdt = s->fdt = create_device_tree(&s->fdt_size);
-    if (!fdt) {
-        error_report("create_device_tree() failed");
-        exit(1);
+    dtb_filename = qemu_opt_get(qemu_get_machine_opts(), "dtb");
+    if (dtb_filename) {
+        fdt = s->fdt = load_device_tree(dtb_filename, &s->fdt_size);
+        if (!fdt) {
+            error_report("load_device_tree() failed");
+            exit(1);
+        }
+        goto update_bootargs;
+    } else {
+        fdt = s->fdt = create_device_tree(&s->fdt_size);
+        if (!fdt) {
+            error_report("create_device_tree() failed");
+            exit(1);
+        }
     }
 
     qemu_fdt_setprop_string(fdt, "/", "model", "SiFive HiFive Unleashed A00");
@@ -390,13 +401,14 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    if (cmdline) {
-        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
-    }
-
     qemu_fdt_setprop_string(fdt, "/aliases", "serial0", nodename);
 
     g_free(nodename);
+
+update_bootargs:
+    if (cmdline) {
+        qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    }
 }
 
 static void sifive_u_machine_reset(void *opaque, int n, int level)
-- 
2.25.1


