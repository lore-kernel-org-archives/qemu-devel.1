Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C2C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 20:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0600820782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 20:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZvNFF2SI";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="MgQ523jq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0600820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQdGL-00035j-5u
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 16:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jQdFM-0002Qq-Nz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 16:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jQdFK-0004Sp-Hk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 16:42:27 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:46772)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jQdFJ-0004Ll-Sd; Mon, 20 Apr 2020 16:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587415345; x=1618951345;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=5jBLtZSIIhzdghzkSOWu7MpEBszqIBnPXHjufCrd6vA=;
 b=ZvNFF2SIq4TL2jJwGacCw+1Gn7FjhX8/mIK/Duzgm9FgaG9WE9SFJJ8x
 OecI9HPJdcpJxNWwSS+TowPOOJLJQnFbwTqTg54tt/D3wf+CENKxTiYLl
 E9gwHv/EVQ9wuX+BOUBaUTf+oFFt5vU5p6u5A8vi67+Ed5kC5qjqKt6Ci w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Apr 2020 13:42:23 -0700
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 20 Apr 2020 13:42:23 -0700
Received: from apsanexr02b.ap.qualcomm.com (10.85.0.27) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 20 Apr 2020 13:42:23 -0700
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 apsanexr02b.ap.qualcomm.com (10.85.0.27) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 20 Apr 2020 13:42:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 20 Apr 2020 13:42:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8AostJpQQA5o+FpS/wzXz1CNl4Ls9r5TyFU5bSGec7I0AtlExjLayzCneBUJqqXGvuWgrFtNh18dlHyIxTjY6tjhNQG3D00KtN8UttfDPFGPyAPPQ2vsCdmwUUF72DLTg0RsmUT1XbxHNAogKx1Pwq+F3uWCWAcvEEMhWriGnxVVEjfAfYay/l664/iGqCC3fAndge+GOXeSfO/IlyLJHuPm7Yfb8NXxcwzO+5FFH/bpn4T9vQGQCvVspbJcKFd/u6ZmrXcYUfhEhU+q1TX/rTU+qbUbxaqAgeHwWSGBjvyMgqOMKzVDXpI5AtRtclcl8hQ/uGe6xOYUj0ww2LfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGGWQXDoLnyJdGGUOyVkZDshnh6G7lbMUfDmUMxiBs=;
 b=BZ1AUFeM7ct8+8DE+uQojyh3KgicmE8j/J268DxRgPeuoFvkQvxGpkB+IzaiEUESgQJKvy8kAGF6+KGmRxqklPrclN7OmX/qeU5EJW+Au1uVSpugfr3myNpPTBkz4Dqu2dYpXguxGyVaQIiU4WJHDDNqYjIQfmSQyhOcIzinWVOmaDuvE5cxqfc50pcG4ubLWPKwwUl/vUussfEt4TRuemdMs6hsxpfkpiuxlmX/tWzhZG+skkS38h5VeBVGXwU9BuWcfQVPxPq13cPR7KHVPn61qg5qIlgYyvmSux5CMOMSJSTMYDxxrUnIaIVCvXwfzSZNwMFiNspJCg7Z7ghJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwGGWQXDoLnyJdGGUOyVkZDshnh6G7lbMUfDmUMxiBs=;
 b=MgQ523jqcpoaNKJbNXLYUaQYAas0m9N1WoabStHlsO1KV8p2W9nro48XNbpwV+UVYzX9QmDMtZe++nStEhk5uzy4iRqvzwKZJrOigelglJY8cxNVw3c/8PhZSf4NU9kyCsJhTgrjlojZ0HRKq7FYRnW07/ZpArI1+o5znwD4OFU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3610.namprd02.prod.outlook.com
 (2603:10b6:301:79::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 20:42:19 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 20:42:19 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] target/arm: Implement SVE2 scatter store insns
Date: Mon, 20 Apr 2020 16:42:03 -0400
Message-ID: <20200420204203.13279-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0036.namprd18.prod.outlook.com
 (2603:10b6:610:55::16) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR18CA0036.namprd18.prod.outlook.com (2603:10b6:610:55::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 20:42:19 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc7dc372-3001-4fe9-f1a8-08d7e56b51f9
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB361060BE3F5DB64B9132ADB4C7D40@MWHPR0201MB3610.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:91;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(346002)(376002)(396003)(39860400002)(366004)(36756003)(2616005)(81156014)(8676002)(956004)(6512007)(6666004)(107886003)(8936002)(66556008)(66476007)(66946007)(2906002)(316002)(86362001)(6486002)(5660300002)(478600001)(4326008)(26005)(6506007)(52116002)(6916009)(16526019)(1076003)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hq0Zt4xt3RwOKOn2spPb8xSjJAFwp8hCTVci/u61NstQE8apV5oVuvOC+nc6OBFoy/w6kbEAwc5Kzy0ST5rwFkBBjZD/DoZN7XMEdUbAvQ5+sDx/OmAdZKYRtROH5VSAf0qJm/Z41NpSp07xorspELM6f9W0z6gqgwoEr5px74HcfNYVhahKtfX9L1QGpE/M20dfCjC8a99QcbAlyfpyaLFcD3Hk7tAvHNp+HOyqyBAzTdJaoJHWP/IR6Dut3uNGo+0YUgEbhrput5cFyHPGqKGV0tzAITgKrpHTet++QRWaRjwT8IPqnds26wJ85CpDm2xT19zOxQRZFHl6t8S8JNr/S/QPbrxn7FrJzpdZrj34P/Ao7BygDJ25975HKSyI8NFC2SKOUVHXoEZKd9jx5tqm4w2kZDbC22NYGoX1SS9+e1m3CFFayBxJtmSSWTxq
X-MS-Exchange-AntiSpam-MessageData: G+rwWFLtm7mqSHS7ZBmUUGHH/IrCe1xJSo2ZBBCo9yQnMPWZrPWE59rCY2PTJpAIBIsfTgLXutcAKg1M8X+jo5fZjRgL2b07cDS2KkudJSlaGXKNcc9zhq17RoMLs+WKSH8+CGo+tE1mtDuIeCuErA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7dc372-3001-4fe9-f1a8-08d7e56b51f9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 20:42:19.9448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5bwToUXjpubWgr8oLVCaOW0ap3Qrv6YiFqwCymRVttNoQMj8CUtnMCuoUMQjEvl5KjnLtCm0TS5QNhhqYxwAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3610
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 16:42:23
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

Add decoding logic for SVE2 64-bit/32-bit scatter non-temporal store
insns.

64-bit
* STNT1B (vector plus scalar)
* STNT1H (vector plus scalar)
* STNT1W (vector plus scalar)
* STNT1D (vector plus scalar)

32-bit
* STNT1B (vector plus scalar)
* STNT1H (vector plus scalar)
* STNT1W (vector plus scalar)

Signed-off-by: Stephen Long <steplong@quicinc.com>

I'm not sure if this is the correct way to do this.
---
 target/arm/sve.decode      | 10 ++++++++++
 target/arm/translate-sve.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index dd987da648..6d0b8144c3 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1387,3 +1387,13 @@ SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 ### SVE2 floating point matrix multiply accumulate
 
 FMMLA           01100100 .. 1 ..... 111001 ..... .....  @rda_rn_rm
+
+### SVE2 Memory Store Group
+
+# SVE2 64-bit scatter non-temporal store (vector plus scalar)
+ST1_zprz_sve2   1110010 .. 00 ..... 001 ... ..... ..... \
+                @rprr_scatter_store xs=2 esz=3 scale=0
+
+# SVE2 32-bit scatter non-temporal store (vector plus scalar)
+ST1_zprz_sve2   1110010 .. 10 ..... 001 ... ..... ..... \
+                @rprr_scatter_store xs=0 esz=2 scale=0
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 29532424c1..2919692dff 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6038,6 +6038,34 @@ static bool trans_ST1_zpiz(DisasContext *s, arg_ST1_zpiz *a)
     return true;
 }
 
+static bool trans_ST1_zprz_sve2(DisasContext *s, arg_ST1_zprz_sve2 *a)
+{
+    gen_helper_gvec_mem_scatter *fn;
+    bool be = s->be_data == MO_BE;
+    bool mte = s->mte_active[0];
+
+    if (!dc_isar_feature(aa64_sve2, s) || a->esz < a->msz
+            || (a->msz == 0 && a->scale)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+    switch (a->esz) {
+    case MO_32:
+        fn = scatter_store_fn32[mte][be][a->xs][a->msz];
+        break;
+    case MO_64:
+        fn = scatter_store_fn64[mte][be][a->xs][a->msz];
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    do_mem_zpz(s, a->rd, a->pg, a->rm, a->scale * a->msz,
+               cpu_reg_sp(s, a->rn), a->msz, true, fn);
+    return true;
+}
+
 /*
  * Prefetches
  */
-- 
2.17.1


