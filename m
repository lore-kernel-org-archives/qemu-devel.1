Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9819BC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EDC206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SgfNbDo4";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="szEAg88k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EDC206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQY9P-0000LO-FC
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57780 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jQY85-0007AH-Rf
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:14:38 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jQY83-00012N-ET
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:14:35 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:46662)
 by eggs1p.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jQY82-0000wA-Mt; Mon, 20 Apr 2020 11:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1587395674; x=1618931674;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=ArGPMHO80+WoxJKaSD09R3JWNjtFk2ZxMhR5NoIBfjQ=;
 b=SgfNbDo4JvCv+ylCX0PAakhOizn9JPbxR/pH0Vx7QORzgv+Ix6LJFH+y
 /ZlgWZb4EE8sEJr31aD8oVHuS51IJLstY4BaWJNZl5jxdQqmyfz59KlRL
 fb1myLjMa/1qIxs2dwPsfMyuagGNi9ByGdsqeFilC0dGnZikmV055x1FD c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Apr 2020 08:11:14 -0700
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 20 Apr 2020 08:11:09 -0700
Received: from apsanexr02e.ap.qualcomm.com (10.85.0.28) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 20 Apr 2020 08:11:06 -0700
Received: from NASANEXM01C.na.qualcomm.com (10.85.0.83) by
 apsanexr02e.ap.qualcomm.com (10.85.0.28) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 20 Apr 2020 08:11:04 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 20 Apr 2020 08:11:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q74Fvk2d29Wf/BLwb07/frpKQag3qWcteE+OKN4ahucud0PMhZYDhjzCn6m3Wm4tmxUobEWAEYW/zODS9Idy9t3votAMhQToByJJEwbYWCb7mTo8Bt5w1CAek6vOqh8z1e0ocETDVVN4wZFctcTWJ955ZcyoiwE4BraUKw9L+7L+t9FnarKM3W5t/Oh4PTQ+9QTTuERQf/g+D/EQkeq/nkQGMSuqb/Kt5qDdtVgD+U28jMGYMunVniS2IMde/AGx9glgeIxii+fI83Afwu4oWWvDI6aHyCBcU5dy5s0r5f5GxuLsNobCCvj7qV4kjIfnaghdHbbTuElQhB5jMxnqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDJ/+DfHfgHMkFENiPasnvnTZwhIRlwMg6Gepz761Fc=;
 b=Ned9I9IB3FBeOcE2OF1+nzoOn4Hb4k3MqJfWlHyXJFTiR+3DJC2HbzH3azJcJ4bslLm0mGHLlRtTMoR+1ZLu2gEGdMyK5036qcYS6qtgkHPg1XuXgaHx0iHUziF+FQcvy8iXCWn7hoT8ezZoFbyOOxBfYbFOszlRU4fXgeOpnIZCrv0g/RtH4K6M5NzuZOUHd1AQGXYNNN9M22XYmTpSI6e0lFy/m++t3p/DXl4NWseFa4kuJXBYRijaz4kzF6gkjD5RvBQoQuFijqqkM1FpTcDD2vH7w98pqipzdQWKrvCuhOUNyEPI/ndIWlDSi/qRYkt+bufWt07mEChf/BSo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDJ/+DfHfgHMkFENiPasnvnTZwhIRlwMg6Gepz761Fc=;
 b=szEAg88kbpfWUhl4YQLt8wf7vOst/xf6Rw7z10cqDa6EFjAmex9ZMH0I6xhLYp5qpRwfBEojA6RnuxaoChcKoqAgSckawib5O5Z7vNe5PgHzpJ+X2zkdwc0oSqW2u3ERglaTZOLxyX4ElPFemxRs0mfm4GAPLogOnAOq6VA80tc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3580.namprd02.prod.outlook.com
 (2603:10b6:301:78::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 15:11:01 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 15:11:01 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] target/arm: Implement SVE2 FMMLA
Date: Mon, 20 Apr 2020 11:10:44 -0400
Message-ID: <20200420151044.12186-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH2PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:610:54::22) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-L2LA14H.localdomain (108.176.222.2) by
 CH2PR11CA0012.namprd11.prod.outlook.com (2603:10b6:610:54::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.26 via Frontend Transport; Mon, 20 Apr 2020 15:11:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9467afe5-cb98-4401-bc50-08d7e53d09b4
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB358088B5FFA1D5E6EE673B08C7D40@MWHPR0201MB3580.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:62;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(136003)(346002)(376002)(396003)(39860400002)(366004)(36756003)(81156014)(8676002)(6666004)(6512007)(956004)(2616005)(8936002)(107886003)(66556008)(2906002)(66476007)(66946007)(316002)(86362001)(6486002)(966005)(5660300002)(478600001)(4326008)(26005)(6506007)(52116002)(6916009)(16526019)(1076003)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ku4IFw1hMhR2nC67Vuouc6WG7/aNmWNtI4S24+Dpgjmj17WKcbtIDw2oWmTw6rMAvReE2eC/WW17zAeYXCBiwKTqSbEVoVsoAg38vdjb6ZcdtHalctX7yMjIJymYzbauyy7Q1lIQAvghWeDz1UE4TURiq9639/gBWbRi5rsvLskq8DVKAvxtN/pxuBShuBUew2gq/7wtdG6jR4fmAwnhzQCqUMXVCb+GYMabF9Gw0XRPNJcxitXcbK6+z1PFurLugzjtXo+7RkgkJPvaNq30bZic7zmClZBiI4zax1zTsffm2ISCC9gGp7nmDjmo8J13npGQCDfUX9D4OSZKL2vt1qUPB6eBz33L0i3aDFSkqBclRa7mSPOntfAM0r/wAmgvtJc626eyHbZi46K1gGuQnjgBwoIMKrNu4oNWxYcTDv0jLmaLLmXWqETOYXfGR4wyEwA4dBVaE9gJ0WNbCNb+shPiD4BbAxoK1y4ezNxi6icKNcnFINfHygtZcA67CxLY/lDQPuIjORr+bO4tb6rY5Q==
X-MS-Exchange-AntiSpam-MessageData: NkM7hpIkcSctkuzzW/hI9vRvuAjw2b+40i5nfWsXkVTBdAfxCGxKWCnegVbPOZx/57F5P3W19x8wLdBGMRWb+y02afgsXjiPqPMbJ19CGjkNM+7vrHKJvNX3fqCmxtCVzCGpr/mGL6k7xDlSxKVj9Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9467afe5-cb98-4401-bc50-08d7e53d09b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 15:11:01.6988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpGoXvmyf5UUpcCyiXFjUGwOxDtPBCE7K4kNNm67z3Z54GWLOsOjrO6CMW1KM4apJrht+B8fY6JD9zOJMTG4PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3580
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 11:14:31
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

I'm not sure if this insn is an SVE2 insn, since it shows up under
SVE floating point matrix multiply accumulate in the manual [1]. But,
I'll submit this for early review anyways.

[1] https://static.docs.arm.com/ddi0602/d/ISA_A64_xml_futureA-2019-12_OPT.pdf (page 2955-2956)

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
 target/arm/cpu.h           | 10 ++++++++++
 target/arm/helper-sve.h    |  3 +++
 target/arm/sve.decode      |  4 ++++
 target/arm/sve_helper.c    | 35 +++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 29 +++++++++++++++++++++++++++++
 5 files changed, 81 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b7c7946771..d41c4a08c0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3870,6 +3870,16 @@ static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_f32mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F32MM) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_f64mm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, F64MM) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index ea53750141..8104d23c5f 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2683,3 +2683,6 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 95c73c665a..dd987da648 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1383,3 +1383,7 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
+
+### SVE2 floating point matrix multiply accumulate
+
+FMMLA           01100100 .. 1 ..... 111001 ..... .....  @rda_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b392a87aef..0d8fe856d0 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7389,3 +7389,38 @@ void HELPER(sve2_histseg)(void *vd, void *vn, void *vm, uint32_t desc)
         *(uint64_t *)(vd + i + 8) = out1;
     }
 }
+
+#define DO_FP_MATRIX_MUL(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *va, void *vn, void *vm,                   \
+                     void *status, uint32_t desc)                           \
+{                                                                           \
+    intptr_t s, i, j;                                                       \
+    intptr_t opr_sz = simd_oprsz(desc) / (sizeof(TYPE) >> 2);               \
+                                                                            \
+    for (s = 0; s < opr_sz; ++s) {                                          \
+        TYPE *n = vn + s * (sizeof(TYPE) >> 2);                             \
+        TYPE *m = vm + s * (sizeof(TYPE) >> 2);                             \
+        TYPE *a = va + s * (sizeof(TYPE) >> 2);                             \
+        TYPE *d = vd + s * (sizeof(TYPE) >> 2);                             \
+                                                                            \
+        for (i = 0; i < 1; ++i) {                                           \
+            for (j = 0; j < 1; ++j) {                                       \
+                TYPE addend = a[H(2*i + j)];                                \
+                                                                            \
+                TYPE nn0 = n[H(2*i)];                                       \
+                TYPE mm0 = m[H(2*j)];                                       \
+                TYPE prod0 = TYPE##_mul(nn0, mm0, status);                  \
+                                                                            \
+                TYPE nn1 = n[H4(2*i + 1)];                                  \
+                TYPE mm1 = m[H4(2*j + 1)];                                  \
+                TYPE prod1 = TYPE##_mul(nn1, mm1, status);                  \
+                                                                            \
+                TYPE sum = TYPE##_add(prod0, prod1, status);                \
+                d[H(2*i + j)] = TYPE##_add(sum, addend, status);            \
+            }                                                               \
+        }                                                                   \
+    }                                                                       \
+}
+
+DO_FP_MATRIX_MUL(fmmla_s, float32, H4)
+DO_FP_MATRIX_MUL(fmmla_d, float64,   )
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0cbb35c691..29532424c1 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7615,6 +7615,35 @@ static bool do_sve2_zzzz_fn(DisasContext *s, int rd, int rn, int rm, int ra,
     return true;
 }
 
+static bool trans_FMMLA(DisasContext *s, arg_rrrr_esz *a)
+{
+    if (a->esz < MO_32) {
+        return false;
+    }
+
+    if (a->esz == MO_32 && !dc_isar_feature(aa64_sve2_f32mm, s)) {
+        return false;
+    }
+
+    if (a->esz == MO_64 && !dc_isar_feature(aa64_sve2_f64mm, s)) {
+        return false;
+    }
+
+    static gen_helper_gvec_4_ptr * const fns[2] = {
+        gen_helper_fmmla_s, gen_helper_fmmla_d
+    };
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->ra),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           status, vsz, vsz, 0, fns[a->esz - 2]);
+    }
+    return true;
+}
+
 static bool do_sqdmlal_zzzw(DisasContext *s, arg_rrrr_esz *a,
                             bool sel1, bool sel2)
 {
-- 
2.17.1


