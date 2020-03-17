Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFCEC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1AC2051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1AC2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jED3O-0003Ty-HJ
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mahesh@linux.ibm.com>) id 1jEBME-0005nd-Bi
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mahesh@linux.ibm.com>) id 1jEBMD-00009q-1U
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:30:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mahesh@linux.ibm.com>)
 id 1jEBMC-0008UY-Pg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:30:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02HCM666034817
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 08:30:03 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yrubp08f4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 08:30:02 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mahesh@linux.ibm.com>;
 Tue, 17 Mar 2020 12:29:59 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Mar 2020 12:29:56 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02HCTtGn37618082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2020 12:29:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7ECCAA405B;
 Tue, 17 Mar 2020 12:29:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A786A405C;
 Tue, 17 Mar 2020 12:29:54 +0000 (GMT)
Received: from [192.168.0.24] (unknown [9.199.55.39])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2020 12:29:54 +0000 (GMT)
Subject: [PATCH] ppc/spapr: Set the effective address provided flag in mc
 error log.
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: Qemu-ppc <qemu-ppc@nongnu.org>
Date: Tue, 17 Mar 2020 17:59:53 +0530
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031712-4275-0000-0000-000003ADC81C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031712-4276-0000-0000-000038C2F0D6
Message-Id: <158444819283.31599.12155058652686614304.stgit@jupiter>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-17_03:2020-03-17,
 2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170052
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-Mailman-Approved-At: Tue, 17 Mar 2020 10:17:12 -0400
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
fwnmi-mce patch series. Hence guest fails to extract effective address from
mce rtas log. This patch fixes that.

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
 hw/ppc/spapr_events.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 8b32b7eea5..98a32a2e2e 100644
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
+	switch (ext_elog->mc.error_type) {
+	case RTAS_LOG_V6_MC_TYPE_UE:
+		ext_elog->mc.sub_err_type |= RTAS_LOG_V6_MC_UE_EA_ADDR_PROVIDED;
+		break;
+	case RTAS_LOG_V6_MC_TYPE_SLB:
+	case RTAS_LOG_V6_MC_TYPE_ERAT:
+	case RTAS_LOG_V6_MC_TYPE_TLB:
+		ext_elog->mc.sub_err_type |= RTAS_LOG_V6_MC_EA_ADDR_PROVIDED;
+		break;
+	default:
+		break;
+	}
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


