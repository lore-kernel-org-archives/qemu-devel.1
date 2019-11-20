Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D532DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C2D22444
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C2D22444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOdk-0004RN-PT
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOP1-0003Jg-Vn
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1iXOP0-0003Vj-2P
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1iXOOz-0003SA-R5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:44:06 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAKBfwcm079157
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:44:04 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcendfxug-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:44:03 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 20 Nov 2019 11:44:00 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Nov 2019 11:43:56 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xAKBht9q31850772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Nov 2019 11:43:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8DD84C040;
 Wed, 20 Nov 2019 11:43:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BAA794C046;
 Wed, 20 Nov 2019 11:43:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.152.224.205])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Nov 2019 11:43:53 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/15] s390x: protvirt: Support unpack facility
Date: Wed, 20 Nov 2019 06:43:25 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120114334.2287-1-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112011-0020-0000-0000-0000038C55AF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112011-0021-0000-0000-000021E288E0
Message-Id: <20191120114334.2287-7-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_03:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=3 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200107
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
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
---
 hw/s390x/Makefile.objs              |   1 +
 hw/s390x/ipl.c                      |  33 ++++++++
 hw/s390x/ipl.h                      |   2 +
 hw/s390x/pv.c                       | 118 ++++++++++++++++++++++++++++
 hw/s390x/pv.h                       |  26 ++++++
 hw/s390x/s390-virtio-ccw.c          |  45 ++++++++---
 target/s390x/cpu_features_def.inc.h |   1 +
 7 files changed, 216 insertions(+), 10 deletions(-)
 create mode 100644 hw/s390x/pv.c
 create mode 100644 hw/s390x/pv.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index 94e57113d8..568bab9711 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -31,6 +31,7 @@ obj-y += tod-qemu.o
 obj-$(CONFIG_KVM) += tod-kvm.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
 obj-$(CONFIG_KVM) += s390-stattrib-kvm.o s390-mchk.o
+obj-$(CONFIG_KVM) += pv.o
 obj-y += s390-ccw.o
 obj-y += ap-device.o
 obj-y += ap-bridge.o
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index a077926f36..50501fcd27 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -33,6 +33,7 @@
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "exec/exec-all.h"
+#include "pv.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define LINUX_MAGIC_ADDR                0x010008UL
@@ -668,6 +669,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
     cpu_physical_memory_unmap(addr, len, 1, len);
 }
 
+int s390_ipl_prepare_pv_header(void)
+{
+    int rc;
+    IplParameterBlock *iplb = s390_ipl_get_iplb_secure();
+    IPLBlockPV *ipib_pv = &iplb->pv;
+    void *hdr = g_malloc(ipib_pv->pv_header_len);
+
+    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
+                             ipib_pv->pv_header_len);
+    rc = s390_pv_set_sec_parms((uint64_t)hdr,
+                               ipib_pv->pv_header_len);
+    g_free(hdr);
+    return rc;
+}
+
+int s390_ipl_pv_unpack(void)
+{
+    int i, rc;
+    IplParameterBlock *iplb = s390_ipl_get_iplb_secure();
+    IPLBlockPV *ipib_pv = &iplb->pv;
+
+    for (i = 0; i < ipib_pv->num_comp; i++) {
+        rc = s390_pv_unpack(ipib_pv->components[i].addr,
+                            TARGET_PAGE_ALIGN(ipib_pv->components[i].size),
+                            ipib_pv->components[i].tweak_pref);
+        if (rc) {
+            return rc;
+        }
+    }
+    return rc;
+}
+
 void s390_ipl_prepare_cpu(S390CPU *cpu)
 {
     S390IPLState *ipl = get_ipl_device();
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 7b8a493509..e848602c16 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -105,6 +105,8 @@ typedef union IplParameterBlock IplParameterBlock;
 int s390_ipl_set_loadparm(uint8_t *loadparm);
 int s390_ipl_pv_check_comp(IplParameterBlock *iplb);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
+int s390_ipl_prepare_pv_header(void);
+int s390_ipl_pv_unpack(void);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
 IplParameterBlock *s390_ipl_get_iplb_secure(void);
diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
new file mode 100644
index 0000000000..0218070322
--- /dev/null
+++ b/hw/s390x/pv.c
@@ -0,0 +1,118 @@
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
+        error_report("KVM PV command failed cmd: %d rc: %d", cmd, rc);
+        exit(1);
+    }
+    return rc;
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
+        error_report("KVM PV VCPU command failed cmd: %d rc: %d", cmd, rc);
+        exit(1);
+    }
+    return rc;
+}
+
+int s390_pv_vm_create(void)
+{
+    return s390_pv_cmd(KVM_PV_VM_CREATE, NULL);
+}
+
+int s390_pv_vm_destroy(void)
+{
+    return s390_pv_cmd(KVM_PV_VM_DESTROY, NULL);
+}
+
+int s390_pv_vcpu_create(CPUState *cs)
+{
+    return s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_CREATE, NULL);
+}
+
+int s390_pv_vcpu_destroy(CPUState *cs)
+{
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+    int rc;
+
+    rc = s390_pv_cmd_vcpu(cs, KVM_PV_VCPU_DESTROY, NULL);
+    if (!rc) {
+        env->pv = false;
+    }
+    return rc;
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
+int s390_pv_perf_clear_reset(void)
+{
+    return s390_pv_cmd(KVM_PV_VM_PERF_CLEAR_RESET, NULL);
+}
+
+int s390_pv_verify(void)
+{
+    return s390_pv_cmd(KVM_PV_VM_VERIFY, NULL);
+}
+
+int s390_pv_unshare(void)
+{
+    return s390_pv_cmd(KVM_PV_VM_UNSHARE, NULL);
+}
diff --git a/hw/s390x/pv.h b/hw/s390x/pv.h
new file mode 100644
index 0000000000..eb074e4bc9
--- /dev/null
+++ b/hw/s390x/pv.h
@@ -0,0 +1,26 @@
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
+int s390_pv_vm_create(void);
+int s390_pv_vm_destroy(void);
+int s390_pv_vcpu_destroy(CPUState *cs);
+int s390_pv_vcpu_create(CPUState *cs);
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
+int s390_pv_perf_clear_reset(void);
+int s390_pv_verify(void);
+int s390_pv_unshare(void);
+
+#endif /* HW_S390_PV_H */
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c1d1440272..7262453616 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -41,6 +41,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
 #include "sysemu/sysemu.h"
+#include "hw/s390x/pv.h"
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -322,6 +323,7 @@ static void s390_machine_reset(MachineState *machine)
 {
     enum s390_reset reset_type;
     CPUState *cs, *t;
+    S390CPU *cpu;
 
     /* get the reset parameters, reset them once done */
     s390_ipl_get_reset_request(&cs, &reset_type);
@@ -329,16 +331,10 @@ static void s390_machine_reset(MachineState *machine)
     /* all CPUs are paused and synchronized at this point */
     s390_cmma_reset();
 
-    switch (reset_type) {
-    case S390_RESET_EXTERNAL:
-    case S390_RESET_REIPL:
-        qemu_devices_reset();
-        s390_crypto_reset();
+    cpu = S390_CPU(cs);
 
-        /* configure and start the ipl CPU only */
-        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
-        break;
-    case S390_RESET_MODIFIED_CLEAR:
+    switch (reset_type) {
+    case S390_RESET_MODIFIED_CLEAR:  /* Subcode 0 */
         CPU_FOREACH(t) {
             run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
         }
@@ -346,7 +342,7 @@ static void s390_machine_reset(MachineState *machine)
         s390_crypto_reset();
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
-    case S390_RESET_LOAD_NORMAL:
+    case S390_RESET_LOAD_NORMAL: /* Subcode 1*/
         CPU_FOREACH(t) {
             if (t == cs) {
                 continue;
@@ -357,6 +353,35 @@ static void s390_machine_reset(MachineState *machine)
         run_on_cpu(cs, s390_do_cpu_initial_reset, RUN_ON_CPU_NULL);
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
+    case S390_RESET_EXTERNAL:
+    case S390_RESET_REIPL: /* Subcode 4 */
+        qemu_devices_reset();
+        s390_crypto_reset();
+        /* configure and start the ipl CPU only */
+        run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
+        break;
+    case S390_RESET_PV: /* Subcode 10 */
+        subsystem_reset();
+        s390_crypto_reset();
+
+        CPU_FOREACH(t) {
+            run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
+        }
+
+        /* Create SE VM */
+        s390_pv_vm_create();
+        CPU_FOREACH(t) {
+            s390_pv_vcpu_create(t);
+        }
+
+        /* Set SE header and unpack */
+        s390_ipl_prepare_pv_header();
+        /* Decrypt image */
+        s390_ipl_pv_unpack();
+        /* Verify integrity */
+        s390_pv_verify();
+        s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
+        break;
     default:
         g_assert_not_reached();
     }
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


