Received: from eggs.gnu.org ([2001:4830:134:3::10]:58867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGlIe-0001b7-2O
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eGlIY-0000V4-27
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:35:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52326
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eGlIX-0000Uq-T9
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:35:37 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAKCT04m027530
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 07:35:33 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ebuyquarm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 07:35:32 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 20 Nov 2017 12:35:31 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 20 Nov 2017 13:35:25 +0100
In-Reply-To: <20171120123525.147663-1-borntraeger@de.ibm.com>
References: <20171120123525.147663-1-borntraeger@de.ibm.com>
Message-Id: <20171120123525.147663-3-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] s390x/kvm: use valgrind annotations for
 kvm device attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

the KVM_GET/SET_DEVICE_ATTR calls have non-self-describing
side effects. Use valgrind annotations to properly mark
all storage changes instead of using memset or designated
initializers.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-skeys-kvm.c    | 12 ++++++++++-
 hw/s390x/s390-stattrib-kvm.c |  7 ++++++
 target/s390x/kvm.c           | 51 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-skeys-kvm.c b/hw/s390x/s390-skeys-kvm.c
index dc54ed8..0986795 100644
--- a/hw/s390x/s390-skeys-kvm.c
+++ b/hw/s390x/s390-skeys-kvm.c
@@ -13,6 +13,9 @@
 #include "hw/s390x/storage-keys.h"
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
+#ifdef CONFIG_VALGRIND_H
+#include <valgrind/memcheck.h>
+#endif
 
 static int kvm_s390_skeys_enabled(S390SKeysState *ss)
 {
@@ -35,8 +38,15 @@ static int kvm_s390_skeys_get(S390SKeysState *ss, uint64_t start_gfn,
         .count = count,
         .skeydata_addr = (__u64)keys
     };
+    int ret;
 
-    return kvm_vm_ioctl(kvm_state, KVM_S390_GET_SKEYS, &args);
+    ret = kvm_vm_ioctl(kvm_state, KVM_S390_GET_SKEYS, &args);
+    if (!ret) {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(keys, count);
+#endif
+    }
+    return ret;
 }
 
 static int kvm_s390_skeys_set(S390SKeysState *ss, uint64_t start_gfn,
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 41770a7..eb2b220 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -18,6 +18,9 @@
 #include "exec/ram_addr.h"
 #include "cpu.h"
 #include "kvm_s390x.h"
+#ifdef CONFIG_VALGRIND_H
+#include <valgrind/memcheck.h>
+#endif
 
 Object *kvm_s390_stattrib_create(void)
 {
@@ -54,6 +57,10 @@ static int kvm_s390_stattrib_read_helper(S390StAttribState *sa,
     if (r < 0) {
         error_report("KVM_S390_GET_CMMA_BITS failed: %s", strerror(-r));
         return r;
+    } else {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(values, clog.count);
+#endif
     }
 
     *start_gfn = clog.start_gfn;
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index b0439a1..d3f3ddb 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -50,6 +50,9 @@
 #include "exec/memattrs.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-virtio-hcall.h"
+#ifdef CONFIG_VALGRIND_H
+#include <valgrind/memcheck.h>
+#endif
 
 #ifndef DEBUG_KVM
 #define DEBUG_KVM  0
@@ -176,8 +179,13 @@ int kvm_s390_set_mem_limit(uint64_t new_limit, uint64_t *hw_limit)
     rc = kvm_s390_query_mem_limit(hw_limit);
     if (rc) {
         return rc;
-    } else if (*hw_limit < new_limit) {
-        return -E2BIG;
+    } else {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(hw_limit, sizeof(*hw_limit));
+#endif
+        if (*hw_limit < new_limit) {
+            return -E2BIG;
+        }
     }
 
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
@@ -312,6 +320,10 @@ static int compat_disable_facilities(KVMState *s, __u64 fac_mask[], int len)
     if (rc) {
         error_report("KVM_GET_DEVICE_ATTR failed with rc %d", rc);
         return  rc;
+    } else {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(&mach_attrs, sizeof(mach_attrs));
+#endif
     }
 
     cpu_attrs.cpuid = mach_attrs.cpuid | 0xff00000000000000UL;
@@ -704,11 +716,21 @@ int kvm_s390_get_clock(uint8_t *tod_high, uint64_t *tod_low)
     r = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
     if (r) {
         return r;
+    } else {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(tod_low, sizeof(tod_low));
+#endif
     }
 
     attr.attr = KVM_S390_VM_TOD_HIGH;
     attr.addr = (uint64_t)tod_high;
-    return kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+    r = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+    if (!r) {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(tod_high, sizeof(tod_high));
+#endif
+    }
+    return r;
 }
 
 int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
@@ -722,6 +744,11 @@ int kvm_s390_get_clock_ext(uint8_t *tod_high, uint64_t *tod_low)
     };
 
     r = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+    if (!r) {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(&gtod, sizeof(gtod));
+#endif
+    }
     *tod_high = gtod.epoch_idx;
     *tod_low  = gtod.tod;
 
@@ -2085,6 +2112,10 @@ void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
         cpu->irqstate_saved_size = 0;
         error_report("Migration of interrupt state failed");
         return;
+    } else {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(cpu->irqstate, bytes);
+#endif
     }
 
     cpu->irqstate_saved_size = bytes;
@@ -2170,6 +2201,10 @@ static int query_cpu_subfunc(S390FeatBitmap features)
     rc = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
     if (rc) {
         return  rc;
+    } else {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(&prop, sizeof(prop));
+#endif
     }
 
     /*
@@ -2280,6 +2315,10 @@ static int query_cpu_feat(S390FeatBitmap features)
     rc = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
     if (rc) {
         return  rc;
+    } else {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(&prop, sizeof(prop));
+#endif
     }
 
     for (i = 0; i < ARRAY_SIZE(kvm_to_feat); i++) {
@@ -2328,7 +2367,7 @@ bool kvm_s390_cpu_models_supported(void)
 
 void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
 {
-    struct kvm_s390_vm_cpu_machine prop = {};
+    struct kvm_s390_vm_cpu_machine prop;
     struct kvm_device_attr attr = {
         .group = KVM_S390_VM_CPU_MODEL,
         .attr = KVM_S390_VM_CPU_MACHINE,
@@ -2349,6 +2388,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
     if (rc) {
         error_setg(errp, "KVM: Error querying host CPU model: %d", rc);
         return;
+    } else {
+#ifdef CONFIG_VALGRIND_H
+        VALGRIND_MAKE_MEM_DEFINED(&prop, sizeof(prop));
+#endif
     }
 
     cpu_type = cpuid_type(prop.cpuid);
-- 
2.9.4
