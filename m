Received: from eggs.gnu.org ([2001:4830:134:3::10]:60605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eGpjJ-0000q1-03
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eGpjF-0007Sm-QZ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:19:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eGpjF-0007Rw-Jx
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:19:29 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 20 Nov 2017 18:19:23 +0100
Message-Id: <1511198363-106442-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v2] pc: fix crash on attempted cpu
 unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net

when qemu is started with '-no-acpi' CLI option, an attempt
to unplug a CPU using device_del results in null pointer
dereference at:

  #0 object_get_class
  #1 pc_machine_device_unplug_request_cb
  #2 qmp_marshal_device_del

which is caused by pcms->acpi_dev == NULL due to ACPI support
being disabled.

Considering that ACPI support is necessary for unplug to work,
check that it's enabled and fail unplug request gracefully
if no acpi device were found.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
v2:
  - make error message more verbose (ehabkost@redhat.com)
---
 hw/i386/pc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c3afe5b..186545d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1842,6 +1842,11 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
+    if (!pcms->acpi_dev) {
+        error_setg(&local_err, "CPU hot unplug not supported without ACPI");
+        goto out;
+    }
+
     pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     assert(idx != -1);
     if (idx == 0) {
-- 
2.7.4
