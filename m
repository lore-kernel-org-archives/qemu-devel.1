Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ACDC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8BE2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="w6l7HfM/";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="XLiLX5eT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8BE2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVegX-0005lI-FP
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jVeeP-0003zU-OS; Mon, 04 May 2020 13:13:05 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:49721)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jVeeM-0001gz-Sm; Mon, 04 May 2020 13:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588612382; x=1620148382;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=RgAGH3haK9UPB88zqGDUU8Fx2h6e0OWVeCTs/04UnLk=;
 b=w6l7HfM/U4N37f+3ffl74VStGtveXA7iGRU0xKQYmWuT6pzh2Lc+hqjW
 z6933ZKWH4sbrA3Z/l/hhET8CGQckSSHPGPnSPjy3nBw34WqDk3aGz8ye
 eM3HC8mpXK//bTFSiOhyEF3J25sDJ7I19pojc6ku47UcIRzPK5eDNUdya Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 04 May 2020 10:13:00 -0700
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 04 May 2020 10:13:00 -0700
Received: from APSANEXR01A.ap.qualcomm.com (10.85.0.36) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 4 May 2020 10:12:59 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 APSANEXR01A.ap.qualcomm.com (10.85.0.36) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 4 May 2020 10:12:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 4 May 2020 10:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd0Jzt4NxCzSW7Hjzk3CHFlUQ+9kxIwQkS8qpHtv1QWdl0AXq10zLhlPgUSor0jv5eWsBXr5LEBkw6I5W8vFsJ1i29q18UGJPtNiGkEwDhXSrWmeC+oWYN2WAJWgz/au9SO0KVqCX7rFYIpZcfpXNQbPvgIxQVw2IAgDh+q0c6XQuTNIHUCg3S5405SRWvj5aEmrMj2k6VKi57RKn2LlH7oZV2QWfhVkiMzFryqUaA+nffRby4k4u8tbkNNXD4LAnL4GUvRXwKzGP2UdaxzkyZzP+sFoKhLs9jYDZ/xDFDAEEBKXAF3fmqdCTGY78rjwXaZOYIdrjAf+6rS80zQUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfui14MQ1pc9/PghXrBC+29CxM37rqIHLDCr9sOl+Qw=;
 b=YT1r2T5SXfofyui74/IiZYbmmRP7onKdSjaMnNALAixf/yNkQDSnY+/ICOwygEYG73NVJMA11d2rqQW35nt+iP1ft141GSsj664voyfmu/ZSGqhlLYE30GXglylRf9tBrQAkbf3z7+Fa4QSLDYmdwZPoM1eDqfU5+VUWTA6K2PcoLnQBrxftwqHvGPiRJo8FurmlAzM9MlWEPcc7/MDkDf9sjs2guZ1oCFkCqbYVev7SAUKDVUJKmhrGara/utA1nboICq1CefsIaKkR8+hA+NV8L7SFWom5h+gpqnyhJDdj152e9OwmEWU6dN3GtGwKGc1e9l9kgyCx6NGP3QqmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfui14MQ1pc9/PghXrBC+29CxM37rqIHLDCr9sOl+Qw=;
 b=XLiLX5eTVeiSh67SvjfNNUvWHTBvV9uqQeePmmrDfkNg9xldIbJHUqT9NvwYagATjw1G9WUtLyEe/tvt++9hrIa9XQv2d5D/7iMmhHeY/IcLQZFw3Gq85xpJFPdfIHUmBeQG9jLoyS5B4Rqw0Dx85PpbiBd3/VrrRbYwmZ9BGM8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3498.namprd02.prod.outlook.com
 (2603:10b6:301:76::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 17:12:55 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 17:12:55 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] target/arm: Implement SVE2 fp multiply-add long
Date: Mon,  4 May 2020 10:12:40 -0700
Message-ID: <20200504171240.11220-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (24.102.122.190) by
 BL0PR1501CA0024.namprd15.prod.outlook.com (2603:10b6:207:17::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Mon, 4 May 2020 17:12:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2380ef09-6494-4799-1b94-08d7f04e62bc
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3498:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34989E5D00049E27A00FD471C7A60@MWHPR0201MB3498.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:34;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eh1KfWZjhHcqPZr13++w4e95KiMFDsxzfV0UU509qtbJdKRZ0rtXfOo8uTk1QKMdm9XEEGahaA2DNO8a0DSBE0n/3Up7sNAx4a0qoQsxa3zs15h3aicjnrotMZ9ju1qWQMnQh2XUtO7VIhZZCgbH6DoFzV39Rs+Vvy5P80ywmsjP0nlGQExnq+QMkkqKx1TssvxB7Kb0uUUTolPwcz77SBmyDK6iJy9WoMfmJPd8KF/7kZB104Kc/sUjdkb/pO2fj48ArptWSldIRfjppYdp5nLTYgPMfUF0myl4VH/HX0hL0w7FosvU6ZKJW0N5rH/AhHcDyP/Gh8qrSP8UxT5efHcMtVIq4rLEs5aPhgsmoAZDfcNSNjfdJ+q9VUHRmkZMCxe88kNfUcU3PQXHrk9YSRzZsoQWkIfQaj9zYFo60NmYlQi+gXRC8WFKcx8gBcF2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(136003)(346002)(39860400002)(366004)(956004)(478600001)(1076003)(107886003)(86362001)(4326008)(2616005)(6916009)(5660300002)(6486002)(2906002)(6506007)(52116002)(186003)(6512007)(16526019)(66556008)(66946007)(66476007)(6666004)(8676002)(26005)(316002)(36756003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Ftxm6OuxXHlqx4VWZuC5ZOGC7lBl+vmCrdUrC9FxhdOo6Cun83SzLAjL8AbImNmKpbEqmBV9dgUWHLuT4HT45ZpP8rJaBsiJtSzk9qi4XXjT7G4p7EjzF/1PAIHrwIeqFaIGhLL3GVJdhIovOjGRPodCmcIPQZ+W1yF2zBxRI1v8+aaSZU/nKiJkG25m8d8Z6N+KH4Q1CCqu553Dg06RJp3ds9jONzdnD6l0NRDWDnnGkkFSyh/rvqzfggDD+WeHEP33wUrMXo0hoCx1Rcrdn+J/jY1MHr/WioVilsM7tbEN1HoKqbuKq+YAjbPxK+8fsbC44dVGVO4ZD2+fbA3Jjz3iSSc9DaRptksRYPWJLhbkC9wEPX2gq5fQnG8+OriY/qNmIn1WjGDlE6d1E6E1yETibEK1YTEiRMnlOnVAB8LzYlqyeUAQxhbLnv52BbwAk0PBxNzzrxdtnNlyEi330pmO68/PXqorCDxufj8ye5CI2ozg7wAtRZ4PkSgyYdMRx5meQWr/Qr23ouo4+mfnEqO+M6EmDeEi/Y0rSBMDce1ee/veCzwr0sS7/C829uN+be9KcpJRQnwHt4RnSneDiaoOMOFRl+cFntWy7krEq8JT8n0gftkrze2hzXGP+sGkzJsOXVq82BRe6vxls2BPzIeIKIVGW2kn1Toq70+gDPvw8iCtc3/S/DeTnvoA7LwMRrfltuirlELfpDuGvZwWEtvWZd2cpSeysSdvl/xaI2+Yoq8mOco2J31X/69Bw1AUMMZa1PQxFuqxGuStf6dBp1EldnqiLNUUBLYfh31bPHo=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2380ef09-6494-4799-1b94-08d7f04e62bc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 17:12:55.4013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6BnwVI2uNUVE9kbk2e8CoWoaQxQqTbMiLy93v21wadfUmFU+zpnyjNQcifQUi+Ii5jDNyF0PZHZmT3XZQBuFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3498
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 13:13:00
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
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implements both vectored and indexed FMLALB, FMLALT, FMLSLB, FMLSLT

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
 target/arm/helper-sve.h    | 10 +++++
 target/arm/sve.decode      | 12 ++++++
 target/arm/sve_helper.c    | 76 +++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 86 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 184 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0a62eef94e..2e5f1d810e 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2731,3 +2731,13 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve2_fmlal_zzzw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve2_fmlsl_zzzw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sve2_fmlal_zzxw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sve2_fmlsl_zzxw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 3cf824bac5..7602ba4e3f 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1568,3 +1568,15 @@ SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
+
+### SVE2 floating-point multiply-add long (vectors)
+FMLALB_zzzw     01100100 .. 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm
+FMLALT_zzzw     01100100 .. 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm
+FMLSLB_zzzw     01100100 .. 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm
+FMLSLT_zzzw     01100100 .. 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm
+
+### SVE2 floating-point multiply-add long (indexed)
+FMLALB_zzxw     01100100 .. 1 ..... 0100.0 ..... .....          @rrxw_s
+FMLALT_zzxw     01100100 .. 1 ..... 0100.1 ..... .....          @rrxw_s
+FMLSLB_zzxw     01100100 .. 1 ..... 0110.0 ..... .....          @rrxw_s
+FMLSLT_zzxw     01100100 .. 1 ..... 0110.1 ..... .....          @rrxw_s
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index aa94df302a..ae1321225a 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7622,3 +7622,79 @@ void HELPER(fmmla_d)(void *vd, void *va, void *vn, void *vm,
         d[3] = float64_add(a[3], float64_add(p0, p1, status), status);
     }
 }
+
+/* SVE2 Floating Point Multiply-Add (Vectors) Helpers */
+
+void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
+                               void *status, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    intptr_t sel1 = simd_data(desc) * sizeof(float16);
+    for (i = 0; i < opr_sz; i += sizeof(float32)) {
+        float16 nn_16 = *(float16 *)(vn + H1_2(i + sel1));
+        float16 mm_16 = *(float16 *)(vm + H1_2(i + sel1));
+
+        float32 nn = float16_to_float32(nn_16, true, status);
+        float32 mm = float16_to_float32(mm_16, true, status);
+        float32 aa = *(float32 *)(va + H1_4(i));
+        *(float32 *)(vd + H1_4(i)) = float32_muladd(nn, mm, aa, 0, status);
+    }
+}
+
+void HELPER(sve2_fmlsl_zzzw_s)(void *vd, void *vn, void *vm, void *va,
+                               void *status, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    intptr_t sel1 = simd_data(desc) * sizeof(float16);
+    for (i = 0; i < opr_sz; i += sizeof(float32)) {
+        float16 nn_16 = *(float16 *)(vn + H1_2(i + sel1));
+        float16 mm_16 = *(float16 *)(vm + H1_2(i + sel1));
+
+        float32 nn = float16_to_float32(nn_16, true, status);
+        float32 mm = float16_to_float32(mm_16, true, status);
+        float32 aa = *(float32 *)(va + H1_4(i));
+        nn = float32_set_sign(nn, float32_is_neg(nn) ^ 1);
+        *(float32 *)(vd + H1_4(i)) = float32_muladd(nn, mm, aa, 0, status);
+    }
+}
+
+/* SVE2 Floating Point Multiply-Add (Indexed) Helpers */
+
+void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
+                               void *status, uint32_t desc)
+{
+    intptr_t i, j, oprsz = simd_oprsz(desc);
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1) * sizeof(float16);
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 1, 3);
+    for (i = 0; i < oprsz; i += 16) {
+        float16 mm_16 = *(float16 *)(vm + i + idx);
+        float32 mm = float16_to_float32(mm_16, true, status);
+        for (j = 0; j < 16; j += sizeof(float32)) {
+            float16 nn_16 = *(float16 *)(vn + H1_2(i + j + sel));
+            float32 nn = float16_to_float32(nn_16, true, status);
+            float32 aa = *(float32 *)(va + H1_4(i + j));
+            *(float32 *)(vd + H1_4(i + j)) =
+                float32_muladd(nn, mm, aa, 0, status);
+        }
+    }
+}
+
+void HELPER(sve2_fmlsl_zzxw_s)(void *vd, void *vn, void *vm, void *va,
+                               void *status, uint32_t desc)
+{
+    intptr_t i, j, oprsz = simd_oprsz(desc);
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1) * sizeof(float16);
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 1, 3);
+    for (i = 0; i < oprsz; i += 16) {
+        float16 mm_16 = *(float16 *)(vm + i + idx);
+        float32 mm = float16_to_float32(mm_16, true, status);
+        for (j = 0; j < 16; j += sizeof(float32)) {
+            float16 nn_16 = *(float16 *)(vn + H1_2(i + j + sel));
+            float32 nn = float16_to_float32(nn_16, true, status);
+            float32 aa = *(float32 *)(va + H1_4(i + j));
+            nn = float32_set_sign(nn, float32_is_neg(nn) ^ 1);
+            *(float32 *)(vd + H1_4(i + j)) =
+                float32_muladd(nn, mm, aa, 0, status);
+        }
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a8e57ea5f4..3d7382a7de 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8253,3 +8253,89 @@ static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
     }
     return true;
 }
+
+static bool do_zzzz_fp(DisasContext *s, arg_rrrr_esz *a,
+                       gen_helper_gvec_4_ptr *fn, int data)
+{
+    if (fn == NULL) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vec_full_reg_offset(s, a->ra),
+                           status, vsz, vsz, data, fn);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
+static bool do_zzxz_fp(DisasContext *s, arg_rrxr_esz *a,
+                       gen_helper_gvec_4_ptr *fn, int data)
+{
+    if (fn == NULL) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vec_full_reg_offset(s, a->ra),
+                           status, vsz, vsz, data, fn);
+        tcg_temp_free_ptr(status);
+    }
+    return true;
+}
+
+static bool do_sve2_zzzz_fp(DisasContext *s, arg_rrrr_esz *a,
+                            gen_helper_gvec_4_ptr *fn, int data)
+{
+    if (!dc_isar_feature(aa64_sve2, s) || a->esz != 2) {
+        return false;
+    }
+    return do_zzzz_fp(s, a, fn, data);
+}
+
+static bool do_sve2_zzxz_fp(DisasContext *s, arg_rrxr_esz *a,
+                            gen_helper_gvec_4_ptr *fn, int data)
+{
+    if (!dc_isar_feature(aa64_sve2, s) || a->esz != 2) {
+        return false;
+    }
+    return do_zzxz_fp(s, a, fn, data);
+}
+
+#define DO_SVE2_FP_MULADD_VEC(NAME, FUNC, TOP)                            \
+static bool trans_##NAME(DisasContext *s, arg_rrrr_esz *a)                \
+{                                                                         \
+    return do_sve2_zzzz_fp(s, a, FUNC, TOP);                              \
+}
+
+#define DO_SVE2_FP_MULADD_IDX(NAME, FUNC, TOP)                            \
+static bool trans_##NAME(DisasContext *s, arg_rrxr_esz *a)                \
+{                                                                         \
+    return do_sve2_zzxz_fp(s, a, FUNC, (a->index << 1) | TOP);            \
+}
+
+/*
+ * SVE2 Floating Point Multiply-Add Vector Group
+ */
+
+DO_SVE2_FP_MULADD_VEC(FMLALB_zzzw, gen_helper_sve2_fmlal_zzzw_s, false)
+DO_SVE2_FP_MULADD_VEC(FMLALT_zzzw, gen_helper_sve2_fmlal_zzzw_s, true)
+DO_SVE2_FP_MULADD_VEC(FMLSLB_zzzw, gen_helper_sve2_fmlsl_zzzw_s, false)
+DO_SVE2_FP_MULADD_VEC(FMLSLT_zzzw, gen_helper_sve2_fmlsl_zzzw_s, true)
+
+/*
+ * SVE2 Floating Point Multiply-Add Indexed Group
+ */
+
+DO_SVE2_FP_MULADD_IDX(FMLALB_zzxw, gen_helper_sve2_fmlal_zzxw_s, false)
+DO_SVE2_FP_MULADD_IDX(FMLALT_zzxw, gen_helper_sve2_fmlal_zzxw_s, true)
+DO_SVE2_FP_MULADD_IDX(FMLSLB_zzxw, gen_helper_sve2_fmlsl_zzxw_s, false)
+DO_SVE2_FP_MULADD_IDX(FMLSLT_zzxw, gen_helper_sve2_fmlsl_zzxw_s, true)
-- 
2.17.1


