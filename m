Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E089C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 18:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB60320768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 18:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="giBdm9Nc";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="tKKzFpHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB60320768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOnCZ-0002UX-4B
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 14:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jOnBO-0001Ej-1b
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 14:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jOnBM-0007ju-O2
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 14:54:45 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:12053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jOnB8-0007er-Si; Wed, 15 Apr 2020 14:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1586976870; x=1618512870;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=GSoJOBFNlREKHpODWXakNAZY+asB/A39kK1BDSxGiRk=;
 b=giBdm9NcfLrZ6bE6bD0KKBtUkAxARfoxMmyZ3oOn/t08hcYeW9GbIu6m
 H4KCutnYvPePUmXsZFSsFgvQVSr0DfbOhtlAGoQRG7O7Qm5ZD5mHct2zR
 IbsCzZetmxmKllB9aDcaToshaj+cH16fcbN0dIwYbPCEulfx0piO05sMD M=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Apr 2020 11:54:29 -0700
Received: from nasanexm03g.na.qualcomm.com ([10.85.0.49])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 15 Apr 2020 11:54:29 -0700
Received: from nasanexm03h.na.qualcomm.com (10.85.0.50) by
 nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 11:54:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03h.na.qualcomm.com (10.85.0.50) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 15 Apr 2020 11:54:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nyr0j4e/FIoENAbCcf7ARSNgpcPBBdPziazFHIpl5umTvVfJfAxG1UmtTxVbsH5gkO88hTfbF9d16HiezUxwb6EG1ud/E+Zeik5XsQo2+9pAy6jK93vOv5JuzJd/Xx0G7YDKNybRy5xGw+m8V1SgH1SyK7+8zBsErnZZrHOPvrcarZgDwC39GN7b8/vTPSAAVKVEcsG/eEX0QftzK9FxP9eWOENcJYOsZRZ+6eKavraGx0CQX4rw/4yCEraeNejAcUJEWVKGoPcJZcN7E0faicsd5lDWSKk48ABxhdLTQTjXAr2T9nQJBRYHb+4kEgSpAL4xb/Ue/IxSyGLwr2qt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UsHe7kK7Q5Q16rPhIcHzToYySk0IuFkzPvUC8apci8=;
 b=Td9jR7whzLwv3pKCZPoVVF0PJ0oXBTnju4SxConmXW1hEJh55g8BmviDOpkIHjSL8Q3Wy04yERTSz3TND5Fl8FIq/TdnsJhLgyKra9BEBrJtJhob9HlkTp5xWBFgAPn98ipJbF3RdEDtuNXYEh54+PhrlwvUu96a069uCJzZw87dcNqZwtib0JYhNYZ2ThDRLdSuIrNQMO9Wxg+0+83dXRjIOL/0PaRb/QainBXGZsbpitc3SisjWpAaX+FoGpGukpeyicvM5zJ1ekHcjHviWREs167UVVBa21Ps/E7d8xwKCvzDanbNAOxOWh37YW++cs1kj1gM4x00pV7o/XCO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UsHe7kK7Q5Q16rPhIcHzToYySk0IuFkzPvUC8apci8=;
 b=tKKzFpHAjmDiDyFL0wHE5Thqo9PdYogTuH9G1fQkssRNZ071ptiA2sxPoCWKz7i839t8u4pmdf/COBXnIA5/73ZffUdA9Zf76jzLoIHEmzGhW7vclGh0DYsHahH6qHgvxWVaqzTL6h+VfXqrcxSSLP5TCpvl0PNk7XbZpjAs1cs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3625.namprd02.prod.outlook.com
 (2603:10b6:301:76::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Wed, 15 Apr
 2020 18:54:27 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 18:54:27 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC] target/arm: Implement SVE2 HISTCNT, HISTSEG
Date: Wed, 15 Apr 2020 14:54:10 -0400
Message-ID: <20200415185410.15174-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:610:54::31) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR11CA0021.namprd11.prod.outlook.com (2603:10b6:610:54::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17 via Frontend Transport; Wed, 15 Apr 2020 18:54:26 +0000
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92597106-cda2-4ba6-4903-08d7e16e6c07
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3625:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB36258E0356F1EDAA8A546871C7DB0@MWHPR0201MB3625.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(376002)(39860400002)(136003)(366004)(346002)(396003)(52116002)(16526019)(5660300002)(4326008)(2616005)(26005)(6512007)(316002)(107886003)(66556008)(186003)(6486002)(6916009)(66946007)(66476007)(956004)(6506007)(86362001)(36756003)(2906002)(81156014)(8936002)(8676002)(6666004)(478600001)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqApNzuDdLqIEU2U+FaRDma7mqS4E1/ctKCW4eEjDXaO+xt9HgxG7CULkjBaMvzQOoqQPoWK9O+2X7kLTE1kJryWJ4O+RPlOBQ1zBinCnwMymGDxtb1m9VOVKmcFh9KUWR3EpyJtEw4gZKr1C4A3bWb6aE2KXHX1LUoMYmOvhcrvRxJE+HDKm7Sr1t1uatgutWA7wwgaR5HTS0rgAHUorVNB328vFr+ZN4JDQQDQfDnud7WaYYyBQt3mP99YUFXOPhxaquzz3rQs+8+R+2C62pMQlmI5y91u6pW7KbfJVpkKjXrL33bV5LnZsvEEC7AIGAejVyxFmwoUzKJvogwkyBZIp3GlG4f5POtJ5whzNxqdN03BcHVboG57IgPff60488tIdBWP7xA9oDPKxxvUCCFFzYCPSuSasvHDbehqz9qB6zgBAZxnUgBnY+Wr0UT6
X-MS-Exchange-AntiSpam-MessageData: DxL6kQBPmTxecWSpe55oi9WjOw5DhjL8fT6R9NP1bwTxE6AKYGnxqzcw3oiPwc24a8k40OU5niuaDgxTVun8ZZqyTmTDHsnmXbVfZZpTjIbSciG6Gu1/eFZtgLyz2JIwr8xk+ReXwiJ9sRGvmr5xRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92597106-cda2-4ba6-4903-08d7e16e6c07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 18:54:27.3432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcSNkYVy5UKH/IrFgPoI9GGlkVyXRg3MiEDAAz1fPbZj7rIYhGvYpCXUY0RNYb6WQgv2p2Dcs5RiB79uD881bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3625
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
Submitting patch for early review. We can probably lookup two elements
at a time for the 32 bit case for histcnt_s.

 target/arm/helper-sve.h    |  7 +++++
 target/arm/sve.decode      |  6 ++++
 target/arm/sve_helper.c    | 63 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 29 ++++++++++++++++++
 4 files changed, 105 insertions(+)

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
index 26690d4208..50ed0726fb 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -147,6 +147,7 @@
                 &rprrr_esz rn=%reg_movprfx
 @rdn_pg_rm_ra   ........ esz:2 . ra:5  ... pg:3 rm:5 rd:5 \
                 &rprrr_esz rn=%reg_movprfx
+@rd5_pg_rn_rm   ........ esz:2 . rm:5 ... pg:3 rn:5 rd:5       &rprr_esz
 
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
@@ -1325,6 +1326,11 @@ UQRSHRNT        01000101 .. 1 ..... 00 1111 ..... .....  @rd_rn_tszimm_shr
 MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
 NMATCH          01000101 .. 1 ..... 100 ... ..... 1 .... @pd_pg_rn_rm
 
+### SVE2 Histogram Computation
+
+HISTCNT         01000101 .. 1 ..... 110 ... ..... .....  @rd5_pg_rn_rm
+HISTSEG         01000101 .. 1 ..... 101 000 ..... .....  @rd_rn_rm
+
 ## SVE2 floating-point pairwise operations
 
 FADDP           01100100 .. 010 00 0 100 ... ..... ..... @rdn_pg_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 7c65009bb8..2e1012bbc4 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7016,3 +7016,66 @@ DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
 DO_PPZZ_MATCH(sve2_nmatch_ppzz_h, MO_16, true)
 
 #undef DO_PPZZ_MATCH
+
+#define DO_HISTCNT(NAME, TYPE, H)                                            \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)     \
+{                                                                            \
+    intptr_t i, j;                                                           \
+    intptr_t opr_sz = simd_oprsz(desc) / 8;                                  \
+    TYPE *d = vd, *n = vn, *m = vm;                                          \
+    uint8_t *pg = vg;                                                        \
+    for (i = 0; i < opr_sz; ++i) {                                           \
+        TYPE count = 0;                                                      \
+        if (pg[H1(i)] & 1) {                                                 \
+            TYPE nn = n[H(i)];                                               \
+            for (j = 0; j <= i; ++j) {                                       \
+                if (pg[H1(j)] & 1 && nn == m[H(j)]) {                        \
+                    ++count;                                                 \
+                }                                                            \
+            }                                                                \
+        }                                                                    \
+        d[H(i)] = count;                                                     \
+    }                                                                        \
+}
+
+DO_HISTCNT(sve2_histcnt_s, uint32_t, H1_2)
+DO_HISTCNT(sve2_histcnt_d, uint64_t,     )
+
+#undef DO_HISTCNT
+
+static inline uint8_t get_count(uint8_t n, uint64_t m)
+{
+    int i;
+    uint8_t count = 0;
+
+    for (i = 0; i < 64; i += 8) {
+        if (n == extract64(m, i, 8)) {
+            ++count;
+        }
+    }
+    return count;
+}
+
+void HELPER(sve2_histseg)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, j;
+    intptr_t opr_sz = simd_oprsz(desc);
+    uint64_t *m = vm;
+
+    for (i = 0; i < opr_sz; i += 8) {
+        uint64_t n = *(uint64_t *)(vn + i);
+        uint64_t out = 0;
+
+        for (j = 0; j < 64; j += 8) {
+            uint64_t m0 = *m;
+            uint64_t m1 = *(m + 1);
+
+            uint8_t count = get_count(n >> j, m0) + get_count(n >> j, m1);
+            out |= count << j;
+
+            m += 2;
+        }
+
+        *(uint64_t *)(vd + i) = out;
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5403ceb1d1..a4bfbe72f4 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7526,6 +7526,35 @@ static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)                  \
 DO_SVE2_PPZZ_MATCH(MATCH, match)
 DO_SVE2_PPZZ_MATCH(NMATCH, nmatch)
 
+static bool trans_HISTCNT(DisasContext *s, arg_rprr_esz *a)
+{
+    if (a->esz > 1) {
+        return false;
+    }
+    static gen_helper_gvec_4 * const fns[2] = {
+        gen_helper_sve2_histcnt_s, gen_helper_sve2_histcnt_d
+    };
+    return do_zpzz_ool(s, a, fns[a->esz]);
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


