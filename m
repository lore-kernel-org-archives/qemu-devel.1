Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE2DC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46252133F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46252133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnGg-0006kM-2L
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57721)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <walling@linux.ibm.com>) id 1hfnDK-00048t-SF
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1hfnDI-0007OV-Hn
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:18:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23138
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1hfnD9-00076x-1r; Tue, 25 Jun 2019 11:18:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5PF5iPk139150; Tue, 25 Jun 2019 11:18:12 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tbmka4sk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jun 2019 11:18:10 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5PFFLXW019897;
 Tue, 25 Jun 2019 15:18:09 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma04dal.us.ibm.com with ESMTP id 2t9by6rx44-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jun 2019 15:18:09 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5PFI8Ko50659610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2019 15:18:08 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DD81124053;
 Tue, 25 Jun 2019 15:18:08 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F46C12405C;
 Tue, 25 Jun 2019 15:18:08 +0000 (GMT)
Received: from collin-T470p.pok.ibm.com (unknown [9.63.14.221])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 25 Jun 2019 15:18:08 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 rth@twiddle.net, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, mst@redhat.com, pbonzini@redhat.com
Date: Tue, 25 Jun 2019 11:17:09 -0400
Message-Id: <1561475829-19202-3-git-send-email-walling@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561475829-19202-1-git-send-email-walling@linux.ibm.com>
References: <1561475829-19202-1-git-send-email-walling@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-25_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250116
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v5 2/2] s390: diagnose 318 info reset and
 migration support
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
be intercepted by SIE and handled via KVM. Let's introduce some
functions to communicate between QEMU and KVM via ioctls. These
will be used to get/set the diag318 information.

The availability of this instruction is determined by byte 134, bit 0
of the Read Info block. This coincidentally expands into the space used
for CPU entries, which means VMs running with the diag318 capability
will have a reduced maximum CPU count. Let's reduce the maximum CPU
count from 248 to 247.

In order to simplify the migration and system reset requirements of
the diag318 data, let's introduce it as a device class and include
a VMStateDescription.

Diag318 is set to 0 during modified clear and load normal resets.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/Makefile.objs          |  1 +
 hw/s390x/diag318.c              | 80 +++++++++++++++++++++++++++++++++++++++++
 hw/s390x/diag318.h              | 38 ++++++++++++++++++++
 hw/s390x/s390-virtio-ccw.c      | 17 +++++++++
 hw/s390x/sclp.c                 |  3 ++
 include/hw/s390x/sclp.h         |  2 ++
 target/s390x/cpu.h              |  8 ++++-
 target/s390x/cpu_features.c     |  3 ++
 target/s390x/cpu_features.h     |  1 +
 target/s390x/cpu_features_def.h |  3 ++
 target/s390x/gen-features.c     |  1 +
 target/s390x/kvm-stub.c         | 10 ++++++
 target/s390x/kvm.c              | 29 +++++++++++++++
 target/s390x/kvm_s390x.h        |  2 ++
 14 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 hw/s390x/diag318.c
 create mode 100644 hw/s390x/diag318.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index e02ed80..93621dc 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -34,3 +34,4 @@ obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
 obj-y += s390-ccw.o
 obj-y += ap-device.o
 obj-y += ap-bridge.o
+obj-y += diag318.o
diff --git a/hw/s390x/diag318.c b/hw/s390x/diag318.c
new file mode 100644
index 0000000..0eb80fe
--- /dev/null
+++ b/hw/s390x/diag318.c
@@ -0,0 +1,80 @@
+/*
+ * DIAGNOSE 0x318 functions for reset and migration
+ *
+ * Copyright IBM, Corp. 2019
+ *
+ * Authors:
+ *  Collin Walling <walling@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version. See the COPYING file in the top-level directory.
+ */
+
+#include "hw/s390x/diag318.h"
+#include "qapi/error.h"
+#include "kvm_s390x.h"
+#include "sysemu/kvm.h"
+
+static int diag318_post_load(void *opaque, int version_id)
+{
+    DIAG318State *d = opaque;
+
+    kvm_s390_set_diag318_info(d->info);
+    return 0;
+}
+
+static int diag318_pre_save(void *opaque)
+{
+    DIAG318State *d = opaque;
+
+    kvm_s390_get_diag318_info(&d->info);
+    return 0;
+}
+
+static bool diag318_needed(void *opaque)
+{
+    return s390_has_feat(S390_FEAT_DIAG318);
+}
+
+const VMStateDescription vmstate_diag318 = {
+    .name = "vmstate_diag318",
+    .post_load = diag318_post_load,
+    .pre_save = diag318_pre_save,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = diag318_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(info, DIAG318State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void s390_diag318_reset(DeviceState *dev)
+{
+    kvm_s390_set_diag318_info(0);
+}
+
+static void s390_diag318_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = s390_diag318_reset;
+    dc->vmsd = &vmstate_diag318;
+    dc->hotpluggable = false;
+    /* Reason: Set automatically during IPL */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo s390_diag318_info = {
+    .class_init = s390_diag318_class_init,
+    .parent = TYPE_DEVICE,
+    .name = TYPE_S390_DIAG318,
+    .instance_size = sizeof(DIAG318State),
+};
+
+static void s390_diag318_register_types(void)
+{
+    type_register_static(&s390_diag318_info);
+}
+
+type_init(s390_diag318_register_types)
diff --git a/hw/s390x/diag318.h b/hw/s390x/diag318.h
new file mode 100644
index 0000000..d588bdd
--- /dev/null
+++ b/hw/s390x/diag318.h
@@ -0,0 +1,38 @@
+/*
+ * DIAGNOSE 0x318 functions for reset and migration
+ *
+ * Copyright IBM, Corp. 2019
+ *
+ * Authors:
+ *  Collin Walling <walling@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at your
+ * option) any later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_DIAG318_H
+#define HW_DIAG318_H
+
+#include "qemu/osdep.h"
+#include "hw/qdev.h"
+
+#define TYPE_S390_DIAG318 "diag318"
+#define DIAG318(obj) \
+    OBJECT_CHECK(DIAG318State, (obj), TYPE_S390_DIAG318)
+
+typedef struct DIAG318State {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    uint64_t info;
+} DIAG318State;
+
+typedef struct DIAG318Class {
+    /*< private >*/
+    DeviceClass parent_class;
+
+    /*< public >*/
+} DIAG318Class;
+
+#endif /* HW_DIAG318_H */
\ No newline at end of file
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 87b2039..54230c7 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -38,6 +38,7 @@
 #include "cpu_models.h"
 #include "hw/nmi.h"
 #include "hw/s390x/tod.h"
+#include "hw/s390x/diag318.h"
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -94,6 +95,7 @@ static const char *const reset_dev_types[] = {
     "s390-sclp-event-facility",
     "s390-flic",
     "diag288",
+    TYPE_S390_DIAG318,
 };
 
 static void subsystem_reset(void)
@@ -258,6 +260,17 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
     qdev_init_nofail(dev);
 }
 
+static void s390_init_diag318(void)
+{
+    Object *new = object_new(TYPE_S390_DIAG318);
+    DeviceState *dev = DEVICE(new);
+
+    object_property_add_child(qdev_get_machine(), TYPE_S390_DIAG318,
+                              new, NULL);
+    object_unref(new);
+    qdev_init_nofail(dev);
+}
+
 static void ccw_init(MachineState *machine)
 {
     int ret;
@@ -315,6 +328,9 @@ static void ccw_init(MachineState *machine)
 
     /* init the TOD clock */
     s390_init_tod();
+
+    /* init object used for migrating diag318 info */
+    s390_init_diag318();
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
@@ -583,6 +599,7 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
         ms->loadparm[i] = ' '; /* pad right with spaces */
     }
 }
+
 static inline void s390_machine_initfn(Object *obj)
 {
     object_property_add_bool(obj, "aes-key-wrap",
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 4510a80..f905af0 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -22,6 +22,7 @@
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
+#include "kvm_s390x.h"
 
 static inline SCLPDevice *get_sclp_device(void)
 {
@@ -74,6 +75,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
                          read_info->conf_char_ext);
 
+    s390_get_feat_block(S390_FEAT_TYPE_SCLP_BYTE_134, read_info->fac134);
+
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
                                         SCLP_HAS_IOA_RECONFIG);
 
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index f9db243..667da49 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -133,6 +133,8 @@ typedef struct ReadInfo {
     uint16_t highest_cpu;
     uint8_t  _reserved5[124 - 122];     /* 122-123 */
     uint32_t hmfai;
+    uint8_t  _reserved7[134 - 128];     /* 128-133 */
+    uint8_t  fac134[1];
     struct CPUEntry entries[0];
 } QEMU_PACKED ReadInfo;
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a606547..4c26754 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -39,7 +39,13 @@
 
 #define MMU_USER_IDX 0
 
-#define S390_MAX_CPUS 248
+/*
+ * HACK: The introduction of additional facility bytes in the Read Info
+ * struct consumes space used for CPU entries, thus we must reduce the
+ * original maximum CPUs of 248 by one for each new byte or risk smashing
+ * the stack.
+ */
+#define S390_MAX_CPUS 247
 
 typedef struct PSW {
     uint64_t mask;
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index f64f581..77a1df5 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -127,6 +127,9 @@ static const S390FeatDef s390_features[] = {
     FEAT_INIT("pfmfi", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 9, "SIE: PFMF interpretation facility"),
     FEAT_INIT("ibs", S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-suppression facility"),
 
+    /* SCLP SCCB Byte 134 */
+    FEAT_INIT("diag318", S390_FEAT_TYPE_SCLP_BYTE_134, 0, "Control program name and version codes"),
+
     FEAT_INIT("sief2", S390_FEAT_TYPE_SCLP_CPU, 4, "SIE: interception format 2 (Virtual SIE)"),
     FEAT_INIT("skey", S390_FEAT_TYPE_SCLP_CPU, 5, "SIE: Storage-key facility"),
     FEAT_INIT("gpereh", S390_FEAT_TYPE_SCLP_CPU, 10, "SIE: Guest-PER enhancement facility"),
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index da695a8..954544e 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -23,6 +23,7 @@ typedef enum {
     S390_FEAT_TYPE_STFL,
     S390_FEAT_TYPE_SCLP_CONF_CHAR,
     S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
+    S390_FEAT_TYPE_SCLP_BYTE_134,
     S390_FEAT_TYPE_SCLP_CPU,
     S390_FEAT_TYPE_MISC,
     S390_FEAT_TYPE_PLO,
diff --git a/target/s390x/cpu_features_def.h b/target/s390x/cpu_features_def.h
index 292b17b..4f2c23e 100644
--- a/target/s390x/cpu_features_def.h
+++ b/target/s390x/cpu_features_def.h
@@ -115,6 +115,9 @@ typedef enum {
     S390_FEAT_SIE_PFMFI,
     S390_FEAT_SIE_IBS,
 
+    /* Sclp Byte 134 */
+    S390_FEAT_DIAG318,
+
     /* Sclp Cpu */
     S390_FEAT_SIE_F2,
     S390_FEAT_SIE_SKEY,
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index dc320a0..cdd1875 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -521,6 +521,7 @@ static uint16_t full_GEN12_GA1[] = {
     S390_FEAT_AP_QUERY_CONFIG_INFO,
     S390_FEAT_AP_FACILITIES_TEST,
     S390_FEAT_AP,
+    S390_FEAT_DIAG318,
 };
 
 static uint16_t full_GEN12_GA2[] = {
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index 5152e2b..7c39d6a 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -107,3 +107,13 @@ void kvm_s390_stop_interrupt(S390CPU *cpu)
 void kvm_s390_restart_interrupt(S390CPU *cpu)
 {
 }
+
+int kvm_s390_get_diag318_info(uint64_t *info)
+{
+    return 0;
+}
+
+int kvm_s390_set_diag318_info(uint64_t info)
+{
+    return 0;
+}
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 0267c6c..1fda9cd 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -750,6 +750,28 @@ int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+int kvm_s390_get_diag318_info(uint64_t *info)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_DIAG318,
+        .addr = (uint64_t)info,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+}
+
+int kvm_s390_set_diag318_info(uint64_t info)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_DIAG318,
+        .addr = (uint64_t)&info,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+}
+
 /**
  * kvm_s390_mem_op:
  * @addr:      the logical start address in guest memory
@@ -2323,6 +2345,13 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
         set_bit(S390_FEAT_AP, model->features);
     }
+
+    /* if KVM supports interception of diag318, then let's provide the bit */
+    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_MISC,
+        KVM_S390_VM_MISC_DIAG318)) {
+        set_bit(S390_FEAT_DIAG318, model->features);
+    }
+
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index caf9859..50df93e 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -29,6 +29,8 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_set_clock(uint8_t tod_high, uint64_t tod_clock);
 int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_clock);
+int kvm_s390_get_diag318_info(uint64_t *info);
+int kvm_s390_set_diag318_info(uint64_t info);
 void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
-- 
2.7.4


