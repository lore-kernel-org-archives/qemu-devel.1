Received: from eggs.gnu.org ([209.51.188.92]:37045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEC-0003Db-FW
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB8V-0005ug-Ka
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:56:05 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:42314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB8V-0005ZL-Dg
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:55 -0500
Received: by mail-io1-xd43.google.com with SMTP id x6so14214373ioa.9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:21 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:49 -0600
Message-Id: <20190128175458.27255-11-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v4 10/19] boards.h: Ignore migration for SMBus
 devices on older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

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
index 6ba163ccbb..a8331b82f2 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -431,6 +431,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
 static void pc_i440fx_4_0_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
+    m->smbus_no_migration_support = true;
     m->alias = "pc";
     m->is_default = 1;
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 1689885cac..bafc73b2d9 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -368,6 +368,7 @@ static void pc_q35_machine_options(MachineClass *m)
 static void pc_q35_4_0_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
+    m->smbus_no_migration_support = true;
     m->alias = "q35";
 }
 
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
