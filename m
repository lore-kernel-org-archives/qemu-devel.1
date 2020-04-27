Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28F8C4CECC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 21:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6B52070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 21:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M7fvxljZ";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="iCDdvw11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6B52070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTBWn-0001eo-KY
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 17:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTBV7-0006th-9V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 17:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTBV6-0003Zz-Kz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 17:41:17 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:56017)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jTBUy-0003YP-Rl; Mon, 27 Apr 2020 17:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588023668; x=1619559668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=LgCGX6obc0LwYH2h2R+wRRQ8+MJIS29iOFUVmsScMII=;
 b=M7fvxljZFbeu/gDr9K2NKeSHSsaVxZfBjz7C3cbdaSL9WVqSkumllFN2
 n1Q3pXM1Zv//D7/xZEW2ldqXlNhfAbjL77Zg03rd9IGxVoNIr15Td4Lbk
 11tp2GNVVLc9NI3v46wCfl8YQR2tR/7Wwyubklomgtn+EDFXfHhe4hz5S o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2020 14:41:06 -0700
Received: from nasanexm03a.na.qualcomm.com ([10.85.0.103])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 27 Apr 2020 14:41:06 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Apr 2020 14:41:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 14:41:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkpRB3BjcRXhXDkbEZ77nDVgxdYRhFh/xey8vzEE1WAZkeVwXCI6nZB5bKUfyLz6K19x0LSMDvjD6JWA5+tVhMqv8ScYxe6ybpjDPuvMWlnVTi0i0iTN5xQT5yAUdLQaXcsrqfedYxq0srHyn6CriD/m/FFYguOWljZEzBaN7/0xfTPFkgXQHE1OUI1GeIKnsoBkfGxt9CQCaE5N2AU3XqjeI1PK00D92/yajenvt09ZHZwxwXXNBwjbUzLS6oQpOOEwGF5E2qS0QTMaK9F1ZHTQGBEE7amkx6DahwKFQECIXB/oZLnp/KCwwyJHKarGkdf/7mkTHDU+2u516c1xgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCrr2Hg/amikv/N2vvXiB77ScBz4C6zaUKrFvvIxWsM=;
 b=esoNX/7ukMEYnex7w/YhPZMU8MeO71gZ9qQzarr9Pv1j34Wv98MhzSFd3iVrF0muEfpdXVWJ+OSlbhas19Toul28oDi0HUxc9jZ92zGHuQJtN+5gE9EzElRMFrdvVShsHLQ1IsITUsWJjvJJbODUhAF51hak8sU4Pdsfx1RvHttfhNycAH5szN8Ynhw98J1IxqU7yqG5dq4Cqb4t/iHMn2n3bPv1kJqu5CFdcP9MwEzohTKc6/QK6BZ/ADiW6oQJPXiMFLhlDoJWm09Dc8qWBVijh0pbippM5NQnoi3v4PjFYcJMuWK0BTRJcaypzMnOna56gg1oLFGWKpbbns7kdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCrr2Hg/amikv/N2vvXiB77ScBz4C6zaUKrFvvIxWsM=;
 b=iCDdvw11fCvC3OotsT7K3SRvdV2AhPbVfGi+A0b/kcjGfiaXA+RKbu9+gZjPCt7h9FsKPp27mUUleXKcT/yt5/h0BzCA/XOijtJ7d+L2wJ354ByL1fon3ufxYFzsI6f6oi0/8FzAZUyELtfksatub+PNy9UYUVW87TSL7zEJY0M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=steplong@quicinc.com; 
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3577.namprd02.prod.outlook.com
 (2603:10b6:301:76::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 21:41:03 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 21:41:03 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v3 1/3] target/arm: Implement SVE2 AESMC, AESIMC
Date: Mon, 27 Apr 2020 14:40:44 -0700
Message-ID: <20200427214046.31401-2-steplong@quicinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: a49b9651-6b99-465e-97e5-08d7eaf3af63
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB357761999B1C42F2064CC18FC7AF0@MWHPR0201MB3577.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(376002)(366004)(346002)(396003)(136003)(6666004)(2616005)(478600001)(36756003)(6512007)(107886003)(66556008)(2906002)(66946007)(6486002)(66476007)(4326008)(316002)(1076003)(86362001)(6506007)(8936002)(81156014)(26005)(8676002)(16526019)(956004)(186003)(52116002)(5660300002)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+TGI6B8Q+/zNA7JmKkqtZl8sxHaXdEK4XJJ7N7xpRJdyq4k4xL68jf4zxPAPFkjESQ/cCusqv0LjqwMkgEC12PPLIUCHsn7qYPnGLOvEMrV4HtIpfZxGuSuA79MpW2HUAvwGJf4Qx3LcWijOCJMyxCGE4wX+86Hv6nOTmyQqvXxFFz/K927e2Rfn5zaIUyzhUwlUOFiiOy3C7G9ZMpZ35RYVYEjs+7frfI97sY40/VNpyPMozbPSzXC4G0bhOUAjBeOuAV+FN820VRAcTWKZA78wwlpMEAeDegnKG5HJ+LBjyyHBJl7NcqOJtzIEggQ2RT1JqjarqCXhJXroaHajw7nLGw3ohL04pWBzODh1ABlSw3HYtGpfrNBrYvIYL/3Emjy3Rda+ACRdfkYyiZAoFj5vpt4ZKFmz3ibfjbyLe2MxywzUM4CRLLQWwNtZGZ7
X-MS-Exchange-AntiSpam-MessageData: KziP6W6CRSNB7D5WvPKIp38kDaxUghKsF7zlogk461tn1JnnKJ3nAMvOgrI4lFX/c9dv91STd2mkkhUtFT5m5Auf+LHp6NQg7OPv1OKAgzjxKtUh9SGQRfKEzeEhLoT0eHACJzL4tYHrx05v0XmBZ3MpQCifdttsEFRBcIr2S1xjXwRkPc2i4wslrFBZlkBIfT2OVz3e022t+yeTemIoZ5S1aiEsolA+98cOTg/AhBjJpoQ2ymepSODsNK3ITxJE6faCM0YYwL3NyIXYI/u7PDyE0rflBOlLduNN6LXR+2niCtcx9JrED8WclzJ9C9T+JPrGdZod0Z2/iqxcUNQsdQoUCfb58XbtgTf+Rb0IWgTCXLnl2xwma/1522tR+RCIIlJnrP/wSU9VdSX05udpF1ygoAxc+CpIBRkQC1afKD25Xk/vtX4L4/TuJ/yngOwdDhSEOskPEmr2rfZJ+iypkG7+oQk+vJVZmNaLAtpcPAkm81PtOOFIoVUL6Wd4aRbg4ebpgO/mzhd1XsD/4H0Xm2/0xe+Y58O61G4cCL6lom64PoZrh9mqnEOIw2Nu0RiHgKagPb/VJEQR8Mk38wUwSV0iWggN5/0JxlmbUr0Sh6DIB9d8aGbWwmDyYqiWWAkQF9BGoEI1VBajg+YNrAq1jyltkGcYD43JvmrelOAGACIUue3pdshnlc7T2I6gPos6pWH1Q50J91Qqhq5lLObxdFIlL1twkiZvRovOjufR4DV49Snb/t9ek+YWT1rlrOIL3JFqSKmOVup4YZQk0j+tGd/4yK8BMWX1+r1f0IROI0I=
X-MS-Exchange-CrossTenant-Network-Message-Id: a49b9651-6b99-465e-97e5-08d7eaf3af63
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 21:41:03.7886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKevp4RNh/l7aCN/r9BJe5z5j9j0B4iIY2cf8oUznfjqorsGET+DZQehVepK3+GF91yvRWRFB9UrtTHNFCLKhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3577
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 17:41:06
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
 target/arm/crypto_helper.c | 36 +++++++++++++++++++++---------------
 target/arm/sve.decode      | 10 ++++++++++
 target/arm/translate-sve.c | 20 ++++++++++++++++++++
 3 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index f800266727..ae2ea018af 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -14,6 +14,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "tcg/tcg-gvec-desc.h"
 
 union CRYPTO_STATE {
     uint8_t    bytes[16];
@@ -54,7 +55,7 @@ void HELPER(crypto_aese)(void *vd, void *vm, uint32_t decrypt)
     rd[1] = st.l[1];
 }
 
-void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t decrypt)
+void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
 {
     static uint32_t const mc[][256] = { {
         /* MixColumns lookup table */
@@ -190,23 +191,28 @@ void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t decrypt)
         0xbe805d9f, 0xb58d5491, 0xa89a4f83, 0xa397468d,
     } };
 
-    uint64_t *rd = vd;
-    uint64_t *rm = vm;
-    union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
-    int i;
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    intptr_t decrypt = simd_data(desc);
 
-    assert(decrypt < 2);
+    for (i = 0; i < opr_sz; i += 16) {
+        uint64_t *rd = vd + i;
+        uint64_t *rm = vm + i;
+        union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
+        int i;
 
-    for (i = 0; i < 16; i += 4) {
-        CR_ST_WORD(st, i >> 2) =
-            mc[decrypt][CR_ST_BYTE(st, i)] ^
-            rol32(mc[decrypt][CR_ST_BYTE(st, i + 1)], 8) ^
-            rol32(mc[decrypt][CR_ST_BYTE(st, i + 2)], 16) ^
-            rol32(mc[decrypt][CR_ST_BYTE(st, i + 3)], 24);
-    }
+        assert(decrypt < 2);
 
-    rd[0] = st.l[0];
-    rd[1] = st.l[1];
+        for (i = 0; i < 16; i += 4) {
+            CR_ST_WORD(st, i >> 2) =
+                mc[decrypt][CR_ST_BYTE(st, i)] ^
+                rol32(mc[decrypt][CR_ST_BYTE(st, i + 1)], 8) ^
+                rol32(mc[decrypt][CR_ST_BYTE(st, i + 2)], 16) ^
+                rol32(mc[decrypt][CR_ST_BYTE(st, i + 3)], 24);
+        }
+
+        rd[0] = st.l[0];
+        rd[1] = st.l[1];
+    }
 }
 
 /*
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index de3768c24a..f58eb04d11 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -92,6 +92,10 @@
 # Named instruction formats.  These are generally used to
 # reduce the amount of duplication between instruction patterns.
 
+# One operand with unused vector element size
+@rdn_e0         ........ .. ........... . ..... rd:5 \
+                &rr_esz rn=%reg_movprfx esz=0
+
 # Two operand with unused vector element size
 @pd_pn_e0       ........ ........ ....... rn:4 . rd:4           &rr_esz esz=0
 
@@ -1419,3 +1423,9 @@ STNT1_zprz      1110010 .. 00 ..... 001 ... ..... ..... \
 # SVE2 32-bit scatter non-temporal store (vector plus scalar)
 STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
                 @rprr_scatter_store xs=0 esz=2 scale=0
+
+#### SVE2 Crypto Extensions
+
+## SVE2 crypto unary operations
+AESMC           01000101 00 10000011100 0 00000 .....   @rdn_e0
+AESIMC          01000101 00 10000011100 1 00000 .....   @rdn_e0
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 86c3d0ed11..6523621d21 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7956,3 +7956,23 @@ static bool trans_SQRDCMLAH_zzzz(DisasContext *s, arg_CMLA_zzzz *a)
     };
     return do_sve2_zzzz_fn(s, a->rd, a->rn, a->rm, a->ra, fns[a->esz], a->rot);
 }
+
+#define DO_SVE2_AES_CRYPTO(NAME, name, DECRYPT)                         \
+static bool trans_##NAME(DisasContext *s, arg_rr_esz *a)                \
+{                                                                       \
+    if (!dc_isar_feature(aa64_sve2_aes, s)) {                           \
+        return false;                                                   \
+    }                                                                   \
+    if (sve_access_check(s)) {                                          \
+        unsigned vsz = vec_full_reg_size(s);                            \
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->rd),               \
+                           vec_full_reg_offset(s, a->rn),               \
+                           vsz, vsz, DECRYPT, gen_helper_crypto_##name);\
+    }                                                                   \
+    return true;                                                        \
+}
+
+DO_SVE2_AES_CRYPTO(AESMC, aesmc, 0)
+DO_SVE2_AES_CRYPTO(AESIMC, aesmc, 1)
+DO_SVE2_AES_CRYPTO(AESE, aese, 0)
+DO_SVE2_AES_CRYPTO(AESD, aese, 1)
-- 
2.17.1


