Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33BFC4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 21:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD3B2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 21:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cnIBnEru";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="WYrc+TnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD3B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTBWo-0001fC-DF
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 17:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTBV6-0006tX-Nk
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 17:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTBV4-0003Zl-SG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 17:41:16 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:18991)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jTBV2-0003YO-Sf; Mon, 27 Apr 2020 17:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588023672; x=1619559672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=aoQf92eHwqYMv8cxGNlQBVaqX3vePWiIEIionsrUU3I=;
 b=cnIBnEruXw0ITRfITyDAU9U+FUiAx7KGzzpvzNlnAFZXSJPsN9tJQbJc
 prjPpheAbhRHoAGeDyg5shChqvpis270EC1nqewoGIVXbKVI2KIOZtMr+
 We1mylwtd5ytanNjxPVkUiC/K8ghUe3hpyiwA1YCT/ccS8JDH5L6P9p0y c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2020 14:41:10 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 27 Apr 2020 14:41:10 -0700
Received: from APSANEXR01F.ap.qualcomm.com (10.85.0.39) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 14:41:10 -0700
Received: from NASANEXM01H.na.qualcomm.com (10.85.0.34) by
 APSANEXR01F.ap.qualcomm.com (10.85.0.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 14:41:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 14:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laqgWYJl3eCB+2+hHLhOrnfabsI87wKNEKNOPeOVGhQclAh4kiDADkJl1F43GK9PErEtwmPT01Lyh2oZgumEHTuPG8D10VqHSsAzjWrdydmqUvE1Ch8jF928KHeNWkC49ebHENO9E1nICleam0R25OFN1XUU0QfktK5FGfta6Co1yy5vUmi2iOdyVmVe+4CfycLshSd0Eg+51e5y8HNepWD7rMH3wYYLvw3D5jNDnRwYMqBFgftKuhZMXtSGNz+D2CjnWrFicA4Mm/Kmc9MPmQtfU8jFwPEbOPE4DsIeg0jIKCnkLAEjhBkDrXsVpJzVSZCC5yVK1dlWVbq/FECh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCfjUJiBIpgM03wVzwpqm4VIMtdKavH/mALDd28rSfU=;
 b=PrPXf+n2q5QYgzShHnFIYid0R0KaoS3vAPece3/Eg2y/ZFto/CSPGwtlFY4PafjRygdgON1/Uz9DUzYFN+to8d6oc7G5mXjhWnpTJpRItJkLbgc4z9P/LquDaIRewfh+d4Q3GGxCDWtinuzaXWjaXi10clxmmpWTF4rq2Af1VUtQ5sF20tJhDfUF8ZL+Cu+dpognM+LOAGWBV/ecrCPS6+xQiLByvdbMR/X+SWS1xdd0sLH4QWMEkGkXQHpXmEu7vKU812RPCNnLP1/Q3mCaML9w1VSNqQQbLeGydPpAjG7o4UJLc7988dYz03F/DsJZSuJqfgTQNXZiMTI3ejPPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCfjUJiBIpgM03wVzwpqm4VIMtdKavH/mALDd28rSfU=;
 b=WYrc+TnTZcUZvMGVzp7/iswKgiMUNu3FWFoS0oQtdUf8e4992btFzOv4ajyLb1/5n2Gbln1eUuWMGrv3FWX33RiULMdNFx+U5tJckFeqHyuij+GABr/m9QfbqDDZkrAy88OyllSrYJiWFK8re+2H9MwBfFEGIdmCx93+8manx9s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3577.namprd02.prod.outlook.com
 (2603:10b6:301:76::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 21:41:06 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 21:41:06 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v3 3/3] target/arm: Implement SVE2 SM4EKEY, RAX1
Date: Mon, 27 Apr 2020 14:40:46 -0700
Message-ID: <20200427214046.31401-4-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427214046.31401-1-steplong@quicinc.com>
References: <20200427214046.31401-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0014.namprd12.prod.outlook.com
 (2603:10b6:208:a8::27) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (108.176.222.2) by
 MN2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:208:a8::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 21:41:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 741754b0-e3d6-4865-2000-08d7eaf3b0b8
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3577E3D8DD7A40C8017C3C2BC7AF0@MWHPR0201MB3577.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(376002)(366004)(346002)(396003)(136003)(6666004)(2616005)(478600001)(36756003)(6512007)(107886003)(66556008)(2906002)(66946007)(6486002)(66476007)(4326008)(316002)(1076003)(86362001)(6506007)(8936002)(81156014)(26005)(8676002)(16526019)(956004)(186003)(52116002)(5660300002)(6916009)(32563001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjRIhQxQMt8GCj1fNKR9TXa5Iu0mNhcHo8QjzeObsMb8m+pZIxa46Nlmc4us7DvDF9oQL4A13nZIOg1eSSy+J4excPO7h082TGzuiCc0hwV+aNbGXKaJGjF9Ql7WFkzpLAo2Bw/A0C84GaJewbFL41sQD952YP+O6Jmg46aMcWrMziGVAxtrsvwxt14U+NEHL2cruh+zjoo1Kgxo1xi/wuXeDMDM9cF7DaJrfQEzGSyfCehvRtuH7M1avoNoBY5OralCTyd8eJTfuSNhiFmYm+7ttofl0dN9ehEukZHORcUZ1QN2Ead9/sluWIlZRUb8nigCh2LuMzlXrUmo3LEFdl+50RbDns0tgKKsOXsqoUwj15V676BuHbQo1D+QTMZiVhU+cFVBkR82jbojXRIn33Zr7fV/1gD5DfIizlBohReYNFOC8LWo6xY8fiNzhNX+nf658yxbXI+DsZ/tXyfOl8EieXj+vpxNJbAYMQeavJ9dXiIKoTmfVt79GDM9XM7s
X-MS-Exchange-AntiSpam-MessageData: oxf7ZMpklpO/3gp7w9MpdNVftj2hSi089eMJCKF8j1FJcnzPlGs+6WF1IfrIX2A7h0iAib+J6pkZ8if93wCDG8e5I5zG8QeZzbiZFVFxvktEUIwADdD9W3lV4KVontFm0N0NLNB/W2ddoqPekfDW8hVybUd0z7oDLyJosz4HDiKx4CkURq7O7DBSVAt4kn/VAmkCZcgNunnctwKfgZ5XEcKrAEjHkoYCFvUbeWvSvbt2EU2HmRXgOtvhBRSAQbj9LpHxYYqQQ4oXeusJvkh4uissbBtYDxTI/KTGSn2Jpdm8OM8+rDtDCk9t8NRoZT9kHLDRWwONmuysFjrLOYseAq1MdGVqVhstt5pzKjSBwXiwnjSTz1n2IhebIVfhC/6RJ/urNdSa2fDfZO2bx0TpsbE4rHeVCKGUVzq1GZ6wSCNfXSt6jSHaQbQPitV/3lwGxr7VOYjkQnNu+sNuO0Kw1UDGZg4txeRHK4N+msZnmGEL+GN6ZI1MYxIoc/8w3t1d3wFRjwAA1rSe/4ymM+gJsT0HAq7VGaSxoeIpRqQnRl+SKKx3UmwMIMtDpUdE7G5N9WCn6+vcb5yg7pkLshAymHBxGaI0+kL2ii5uJrf7XCkfW/2fGBDjINpdSReDxkOuvlCmskFu++HSaKZxc124wfJnSCkJ2ipXiihAFo5C4GxTU68Qny9gYYA9NTDua2mugdULKvO5XmZsfuXeycmbjxl3x//nu6mkwDeK3nKljvRrS0F6NgARB90uSaU/kJmEPdRHDDUrs2G21OYL1yW0iIrm8tV4/cYxwu2M2qIGcmY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 741754b0-e3d6-4865-2000-08d7eaf3b0b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 21:41:06.1112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEgrk+N6vt0P9ptrsg+0uFk01rzivsP3xFrNXX6ba5PmrJP36Xr6hITw0VPcI67/skc4BR8fpPkYDnHNca4mVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3577
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 17:41:06
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
 target/arm/crypto_helper.c | 12 ++++++++++++
 target/arm/helper-sve.h    |  1 +
 target/arm/helper.h        |  2 ++
 target/arm/sve.decode      |  4 ++++
 target/arm/sve_helper.c    |  8 ++++++++
 target/arm/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 6 files changed, 57 insertions(+)

diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index 45740c1bfd..0720b3b98f 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -705,3 +705,15 @@ void HELPER(crypto_sm4ekey)(void *vd, void *vn, void* vm)
     rd[0] = d.l[0];
     rd[1] = d.l[1];
 }
+
+void HELPER(crypto_rax1)(void *vd, void *vn, void *vm, uint32_t desc)
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
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 7eef4eb476..059003c26e 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2692,3 +2692,4 @@ DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(sve2_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 37f489412c..c74cea76a2 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -537,6 +537,8 @@ DEF_HELPER_FLAGS_3(crypto_sm3partw2, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 DEF_HELPER_FLAGS_2(crypto_sm4e, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_3(crypto_sm4ekey, TCG_CALL_NO_RWG, void, ptr, ptr, ptr)
 
+DEF_HELPER_FLAGS_4(crypto_rax1, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 
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
index b3a7594981..3b560e702a 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7524,3 +7524,11 @@ void HELPER(sve2_sm4e)(void *vd, void *vn, uint32_t desc)
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
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4253955471..affe41779b 100644
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
+                           vsz, vsz, 0, gen_helper_crypto_rax1);
+    }
+    return true;
+}
-- 
2.17.1


