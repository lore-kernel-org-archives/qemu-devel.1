Received: from eggs.gnu.org ([2001:4830:134:3::10]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gCOD6-0002Kc-G3
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gCOCy-0005Yp-RV
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:12:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gCOCy-0005XD-9l
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:12:20 -0400
Received: by mail-pl1-x644.google.com with SMTP id f18-v6so10942261plr.1
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 05:12:19 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 16 Oct 2018 05:12:13 -0700
Message-Id: <1539691933-4211-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] kvm: move vcpu mmap size to KVMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@163.com, Li Qiang <liq3ea@gmail.com>

First the mmap size is a kvm ioctl, so it can go kvm initialization.
Second this can avoid triggering KVM_GET_VCPU_MMAP_SIZE while
initializing and destroying every VCPU.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 accel/kvm/kvm-all.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index de12f78eb8..f5cc47ec9f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -101,6 +101,7 @@ struct KVMState
     int nr_allocated_irq_routes;
     unsigned long *used_gsi_bitmap;
     unsigned int gsi_count;
+    long mmap_size;
     QTAILQ_HEAD(msi_hashtab, KVMMSIRoute) msi_hashtab[KVM_MSI_HASHTAB_SIZE];
 #endif
     KVMMemoryListener memory_listener;
@@ -285,20 +286,12 @@ static int kvm_set_user_memory_region(KVMMemoryListener *kml, KVMSlot *slot, boo
 int kvm_destroy_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
-    long mmap_size;
     struct KVMParkedVcpu *vcpu = NULL;
     int ret = 0;
 
     DPRINTF("kvm_destroy_vcpu\n");
 
-    mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
-    if (mmap_size < 0) {
-        ret = mmap_size;
-        DPRINTF("KVM_GET_VCPU_MMAP_SIZE failed\n");
-        goto err;
-    }
-
-    ret = munmap(cpu->kvm_run, mmap_size);
+    ret = munmap(cpu->kvm_run, s->mmap_size);
     if (ret < 0) {
         goto err;
     }
@@ -332,7 +325,6 @@ static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id)
 int kvm_init_vcpu(CPUState *cpu)
 {
     KVMState *s = kvm_state;
-    long mmap_size;
     int ret;
 
     DPRINTF("kvm_init_vcpu\n");
@@ -347,14 +339,7 @@ int kvm_init_vcpu(CPUState *cpu)
     cpu->kvm_state = s;
     cpu->vcpu_dirty = true;
 
-    mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
-    if (mmap_size < 0) {
-        ret = mmap_size;
-        DPRINTF("KVM_GET_VCPU_MMAP_SIZE failed\n");
-        goto err;
-    }
-
-    cpu->kvm_run = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+    cpu->kvm_run = mmap(NULL, s->mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
                         cpu->kvm_fd, 0);
     if (cpu->kvm_run == MAP_FAILED) {
         ret = -errno;
@@ -1583,6 +1568,13 @@ static int kvm_init(MachineState *ms)
 
     s->vmfd = ret;
 
+    s->mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
+    if (s->mmap_size < 0) {
+        ret = s->mmap_size;
+        fprintf(stderr, "KVM_GET_VCPU_MMAP_SIZE failed\n");
+        goto err;
+    }
+
     /* check the vcpu limits */
     soft_vcpus_limit = kvm_recommended_vcpus(s);
     hard_vcpus_limit = kvm_max_vcpus(s);
-- 
2.11.0
