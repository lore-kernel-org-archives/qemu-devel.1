Received: from eggs.gnu.org ([2001:4830:134:3::10]:46344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fahE5-0007bx-FN
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fahE4-0000ZI-LX
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:49:41 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Wed,  4 Jul 2018 14:49:23 +0200
Message-Id: <20180704124923.32483-7-drjones@redhat.com>
In-Reply-To: <20180704124923.32483-1-drjones@redhat.com>
References: <20180704124923.32483-1-drjones@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 6/6] hw/arm/virt: cpu topology: don't allow
 threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, imammedo@redhat.com, eric.auger@redhat.com, wei@redhat.com

None of the cpu models supported by mach-virt support threads.
Furthermore when running with KVM and cpu=host, while the host
processor may support threads, we don't yet support telling KVM
that we want the guest to see that. So if the user tries to
select more than one thread for the cpu topology, just error-out.

We'll remove the restriction for KVM guests after adding support
to KVM and QEMU for userspace controlled VCPU MPIDRs.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6c5fecdd61df..8fc2751ab4bb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1390,6 +1390,19 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if (!vmc->ignore_cpu_topology && smp_threads > 1) {
+        if (kvm_enabled() &&
+            strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("host")) == 0) {
+            error_report("mach-virt: KVM: user controlled MPIDR.MT not "
+                         "yet supported");
+        } else {
+            error_report("mach-virt: CPU type %s does not support SMT",
+                         machine->cpu_type);
+        }
+        error_report("mach-virt: smp_threads cannot be > 1");
+        exit(1);
+    }
+
     /* If we have an EL3 boot ROM then the assumption is that it will
      * implement PSCI itself, so disable QEMU's internal implementation
      * so it doesn't get in the way. Instead of starting secondary
-- 
2.17.1
