Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C2CC4741C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDA92168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDA92168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ckv-0003YU-PQ
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1j2ciO-0006ii-91
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1j2ciM-00063D-4K
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15196
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1j2ciM-00062z-01
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:17:10 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01EFH47u001046
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:17:09 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j8d25hj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:17:07 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Fri, 14 Feb 2020 15:17:04 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Feb 2020 15:17:02 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01EFH1Np57081868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2020 15:17:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DE09A4059;
 Fri, 14 Feb 2020 15:17:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E58E0A4053;
 Fri, 14 Feb 2020 15:16:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.191.187])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 14 Feb 2020 15:16:59 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/17] s390x: protvirt: Support unpack facility
Date: Fri, 14 Feb 2020 10:16:24 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214151636.8764-1-frankja@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021415-0028-0000-0000-000003DA8A46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021415-0029-0000-0000-0000249F053C
Message-Id: <20200214151636.8764-6-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-14_04:2020-02-12,
 2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=3 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140121
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
Cc: mihajlov@linux.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a guest has saved a ipib of type 5 and call diagnose308 with
subcode 10, we have to setup the protected processing environment via
Ultravisor calls. The calls are done by KVM and are exposed via an API.

The following steps are necessary:
1. Create a VM (register it with the Ultravisor)
2. Create secure CPUs for all of our current cpus
3. Forward the secure header to the Ultravisor (has all information on
how to decrypt the image and VM information)
4. Protect image pages from the host and decrypt them
5. Verify the image integrity

Only after step 5 a protected VM is allowed to run.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
to machine]
---
 hw/s390x/Makefile.objs              |   1 +
 hw/s390x/ipl.c                      |  32 ++++++
 hw/s390x/ipl.h                      |   2 +
 hw/s390x/pv.c                       | 154 ++++++++++++++++++++++++++++
 hw/s390x/pv.h                       |  38 +++++++
 hw/s390x/s390-virtio-ccw.c          |  79 ++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h  |   1 +
 target/s390x/cpu.c                  |   4 +
 target/s390x/cpu.h                  |   1 +
 target/s390x/cpu_features_def.inc.h |   1 +
 10 files changed, 313 insertions(+)
 create mode 100644 hw/s390x/pv.c
 create mode 100644 hw/s390x/pv.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index e02ed80b68..a46a1c7894 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -31,6 +31,7 @@ obj-y += tod-qemu.o
 obj-$(CONFIG_KVM) += tod-kvm.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
 obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
+obj-$(CONFIG_KVM) += pv.o
 obj-y += s390-ccw.o
 obj-y += ap-device.o
 obj-y += ap-bridge.o
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index db97a888ff..3290832f1e 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -33,6 +33,7 @@
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "exec/exec-all.h"
+#include "pv.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define LINUX_MAGIC_ADDR                0x010008UL
@@ -677,6 +678,37 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
     cpu_physical_memory_unmap(addr, len, 1, len);
 }
 
+int s390_ipl_prepare_pv_header(void)
+{
+    S390IPLState *ipl = get_ipl_device();
+    IPLBlockPV *ipib_pv = &ipl->iplb_pbt5.pv;
+    void *hdr = g_malloc(ipib_pv->pv_header_len);
+    int rc;
+
+    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
+                             ipib_pv->pv_header_len);
+    rc = s390_pv_set_sec_parms((uint64_t)hdr,
+                          ipib_pv->pv_header_len);
+    g_free(hdr);
+    return rc;
+}
+
+int s390_ipl_pv_unpack(void)
+{
+    int i, rc;
+    S390IPLState *ipl = get_ipl_device();
+    IPLBlockPV *ipib_pv = &ipl->iplb_pbt5.pv;
+
+    for (i = 0; i < ipib_pv->num_comp; i++) {
+        rc = s390_pv_unpack(ipib_pv->components[i].addr,
+                            TARGET_PAGE_ALIGN(ipib_pv->components[i].size),
+                            ipib_pv->components[i].tweak_pref);
+        if (rc)
+            return rc;
+    }
+    return 0;
+}
+
 void s390_ipl_prepare_cpu(S390CPU *cpu)
 {
     S390IPLState *ipl = get_ipl_device();
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index d0b8d90fa4..b5a13012ff 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -104,6 +104,8 @@ typedef union IplParameterBlock IplParameterBlock;
 int s390_ipl_set_loadparm(uint8_t *loadparm);
 int s390_ipl_pv_check_components(IplParameterBlock *iplb);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
+int s390_ipl_prepare_pv_header(void);
+int s390_ipl_pv_unpack(void);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
 IplParameterBlock *s390_ipl_get_iplb_secure(void);
diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
new file mode 100644
index 0000000000..5b6a26cba9
--- /dev/null
+++ b/hw/s390x/pv.c
@@ -0,0 +1,154 @@
+/*
+ * Secure execution functions
+ *
+ * Copyright IBM Corp. 2019
+ * Author(s):
+ *  Janosch Frank <frankja@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include <linux/kvm.h>
+
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+#include "pv.h"
+
+const char* cmd_names[] = {
+    "VM_CREATE",
+    "VM_DESTROY",
+    "VM_SET_SEC_PARAMS",
+    "VM_UNPACK",
+    "VM_VERIFY",
+    "VM_PREP_RESET",
+    "VM_UNSHARE_ALL",
+    "VCPU_CREATE",
+    "VCPU_DESTROY",
+    NULL
+};
+
+static int s390_pv_cmd(uint32_t cmd, void *data)
+{
+    int rc;
+    struct kvm_pv_cmd pv_cmd = {
+        .cmd = cmd,
+        .data = (uint64_t)data,
+    };
+
+    rc = kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
+    if (rc) {
+        error_report("KVM PV command %d (%s) failed: header rc %x rrc %x "
+                     "IOCTL rc: %d", cmd, cmd_names[cmd], pv_cmd.rc, pv_cmd.rrc,
+                     rc);
+    }
+    return rc;
+}
+
+static void s390_pv_cmd_exit(uint32_t cmd, void *data)
+{
+    int rc;
+
+    rc = s390_pv_cmd(cmd, data);
+    if (rc) {
+        exit(1);
+    }
+}
+
+static int s390_pv_cmd_vcpu(CPUState *cs, uint32_t cmd, void *data)
+{
+    int rc;
+    struct kvm_pv_cmd pv_cmd = {
+        .cmd = cmd,
+        .data = (uint64_t)data,
+    };
+
+    rc = kvm_vcpu_ioctl(cs, KVM_S390_PV_COMMAND_VCPU, &pv_cmd);
+    if (rc) {
+        error_report("KVM PV VCPU command %d (%s) failed header: rc %x rrc %x "
+                     "IOCTL rc: %d", cmd, cmd_names[cmd], pv_cmd.rc, pv_cmd.rrc,
+                     rc);
+    }
+    return rc;
+}
+
+static void s390_pv_cmd_vcpu_exit(CPUState *cs, uint32_t cmd, void *data)
+{
+    int rc;
+
+    rc = s390_pv_cmd_vcpu(cs, cmd, data);
+    if (rc) {
+        exit(1);
+    }
+
+}
+
+int s390_pv_vm_create(void)
+{
+    return s390_pv_cmd(KVM_PV_VM_CREATE, NULL);
+}
+
+void s390_pv_vm_destroy(void)
+{
+     s390_pv_cmd_exit(KVM_PV_VM_DESTROY, NULL);
+}
+
+int s390_pv_vcpu_create(CPUState *cs)
+{
+    int rc;
+
+    rc = s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_CREATE, NULL);
+    if (!rc) {
+        S390_CPU(cs)->env.pv = true;
+    }
+
+    return rc;
+}
+
+void s390_pv_vcpu_destroy(CPUState *cs)
+{
+    s390_pv_cmd_vcpu_exit(cs, KVM_PV_VCPU_DESTROY, NULL);
+    S390_CPU(cs)->env.pv = false;
+}
+
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
+{
+    struct kvm_s390_pv_sec_parm args = {
+        .origin = origin,
+        .length = length,
+    };
+
+    return s390_pv_cmd(KVM_PV_VM_SET_SEC_PARMS, &args);
+}
+
+/*
+ * Called for each component in the SE type IPL parameter block 0.
+ */
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak)
+{
+    struct kvm_s390_pv_unp args = {
+        .addr = addr,
+        .size = size,
+        .tweak = tweak,
+    };
+
+    return s390_pv_cmd(KVM_PV_VM_UNPACK, &args);
+}
+
+void s390_pv_perf_clear_reset(void)
+{
+    s390_pv_cmd_exit(KVM_PV_VM_PREP_RESET, NULL);
+}
+
+int s390_pv_verify(void)
+{
+    return s390_pv_cmd(KVM_PV_VM_VERIFY, NULL);
+}
+
+void s390_pv_unshare(void)
+{
+    s390_pv_cmd_exit(KVM_PV_VM_UNSHARE_ALL, NULL);
+}
diff --git a/hw/s390x/pv.h b/hw/s390x/pv.h
new file mode 100644
index 0000000000..7d20bdd12e
--- /dev/null
+++ b/hw/s390x/pv.h
@@ -0,0 +1,38 @@
+/*
+ * Protected Virtualization header
+ *
+ * Copyright IBM Corp. 2019
+ * Author(s):
+ *  Janosch Frank <frankja@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_PV_H
+#define HW_S390_PV_H
+
+#ifdef CONFIG_KVM
+int s390_pv_vm_create(void);
+void s390_pv_vm_destroy(void);
+void s390_pv_vcpu_destroy(CPUState *cs);
+int s390_pv_vcpu_create(CPUState *cs);
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
+void s390_pv_perf_clear_reset(void);
+int s390_pv_verify(void);
+void s390_pv_unshare(void);
+#else
+int s390_pv_vm_create(void) { return 0; }
+void s390_pv_vm_destroy(void) {}
+void s390_pv_vcpu_destroy(CPUState *cs) {}
+int s390_pv_vcpu_create(CPUState *cs) { return 0; }
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length) { return 0; }
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) { return 0: }
+void s390_pv_perf_clear_reset(void) {}
+int s390_pv_verify(void) { return 0; }
+void s390_pv_unshare(void) {}
+#endif
+
+#endif /* HW_S390_PV_H */
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e759eb5f83..5fa4372083 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -41,6 +41,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
 #include "sysemu/sysemu.h"
+#include "hw/s390x/pv.h"
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -240,9 +241,11 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
 static void ccw_init(MachineState *machine)
 {
     int ret;
+    S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
     VirtualCssBus *css_bus;
     DeviceState *dev;
 
+    ms->pv = false;
     s390_sclp_init();
     /* init memory + setup max page size. Required for the CPU model */
     s390_memory_init(machine->ram_size);
@@ -318,10 +321,58 @@ static inline void s390_do_cpu_ipl(CPUState *cs, run_on_cpu_data arg)
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
 
+static int s390_machine_pv_secure(S390CcwMachineState *ms)
+{
+    CPUState *t;
+    int rc;
+
+    /* Create SE VM */
+    rc = s390_pv_vm_create();
+    if (rc) {
+        return rc;
+    }
+
+    CPU_FOREACH(t) {
+        rc = s390_pv_vcpu_create(t);
+        if (rc) {
+            return rc;
+        }
+    }
+
+    ms->pv = true;
+
+    /* Set SE header and unpack */
+    rc = s390_ipl_prepare_pv_header();
+    if (rc) {
+        return rc;
+    }
+
+    /* Decrypt image */
+    rc = s390_ipl_pv_unpack();
+    if (rc) {
+        return rc;
+    }
+
+    /* Verify integrity */
+    rc = s390_pv_verify();
+    return rc;
+}
+
+static void s390_machine_inject_pv_error(CPUState *cs)
+{
+    int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
+    CPUS390XState *env = &S390_CPU(cs)->env;
+
+    /* Report that we are unable to enter protected mode */
+    env->regs[r1 + 1] = 0xa02;
+}
+
 static void s390_machine_reset(MachineState *machine)
 {
     enum s390_reset reset_type;
     CPUState *cs, *t;
+    S390CPU *cpu;
+    S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
 
     /* get the reset parameters, reset them once done */
     s390_ipl_get_reset_request(&cs, &reset_type);
@@ -329,6 +380,8 @@ static void s390_machine_reset(MachineState *machine)
     /* all CPUs are paused and synchronized at this point */
     s390_cmma_reset();
 
+    cpu = S390_CPU(cs);
+
     switch (reset_type) {
     case S390_RESET_EXTERNAL:
     case S390_RESET_REIPL:
@@ -355,6 +408,32 @@ static void s390_machine_reset(MachineState *machine)
         }
         subsystem_reset();
         run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
+        run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
+        break;
+    case S390_RESET_PV: /* Subcode 10 */
+        subsystem_reset();
+        s390_crypto_reset();
+
+        CPU_FOREACH(t) {
+            if (t == cs) {
+                continue;
+            }
+            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
+        }
+        run_on_cpu(cs, s390_do_cpu_reset, RUN_ON_CPU_NULL);
+
+        if (s390_machine_pv_secure(ms)) {
+            CPU_FOREACH(t) {
+                s390_pv_vcpu_destroy(t);
+            }
+            s390_pv_vm_destroy();
+            ms->pv = false;
+
+            s390_machine_inject_pv_error(cs);
+            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
+            return;
+        }
+
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
     default:
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 8aa27199c9..cd1dccc6e3 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -28,6 +28,7 @@ typedef struct S390CcwMachineState {
     /*< public >*/
     bool aes_key_wrap;
     bool dea_key_wrap;
+    bool pv;
     uint8_t loadparm[8];
 } S390CcwMachineState;
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 8da1905485..1dbd84b9d7 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -37,6 +37,8 @@
 #include "sysemu/hw_accel.h"
 #include "hw/qdev-properties.h"
 #ifndef CONFIG_USER_ONLY
+#include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/s390x/pv.h"
 #include "hw/boards.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
@@ -191,6 +193,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #if !defined(CONFIG_USER_ONLY)
     MachineState *ms = MACHINE(qdev_get_machine());
+    S390CcwMachineState *ccw = S390_CCW_MACHINE(ms);
     unsigned int max_cpus = ms->smp.max_cpus;
     if (cpu->env.core_id >= max_cpus) {
         error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
@@ -205,6 +208,7 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
         goto out;
     }
 
+    cpu->env.pv = ccw->pv;
     /* sync cs->cpu_index and env->core_id. The latter is needed for TCG. */
     cs->cpu_index = cpu->env.core_id;
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8a557fd8d1..cbc53c99cf 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -114,6 +114,7 @@ struct CPUS390XState {
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
+    bool pv; /* protected virtualization */
 
 #if !defined(CONFIG_USER_ONLY)
     uint32_t core_id; /* PoP "CPU address", same as cpu_index */
diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.inc.h
index 31dff0d84e..60db28351d 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -107,6 +107,7 @@ DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, "Deflate-conversion facility (
 DEF_FEAT(VECTOR_PACKED_DECIMAL_ENH, "vxpdeh", STFL, 152, "Vector-Packed-Decimal-Enhancement Facility")
 DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)")
 DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
+DEF_FEAT(UNPACK, "unpack", STFL, 161, "Unpack facility")
 
 /* Features exposed via SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
 DEF_FEAT(SIE_GSLS, "gsls", SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit-suppression facility")
-- 
2.20.1


