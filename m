Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5BDC2D0DD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 07:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6BD20866
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 07:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6BD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imvJ1-0005Np-Ro
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 02:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1imvHD-0003KG-CS
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1imvHC-0005SD-0X
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:52:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37858
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1imvHB-0005Rz-Rn
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:52:13 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0027lOhL158592
 for <qemu-devel@nongnu.org>; Thu, 2 Jan 2020 02:52:13 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2x6n4b1j8t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 02:52:13 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Thu, 2 Jan 2020 07:52:11 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 2 Jan 2020 07:52:07 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0027q6B954657146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jan 2020 07:52:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A32D5205F;
 Thu,  2 Jan 2020 07:52:06 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.45.4])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E7C4052051;
 Thu,  2 Jan 2020 07:52:03 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Subject: [PATCH v18 6/7] migration: Include migration support for machine
 check handling
Date: Thu,  2 Jan 2020 13:21:10 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
References: <20200102075111.25308-1-ganeshgr@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20010207-0008-0000-0000-00000345D86C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010207-0009-0000-0000-00004A660E1D
Message-Id: <20200102075111.25308-7-ganeshgr@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_01:2019-12-30,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=2 adultscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020072
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: paulus@ozlabs.org, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 Aravinda Prasad <arawinda.p@gmail.com>, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aravinda Prasad <arawinda.p@gmail.com>

This patch includes migration support for machine check
handling. Especially this patch blocks VM migration
requests until the machine check error handling is
complete as these errors are specific to the source
hardware and is irrelevant on the target hardware.

[Do not set FWNMI cap in post_load, now its done in .apply hook]
Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
---
 hw/ppc/spapr.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_events.c  | 20 +++++++++++++++++++-
 hw/ppc/spapr_rtas.c    |  4 ++++
 include/hw/ppc/spapr.h |  1 +
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 975d7da734..4acdc30100 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -46,6 +46,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/global_state.h"
 #include "migration/register.h"
+#include "migration/blocker.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
 #include "cpu-models.h"
@@ -1685,6 +1686,8 @@ static void spapr_machine_reset(MachineState *machine)
 
     /* Signal all vCPUs waiting on this condition */
     qemu_cond_broadcast(&spapr->mc_delivery_cond);
+
+    migrate_del_blocker(spapr->fwnmi_migration_blocker);
 }
 
 static void spapr_create_nvram(SpaprMachineState *spapr)
@@ -1967,6 +1970,43 @@ static const VMStateDescription vmstate_spapr_dtb = {
     },
 };
 
+static bool spapr_fwnmi_needed(void *opaque)
+{
+    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
+
+    return spapr->fwnmi_calls_registered;
+}
+
+static int spapr_fwnmi_pre_save(void *opaque)
+{
+    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
+
+    /*
+     * Check if machine check handling is in progress and print a
+     * warning message.
+     */
+    if (spapr->mc_status != -1) {
+        warn_report("A machine check is being handled during migration. The"
+                "handler may run and log hardware error on the destination");
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_spapr_machine_check = {
+    .name = "spapr_machine_check",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_fwnmi_needed,
+    .pre_save = spapr_fwnmi_pre_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
+        VMSTATE_INT32(mc_status, SpaprMachineState),
+        VMSTATE_BOOL(fwnmi_calls_registered, SpaprMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr = {
     .name = "spapr",
     .version_id = 3,
@@ -2001,6 +2041,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_large_decr,
         &vmstate_spapr_cap_ccf_assist,
         &vmstate_spapr_cap_fwnmi,
+        &vmstate_spapr_machine_check,
         NULL
     }
 };
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 54eaf28a9e..7092687fa0 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -43,6 +43,7 @@
 #include "qemu/main-loop.h"
 #include "hw/ppc/spapr_ovec.h"
 #include <libfdt.h>
+#include "migration/blocker.h"
 
 #define RTAS_LOG_VERSION_MASK                   0xff000000
 #define   RTAS_LOG_VERSION_6                    0x06000000
@@ -843,6 +844,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     CPUState *cs = CPU(cpu);
+    int ret;
+    Error *local_err = NULL;
 
     if (spapr->guest_machine_check_addr == -1) {
         /*
@@ -872,8 +875,23 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
             return;
         }
     }
-    spapr->mc_status = cpu->vcpu_id;
 
+    error_setg(&spapr->fwnmi_migration_blocker,
+               "Live migration not supported during machine check handling");
+    ret = migrate_add_blocker(spapr->fwnmi_migration_blocker, &local_err);
+    if (ret == -EBUSY) {
+        /*
+         * We don't want to abort so we let the migration to continue.
+         * In a rare case, the machine check handler will run on the target.
+         * Though this is not preferable, it is better than aborting
+         * the migration or killing the VM.
+         */
+        error_free(spapr->fwnmi_migration_blocker);
+        spapr->fwnmi_migration_blocker = NULL;
+        warn_report("Received a fwnmi while migration was in progress");
+    }
+
+    spapr->mc_status = cpu->vcpu_id;
     spapr_mce_dispatch_elog(cpu, recovered);
 }
 
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 54b142f35b..3409f6b896 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -50,6 +50,7 @@
 #include "hw/ppc/fdt.h"
 #include "target/ppc/mmu-hash64.h"
 #include "target/ppc/mmu-book3s-v3.h"
+#include "migration/blocker.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -448,6 +449,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
     spapr->mc_status = -1;
     qemu_cond_signal(&spapr->mc_delivery_cond);
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    migrate_del_blocker(spapr->fwnmi_migration_blocker);
+    error_free(spapr->fwnmi_migration_blocker);
+    spapr->fwnmi_migration_blocker = NULL;
 }
 
 static struct rtas_call {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a90e677cc3..ac246c8be3 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -220,6 +220,7 @@ struct SpaprMachineState {
     SpaprTpmProxy *tpm_proxy;
 
     bool fwnmi_calls_registered;
+    Error *fwnmi_migration_blocker;
 };
 
 #define H_SUCCESS         0
-- 
2.17.2


