Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A978C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629E720656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QZWSzltZ";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="ScRI8yAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629E720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5jd-0002IW-E0
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 11:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jT5hQ-0007jh-6X
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jT5hP-0004jJ-J7
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 11:29:35 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:49212)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jT5hK-0004Sx-Bd; Mon, 27 Apr 2020 11:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588001370; x=1619537370;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=F3VMx/q3+546b5b+V4Rcp26Ncrbd/UAUaG1D9yRnUpY=;
 b=QZWSzltZIOkdFH297lWBW88SfsG4c8ZLOvBIngH6YQ4L3xiVNhn95q/U
 F64btod6dJgarLjbfUm+bFFWJ9Isr2rbtixlPZ/9nvP4uar2il+5IBqlJ
 X69fy+AkASWWmBVU/9T5I9mRvqa9WXZo87Pr0mwO59mxn6T0pLvGaR8KM 0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2020 08:29:22 -0700
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 27 Apr 2020 08:29:22 -0700
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 08:29:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 08:29:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcEkkaksS+/iGM1muHNAvAtUdqV3CI00xLCZ3SZ7/eBBK1LLtp3yqkJB6fy7iX/kEnBCAvkYUYnVRx/nY3Kd2Itw2nJJt7ogdDrA0g77WxHeU72/14ThW485rywdcRgQ8NxeWstSvndX+hxpsBGQ4VQb7SLvTo2XBrPb4juDkUndCFYGRKj5PuubK0U/rmAr6y3nQRi5AKKl+5nW9H/uahQAKT7rAT52NrsG3w4mnQNVA75A/wEhy/Dp0PDHuzROZnrnrC9ByK2bt4ULyZoI+F8cPieEuAQ/cGMtlmQcp+bArfuto91lm5aO0WlzsyRERX6r7Rw1++AE7ERdjSXSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+HA7B7t/m+LQpWl91cYVNPPygkF0u8diLcFRD41xTE=;
 b=LiG9cjjUEXk+rU2gG3szvMU5JOfA8JxoGyoJDrzrBfG2a1jh2WyHLk9E2+WQEW3l1IKWSmdAETIWM14U+maEGq2M5CyW+uBIyC3qz4xavJ6yNCNI4U+92TK/cbFXvxiJ6ODolDQvJjUbCBKHIEI3aXb+4uYZdwNGUwtkG8xWbKet8M3k7bE9V/ZvAheX6hpyfLOXl1KMKUir0Ar0+JQBNMEIyq4xYZifoR1IWb/iZzkXAUJRWruEItHIRfQhBWD50Vxwh+6Q3U6d8Jnxe4R6FgSPN/4RdVXUuQJ7QjA8h2t5b0nlTzK+QlO3rBYTR29+xUUFNSONQbZEDcjoTlcNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+HA7B7t/m+LQpWl91cYVNPPygkF0u8diLcFRD41xTE=;
 b=ScRI8yAbOK+4sCEQuVqdzzHKKdn3LtlyNk06B6nwOGczYGUGLfck7UvSeEY6EA7cwPYjttX7lpXwWc4Vr3Gl9I77TuF0RrJaqoLE0Ctsivu13Sbrtp+4OGPSdZ1XoftXs3m/VDT8Ylkxt83uCkhXqv5107a2NqGPL7ReCJ0BGJo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3465.namprd02.prod.outlook.com
 (2603:10b6:301:76::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 15:29:20 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 15:29:20 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v2 2/3] target/arm: Implement SVE2 AESE, AESD, SM4E
Date: Mon, 27 Apr 2020 08:29:03 -0700
Message-ID: <20200427152904.14768-3-steplong@quicinc.com>
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
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 15:29:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b36838a-926e-4e69-c87e-08d7eabfc162
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3465B6DA2BDDD6844AB3B471C7AF0@MWHPR0201MB3465.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:32;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(346002)(376002)(396003)(366004)(136003)(2906002)(6916009)(107886003)(6666004)(6506007)(66476007)(316002)(66946007)(26005)(8676002)(2616005)(52116002)(81156014)(4326008)(8936002)(6486002)(478600001)(956004)(5660300002)(186003)(1076003)(36756003)(16526019)(66556008)(86362001)(6512007)(32563001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZpkhu60Jlg8GxfoUYfM0utL9DjcMtyKznfy8vnH17e2NoKZEkEMBUiJfGtvnTAKFdg0c9dGhe5Fla2dOOZmRAnO9BO4Q58bapSbOdjXHDCffowrZWeqc3Ge5TrA8GUu5bCe6576ehd4JR5/+SWz3Ox8O1g0woAZRQmPR98f7SbmmSIo8GfG8aq6QWuRTWVc3TyzR9axCH80upGzbiO8DSMXUsOrjqTSobjq627K3RYCcCBPCDbVRcfqJkXV30GAX23kAgsxGmdq71kFaO8osjLRv7aOJIcCufUy+W7m32T0AcJRfamEad6uO4GfFScOwLSuA5+Rjmb8ZqSqX1hjz6VDGlAB/2kiOWJp/pMyVhl1Jbrs2BJCB/TQIquEiXqm+l/gWXCs/+kywAOvMx+SatxJ81z0TPpcINYGFjRxo3FDddnrbZIMnmD1gaRM7NG4jwvjFV4sBDz5Xi/QsTGmmO4jJb466AUDXkead8R1atw=
X-MS-Exchange-AntiSpam-MessageData: SpNfGcQnitbSlge/TKTfYEnoTQz1kiB/G0c4JHQAoyUi5b0bpvUHZBz/TAE7pMCGK8RYGZzo/hc4OklLVrRXHPHx6bPL+NFvwnG0D5F8rzvEfWXP6X0ryegiEuVt+/gm9JsWjaVFYJs2q+SyX4nYNi6TXQl9Gdk3gNhVClIN6oahGDLpjjVfBqinXP6JzIjkivZfAskt8/ZNyjoDziPzIxlFXqJOJB+9mbmeCYS/3S2hyPFTsbMyA6cKSIPVuKCOJQ4nFzVDP2qxZxVPuRtgVh2zSwh1RgVmQ55PH1461kwISCEHviB72/mRDUwUm89IvaGJS47XU/LoZnZLDAORdqd2OfdPu9ZvSB3dgFSObYZIuol8SqDwYfpQjBFvv4UjXUX/JED3ulWk1LXGbNX3Tc9hSquKkFTbz9yFEtT6/+/llqOBTLxfZ9b44WmrCCjEU/6pg57ls5FAYdVSsN7n7txAzo7ajD4XkwOJcBxcFLRitO/GG/kmElv2vAwalfXXbxqQB/fbCz7fRg2PrROvO0GzV+M+LaGe2+NFuSdZoSmQSsdpd2G1DOKhIr0Ku2JV44kmITggiOdiHw+q15pmNK80viAlFL4RKjmQchvXJ+LtTtq5vCrG1nLof8z0+6g3EZ/GYOGe1zuKK4+ZxCun8OdFYOvR8bbHYgkmrxN1F2JowjQS6U+ErbSZaftDMtAf61yWYOp/3jseSS0m9w2BD3OVwM4ozIw37vYc5MjCMN9yDALvKFg6TXLuaDNMKuGPZZKR8uboifQKYMw5pbNSuz9hcFHoLJI7w5Z21S8hVQ8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b36838a-926e-4e69-c87e-08d7eabfc162
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 15:29:20.2293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hiKp/2TPunPqLQOq2jdh7BTdkkKCRhkOrT1ugsqEb4qedkpqiCMxZlZCyzmEalHEAMUm11TE2aaDDoyDmdpA1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3465
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 11:29:22
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

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
 target/arm/cpu.h           |  5 +++++
 target/arm/helper-sve.h    |  4 ++++
 target/arm/sve.decode      |  6 ++++++
 target/arm/sve_helper.c    | 11 +++++++++++
 target/arm/translate-sve.c | 16 ++++++++++++++++
 5 files changed, 42 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d41c4a08c0..8b1dc38b9c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3880,6 +3880,11 @@ static inline bool isar_feature_aa64_sve2_f64mm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_sm4(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SM4) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 340fe07801..6cd6fdfae1 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2693,3 +2693,7 @@ DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(sve2_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_aese, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index f58eb04d11..1cb5792bb1 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -98,6 +98,7 @@
 
 # Two operand with unused vector element size
 @pd_pn_e0       ........ ........ ....... rn:4 . rd:4           &rr_esz esz=0
+@pd5_pn5_e0     ........ ........ ...... rn:5 rd:5              &rr_esz esz=0
 
 # Two operand
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
@@ -1429,3 +1430,8 @@ STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
 ## SVE2 crypto unary operations
 AESMC           01000101 00 10000011100 0 00000 .....   @rdn_e0
 AESIMC          01000101 00 10000011100 1 00000 .....   @rdn_e0
+
+## SVE2 crpyto destructive binary operations
+AESE            01000101 00 10001 0 11100 0 ..... .....  @pd5_pn5_e0
+AESD            01000101 00 10001 0 11100 1 ..... .....  @pd5_pn5_e0
+SM4E            01000101 00 10001 1 11100 0 ..... .....  @pd5_pn5_e0
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 5c3dee048d..4204659276 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7530,4 +7530,15 @@ void HELPER(NAME)(void *vd, void *vn, uint32_t desc)            \
 DO_SVE2_AES_CRYPTO(sve2_aesmc, crypto_aesmc);
 DO_SVE2_AES_CRYPTO(sve2_aesimc, crypto_aesmc);
 
+DO_SVE2_AES_CRYPTO(sve2_aese, crypto_aese);
+DO_SVE2_AES_CRYPTO(sve2_aesd, crypto_aese);
+
 #undef DO_SVE2_AES_CRYPTO
+
+void HELPER(sve2_sm4e)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    for (i = 0; i < opr_sz; i += 16) {
+        HELPER(crypto_sm4e)(vd + i, vn + i);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f70b7f44e3..6b26d8c512 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7974,3 +7974,19 @@ static bool trans_##NAME(DisasContext *s, arg_rr_esz *a)                \
 
 DO_SVE2_AES_CRYPTO(AESMC, aesmc, 0)
 DO_SVE2_AES_CRYPTO(AESIMC, aesimc, 1)
+DO_SVE2_AES_CRYPTO(AESE, aese, 0)
+DO_SVE2_AES_CRYPTO(AESD, aesd, 1)
+
+static bool trans_SM4E(DisasContext *s, arg_rr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_sm4, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vsz, vsz, 0, gen_helper_sve2_sm4e);
+    }
+    return true;
+}
-- 
2.17.1


