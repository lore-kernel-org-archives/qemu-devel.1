Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318AFC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0604120717
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 00:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0604120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA0lp-00013X-6r
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 19:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1jA0l3-0008Ew-W7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1jA0l2-0006Es-RI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 19:22:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1jA0kz-00067c-HS; Thu, 05 Mar 2020 19:22:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0260K25K044563; Thu, 5 Mar 2020 19:22:18 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yk4jpe5up-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2020 19:22:17 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0260FD2h019951;
 Fri, 6 Mar 2020 00:22:16 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma03wdc.us.ibm.com with ESMTP id 2yffk7f8eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2020 00:22:16 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0260MDQY56426904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2020 00:22:13 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A05827805E;
 Fri,  6 Mar 2020 00:22:13 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ABCE7805C;
 Fri,  6 Mar 2020 00:22:12 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.147])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2020 00:22:12 +0000 (GMT)
From: Leonardo Bras <leonardo@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>, bharata.rao@in.ibm.com
Subject: [RFC PATCH 1/1] ppc/spapr: Add hotplugged flag on DIMM LMBs on
 drmem_v2
Date: Thu,  5 Mar 2020 21:22:02 -0300
Message-Id: <20200306002202.176732-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-05_08:2020-03-05,
 2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060000
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
Cc: Leonardo Bras <leonardo@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On reboot, all memory that was previously added using object_add and
device_add is placed in this DIMM area.

The new SPAPR_LMB_FLAGS_HOTPLUGGED flag helps Linux to put this memory in
the correct memory zone, so no unmovable allocations are made there,
allowing the object to be easily hot-removed by device_del and
object_del.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>

---
The new flag was already proposed on Power Architecture documentation,
and it's waiting for approval.

I would like to get your comments on this change, but it's still not
ready for being merged.

Matching Linux change is here:
http://patchwork.ozlabs.org/patch/1249917/
---
 hw/ppc/spapr.c         | 3 ++-
 include/hw/ppc/spapr.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cc10798be4..01611b7953 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -699,7 +699,8 @@ static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
         g_assert(drc);
         elem = spapr_get_drconf_cell(size / lmb_size, addr,
                                      spapr_drc_index(drc), node,
-                                     SPAPR_LMB_FLAGS_ASSIGNED);
+                                     (SPAPR_LMB_FLAGS_ASSIGNED |
+                                      SPAPR_LMB_FLAGS_HOTPLUGGED);
         QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
         nr_entries++;
         cur_addr = addr + size;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 09110961a5..64a138d4d4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -870,6 +870,7 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
 #define SPAPR_LMB_FLAGS_ASSIGNED 0x00000008
 #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
 #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
+#define SPAPR_LMB_FLAGS_HOTPLUGGED 0x00000100
 
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
-- 
2.24.1


