Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10BEC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 22:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69AB320866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 22:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AB320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLxma-000059-GU
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 18:32:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hLxlk-0008Dl-Uo
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hLxlj-0000vk-1v
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:32:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46962
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1hLxle-0000iL-4u; Wed, 01 May 2019 18:31:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x41MRDcu043068; Wed, 1 May 2019 18:31:55 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
	[169.63.214.131])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s7m0yrg18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 01 May 2019 18:31:55 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id
	x41GZNHK019669; Wed, 1 May 2019 16:35:50 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
	(b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma01dal.us.ibm.com with ESMTP id 2s4eq3usqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 01 May 2019 16:35:50 +0000
Received: from b03ledav002.gho.boulder.ibm.com
	(b03ledav002.gho.boulder.ibm.com [9.17.130.233])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x41MVqZa58458184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 1 May 2019 22:31:52 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B373C13604F;
	Wed,  1 May 2019 22:31:52 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBB40136055;
	Wed,  1 May 2019 22:31:51 +0000 (GMT)
Received: from collin-T470p.pok.ibm.com (unknown [9.56.58.88])
	by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed,  1 May 2019 22:31:51 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
	rth@twiddle.net, david@redhat.com, pasic@linux.ibm.com,
	borntraeger@de.ibm.com, mst@redhat.com, pbonzini@redhat.com
Date: Wed,  1 May 2019 18:31:43 -0400
Message-Id: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905010138
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v4] s390: diagnose 318 info reset and migration
 support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501223143.oO7doPmRTrbCh6opRMKpC6MSTe3zjNrCHVrDqgS6lZU@z>

DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
be intercepted by SIE and handled via KVM. Let's introduce some
functions to communicate between QEMU and KVM via ioctls. These
will be used to get/set the diag318 related information (also known
as the "Control Program Code" or "CPC"), as well as check the system
if KVM supports handling this instruction.

The availability of this instruction is determined by byte 134, bit 0
of the Read Info block. This coincidentally expands into the space used
for CPU entries, which means VMs running with the diag318 capability
will have a reduced maximum CPU count. To alleviate this, let's calculate
the actual max CPU entry space by subtracting the size of Read Info from
the SCCB size then dividing that number by the size of a CPU entry. If
this value is less than the value denoted by S390_MAX_CPUS, then let's
reduce the max cpus for s390 from 248 to 240 in an effort to anticipate
this potentially happening again in the future.

In order to simplify the migration and system reset requirements of
the diag318 data, let's introduce it as a device class and include
a VMStateDescription.

Diag318 is reset on during modified clear and load normal.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/Makefile.objs       |   1 +
 hw/s390x/diag318.c           | 100 +++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/diag318.h           |  39 +++++++++++++++++
 hw/s390x/s390-virtio-ccw.c   |  23 ++++++++++
 hw/s390x/sclp.c              |   5 +++
 include/hw/s390x/sclp.h      |   2 +
 linux-headers/asm-s390/kvm.h |   4 ++
 target/s390x/kvm-stub.c      |  15 +++++++
 target/s390x/kvm.c           |  32 ++++++++++++++
 target/s390x/kvm_s390x.h     |   3 ++
 10 files changed, 224 insertions(+)
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
index 0000000..94b44da
--- /dev/null
+++ b/hw/s390x/diag318.c
@@ -0,0 +1,100 @@
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
+    kvm_s390_set_cpc(d->cpc);
+
+    /* It is not necessary to retain a copy of the cpc after migration. */
+    d->cpc = 0;
+
+    return 0;
+}
+
+static int diag318_pre_save(void *opaque)
+{
+    DIAG318State *d = opaque;
+
+    kvm_s390_get_cpc(&d->cpc);
+    return 0;
+}
+
+static bool diag318_needed(void *opaque)
+{
+    DIAG318State *d = opaque;
+
+    return d->enabled;
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
+        VMSTATE_UINT64(cpc, DIAG318State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void s390_diag318_realize(DeviceState *dev, Error **errp)
+{
+    DIAG318State *d = DIAG318(dev);
+
+    if (kvm_s390_has_diag318()) {
+        d->enabled = true;
+    }
+}
+
+static void s390_diag318_reset(DeviceState *dev)
+{
+    DIAG318State *d = DIAG318(dev);
+
+    if (d->enabled) {
+        kvm_s390_set_cpc(0);
+    }
+}
+
+static void s390_diag318_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = s390_diag318_realize;
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
index 0000000..c154b0a
--- /dev/null
+++ b/hw/s390x/diag318.h
@@ -0,0 +1,39 @@
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
+ #ifndef DIAG318_H
+ #define DIAG318_H
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
+    uint64_t cpc;
+    bool enabled;
+} DIAG318State;
+
+typedef struct DIAG318Class {
+    /*< private >*/
+    DeviceClass parent_class;
+
+    /*< public >*/
+} DIAG318Class;
+
+#endif /* DIAG318_H */
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d11069b..44a424b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -36,6 +36,7 @@
 #include "cpu_models.h"
 #include "hw/nmi.h"
 #include "hw/s390x/tod.h"
+#include "hw/s390x/diag318.h"
 
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
 {
@@ -92,6 +93,7 @@ static const char *const reset_dev_types[] = {
     "s390-sclp-event-facility",
     "s390-flic",
     "diag288",
+    TYPE_S390_DIAG318,
 };
 
 static void subsystem_reset(void)
@@ -246,6 +248,17 @@ static void s390_create_sclpconsole(const char *type, Chardev *chardev)
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
@@ -302,6 +315,8 @@ static void ccw_init(MachineState *machine)
 
     /* init the TOD clock */
     s390_init_tod();
+
+    s390_init_diag318();
 }
 
 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
@@ -570,6 +585,7 @@ static void machine_set_loadparm(Object *obj, const char *val, Error **errp)
         ms->loadparm[i] = ' '; /* pad right with spaces */
     }
 }
+
 static inline void s390_machine_initfn(Object *obj)
 {
     object_property_add_bool(obj, "aes-key-wrap",
@@ -652,6 +668,13 @@ static void ccw_machine_4_0_instance_options(MachineState *machine)
 
 static void ccw_machine_4_0_class_options(MachineClass *mc)
 {
+    /*
+     * Read Info might reveal more bytes used to detect facilities, thus
+     * reducing the number of CPU entries. Let's reduce the max CPUs by
+     * an arbitrary number in effort to anticipate future facility bytes.
+     */
+    if ((SCCB_SIZE - sizeof(ReadInfo)) / sizeof(CPUEntry) < S390_MAX_CPUS)
+        mc->max_cpus = S390_MAX_CPUS - 8;
 }
 DEFINE_CCW_MACHINE(4_0, "4.0", true);
 
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 4510a80..9cfa188 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -22,6 +22,7 @@
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/ipl.h"
+#include "kvm_s390x.h"
 
 static inline SCLPDevice *get_sclp_device(void)
 {
@@ -74,6 +75,10 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR_EXT,
                          read_info->conf_char_ext);
 
+    /* Enable diag318 for guest if KVM supports emulation */
+    if (kvm_s390_has_diag318())
+        read_info->fac134 = 0x80;
+
     read_info->facilities = cpu_to_be64(SCLP_HAS_CPU_INFO |
                                         SCLP_HAS_IOA_RECONFIG);
 
diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index f9db243..d47e10a 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -133,6 +133,8 @@ typedef struct ReadInfo {
     uint16_t highest_cpu;
     uint8_t  _reserved5[124 - 122];     /* 122-123 */
     uint32_t hmfai;
+    uint8_t  _reserved7[134 - 128];     /* 128-133 */
+    uint8_t  fac134;
     struct CPUEntry entries[0];
 } QEMU_PACKED ReadInfo;
 
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index 0265482..735f5a4 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -74,6 +74,7 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_CRYPTO		2
 #define KVM_S390_VM_CPU_MODEL		3
 #define KVM_S390_VM_MIGRATION		4
+#define KVM_S390_VM_MISC		5
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
@@ -168,6 +169,9 @@ struct kvm_s390_vm_cpu_subfunc {
 #define KVM_S390_VM_MIGRATION_START	1
 #define KVM_S390_VM_MIGRATION_STATUS	2
 
+/* kvm attributes for KVM_S390_VM_MISC */
+#define KVM_S390_VM_MISC_CPC		0
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
diff --git a/target/s390x/kvm-stub.c b/target/s390x/kvm-stub.c
index bf7795e..7861ccd 100644
--- a/target/s390x/kvm-stub.c
+++ b/target/s390x/kvm-stub.c
@@ -104,3 +104,18 @@ void kvm_s390_stop_interrupt(S390CPU *cpu)
 void kvm_s390_restart_interrupt(S390CPU *cpu)
 {
 }
+
+int kvm_s390_get_cpc(uint64_t *cpc)
+{
+    return 0;
+}
+
+int kvm_s390_set_cpc(uint64_t cpc)
+{
+    return 0;
+}
+
+bool kvm_s390_has_diag318(void)
+{
+    return false;
+}
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 19530fb..225e516 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -747,6 +747,38 @@ int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_low)
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+int kvm_s390_get_cpc(uint64_t *cpc)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_CPC,
+        .addr = (uint64_t)cpc,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+}
+
+int kvm_s390_set_cpc(uint64_t cpc)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_CPC,
+        .addr = (uint64_t)&cpc,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
+}
+
+bool kvm_s390_has_diag318(void)
+{
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_MISC,
+        .attr = KVM_S390_VM_MISC_CPC,
+    };
+
+    return kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr) == 0;
+}
+
 /**
  * kvm_s390_mem_op:
  * @addr:      the logical start address in guest memory
diff --git a/target/s390x/kvm_s390x.h b/target/s390x/kvm_s390x.h
index 6e52287..53f165f 100644
--- a/target/s390x/kvm_s390x.h
+++ b/target/s390x/kvm_s390x.h
@@ -29,6 +29,9 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_clock);
 int kvm_s390_set_clock(uint8_t tod_high, uint64_t tod_clock);
 int kvm_s390_set_clock_ext(uint8_t tod_high, uint64_t tod_clock);
+int kvm_s390_get_cpc(uint64_t *cpc);
+int kvm_s390_set_cpc(uint64_t cpc);
+bool kvm_s390_has_diag318(void);
 void kvm_s390_enable_css_support(S390CPU *cpu);
 int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
-- 
2.7.4


