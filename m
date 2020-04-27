Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04504C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC48320656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O4VaJ7KJ";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Jwc1niWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC48320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5ol-0000qp-Ih
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jT5hP-0007hs-45
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jT5hO-0004hW-DX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:29:34 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38127)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jT5hL-0004Wf-DZ; Mon, 27 Apr 2020 11:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588001371; x=1619537371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=g8l6B1zIFDuTpgYf1S8P91HgRdw8FXTxLMiLq+hZN5k=;
 b=O4VaJ7KJSQPb+c5aoyig5p1ihHHK0v4ewCc2r7IA1HYxQBHkj5S1yRfk
 m7In+qQf1aV2E1mQ6cz7pPFHMOjt846XEbuIEeTI6goHlcYN4V7WOp6Pp
 Jk/kOAZs4u06Y5ChxV9JHn/bjsvvM18B9qrnZ5AK1dxHaIjuk0CKcp01i s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2020 08:29:27 -0700
Received: from nasanexm01a.na.qualcomm.com ([10.85.0.81])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 27 Apr 2020 08:29:23 -0700
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 08:29:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 08:29:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpgbyvW+zsNiZTFhGl6i1vZ7Wlfnf76GFS6hnJB/HoPat4sB5NX54lNsvVRpQ/gEcktB84eB9oFOpVVHEojuDvGQuxV2mlMOK85eVmdkx0JoHuztcGhbAK2I+pRDZIAp6UXHOcRbx3cJB9a16GC8xECTLnxjHi8qTPHVD8ClvlMUZJt/yr/t4F2lQo7S/aPOGcHhM6rX9STxrN9JGJ9rmHtplGi+8SC0tVIP6c6uBzLw3UDaYsU9I7zT+WQP7277yNZsNSCM3eTtmseuEQpqXJEK4h5MxiSjWxFsG7Yw7LxAcJdAAGcEjgqLRhSPpz+IJMFjxsr6ULtjCqFwl/2zFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+gURTTa5FWZndFRSTGgyOCn0ZSl1mfL0/jj8lXw9CU=;
 b=HnWJM9AHxacHDB2cgnly68xzmgVQ2Px6DQK7ZOfOOrz313jFVITHoCibSR95s67ki5NQG+Mca5KYuH7CPl+hWH1eJhFJwgyfTNMWLPPkRm73wSSDRC2D53+EyyO9wG3WPRAM7LkiPMsqz9oXfz2rGaR9j0/bjtj4IvmLfaDqztjyyNJteJnPYeNTu3LrX7UZ1GOhW0Z5mwkUppw8mAWbpmZqxKpd+xKrvwfdcr4Qcxje6CnHffYw/gCxwZk851ItEdU0cSfjQQmBkcPCqS9kc7EXXlTB7EYcpoZPpzNcaeZjzKwVPY5UYWnMxHYl403azXPIf5DqxH1XNgXMQTG83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+gURTTa5FWZndFRSTGgyOCn0ZSl1mfL0/jj8lXw9CU=;
 b=Jwc1niWifdbXjfG6AkTJCRAE5CAHgYZG7+k3HkO8g/JTHfG5DbkSZ/EEOf4x1X/AzV4QBD7JZvwzsyxouasyVkdgXIbmtpRQirMDrs4Co2g5I6TuO45Hf+ZmeMLtIcfrAWTDgUxBl8rrIr3eI+Hik4acaincvcy1wrzIRtue0SE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3465.namprd02.prod.outlook.com
 (2603:10b6:301:76::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 15:29:21 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 15:29:21 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v2 3/3] target/arm: Implement SVE2 SM4EKEY, RAX1
Date: Mon, 27 Apr 2020 08:29:04 -0700
Message-ID: <20200427152904.14768-4-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427152904.14768-1-steplong@quicinc.com>
References: <20200427152904.14768-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:208:fc::38) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (108.176.222.2) by
 MN2PR02CA0025.namprd02.prod.outlook.com (2603:10b6:208:fc::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 15:29:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bab7e3c-dc50-4e8b-f161-08d7eabfc1fe
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34653923C9689F00566764F5C7AF0@MWHPR0201MB3465.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(2906002)(6916009)(107886003)(6666004)(6506007)(66476007)(316002)(66946007)(26005)(8676002)(2616005)(52116002)(81156014)(4326008)(8936002)(6486002)(478600001)(956004)(5660300002)(186003)(1076003)(36756003)(16526019)(66556008)(86362001)(6512007)(32563001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THCYS9KIZRKpi20baAPDv2PEMtdYkOp/Y0XtDEgO6tcuQKM9w2yaxCogTJDQSJDaG/zMTWIJaw5oqknluKxaqe27iPIENeI7wHjWHhifIoKXRh2EWhE6XvhwrtkpPg4Y7YguLLTCX7PmJO8rUlRYTpbvLqdnWh8rmDzU2IXtgbVkJQbjpWmVK9aZVmxhZqLLrkjMyoLjpKfsX6LPWP8jWfnhAlcs1KCfOHNTPi+sDmSyuxd2o/ngTRpK9mYiR0yxZtcxuRVwpPDEP+aRBw4YW+37jZIBXWnLuhoHqkvigHYua6qlERX6kDdwxfWK3OI3YzPxGRop17U8b0W0qgCsAo0H/6n/84WZJyFGZ2iCUbg7CBnZe0pYg0ucssl6MeiB+fvp3APlL58RQ85FW74Q3rhiBM2ceEtMG7wJsVMI87nceEiG6KmMyQNtXvEKHmi3guOxmi/amJMjbbIJoVyWZcgMBF2g0/kubAvM5nl6eM8tn+BdFleTdhlVChxIccvA
X-MS-Exchange-AntiSpam-MessageData: +EiTdo8BhG6Fvdx59fi8M7GVWtVkfctTP/wYHsHA+rm1kIIr34qkQ0ih2OCyY/9PDxn4UuUPPOgyJ3SMxO19tzj73v6O/DC+4SKk5pV4rcESp5UWokch37ctqqh+WcMUyt+VBGd/eiUYRbsbRw9BSJZJVVDOJR/nLUa5wmZK/TCDpCfUHZ/10UTLLzyoBdPgn1s3i6XwdJU+lVVwHeKveQsMZbDuaSkQdUVZekVcx8DpRtv9QrLWnLrABLGzwXOlNHbunW+HKxnHRIuEdUNLkzOSEif96BrneGmfjwcFvpC3GNbvGBnuWa8AQXmS/VB6yfY5efRDShda7J0ENhp3AHjPLkMV1swT8v3Eq/9KPvFsLEcIyfI+u8Se2zdRgXrqIdKMzzsJHDHsob0YY7OB0a3qpScmGKx8MzHxFnEDB+0CPl6jD7iyOHYy1VbnT4arWixypo4B8PkWSWVIAZJzt/cUvwijP2cj4P4LJh+fOI4lFSVA39Yg0sZGhTI1qa5/NpyUvgIokhcS2fHyccp6xNhtVl1xTBmtzGGYHCN+Ra1JJ0bPp5eDWzeJdolohIndr1oBwk9I3XaA2xySQzAPFDcBTM1DY5/Ct0xipWlusjFzI4QDE5KXCK177KMHOvLIP8AYCDn2/PEwHMXrlb2D+tB5eDJaj8I07MRM299NVjfi2BigwCrwNT/XKenwl4fXUl32juahcc++0ighBDk8mV2QoxLT1mbZpQhT0Rn1k7YihyKLQswFjt7+2S1zif1jO6i5D2huP21R/s41ICMX4jAaMRP9brwOuUTUo4e8kBU=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bab7e3c-dc50-4e8b-f161-08d7eabfc1fe
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 15:29:21.2477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YYgYH+TTjD4qUFn22FHbsSKPJf5a/P8lfUd5aWTWLy85F1MC/NcCJdcGp6nepY9BaqWl3WBoHJf6u8w+bj0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3465
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 11:29:29
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
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
 target/arm/helper-sve.h    |  3 +++
 target/arm/sve.decode      |  4 ++++
 target/arm/sve_helper.c    | 20 ++++++++++++++++++++
 target/arm/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 6cd6fdfae1..e509137e4a 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2697,3 +2697,6 @@ DEF_HELPER_FLAGS_3(sve2_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_aese, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_rax1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 1cb5792bb1..278530ca83 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1435,3 +1435,7 @@ AESIMC          01000101 00 10000011100 1 00000 .....   @rdn_e0
 AESE            01000101 00 10001 0 11100 0 ..... .....  @pd5_pn5_e0
 AESD            01000101 00 10001 0 11100 1 ..... .....  @pd5_pn5_e0
 SM4E            01000101 00 10001 1 11100 0 ..... .....  @pd5_pn5_e0
+
+## SVE2 crypto constructive binary operations
+SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
+RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4204659276..8307abc401 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7542,3 +7542,23 @@ void HELPER(sve2_sm4e)(void *vd, void *vn, uint32_t desc)
         HELPER(crypto_sm4e)(vd + i, vn + i);
     }
 }
+
+void HELPER(sve2_sm4ekey)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    for (i = 0; i < opr_sz; i += 16) {
+        HELPER(crypto_sm4ekey)(vd + i, vn + i, vm + i);
+    }
+}
+
+void HELPER(sve2_rax1)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        uint64_t nn = n[i];
+        uint64_t mm = m[i];
+        d[i] = nn ^ rol64(mm, 1);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 6b26d8c512..2baa51b2b2 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7990,3 +7990,33 @@ static bool trans_SM4E(DisasContext *s, arg_rr_esz *a)
     }
     return true;
 }
+
+static bool trans_SM4EKEY(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_sm4, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, 0, gen_helper_sve2_sm4ekey);
+    }
+    return true;
+}
+
+static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_sm4, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, 0, gen_helper_sve2_rax1);
+    }
+    return true;
+}
-- 
2.17.1


