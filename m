Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A401C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D585F20757
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ThBF5wOR";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="V/5/Oq93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D585F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTULj-0001P1-Ke
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTUJB-0006C3-Tn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTUGw-00027G-JO
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:12 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:56545)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jTUGv-00026p-To; Tue, 28 Apr 2020 13:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588095833; x=1619631833;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=kz4lvfAmpHjMkX1TMlKAOwT+dMWopuvbpQ7GAK4T7aM=;
 b=ThBF5wORVsbYMRUo0lvjL0nkTrVjkVR2VpRNzlzWa+gqC+xBJVQBxCsL
 Hu9R2Wt42exppaZtDsLww/mRuHZnDBiLU+c2ac9ggQI/ZGCfk4P/xDg89
 ly/sWGdTvo0SRveDqAWIsE7CV35BExiEYMbvd7hGPHKbNiSV/Pzxy9Vla k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Apr 2020 10:43:51 -0700
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 28 Apr 2020 10:43:51 -0700
Received: from eusanexr01b.eu.qualcomm.com (10.85.0.99) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Apr 2020 10:43:51 -0700
Received: from NASANEXM01E.na.qualcomm.com (10.85.0.31) by
 eusanexr01b.eu.qualcomm.com (10.85.0.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Apr 2020 10:43:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 28 Apr 2020 10:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA7bLMq+fQqMGFRkR/uZzAy9LzEuaPWj6Al+VVI2HMjU3mA1GaWtb7d/q360BLvHfOp1GazTyTJZ72fU9jEFVIn4gVRN6zUBqec8/+DAXcWmWwRUlbHVT5JckNoKiNecZx7+zarA+rr+hvyfnkW5Ev2sAN5q11i5PY3HjXmTVAGWr5j2RVlWRi57nVy5fstspzUX36CPrztUOWx9MUlLsRnJ+IVtCu13z6wRAsqMTwXcPll0sRu/ET4/Ykq1tRlIt7cy5Xs94fRLjSl2PF0eAk25eUGzvaq/p2Yt8FkNHiigbcCWghPfHhGRoFLa1dMj8CWl0eMgVlAxCF37yWpI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvQhlAvvorUbWW9cIAs41+Hzbu1RLwJ/ZUWrXBX5iAo=;
 b=KHjj/G7myJ2drPLpwVKWwynZK/SwJjZej3fDMP+CeQ7p7QrWF0xTXFMpevM61nshHrUWnWQOtDkaKsCr3eui0KKsXg9Nn5BOp1A9J2t7D8wbflBk3rtvsHliYm0KLYmM97hBK7CWWuei+xGcT7+6whn5wFXh2X8esZAdgMaB0l+USAO8xgwKRMkdT01Un2sKf8Q9RKq4+mtB8yosLYUaIIeTxP/03IEerggRT4zrwsBXhmdf9f17hgU+i0XZ26IcMTn6SCcDGSGfsAUAO3pZSKShe74TI/0V2pz4m1H6j1Z/i+fkiGwQyBBNdJaLAEnpfOUH+cDpKJDv2HKoKEArZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvQhlAvvorUbWW9cIAs41+Hzbu1RLwJ/ZUWrXBX5iAo=;
 b=V/5/Oq93o8yinpuCyhYwf6IVXvG8D5FZNctA1/pzzsBD6L9HgczGj9WxtefF97l6CV0I46a4dFIIzri2wF0QymbgfkL3xOGkjuO/WguzR7oc2rVbAxJrhHhB4WdLiCLU6jJRVYJYqS4zwDsW4b8RD53Q8BxvTZEjLkec26Rsj1k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3531.namprd02.prod.outlook.com
 (2603:10b6:301:7c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 17:43:48 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.026; Tue, 28 Apr 2020
 17:43:48 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC 2/3] target/arm: Implement SVE2 FCVTLT
Date: Tue, 28 Apr 2020 10:43:31 -0700
Message-ID: <20200428174332.17162-3-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200428174332.17162-1-steplong@quicinc.com>
References: <20200428174332.17162-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:208:237::12) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (108.176.222.2) by
 MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Tue, 28 Apr 2020 17:43:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a887b8fe-379d-49f4-c1de-08d7eb9bb491
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3531486BD9932563CAB251BFC7AC0@MWHPR0201MB3531.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:13;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(136003)(396003)(376002)(346002)(39860400002)(6512007)(6486002)(8936002)(186003)(16526019)(26005)(4326008)(36756003)(316002)(5660300002)(6916009)(86362001)(107886003)(6666004)(52116002)(6506007)(8676002)(956004)(2616005)(2906002)(66946007)(66556008)(1076003)(66476007)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4HAM3QPt7xuP1jifpKJJEDq2ONcp860jtC91CzPk8PAzhzPrfNh+X6UZGBbYSVAUp4Uh+jgL0qOrpZ0ngY4RzuYUzvPV0fV9wvOHKqckiMeoEkKJDQIJSSebKgAKflcoCHDWs6oqd/1F8R5Aa0jzpLCrjzFa5AMPJkL34xesvyJv1qqMt9pKD1HxNDB9Jld6agjIz4+YYs/a/rW39rIgMxqRB1p2y6W83BJPJmIRqtfpXLxzFEVhnNRpPPx9B/VmF9k5+vD2sqEoSxiKzn9hHTERTwpQGbH6Be9BQem9qXiD/0YvITS7FKzCO3eHRclDMaeWKMLF+wQcitbjtvw+KhRnubRGV/hZsPz1Uyo/FIMxooWz7qDdJeFYmyT4VYsY9wLuYna1witJYsPgHGQncNtq+7gS5VY/aLFiBr8x95s3NHD2L6M2XSv0kAqA7ul
X-MS-Exchange-AntiSpam-MessageData: HWxi1vc/DF7m0Y0Uuje0tbVZzWe7rgMfKWR99yEcj3WLnclNPwWnlOPCKJc46Ek6ajsIga8TTWBJvCDuxi5BVVrV9w5Mw0VQf/fkUzcenfaq4Lip6p0W/zqvA5bOGoaCT1raGO2GH9ojsCrbu2/u1dfMDzcqyuhhZlZ+ijybsQq8A5FZQ2nTJy25zklS2Seu2vz7KU9HBx8w45vZLmYzzBkmIx8RP7SSJguWEc2hj42Znk4GX9774bW52HrQzYUerKjd2AS/xhsGm18cb/A9R9BhayUvFKmC/rFTDI7Z6ARskixYcnKx6N8zes3qZStrzQaztvjWUArYrSpndcgbDZ+oVSGcrXkEwntO2+sWfl6wIUd8V7R+j/IF4TEI1m5Wq8bI7zBPqq52dRNgDOjHf2qo7vd34HOjH+19upKoDfXCzfNa3c2BEKUUhdByhxX1OK0KJLnUcOaNAbPDYMTQQPU/dc2Vdg6GM0r/z88024QnKLJd3SWSDjnAhJAFPjuX6A+4y+VZF5SO6XrCD7fQmBKmR5AWZ6e184S8rugt0GeacDBDURZRqAuaB3dVrarsz+ONT6e1xGBx7eQNfEAj58+cccfJCptNnqbCAb/t55g6oGcUk2oUE7LkfenAc/IgvezzHgXPZGS34fTAGfwoi3wVBKOHybvj5S1d62P48MD1CKWXjhpGDn57/XQ3y1hnVNHzReWyhsl0ir5t8Nx7OS/jFBs84SFQRT1NKJyGohw+suF9poPM/4b3clczNz27q6AVUOUIalneOGSbCXV07TwQWc+33jPyd0w4v25/CMQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: a887b8fe-379d-49f4-c1de-08d7eb9bb491
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 17:43:48.0502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgWLWhr0ycCB6P4IVpu4R4uclPt0ih3dqokISbLKzRTsr9Go5/7ncKHrzFPtwd0R6+Ac9LkPaaqa/1xNltlJVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3531
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 13:43:52
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
 target/arm/helper-sve.h    |  5 +++++
 target/arm/sve.decode      |  2 ++
 target/arm/sve_helper.c    | 23 +++++++++++++++++++++++
 target/arm/translate-sve.c | 16 ++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 154593f110..27a8cc2cbe 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2718,3 +2718,8 @@ DEF_HELPER_FLAGS_5(sve2_fcvtnt_sh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_fcvtnt_ds, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_fcvtlt_hs, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_fcvtlt_sd, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 355b8eec75..95fc7ee32c 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1481,4 +1481,6 @@ STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
 
 ### SVE2 floating-point convert precision odd elements
 FCVTNT_sh       01100100 10 0010 00 101 ... ..... .....         @rd_pg_rn_e0
+FCVTLT_hs       01100100 10 0010 01 101 ... ..... .....         @rd_pg_rn_e0
 FCVTNT_ds       01100100 11 0010 10 101 ... ..... .....         @rd_pg_rn_e0
+FCVTLT_sd       01100100 11 0010 11 101 ... ..... .....         @rd_pg_rn_e0
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index a35983b7cd..8461d84445 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7590,3 +7590,26 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc)  \
 
 DO_FCVTNT(sve2_fcvtnt_sh, uint32_t, uint16_t, H1_4, H1_2, sve_f32_to_f16)
 DO_FCVTNT(sve2_fcvtnt_ds, uint64_t, uint32_t, H1_4, H1_2, float64_to_float32)
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
+#undef DO_FCVTLT
+#undef DO_FCVTNT
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d410d0024e..220ff19348 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8121,3 +8121,19 @@ static bool trans_FCVTNT_ds(DisasContext *s, arg_rpr_esz *a)
     }
     return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_fcvtnt_ds);
 }
+
+static bool trans_FCVTLT_hs(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_fcvtlt_hs);
+}
+
+static bool trans_FCVTLT_sd(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_fcvtlt_sd);
+}
-- 
2.17.1


