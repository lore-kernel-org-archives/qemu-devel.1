Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4C0C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 21:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072EB2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 21:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oFi/Z7Ho";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="DRyyvEzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072EB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTBWo-0001l0-VQ
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 17:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTBV9-0006vD-EF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 17:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTBV8-0003aZ-GP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 17:41:19 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:18991)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jTBV0-0003YO-3Y; Mon, 27 Apr 2020 17:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588023670; x=1619559670;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=F7awvEuPIltKdb65/KCGxYIlUKiPHhaqZtEPEeI4p74=;
 b=oFi/Z7Hos4McyBTd7PLIqht25bwpYN3iNSepj+npLwMtyzKfCOtmPjdL
 rnLYqH7UBvc9xsr/be7JfSYmTvBj0Eml1wIkvElFZTz12ZJLgaRXAYtUf
 FAUvfEKGF7CA2S0xfBkboZBO8chiGFGSrEEVQrJ3KNjnoeD2pxt7SodU2 E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Apr 2020 14:41:06 -0700
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 27 Apr 2020 14:41:06 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 14:41:06 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 14:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wlp+h3mkPiVNcmzj6Ivx2Sa/zNilIixGdMf/rGbde/+uDHOp6ffEOhPIIPGJDYGxWX2ldkbRKNEvyJV83+s1Cy5fYiqIUhlr6YUvmUE24qTUScbfx487cQdSKZn5ZQYFzTOiAWI4r/VQX1ATXlRsPvawwVV99VSaLSQpeSuEHy3XbshexiQQMEKcWbIsdF5s8t9u37YjxY7Fai3zI/uJlIT/KYQ0ax2ghlt26sbimgbYlYJ1g6hSYSkdBqQgphM8lEePAH0Y9xTT0sRO6NgnxRW27Ede/nLRZPOSubkp/r4KFL7fPV/5KKaj8io4UMwBknBGAyfqzzanUakpMKw9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeA5/UkwlJZRKpIC3EW9w9mTody8GONHY+eJaj22f20=;
 b=ofCvyWMjBbcPOi7nV1Rg/KuS+T1plZUHERx2G2IPorhNwp0bzziyYcSEWEp+BiNDJDzkzUMTZznw2KcUVgV7ajjMeBJrlDEqpxB1Zez6hY9142slBMT2R5oM1eA7H9nYqeoxEt1RBNimoORNu25UMqhO/q+W6M+wNdw1oghIxCuxVJ6pqCZ+7iPBQj9Nyos+P9HUZX96z2WBqs0LrPkZLFtsDnH1jmvMfLcwb9t9Edbm9Vd8GCS612RZj1A/6wrG1AyAY2CxFnWTMYP0QSS5787r6iOqXwaRJEx35JDBqu+/J3eTIwpAwZ34PT0SpPQWPEZyeFeJ/G8UIxqWIdcknA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeA5/UkwlJZRKpIC3EW9w9mTody8GONHY+eJaj22f20=;
 b=DRyyvEzIQEPkotrn98CTfUGEXq++MzdHOuvoQBsXKFfz4mDmFUBJcqZiKvilaQOGFe+xh9rgnCkYJq/zDI1QUyxw2e4wmqPMRmrJ3FmsEDkTD0awLQbN7oV3b2CgEP08vw1gnybK3H1rh8/yNmZvEU2LYxp94fyII1ytRC6YrWM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3577.namprd02.prod.outlook.com
 (2603:10b6:301:76::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 21:41:04 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 21:41:04 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v3 2/3] target/arm: Implement SVE2 AESE, AESD, SM4E
Date: Mon, 27 Apr 2020 14:40:45 -0700
Message-ID: <20200427214046.31401-3-steplong@quicinc.com>
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
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 21:41:03 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0140f95c-6b70-4388-b54c-08d7eaf3afea
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB35771B9EB54E005FE2DD6A57C7AF0@MWHPR0201MB3577.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:32;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(376002)(366004)(346002)(396003)(136003)(6666004)(2616005)(478600001)(36756003)(6512007)(107886003)(66556008)(2906002)(66946007)(6486002)(66476007)(4326008)(316002)(1076003)(86362001)(6506007)(8936002)(81156014)(26005)(8676002)(16526019)(956004)(186003)(52116002)(5660300002)(6916009)(32563001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kl6+GI1+/+dU7TRz8xNTGHDIsrK8ctPFeUxOy634q11GAxh6avm/Rzp1vPrC/BYhA8eoPXF4MAAT3I6YTEfZwYfSXa7tc5RBMC2lkzl5z4damBEKG0H6FfAHaVqBYjzbtpxrpaE4vA3g7Ot0SVTjUhX+EsUFUYERQzlT3832tCNOCOnyjNWD7+z+zz8TIVOEXBu2FdhkF86sSSJuJ+RylOmdS2+SqtH0B2YsiF698JEWDrgxS1rZogPH+vZuPzrhVC7iybGSaid6kIx8eqNgLuesOgfmwY/hKIHXwxjotbBTK7BPoS60YuZ5ZNeXCGsrN73GKQnyjCftecshQootlCptXTZkCfjT7i6ssaFqCH6jzLvqgDjwNthCmv8tw3EuAH0zu6wL9+/8VT7iut8NBjuhShGnJeve1yVxOO7/Ho0coyTHaYH5FdTgGITk3GtD8B7qHNlq5HrgNjmi1KBN9Sv8Cw0Gg57m9jYsJ49hpFk=
X-MS-Exchange-AntiSpam-MessageData: /tiRtikNN6YOH9ezUZo4+PnrAW3hQJZiHB6AxHgAYUeR8yn/bMXu79yA2L6jcI/qOaO5D11Rvb4mAqd673C9CASHWUjJsoYWDq+RCIpklWihlIVdz4/psJpD/ivTdicDCwQErkJNS+tepLv6lUg0lAzZxeY9coUxW6oFrvRnrRBPvZu8A+aZXGuFuFBjEctydS8vGCOIc6CaYGTXA32YAHln5t/VOVUc5MU6IbwbXd/q9bpYVxipfQpgAErnD8ZAQaO05r1q0V0DZxSeNlt2eInkBXTFJrn45DPGhA1LlKI5pGymrZ7CSjR28xkcFg0V0a/+NlAYQ/pOCv1KK7q9fk6bqpCHq939dNjf7BrtpOeDrlGfCnIhNnePY2UWbOVNdVCLFVz8cVnq9RTrdOCJ+AWxM73ut7XujhUBJKcjGf1XBHHf4U854Rj+Og9on7NwvlCl1RSacDs1tG601c3SDKYiymx8PIX+O6B0a7xZ47B1bcZpDrVoLpjmPhZxJvwgOAT7Cd4jbyCyVx3+6buOx2Y/cmMxeUmVSpLgqhgPMD5a6LQFNUYBfwOtsTiVbAq6GJeJJpFxIqrKGlQu6q4z2rUHcQqFLJWG6CCWgE6UWsF8H3qcNKUFVavhyUiGy90/BNrywqEhFefqHNFGx9ZqvO4v1yQ2MnNYc3JM6w4fu4M+9vN6jaRzCenLfMBxwGYLptBMo/12m69ngPVBp8/n/I+4CSUqNJSiOwbUAqQlU6fq63dLBZw1YE4v4ovN1UfQxgP+ye99qbmsqE0HMbuhrhD1fEzyFvRT7EDhU158HH4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0140f95c-6b70-4388-b54c-08d7eaf3afea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 21:41:04.6830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXkPpZbcNccONmKcxdBnRZuFk93eeawiyTQ8zEt06QSWK6sFgZCRzDlTuHV+UKLUuoW+xRjbPb+KX8l9a9Wz3w==
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
 target/arm/cpu.h           |  5 +++++
 target/arm/crypto_helper.c | 38 ++++++++++++++++++++++----------------
 target/arm/helper-sve.h    |  2 ++
 target/arm/sve.decode      |  6 ++++++
 target/arm/sve_helper.c    |  8 ++++++++
 target/arm/translate-sve.c | 14 ++++++++++++++
 6 files changed, 57 insertions(+), 16 deletions(-)

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
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index ae2ea018af..45740c1bfd 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -30,29 +30,35 @@ union CRYPTO_STATE {
 #define CR_ST_WORD(state, i)   (state.words[i])
 #endif
 
-void HELPER(crypto_aese)(void *vd, void *vm, uint32_t decrypt)
+void HELPER(crypto_aese)(void *vd, void *vm, uint32_t desc)
 {
     static uint8_t const * const sbox[2] = { AES_sbox, AES_isbox };
     static uint8_t const * const shift[2] = { AES_shifts, AES_ishifts };
-    uint64_t *rd = vd;
-    uint64_t *rm = vm;
-    union CRYPTO_STATE rk = { .l = { rm[0], rm[1] } };
-    union CRYPTO_STATE st = { .l = { rd[0], rd[1] } };
-    int i;
 
-    assert(decrypt < 2);
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    intptr_t decrypt = simd_data(desc);
 
-    /* xor state vector with round key */
-    rk.l[0] ^= st.l[0];
-    rk.l[1] ^= st.l[1];
+    for (i = 0; i < opr_sz; i += 16) {
+        uint64_t *rd = vd + i;
+        uint64_t *rm = vm + i;
+        union CRYPTO_STATE rk = { .l = { rm[0], rm[1] } };
+        union CRYPTO_STATE st = { .l = { rd[0], rd[1] } };
+        int i;
 
-    /* combine ShiftRows operation and sbox substitution */
-    for (i = 0; i < 16; i++) {
-        CR_ST_BYTE(st, i) = sbox[decrypt][CR_ST_BYTE(rk, shift[decrypt][i])];
-    }
+        assert(decrypt < 2);
+
+        /* xor state vector with round key */
+        rk.l[0] ^= st.l[0];
+        rk.l[1] ^= st.l[1];
+
+        /* combine ShiftRows operation and sbox substitution */
+        for (i = 0; i < 16; i++) {
+            CR_ST_BYTE(st, i) = sbox[decrypt][CR_ST_BYTE(rk, shift[decrypt][i])];
+        }
 
-    rd[0] = st.l[0];
-    rd[1] = st.l[1];
+        rd[0] = st.l[0];
+        rd[1] = st.l[1];
+    }
 }
 
 void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 51ad60e5c3..7eef4eb476 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2690,3 +2690,5 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+
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
index cd5c6f7fb0..b3a7594981 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7516,3 +7516,11 @@ void HELPER(fmmla_d)(void *vd, void *va, void *vn, void *vm,
         d[3] = float64_add(a[3], float64_add(p0, p1, status), status);
     }
 }
+
+void HELPER(sve2_sm4e)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    for (i = 0; i < opr_sz; i += 16) {
+        HELPER(crypto_sm4e)(vd + i, vn + i);
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 6523621d21..4253955471 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7976,3 +7976,17 @@ DO_SVE2_AES_CRYPTO(AESMC, aesmc, 0)
 DO_SVE2_AES_CRYPTO(AESIMC, aesmc, 1)
 DO_SVE2_AES_CRYPTO(AESE, aese, 0)
 DO_SVE2_AES_CRYPTO(AESD, aese, 1)
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


