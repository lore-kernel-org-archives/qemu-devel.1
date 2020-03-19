Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEF9C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 03:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E0020724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 03:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E0020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jElvh-0007tt-1K
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 23:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1jElv6-0007Tc-Ay
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:32:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1jElv5-0007aC-BA
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:32:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1jElv5-0007SZ-3F
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 23:32:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02J33V5D088924; Wed, 18 Mar 2020 23:32:24 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yua3vptv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2020 23:32:24 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02J3MIGo009141;
 Thu, 19 Mar 2020 03:32:23 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma02wdc.us.ibm.com with ESMTP id 2yrpw75j6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2020 03:32:23 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02J3WMwI58458458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 03:32:22 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5694078069;
 Thu, 19 Mar 2020 03:32:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF65D78064;
 Thu, 19 Mar 2020 03:32:19 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.85.205.198])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 03:32:18 +0000 (GMT)
From: Leonardo Bras <leonardo@linux.ibm.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/1] device_tree: Add info message when dumping dtb to file
Date: Thu, 19 Mar 2020 00:32:00 -0300
Message-Id: <20200319033200.390008-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_10:2020-03-18,
 2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 impostorscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=961 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190013
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Leonardo Bras <leonardo@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When dumping dtb to a file, qemu exits silently before starting the VM.

Add info message so user can easily track why the proccess exits.
Add error message if dtb dump failed.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 device_tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/device_tree.c b/device_tree.c
index f8b46b3c73..2e45c18c79 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -530,7 +530,12 @@ void qemu_fdt_dumpdtb(void *fdt, int size)
 
     if (dumpdtb) {
         /* Dump the dtb to a file and quit */
-        exit(g_file_set_contents(dumpdtb, fdt, size, NULL) ? 0 : 1);
+        if (g_file_set_contents(dumpdtb, fdt, size, NULL)) {
+            info_report("dtb dumped to %s. Exiting.", dumpdtb);
+            exit(0);
+        }
+        error_report("%s: Failed dumping dtb to %s", __func__, dumpdtb)
+        exit(1);
     }
 }
 
-- 
2.24.1


