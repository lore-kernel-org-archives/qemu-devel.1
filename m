Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1827CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCF520814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c4l/sGJg";
	dkim=pass (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="c1cBaVMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCF520814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrAk-0004Fx-0R
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpK-0006AV-JE
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:58 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25353)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <steplong@quicinc.com>)
 id 1jbqpI-0002Tt-FS
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590089156; x=1621625156;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=9ApVDCx4SkhofHSIoJUOCmiVH6luw0gdjz13VQEKV3s=;
 b=c4l/sGJgCnPE3mdPoiP33aJtMOdqEABIZoyfWGkNiPdq8jkhts4fPhyz
 hgx+/zvy42wPgSsrhxGR214iuTMyYwz7xwpXHeyIiw70XqbbNK6Ua1vM9
 8Pl6h+LAr+rOMjzGXeuo8fcGP81ToI+L8lA6wk3V+EMktBD26ywdSUhWy 0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 May 2020 12:25:39 -0700
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 May 2020 12:25:39 -0700
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 12:25:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 21 May 2020 12:25:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cobgasheSIC2yfJ2E+QEXRpZ/OzxPYH1SR6iNEmCXVAA28e6IUZ4dg1tUYE2ro0l3QhUSwm7YCghBxZ+PFa3yLJHTaKCDje9ACU7C+cEWKE2k+Mond5Kujr9QRrKGPvhG7qTl2NuoGrJtzKs9FkbJ5NwJddkKcHctfgaFlUp2GLjgB9ZkIJxSGDQKsaeP5cXEAMV/Fv9pMSkiOX13IOb15/zkQ9ZrCnK2ow/UUqSZXTrMaKsNTFZmRWWmWuuaOIXSpjnbz7YKCPfXX9y2OjI+uzn2ArGX1Ydfw2hQnmUAw9J1LQLHlK7gHs84fcSfkncb93vpagIBiPuWKNf0AcI9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra6TFRSkmDmWCOlbvM3xJdG12sr8ig3+z+0wvJ8mn6A=;
 b=XSKXX95XvMNZRKjMa0fmlVWYZR1pw5B6HAbR0Lbxe2iVlFFb55iRy4cQOKSqt30snKkhJniemAl9098+5N3TdEj4jEqssQkwY2lAlGXIiMNGA3HhqFaca/DMWaqC64s8Qteh8aaQhgediUEs0ssxSC53jRhuGPOMyHs6wRFqJvZTW6ckAY1/8PUFwwFPGA4+XUdV4zHR+nJGxu2tiVAvJyNyHI/Bz2r2UWe/y9/cg7rPqbCIFvfvlECO+7A+i3Tnk3AV89Zf3Hsj6UYMFnFaN6is9SL4GgRF5/b7j7KQGZ2ZUdETE0lerTR2qP29qOe7se7809bkhNIpkrPeNFfVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra6TFRSkmDmWCOlbvM3xJdG12sr8ig3+z+0wvJ8mn6A=;
 b=c1cBaVMCU/bEDw4cIqu+ZlW1HxteZO+wrhV5gX7whVWXl3WH0Bs9muwviH1/Gjg5xkBKaugT04RMlM2FaLUCU7uR0bQw55NaXQAG6+XrBCizmzaXXlo6yqxWIBlpXlsDBOD0MdjjfnCe1tgIsYE3ieMGZ6ABddRR+4jUWlyB2TY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24) by MWHPR0201MB3627.namprd02.prod.outlook.com
 (2603:10b6:301:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Thu, 21 May
 2020 19:25:37 +0000
Received: from MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37]) by MWHPR0201MB3547.namprd02.prod.outlook.com
 ([fe80::10ad:5df5:d575:1f37%3]) with mapi id 15.20.3000.034; Thu, 21 May 2020
 19:25:37 +0000
From: Stephen Long <steplong@quicinc.com>
To: <qemu-devel@nongnu.org>
Subject: [RISU PATCH v2 10/22] sve2.risu: Add patterns for crypto operations
Date: Thu, 21 May 2020 12:24:59 -0700
Message-ID: <20200521192511.6623-11-steplong@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521192511.6623-1-steplong@quicinc.com>
References: <20200521192511.6623-1-steplong@quicinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To MWHPR0201MB3547.namprd02.prod.outlook.com
 (2603:10b6:301:7b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from STEPLONG.qualcomm.com (24.102.122.190) by
 MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Thu, 21 May 2020 19:25:37 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [24.102.122.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c122f1f-2eb2-405c-cf29-08d7fdbcbdb5
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3627:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB36278B0673D2EA4BDE4B6C71C7B70@MWHPR0201MB3627.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ea9Qque4G5LfIZ4to2PKfoTRue3VCGYwQGGUDPzY5LGvQyyZK+AmqzQu3XqKzzPbYHXVShwocunZ8wshQxMdLk9z3154qmyauW5M54i00Q3d3jXAavp9+JKtH+DcLvoZJjHE72peaIig5PzjDeRTsh/Ih716C3lU1jaUvx5DKSbvrqM0QoFEm/D5Yj+zNzK8DOSJob+CX2jnrpda/UAIpxvpaARn18JZYVdw5N7tZzYc7tG/5yGchcQbv5vVBSgPL0RDlXzg8o9acPrd1rSkJLmFCdvTEJ7ArmwGscUhHhzXPoptx2QVnSIP59U/aQ7qBCqzUOPz1tBof5qWB2K19U+eHlDEWRY/MctmbD/hc5b4Eo2dIVA8JSgpyQr1NyAM/T70sWkH4l0AKI47emGcDit0jeIHoctXV1vSmYyX591qPNqKA15Q903mYt+OELhn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3547.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39860400002)(396003)(136003)(26005)(186003)(16526019)(6666004)(6916009)(1076003)(4744005)(86362001)(478600001)(2906002)(6486002)(5660300002)(8676002)(36756003)(8936002)(6512007)(6506007)(4326008)(66556008)(316002)(956004)(66476007)(66946007)(52116002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7KJuCJTFAVozPDTSnp2aK8ucKk2ck/7c7l7KIqNNO7bSzvyg4SvVre1xvM1mXff1dBYCzR9PGbifimu0Vphoh00jGF0i1CNpemTa0Ll/V1biJwS9/KnZjIp3Y5zeuCqwH6J5FjxSJcVW1EcVQ5JKT7AcoZYkGg675deNf2ArGqf7jc83WSYvHEWTVcsfzCIDjzP3BV3XgdlMf67Sp6UAg2gGRwnV4xuyVzbJ+GlClgnFFOmWRToBFDD94kpdp1B4HGvwuaErK3iZ86H7Nq45UdGapmvUDcKo3olDTwFHcj6Y149ypkwLiBQKDgYv981t++LDXiYo/Stn+ivQqzhNKgczOjHEAU2n2wfCgQnpbWPsP+6Y9sgupYtazathuv9oEgNsT/gjhAfWY4RIhy6C5SMkyqtWTyLvHXEhq5LfDp7fJg+T25QqlfPUNIvfr2sGNixLfuhZqVanHlH5sI3PRbeLH69LUFwKCz/vN6mwZjw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c122f1f-2eb2-405c-cf29-08d7fdbcbdb5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 19:25:37.7810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJs1FGMFEn57L0KM8q8f4asnYMzSAeSw8YG4ZqazMXkCQ3t4R2fqRC3FTPSIdhnCWilCM56AbkUuDihjNlX5+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3627
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=steplong@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 15:25:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stephen Long <steplong@quicinc.com>
---
 sve2.risu | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sve2.risu b/sve2.risu
index 725bbd2..6177848 100755
--- a/sve2.risu
+++ b/sve2.risu
@@ -272,6 +272,18 @@ HISTSEG     A64_V    01000101 size:2 1 zm:5 101000 zn:5 zd:5 \
 HISTCNT     A64_V    01000101 size:2 1 zm:5 110 pg:3 zn:5 zd:5 \
 !constraints { $size > 1; }
 
+# Crypto Extensions
+## crypto unary operations
+AESMC       A64_V    01000101 size:2 10000011100 0 00000 zdn:5
+AESIMC      A64_V    01000101 size:2 10000011100 1 00000 zdn:5
+## crypto destructive binary operations
+AESE        A64_V    01000101 00 10001 0 11100 0 zm:5 zdn:5
+AESD        A64_V    01000101 00 10001 0 11100 1 zm:5 zdn:5
+SM4E        A64_V    01000101 00 10001 1 11100 0 zm:5 zdn:5
+## crypto constructive binary operations
+SM4EKEY     A64_V    01000101 00 1 zm:5 11110 0 zn:5 zd:5
+RAX1        A64_V    01000101 00 1 zm:5 11110 1 zn:5 zd:5
+
 # Floating Point Pairwise
 FADDP       A64_V    01100100 size:2 010 000 100 pg:3 zm:5 zdn:5 \
 !constraints { $size != 0; }
-- 
2.25.1


