Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F92C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7D62083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="vMMPLqJP";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="NGfTCtW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7D62083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTnA-0003gh-Iw
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 12:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jPTld-00024H-RZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jPTlb-0007iO-WD
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:23:01 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:65335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jPTla-0007gr-Fp; Fri, 17 Apr 2020 12:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587140578; x=1618676578;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=G6IZrIG+GaV2o21HswiIwVBpmtJCeR/c3OMbR/NiLp0=;
 b=vMMPLqJPSxK+hK/nGCia/6+Sbrq67OSWVlXXdGWSeIP/hy9Qr+ziiXYJ
 TplpZKi0Ahkiy4W3qBYDBeEYaG5g+MJwLccGdyeFXwCoLJ1TP2IXFRUD/
 uWbA9e6z2DQEI6D5EPses+OHa6KP6n5zPhcvHlhej1N/jS4qmC2sOERFC 8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Apr 2020 09:22:57 -0700
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 17 Apr 2020 09:22:57 -0700
Received: from apsanexr02f.ap.qualcomm.com (10.85.0.29) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 09:22:56 -0700
Received: from nasanexm03b.na.qualcomm.com (10.85.0.98) by
 apsanexr02f.ap.qualcomm.com (10.85.0.29) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 09:22:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03b.na.qualcomm.com (10.85.0.98) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 17 Apr 2020 09:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFUxdlqZF09UdM+fHEl4bB3PzsssPj4r2/PyaNbTF37ULpUk/+EFRadBgbxiAJnq6CGY9i0jBRkn+3xzsOvgH1fRgCzQBH2sSwjw/+1xxTV1hHjsYs/VVluLKmF/0xQgnQE+AmdES2ezEOLl2OXvBJff88ri0l6lckc3af3RR3TnMpNgErRcJ19KPeN8ecMsL9dvQy7s5bVWVEpJpDkp0oAOQrbusucxLGz+S3TCPBISEEwoJQ3MRk9TZnQP0JYJNpoG+hpI/DvKg9Kzk0dp3M7h4uyOzvrJTBMjPWtgUhpQczPPgxvzejRD0PsaDbMfkkD10/9DATZJfM34ChhMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P20yB/cy6Iy4pVkHiEfdQFWDkNpzjYa5Rcd0mNGaP4Q=;
 b=F7BXbaAtntQnvk8ddB1MDTTHEmWsxrou/ZOTIuL7StLaKjLO+9mfOVsPezXAzmk/gykozYFb8emcCnPr1+3W8uGH5Kv80toHhhg051/fNaUiXemtB2TpwzKdjTjw5XfH1kBFWvfi9tLd6vnfJGvBNecz/51VINpM/xeSSfroPwMtZx0iNPWfPPAsenCWD8ngdFUbaV9OVh6pHyPLLhji+D/TlZAl+c7AhZbf/e5NvIZxeM3R2l8Ce58vjv5bu6v6RzTia0F6moK5jxSfQPM7iR8ARD2+BCzcOmLmXwDUC2XOGShJ8WBqZKmO8lw0RppJbjFvy18Y7J9l2Su/3/yxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P20yB/cy6Iy4pVkHiEfdQFWDkNpzjYa5Rcd0mNGaP4Q=;
 b=NGfTCtW6kpp/c0SHcNe0zEy3yy0Ous2CP45hyiwG2NRKtHYFmAxH+BZPNhFAoYkAADnz2lLE7nEKVdPiKPdqMBumEkMLaLZycFC8GxvFzfxXrXbHnGVYDWLOMMg8pn9Gnrbs4/lMVW/LkkJ2J329N6J8amrcbs5QBSliVaUnTjs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 16:22:49 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.030; Fri, 17 Apr 2020
 16:22:49 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 2/4] target/arm: Implement SVE2 RADDHNB, RADDHNT
Date: Fri, 17 Apr 2020 12:22:29 -0400
Message-ID: <20200417162231.10374-3-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417162231.10374-1-steplong@quicinc.com>
References: <20200417162231.10374-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:610:57::27) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:610:57::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 16:22:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d821d4c6-03d3-424d-3ca4-08d7e2eb91dc
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3484F7A8ED9ADB5634B3B34FC7D90@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:65;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(5660300002)(107886003)(4326008)(66946007)(66476007)(66556008)(6916009)(6486002)(478600001)(6512007)(6666004)(2906002)(36756003)(186003)(16526019)(86362001)(956004)(1076003)(2616005)(316002)(8676002)(26005)(6506007)(52116002)(81156014)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zm61WIMyu5b84gL6qUkxREqU/st7YxFIMWi6l/BOZ4k7zI1nh1thuGu1RWuPPhSpJgIwXcNx9+SQtHy5zenX0s7FxczCM3miFE91NLeTD2ya88qpK+mePCpP48UQwkd37PeQDxA/Mzp56FfwXuTH5xr0+jeERtuUkoTLhLZXOG9+fKm16drUrfRiseHKLKySS0gfrXhAHCqYLkkHnrrKfwWqCqS2yvWQlHsg6wKAR85xegcCMvEeNq+SWJ/NRAyPejAGYksEa7LSYhQgNkuN80g51E+uEGpyMJOmuKZJFi+ifKfq39NVUgipPMaqhB0okHA/Z70Mpw8PM8kVKxqnYSO3Ij07sSsa9KNVuhAnmcDqtO8To7Wi4gpoWYeC2Wq30OGVE7pVHYkIPp0mTis13cTeZTV2ZjEeSdINSU62msTikflxbTEZ9RXvJymBT2LU
X-MS-Exchange-AntiSpam-MessageData: bKNqtFphTnEb0ttBZCoJOzx2Ts+FT8fFLgsG1I7ViX5BvUt5QkloFz0d225lgBdJ6DzBjR6xfcHmUnWYi4e3Avlv92DZimSud6MiNHhPTDH0PnM2CN63+gfW6OuhRTSeuOEZKb61Ln/SDGJoTAC26w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d821d4c6-03d3-424d-3ca4-08d7e2eb91dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:22:49.1284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9Fn2eqtt01w7w+DjKFaTWkbXiducufm2r331BN/ed44Wlleju8h9z4Sk02wZGn8ZD6WpSJ8nAaGU5rqlIrYjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3484
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
 target/arm/helper-sve.h    |  8 ++++++++
 target/arm/sve.decode      |  2 ++
 target/arm/sve_helper.c    | 10 ++++++++++
 target/arm/translate-sve.c |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 5b8a8b0656..5d5542a82a 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2524,6 +2524,14 @@ DEF_HELPER_FLAGS_4(sve2_addhnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_addhnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_addhnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_raddhnb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_raddhnb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_raddhnb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_raddhnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_raddhnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_raddhnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve2_match_ppzz_b, TCG_CALL_NO_RWG,
                    i32, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_match_ppzz_h, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index e6a12f4e66..9d82677808 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1325,6 +1325,8 @@ UQRSHRNT        01000101 .. 1 ..... 00 1111 ..... .....  @rd_rn_tszimm_shr
 
 ADDHNB          01000101 .. 1 ..... 011 000 ..... .....  @rd_rn_rm
 ADDHNT          01000101 .. 1 ..... 011 001 ..... .....  @rd_rn_rm
+RADDHNB         01000101 .. 1 ..... 011 010 ..... .....  @rd_rn_rm
+RADDHNT         01000101 .. 1 ..... 011 011 ..... .....  @rd_rn_rm
 
 ### SVE2 Character Match
 
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 743240aa80..f92b8dd312 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2048,6 +2048,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)              \
 }
 
 #define DO_ADDHN(N, M, SH)  ((N + M) >> SH)
+#define DO_RADDHN(N, M, SH) ((N + M + (1 << (SH - 1))) >> SH)
 
 DO_BINOPNB(sve2_addhnb_h, uint16_t, uint8_t, 8, DO_ADDHN)
 DO_BINOPNB(sve2_addhnb_s, uint32_t, uint16_t, 16, DO_ADDHN)
@@ -2057,6 +2058,15 @@ DO_BINOPNT(sve2_addhnt_h, uint16_t, uint8_t, 8, H1_2, H1, DO_ADDHN)
 DO_BINOPNT(sve2_addhnt_s, uint32_t, uint16_t, 16, H1_4, H1_2, DO_ADDHN)
 DO_BINOPNT(sve2_addhnt_d, uint64_t, uint32_t, 32,     , H1_4, DO_ADDHN)
 
+DO_BINOPNB(sve2_raddhnb_h, uint16_t, uint8_t, 8, DO_RADDHN)
+DO_BINOPNB(sve2_raddhnb_s, uint32_t, uint16_t, 16, DO_RADDHN)
+DO_BINOPNB(sve2_raddhnb_d, uint64_t, uint32_t, 32, DO_RADDHN)
+
+DO_BINOPNT(sve2_raddhnt_h, uint16_t, uint8_t, 8, H1_2, H1, DO_RADDHN)
+DO_BINOPNT(sve2_raddhnt_s, uint32_t, uint16_t, 16, H1_4, H1_2, DO_RADDHN)
+DO_BINOPNT(sve2_raddhnt_d, uint64_t, uint32_t, 32,     , H1_4, DO_RADDHN)
+
+#undef DO_RADDHN
 #undef DO_ADDHN
 
 #undef DO_BINOPNB
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0d1a9cd8a5..a36eb9cf98 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7516,6 +7516,8 @@ static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a)                 \
 
 DO_SVE2_ZZZ_NARROW(ADDHNB, addhnb)
 DO_SVE2_ZZZ_NARROW(ADDHNT, addhnt)
+DO_SVE2_ZZZ_NARROW(RADDHNB, raddhnb)
+DO_SVE2_ZZZ_NARROW(RADDHNT, raddhnt)
 
 static bool do_sve2_ppzz_flags(DisasContext *s, arg_rprr_esz *a,
                                gen_helper_gvec_flags_4 *fn)
-- 
2.17.1


