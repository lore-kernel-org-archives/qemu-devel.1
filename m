Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3796FC2BB85
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E661422201
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="rRVBC8P9";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="susefKk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E661422201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP4i6-00079S-55
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 09:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jP4hR-0006d9-Bu
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jP4hQ-00040Z-0K
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:37:01 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:31568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jP4hN-0003uf-0h; Thu, 16 Apr 2020 09:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587044217; x=1618580217;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=2qJfgd9twUEnfjNJ3yavCuqHCmAIsP2qILq3MbNA6mk=;
 b=rRVBC8P9rxaKqPNjO40+OBg5lSMCbYfW94LM+4QIUbwhueRUi07TSBld
 fqkI+4ztx+SUF5bmhluoLdckxFVt1R3zheyNJMgbQeKgf1x0fsuFYC9i7
 5AI7G3h5y4JMSL20f90rvg40lYfqdelexhh09zo3FUK+7+Pkq905AnQw2 s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Apr 2020 06:36:56 -0700
Received: from nasanexm01f.na.qualcomm.com ([10.85.0.32])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 16 Apr 2020 06:36:55 -0700
Received: from NASANEXM01H.na.qualcomm.com (10.85.0.34) by
 NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Apr 2020 06:36:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 16 Apr 2020 06:36:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFnUL5zynqz+Vv1KcGQMT5bbChAFnqhuBpSZ/f+6+yXHizWoD3dsfcRTx6f48k5fG2m0laed7/nGaEJplkyB5rdQsBI6anqldlxcCzSs0SfhOpfFnmGOy/aTnwfrFQyanWCyDeJ5rRWBUq9T1Rjcue/8eOQrAJf113ysL/MM2vjvFbRUCngyiRJ0qP1QvZTYVzG3eJfg3vN+gAkHTMtbDxmB0/EM0iee1vsyKZeZt4ou1wuZpkh9LJkVlZAQkSzrQV6nOciruQ29gmlJIvNsHETPqXBgeW2fhdY2GaVMe1Qco1OuTVuahh4cVAnc0XusH4LBb0BnOBN1BIP248Ybdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJsEf6fvVGvC2a2ElbnNSPrCd4pOE+/hIxu8j2S0kK4=;
 b=IyLpv5enOMsGHJPO5Wv4Ma1SGRx2NzX0D024fi83+wwFaDmgG9hNp3W/wSYdzukSUbDCjP2wY30n5TH6hI4AQTogc3vHAowfDEfk8fNqrKon6sbpI5yQgB8xebJ08eo/MpXG550ob6KvEZjmgZQe1GRU5GQXLIOQTImWCUb18ztDb/EgCC3yNTKvTWNCAJt843VCminRIzbNWq7Ev5N8/pV6GeJKnVQJe8hO+RZPVTx1TRYwnOgOMOBE4wk6pVgTWPmrkLZZr07mcS05pPrH9wiqZbdBgy8rlp/pkpBBqIfwKSOtehQTYdCU3zg3ze7xpokNmwI55HALGmCVkVyJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJsEf6fvVGvC2a2ElbnNSPrCd4pOE+/hIxu8j2S0kK4=;
 b=susefKk4qg+uCNc/Wd5gNNKx8AGUeAnnojq1hPBtkbYzmM0OJMRVRirz2vWR4kWb7t8uW+3FF3BQa1vGkgc2tQh67eSybcOpzne6tibbk0P8uJN4U327BHCHFHGhTIXoSBs6zimBBPRsV17AsTRbX4O34Fxk6xvZcFDyoMX/w7k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3433.namprd02.prod.outlook.com
 (2603:10b6:301:7c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Thu, 16 Apr
 2020 13:36:54 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 13:36:54 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v3] target/arm: Implement SVE2 HISTCNT, HISTSEG
Date: Thu, 16 Apr 2020 09:36:39 -0400
Message-ID: <20200416133639.3818-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:610:51::32) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR15CA0022.namprd15.prod.outlook.com (2603:10b6:610:51::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Thu, 16 Apr 2020 13:36:53 +0000
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa091e8-8ec5-4531-23f8-08d7e20b39b6
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3433:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB343367F3D7EBE945E3B94F5FC7D80@MWHPR0201MB3433.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(6916009)(86362001)(81156014)(8936002)(6486002)(107886003)(6666004)(6512007)(2616005)(66946007)(66476007)(66556008)(316002)(6506007)(956004)(52116002)(5660300002)(16526019)(186003)(26005)(36756003)(478600001)(2906002)(8676002)(4326008)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SsNPm6cQ9wReXdOxuJew9uqaMisdbbQq/Po2QWV22Tm968IL3SDVLBZt2KoyZ7KAwK6Jq7hSrgoulBqWRQFxHURBinxfhZP5NGFvSuzI3525lDJjCN79LQWezSB8cnrautj5gSbjaaSFfjJVlSi1jP3HnGqZXjgqYPoBeTzfKZu6xYqKx3iPgDVxZA00fq1kN8flR7OQP6AjSqS/Cpp4Fw/yplDsRoTK4/dC3TM781u8KwPq8Q5UaQsTYxzLiGNWsXJMczStuP56l5h9MoeSxTRhN8yjuaJ/tXz1Hebk+tV5jiSn58+dOdJ8/R0GaK91m01Fhv4ywuwNmFZwT52/GSIashWRu7QtHc5/JNjDl5Rba64OBwRmisXYByL1gVeOLbTwQNMvIWeHQlXeS1U7TuOhZBJmzCEna6WUq0NfRXWzM9MtX35A+tPto+3eqzEs
X-MS-Exchange-AntiSpam-MessageData: fsRBBxSq3pMl+zhoYQYVt4UreWQm2vAmP5Y9eViAjHS7P1S102IsoGdKNhd1etjt7MoGcdeN6OgS7TXl7gF29Z8zcNv9+Q02T0Z0IUr+Clz4Nw4xhGHkt8f3kl4sCCqBVa6uFguit9Xf8FR1qXcrcg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa091e8-8ec5-4531-23f8-08d7e20b39b6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 13:36:53.9668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXOJgcqts01QNksRxoMLAjuAKgswUmkYGziaRPZjzUWVgFrig6gO4jEYrPaORtCAKUjXgp6gXt3yhiWkM434ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3433
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Disregard my previous patch. There was a mistake in translate_HISTCNT().

 target/arm/helper-sve.h    |  7 +++
 target/arm/sve.decode      |  6 +++
 target/arm/sve_helper.c    | 90 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 29 ++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4733614614..958ad623f6 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2526,6 +2526,13 @@ DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_b, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_h, TCG_CALL_NO_RWG,
                    i32, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve2_histcnt_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_histcnt_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_histseg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 26690d4208..9dd20eb6ec 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -147,6 +147,7 @@
                 &rprrr_esz rn=%reg_movprfx
 @rdn_pg_rm_ra   ........ esz:2 . ra:5  ... pg:3 rm:5 rd:5 \
                 &rprrr_esz rn=%reg_movprfx
+@rd_pg_rn_rm   ........ esz:2 . rm:5 ... pg:3 rn:5 rd:5       &rprr_esz
 
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
@@ -1325,6 +1326,11 @@ UQRSHRNT        01000101 .. 1 ..... 00 1111 ..... .....  @rd_rn_tszimm_shr
 MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
 NMATCH          01000101 .. 1 ..... 100 ... ..... 1 .... @pd_pg_rn_rm
 
+### SVE2 Histogram Computation
+
+HISTCNT         01000101 .. 1 ..... 110 ... ..... .....  @rd_pg_rn_rm
+HISTSEG         01000101 .. 1 ..... 101 000 ..... .....  @rd_rn_rm
+
 ## SVE2 floating-point pairwise operations
 
 FADDP           01100100 .. 010 00 0 100 ... ..... ..... @rdn_pg_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 7c65009bb8..1489141792 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7016,3 +7016,93 @@ DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
 DO_PPZZ_MATCH(sve2_nmatch_ppzz_h, MO_16, true)
 
 #undef DO_PPZZ_MATCH
+
+void HELPER(sve2_histcnt_s)(void *vd, void *vn, void *vm, void *vg,
+                            uint32_t desc)
+{
+    intptr_t i, j;
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn, *m = vm;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; i += 4) {
+        uint64_t count = 0;
+        uint8_t pred = pg[H1(i >> 3)] >> (i & 7);
+        if (pred & 1) {
+            uint32_t nn = n[H4(i >> 2)];
+            for (j = 0; j <= i; j += 4) {
+                uint8_t pred = pg[H1(j >> 3)] >> (j & 7);
+                if (pred & 1 && nn == m[H4(j >> 2)]) {
+                    ++count;
+                }
+            }
+        }
+        d[H4(i >> 2)] = count;
+    }
+}
+
+void HELPER(sve2_histcnt_d)(void *vd, void *vn, void *vm, void *vg,
+                            uint32_t desc)
+{
+    intptr_t i, j;
+    intptr_t opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint8_t *pg = vg;
+
+    for (i = 0; i < opr_sz; ++i) {
+        uint64_t count = 0;
+        if (pg[H1(i)] & 1) {
+            uint64_t nn = n[i];
+            for (j = 0; j <= i; ++j) {
+                if (pg[H1(j)] & 1 && nn == m[j]) {
+                    ++count;
+                }
+            }
+        }
+        d[i] = count;
+    }
+}
+
+/*
+ * Returns the number of bytes in m0 and m1 that match n.
+ * See comment for do_match2().
+ * */
+static inline uint8_t do_histseg_cnt(uint8_t n, uint64_t m0, uint64_t m1)
+{
+    int esz = 0;
+    int bits = 8 << esz;
+    uint64_t ones = dup_const(esz, 1);
+    uint64_t signs = ones << (bits - 1);
+    uint64_t cmp0, cmp1;
+
+    cmp1 = dup_const(1, n);
+    cmp0 = cmp1 ^ m0;
+    cmp1 = cmp1 ^ m1;
+    cmp0 = (cmp0 - ones) & ~cmp0;
+    cmp1 = (cmp1 - ones) & ~cmp1;
+    return ctpop64((cmp0 | cmp1) & signs);
+}
+
+void HELPER(sve2_histseg)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, j;
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint64_t m0, m1;
+
+    for (i = 0; i < opr_sz; i += 8) {
+        uint64_t n = *(uint64_t *)(vn + i);
+        uint64_t out = 0;
+
+        if ((i & 1) == 0) {
+            m0 = *(uint64_t *)(vm + i);
+            m1 = *(uint64_t *)(vm + i + 8);
+        }
+
+        for (j = 0; j < 64; j += 8) {
+            uint8_t count = do_histseg_cnt(n >> j, m0, m1);
+            out |= count << j;
+        }
+
+        *(uint64_t *)(vd + i) = out;
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5403ceb1d1..6c237343ef 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7526,6 +7526,35 @@ static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)                  \
 DO_SVE2_PPZZ_MATCH(MATCH, match)
 DO_SVE2_PPZZ_MATCH(NMATCH, nmatch)
 
+static bool trans_HISTCNT(DisasContext *s, arg_rprr_esz *a)
+{
+    if (a->esz < 2) {
+        return false;
+    }
+    static gen_helper_gvec_4 * const fns[2] = {
+        gen_helper_sve2_histcnt_s, gen_helper_sve2_histcnt_d
+    };
+    return do_sve2_zpzz_ool(s, a, fns[a->esz - 2]);
+}
+
+static bool trans_HISTSEG(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (a->esz != 0) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, 0, gen_helper_sve2_histseg);
+    }
+    return true;
+}
+
 static bool do_sve2_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
                             gen_helper_gvec_4_ptr *fn)
 {
-- 
2.17.1


