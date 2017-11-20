Received: from eggs.gnu.org ([2001:4830:134:3::10]:38908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eGn9W-0006lt-KP
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eGn9T-0006Pa-IN
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:34:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eGn9T-0006PJ-Bq
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:34:23 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 20 Nov 2017 15:34:13 +0100
Message-Id: <1511188453-248734-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] pc: fix crash on attempted cpu unplug
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
---
 hw/i386/pc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c3afe5b..d80cec3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1842,6 +1842,11 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
+    if (!pcms->acpi_dev) {
+        error_setg(&local_err, "not supported without acpi");
+        goto out;
+    }
+
     pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     assert(idx != -1);
     if (idx == 0) {
-- 
2.7.4
