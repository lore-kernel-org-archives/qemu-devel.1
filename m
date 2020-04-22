Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A1C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9BC2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WJqyqIZ+";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="imcmWhg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9BC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGB9-0002oD-EH
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRGAB-000213-Iu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRGAB-0006Zy-0a
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:15:43 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:62920)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jRGA7-0006UH-UD; Wed, 22 Apr 2020 10:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587564939; x=1619100939;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=x/bD3v9/g7N7ULFi9YlR+bQD5qLdylVk7Hd1N2CWjFg=;
 b=WJqyqIZ+/72Iq5MvQ+1hGz3jypMUq1BiB+MqgVmNWwEDr84S54/K1N9M
 LGszeT+ye0EL+7IodNMGCV2TQIDW36An72eJVJPePfw3WRvaepxW1BDES
 by2vUsMNO5A5lfqYJmlo0tHjoVtY4SccVX4buQjxktC0Jon6grynuQVXH E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Apr 2020 07:15:35 -0700
Received: from nasanexm01a.na.qualcomm.com ([10.85.0.81])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 22 Apr 2020 07:15:35 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Apr 2020 07:15:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 07:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bq82mahdxjVKHXkrIZoBUagHbhAAgtYxfuv3xXVovU9Qa5ACKdts3pJMk8D5AfKJINVzhScC7LW4yrGn8HqeiHrwgHr5FqtHQRDVOmm+h9m1JtAWnGvQdWgyokocT35nDr4xzK5BtE9D01sFNXncBbr++pVfOAvWgfbo2EwjjgPEVARuO/h5KSRvnON/g2Mif5aOOqjpWbd5KnZYSNzMDCXlPLBqyMEctxfcrglAqazT7kdYAKRfRMUfrthaGFpzYhsycYU63nSyfd2O5hjRjZv/tHItwE1Q6glLd96Blbi6dUl2P2CSFH3wpxiRwgZP26rbzu7lcZtwDtxH9uRzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyWAbxKhDFkXqaPj9PcOSGJ/bx9EbOnHsBnmQ8nLqvo=;
 b=csVQxmfKnGSfqhpd2vjWN3U9xx3ur3jR+vC9PHI2fLZfjKAJxQ2VoLcaUr91PpoM/KPjT6h2vWLAR/HbAPsGqF5CMYlQrkJpBh7LKxZ74H76+VKeCtBwYoBIWcdLZewhHKkoYfHNIELcn+LE0gMm24+8e0vyUAVYaReJOCfKhhvpPuX240LjyegUTiF4w8MtgJ2oZN0jBwj6IXwIvxtFdmCxnUREm5ehlNVwAwc2kLM/3BeGZTqS1jPhxyxa/e5YhVeV3In5BFgN9pOw7IV4O5OTdpLgwx88K2ZEOo5AZQinV8EvyU8fkfTQT/icwW8fU0/HMNogCGWaxdWI84NPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyWAbxKhDFkXqaPj9PcOSGJ/bx9EbOnHsBnmQ8nLqvo=;
 b=imcmWhg0WzvsMVfX73a5oZSwTOdjDd2mdMI2KCNdPEgcXqjHwP2jHpyM7dZzTAvIiiYvO/nNcRajTnrebR13RfGyEli44PBTxPZ2yQevFFyeHQf4zPS/6hGuYSP3G1Wm6kcHjwl/fqH7Kf0QKyMBW1oSKM4SSDhtzaVFtb/g9oM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3628.namprd02.prod.outlook.com
 (2603:10b6:301:78::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 14:15:31 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 14:15:31 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2] target/arm: Implement SVE2 FMMLA
Date: Wed, 22 Apr 2020 10:15:16 -0400
Message-ID: <20200422141516.7977-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:208:d4::27) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 MN2PR04CA0014.namprd04.prod.outlook.com (2603:10b6:208:d4::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 14:15:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6c39eba-744b-442b-e7fa-08d7e6c79d9c
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3628:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3628E0B10C8AACFCBD3921F5C7D20@MWHPR0201MB3628.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(136003)(39850400004)(346002)(396003)(376002)(66946007)(6916009)(1076003)(66556008)(5660300002)(6666004)(4326008)(16526019)(6486002)(81156014)(107886003)(6512007)(8676002)(52116002)(316002)(478600001)(66476007)(186003)(86362001)(36756003)(956004)(26005)(6506007)(8936002)(2616005)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PlEhlgq6qQcVSCJuRF+hr28qdGp1EVv2mR63xptYHZ3QeTasoK7omK8kbLtovfdSOuFTQnEcIY/iywYbmhePEGf6WlJBHQpM1UjpgMQnix6vgq0swoYiVY2kRFdJ3VwutVUQ+eoz40iW1nOJJXYq0M+QXUuPa2bSthk/gxXzW/hbuWIjrTV3RuMo8YLk7oXBHdSViy2I5oWMJnKdmC4GdPCZx0vNs9bA93dDQlok9dD9LuUsEtxW4TjPkzjpzkFUrcS6/5bdGXWrtS39XQ+HcoYrA39GSa+QHY5tVuETYcfB4jeXoCXg/hMEUrFoaT7KcXVdNoI+03UvkJSFOuj4jZw7UcFEcCTmdgQL7+r1qexrNvx0cbP68AJcfSGOmznP6hQdd4Rr6T2IE6FgEcwzKmYyX4p0vXfrNa7koQ06rEUAP/b34p7Ht9RiT7BMJhYv
X-MS-Exchange-AntiSpam-MessageData: yyi55tz0WlTTmR19zkpzq1Y52fZjIGvv/e94z2da8g0SQxmHYfem5ah9Ft5WLgsdmcYQ9FZXzkbcQ861+hmN0jyq6kCSDi+pyBzf/EGHJA+SrGj4wtyzRlUM6c/1N4QJ7w1OnU7UM6/VOx8s7IKk8g==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c39eba-744b-442b-e7fa-08d7e6c79d9c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 14:15:31.5299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuy3IKXjAbgeoeoBLCGgFeJno2uCRC2Xd7O8SfypMfOVc/DjA25ufnUTbIYlr9UvaEjXxVwaoy5KkYCiq0czww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3628
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 10:15:36
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

I'm guessing endianness doesn't matter because we are writing to the
corresponding 32-bit/64-bit in the destination register.
---
 target/arm/cpu.h           | 10 +++++++++
 target/arm/helper-sve.h    |  3 +++
 target/arm/sve.decode      |  4 ++++
 target/arm/sve_helper.c    | 44 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 29 +++++++++++++++++++++++++
 5 files changed, 90 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b7c7946771..d41c4a08c0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3870,6 +3870,16 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_f32mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F32MM) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_f64mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index ea53750141..8104d23c5f 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2683,3 +2683,6 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 95c73c665a..dd987da648 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1383,3 +1383,7 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
+
+### SVE2 floating point matrix multiply accumulate
+
+FMMLA           01100100 .. 1 ..... 111001 ..... .....  @rda_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b392a87aef..4646107f2e 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7389,3 +7389,47 @@ void HELPER(sve2_histseg)(void *vd, void *vn, void *vm, uint32_t desc)
         *(uint64_t *)(vd + i + 8) = out1;
     }
 }
+
+#define DO_FP_MATRIX_MUL(NAME, TYPE, MUL, ADD)                              \
+void HELPER(NAME)(void *vd, void *va, void *vn, void *vm,                   \
+                     void *status, uint32_t desc)                           \
+{                                                                           \
+    intptr_t s;                                                             \
+    intptr_t opr_sz = simd_oprsz(desc) / (sizeof(TYPE) >> 2);               \
+                                                                            \
+    for (s = 0; s < opr_sz; ++s) {                                          \
+        TYPE *n = vn + s * (sizeof(TYPE) >> 2);                             \
+        TYPE *m = vm + s * (sizeof(TYPE) >> 2);                             \
+        TYPE *a = va + s * (sizeof(TYPE) >> 2);                             \
+        TYPE *d = vd + s * (sizeof(TYPE) >> 2);                             \
+                                                                            \
+        TYPE n00 = n[0], n01 = n[1], n10 = n[2], n11 = n[3];                \
+        TYPE m00 = m[0], m01 = m[1], m10 = m[2], m11 = m[3];                \
+        TYPE p0, p1, results[4];                                            \
+                                                                            \
+        /* i = 0, j = 0 */                                                  \
+        p0 = MUL(n00, m00, status);                                         \
+        p1 = MUL(n01, m01, status);                                         \
+        results[0] = ADD(a[0], ADD(p0, p1, status), status);                \
+                                                                            \
+        /* i = 0, j = 1 */                                                  \
+        p0 = MUL(n00, m10, status);                                         \
+        p1 = MUL(n01, m11, status);                                         \
+        results[1] = ADD(a[1], ADD(p0, p1, status), status);                \
+                                                                            \
+        /* i = 1, j = 0 */                                                  \
+        p0 = MUL(n10, m00, status);                                         \
+        p1 = MUL(n11, m01, status);                                         \
+        results[2] = ADD(a[2], ADD(p0, p1, status), status);                \
+                                                                            \
+        /* i = 1, j = 1 */                                                  \
+        p0 = MUL(n10, m10, status);                                         \
+        p1 = MUL(n11, m11, status);                                         \
+        results[3] = ADD(a[3], ADD(p0, p1, status), status);                \
+                                                                            \
+        memcpy(d, results, sizeof(TYPE) * 4);                               \
+    }                                                                       \
+}
+
+DO_FP_MATRIX_MUL(fmmla_s, float32, float32_mul, float32_add)
+DO_FP_MATRIX_MUL(fmmla_d, float64, float64_mul, float64_add)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0cbb35c691..29532424c1 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7615,6 +7615,35 @@ static bool do_sve2_zzzz_fn(DisasContext *s, int rd, int rn, int rm, int ra,
     return true;
 }
 
+static bool trans_FMMLA(DisasContext *s, arg_rrrr_esz *a)
+{
+    if (a->esz < MO_32) {
+        return false;
+    }
+
+    if (a->esz == MO_32 && !dc_isar_feature(aa64_sve2_f32mm, s)) {
+        return false;
+    }
+
+    if (a->esz == MO_64 && !dc_isar_feature(aa64_sve2_f64mm, s)) {
+        return false;
+    }
+
+    static gen_helper_gvec_4_ptr * const fns[2] = {
+        gen_helper_fmmla_s, gen_helper_fmmla_d
+    };
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->ra),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           status, vsz, vsz, 0, fns[a->esz - 2]);
+    }
+    return true;
+}
+
 static bool do_sqdmlal_zzzw(DisasContext *s, arg_rrrr_esz *a,
                             bool sel1, bool sel2)
 {
-- 
2.17.1


