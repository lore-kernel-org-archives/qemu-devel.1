Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FCFC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C0420873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C0420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1PD-00058J-Ss
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jC1Lf-0007qV-El
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jC1Lc-00078F-Eu
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:24:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jC1Lc-000778-6h
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:24:32 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02BDO6CL082672
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 09:24:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ypxbk4v5x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 09:24:23 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Wed, 11 Mar 2020 13:22:13 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 11 Mar 2020 13:22:11 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02BDMAip55115846
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2020 13:22:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADD1F52054;
 Wed, 11 Mar 2020 13:22:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.36.208])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4E0625204E;
 Wed, 11 Mar 2020 13:22:09 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 02/15] s390x: protvirt: Support unpack facility
Date: Wed, 11 Mar 2020 09:21:38 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311132151.172389-1-frankja@linux.ibm.com>
References: <20200311132151.172389-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031113-4275-0000-0000-000003AAA24B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031113-4276-0000-0000-000038BFBE6B
Message-Id: <20200311132151.172389-3-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-03-11_05:2020-03-11,
 2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110085
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

The unpack facility provides the means to setup a protected guest. A
protected guest cannot be introspected by the hypervisor or any
user/administrator of the machine it is running on.

Protected guests are encrypted at rest and need a special boot
mechanism via diag308 subcode 8 and 10.

Code 8 sets the PV specific IPLB which is retained separately from
those set via code 5.

Code 10 is used to unpack the VM into protected memory, verify its
integrity and start it.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Co-developed-by: Christian Borntraeger <borntraeger@de.ibm.com> [Changes
to machine]
---
 hw/s390x/Makefile.objs              |   1 +
 hw/s390x/ipl.c                      |  56 +++++++++++++-
 hw/s390x/ipl.h                      |  79 +++++++++++++++++++
 hw/s390x/pv.c                       |  98 +++++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c          | 116 +++++++++++++++++++++++++++-
 include/hw/s390x/pv.h               |  57 ++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h  |   1 +
 target/s390x/cpu.c                  |   2 +
 target/s390x/cpu_features_def.inc.h |   1 +
 target/s390x/diag.c                 |  31 +++++++-
 10 files changed, 436 insertions(+), 6 deletions(-)
 create mode 100644 hw/s390x/pv.c
 create mode 100644 include/hw/s390x/pv.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index e02ed80b6829a511..a46a1c7894e0f612 100644
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
index b81942e1e6f9002e..98df89e62c25f583 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -27,6 +27,7 @@
 #include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/ebcdic.h"
+#include "hw/s390x/pv.h"
 #include "ipl.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
@@ -566,12 +567,31 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
 {
     S390IPLState *ipl = get_ipl_device();
 
-    ipl->iplb = *iplb;
-    ipl->iplb_valid = true;
+    /*
+     * The IPLB set and retrieved by subcodes 8/9 is completely
+     * separate from the one managed via subcodes 5/6.
+     */
+    if (iplb->pbt == S390_IPL_TYPE_PV) {
+        ipl->iplb_pv = *iplb;
+        ipl->iplb_valid_pv = true;
+    } else {
+        ipl->iplb = *iplb;
+        ipl->iplb_valid = true;
+    }
     ipl->netboot = is_virtio_net_device(iplb);
     update_machine_ipl_properties(iplb);
 }
 
+IplParameterBlock *s390_ipl_get_iplb_pv(void)
+{
+    S390IPLState *ipl = get_ipl_device();
+
+    if (!ipl->iplb_valid_pv) {
+        return NULL;
+    }
+    return &ipl->iplb_pv;
+}
+
 IplParameterBlock *s390_ipl_get_iplb(void)
 {
     S390IPLState *ipl = get_ipl_device();
@@ -660,6 +680,38 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
     cpu_physical_memory_unmap(addr, len, 1, len);
 }
 
+int s390_ipl_prepare_pv_header(void)
+{
+    IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
+    IPLBlockPV *ipib_pv = &ipib->pv;
+    void *hdr = g_malloc(ipib_pv->pv_header_len);
+    int rc;
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
+    IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
+    IPLBlockPV *ipib_pv = &ipib->pv;
+    int i, rc = 0;
+
+    for (i = 0; i < ipib_pv->num_comp; i++) {
+        rc = s390_pv_unpack(ipib_pv->components[i].addr,
+                            TARGET_PAGE_ALIGN(ipib_pv->components[i].size),
+                            ipib_pv->components[i].tweak_pref);
+        if (rc) {
+            break;
+        }
+    }
+    return rc;
+}
+
 void s390_ipl_prepare_cpu(S390CPU *cpu)
 {
     S390IPLState *ipl = get_ipl_device();
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 3e44abe1c651d8a0..919f9e69131b5207 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -15,6 +15,24 @@
 #include "cpu.h"
 #include "hw/qdev-core.h"
 
+struct IPLBlockPVComp {
+    uint64_t tweak_pref;
+    uint64_t addr;
+    uint64_t size;
+} QEMU_PACKED;
+typedef struct IPLBlockPVComp IPLBlockPVComp;
+
+struct IPLBlockPV {
+    uint8_t  reserved18[87];    /* 0x18 */
+    uint8_t  version;           /* 0x6f */
+    uint32_t reserved70;        /* 0x70 */
+    uint32_t num_comp;          /* 0x74 */
+    uint64_t pv_header_addr;    /* 0x78 */
+    uint64_t pv_header_len;     /* 0x80 */
+    struct IPLBlockPVComp components[];
+} QEMU_PACKED;
+typedef struct IPLBlockPV IPLBlockPV;
+
 struct IplBlockCcw {
     uint8_t  reserved0[85];
     uint8_t  ssid;
@@ -71,6 +89,7 @@ union IplParameterBlock {
         union {
             IplBlockCcw ccw;
             IplBlockFcp fcp;
+            IPLBlockPV pv;
             IplBlockQemuScsi scsi;
         };
     } QEMU_PACKED;
@@ -85,8 +104,11 @@ typedef union IplParameterBlock IplParameterBlock;
 
 int s390_ipl_set_loadparm(uint8_t *loadparm);
 void s390_ipl_update_diag308(IplParameterBlock *iplb);
+int s390_ipl_prepare_pv_header(void);
+int s390_ipl_pv_unpack(void);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
+IplParameterBlock *s390_ipl_get_iplb_pv(void);
 
 enum s390_reset {
     /* default is a reset not triggered by a CPU e.g. issued by QMP */
@@ -94,6 +116,7 @@ enum s390_reset {
     S390_RESET_REIPL,
     S390_RESET_MODIFIED_CLEAR,
     S390_RESET_LOAD_NORMAL,
+    S390_RESET_PV,
 };
 void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type);
 void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type);
@@ -133,6 +156,7 @@ struct S390IPLState {
     /*< private >*/
     DeviceState parent_obj;
     IplParameterBlock iplb;
+    IplParameterBlock iplb_pv;
     QemuIplParameters qipl;
     uint64_t start_addr;
     uint64_t compat_start_addr;
@@ -140,6 +164,7 @@ struct S390IPLState {
     uint64_t compat_bios_start_addr;
     bool enforce_bios;
     bool iplb_valid;
+    bool iplb_valid_pv;
     bool netboot;
     /* reset related properties don't have to be migrated or reset */
     enum s390_reset reset_type;
@@ -161,9 +186,11 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 
 #define S390_IPL_TYPE_FCP 0x00
 #define S390_IPL_TYPE_CCW 0x02
+#define S390_IPL_TYPE_PV 0x05
 #define S390_IPL_TYPE_QEMU_SCSI 0xff
 
 #define S390_IPLB_HEADER_LEN 8
+#define S390_IPLB_MIN_PV_LEN 148
 #define S390_IPLB_MIN_CCW_LEN 200
 #define S390_IPLB_MIN_FCP_LEN 384
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
@@ -173,6 +200,50 @@ static inline bool iplb_valid_len(IplParameterBlock *iplb)
     return be32_to_cpu(iplb->len) <= sizeof(IplParameterBlock);
 }
 
+static inline bool ipl_valid_pv_components(IplParameterBlock *iplb)
+{
+    IPLBlockPV *ipib_pv = &iplb->pv;
+    int i;
+
+    if (ipib_pv->num_comp == 0) {
+        return false;
+    }
+
+    for (i = 0; i < ipib_pv->num_comp; i++) {
+        /* Addr must be 4k aligned */
+        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
+            return false;
+        }
+
+        /* Tweak prefix is monotonically increasing with each component */
+        if (i < ipib_pv->num_comp - 1 &&
+            ipib_pv->components[i].tweak_pref >=
+            ipib_pv->components[i + 1].tweak_pref) {
+            return false;
+        }
+    }
+    return true;
+}
+
+static inline bool ipl_valid_pv_header(IplParameterBlock *iplb)
+{
+        IPLBlockPV *ipib_pv = &iplb->pv;
+
+        if (ipib_pv->pv_header_len > 2 * TARGET_PAGE_SIZE) {
+            return false;
+        }
+
+        if (!address_space_access_valid(&address_space_memory,
+                                        ipib_pv->pv_header_addr,
+                                        ipib_pv->pv_header_len,
+                                        false,
+                                        MEMTXATTRS_UNSPECIFIED)) {
+            return false;
+        }
+
+        return true;
+}
+
 static inline bool iplb_valid(IplParameterBlock *iplb)
 {
     switch (iplb->pbt) {
@@ -180,6 +251,14 @@ static inline bool iplb_valid(IplParameterBlock *iplb)
         return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_FCP_LEN;
     case S390_IPL_TYPE_CCW:
         return be32_to_cpu(iplb->len) >= S390_IPLB_MIN_CCW_LEN;
+    case S390_IPL_TYPE_PV:
+        if (be32_to_cpu(iplb->len) < S390_IPLB_MIN_PV_LEN) {
+            return false;
+        }
+        if (!ipl_valid_pv_header(iplb)) {
+            return false;
+        }
+        return ipl_valid_pv_components(iplb);
     default:
         return false;
     }
diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
new file mode 100644
index 0000000000000000..8cf5cd2c9bcd48b0
--- /dev/null
+++ b/hw/s390x/pv.c
@@ -0,0 +1,98 @@
+/*
+ * Protected Virtualization functions
+ *
+ * Copyright IBM Corp. 2020
+ * Author(s):
+ *  Janosch Frank <frankja@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#include "qemu/osdep.h"
+
+#include <linux/kvm.h>
+
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+#include "hw/s390x/pv.h"
+
+static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
+{
+    struct kvm_pv_cmd pv_cmd = {
+        .cmd = cmd,
+        .data = (uint64_t)data,
+    };
+    int rc = kvm_vm_ioctl(kvm_state, KVM_S390_PV_COMMAND, &pv_cmd);
+
+    if (rc) {
+        error_report("KVM PV command %d (%s) failed: header rc %x rrc %x "
+                     "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.rrc,
+                     rc);
+    }
+    return rc;
+}
+
+/*
+ * This macro lets us pass the command as a string to the function so
+ * we can print it on an error.
+ */
+#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data);
+#define s390_pv_cmd_exit(cmd, data)    \
+{                                      \
+    int rc;                            \
+                                       \
+    rc = __s390_pv_cmd(cmd, #cmd, data);\
+    if (rc) {                          \
+        exit(1);                       \
+    }                                  \
+}
+
+int s390_pv_vm_enable(void)
+{
+    return s390_pv_cmd(KVM_PV_ENABLE, NULL);
+}
+
+void s390_pv_vm_disable(void)
+{
+     s390_pv_cmd_exit(KVM_PV_DISABLE, NULL);
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
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 895498cca6199c16..9569b777a0e1abd6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -41,6 +41,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/tod.h"
 #include "sysemu/sysemu.h"
+#include "hw/s390x/pv.h"
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -316,10 +317,79 @@ static inline void s390_do_cpu_ipl(CPUState *cs, run_on_cpu_data arg)
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
 }
 
+static void s390_machine_unprotect(S390CcwMachineState *ms)
+{
+    s390_pv_vm_disable();
+    ms->pv = false;
+}
+
+static int s390_machine_protect(S390CcwMachineState *ms)
+{
+    int rc;
+
+    /* Create SE VM */
+    rc = s390_pv_vm_enable();
+    if (rc) {
+        return rc;
+    }
+
+    ms->pv = true;
+
+    /* Set SE header and unpack */
+    rc = s390_ipl_prepare_pv_header();
+    if (rc) {
+        goto out_err;
+    }
+
+    /* Decrypt image */
+    rc = s390_ipl_pv_unpack();
+    if (rc) {
+        goto out_err;
+    }
+
+    /* Verify integrity */
+    rc = s390_pv_verify();
+    if (rc) {
+        goto out_err;
+    }
+    return rc;
+
+out_err:
+    s390_machine_unprotect(ms);
+    return rc;
+}
+
+#define DIAG_308_RC_INVAL_FOR_PV    0x0a02
+static void s390_machine_inject_pv_error(CPUState *cs)
+{
+    int r1 = (cs->kvm_run->s390_sieic.ipa & 0x00f0) >> 4;
+    CPUS390XState *env = &S390_CPU(cs)->env;
+
+    /* Report that we are unable to enter protected mode */
+    env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
+}
+
+static void s390_pv_prepare_reset(S390CcwMachineState *ms)
+{
+    CPUState *cs;
+
+    if (!s390_is_pv()) {
+        return;
+    }
+    /* Unsharing requires all cpus to be stopped */
+    CPU_FOREACH(cs) {
+        s390_cpu_set_state(S390_CPU_STATE_STOPPED, S390_CPU(cs));
+    }
+    s390_pv_unshare();
+    s390_pv_perf_clear_reset();
+}
+
 static void s390_machine_reset(MachineState *machine)
 {
+    S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
     enum s390_reset reset_type;
     CPUState *cs, *t;
+    S390CPU *cpu;
 
     /* get the reset parameters, reset them once done */
     s390_ipl_get_reset_request(&cs, &reset_type);
@@ -327,9 +397,15 @@ static void s390_machine_reset(MachineState *machine)
     /* all CPUs are paused and synchronized at this point */
     s390_cmma_reset();
 
+    cpu = S390_CPU(cs);
+
     switch (reset_type) {
     case S390_RESET_EXTERNAL:
     case S390_RESET_REIPL:
+        if (s390_is_pv()) {
+            s390_machine_unprotect(ms);
+        }
+
         qemu_devices_reset();
         s390_crypto_reset();
 
@@ -337,22 +413,56 @@ static void s390_machine_reset(MachineState *machine)
         run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
         break;
     case S390_RESET_MODIFIED_CLEAR:
+        /*
+         * Susbsystem reset needs to be done before we unshare memory
+         * and loose access to VIRTIO structures in guest memory.
+         */
+        subsystem_reset();
+        s390_crypto_reset();
+        s390_pv_prepare_reset(ms);
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
+        s390_pv_prepare_reset(ms);
         CPU_FOREACH(t) {
             if (t == cs) {
                 continue;
             }
             run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
         }
-        subsystem_reset();
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
+        if (s390_machine_protect(ms)) {
+            s390_machine_inject_pv_error(cs);
+            /*
+             * Continue after the diag308 so the guest knows something
+             * went wrong.
+             */
+            s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
+            return;
+        }
+
         run_on_cpu(cs, s390_do_cpu_load_normal, RUN_ON_CPU_NULL);
         break;
     default:
diff --git a/include/hw/s390x/pv.h b/include/hw/s390x/pv.h
new file mode 100644
index 0000000000000000..43298171a9e23c76
--- /dev/null
+++ b/include/hw/s390x/pv.h
@@ -0,0 +1,57 @@
+/*
+ * Protected Virtualization header
+ *
+ * Copyright IBM Corp. 2020
+ * Author(s):
+ *  Janosch Frank <frankja@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+#ifndef HW_S390_PV_H
+#define HW_S390_PV_H
+
+#ifdef CONFIG_KVM
+#include "hw/s390x/s390-virtio-ccw.h"
+
+static inline bool s390_is_pv(void)
+{
+    static S390CcwMachineState *ccw;
+    Object *obj;
+
+    if (ccw) {
+        return ccw->pv;
+    }
+
+    /* we have to bail out for the "none" machine */
+    obj = object_dynamic_cast(qdev_get_machine(),
+                              TYPE_S390_CCW_MACHINE);
+    if (!obj) {
+        return false;
+    }
+    ccw = S390_CCW_MACHINE(obj);
+    return ccw->pv;
+}
+
+int s390_pv_vm_enable(void);
+void s390_pv_vm_disable(void);
+int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
+int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
+void s390_pv_perf_clear_reset(void);
+int s390_pv_verify(void);
+void s390_pv_unshare(void);
+#else
+static inline bool s390_is_pv(void) { return false; }
+static inline int s390_pv_vm_enable(void) { return 0; }
+static inline void s390_pv_vm_disable(void) {}
+static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t length) { return 0; }
+static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) { return 0; }
+static inline void s390_pv_perf_clear_reset(void) {}
+static inline int s390_pv_verify(void) { return 0; }
+static inline void s390_pv_unshare(void) {}
+#endif
+
+
+
+#endif /* HW_S390_PV_H */
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 8aa27199c9123bab..cd1dccc6e3ba8645 100644
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
index 3dd396e870357944..84029f14814b4980 100644
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
diff --git a/target/s390x/cpu_features_def.inc.h b/target/s390x/cpu_features_def.inc.h
index 31dff0d84e972451..60db28351d059091 100644
--- a/target/s390x/cpu_features_def.inc.h
+++ b/target/s390x/cpu_features_def.inc.h
@@ -107,6 +107,7 @@ DEF_FEAT(DEFLATE_BASE, "deflate-base", STFL, 151, "Deflate-conversion facility (
 DEF_FEAT(VECTOR_PACKED_DECIMAL_ENH, "vxpdeh", STFL, 152, "Vector-Packed-Decimal-Enhancement Facility")
 DEF_FEAT(MSA_EXT_9, "msa9-base", STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)")
 DEF_FEAT(ETOKEN, "etoken", STFL, 156, "Etoken facility")
+DEF_FEAT(UNPACK, "unpack", STFL, 161, "Unpack facility")
 
 /* Features exposed via SCLP SCCB Byte 80 - 98  (bit numbers relative to byte-80) */
 DEF_FEAT(SIE_GSLS, "gsls", SCLP_CONF_CHAR, 40, "SIE: Guest-storage-limit-suppression facility")
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 54e5670b3fd6d960..b245e557037ded06 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -20,6 +20,7 @@
 #include "sysemu/cpus.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/s390x/pv.h"
 
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 {
@@ -52,6 +53,7 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 #define DIAG_308_RC_OK              0x0001
 #define DIAG_308_RC_NO_CONF         0x0102
 #define DIAG_308_RC_INVALID         0x0402
+#define DIAG_308_RC_NO_PV_CONF      0x0902
 
 #define DIAG308_RESET_MOD_CLR       0
 #define DIAG308_RESET_LOAD_NORM     1
@@ -59,10 +61,17 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 #define DIAG308_LOAD_NORMAL_DUMP    4
 #define DIAG308_SET                 5
 #define DIAG308_STORE               6
+#define DIAG308_PV_SET              8
+#define DIAG308_PV_STORE            9
+#define DIAG308_PV_START            10
 
 static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
                               uintptr_t ra, bool write)
 {
+    /* Handled by the Ultravisor */
+    if (s390_is_pv()) {
+        return 0;
+    }
     if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return -1;
@@ -93,6 +102,11 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         return;
     }
 
+    if (subcode >= DIAG308_PV_SET && !s390_has_feat(S390_FEAT_UNPACK)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+
     switch (subcode) {
     case DIAG308_RESET_MOD_CLR:
         s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
@@ -105,6 +119,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         s390_ipl_reset_request(cs, S390_RESET_REIPL);
         break;
     case DIAG308_SET:
+    case DIAG308_PV_SET:
         if (diag308_parm_check(env, r1, addr, ra, false)) {
             return;
         }
@@ -128,10 +143,15 @@ out:
         g_free(iplb);
         return;
     case DIAG308_STORE:
+    case DIAG308_PV_STORE:
         if (diag308_parm_check(env, r1, addr, ra, true)) {
             return;
         }
-        iplb = s390_ipl_get_iplb();
+        if (subcode == DIAG308_PV_STORE) {
+            iplb = s390_ipl_get_iplb_pv();
+        } else {
+            iplb = s390_ipl_get_iplb();
+        }
         if (iplb) {
             cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
             env->regs[r1 + 1] = DIAG_308_RC_OK;
@@ -139,6 +159,15 @@ out:
             env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
         }
         return;
+    case DIAG308_PV_START:
+        iplb = s390_ipl_get_iplb_pv();
+        if (!iplb) {
+            env->regs[r1 + 1] = DIAG_308_RC_NO_PV_CONF;
+            return;
+        }
+
+        s390_ipl_reset_request(cs, S390_RESET_PV);
+        break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         break;
-- 
2.25.1


