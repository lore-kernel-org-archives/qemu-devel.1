Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37022C83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2F1206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d4Qk5WbL";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="pukO1owu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2F1206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRZf-0006Oy-17
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTRXh-0004EY-Iv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTRXJ-0008JM-9M
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:49:01 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:57020)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jTRT2-0001eV-Cl; Tue, 28 Apr 2020 10:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588085052; x=1619621052;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=dlzhgSXUBqq3kvF1WGAf1OySiT7ux8Ce68F6p/JVRSQ=;
 b=d4Qk5WbLgpsu/S3YODiHce8QZMjoohIpo0JZF7l3NK/ceYWBOxZ6eoxd
 xLWp26zec0DUHMinZejVx7OkjT7l/heV1f+7tmIsxe2BCeP/Y1bwrNp0L
 c0qeS5+z9cf/olgz57ryLo3G4etS4DZ3BYgFd1lfNyLuo0K49bE6eroWh 8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Apr 2020 07:44:10 -0700
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 28 Apr 2020 07:44:09 -0700
Received: from NASANEXM01G.na.qualcomm.com (10.85.0.33) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Apr 2020 07:44:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 28 Apr 2020 07:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa/rU04VJgrDRemtvT0iE0cK5vEqtN5dqQ9Jag+EotAUDVp8XfpZ5jLm7D7SasJeWyn5C1K41Tt/EmPDK116l1wtAtnQ7TgJ+cYBDfHOeQ5tCMdWH6tFSuKF/Hip+LfdPCmdp5kJdbjRIifNBypY7tWAdy5IvQFGz765FDHCqRLneZsyCOEW23mOFlduNc+6Z91c+EVfTBDg06NhJjD+Qf4FxEqRAZa0pdfzQPPm8Ecrn5uCLD6NPGA76JomCxqvreVo0F25cF8hkyRea2qkJCQcLqupcZr7EVkPhEH/IjuSZI7qxegUhDtXl02IIoSHsi73Rd9L+0Lwsikxuhjw9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNq2kIrHCpw1F3uVTCYHQ0belACB4ogEd2x7kex1uMY=;
 b=aROoVHWf8okJju8YJYN5S8cAGmztzFOXBfeM4070vS8nk0ed7ok+GCWZO9jao0b2PIcmWmi7it9bZn1LN8YeB6koM7+uc6wVJsawIvtBl57UdoGw5+4PIk12/a2x961t092xK8iCrar/SodF9r9WSDOhvzVSJRdWYhbTx7iUY2b9gUxdRApSpcc0mLS7m5OMVKYYkumL2BFPG3xUag2Ymfe0RlppkJW/WW+uKrxefRcO/ZMUEI2vY+SYZA7VMohEJZUEg+NMdKnzRlu78X1LxXddB390q8aGfoyTsCnE6RUhtUbflO8IvTs32xGjOYambpuaFEjCNhfHkSccXZ4jdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNq2kIrHCpw1F3uVTCYHQ0belACB4ogEd2x7kex1uMY=;
 b=pukO1owul+65uOjRxSou3P4mrywK7S75E6D6GX8qjqiikDR85K9unI6Ncrdycka5PQg4WdfFZXLSam0rKuJzrWL+57dugIHpbkJgaxf+pu7tX23uNVzULTkksPRBaoMxx/uNCI1RgrKj7N/L6uQtAGkJBluyEkSAwfrF6R955oA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 14:44:07 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.026; Tue, 28 Apr 2020
 14:44:07 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v2] target/arm: Implement SVE2 TBL, TBX
Date: Tue, 28 Apr 2020 07:43:52 -0700
Message-ID: <20200428144352.9275-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (108.176.222.2) by
 MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Tue, 28 Apr 2020 14:44:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23988ba7-daaa-486d-2608-08d7eb829abb
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3547D5FC35A6C3636973DED8C7AC0@MWHPR0201MB3547.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(346002)(366004)(39860400002)(136003)(36756003)(86362001)(2616005)(478600001)(1076003)(956004)(66946007)(66556008)(66476007)(26005)(6486002)(6916009)(4326008)(6666004)(316002)(6506007)(81156014)(8676002)(6512007)(5660300002)(8936002)(16526019)(186003)(107886003)(52116002)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwoIPzC3tqHAu63KhynNU/IAssqN9Uh4gjHNidJfnah8BAz+PSUfjTQCWjTWzLn7D5feOY9Ct0mmCEPmGdmRdiFUMaz1ceFG50IMgM8fOQrR0smbBNFBYsVJEFzXHPdEVB1kOQw1J/py8XHyh+IUJ4yJMxGN9XCxDxVjCG2aT2rP9NHHdroMtqlyNLJfmMj/rkROv5kBHJ6yEcYu+Lht2uVgvCmfADPx/Aa2BjdEVuydb2VTd7+PpZTsajtrPuqCpY96Qb0SzkT9SGTJvWNFoJiWVxLot8Z6FlZaXc00LA3bVWYTz8bT4PIjoJwDsC5r7cr+pekb9y8Nq5YgNY1fs7v5/ESYJxu37Uv/W/ePhiftCvtKT+vgbLNbwGmYTE0Cha5pjAbo3kFcBk6d2z0/67P5iDyMeQXSzQDtO5kSWq3Zp/iBt24QxI757JWiBNXp
X-MS-Exchange-AntiSpam-MessageData: 3JbSV95OEm/BTOHey0xjdDS9Cumm2fxOfHWJM0nSIrJ80YOBjJLgwjKV96R81aiRMxsJMRXFNlPCtVO9aWplHb6w/hqloC1PJGylT3b3zUazgbjFB2EdUQsD0oXAy0eEZecVAY20banA4upA8xXKYPI5SxzvjmeIMLTNZAbGCKMkB2qGwQaVZ78xEGn8HDmHETCthAmnk75EVZ6Cre1TBbqSq3rmQOZveIh6rI04p31VTlWBJsfE+YiH5w9H83A2iMqgyQcZR9JG47mgPubG2FH5CGrFLaDv8Dn1mrrCB6a13EzXFR+4y89DeyNOfwUBn8NE9wKzXGKOCK9O0sjsU5+julk/IoHqu6wcAorqndaMNdCrr14DV9v9RNzagy7NnGqOEro9XKm59W4jcBEgLbLk68TjhedUG4Gcl+vwk2tMFkuV7SLwifWzz19Cp8qDjXwqgc/VghZWlGBlKGPlhOgpodU1uiGRmLLJ0VEuFxdMcJxA2mTu8lQJP6Qsx4bkl1+0gaBgI2eGp9ODpKe8hqMxkX07Jbifkw/6YEWDAyjp6InNQ7FrL83ZVhoJi8h7BcjBF3qhydilf3PIbZNcQidS4J5jn8m6yoR3bWEB7+HIb/EGBOglbFkMYHC3jlvPQzFG8E9/QK6XUcXHTnLJpSVwCPzUg8qf1BsBJrErMEdJ+L4TANZd4aTPEkikpUJszZBdKmMkVHf0sfzbfNX+QgjoiWZkj5HwEO5NNztEd0Yu2ojrDFl+bdX0aDaKfnMoqfDlZ3QG6oQ4hSkGagUNGGshK6jW25Yw/rJZus0zyoA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23988ba7-daaa-486d-2608-08d7eb829abb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 14:44:07.2575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EqmpRgcxgVuKYpCuj+avvYvguXemTIJ+vRZo9zXk51X/OA91w3NZ8u3v8vZPdX5pxHXM9O95MNaZwQN81O0TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3547
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 10:44:10
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
 target/arm/helper-sve.h    | 10 ++++++
 target/arm/internals.h     | 12 +++++++
 target/arm/sve.decode      |  5 +++
 target/arm/sve_helper.c    | 71 ++++++++++++++++++++++++++++++++++----
 target/arm/translate-sve.c | 20 +++++++++++
 5 files changed, 112 insertions(+), 6 deletions(-)

Pulled out the common functionality for SVE TBL and SVE2 TBL, TBX. I still
haven't reimplemnted AdvSIMD TBL, TBX yet, but I would like to know if
I'm on the right track.

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 51ad60e5c3..ed8b9223ee 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2690,3 +2690,13 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_tbl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_tbl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_tbl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_tbl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_tbx_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_tbx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_tbx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_tbx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index bae4f36426..286ef3c4c6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1381,4 +1381,16 @@ static inline uint64_t useronly_maybe_clean_ptr(uint32_t desc, uint64_t ptr)
     return ptr;
 }
 
+#define DECLARE_DO_TB(TYPE)                                      \
+void do_tb_##TYPE(TYPE *vd, TYPE **tables, intptr_t ntables,     \
+                  intptr_t table_sz, TYPE *indices,              \
+                  intptr_t nindices, bool is_tbl);
+
+DECLARE_DO_TB(uint8_t)
+DECLARE_DO_TB(uint16_t)
+DECLARE_DO_TB(uint32_t)
+DECLARE_DO_TB(uint64_t)
+
+#undef DECLARE_DO_TB
+
 #endif
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index de3768c24a..624c12faf3 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1419,3 +1419,8 @@ STNT1_zprz      1110010 .. 00 ..... 001 ... ..... ..... \
 # SVE2 32-bit scatter non-temporal store (vector plus scalar)
 STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
                 @rprr_scatter_store xs=0 esz=2 scale=0
+
+### SVE2 Table Lookup (three sources)
+
+TBL_zzz         00000101 .. 1 ..... 00101 0 ..... .....  @rd_rn_rm
+TBX_zzz         00000101 .. 1 ..... 00101 1 ..... .....  @rd_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index cd5c6f7fb0..2b8de6adb8 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2944,20 +2944,37 @@ void HELPER(sve_rev_d)(void *vd, void *vn, uint32_t desc)
     }
 }
 
+#define DO_TB(TYPE, H)                                                  \
+void do_tb_##TYPE(TYPE *vd, TYPE **tables, intptr_t ntables,            \
+                  intptr_t table_sz, TYPE *indices,                     \
+                  intptr_t nindices, bool is_tbl)                       \
+{                                                                       \
+    for (intptr_t i = 0; i < nindices; ++i) {                           \
+        TYPE index = indices[H(i)];                                     \
+        if (index < table_sz * ntables) {                               \
+            vd[H(i)] = tables[index / ntables][H(index % ntables)];     \
+        } else if (is_tbl) {                                            \
+            vd[H(i)] = 0;                                               \
+        }                                                               \
+    }                                                                   \
+}
+
+DO_TB(uint8_t, H1)
+DO_TB(uint16_t, H2)
+DO_TB(uint32_t, H4)
+DO_TB(uint64_t, )
+
 #define DO_TBL(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
 {                                                              \
-    intptr_t i, opr_sz = simd_oprsz(desc);                     \
+    intptr_t opr_sz = simd_oprsz(desc);                        \
     uintptr_t elem = opr_sz / sizeof(TYPE);                    \
-    TYPE *d = vd, *n = vn, *m = vm;                            \
+    TYPE *n = vn;                                              \
     ARMVectorReg tmp;                                          \
     if (unlikely(vd == vn)) {                                  \
         n = memcpy(&tmp, vn, opr_sz);                          \
     }                                                          \
-    for (i = 0; i < elem; i++) {                               \
-        TYPE j = m[H(i)];                                      \
-        d[H(i)] = j < elem ? n[H(j)] : 0;                      \
-    }                                                          \
+    do_tb_##TYPE(vd, &n, 1, elem, vm, elem, true);             \
 }
 
 DO_TBL(sve_tbl_b, uint8_t, H1)
@@ -2967,6 +2984,48 @@ DO_TBL(sve_tbl_d, uint64_t, )
 
 #undef TBL
 
+#define DO_SVE2_TBL(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn1, void *vm, void *vn2, uint32_t desc)  \
+{                                                                           \
+    intptr_t opr_sz = simd_oprsz(desc);                                     \
+    intptr_t elem = opr_sz / sizeof(TYPE);                                  \
+    TYPE *n1 = vn1, *n2 = vn2;                                              \
+    ARMVectorReg tmp1, tmp2;                                                \
+    if (unlikely(vd == vn1)) {                                              \
+        n1 = memcpy(&tmp1, vn1, opr_sz);                                    \
+    } else if (unlikely(vd == vn2)) {                                       \
+        n2 = memcpy(&tmp2, vn2, opr_sz);                                    \
+    }                                                                       \
+    TYPE *tables[] = {n1, n2};                                              \
+    do_tb_##TYPE(vd, tables, 2, elem, vm, elem, true);                      \
+}
+
+DO_SVE2_TBL(sve2_tbl_b, uint8_t, H1)
+DO_SVE2_TBL(sve2_tbl_h, uint16_t, H2)
+DO_SVE2_TBL(sve2_tbl_s, uint32_t, H4)
+DO_SVE2_TBL(sve2_tbl_d, uint64_t, )
+
+#define DO_SVE2_TBX(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    intptr_t opr_sz = simd_oprsz(desc);                         \
+    uintptr_t elem = opr_sz / sizeof(TYPE);                     \
+    TYPE *n = vn;                                               \
+    ARMVectorReg tmp;                                           \
+    if (unlikely(vd == vn)) {                                   \
+        n = memcpy(&tmp, vn, opr_sz);                           \
+    }                                                           \
+    do_tb_##TYPE(vd, &n, 1, elem, vm, elem, false);             \
+}
+
+DO_SVE2_TBX(sve2_tbx_b, uint8_t, H1)
+DO_SVE2_TBX(sve2_tbx_h, uint16_t, H2)
+DO_SVE2_TBX(sve2_tbx_s, uint32_t, H4)
+DO_SVE2_TBX(sve2_tbx_d, uint64_t, )
+
+#undef DO_SVE2_TBX
+#undef DO_SVE2_TBL
+
 #define DO_UNPK(NAME, TYPED, TYPES, HD, HS) \
 void HELPER(NAME)(void *vd, void *vn, uint32_t desc)           \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 86c3d0ed11..11b78f49b4 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7956,3 +7956,23 @@ static bool trans_SQRDCMLAH_zzzz(DisasContext *s, arg_CMLA_zzzz *a)
     };
     return do_sve2_zzzz_fn(s, a->rd, a->rn, a->rm, a->ra, fns[a->esz], a->rot);
 }
+
+static bool trans_TBL_zzz(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_4 * const fns[] = {
+        gen_helper_sve2_tbl_b, gen_helper_sve2_tbl_h,
+        gen_helper_sve2_tbl_s, gen_helper_sve2_tbl_d,
+    };
+    int rn1 = a->rn;
+    int rn2 = (a->rn + 1) % 32;
+    return do_sve2_zzzz_fn(s, a->rd, rn1, a->rm, rn2, fns[a->esz], 0);
+}
+
+static bool trans_TBX_zzz(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[] = {
+        gen_helper_sve2_tbx_b, gen_helper_sve2_tbx_h,
+        gen_helper_sve2_tbx_s, gen_helper_sve2_tbx_d,
+    };
+    return do_sve2_zzz_ool(s, a, fns[a->esz]);
+}
-- 
2.17.1


