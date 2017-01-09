Received: from eggs.gnu.org ([2001:4830:134:3::10]:37253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWT-0002Qs-Fe
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWS-00046p-8C
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:57 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWS-00043I-1o
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:53:56 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWP-0001Rk-41
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:53 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:40 +0000
Message-Id: <1483962824-29185-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/21] hw/arm/virt-acpi-build: don't save
 VirtGuestInfo on AcpiBuildState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

We can get to VirtMachineState without the need for saving a pointer
on AcpiBuildState. This is the mach-virt equivalent to "acpi: Don't save
PcGuestInfo on AcpiBuildState"

Signed-off-by: Andrew Jones <drjones@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20170102200153.28864-13-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index a3848a9..3791b81 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -707,7 +707,6 @@ struct AcpiBuildState {
     MemoryRegion *linker_mr;
     /* Is table patched? */
     bool patched;
-    VirtGuestInfo *guest_info;
 } AcpiBuildState;
 
 static
@@ -791,8 +790,7 @@ static void virt_acpi_build_update(void *build_opaque)
 
     acpi_build_tables_init(&tables);
 
-    virt_acpi_build(container_of(build_state->guest_info,
-                                 VirtMachineState, acpi_guest_info), &tables);
+    virt_acpi_build(VIRT_MACHINE(qdev_get_machine()), &tables);
 
     acpi_ram_update(build_state->table_mr, tables.table_data);
     acpi_ram_update(build_state->rsdp_mr, tables.rsdp);
@@ -842,7 +840,6 @@ void virt_acpi_setup(VirtMachineState *vms)
     }
 
     build_state = g_malloc0(sizeof *build_state);
-    build_state->guest_info = guest_info;
 
     acpi_build_tables_init(&tables);
     virt_acpi_build(vms, &tables);
-- 
2.7.4
