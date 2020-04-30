Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF30DC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758E02070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bp0wvXUs";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="cndo9WPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758E02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUEf0-00031I-Jp
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jUEdk-0001Pb-Eu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jUEdh-0005Wc-Qx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:14:30 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:6008)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jUEdh-0005WD-1h; Thu, 30 Apr 2020 15:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588274069; x=1619810069;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=NTrZL/sf/gnFsnLVZV0+PK11AIHEDUTk4seZyG3JnrE=;
 b=bp0wvXUspGMEVmyI13z+O4Vj+1Nc1WlV18LeStbxSKUxwMwAJZA/4BLp
 fEI/9PS3X+GJNzf2LeH8fCaVugaGzUR7k/dK12GORqJCC6MKT5tb2YclL
 H6qfGEJVUTo47Fx6Z3XivviG12FTT6+K5elZWWql/kB+ldCiXtgOncrmw g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Apr 2020 12:14:26 -0700
Received: from nasanexm03h.na.qualcomm.com ([10.85.0.50])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Apr 2020 12:14:26 -0700
Received: from APSANEXR01E.ap.qualcomm.com (10.85.0.38) by
 nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 12:14:26 -0700
Received: from NASANEXM01D.na.qualcomm.com (10.85.0.84) by
 APSANEXR01E.ap.qualcomm.com (10.85.0.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 12:14:22 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 30 Apr 2020 12:14:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsbvuU5bf8vSa/5cR6DiADgHq9vmFfBZziCrU+yygwBiNE9orNEP2MFh857Uch+y5SeMXDHKjc/Kkvzc9ak6Xi8j3R3Y7zzYW0g7jNcz9LodMx3cq9p5mkxizUSIbhdhBY0mT7rIUVlSvERyiP0ZFMFsBSvaBSPAXORcfkyB8sOOUSd8aJk8wuRE3SWLY+FLX44GJbNBDz7MR+TjsxlF4sK6F/fAqDwrIwaJXIBaPPj6AQ+FQxVuiT2ej6px2HSf+dHprI6oPOU43NyZLC3FaG9E5+4Svx+i4LAZCqrFj3QG+FXB938blqcvWoYDr92krKYx129PbjyZQv37xyZKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLYp9GaN/BBZNlk3OJ4l6ySJU2524/XgZRnyVxYPXVg=;
 b=gwGMBLeD574V1SGxQzDQ8dfFckLbv+NuIXUK+a/n63h/eaB8JVQ+w5ZyxKp3TC7I+ZgXjQ733WBubjDj0kbwanOUaPoUVSvbSoePX2j2lc2yu66nNOUeCebuTSYvhPNCjGrMDrGILAsFbJUqhhfFrxvVyKvtHFv/LjNqT+aCtQBXo49l0M2l+pY8dakzR5Ydt7E/dqnDKbXIgvV8Ls71+Vb6hsxW+wYCJ8IWrViUayHFIjf0zaeB14kZuORmFtT93nb3Xo7edPb6dLgGehv4bddm59hfL2k+dbTIWNlRRiWM9+GNWL+cY0CKE/AeX1rzzDELWx1nVEKEFJWLUxO0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLYp9GaN/BBZNlk3OJ4l6ySJU2524/XgZRnyVxYPXVg=;
 b=cndo9WPOCPQype7eGl3K0RvLs4JFQWdK45tVUyHFFBYCLUbZfbrpsyIs4iw4/B9YWb5cEzvbrelg2vaOuBbzOsUKzl1qt2CLMqeyerxzU9nbbaRDH8/6+ZuaC/eJyxrNkT4c1QN8s2rPQkoO2nHK+0HRTUI53kynCT12CxLekf8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3497.namprd02.prod.outlook.com
 (2603:10b6:301:7e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 19:14:18 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 19:14:18 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v2] target/arm: Implement SVE2 FLOGB
Date: Thu, 30 Apr 2020 12:14:05 -0700
Message-ID: <20200430191405.21641-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:91::23) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (108.176.222.2) by
 BL0PR05CA0013.namprd05.prod.outlook.com (2603:10b6:208:91::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.14 via Frontend Transport; Thu, 30 Apr 2020 19:14:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d92ae5f-273b-4aa2-a68d-08d7ed3aae58
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB349725FEE037F61A8844E4DFC7AA0@MWHPR0201MB3497.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3Hd6vkMu/yKdOUfcKS4yphDwzBgDDb4REmz2Oav/hu4EDfljl8acEuUBDMAvVhZN3a8Mue/w2o3DxrNUqLqhoHA6ovcr5YymP/x3qQ47uduOGp7b4cZmNrWbXT+7sD/TRvYFCNg/Jmdnlgr9oqSz5jk99CJ20cWuEBcguoSi1Kf6pa2E1igG0vkdLR+V0Sn+tqulTGEbh52/rZI2rtda3tP2i9uIK5nM1WkGmizr/4T7wAd7vDftkPFzC3MkEag5UROWByrstVwkY6mgshHwsXHTIZ8KgnbKVlWNx5Bh5kH1q2TKcgRJgQJLehqojXpJwXAw9Hm4SHLZlhmbBfZYbOCEUBJ4PyzJIlvg8WQ/b+HtwBDL6jvLGzw4f8uZVxLssb1UaKWgLe3wcpnAHiLXuJ7mggPQjil0gcDgboCwPExsOfMjQ9lBd6x7EEOhGVd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(366004)(396003)(376002)(39860400002)(346002)(316002)(6916009)(1076003)(478600001)(6666004)(66476007)(66946007)(8936002)(8676002)(66556008)(2906002)(107886003)(6506007)(5660300002)(26005)(6486002)(4326008)(956004)(2616005)(186003)(36756003)(52116002)(86362001)(6512007)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: of8wS3T0SDn4LsLToKnvXqKI1xucdbLTwcFLC6RE7CXqpVY7I5gn3kT7mxeXNXY5PgYWFakQR1xPiIaIpYqg0BoltMKSXs65lLikxqBOpI4X2RNfomF3BJtocENzHOlraLrrx+aIZ42bA8HkbJSDAm2Hx3c/idEkokuG00UOG4iA5wLIppr05JXq1mqbv8qBGhxovOEgMMN+gTqsBiQdSHIi/a26x75XC2UzpVidebi0Co6H3kvGJjoBG7qtKnXwTy05gD9uVfRzzQzvhOcI1O2hRsY4nb/59r3YxtJoTmMlvocADJ57JD1MbHZPka3zXX6QpfOm8AZV7nw2HksIMlsaOhCrP8Xfvm8+8weJbcYbOL5LF6Nra7cMcUsi9uOJVJbP6apNFlSHx0TD0k5qzRkHcOEJ3FUuHsUDv8WswGsqLp29yyPIcV/KYdMKw0cC4jYuYPPMfRtVXZ/Zt00XWbTT1QBIcbgLjqUvzuLiM2LA+MT6lUAnPAmDT6RUOUlbstAsvXKe013yskh/VPLQkvF1uYMKS93eapF54y50LAChxMAGEdz8IqO2p3D4jQJvGiMZ1LlD9tzkC6i40SjALAu/etM1pHjWSWZCmpsyPMOJgmECHlaSsi13QS4iUUc4EvyU8IlG5shYMi2cS5suF3nKi7Vjk7swb98qxhpJlTCHXOMqOZm84C6pOkCB04Jkb2Ml1xrpJZJ3PT8WlMGjTjyLapKCmxdyTQYIbbDlV4olLCOJmxvc+BtbdBOjstvVAKIpiMaRB1L96K6OsI2lSUufAktuZmpY96bCnvxgWv4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d92ae5f-273b-4aa2-a68d-08d7ed3aae58
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 19:14:18.6934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dC4vFTBUWahEi2olC5r6phjkBznQBIUtKO/cVQK++75bJqr27PAdDDHidwFdPvSPhjj55zbxjCdjpKg6+dtjlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3497
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 12:28:45
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

I made the changes Richard requested. I took out the status field for
the helper function.

 include/fpu/softfloat.h    |  5 +++
 target/arm/helper-sve.h    |  4 +++
 target/arm/sve.decode      |  4 +++
 target/arm/sve_helper.c    | 63 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  9 ++++++
 5 files changed, 85 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index ecb8ba0114..275d138145 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -260,6 +260,11 @@ static inline int float16_is_zero_or_denormal(float16 a)
     return (float16_val(a) & 0x7c00) == 0;
 }
 
+static inline bool float16_is_normal(float16 a)
+{
+    return (((float16_val(a) >> 10) + 1) & 0x1f) >= 2;
+}
+
 static inline float16 float16_abs(float16 a)
 {
     /* Note that abs does *not* handle NaN specially, nor does
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0a62eef94e..4a7b322f15 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2731,3 +2731,7 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(flogb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(flogb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(flogb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 3cf824bac5..dcb095bb5d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1568,3 +1568,7 @@ SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
+
+### SVE2 floating-point convert to integer
+
+FLOGB           01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index aa94df302a..33fea27cb7 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7622,3 +7622,66 @@ void HELPER(fmmla_d)(void *vd, void *va, void *vn, void *vm,
         d[3] = float64_add(a[3], float64_add(p0, p1, status), status);
     }
 }
+
+#define DO_ZPZW_UNOP(NAME, TYPE, TYPEW, H, OP)                      \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)      \
+{                                                                   \
+    intptr_t i = simd_oprsz(desc);                                  \
+    uint64_t *g = vg;                                               \
+    do {                                                            \
+        uint64_t pg = g[(i - 1) >> 6];                              \
+        do {                                                        \
+            i -= sizeof(TYPE);                                      \
+            if (likely((pg >> (i & 63)) & 1)) {                     \
+                TYPE nn = *(TYPE *)(vn + H(i));                     \
+                *(TYPEW *)(vd + H(i)) = OP(nn);                     \
+            }                                                       \
+        } while (i & 63);                                           \
+    } while (i != 0);                                               \
+}
+
+static int16_t do_float16_logb_as_int(float16 a)
+{
+    if (float16_is_normal(a)) {
+        return extract16(a, 10, 5) - 15;
+    } else if (float16_is_infinity(a)) {
+        return INT16_MAX;
+    } else if (float16_is_any_nan(a) || float16_is_zero(a)) {
+        return INT16_MIN;
+    }
+    // denormal
+    int shift = 6 - clz32(extract16(a, 0, 10)) - 16;
+    return -15 - shift + 1;
+}
+
+static int32_t do_float32_logb_as_int(float32 a)
+{
+    if (float32_is_normal(a)) {
+        return extract32(a, 23, 8) - 127;
+    } else if (float32_is_infinity(a)) {
+        return INT32_MAX;
+    } else if (float32_is_any_nan(a) || float32_is_zero(a)) {
+        return INT32_MIN;
+    }
+    // denormal
+    int shift = 9 - clz32(extract32(a, 0, 23));
+    return -127 - shift + 1;
+}
+
+static int64_t do_float64_logb_as_int(float64 a)
+{
+    if (float64_is_normal(a)) {
+        return extract64(a, 52, 11) - 1023;
+    } else if (float64_is_infinity(a)) {
+        return INT64_MAX;
+    } else if (float64_is_any_nan(a) || float64_is_zero(a)) {
+        return INT64_MIN;
+    }
+    // denormal
+    int shift = 12 - clz64(extract64(a, 0, 52));
+    return -1023 - shift + 1;
+}
+
+DO_ZPZW_UNOP(flogb_h, float16, int16_t, H1_2, do_float16_logb_as_int)
+DO_ZPZW_UNOP(flogb_s, float32, int32_t, H1_4, do_float32_logb_as_int)
+DO_ZPZW_UNOP(flogb_d, float64, int64_t,     , do_float64_logb_as_int)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a8e57ea5f4..68157b892b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8253,3 +8253,12 @@ static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
     }
     return true;
 }
+
+static bool trans_FLOGB(DisasContext *s, arg_rpr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[] = {
+        NULL,               gen_helper_flogb_h,
+        gen_helper_flogb_s, gen_helper_flogb_d
+    };
+    return do_sve2_zpz_ool(s, a, fns[a->esz - 1]);
+}
-- 
2.17.1


