Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6319AC8300C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E4BC2074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GFAbmB4G";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="f61AjFzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4BC2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9K7-00075q-47
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jU9GE-0004QO-2i
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jU9F1-0002nV-7f
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:29:52 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:29267)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jU9F0-0002nK-Ir; Thu, 30 Apr 2020 09:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588253318; x=1619789318;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=ymC8LOLLUILQtJI46MwLQoxs9l+g69GQTIIL8sIVTxs=;
 b=GFAbmB4GTD2zkZcPXdN0/K0mY6sw8RnMelRoX/Ryw5smuRCAvvJC5xBC
 LNFjSLgUbuBBfJJCWhVC/MPe/tzqKbXLw+VPdncZaiPfqLYHEhRrviIXD
 Qbb3ADaNZ18ymSw/IrGKjwleGnSWteebPgjHZwOHMfnalw810FQGgXVJa U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Apr 2020 06:28:36 -0700
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Apr 2020 06:28:35 -0700
Received: from APSANEXR01F.ap.qualcomm.com (10.85.0.39) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 06:28:34 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 APSANEXR01F.ap.qualcomm.com (10.85.0.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 06:28:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 30 Apr 2020 06:28:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDg60PcWu6iNJ6jxGABszSmo/9XWhlfZd/RTpq6davIUcRb80MCrUFvJKzXM/Y5DhQn5ujgdAvb4fEgFFpS6PmhJk+kdULOJauKXu8whE5sgECKlWNbzBJSWol33NyqKBjlypEAe7gqBMPYZIvrRdLa7e4sG2jqVWq6FZOAW9aaPKx+ZhTr20RXTweiygu5zzKFTgTAyg3ZT5hID+Fhj+toyHR7G/3lqVa1iZUaZTLv9asQLCP1rtJmXp7BoIz8e2/dWXkOg00bmoEvR6dpwu88DfkGQuXx01vqS+A9e4RVmiZkT1cg2wGFYSQXs8RhQ9pmsK094+oSmSRbeC5qc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBWh8fMlWa9h08QSPXLKt6rWuoY0lslP+feZyus01ic=;
 b=iiuovBhOmIcPNreNMUqEAtqO2iM7xWC4+B6iPBengNiWQZduReYLI6mtvyphFOCSEwSDAAYkxMh7dq12u2xup1j2o5LrZuMr9eZYQwRa1BuF424APD4erllE0rtA5Y4L4FKMJ2pbrAZjiPDxMyvbnbp9EZ5vJhTMEPLjBrrhCy2RtbidPj6ptBOUZoRoY5RrnvbIcBOLjQY0+LohcehAXJRUsfP8XvrPDM8oimIjeS17XwyQVSOCLZTXVaz7rrNUOr+8Xcz+XIdbxWVacVXCKZOLQJ9yTX+SMW7KVeocO39NLvueqTliDgPxCtFKL/CLt7NPFHp/+ORyvZqULLvb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBWh8fMlWa9h08QSPXLKt6rWuoY0lslP+feZyus01ic=;
 b=f61AjFzTFcN5Njmwmo6EkQzc0xuNz/NWR2xsq6AQt+yz3foruuqQBEG2HMtVkAxjngHLw/1Q5T3sd42LLGZ2L0fh67U4n00f+1V4opAdiU/HDW8bNPLbmgyMPhANyWpf3ly85J3RBgk3c0/Bi7IroYuvTjk+tQQCahpxnQ0Dbn0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3516.namprd02.prod.outlook.com
 (2603:10b6:301:76::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 13:28:26 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 13:28:26 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2] target/arm: Implement SVE2 fp convert precision
Date: Thu, 30 Apr 2020 06:28:13 -0700
Message-ID: <20200430132813.7750-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:208:fc::17) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.na.qualcomm.com (108.176.222.2) by
 MN2PR02CA0004.namprd02.prod.outlook.com (2603:10b6:208:fc::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 13:28:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d32af99-6b50-4151-83df-08d7ed0a5cde
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3516:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB351668B5BC4E6012E02F65FEC7AA0@MWHPR0201MB3516.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oD0JOu+6tqegetmoWbNsrNCr3youqMzVGIV1eaviuFwkUM6Evw/lGagdhlIwiWp4M5Eu5lEooNNNh9lquGTejpFxPnl5woU8s9DRR/U/XiGb5N/83XnDqjfZ+5hkOqVjljpb+2o124SlMZOyNRXzbelVuvRR4fuf0H7f/xkx4sUR3edQE7h/T7JDDNu3X4B3qedmcRvVdgSfDEODZ6nAXrPqdDYlVHKtQCqeyAhHjWgwybvmvc5Nnnkb20rxtaeD2yjb2Kci4erO1a+ioT/bx7PbZkYTXD9BVdHh+SptQlVgTC3eliWq8Bvzk/gzMzwOPUSjvszkdhjx+uctV236gOiJKwBlJO+9CGKe+/z512apKZj5DV1NdBmEOaNE55LGycrY9c6jrrZIUbLsoD5g6d8fSmivWD4KHcFk0tYK3EAu4TdIDOpieiY/9Y4ba0JL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(136003)(396003)(66556008)(66476007)(6506007)(26005)(1076003)(316002)(186003)(16526019)(4326008)(36756003)(86362001)(8936002)(6486002)(956004)(8676002)(6916009)(2616005)(66946007)(6512007)(6666004)(52116002)(478600001)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oRo446XFWS7janVAbhnsagBQrrOVnmxv01b3cihxnxkBVjG27Z8QUUNB/Cql9zxL0+lumsCspQIE2WJJIDpC60FHnulr2UXLikADwyLKQV6H3z9//LxNJZbgXqHqY28F3kntCRBmGSLaml+KTc5oIpGvF442kW7LWlxu9HKlh7poQ09eCSlkXl7ZovNQaYaYfhQTjjGvg6zNyJ6NY35kpmAJzTNXI2vJBoglUnt8MZbEq/gESHU++zAvD6C9DAhLO9zXZ7YRaTa7K54EmvDTNaod62rxvBG5iTklULR8H6D0MrYYs4iL2mWTdPaWF0gH0VZrf5n8IUvxk96J1elR8OCq6qsbCMz20ejmsu7rlbJqEcgGhcgMybq523CWoDtgdInw6gGhbLhBpugKKXCICN+cD6MkKOSp3TZFRnTUT6bCGaH368opcuhrVjNU/TeH2b+10ZbAodH8yBG8IReGLg0MfI9ju8LES2fxRgjJaQ/3gwcrAVQp0yXeI0S+kx7gFKH1enxSdSHaG9im80QbevBdiYNQTQE4BTg6Z32/lyEXZ/G3BDU+v4kG3lKEC062FF3Luiq0lRN4/hW3edMYM1glRM4IY0JcBXptG08lK5hmVT7VghVjkEaYcSFhtcwDHvVvtd/AavBAskGB6DO9XUoDfPnvwVtIYj0EI1TpdpqIoUUMjVkLOzc2mTwFSz+/22c8+sVu1bIvKEjxjqeqFKvGHUDTZYwWyAwAC4guF1GIO1LLDVPf8AQ1oypaQusO7jLx+vj+C3szAV1y0k7llTGFwcWVCUBMD/35MdbfvWQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d32af99-6b50-4151-83df-08d7ed0a5cde
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 13:28:26.1665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faRxp/+2H3ls42bRdygFf+Ev+esbTg/p1nRhkgnvzbg/VsRzUc4ShlT2vQyKeoyLLTfff5fwq10wHziUK1Rpqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3516
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:28:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implements FCVTLT, FCVTX, FCVTNT, FCVTXNT

Signed-off-by: Stephen Long <steplong@quicinc.com>
---

Fixed a compilation error and collapsed the translation functions with a
macro.

> Ignore my previous patchset. I missed the insn FCVTX and I ended up
> squashing those commits into this one. At the moment, I'm working on a
> patch for the SVE2 bitwise shift by imm insns.

 target/arm/helper-sve.h    | 16 +++++++++++
 target/arm/sve.decode      |  8 ++++++
 target/arm/sve_helper.c    | 59 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 18 ++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0a62eef94e..7c734334b2 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2731,3 +2731,19 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
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
+                   void, ptr, ptr, ptr, ptr, i32)
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
index a8e57ea5f4..dbfc0c337e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8253,3 +8253,21 @@ static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
     }
     return true;
 }
+
+#define DO_SVE2_FP_CONVERT(NAME, name) \
+static bool trans_##NAME(DisasContext *s, arg_rpr_esz *a)                      \
+{                                                                              \
+    if (!dc_isar_feature(aa64_sve2, s)) {                                      \
+        return false;                                                          \
+    }                                                                          \
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_##name);  \
+}
+
+DO_SVE2_FP_CONVERT(FCVTX_ds, fcvtx_ds)
+DO_SVE2_FP_CONVERT(FCVTXNT, fcvtxnt)
+
+DO_SVE2_FP_CONVERT(FCVTNT_sh, fcvtnt_sh)
+DO_SVE2_FP_CONVERT(FCVTNT_ds, fcvtnt_ds)
+
+DO_SVE2_FP_CONVERT(FCVTLT_hs, fcvtlt_hs)
+DO_SVE2_FP_CONVERT(FCVTLT_sd, fcvtlt_sd)
-- 
2.17.1


