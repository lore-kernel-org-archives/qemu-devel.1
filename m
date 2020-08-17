Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E740CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23F820674
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C3JAS2B6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23F820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7fyJ-00018V-RA
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1k7fxK-0000DW-7l; Mon, 17 Aug 2020 10:17:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1k7fxG-0003WD-V4; Mon, 17 Aug 2020 10:17:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07HE2Mlg002239; Mon, 17 Aug 2020 10:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nmuCmfqcbntZMBT39ZDEq96vmf4VMsF+/zVTIw9tPL4=;
 b=C3JAS2B6qSuZg4NiSAqbFvvK6V9B8nbmm/nqkMSI00jFy438JkRPG1DeB6On/awh1w1y
 dSJSb1bI4RAhYKFnY36ojA0yQh5FJns8yNAWUka2VHqfSPijbFZxD3z9J6kPNtBWEWSF
 xP1HN8qses6HnUBwvnQMxegX1PAVfXCQIRiP9ir9r2L3zuT/Q/CV62xQT3wekzgHsl6s
 Jc/wo+/7UxBmPsafImpIc5SxJ2Se09axS7PQlQ8V59krjXyJpiP+ISZ4RmKRElHu7gA/
 RHDYsp6uCf0zoAylsOV47qNWmRd4Nhte9UpUWPdt3ujS4tgsghMBh2Qgm6XFhXGNiIpB 1g== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32y24j9fxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2020 10:17:38 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HEBBUV012036;
 Mon, 17 Aug 2020 14:17:37 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma04dal.us.ibm.com with ESMTP id 32x7b9wrm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2020 14:17:37 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07HEHauO33292740
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2020 14:17:36 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69A3E6A047;
 Mon, 17 Aug 2020 14:17:36 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FA516A051;
 Mon, 17 Aug 2020 14:17:35 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.160.29])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2020 14:17:35 +0000 (GMT)
From: "Jason J. Herne" <jjherne@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH] pc-bios: s390x: Only set lowcore iplb address on
 list-directed IPL
Date: Mon, 17 Aug 2020 10:17:34 -0400
Message-Id: <20200817141734.5109-1-jjherne@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-17_09:2020-08-17,
 2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=981 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 10:17:39
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The POP states that the IPLB location is only written to 0x14 for
list-directed IPL. Some operating systems expect 0x14 to not change on
boot and will fail IPL if it does change.

Fixes: 9bfc04f9ef6802fff0
Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@de.ibm.com>
---
 pc-bios/s390-ccw/jump2ipl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
index 767012bf0c..5e3e13f4b0 100644
--- a/pc-bios/s390-ccw/jump2ipl.c
+++ b/pc-bios/s390-ccw/jump2ipl.c
@@ -33,7 +33,10 @@ void jump_to_IPL_code(uint64_t address)
 {
     /* store the subsystem information _after_ the bootmap was loaded */
     write_subsystem_identification();
-    write_iplb_location();
+
+    if (iplb.pbt != S390_IPL_TYPE_CCW) {
+            write_iplb_location();
+    }
 
     /* prevent unknown IPL types in the guest */
     if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
-- 
2.21.1


