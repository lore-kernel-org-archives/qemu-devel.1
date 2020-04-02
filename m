Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF97C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F3120757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F3120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3bd-0001Y9-Vl
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <leonardo@linux.ibm.com>) id 1jK3aR-0008KS-Sh
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <leonardo@linux.ibm.com>) id 1jK3aQ-0002Qs-2k
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:25:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <leonardo@linux.ibm.com>)
 id 1jK3aL-0002OR-H4; Thu, 02 Apr 2020 13:24:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 032H2g2Y092163; Thu, 2 Apr 2020 13:24:53 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 303wrynt70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 13:24:52 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 032HMhaJ003806;
 Thu, 2 Apr 2020 17:24:52 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04dal.us.ibm.com with ESMTP id 301x7756ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2020 17:24:52 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 032HOoVl41812280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2020 17:24:50 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F2B7112061;
 Thu,  2 Apr 2020 17:24:50 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D753B112062;
 Thu,  2 Apr 2020 17:24:44 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.85.174.86])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2020 17:24:43 +0000 (GMT)
From: Leonardo Bras <leonardo@linux.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Bharata B Rao <bharata.rao@in.ibm.com>
Subject: [PATCH v3 1/1] ppc/spapr: Add hotremovable flag on DIMM LMBs on
 drmem_v2
Date: Thu,  2 Apr 2020 14:23:40 -0300
Message-Id: <20200402172339.622720-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-02_06:2020-04-02,
 2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020133
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
 qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On reboot, all memory that was previously added using object_add and
device_add is placed in this DIMM area.

The new SPAPR_LMB_FLAGS_HOTREMOVABLE flag helps Linux to put this memory in
the correct memory zone, so no unmovable allocations are made there,
allowing the object to be easily hot-removed by device_del and
object_del.

This new flag was accepted in Power Architecture documentation.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>

---
Changes since v1:
- Flag name changed from SPAPR_LMB_FLAGS_HOTPLUGGED to
	SPAPR_LMB_FLAGS_HOTREMOVABLE
---
 hw/ppc/spapr.c         | 3 ++-
 include/hw/ppc/spapr.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9a2bd501aa..fe662e297e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -446,7 +446,8 @@ static int spapr_dt_dynamic_memory_v2(SpaprMachineState *spapr, void *fdt,
         g_assert(drc);
         elem = spapr_get_drconf_cell(size / lmb_size, addr,
                                      spapr_drc_index(drc), node,
-                                     SPAPR_LMB_FLAGS_ASSIGNED);
+                                     (SPAPR_LMB_FLAGS_ASSIGNED |
+                                      SPAPR_LMB_FLAGS_HOTREMOVABLE);
         QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
         nr_entries++;
         cur_addr = addr + size;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 42d64a0368..93e0d43051 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -880,6 +880,7 @@ int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
 #define SPAPR_LMB_FLAGS_ASSIGNED 0x00000008
 #define SPAPR_LMB_FLAGS_DRC_INVALID 0x00000020
 #define SPAPR_LMB_FLAGS_RESERVED 0x00000080
+#define SPAPR_LMB_FLAGS_HOTREMOVABLE 0x00000100
 
 void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 
-- 
2.25.1


