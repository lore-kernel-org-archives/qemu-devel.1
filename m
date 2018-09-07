Received: from eggs.gnu.org ([2001:4830:134:3::10]:60824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyOf1-00006y-MI
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyOf0-0005rh-Qq
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fyOf0-0005rJ-K9
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:26 -0400
Date: Fri, 7 Sep 2018 17:51:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180907215109.146867-6-mst@redhat.com>
References: <20180907215109.146867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907215109.146867-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] pc: make sure that guest isn't able to
 unplug the first cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

The first cpu unplug wasn't ever supported and corresponding
monitor/qmp commands refuse to unplug it. However guest is able
to issue eject request either using following command:
  # echo 1 >/sys/devices/system/cpu/cpu0/firmware_node/eject
or directly writing to cpu hotplug registers, which makes
qemu crash with SIGSEGV following back trace:

   kvm_flush_coalesced_mmio_buffer ()
       while (ring->first != ring->last)
   ...
   qemu_flush_coalesced_mmio_buffer
   prepare_mmio_access
   flatview_read_continue
   flatview_read
   address_space_read_full
   address_space_rw
   kvm_cpu_exec(cpu!0)
   qemu_kvm_cpu_thread_fn

the reason for which is that ring == KVMState::coalesced_mmio_ring
happens to be a part of 1st CPU that was uplugged by guest.

Fix it by forbidding 1st cpu unplug from guest side and in addition
remove CPU0._EJ0 ACPI method to make clear that unplug of the first
CPU is not supported.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5ae595ecbe..4bb83713c5 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -117,7 +117,7 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
             DeviceState *dev = NULL;
             HotplugHandler *hotplug_ctrl = NULL;
 
-            if (!cdev->cpu) {
+            if (!cdev->cpu || cdev->cpu == first_cpu) {
                 trace_cpuhp_acpi_ejecting_invalid_cpu(cpu_st->selector);
                 break;
             }
@@ -541,9 +541,11 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                 aml_buffer(madt_buf->len, (uint8_t *)madt_buf->data)));
             g_array_free(madt_buf, true);
 
-            method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
-            aml_append(method, aml_call1(CPU_EJECT_METHOD, uid));
-            aml_append(dev, method);
+            if (CPU(arch_ids->cpus[i].cpu) != first_cpu) {
+                method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
+                aml_append(method, aml_call1(CPU_EJECT_METHOD, uid));
+                aml_append(dev, method);
+            }
 
             method = aml_method("_OST", 3, AML_SERIALIZED);
             aml_append(method,
-- 
MST
