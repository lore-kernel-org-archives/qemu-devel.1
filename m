Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5525BC41621
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 00:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150262070A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 00:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150262070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFSDi-0002eF-9d
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 20:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1jFSD5-0002A3-47
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 20:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1jFSD4-0008JR-7S
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 20:41:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46754
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1jFSD1-0008HZ-Kg; Fri, 20 Mar 2020 20:41:51 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02L0WfWG012546; Fri, 20 Mar 2020 20:41:46 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yu7af53h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2020 20:41:46 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02L0dpTM020867;
 Sat, 21 Mar 2020 00:41:45 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma04dal.us.ibm.com with ESMTP id 2yrpw7hjg3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Mar 2020 00:41:45 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02L0fia754526332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Mar 2020 00:41:45 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1A80AC05F;
 Sat, 21 Mar 2020 00:41:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F9CDAC062;
 Sat, 21 Mar 2020 00:41:42 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.85.194.114])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Sat, 21 Mar 2020 00:41:41 +0000 (GMT)
From: Leonardo Bras <leonardo@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/1] spapr/rtas: Add MinMem to ibm,
 get-system-parameter RTAS call
Date: Fri, 20 Mar 2020 21:39:22 -0300
Message-Id: <20200321003921.434620-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-20_08:2020-03-20,
 2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=926 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003200094
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: danielhb@linux.ibm.com, lagarcia@linux.ibm.com, ricardom@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Leonardo Bras <leonardo@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for MinMem SPLPAR Characteristic on emulated
RTAS call ibm,get-system-parameter.

MinMem represents Minimum Memory, that is described in LOPAPR as:
The minimum amount of main store that is needed to power on the
partition. Minimum memory is expressed in MB of storage.

This  provides a way for the OS to discern hotplugged LMBs and
LMBs that have started with the VM, allowing it to better provide
a way for memory hot-removal.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 hw/ppc/spapr_rtas.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 9fb8c8632a..0f3fbca7af 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -276,10 +276,12 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
 
     switch (parameter) {
     case RTAS_SYSPARM_SPLPAR_CHARACTERISTICS: {
-        char *param_val = g_strdup_printf("MaxEntCap=%d,"
+        char *param_val = g_strdup_printf("MinMem=%" PRIu64 ","
+                                          "MaxEntCap=%d,"
                                           "DesMem=%" PRIu64 ","
                                           "DesProcs=%d,"
                                           "MaxPlatProcs=%d",
+                                          ms->ram_size / MiB,
                                           ms->smp.max_cpus,
                                           ms->ram_size / MiB,
                                           ms->smp.cpus,
-- 
2.24.1


