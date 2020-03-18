Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE161C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 07:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D56E20768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 07:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D56E20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jETEW-000307-MC
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mahesh@linux.ibm.com>) id 1jETDj-0002Qo-AI
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mahesh@linux.ibm.com>) id 1jETDi-0008Lc-3E
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:34:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45013
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mahesh@linux.ibm.com>)
 id 1jETDh-0008Km-U6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 03:34:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02I7XYwa075354
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 03:34:29 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2yucv4vc9j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 03:34:28 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mahesh@linux.ibm.com>;
 Wed, 18 Mar 2020 07:34:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Mar 2020 07:34:24 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02I7YNo342795136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2020 07:34:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B8B85205A;
 Wed, 18 Mar 2020 07:34:23 +0000 (GMT)
Received: from [192.168.0.24] (unknown [9.199.55.186])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D0B5D52051;
 Wed, 18 Mar 2020 07:34:21 +0000 (GMT)
Subject: [PATCH v2] ppc/spapr: Set the effective address provided flag in mc
 error log.
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: Qemu-ppc <qemu-ppc@nongnu.org>
Date: Wed, 18 Mar 2020 13:04:20 +0530
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031807-0016-0000-0000-000002F30926
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031807-0017-0000-0000-000033568D0A
Message-Id: <158451653844.22972.17999316676230071087.stgit@jupiter>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-18_02:2020-03-17,
 2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180034
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Qemu-devel <qemu-devel@nongnu.org>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per PAPR, it is expected to set effective address provided flag in
sub_err_type member of mc extended error log (i.e
rtas_event_log_v6_mc.sub_err_type). This somehow got missed in original
fwnmi-mce patch series. The current code just updates the effective address
but does not set the flag to indicate that it is available. Hence guest
fails to extract effective address from mce rtas log. This patch fixes
that.

Without this patch guest MCE logs fails print DAR value:

[   11.933608] Disabling lock debugging due to kernel taint
[   11.933773] MCE: CPU0: machine check (Severe) Host TLB Multihit [Recovered]
[   11.933979] MCE: CPU0: NIP: [c000000000090b34] radix__flush_tlb_range_psize+0x194/0xf00
[   11.934223] MCE: CPU0: Initiator CPU
[   11.934341] MCE: CPU0: Unknown

After the change:

[   22.454149] Disabling lock debugging due to kernel taint
[   22.454316] MCE: CPU0: machine check (Severe) Host TLB Multihit DAR: deadbeefdeadbeef [Recovered]
[   22.454605] MCE: CPU0: NIP: [c0000000003e5804] kmem_cache_alloc+0x84/0x330
[   22.454820] MCE: CPU0: Initiator CPU
[   22.454944] MCE: CPU0: Unknown


Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
---
Change in v2:
- Fixed coding style issues.
---
 hw/ppc/spapr_events.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 8b32b7eea5..cb6bfedc53 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -243,6 +243,14 @@ struct rtas_event_log_v6_mc {
 #define RTAS_LOG_V6_MC_TLB_PARITY                        1
 #define RTAS_LOG_V6_MC_TLB_MULTIHIT                      2
 #define RTAS_LOG_V6_MC_TLB_INDETERMINATE                 3
+/*
+ * Per PAPR,
+ * For UE error type, set bit 1 of sub_err_type to indicate effective addr is
+ * provided. For other error types (SLB/ERAT/TLB), set bit 0 to indicate
+ * same.
+ */
+#define RTAS_LOG_V6_MC_UE_EA_ADDR_PROVIDED               0x40
+#define RTAS_LOG_V6_MC_EA_ADDR_PROVIDED                  0x80
     uint8_t reserved_1[6];
     uint64_t effective_address;
     uint64_t logical_address;
@@ -726,6 +734,22 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
                             RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
 }
 
+static void spapr_mc_set_ea_provided_flag(struct mc_extended_log *ext_elog)
+{
+    switch (ext_elog->mc.error_type) {
+    case RTAS_LOG_V6_MC_TYPE_UE:
+        ext_elog->mc.sub_err_type |= RTAS_LOG_V6_MC_UE_EA_ADDR_PROVIDED;
+        break;
+    case RTAS_LOG_V6_MC_TYPE_SLB:
+    case RTAS_LOG_V6_MC_TYPE_ERAT:
+    case RTAS_LOG_V6_MC_TYPE_TLB:
+        ext_elog->mc.sub_err_type |= RTAS_LOG_V6_MC_EA_ADDR_PROVIDED;
+        break;
+    default:
+        break;
+    }
+}
+
 static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
                                         struct mc_extended_log *ext_elog)
 {
@@ -751,6 +775,7 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
             ext_elog->mc.sub_err_type = mc_derror_table[i].error_subtype;
             if (mc_derror_table[i].dar_valid) {
                 ext_elog->mc.effective_address = cpu_to_be64(env->spr[SPR_DAR]);
+                spapr_mc_set_ea_provided_flag(ext_elog);
             }
 
             summary |= mc_derror_table[i].initiator
@@ -769,6 +794,7 @@ static uint32_t spapr_mce_get_elog_type(PowerPCCPU *cpu, bool recovered,
             ext_elog->mc.sub_err_type = mc_ierror_table[i].error_subtype;
             if (mc_ierror_table[i].nip_valid) {
                 ext_elog->mc.effective_address = cpu_to_be64(env->nip);
+                spapr_mc_set_ea_provided_flag(ext_elog);
             }
 
             summary |= mc_ierror_table[i].initiator


