Received: from eggs.gnu.org ([2001:4830:134:3::10]:42683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKV1-00039y-Ix
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dzKUy-00023r-Vn
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:27 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dzKUy-000238-OO
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:32:24 -0400
Received: by mail-wm0-x241.google.com with SMTP id i124so15832368wmf.3
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 03:32:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  3 Oct 2017 12:28:40 +0200
Message-Id: <1507026521-19230-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
References: <1507026521-19230-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] kvm: check KVM_CAP_NR_VCPUS with
 kvm_vm_check_extension()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

On a modern server-class ppc host with the following CPU topology:

Architecture:          ppc64le
Byte Order:            Little Endian
CPU(s):                32
On-line CPU(s) list:   0,8,16,24
Off-line CPU(s) list:  1-7,9-15,17-23,25-31
Thread(s) per core:    1

If both KVM PR and KVM HV loaded and we pass:

        -machine pseries,accel=kvm,kvm-type=PR -smp 8

We expect QEMU to warn that this exceeds the number of online CPUs:

Warning: Number of SMP cpus requested (8) exceeds the recommended
 cpus supported by KVM (4)
Warning: Number of hotpluggable cpus requested (8) exceeds the
 recommended cpus supported by KVM (4)

but nothing is printed...

This happens because on ppc the KVM_CAP_NR_VCPUS capability is VM
specific  ndreally depends on the KVM type, but we currently use it
as a global capability. And KVM returns a fallback value based on
KVM HV being present. Maybe KVM on POWER shouldn't presume anything
as long as it doesn't have a VM, but in all cases, we should call
KVM_CREATE_VM first and use KVM_CAP_NR_VCPUS as a VM capability.

This patch hence changes kvm_recommended_vcpus() accordingly and
moves the sanity checking of smp_cpus after the VM creation.

It is okay for the other archs that also implement KVM_CAP_NR_VCPUS,
ie, mips, s390, x86 and arm, because they don't depend on the VM
being created or not.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <150600966286.30533.10909862523552370889.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f54a337..90c88b5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1440,7 +1440,7 @@ static void kvm_irqchip_create(MachineState *machine, KVMState *s)
  */
 static int kvm_recommended_vcpus(KVMState *s)
 {
-    int ret = kvm_check_extension(s, KVM_CAP_NR_VCPUS);
+    int ret = kvm_vm_check_extension(s, KVM_CAP_NR_VCPUS);
     return (ret) ? ret : 4;
 }
 
@@ -1530,26 +1530,6 @@ static int kvm_init(MachineState *ms)
         s->nr_slots = 32;
     }
 
-    /* check the vcpu limits */
-    soft_vcpus_limit = kvm_recommended_vcpus(s);
-    hard_vcpus_limit = kvm_max_vcpus(s);
-
-    while (nc->name) {
-        if (nc->num > soft_vcpus_limit) {
-            warn_report("Number of %s cpus requested (%d) exceeds "
-                        "the recommended cpus supported by KVM (%d)",
-                        nc->name, nc->num, soft_vcpus_limit);
-
-            if (nc->num > hard_vcpus_limit) {
-                fprintf(stderr, "Number of %s cpus requested (%d) exceeds "
-                        "the maximum cpus supported by KVM (%d)\n",
-                        nc->name, nc->num, hard_vcpus_limit);
-                exit(1);
-            }
-        }
-        nc++;
-    }
-
     kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
     if (mc->kvm_type) {
         type = mc->kvm_type(kvm_type);
@@ -1584,6 +1564,27 @@ static int kvm_init(MachineState *ms)
     }
 
     s->vmfd = ret;
+
+    /* check the vcpu limits */
+    soft_vcpus_limit = kvm_recommended_vcpus(s);
+    hard_vcpus_limit = kvm_max_vcpus(s);
+
+    while (nc->name) {
+        if (nc->num > soft_vcpus_limit) {
+            warn_report("Number of %s cpus requested (%d) exceeds "
+                        "the recommended cpus supported by KVM (%d)",
+                        nc->name, nc->num, soft_vcpus_limit);
+
+            if (nc->num > hard_vcpus_limit) {
+                fprintf(stderr, "Number of %s cpus requested (%d) exceeds "
+                        "the maximum cpus supported by KVM (%d)\n",
+                        nc->name, nc->num, hard_vcpus_limit);
+                exit(1);
+            }
+        }
+        nc++;
+    }
+
     missing_cap = kvm_check_extension_list(s, kvm_required_capabilites);
     if (!missing_cap) {
         missing_cap =
-- 
1.8.3.1
