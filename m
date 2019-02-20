Received: from eggs.gnu.org ([209.51.188.92]:43112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTlk-0001Y1-Vu
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gwTlf-0008Iz-Nm
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:26:42 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gwTlb-00089j-QV
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:26:37 -0500
Received: by mail-ot1-x341.google.com with SMTP id v62so31907311otb.3
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:26:15 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Wed, 20 Feb 2019 07:59:47 -0600
Message-Id: <20190220135956.22589-11-minyard@acm.org>
In-Reply-To: <20190220135956.22589-1-minyard@acm.org>
References: <20190220135956.22589-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 10/19] boards.h: Ignore migration for SMBus
 devices on older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Corey Minyard <cminyard@mvista.com>

Migration capability is being added for pm_smbus and SMBus devices.
This change will allow backwards compatibility to be kept when
migrating back to an old qemu version.  Add a bool to the machine
class tho keep smbus migration from happening.  Future changes
will use this.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/i386/pc_piix.c   | 1 +
 hw/i386/pc_q35.c    | 1 +
 include/hw/boards.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6ba163ccbb..3bead1143f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -442,6 +442,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass *m)
 {
     pc_i440fx_4_0_machine_options(m);
     m->is_default = 0;
+    m->smbus_no_migration_support = true;
     m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1689885cac..f24ee74cc5 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -378,6 +378,7 @@ static void pc_q35_3_1_machine_options(MachineClass *m)
 {
     pc_q35_4_0_machine_options(m);
     m->default_kernel_irqchip_split = false;
+    m->smbus_no_migration_support = true;
     m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 02f114085f..e7f7b85008 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -207,6 +207,7 @@ struct MachineClass {
     void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
     bool ignore_boot_device_suffixes;
+    bool smbus_no_migration_support;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
-- 
2.17.1
