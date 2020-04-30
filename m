Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B84C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700392076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dnjDjqTd";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="PGl5hYSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700392076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8u7-0006Yf-Hi
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jU8ri-0005TA-GV
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jU8pp-0000fl-Kh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:04:32 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:31919)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jU8po-0000dN-Mk; Thu, 30 Apr 2020 09:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588251756; x=1619787756;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=OWyS2ItCENswFi0wX74u7lTGRvCLfePqlk7kLmaPYqg=;
 b=dnjDjqTdkf2rjolnyGhDUCvRHbcrKKhZzt8oe27D54c47aXh84ltXTxa
 LTPviKibDSVZcb7igR/DW1UJW7UvgxnXIgvbZl9BVbGzTJkHFhQ1LJ5FI
 /1xsAJ2YsoheR3X2QIo2CZxDg1gXe1lMOw3FyS2NWeHlNYZNaP+/pAqAY g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Apr 2020 06:02:31 -0700
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Apr 2020 06:02:30 -0700
Received: from apsanexr02a.ap.qualcomm.com (10.85.0.26) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 06:02:30 -0700
Received: from NASANEXM01C.na.qualcomm.com (10.85.0.83) by
 apsanexr02a.ap.qualcomm.com (10.85.0.26) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 06:02:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 30 Apr 2020 06:02:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+OoIkX5uCN8+GVhZdFlkViY6q53Z11HERl57z48FirL9P027G1KcCbuUy5HunkJHOdC2Ik0oJC2kthNfni/KQjn1v6eRMbOxih164K6LE7dL9UNCSliOKYTlfsXcX9VGGloJHTOW5Z4jz8pOkxGEpJgf1Tr2W/rDwW4TQDNjJsjELam3EIbAU6Qx6KVWtd271qGQ3XLmrPFm78w5I0XpHzx3PvUC9OjikeftufFs1seWs0aKqSvzI5wiuVWIFt5skRCxmKjX9FmofcGGOe38fomnW/Cd4q1K1gjXCltB/5qqx8z01V+qmxNN1GKLBdT6o7sLrackWPSHuLrAo499Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT3ykJzdT4xMzHTzgspA1VgozOmdnHTRDZl7d52NKPg=;
 b=KTdijRn79X9slneLf8sl7rObuEC5x4MafcEkOFLV+BxOdWRydxomJmeXnFBr4CQ0gx8ZIdYo32zl5H9bg4rXgCJUNQabXyh5yAVeEbf495Jj74+fVU1PfTKgq4pitSAovv2mrhwswbQiUogPH0zRIXTyADdWi/Zy5KS0HwfFCpTH/F7U4Fr7kPZtGjTNdns3OUXrDib8pXIIXLdBmV/HSIDOKFsxMaCkeq2moQURUcU+hPXjEOutohOJgJE8lEkRAfiT/F9yxa6U4EquWOKeXBPZasutH27ab/idA6dQDuqQvmlvGQ164OPTU+O1T/h9kRwlnnGIXVAVWjwSWN8y4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT3ykJzdT4xMzHTzgspA1VgozOmdnHTRDZl7d52NKPg=;
 b=PGl5hYSkSGBkjY3v2h5kyHjpVWayM4V/xlKiBNZ8VnCK2so/hR8ShGgv+9xXw6Pp2Z7BHqTJyfeAY0jW2ZESB4XPvsLvWisxEW1BM6TLCWiO/uq17UYFQg7oHb/JyQZbMtDVMaPOlADXfcXZmTogiOVLzwMOeOE1xS+SCu7+gFI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3401.namprd02.prod.outlook.com
 (2603:10b6:301:76::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 13:02:27 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 13:02:27 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] target/arm: Implement SVE2 fp convert precision
Date: Thu, 30 Apr 2020 06:02:08 -0700
Message-ID: <20200430130208.2670-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610::14)
 To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.na.qualcomm.com (108.176.222.2) by
 CH2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:610::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.11 via Frontend Transport; Thu, 30 Apr 2020 13:02:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05bdf45b-0dcc-4ab6-0ffc-08d7ed06bb9d
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3401D101D7507D6EDAEAA1FBC7AA0@MWHPR0201MB3401.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGjzfLdiIzI+y18qGWeJkhfhNiDeqeDyls0lfXfPZLVMtlYjQ63SPD4PPnUTQQBSw1V3NaafojUaVeFVpMYDjA/sdlFs6Uzzvc/VEATep+2HjAeFygbLNJLd7AZfYzKJy9lpU1XJ3fXnvd37cHbdj12Dje4u7cHoIH0OWXcKU5FgHd/TmCh1jh1ogVaCnzOJh1Iw2VFep8abTTfVd1Ni51Pmsk0HT+N3iBE8qtvVHbxTvMTLGPEyjU2adwOx92s+ud9ouTaSDW/PvW85LO9u89tPEBbanrHvZW6mBF4uACWZSqQO58RnufVUyGVXZoQTG+dnjT+ktM3I+5CAIu6WvWZD7G4eKkkI8G6RsbnY/q2Hm21OA6O8Fu8/GArk4eWS2FSXKV3etyOaQnvXi99CJ6ysTY32uMqk3ddzu7ZN5gmVXIIn1k0wK/0fFWUMBURv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(366004)(39860400002)(376002)(396003)(346002)(6506007)(1076003)(6486002)(5660300002)(107886003)(4326008)(52116002)(16526019)(956004)(26005)(186003)(6916009)(66476007)(478600001)(66556008)(2906002)(66946007)(316002)(6512007)(2616005)(6666004)(36756003)(8936002)(86362001)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: C/TjS1ESTzjJkYh0wViRV8JphKFGsNqO8dMXDT0wRkDE9mYOT47iWt6032RfWewIHo5Azn8Ll//jc2L63BFt6JuCbOVCdnBSKVQNhnatuI5iVlob3t30a7a9EOrTc6DSUpr6/IRhSSSCGsdwNsiZPRW5XFq2W//eKJP6JZXr4XPawG0yHRd9u0+iFbJ+8/43WV0DHyYzI8RjuCKItZ7lEhvdyOSkxF4Z7uJpErCUi1S3qYii+1Dq7BwM0eaBxCDZlQX8CJLocH1m9c4FOGOJyKkdYhxj1Z+f36dIaQBvOC8ptUS4A2RmUIlLfiql7JPmbqq/0WiHXmSgdX4uAygtQCS3hrTPiviorC9uTjj85IX8sd5k2IDYl+8y/3FG29V2tPS3UMuQ48puBIZSHP83crZ/Z364jdNDZLsz+z4GPWu6evPC+ZpcAhjWcyktTKiOIBMqUVCdeCpQH/tVu2HAWAwW/fZ/HDlDrKuXjSB+FR6L2Q/HbTtjQTQby31I/FZ8wG/FFNjslwKXyCek0wvOF877UO1CXGJZgBYz+acmXRLzMMWqaOAeSPcrZ9+aillDerLJtzb7VfW9nUT3b2eAYd0FOpotqMYlAmg+sq44ka50KX+rFnFvGjEI9gUy8yrsqfTJ2lsDK6q2c1XMRZjz6tWRrTJsGOx/05EdIHQLEdimaFMCw1OEo1QdeO7yoJ3HVe+CoYDGPtRiahS0m+YKc7bt/8OaAXdr4SmDaAuSOnZIZyvDanRXtsP3D3M6B/i7k1U1zahxgFOkJbUBpyE8JguRUgzgxyeBT3+owwNGxV4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bdf45b-0dcc-4ab6-0ffc-08d7ed06bb9d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 13:02:27.1402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3xOW+HhLFrhtyMp2eN06LPKVN6018NN9Ds/qiH3KYR2tpss6iUnnVyFurKQA28R/m8T1ZZag32refBdhwB5SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3401
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:02:31
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 199.106.114.39
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

Implements FCVTLT, FCVTX, FCVTNT, FCVTXNT

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
 target/arm/helper-sve.h    | 15 ++++++++++
 target/arm/sve.decode      |  8 ++++++
 target/arm/sve_helper.c    | 59 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 48 +++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+)

Ignore my previous patchset. I missed the insn FCVTX and I ended up
squashing those commits into this one. At the moment, I'm working on a patch
for the SVE2 bitwise shift by imm insns.

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0a62eef94e..22c91913ba 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2730,4 +2730,19 @@ DEF_HELPER_FLAGS_5(sve2_cmla_idx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_s, TCG_CALL_NO_RWG,
+
+DEF_HELPER_FLAGS_5(sve2_fcvtxnt, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_fcvtnt_sh, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_fcvtnt_ds, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_fcvtlt_hs, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_fcvtlt_sd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(do_fcvtx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_fcvtx_ds, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 3cf824bac5..bc48094ed8 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1568,3 +1568,11 @@ SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
+
+### SVE2 floating-point convert precision
+FCVTXNT         01100100 00 0010 10 101 ... ..... .....         @rd_pg_rn_e0
+FCVTNT_sh       01100100 10 0010 00 101 ... ..... .....         @rd_pg_rn_e0
+FCVTLT_hs       01100100 10 0010 01 101 ... ..... .....         @rd_pg_rn_e0
+FCVTNT_ds       01100100 11 0010 10 101 ... ..... .....         @rd_pg_rn_e0
+FCVTLT_sd       01100100 11 0010 11 101 ... ..... .....         @rd_pg_rn_e0
+FCVTX_ds        01100101 00 0010 10 101 ... ..... .....         @rd_pg_rn_e0
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index aa94df302a..cb56148cdc 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4624,6 +4624,8 @@ DO_ZPZ_FP(sve_ucvt_dh, uint64_t,     , uint64_to_float16)
 DO_ZPZ_FP(sve_ucvt_ds, uint64_t,     , uint64_to_float32)
 DO_ZPZ_FP(sve_ucvt_dd, uint64_t,     , uint64_to_float64)
 
+DO_ZPZ_FP(do_fcvtx, uint64_t, , float64_to_float32)
+
 #undef DO_ZPZ_FP
 
 static void do_fmla_zpzzz_h(void *vd, void *vn, void *vm, void *va, void *vg,
@@ -7622,3 +7624,60 @@ void HELPER(fmmla_d)(void *vd, void *va, void *vn, void *vm,
         d[3] = float64_add(a[3], float64_add(p0, p1, status), status);
     }
 }
+
+#define DO_FCVTNT(NAME, TYPEW, TYPEN, HW, HN, OP)                             \
+void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc)  \
+{                                                                             \
+    intptr_t i = simd_oprsz(desc);                                            \
+    uint64_t *g = vg;                                                         \
+    do {                                                                      \
+        uint64_t pg = g[(i - 1) >> 6];                                        \
+        do {                                                                  \
+            i -= sizeof(TYPEW);                                               \
+            if (likely((pg >> (i & 63)) & 1)) {                               \
+                TYPEW nn = *(TYPEW *)(vn + HW(i));                            \
+                *(TYPEN *)(vd + HN(i + sizeof(TYPEN))) = OP(nn, status);      \
+            }                                                                 \
+        } while (i & 63);                                                     \
+    } while (i != 0);                                                         \
+}
+
+DO_FCVTNT(sve2_fcvtnt_sh, uint32_t, uint16_t, H1_4, H1_2, sve_f32_to_f16)
+DO_FCVTNT(sve2_fcvtnt_ds, uint64_t, uint32_t, H1_4, H1_2, float64_to_float32)
+
+void HELPER(sve2_fcvtxnt)(void *vd, void *vn, void *vg,
+                          void *status, uint32_t desc)
+{
+    set_float_rounding_mode(float_round_to_odd, status);
+    HELPER(sve2_fcvtnt_ds)(vd, vn, vg, status, desc);
+}
+
+#define DO_FCVTLT(NAME, TYPEW, TYPEN, HW, HN, OP)                             \
+void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc)  \
+{                                                                             \
+    intptr_t i = simd_oprsz(desc);                                            \
+    uint64_t *g = vg;                                                         \
+    do {                                                                      \
+        uint64_t pg = g[(i - 1) >> 6];                                        \
+        do {                                                                  \
+            i -= sizeof(TYPEW);                                               \
+            if (likely((pg >> (i & 63)) & 1)) {                               \
+                TYPEN nn = *(TYPEN *)(vn + HN(i + sizeof(TYPEN)));            \
+                *(TYPEW *)(vd + HW(i)) = OP(nn, status);                      \
+            }                                                                 \
+        } while (i & 63);                                                     \
+    } while (i != 0);                                                         \
+}
+
+DO_FCVTLT(sve2_fcvtlt_hs, uint32_t, uint16_t, H1_4, H1_2, sve_f16_to_f32)
+DO_FCVTLT(sve2_fcvtlt_sd, uint64_t, uint32_t, H1_4, H1_2, float32_to_float64)
+
+void HELPER(sve2_fcvtx_ds)(void *vd, void *vn, void *vg, void *status,
+                        uint32_t desc)
+{
+    set_float_rounding_mode(float_round_to_odd, status);
+    HELPER(do_fcvtx)(vd, vn, vg, status, desc);
+}
+
+#undef DO_FCVTLT
+#undef DO_FCVTNT
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a8e57ea5f4..7e31468dc0 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8253,3 +8253,51 @@ static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
     }
     return true;
 }
+
+static bool trans_FCVTXNT(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_fcvtxnt);
+}
+
+static bool trans_FCVTNT_sh(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_fcvtnt_sh);
+}
+
+static bool trans_FCVTNT_ds(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_fcvtnt_ds);
+}
+
+static bool trans_FCVTLT_hs(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_fcvtlt_hs);
+}
+
+static bool trans_FCVTLT_sd(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_fcvtlt_sd);
+}
+
+static bool trans_FCVTX_ds(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_fcvtx_ds);
+}
-- 
2.17.1


