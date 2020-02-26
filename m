Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF03C4BA10
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E54120838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E54120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43439 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vhK-0004I8-4u
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j6vgQ-0002Lv-Ur
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j6vgP-0007r9-I7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:20:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j6vgP-0007q5-Ax
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:20:57 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QCKKtD106270
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:20:56 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydcp4myj9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:20:56 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 26 Feb 2020 12:20:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Feb 2020 12:20:51 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01QCKoGH51511312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 12:20:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6D8C11C05C;
 Wed, 26 Feb 2020 12:20:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D74E911C058;
 Wed, 26 Feb 2020 12:20:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.212])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 12:20:49 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/18] s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
Date: Wed, 26 Feb 2020 07:20:26 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226122038.61481-1-frankja@linux.ibm.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022612-4275-0000-0000-000003A5A102
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022612-4276-0000-0000-000038B9B94C
Message-Id: <20200226122038.61481-7-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_04:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=1 mlxlogscore=880 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260092
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we now have access to the protection state of the cpus, we can
implement special handling of diag 308 subcodes for cpus in the
protected state.

For subcodes 0 and 1 we need to unshare all pages before continuing,
so the guest doesn't accidentally expose data when dumping.

For subcode 3/4 we tear down the protected VM and reboot into
unprotected mode. We do not provide a secure reboot.

Before we can do the unshare calls, we need to mark all cpus as
stopped.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 37 ++++++++++++++++++++++++++++++++++---
 target/s390x/diag.c        |  4 ++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 79f472c309..9983165b05 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -335,6 +335,7 @@ static void s390_machine_unprotect(S390CcwMachineState *ms)
         }
         ms->pv = false;
     }
+    migrate_del_blocker(pv_mig_blocker);
 }
 
 static int s390_machine_protect(S390CcwMachineState *ms)
@@ -396,12 +397,27 @@ static void s390_machine_inject_pv_error(CPUState *cs)
     env->regs[r1 + 1] = 0xa02;
 }
 
+static void s390_pv_prepare_reset(CPUS390XState *env)
+{
+    CPUState *cs;
+
+    if (!env->pv) {
+        return;
+    }
+    CPU_FOREACH(cs) {
+        s390_cpu_set_state(S390_CPU_STATE_STOPPED, S390_CPU(cs));
+    }
+    s390_pv_unshare();
+    s390_pv_perf_clear_reset();
+}
+
 static void s390_machine_reset(MachineState *machine)
 {
     enum s390_reset reset_type;
     CPUState *cs, *t;
     S390CPU *cpu;
     S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
+    CPUS390XState *env;
 
     /* get the reset parameters, reset them once done */
     s390_ipl_get_reset_request(&cs, &reset_type);
@@ -410,10 +426,15 @@ static void s390_machine_reset(MachineState *machine)
     s390_cmma_reset();
 
     cpu = S390_CPU(cs);
+    env = &cpu->env;
 
     switch (reset_type) {
     case S390_RESET_EXTERNAL:
     case S390_RESET_REIPL:
+        if (ms->pv) {
+            s390_machine_unprotect(ms);
+        }
+
         qemu_devices_reset();
         s390_crypto_reset();
 
@@ -421,21 +442,31 @@ static void s390_machine_reset(MachineState *machine)
         run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
         break;
     case S390_RESET_MODIFIED_CLEAR:
+        /*
+         * Susbsystem reset needs to be done before we unshare memory
+         * and loose access to VIRTIO structures in guest memory.
+         */
+        subsystem_reset();
+        s390_crypto_reset();
+        s390_pv_prepare_reset(env);
         CPU_FOREACH(t) {
             run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
         }
-        subsystem_reset();
-        s390_crypto_reset();
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
     case S390_RESET_LOAD_NORMAL:
+        /*
+         * Susbsystem reset needs to be done before we unshare memory
+         * and loose access to VIRTIO structures in guest memory.
+         */
+        subsystem_reset();
+        s390_pv_prepare_reset(env);
         CPU_FOREACH(t) {
             if (t == cs) {
                 continue;
             }
             run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
         }
-        subsystem_reset();
         run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index d6ceb1f75d..840335d40a 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -68,6 +68,10 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
                               uintptr_t ra, bool write)
 {
+    /* Handled by the Ultravisor */
+    if (env->pv) {
+        return 0;
+    }
     if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return -1;
-- 
2.20.1


