Received: from eggs.gnu.org ([2001:4830:134:3::10]:56234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNNGI-0003WT-RC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gNNG9-00081z-ND
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:10 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gNNG7-000806-QP
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:25:00 -0500
Received: by mail-ot1-x344.google.com with SMTP id k98so19090368otk.3
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 11:24:57 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 15 Nov 2018 13:24:40 -0600
Message-Id: <20181115192446.17187-7-minyard@acm.org>
In-Reply-To: <20181115192446.17187-1-minyard@acm.org>
References: <20181115192446.17187-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 06/12] boards.h: Ignore migration for SMBus
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, minyard@acm.org, Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Corey Minyard <cminyard@mvista.com>

Migration capability is being added for pm_smbus and SMBus devices.
This change will allow backwards compatibility to be kept when
migrating back to an old qemu version.  Add a bool to the machine
class tho keep smbus migration from happening.  Future changes
will use this.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/i386/pc_piix.c   | 1 +
 hw/i386/pc_q35.c    | 1 +
 include/hw/boards.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index cb28227cc3..3d1ccb1af1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -443,6 +443,7 @@ static void pc_i440fx_2_12_machine_options(MachineClass *m)
     pc_i440fx_3_0_machine_options(m);
     m->is_default = 0;
     m->alias = NULL;
+    m->smbus_no_migration_support = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 90e88c9b28..0c6fca6a40 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -324,6 +324,7 @@ static void pc_q35_2_12_machine_options(MachineClass *m)
 {
     pc_q35_3_0_machine_options(m);
     m->alias = NULL;
+    m->smbus_no_migration_support = true;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f82f28468b..65314fbe2a 100644
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
