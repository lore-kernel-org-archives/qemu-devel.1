Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A8BC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D556A20736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JmRDpeqr";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="BcOIKusd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D556A20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRgGm-0008MG-VK
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 14:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRgDJ-0005m5-60
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jRgDE-0000P4-DI
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:04:38 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:40843)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jRgDD-0000GN-Ax; Thu, 23 Apr 2020 14:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587665075; x=1619201075;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=l9a7hRhV0jSysdHhD7R26SdQ8IW+I22uVC7B3DGTu5g=;
 b=JmRDpeqrORMFXxkCvcSLCxDhBuwDCUnMkJDkN7snRVVpxP2LGDau9Vel
 4rR8oHaDJFZBaidsGgav7H5JXbVI3eoqom4WMNf6K0lGAwQGCPSb2x3Hf
 ksvMNjO4ECWKBx3mOsZGDKev4MJD2vhjpxWV33vZkdgDgLy0W8/h/o2zV 8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Apr 2020 11:04:06 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 23 Apr 2020 11:04:06 -0700
Received: from eusanexr01b.eu.qualcomm.com (10.85.0.99) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Apr 2020 11:04:05 -0700
Received: from NASANEXM01B.na.qualcomm.com (10.85.0.82) by
 eusanexr01b.eu.qualcomm.com (10.85.0.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Apr 2020 11:04:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 23 Apr 2020 11:04:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwW67F7v0s4yjRmRaoyMQXe7YBTBrTXB9x2sCTcfADXbx9RE28im6YcYinfD+oTiX6gN+pssJEplttdjjgb8sdYvCR+WiFwmCsQLKPqBX+1OMrGtbf+A8aqRu36xrxsvhJ2zT32gDKNhTSPnPNUDRDQ42Wgf1jR1bwo4B/az/p+5+IN7s8eMgfDwqXMRLzInRc//tFf+63xnIpLsNHu8kdlIINsnF/Eg44h10j18AD4lZUM31z0WpvJdKavq20gVvkTMmMggM4PR3LRwAGOEH/CS/fWoomU1NKRH5p6vG3Wj2ZYRhPwlxK2/3+1VzbXUC3DI6e/riqN7iCoOVE2BTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHezCcl9gYFcEJwiGCY0pJsso6+8NjJlcSeTFkIK6Jw=;
 b=b8fV9kBSfIw7p6UewWWDn+GAiG07PZyGWxjCCMKznL6k8XTdgEWYWXXjIDA4huUzn0KgJ0NW8Gfgn/GRuG8JBECT1O8h+IUkIWShRoksxx6hwCkGGut3U58VM1wILFE5Pur+c9Ja1/FXQjij7Et1kZM+9hI5EDApGLlqdkqzF2exaej8eEydUXnngoRfeg3D/FLpO77OlWQA2GDiokbAhPYE7+vIH5gkga9BO1zHocWUkhvEInN4GJ8pYao/bx8boNMIax3pEV3PzdRsw7xefFkv58tRAipbx8yLNX+G5/Seq29MVEfbhtYb/G33rFIRWIkX9u8B7QelNgIm0I+gTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHezCcl9gYFcEJwiGCY0pJsso6+8NjJlcSeTFkIK6Jw=;
 b=BcOIKusdpRlY2ko/tiGESr6J9IwCwogP3ShsIChw+ca5I4bmDJeQfJjAG8zGLAL6PnaZOvjB7fDa6MQo6pn5UcJWQps2Jn/SsmbByMy6oG7puB5fcmg16eSWZELNDB7ZCX2WK0Y/ySJsJyhTQWK8vsaWPGy8CZc9KZQjzHSprJc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3595.namprd02.prod.outlook.com
 (2603:10b6:301:7a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 18:04:00 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2921.033; Thu, 23 Apr 2020
 18:04:00 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC] target/arm: Implement SVE2 SPLICE, EXT
Date: Thu, 23 Apr 2020 14:03:47 -0400
Message-ID: <20200423180347.9403-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:610:4e::35) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR02CA0025.namprd02.prod.outlook.com (2603:10b6:610:4e::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 18:04:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75cfcc3e-4429-4a85-be68-08d7e7b0b35e
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35959A47FB94EA61CF46302EC7D30@MWHPR0201MB3595.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(39860400002)(136003)(396003)(366004)(26005)(2616005)(36756003)(478600001)(316002)(86362001)(6512007)(186003)(5660300002)(107886003)(2906002)(66476007)(66556008)(66946007)(956004)(52116002)(6486002)(16526019)(6916009)(8936002)(6666004)(4326008)(6506007)(81156014)(1076003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZvlDiyxve78HFYLMOf8JhZ6iwGL12BLaLYTU3ULVSxP3lL0REnVBNNn0p0AbqUnBNRTLi79Sb6fpUcTxHDTPz3C8SMIsYiVC3lJGWz+ZPbj3dt6MdLI+nlKDxtF4lt4C9S/IWMh+mP6LRawiTu0BgxUHPCyOeXT2t9UZPrX1yfD21qpScig7NP6dqBzOj1mmGOXHVAXOtp67gF1pXTipSm0Iqa9ysxDVr/vx1vzHmhv2H+2Cw0zo3vtl8IEiS2U62V+Sa9sxSGuCfMmIcRAG4a5I7IqqZ1FlcoxRngLzRLpNodO2/CZf5eBPBwYwLTE0E4cg4QA9e2A6SlgyyQ3ydPt7PWqmhemFfjSzRDvXty+4fabdsLZEsOG2a02tpJWN9AXxonnw/VBmNUAhQnNFoT1nZwZBnb21CxmFkpT2HmeLD4EsNqSRHNYDkgZvkqZ
X-MS-Exchange-AntiSpam-MessageData: BmePokgd8oN/niZZ3ucNazxEbOCRf3AUQBHcVsF8BOlMqQyrobLiYT7WTT+e1T5NradaBaJTJ5Ispj2G7uqzocfDn7mWsMzeZtNqkDGPRCd8JJIXpyqnPcWaGby/PzxPtJIRl4iSdH8eGPKk4SMJhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cfcc3e-4429-4a85-be68-08d7e7b0b35e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 18:04:00.8084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15h40LzcEMuEhlIYKbfpJzmyQp6qrAPrGlDk+98sJTuTUBRVMpV3tHxlpyBzbbUTYCBU0H0rOmePkSIlIoSbLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3595
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 14:04:32
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

I'm not sure I can just use the SVE helper functions for the SVE2
variants of EXT and SPLICE.
---
 target/arm/sve.decode      |  8 ++++++++
 target/arm/translate-sve.c | 39 +++++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 3a2a4a7f1c..004cbb4191 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1387,3 +1387,11 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
+
+### SVE2 vector splice (predicated, constructive)
+
+SPLICE_zpz      00000101 .. 101 101 100 ... ..... .....     @rd_pg_rn
+
+### SVE2 extract vector (immediate offset)
+EXT_zzi         00000101 011 ..... 000 ... rn:5 rd:5 \
+                    &rri imm=%imm8_16_10
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 20eb588cb3..8c34785449 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2269,18 +2269,18 @@ static bool trans_CPY_z_i(DisasContext *s, arg_CPY_z_i *a)
  *** SVE Permute Extract Group
  */
 
-static bool trans_EXT(DisasContext *s, arg_EXT *a)
+static bool do_EXT(DisasContext *s, int rd, int rn, int rm, int imm)
 {
     if (!sve_access_check(s)) {
         return true;
     }
 
     unsigned vsz = vec_full_reg_size(s);
-    unsigned n_ofs = a->imm >= vsz ? 0 : a->imm;
+    unsigned n_ofs = imm >= vsz ? 0 : imm;
     unsigned n_siz = vsz - n_ofs;
-    unsigned d = vec_full_reg_offset(s, a->rd);
-    unsigned n = vec_full_reg_offset(s, a->rn);
-    unsigned m = vec_full_reg_offset(s, a->rm);
+    unsigned d = vec_full_reg_offset(s, rd);
+    unsigned n = vec_full_reg_offset(s, rn);
+    unsigned m = vec_full_reg_offset(s, rm);
 
     /* Use host vector move insns if we have appropriate sizes
      * and no unfortunate overlap.
@@ -2299,6 +2299,11 @@ static bool trans_EXT(DisasContext *s, arg_EXT *a)
     return true;
 }
 
+static bool trans_EXT(DisasContext *s, arg_EXT *a)
+{
+    return do_EXT(s, a->rd, a->rn, a->rm, a->imm);
+}
+
 /*
  *** SVE Permute - Unpredicated Group
  */
@@ -7882,3 +7887,27 @@ static bool trans_SQRDCMLAH_zzzz(DisasContext *s, arg_CMLA_zzzz *a)
     };
     return do_sve2_zzzz_fn(s, a->rd, a->rn, a->rm, a->ra, fns[a->esz], a->rot);
 }
+
+static bool trans_SPLICE_zpz(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, (a->rn + 1) % 32),
+                           pred_full_reg_offset(s, a->pg),
+                           vsz, vsz, a->esz, gen_helper_sve_splice);
+    }
+    return true;
+}
+
+static bool trans_EXT_zzi(DisasContext *s, arg_rri *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_EXT(s, a->rd, a->rn, (a->rn + 1) % 32, a->imm);
+}
-- 
2.17.1


