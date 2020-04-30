Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6EFC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D3520731
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="tPNS7nAh";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="CWv5x3Xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D3520731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUFAn-0000ho-5R
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jUF77-0007xB-Uf
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <steplong@quicinc.com>) id 1jUF5C-0003Hw-RG
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:44:52 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46782)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jUF5B-0003Ev-QF; Thu, 30 Apr 2020 15:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588275773; x=1619811773;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=otomSRl8MOSHVRy5hCCy/NGktUgRmHaM7T1orb3gVJY=;
 b=tPNS7nAhPpNeX/EZXzhC7VEc/LDfIz5pL5HO7F/3PehMBJXFrZ3Enqaz
 C+IoEqqLtfq0NqvPS39dpMpJ2KLeVm4+0R32UAUX9TnpBmJ5HDXPUsu/W
 jX5aOTCuFhkY9i2CKdRVoyN2VZnC4pHf7ZQebHoLBSJdkGc3lX8lMyWA7 o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Apr 2020 12:42:25 -0700
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 30 Apr 2020 12:42:25 -0700
Received: from APSANEXR01E.ap.qualcomm.com (10.85.0.38) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 12:42:24 -0700
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 APSANEXR01E.ap.qualcomm.com (10.85.0.38) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 12:42:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 30 Apr 2020 12:42:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcfZvW71VxPxmPs2Q01u4607owFw+T5fMLqO8LroiQ8HfzCDxuNubALF0Sr5nLqfWKnY3/4t485vXRDEhWIpDGOsMmOlDGGJJoEufS3yYtyKj0Sq48NcjVkfgh8SJzGlIZ3R+Bm7x1uFDM6we4dcesoh7LjTyOZMe6hg4bHnAm8iKnj5I6t7A3lKcPCsmG4ExK4k5BJkYLJdOAeXiX1z3zMRMuOtI/89zawq+f8TqlmLeWgJd5B+tVSBDP1cfUnzCMvCGQJ6VIr5KwFe/a1S6lPxFR0lwwbpQr508wcSaTVF2wAe50Lh+KL+Zr7btkk8Z+V0Mi/hLZ9yVKXrTWj0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzcNPah4JUWYoiJp68lZYtQoscdTqraWEO7HMtCON3o=;
 b=coTg02Fr3j2/IIsg2knI7hUG2EgcR8m1il+MTIY5YqAw1OfEZyvfLOY4fiOSFaFs2wO3O8O9CZ4nw6ql7LuFq4tuzagySca9mxlvCPhnn25vwcq1zwkiXrgYDXnDIrOF7gI0q9iFkJdaAlOm7mwf0NMxK/vdQhPdBED8MSRodX0SY5/LvCyuOzWt6UIBf2vaHutYxEIFaDO+gkmND9mRiTUpOayJN5xzuxrrPzwpddJ5se7yXt2+nATkSzACFoE0xuLneM0FHunoK9Hol4MTYYxBqWsFknn4cL+RcvuFsmNcgVjC7y1iRvdQrlB88I8R7siXCV6d4zCeB/DR1WVafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzcNPah4JUWYoiJp68lZYtQoscdTqraWEO7HMtCON3o=;
 b=CWv5x3XrHpjPz/lB9M92XCw+dAFkGpUzUqOLMviF/dQ+Lp2+jIUNQIHZimg796DskK6mxlt4skQgG7+m3LvhPZ9zJkbdLJFh/tW3lk4jIOrUA2t1fgWXh9n7bwVNb6l4ypbnASj2gQOoGOD/x8cPvMUvid7XVoRb+x470r8QAiw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3436.namprd02.prod.outlook.com
 (2603:10b6:301:7b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 19:42:13 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.2937.028; Thu, 30 Apr 2020
 19:42:13 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH RFC v2] target/arm: Implement SVE2 bitwise shift immediate
Date: Thu, 30 Apr 2020 12:41:59 -0700
Message-ID: <20200430194159.24064-1-steplong@quicinc.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0025.namprd22.prod.outlook.com
 (2603:10b6:208:238::30) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (108.176.222.2) by
 MN2PR22CA0025.namprd22.prod.outlook.com (2603:10b6:208:238::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Thu, 30 Apr 2020 19:42:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [108.176.222.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05cf200d-b19d-4b8c-fc23-08d7ed3e945f
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0201MB343663E7EC06A81EDA98EF3BC7AA0@MWHPR0201MB3436.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:338;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(26005)(6916009)(186003)(6666004)(316002)(86362001)(52116002)(6486002)(6512007)(107886003)(4326008)(16526019)(6506007)(1076003)(8676002)(8936002)(2906002)(2616005)(478600001)(956004)(5660300002)(66946007)(66476007)(66556008)(36756003)(14773001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZN5ADDy+xHeFov8ezDhptzSTglv6xvtA3B1uh86nX4PRP9S4Sbpq3J2v+vqUdIboQfGQKJ/bwd0txW/eFax6f2qo9opZvpK2lSA5SUGV51ClOMs/t1Fo0OxVrt1kM5p8z/DGWhRACBTRIEWIXnuvdb7I//6iqZOPz+t+a49PRBBjvPlMd1hwoaNeiCQwh1mmqTlqljrmOmz4PBmqDkZ2nrhsd9Km/IQ9MErfXE2qB2eJRH6oOdyk7xeYtwn0F86qgTPgG6K/icrotr4/EODPhtGfb4/nEl4v9IxMn7E14VKqJPDC7bYF9PnACUUX+cR2B+VeJqfDNuziSBQ2MKlpUwRd20QJHudOi+5Y5XmVOmNuI1n+msOkX+O7ant25VFwQIoKKaZkNUgkLAPkSqkGOGsVvcDXmv99venDfiwsT+8Chmm+i/GQWgOL3oKAhzxlCYDu1YeVuUWR86zlasFE3DOfQ8cM7WgX2FUFad+YH8=
X-MS-Exchange-AntiSpam-MessageData: mGKZqr/bwxLxsVol3bDz7ODVxqoXsC2JxEY/ADEK2Y6M5HwS6kQoSqh7cgTgOYJAeTtL2pF1luOb2hOw1o8R1SFm6956V+kxw+EoNT452A6TVndFhVCqWy8MN64gpRFTRp3C8j/iXDonL5g24DruDiyOj+zat+M5C621uo0F9p3aob4CyN4iNRtrlfqxrRJN/UJOL7nKOQUNWl3fesKSa4MemSKWldPJcxKlX+TbceTsZcn3sK9dgJKA2sCg1qqAlMsaVp1tQEHId3/cJYj1b8PKsbkXr+IAYJnji5PaL329kqXpgqmrbOJMmtWp/oEmuM64y9UtGLG4RI/Cut/dLe+MtxFX8eN5s83aAEwkZAxEqZPDiuiivrYz53aDZG/Pzuhzh12+PhNcUcCjSJCkVPhSR6oX/qRT2GKjGfa3SeBYv8V7f4K89RaS+Z4BGDvQalud6sWFL7PG4snWbLxn7IhY8ElSgbxzVM24uq5Ov1GVql02m1jgPsuhCaLHWY/SuN/kLqU2IusHNVa79z+qrZL2t4ZqkOoYM9DsAnudmg/G3l8Mq3yU3yWNX1fvDQPFwV+iMKJvKBOa7uUQviEn7vpnP/qJAktnnN8kO3HkroHk1T74Ol5fBRZBqeydSDIvcLLfaXhDVgREZyJc36AS1TSSjd0S4r4R7OWq8XHvmrsU/O7KDv47vJpRXP0lQMKkG2EfMIXtfPLbtZloB/dwwkqMvoqWnzA37KsvSZEFqaIWOHXxDhp1JO8H3GqldDfVb4odpAcBPm0xKyXvkF4UWgJBtPKxpPnXwgoSH7aFNGw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cf200d-b19d-4b8c-fc23-08d7ed3e945f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 19:42:13.1716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTDVEVkH5PF068M/0riZgvrlBbn4JeM3StFMEBA4wEXK0Wo03q1WDK1hglKpyVflWpYmvCtZ8jGzPehNYbwSCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3436
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.38; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-01.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 12:28:45
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

Implements SQSHL/UQSHL, SRSHR/URSHR, and SQSHLU

Signed-off-by: Stephen Long <steplong@quicinc.com>
---

Made the changes Richard requested. I think the only SVE2 insns left
are the FMLA and FMLS (both vector and indexed) ones.

There are a couple of patches that Richard has to review:
* this one
* TBX / TBL (not fully done: AdvSIMD hasn't been refactored yet)
* SVE2 fp convert precision

 target/arm/helper-sve.h    | 29 ++++++++++++++++++++++++++++
 target/arm/sve.decode      |  7 +++++++
 target/arm/sve_helper.c    | 39 ++++++++++++++++++++++++++++++++++++--
 target/arm/translate-sve.c | 19 +++++++++++++++++++
 4 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0a62eef94e..c71f3e1f39 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2731,3 +2731,32 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshl_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uqshl_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_srshr_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_srshr_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_srshr_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_srshr_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_urshr_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_urshr_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_urshr_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_urshr_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqshlu_zpzi_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshlu_zpzi_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshlu_zpzi_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqshlu_zpzi_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 3cf824bac5..a9cfbc80ab 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1568,3 +1568,10 @@ SM4E            01000101 00 10001 1 11100 0 ..... .....  @rdn_rm_e0
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
+
+### SVE2 bitwise shift by immediate (predicated)
+SQSHL_zpzi      00000100 .. 000 110 100 ... .. ... .....  @rdn_pg_tszimm_shl
+UQSHL_zpzi      00000100 .. 000 111 100 ... .. ... .....  @rdn_pg_tszimm_shl
+SRSHR_zpzi      00000100 .. 001 100 100 ... .. ... .....  @rdn_pg_tszimm_shr
+URSHR_zpzi      00000100 .. 001 101 100 ... .. ... .....  @rdn_pg_tszimm_shr
+SQSHLU_zpzi     00000100 .. 001 111 100 ... .. ... .....  @rdn_pg_tszimm_shl
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index aa94df302a..187970c288 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2218,6 +2218,43 @@ DO_ZPZI(sve_asrd_h, int16_t, H1_2, DO_ASRD)
 DO_ZPZI(sve_asrd_s, int32_t, H1_4, DO_ASRD)
 DO_ZPZI_D(sve_asrd_d, int64_t, DO_ASRD)
 
+#define DO_RSHR(x, sh) ((x >> sh) + ((x >> (sh - 1)) & 1))
+
+/* SVE2 bitwise shift by immediate */
+DO_ZPZI(sve2_sqshl_zpzi_b, int8_t, H1, do_sqshl_b)
+DO_ZPZI(sve2_sqshl_zpzi_h, int16_t, H1_2, do_sqshl_h)
+DO_ZPZI(sve2_sqshl_zpzi_s, int32_t, H1_4, do_sqshl_s)
+DO_ZPZI_D(sve2_sqshl_zpzi_d, int64_t, do_sqshl_d)
+
+DO_ZPZI(sve2_uqshl_zpzi_b, uint8_t, H1, do_uqshl_b)
+DO_ZPZI(sve2_uqshl_zpzi_h, uint16_t, H1_2, do_uqshl_h)
+DO_ZPZI(sve2_uqshl_zpzi_s, uint32_t, H1_4, do_uqshl_s)
+DO_ZPZI_D(sve2_uqshl_zpzi_d, uint64_t, do_uqshl_d)
+
+DO_ZPZI(sve2_srshr_zpzi_b, int8_t, H1, DO_RSHR)
+DO_ZPZI(sve2_srshr_zpzi_h, int16_t, H1_2, DO_RSHR)
+DO_ZPZI(sve2_srshr_zpzi_s, int32_t, H1_4, DO_RSHR)
+DO_ZPZI_D(sve2_srshr_zpzi_d, int64_t, DO_RSHR)
+
+DO_ZPZI(sve2_urshr_zpzi_b, uint8_t, H1, DO_RSHR)
+DO_ZPZI(sve2_urshr_zpzi_h, uint16_t, H1_2, DO_RSHR)
+DO_ZPZI(sve2_urshr_zpzi_s, uint32_t, H1_4, DO_RSHR)
+DO_ZPZI_D(sve2_urshr_zpzi_d, uint64_t, DO_RSHR)
+
+#define do_suqrshl_b(n, m) \
+   ({ uint32_t discard; do_suqrshl_bhs(n, (int8_t)m, 8, false, &discard); })
+#define do_suqrshl_h(n, m) \
+   ({ uint32_t discard; do_suqrshl_bhs(n, (int16_t)m, 16, false, &discard); })
+#define do_suqrshl_s(n, m) \
+   ({ uint32_t discard; do_suqrshl_bhs(n, m, 32, false, &discard); })
+#define do_suqrshl_d(n, m) \
+   ({ uint32_t discard; do_suqrshl_d(n, m, false, &discard); })
+
+DO_ZPZI(sve2_sqshlu_zpzi_b, int8_t, H1, do_suqrshl_b)
+DO_ZPZI(sve2_sqshlu_zpzi_h, int16_t, H1_2, do_suqrshl_h)
+DO_ZPZI(sve2_sqshlu_zpzi_s, int32_t, H1_4, do_suqrshl_s)
+DO_ZPZI_D(sve2_sqshlu_zpzi_d, int64_t, do_suqrshl_d)
+
 #undef DO_ASRD
 #undef DO_ZPZI
 #undef DO_ZPZI_D
@@ -2252,8 +2289,6 @@ DO_SHRNT(sve2_shrnt_h, uint16_t, uint8_t, H1_2, H1, DO_SHR)
 DO_SHRNT(sve2_shrnt_s, uint32_t, uint16_t, H1_4, H1_2, DO_SHR)
 DO_SHRNT(sve2_shrnt_d, uint64_t, uint32_t,     , H1_4, DO_SHR)
 
-#define DO_RSHR(x, sh) ((x >> sh) + ((x >> (sh - 1)) & 1))
-
 DO_SHRNB(sve2_rshrnb_h, uint16_t, uint8_t, DO_RSHR)
 DO_SHRNB(sve2_rshrnb_s, uint32_t, uint16_t, DO_RSHR)
 DO_SHRNB(sve2_rshrnb_d, uint64_t, uint32_t, DO_RSHR)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a8e57ea5f4..d74fcf4e75 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -8253,3 +8253,22 @@ static bool trans_RAX1(DisasContext *s, arg_rrr_esz *a)
     }
     return true;
 }
+
+#define DO_SVE2_ZPZI(NAME, name) \
+static bool trans_##NAME(DisasContext *s, arg_rpri_esz *a)        \
+{                                                                 \
+    static gen_helper_gvec_3 * const fns[] = {                    \
+        gen_helper_sve2_##name##_b, gen_helper_sve2_##name##_h,   \
+        gen_helper_sve2_##name##_s, gen_helper_sve2_##name##_d    \
+    };                                                            \
+    if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {           \
+        return false;                                             \
+    }                                                             \
+    return do_zpzi_ool(s, a, fns[a->esz]);                        \
+}
+
+DO_SVE2_ZPZI(SQSHL_zpzi, sqshl_zpzi)
+DO_SVE2_ZPZI(UQSHL_zpzi, uqshl_zpzi)
+DO_SVE2_ZPZI(SRSHR_zpzi, srshr_zpzi)
+DO_SVE2_ZPZI(URSHR_zpzi, urshr_zpzi)
+DO_SVE2_ZPZI(SQSHLU_zpzi, sqshlu_zpzi)
-- 
2.17.1


