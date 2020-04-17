Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBD8C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E052083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fs9yXHlx";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="rjvvRqh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E052083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPTqL-0007be-Ce
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 12:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jPTlh-00027z-EQ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jPTlg-0007ku-3E
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 12:23:05 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:65349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jPTlf-0007jv-RQ; Fri, 17 Apr 2020 12:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587140583; x=1618676583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=ei0R4waqVRE/JAQwz+ETEou8n70kUYcmScagegOMUS0=;
 b=fs9yXHlxSRZcp6DCpu7KVOWbuG5DPrd8Op+iWntmP3mftCOVxQD9cuqj
 LMGp2S4jGerbrn6ynUqXUech/ZJwSepzw7YC5284Vt4G5SYa11pmCWM38
 86ITnQ1E/AU9Y175Ri7uw1q9IWJeeOhtu+tgw6IrELHJC1QcumzfIuY9e A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Apr 2020 09:23:02 -0700
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 17 Apr 2020 09:23:02 -0700
Received: from eusanexr01e.eu.qualcomm.com (10.85.0.100) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 09:23:01 -0700
Received: from NASANEXM01H.na.qualcomm.com (10.85.0.34) by
 eusanexr01e.eu.qualcomm.com (10.85.0.100) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Apr 2020 09:22:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 17 Apr 2020 09:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG2ttctbbdF8Uaccwvvt49NTyivERMwqcDkvB0M0A8DvuIL5mMj4cnP9TAN2yoigWR+JfhOi6CnNb2O+qJuCea78GM64H0ishtYYk3Ktzz7tAT9EoG02ctVzIm23444y/S8gtcWWKhEM0eSLMIttwwomlk+cjZsAOal2bxE1ViV2sFBHZb4mLz7JJhVX+NZe0ZYwGdFQ73y6l6zkQ3xAFGxf75D1B9+yjs/vqn30V6IRoVetNBIvcaqlmYVedTacIRHFrEP+0LrfSVNq7bNOJokVtK/aoh3SjMHWwRBZHTIyNfMIYnr5A7mclEKzBKafMryxvfCugaFRE97ibwQ+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/MVM6Rylf9oEFKkDPh393K6rZ4AVl+s217nPgJu7Ds=;
 b=LwcuDa10zZXdvCm3erEJI7rM38X74ftRms9Ppzk5Z2SrTien7Q/lN5n8VDnEhPWgfmf3K0GZbZcdPaUm5bJ/1qIL4GZmOK//oI1Ax223Okt6rcT1Dzdzw0iWtw1ClvbD4O8Jj3Bl2yMXotFXR/ssZPWw8nY6NJCPNC7gT3Z/h0QobMviYEu/7bciPGnHlh3/u4DJ5+tn0b6ut7Zg8HbH1h593loJCYEriDssaA8WDYutLa0Prb3Q4eiUrBcx9oe+BPExHdzTZvilKftcCdxj14XRlwEv+FczgTqN8I3+vAIaMT5GY0mkKAof38Y+7rQA+FtsnEJV1tr8KaEJfpv4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/MVM6Rylf9oEFKkDPh393K6rZ4AVl+s217nPgJu7Ds=;
 b=rjvvRqh9GMW7Furd2ive72SioAW+4HLKGGv9mMnM6QMEk/O+mDWxuX7WJXvSFtNBwHCsrng4eu/rPxccw1ka6/H39Nb/l1haf5FwwWp+W5JBQIU1OOgpFvjvqeus6FClTjc4DblShqqTNzCYmlDuAOSe0U8f3y51zw7fOD5w7YY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3484.namprd02.prod.outlook.com
 (2603:10b6:301:77::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 16:22:51 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.030; Fri, 17 Apr 2020
 16:22:51 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 4/4] target/arm: Implement SVE2 RSUBHNB, RSUBHNT
Date: Fri, 17 Apr 2020 12:22:31 -0400
Message-ID: <20200417162231.10374-5-steplong@quicinc.com>
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
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 16:22:50 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fda0aaf-17d5-4ea5-7d7c-08d7e2eb9313
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34843D4FF489043CF46B6029C7D90@MWHPR0201MB3484.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(5660300002)(107886003)(4326008)(66946007)(66476007)(66556008)(6916009)(6486002)(478600001)(6512007)(6666004)(2906002)(36756003)(186003)(16526019)(86362001)(956004)(1076003)(2616005)(316002)(8676002)(26005)(6506007)(52116002)(81156014)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/MVggk6bUChj94Iz3Z+E7D9Msa9ETdu2KLDV7Lblxq2tWjLtV5LcVIA1cyMArKA3BMcUVHc4VuGlVcHwv54AnAwds+2fHrYVMVoRX0eIEmRN99xOMItAO8U35KQNL4DiJyWwivRUje3JSSWt+O21A0dR03kB4efD93kC7HxvHzylfaomWnAeu4puRplEPdsNM0qhdro9EeWkPnVwujCNJW6RljAsvzEMb1BoQD7S9LvP+ytykKN7O5sBfE8VlqjMszqLmTF43Pv03cTv3t0lYkRyThmaKJF5E0ZwD2PNa3utdJXmqvaQztiYS3DNsRLrxmJx1WAyZKHry/HYVuVEqfl1+7jcEnjKqx7TGCgGW9wUFto3n+o+xElPwezrZ4iBKFz8n/AI3Pi6OWx7mkyrifar8Nsh2dKtQKagRWKY+7TNEBCWw/SjCqjZ5fBzkzU
X-MS-Exchange-AntiSpam-MessageData: ipfWZFCOmZVF76ADm9DtHuhX9HckJ3ShbIE6BG4xh+W6A9E8C1x5CxjmjIc5ZapItaR0jT2eRgAI3z6ijotOf9pwjJESo4iWEPRJUACFW8RAq5LbGfFBge53VnWLcw4Awzu5vBAY28pVFIe0mf9S7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fda0aaf-17d5-4ea5-7d7c-08d7e2eb9313
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:22:51.1672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrZLJKtttnC3WCx/m3Z1MDyWeAXiG04lb3XehRKQwn0+CkdZkDZ0CRBUnms3M3yOw8ehF4Y0R345Ok17V52fAg==
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

This completes the section 'SVE2 integer add/subtract narrow high part'

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
 target/arm/helper-sve.h    |  8 ++++++++
 target/arm/sve.decode      |  2 ++
 target/arm/sve_helper.c    | 10 ++++++++++
 target/arm/translate-sve.c |  2 ++
 4 files changed, 22 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 00e3706da0..011aa03010 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2540,6 +2540,14 @@ DEF_HELPER_FLAGS_4(sve2_subhnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_subhnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_subhnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_rsubhnb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_rsubhnb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_rsubhnb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_rsubhnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_rsubhnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_rsubhnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve2_match_ppzz_b, TCG_CALL_NO_RWG,
                    i32, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_match_ppzz_h, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 75996897a1..f0e6143e00 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1329,6 +1329,8 @@ RADDHNB         01000101 .. 1 ..... 011 010 ..... .....  @rd_rn_rm
 RADDHNT         01000101 .. 1 ..... 011 011 ..... .....  @rd_rn_rm
 SUBHNB          01000101 .. 1 ..... 011 100 ..... .....  @rd_rn_rm
 SUBHNT          01000101 .. 1 ..... 011 101 ..... .....  @rd_rn_rm
+RSUBHNB         01000101 .. 1 ..... 011 110 ..... .....  @rd_rn_rm
+RSUBHNT         01000101 .. 1 ..... 011 111 ..... .....  @rd_rn_rm
 
 ### SVE2 Character Match
 
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index f6e7694b9f..d616010390 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2050,6 +2050,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)              \
 #define DO_ADDHN(N, M, SH)  ((N + M) >> SH)
 #define DO_RADDHN(N, M, SH) ((N + M + (1 << (SH - 1))) >> SH)
 #define DO_SUBHN(N, M, SH)  ((N - M) >> SH)
+#define DO_RSUBHN(N, M, SH) ((N - M + (1 << (SH - 1))) >> SH)
 
 DO_BINOPNB(sve2_addhnb_h, uint16_t, uint8_t, 8, DO_ADDHN)
 DO_BINOPNB(sve2_addhnb_s, uint32_t, uint16_t, 16, DO_ADDHN)
@@ -2075,6 +2076,15 @@ DO_BINOPNT(sve2_subhnt_h, uint16_t, uint8_t, 8, H1_2, H1, DO_SUBHN)
 DO_BINOPNT(sve2_subhnt_s, uint32_t, uint16_t, 16, H1_4, H1_2, DO_SUBHN)
 DO_BINOPNT(sve2_subhnt_d, uint64_t, uint32_t, 32,     , H1_4, DO_SUBHN)
 
+DO_BINOPNB(sve2_rsubhnb_h, uint16_t, uint8_t, 8, DO_RSUBHN)
+DO_BINOPNB(sve2_rsubhnb_s, uint32_t, uint16_t, 16, DO_RSUBHN)
+DO_BINOPNB(sve2_rsubhnb_d, uint64_t, uint32_t, 32, DO_RSUBHN)
+
+DO_BINOPNT(sve2_rsubhnt_h, uint16_t, uint8_t, 8, H1_2, H1, DO_RSUBHN)
+DO_BINOPNT(sve2_rsubhnt_s, uint32_t, uint16_t, 16, H1_4, H1_2, DO_RSUBHN)
+DO_BINOPNT(sve2_rsubhnt_d, uint64_t, uint32_t, 32,     , H1_4, DO_RSUBHN)
+
+#undef DO_RSUBHN
 #undef DO_SUBHN
 #undef DO_RADDHN
 #undef DO_ADDHN
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4081fcb873..d75dd938ef 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7521,6 +7521,8 @@ DO_SVE2_ZZZ_NARROW(RADDHNT, raddhnt)
 
 DO_SVE2_ZZZ_NARROW(SUBHNB, subhnb)
 DO_SVE2_ZZZ_NARROW(SUBHNT, subhnt)
+DO_SVE2_ZZZ_NARROW(RSUBHNB, rsubhnb)
+DO_SVE2_ZZZ_NARROW(RSUBHNT, rsubhnt)
 
 static bool do_sve2_ppzz_flags(DisasContext *s, arg_rprr_esz *a,
                                gen_helper_gvec_flags_4 *fn)
-- 
2.17.1


