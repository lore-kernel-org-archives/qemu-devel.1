Received: from eggs.gnu.org ([2001:4830:134:3::10]:53699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsZld-0001XZ-MS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsZlb-00062l-NN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:41 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:35555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsZlb-00062I-DA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:25:39 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 68855ABC36
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 21:25:38 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Sep 2017 21:25:32 +0200
Message-ID: <150541713284.1616.15291547955159941369.stgit@bahia.lan>
In-Reply-To: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
References: <150541711102.1616.2690784964841960181.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/3] kvm: check KVM_CAP_NR_VCPUS with
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Sam Bobroff <sam.bobroff@au1.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

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
---
 accel/kvm/kvm-all.c |   45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 323c567cfb68..d10534de2da1 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1533,7 +1533,7 @@ static void kvm_irqchip_create(MachineState *machine, KVMState *s)
  */
 static int kvm_recommended_vcpus(KVMState *s)
 {
-    int ret = kvm_check_extension(s, KVM_CAP_NR_VCPUS);
+    int ret = kvm_vm_check_extension(s, KVM_CAP_NR_VCPUS);
     return (ret) ? ret : 4;
 }
 
@@ -1623,27 +1623,6 @@ static int kvm_init(MachineState *ms)
         s->nr_slots = 32;
     }
 
-    /* check the vcpu limits */
-    soft_vcpus_limit = kvm_recommended_vcpus(s);
-    hard_vcpus_limit = kvm_max_vcpus(s);
-
-    while (nc->name) {
-        if (nc->num > soft_vcpus_limit) {
-            fprintf(stderr,
-                    "Warning: Number of %s cpus requested (%d) exceeds "
-                    "the recommended cpus supported by KVM (%d)\n",
-                    nc->name, nc->num, soft_vcpus_limit);
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
@@ -1678,6 +1657,28 @@ static int kvm_init(MachineState *ms)
     }
 
     s->vmfd = ret;
+
+    /* check the vcpu limits */
+    soft_vcpus_limit = kvm_recommended_vcpus(s);
+    hard_vcpus_limit = kvm_max_vcpus(s);
+
+    while (nc->name) {
+        if (nc->num > soft_vcpus_limit) {
+            fprintf(stderr,
+                    "Warning: Number of %s cpus requested (%d) exceeds "
+                    "the recommended cpus supported by KVM (%d)\n",
+                    nc->name, nc->num, soft_vcpus_limit);
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
