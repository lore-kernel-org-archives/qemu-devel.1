Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A15C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD1B24654
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD1B24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lTW-0006EM-RZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j4lOh-0005y2-Si
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j4lOg-0006UJ-HR
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:57:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j4lOg-0006Tp-9Q
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 07:57:42 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01KCt3t3092887
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:57:41 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubv5w3u-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:57:41 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Thu, 20 Feb 2020 12:57:39 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Feb 2020 12:57:37 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01KCuej037355844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Feb 2020 12:56:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33E0DAE057;
 Thu, 20 Feb 2020 12:57:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1414BAE045;
 Thu, 20 Feb 2020 12:57:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.185.143])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Feb 2020 12:57:34 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/16] s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
Date: Thu, 20 Feb 2020 07:56:27 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220125638.7241-1-frankja@linux.ibm.com>
References: <20200220125638.7241-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022012-0028-0000-0000-000003DCC0B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022012-0029-0000-0000-000024A1D0A3
Message-Id: <20200220125638.7241-6-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-20_03:2020-02-19,
 2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=784 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200097
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com
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
index 6fba8d9331..48dd3170ab 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -384,6 +384,20 @@ static void s390_machine_inject_pv_error(CPUState *cs)
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
@@ -391,6 +405,7 @@ static void s390_machine_reset(MachineState *machine)
     S390CPU *cpu;
     S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
     static Error *local_err;
+    CPUS390XState *env;
 
     /* get the reset parameters, reset them once done */
     s390_ipl_get_reset_request(&cs, &reset_type);
@@ -399,10 +414,16 @@ static void s390_machine_reset(MachineState *machine)
     s390_cmma_reset();
 
     cpu = S390_CPU(cs);
+    env = &cpu->env;
 
     switch (reset_type) {
     case S390_RESET_EXTERNAL:
     case S390_RESET_REIPL:
+        if (ms->pv) {
+            s390_machine_unprotect(ms);
+            migrate_del_blocker(pv_mig_blocker);
+        }
+
         qemu_devices_reset();
         s390_crypto_reset();
 
@@ -410,21 +431,31 @@ static void s390_machine_reset(MachineState *machine)
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
index 5e77d85652..aedc774695 100644
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


