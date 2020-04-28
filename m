Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35CAC83001
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B244020757
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TFZyt+gq";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="LKjDMXyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B244020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTUPW-0007ve-K6
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTUJV-0006iW-NQ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jTUJS-0007ya-H1
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:46:33 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:56545)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jTUGx-00026p-7i; Tue, 28 Apr 2020 13:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588095835; x=1619631835;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=QT7y+RC2kiHVz1izsmPpId6ASXmY7BgVrjPNkAJdTuY=;
 b=TFZyt+gqgUIAYV67IjxDk732hELNbMOVZbgfOBP8dwIXUk9wncxgs+RR
 MP1s4Age3CYCjzgX1G8KLrfVybb1GOteK/DS+L7mjxtjXxNyjVofkHmWK
 endOy/fmHi4ArfJvc3y9YqwNfQNHpsSD3rHt/dN/wF44GnlovoJOXiEz3 0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Apr 2020 10:43:51 -0700
Received: from nasanexm03c.na.qualcomm.com ([10.85.0.106])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 28 Apr 2020 10:43:51 -0700
Received: from NASANEXM01E.na.qualcomm.com (10.85.0.31) by
 nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Apr 2020 10:43:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 28 Apr 2020 10:43:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9I4ktTMgqESVrfmMxLQR6/9pwLCbfAMjZRLMZFRkBgdsugJOto5Mshy6SGkZ3RsqB9kU1x7u0SPfMJw+TV9shmkrCxgUIk4wDEdoSB7/TJ85Tcc4/lo8oJgpujYizpwATyvNk/nwIdm7L/NnxwiZ5g9DjroQwC8ioAIi/wN4UwHBrVPJrhlrv4fGEejZKfRF8bTWbnxs7cABbPfMZEl2X2G3OfIv7UPCADc56BM3JWlNGXu3WcYd000wCq4jjULrasNUEDH1bpNgYGJuGlHkq7NxVliES/xP62IM1wqswXyV7kJ4gH+kn5u7gcwiwXDqisBeMUB0/tDymGNafbTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8VTZc5mWsbUabHQwJUy4qqN6lEc0eMxWU+PFbyoDwo=;
 b=VS5QLmqGxMHeTUF+KwGeT0omJIw3Fh9e4xKQgFeNXlrMyf6I/9ASjwWljwONwSI3wRtod260ppbJG8GOM/AwhRG7nOReRea9nWmZT6T5FCpGl84Lx+3Lchfzxx+LzV713ibroARH/Ebg/mkXqbokpPLDNYABSW/1I8y7M2YbiPJhFmfIKEeTBHKsdtutQzI6ywwrbBBQty2u53su1bGv3RWKnrZQF3pSbLkkr2O6f4YJyHD61p0mlzY6M+kMB2gSFJo1kwV22Xp3M6z0nAqZzFe/rtILSp2Z2cyvHKjjh5cqT9ttnC5hpjbVRpvfz4AHhw5KQw92lgtrFfrdZuhH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8VTZc5mWsbUabHQwJUy4qqN6lEc0eMxWU+PFbyoDwo=;
 b=LKjDMXywJ/oWrVR0VgGE4lZeH0tZB+x5/30PIRMlDwiPOyfK42y5srTBiVBINo9nDkaSc+LLokRaO+HpEAHMS6EWktuYBtLGKqx4/Ogxr4jhSa9qKVhR2rr309Ee5aFSZz2IhqPt0xuevNmFaQue3HFj4Ya4UWung0fndm7DF3c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3531.namprd02.prod.outlook.com
 (2603:10b6:301:7c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 17:43:49 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.026; Tue, 28 Apr 2020
 17:43:49 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC 3/3] target/arm: Implement SVE2 FCVTXNT
Date: Tue, 28 Apr 2020 10:43:32 -0700
Message-ID: <20200428174332.17162-4-steplong@quicinc.com>
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
 Transport; Tue, 28 Apr 2020 17:43:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efe098d0-a3e6-4148-2c05-08d7eb9bb52b
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB353105749E40EA5F6C9345B5C7AC0@MWHPR0201MB3531.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(136003)(396003)(376002)(346002)(39860400002)(6512007)(6486002)(8936002)(186003)(16526019)(26005)(4326008)(36756003)(316002)(5660300002)(6916009)(86362001)(107886003)(6666004)(52116002)(6506007)(8676002)(956004)(2616005)(2906002)(66946007)(66556008)(1076003)(66476007)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7laegGXoBHGHG070rWPdAikKRLxARh0nzlBZdMZKOyHMIzI33TPLlnNUyPLJDFopL6cBqcFjv/4Ofn0nn5uoMAQl0c3bgBPeJvAoxRuTcaFpCH913cIxD//3cD4KWnUMLrVKgYguNrEpU/dseIzieIozROBel7S8tJwRHOxhln2k0nIs0LSKeFnG64OivfU+JZqZ1kTj2wU3ybak9iVYGzLt8hXR62k+ymgZqtYhiX0xKFZmzpuGmqJF7F/ilWC1iPxhp9VG5/O/vbBZYbA8o9CmovjYVmbqTWeNR7GPj/28k7MQTq2p/KJEQNi1ACbiIWn3FJ2eY8WtmsjzNnEVU+UOizoYjKbwgeQdD0g5UtMArfuaklAoZeYL2fBVT/j/liNpo8Do/J0ZRjGPdd5ksOwG4a0E7RklBcmRQTVEkNC5kMSHFikofh14ta1qvmi
X-MS-Exchange-AntiSpam-MessageData: Ig1T++LOtBBkJADH6Fy9FSzLKgGbxD7VBkzKzI99iByswxA2SDCHcFlwGJny3NyCDNj4WR8P5ZkxKOI3IHGB/MU0+x7L0n8Nr3J+SFimQ31d20bdQZ5xPOCtBDAd+OEfvo2Du1PXdOdFX6XTZwbAn4xuE0iG92p3vGNQ2whnuorqlVxBTnpCrv6pOT+YyPOeEgc6kq9oX0jg8bwe9s8edrUYrCC0LWNZWUqvTwCOHsc3EjP9xnEv94lDZTse7Jjir7MdRGIZ4cio3G3LgOUsHDc64VpGiLAk6ZfMmdIkc3lAURxOnr9qDegpG6LV3L9vEdgC6Y09sRU6PeNCtMQNvvt8CFU3MTP+YILKwUbWSuA1t+ix4Q1yUmOXBfz4Uao5tKBiVCOG4YeyUAS3D5hbb7J2Q3PJBoRkhPBDVXKpfrfOosoA8odzT0cJR7PdGBKuCVUD6ovytjKt7c4XxxUo9ZnrmJH7gKCg+fhsscO2Bbg1G8Ft8CQtWQPhCoz8xdd1ymbWsbZJ7jmbMLbFjOug2IntrilItXiGe9omLpkTVco+WvFFga/LlrPBr8GtKLA70zTZZZnDAy2KgzQZ8kK0SEGiWjJT+EstCANmqEHQZYGC57Z9D59fHWnVQPe1jgT2RnqT/PhHBQE2ye31Ul3AIVxPUH1shuvNsCl1MiqxL64Bn0orMR6HxT86jCflrW3gOvgERI3mRtNJ/+2r+KlBcdVMCASdFkOVBxK5doVldnyGG7FwOEwCFZgmsi3S77WzAAsQ6v1rAY6vmimaULRGyI6nDEpqZCB6y/1RVmJxA+Y=
X-MS-Exchange-CrossTenant-Network-Message-Id: efe098d0-a3e6-4148-2c05-08d7eb9bb52b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 17:43:49.0496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea+ucGNJjOtg2FQOTBR9OpRMvvCwF/RueC70+HcUgOo3qEAcGfor5zh0HzndCz3qODkatgIC1Xzt8kNpTmewpA==
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
 target/arm/helper-sve.h    | 2 ++
 target/arm/sve.decode      | 1 +
 target/arm/sve_helper.c    | 7 +++++++
 target/arm/translate-sve.c | 8 ++++++++
 4 files changed, 18 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 27a8cc2cbe..c18e4c01b0 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2714,6 +2714,8 @@ DEF_HELPER_FLAGS_5(sve2_sqdmlsl_idx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve2_sqdmlsl_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve2_fcvtxnt, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve2_fcvtnt_sh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_fcvtnt_ds, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 95fc7ee32c..cb4ed70698 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1480,6 +1480,7 @@ STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
                 @rprr_scatter_store xs=0 esz=2 scale=0
 
 ### SVE2 floating-point convert precision odd elements
+FCVTXNT         01100100 00 0010 10 101 ... ..... .....         @rd_pg_rn_e0
 FCVTNT_sh       01100100 10 0010 00 101 ... ..... .....         @rd_pg_rn_e0
 FCVTLT_hs       01100100 10 0010 01 101 ... ..... .....         @rd_pg_rn_e0
 FCVTNT_ds       01100100 11 0010 10 101 ... ..... .....         @rd_pg_rn_e0
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 8461d84445..56836d91cc 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -7591,6 +7591,13 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc)  \
 DO_FCVTNT(sve2_fcvtnt_sh, uint32_t, uint16_t, H1_4, H1_2, sve_f32_to_f16)
 DO_FCVTNT(sve2_fcvtnt_ds, uint64_t, uint32_t, H1_4, H1_2, float64_to_float32)
 
+void HELPER(sve2_fcvtxnt)(void *vd, void *vn, void *vg,
+                          void *status, uint32_t desc)
+{
+    set_float_rounding_mode(float_round_to_odd, status);
+    HELPER(sve2_fcvtnt_ds)(vd, vn, vg, status, desc);
+}
+
 #define DO_FCVTLT(NAME, TYPEW, TYPEN, HW, HN, OP)                             \
 void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc)  \
 {                                                                             \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 220ff19348..b1cf24f6e7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8106,6 +8106,14 @@ static bool trans_SQRDCMLAH_zzzz(DisasContext *s, arg_CMLA_zzzz *a)
     return do_sve2_zzzz_fn(s, a->rd, a->rn, a->rm, a->ra, fns[a->esz], a->rot);
 }
 
+static bool trans_FCVTXNT(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpz_ptr(s, a->rd, a->rn, a->pg, false, gen_helper_sve2_fcvtxnt);
+}
+
 static bool trans_FCVTNT_sh(DisasContext *s, arg_rpr_esz *a)
 {
     if (!dc_isar_feature(aa64_sve2, s)) {
-- 
2.17.1


