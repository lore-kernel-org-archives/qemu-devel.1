Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D373C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C48C20CC7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 22:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="izIgI+1k";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="s6bbmWCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C48C20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRkVF-00060m-5H
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 18:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRkTs-00040S-1U
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRkTr-0007ba-1E
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 18:38:03 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:5794)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jRkTp-0007T5-Tk; Thu, 23 Apr 2020 18:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587681481; x=1619217481;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=tgkpRRbB+S3xPDt93GrydFC6o0rRMYx60jdwqQqL77o=;
 b=izIgI+1kfvwpVsliFQ+SJlDAlDUiqFH93k8RMtiFQRK1+gGqQNb61OR5
 RxF4E9ue6YG5+/B5qDQv5OcgFL9eUTCKDADvYvVpBNFFkPL+zvemyk1oj
 C7Kr6EcwVDF4T28bYE5b4oeVZdn3KwQkVYP1WqPpVzTP6LQ/si6sDk/SI c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Apr 2020 15:37:59 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 23 Apr 2020 15:37:59 -0700
Received: from apsanexr02b.ap.qualcomm.com (10.85.0.27) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Apr 2020 15:37:59 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 apsanexr02b.ap.qualcomm.com (10.85.0.27) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Apr 2020 15:37:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 23 Apr 2020 15:37:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khnStY96ymYe3ArjfPqhNu7k3cxZhTKj2liIp8wWIwQJZu9N3IGPuQQEW+4DPqO+9SXy+ddNOStN3NhX7aKb0EoCL4WHfX6oj8ZxXOL19/DV5m3UTbqeFRHV6KVNZOL9vUUqTf/veMmAUWCT0kETjuXjy7ptbVQL/vAzYbA7xMA2pXtjJITYYb/yDDXdwm7fzOjkZfO8JeXNShx2SPMYK/NGq5H7xNcvIMlfeTBgO60voKj1yTISM1qAidkU6rOySx6bas9kFjnopAps7zXfvpOFd0/51u2voBPb6a885RGuAKvgSwDCuyQq93+2HDbSSE0EhuM28kEANukkq3BpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppBdfUYDPyhVn56AkZerf9EclI3XJoAuRm/GMv2yAXA=;
 b=Eu8+cZu2Tqe/k/g3TRNmWSXPYS12A55v9qJIqmNmFdSfGZN+QFt38sYGKM6Wt8jlwXiPG2SsYLyU3qr4W1OlozXx/ofwaIt7erELD89Dc/jM4LjJrlpe4iDv9HQqy8SFX1xhs0GXxPC1Q89U+iBkiuorL4uLAYQhf79OMbZCBJgT0v5ZnzY23Syb+ucvorEn6m/HuwJDAFJu4CfX5wk6/sIKr7k5ANijimHVg9Czhwe0gLcVTlDi23xk/I01TxRpEv0eeHsliuBD7BS1KNcmpYlOOxznNDMTGrgrwuK051HjrvwIboEJOmWVX+pUInOm96eyjnWu2SkjlEiNHtaRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppBdfUYDPyhVn56AkZerf9EclI3XJoAuRm/GMv2yAXA=;
 b=s6bbmWCHbr60aYHFa7CDGjrcHxr6c4XrHzrPQLE6zNaxiG0mcA7h1s2EfJAY6UjzpVc/yuFXEmbEyHmPMIB/s2MRjvtjoAv8/pWBEyAungW24HmAPzOqcwRNJApby5C1errRhiO4bvyIk5o2kjK/fBJ6h8q1WykVYVf6YmdVI+s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3532.namprd02.prod.outlook.com
 (2603:10b6:301:77::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 22:37:55 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2921.033; Thu, 23 Apr 2020
 22:37:55 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC 1/3] target/arm: Implement SVE2 AESMC, AESIMC
Date: Thu, 23 Apr 2020 18:37:37 -0400
Message-ID: <20200423223739.31715-2-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200423223739.31715-1-steplong@quicinc.com>
References: <20200423223739.31715-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:610:53::35) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:610:53::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 22:37:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5211e638-40fe-4a64-b28f-08d7e7d6f6e3
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3532:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB353200DC3943D9893C20D04EC7D30@MWHPR0201MB3532.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(6512007)(6666004)(8676002)(2616005)(478600001)(956004)(4326008)(6486002)(66556008)(107886003)(66946007)(86362001)(16526019)(186003)(66476007)(6916009)(8936002)(2906002)(26005)(52116002)(316002)(81156014)(6506007)(36756003)(5660300002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJHHE53m7ZIIQeIOBMHLvD0cPTXOhmA1rKuHCGdcowEmZaCs9WAjTNuoCDZoOTs1JoETF2a2eafZ2A6Il2UBvCUi6SaUe+Hu0jxUlS7xm9xpN0apsi+zBs9xzg9D0p3SB48HL5Xp9fhOtkw7OwUbTXfqcCNhn4aiX4ayT+VkU8VJh3qR0uGLFjdgwU4r99iFPOuotv11To/NuTzIvBSra9MkLjm4mWYmWuAkFEDNTRrhRQ5/scs7BmN/L/fw9O9RQjTDGcJMyUg9YPsJOAX2SL534DGGvQQnPv5LRPWZiYWNDSILknaa3ErLr4TODNuiY1M0iONA0k1YVCxXGVe/4S+eChhqq1QehN+HKvOxO13S8usYhkIVlA9BUg4xQzAT1rznbIRf+zv7WNFRvVr5BcKMl5SUHDNBO/QnRFaHDk//3rdWyouQdwgbOTbTdM8/
X-MS-Exchange-AntiSpam-MessageData: HdU9exC4ikmHWON1o960Wnqwe3XtrgVXpy6IQnLKUto77fQX338QysN+sunG9xbOoZJXFoD/JIZDtTTNXQB1QpXhK0pUoy13JrgXzsYizmfY/0cKd3E3ktfh1HEVJQpJrhAGMNhNkGFAK4VfgIF7bw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5211e638-40fe-4a64-b28f-08d7e7d6f6e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 22:37:54.9528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzA65EufnfQ5uWzKre8clbHlih8wGyhN1v1svZ5n6T5yHA36LGraP/jG2dgwpgcR/lnBLkm/l2B4yuUs9Y9LJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3532
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 18:38:00
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
 target/arm/sve.decode      | 10 ++++++++++
 target/arm/sve_helper.c    | 13 +++++++++++++
 target/arm/translate-sve.c | 18 ++++++++++++++++++
 4 files changed, 44 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index f6ae814021..6e8421991c 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2687,3 +2687,6 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 3a2a4a7f1c..a83420e690 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -92,6 +92,10 @@
 # Named instruction formats.  These are generally used to
 # reduce the amount of duplication between instruction patterns.
 
+# One operand with unused vector element size
+@rdn_e0         ........ .. ........... . ..... rd:5 \
+                &rr_esz rn=%reg_movprfx esz=0
+
 # Two operand with unused vector element size
 @pd_pn_e0       ........ ........ ....... rn:4 . rd:4           &rr_esz esz=0
 
@@ -1387,3 +1391,9 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
+
+#### SVE2 Crypto Extensions
+
+## SVE2 crypto unary operations
+AESMC           01000101 00 10000011100 0 00000 .....   @rdn_e0
+AESIMC          01000101 00 10000011100 1 00000 .....   @rdn_e0
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 55e2c32f03..f25bb5338d 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7428,3 +7428,16 @@ void HELPER(sve2_xar_s)(void *vd, void *vn, void *vm, uint32_t desc)
         d[i] = ror32(n[i] ^ m[i], shr);
     }
 }
+
+#define DO_CRYPTO_AESMC(NAME, DECRYPT)                          \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)            \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    void *d = vd, *n = vn;                                      \
+    for (i = 0; i < opr_sz; i += 16) {                          \
+        HELPER(crypto_aesmc)(vd + i, vn + i, DECRYPT);          \
+    }
+}
+
+DO_CRYPTO_AESMC(sve2_aesmc, 0);
+DO_CRYPTO_AESMC(sve2_aesimc, 1);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 20eb588cb3..03463308ca 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7882,3 +7882,21 @@ static bool trans_SQRDCMLAH_zzzz(DisasContext *s, arg_CMLA_zzzz *a)
     };
     return do_sve2_zzzz_fn(s, a->rd, a->rn, a->rm, a->ra, fns[a->esz], a->rot);
 }
+
+#define DO_SVE2_AES_CRYPTO(NAME, name)                                  \
+static bool trans_##NAME(DisasContext *s, arg_rr_esz *a)                \
+{                                                                       \
+    if (!dc_isar_feature(aa64_sve2_aes, s)) {                           \
+        return false;                                                   \
+    }                                                                   \
+    if (sve_access_check(s)) {                                          \
+        unsigned vsz = vec_full_reg_size(s);                            \
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->rd),               \
+                           vec_full_reg_offset(s, a->rn),               \
+                           vsz, vsz, 0, gen_helper_sve2_##name);        \
+    }                                                                   \
+    return true;                                                        \
+}
+
+DO_SVE2_AES_CRYPTO(AESMC, aesmc)
+DO_SVE2_AES_CRYPTO(AESIMC, aesimc)
-- 
2.17.1


