Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901CAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFD62074B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 11:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i8Ftcq+z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pHQ9wABU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFD62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0kJK-0008T2-FS
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 07:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=47218c038=Anup.Patel@wdc.com>)
 id 1k0kGK-0005D5-4V; Wed, 29 Jul 2020 07:28:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=47218c038=Anup.Patel@wdc.com>)
 id 1k0kGI-0001pz-0I; Wed, 29 Jul 2020 07:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596022121; x=1627558121;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=3ovgoh9RYf9x+TXZWqjXqhdhVCBZC5tQzm8JwHuvwZA=;
 b=i8Ftcq+zMYmTeNerMgPmWakB/v4q6Y2QRoBeYs1zV1RCTwP+IbBR0MMf
 zJMCFe61nONh3CQM91PX5jh5x0BWnTQMdus3LRazkSpgaoOVvL9TevSq9
 FybXrEdBHOUZf3waTA3A1gf1ckaceAokZENaxtvj5wvtHDEyJTeLIdJo+
 zacjJYS8WNoZsUBsh0LmNRWFabhi9/SuoC00EDv/BrxPOp+1QZQSR7FvL
 eGK4NRqFL7dn9lKjCWzQZKozJSWuLqlnGsjdT+AXJksZONBJfdgvqkVxe
 +lxgugAZt/9Y72yOJRjkN7l9X4ug9/H39AXVxXeCZanad2X+2ygLXJOqO A==;
IronPort-SDR: Uu+pcmRyLy+qVlbzzGurXQRluKS5YCflVJaI6GVreGcHebP5lA2e6hscHefKrwLBPo0yQCLTW4
 K/NrdAsWply+YKGBi0cQbDtBrVlolnXNTos9WDkWobhf5GOSjPfOB7T+m5i4dBXk+79cQE7DaQ
 SPesg5nDinnDWtYh+OpdP99U6yZFll+9WW7jo81/WswXi5IJwKjvgmI0fe7rg0XTHKpEwQgvZ3
 P4CWGH9Wl47d51lr7b0F2Uievw/DMTHL719zzIKv9YIEkmQZ2RLDEvvhW0WvM63uxpw4gX/NTH
 lms=
X-IronPort-AV: E=Sophos;i="5.75,410,1589212800"; d="scan'208";a="143644194"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2020 19:28:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4uYmPxCEmbfJMaKz/iNVGx2ZO0oLdoz7vv3EGKEzpMqyX2y6VBTprslcLbUTLMqkIAb+6/zricPeF+8XKKk+En0nmpl3qSDVpE256Ux5S0Uhi2xeHS5D+H3fb21BmRtq7Sj9RPuum2htcl475a1iR3HNCBBTsiibcF2VyBmaQqcRLKs5Qdf3nGbWlmDr+SCA8AY2fHfg/zwRbO9porJovjVJFPr9CG6zoHnwaC5cVPsML+YM2i+jH80fdqJQaZCYyw2Ry8RCYThYyusGuR/8/52LGf5ua21V5nKdjXUPNBC+wI+Kc0e2vut75QXXmg6EvvABKBYVhuMVLSlkXnBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zucbBLuhA++Js13w8UpK5p5c03btMirgbnWzE/10yg=;
 b=nI/EB0jFCfz4e7/En1KAdFQJfmbCcO1u2Ljc7x4aF8UL8LCCXQVip+TL66Jfs1CwqSfbwnvWMBLy/1eg6ZTDpTUj+OMlIiOfIU1ln/laXDAUtVfxNnnBEA0lOW25CH2zCAp9o8S7QfLYrb2i0YDm3ARzIBV62S9ZG0Oqy4bAtZ2XNcY56bqIK7hPT6o6b2nng/WnPZujZoXX9NUjdBhmXvhH4KJt9WzoUQDqfloZKpUfyrWV8M8SuN4lfEGCLg+7pg9mNRWCiqp9vPoicL3DKZGLXPOSgtuQ2H6NpX7SZguWXq+eomlz4+4VAnLczgNjJ71gCLmoXAFNilx9MPU1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zucbBLuhA++Js13w8UpK5p5c03btMirgbnWzE/10yg=;
 b=pHQ9wABUQpPdAAkSwBcudrurpjUE5XweB42QSXHg/truDBcQAPSjjQdIv6AATQyeGHKE2eWGcFWP+s0U225P5jGTGeIUSH3Xf4KOm2p8Ci78qcPXAHsslMBqSwdCtXiVxQ7OOOVmbLzjJD3ISKr213ugE5lm7ifeBlhnKX+/fwY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB5753.namprd04.prod.outlook.com (2603:10b6:5:167::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Wed, 29 Jul
 2020 11:28:38 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::e0a4:aa82:1847:dea5%7]) with mapi id 15.20.3239.017; Wed, 29 Jul 2020
 11:28:38 +0000
From: Anup Patel <anup.patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH 2/3] target/riscv: Fix write_htinst() implementation
Date: Wed, 29 Jul 2020 16:58:00 +0530
Message-Id: <20200729112801.108985-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729112801.108985-1-anup.patel@wdc.com>
References: <20200729112801.108985-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::36) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (103.56.183.175) by
 BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Wed, 29 Jul 2020 11:28:34 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [103.56.183.175]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 564d6e7c-4e39-4a54-5cae-08d833b289dc
X-MS-TrafficTypeDiagnostic: DM6PR04MB5753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR04MB5753AE5EA4FC5A1485ADD8178D700@DM6PR04MB5753.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImuYcHTkx6qGb7C/QNazCftt3b+P0718EpHRXf9Oto+qPCv2FLXpUybvwDo+hhishBL27B9OM4Zopy/RCsf6FwLG8OVzBN0gd7e5WtZBKQDFq1ahKd/axFTT2ySFEEl4/cZ02Lo340b+rlDIQJHlRLNYBkMENwu4yRdkowFOs546xVEhI6Y3tX6SWHtx9Hg4UQBU8rFLP/JsqQ4YWNlotaVy6AvB++MqRpl+5fS6J1aRG8Qra6qtsgPs6ahd0dT5ioSj1i9Of1A8RPApPBrNqmt2do2Ii8ys/+Cu/4uMaVD6zRObsabhSKRscRCNX6gc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(4326008)(36756003)(956004)(2616005)(52116002)(8886007)(110136005)(2906002)(7696005)(55016002)(8676002)(44832011)(186003)(4744005)(66946007)(316002)(26005)(54906003)(16526019)(8936002)(86362001)(66556008)(5660300002)(6666004)(1076003)(478600001)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xf7vNfROaFLCi/6v1t2YG+Qgc6gwliR8ibRtNXFkXGbBk/59BOyTivvQUshfQOgCsJX8FU9J8LWxEeKqsDCIkWWrgGESclWIDm5WZhj65JNjGe7n2NOBuqsPGztBM7L8T46ILKIu6ATRm99gqbWyRoNSz0oskdjM+rMixqj96p+VxeK1+v707WE6oWfBjwk/hFUSARkzi63UkDq+G99kVidrzdCykK1Sn3momofneYa4p9oTuUy+dliy2R3tPA/aVIoNhK04LW8nhJ9FB2StLAWPa4v2Hdqg4pmMs+Pbx2R8op4+7r0GLyoow88A0z0Rp3xXfSdYTOaYcyzV6HHfIVe48UJtHK0FZ0eC52qYhf1N2mN6i6TFU+HKhapwlyEJQyOhps/2nrp1z++kCTPxXaqpC1fHhY62FRX7aqZA15eifCpevZkZwNAr/Mk4TvnUUjbX2PNrmWY0R6X1us90r1tJC7jc05Yql3eO9DsyThx4R9ni2Jz6O/NeRyAXII1Y
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564d6e7c-4e39-4a54-5cae-08d833b289dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 11:28:38.7907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9q6tKpLvLn8rkf8oQu5is084v71hQR31YciJkAWJmcFN2HasvtEKeHWnhkCfUUFrGoBXKqJfOry4O/8itaO9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5753
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=47218c038=Anup.Patel@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 07:28:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The htinst CSR is writeable from M-mode and HS-mode so
we should not ignore writes to htinst CSR.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 target/riscv/csr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f985b85de4..99fcb7f67d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -943,6 +943,7 @@ static int read_htinst(CPURISCVState *env, int csrno, target_ulong *val)
 
 static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
 {
+    env->htinst = val;
     return 0;
 }
 
-- 
2.25.1


