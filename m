Received: from eggs.gnu.org ([209.51.188.92]:46721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFk-0000Yu-8R
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:18:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFV-0002H7-2l
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:52 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gzQFU-0002Br-PY
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:37 -0500
Received: by mail-oi1-x243.google.com with SMTP id z14so17318475oid.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:17:24 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 28 Feb 2019 12:17:01 -0600
Message-Id: <20190228181710.2477-11-minyard@acm.org>
In-Reply-To: <20190228181710.2477-1-minyard@acm.org>
References: <20190228181710.2477-1-minyard@acm.org>
Subject: [Qemu-devel] [PULL 10/19] boards.h: Ignore migration for SMBus
 devices on older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, minyard@acm.org, Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

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
index 3e9037a19a..8770ecada9 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -444,6 +444,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass *m)
 
     pc_i440fx_4_0_machine_options(m);
     m->is_default = 0;
+    m->smbus_no_migration_support = true;
     m->alias = NULL;
     pcmc->pvh_enabled = false;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 503eeb46f5..cfb9043e12 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -380,6 +380,7 @@ static void pc_q35_3_1_machine_options(MachineClass *m)
 
     pc_q35_4_0_machine_options(m);
     m->default_kernel_irqchip_split = false;
+    m->smbus_no_migration_support = true;
     m->alias = NULL;
     pcmc->pvh_enabled = false;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 05f9f45c3d..21212f0859 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -206,6 +206,7 @@ struct MachineClass {
     void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
     bool ignore_boot_device_suffixes;
+    bool smbus_no_migration_support;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
-- 
2.17.1
