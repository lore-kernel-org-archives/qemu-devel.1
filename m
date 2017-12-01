Received: from eggs.gnu.org ([2001:4830:134:3::10]:54974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKooD-00010U-LI
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKooB-0007DL-Uf
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:09:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eKooB-0007CQ-O2
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:09:03 -0500
Date: Fri, 1 Dec 2017 19:09:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1512148088-28733-8-git-send-email-mst@redhat.com>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512148088-28733-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] pc: fix crash on attempted cpu unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Igor Mammedov <imammedo@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
