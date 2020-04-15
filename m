Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23F1C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9A120768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kgXG0nXf";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="QZL0/JBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9A120768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOnOe-00082f-EN
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 15:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jOnNp-0007Ua-0j
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <steplong@quicinc.com>) id 1jOnNn-0006Gk-P0
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:07:36 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:31071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <steplong@quicinc.com>)
 id 1jOnNj-0006EL-6Q; Wed, 15 Apr 2020 15:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1586977651; x=1618513651;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=Pq4rbuFldd7G2I1pM/m+K3DxSqFmoERBdf3O0uq1iZA=;
 b=kgXG0nXf5Z7UiaNXQQOdyjiR2V9RYYhJibM8bfAGUOA9vCLiT+dx/SLb
 nVeySNWTiu8pP0X96R5s/fXd1xYxG6jk0HNWhLWlbatgrv6y8cO6YG9dP
 fPo6fyQxmfd1ibmU3HJO868rGwiQEql4ydDaaYG+03NMAW3/abJpKxnmT c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Apr 2020 12:07:28 -0700
Received: from nasanexm01c.na.qualcomm.com ([10.85.0.83])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 15 Apr 2020 12:07:28 -0700
Received: from nasanexm03e.na.qualcomm.com (10.85.0.48) by
 NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 12:07:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 15 Apr 2020 12:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvpuLxupX0r59claV23HZLs4Q65pizpeweIZ9KHGa0XNwinMchBdRHvCYNbQ/+YIyG0IsS7WLfHGI0Vxwmsn8UBRMrZSnC7rXDgcDKmRbD2LuG6TNNEtPv2B5LSYbt1wIWa977b9thcII/LBL40WESKJ1B6d33GPrfp/m50vTN+O7ULuPuicXq4QMp7WVz1BVqZFF2zuSQkyADU7v0BZTSJtGhUs9mW1E9Jj9lIvYNgGt/ZGrnOjilNpIxheZJ+10Pxg6dI3QJGIZrCvCTkDx0H4XA6U6DwmyzrLaltPYYdv7KCAz933/8gkNlFPufckvSy0QdKNUoy7mxkbzjP+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uC9lUw8wrJpq+AVM4S/d5ypQdy/E1g7OGG0E7n2P78=;
 b=gsElrCLTJnpsNIaHp4tb1euXXlicdD9SsVOgJJ5TtpJIEFodNjGctUgSZXq88S+iphZUBfJ+9LRhc1AJ5SKGscID1+saO2qo3XduW0eZfHteuQTA3ShabEgnZAqLcRxn1UPYdEBZNJwhMaCcVQyyeKDzHY7G4qtJmR7lchTUYgwdSlwB8hxIIOJJx2hSfqgtn0jlRgqk0R69iMWsDD9pV9yEyHU7nNgV/2tDfibb3BKcZR1XZgpSBIxG8nqt3snDbNpHN++0XzKgwIxWmLHYXdgFmki1ZVADwTVx+kfMDd/zjGqFPambdM3tMF9EX3GnRHC0WGom7eDrjmwZWt9NQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uC9lUw8wrJpq+AVM4S/d5ypQdy/E1g7OGG0E7n2P78=;
 b=QZL0/JBi5WsTH39dCyruRmNn5vk7bV0Vc3nL2qriY6JqzDR7RDa5nmn9plD3K5Tltmbw+cgqPO4jfoPoZLkOxpbONUx9ZPSCnM5BXRGHyAd1Ca8TOvFKWtsoEDlhi+yJ3OX2fOwLc9DNeEuP+2V9B05e5xsmFWMItPe8Bvemk4U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3513.namprd02.prod.outlook.com
 (2603:10b6:301:77::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Wed, 15 Apr
 2020 19:07:24 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 19:07:24 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v2] target/arm: Implement SVE2 HISTCNT, HISTSEG
Date: Wed, 15 Apr 2020 15:07:08 -0400
Message-ID: <20200415190708.16914-1-steplong@quicinc.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:610:4e::31) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:4e::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 19:07:23 +0000
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 841a302d-8d95-4eb6-abc1-08d7e1703b31
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3513F70C392B09C251015097C7DB0@MWHPR0201MB3513.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:517;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(346002)(396003)(376002)(136003)(39860400002)(6506007)(26005)(16526019)(186003)(52116002)(6512007)(316002)(107886003)(6486002)(5660300002)(66476007)(956004)(66946007)(66556008)(2616005)(86362001)(36756003)(8936002)(4326008)(81156014)(2906002)(478600001)(8676002)(6916009)(6666004)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/kJ62TH7GInJoIeKzeaK58uh5kVPZBgkxoCbJQhnrZkBW7Wojy+Ee1tCbLyPQ2+lasfmL2nMZKkqDZ76HeT52sjYMywgiTdDpOP+davNfz4kqJ56jemgJWoQNy2vLCJ1SCuZWsgZN6Cuqz4fVCmp3qdgWO6UQDX3u/Z7tbdzRAo//TlgFxUdKugZW1kj9s2PI9lQbCZRQzKMRtlWUaEO7yUvgiiF0wqCyl05lyKbmeybBaKYEsmY+NzyKL6aH1YeWM+orKq3PLw/nerQAKeK3AIx4ctNzL82TbeTDgoL8XZ1nlZiKQ3nJSbT7KshVbLH87vc6d66D3glFAIMu8Tul/fkhel8LxSzLW8yPAP+JgQR7WLpTJAYaBGUfZ29/ZJnDlDYehzjFEeuxc3m44MioDtnCEWFzmVGZWxQ4FZ0TlVZYUpcZVXKiSJ1HAJezyS
X-MS-Exchange-AntiSpam-MessageData: lJ5Q9WzxqjrzSDPNxKcU+FEESmTDBO4EE9TrwisYnXYeTZWBCQK9RqIQK6H7xMIY7uqjuzxSY64+Qgme7Y6Cat+D1dUjbLwgFZk3vIJ0FpXHjWlN8Qf5jIsOGNkMfGZp5nUuw/EASwpJzY9EjYF4Vw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 841a302d-8d95-4eb6-abc1-08d7e1703b31
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 19:07:24.3711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETd4D82wE0+5X+UMhXQ0PpNuTPFxOcfkvqPiuMkRpcBj/vEXhkXaiVhlEpl4Fkgdh50jYoIokF0uzjQd588wQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3513
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Realized that I was handling the predicate register incorrectly for the
32 bit case for histcnt_s. There might be a cleaner way to write the
handler function.

 target/arm/helper-sve.h    |  7 ++++
 target/arm/sve.decode      |  6 ++++
 target/arm/sve_helper.c    | 65 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 29 +++++++++++++++++
 4 files changed, 107 insertions(+)

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
index 7c65009bb8..79e54b767d 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7016,3 +7016,68 @@ DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
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
+        uint8_t pred = pg[H1(i)] >> ((i & 1) * 4);                           \
+        if (pred & 1) {                                                      \
+            TYPE nn = n[H(i)];                                               \
+            for (j = 0; j <= i; ++j) {                                       \
+                uint8_t pred = pg[H1(j)] >> ((j & 1) * 4);                   \
+                if (pred & 1 && nn == m[H(j)]) {                             \
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


