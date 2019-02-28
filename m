Received: from eggs.gnu.org ([209.51.188.92]:46776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFo-0000aG-Ic
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gzQFc-0002Mg-Ts
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:56 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:33637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gzQFY-0002DA-CO
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:17:42 -0500
Received: by mail-ot1-x32c.google.com with SMTP id q24so18585007otk.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:17:28 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 28 Feb 2019 12:17:04 -0600
Message-Id: <20190228181710.2477-14-minyard@acm.org>
In-Reply-To: <20190228181710.2477-1-minyard@acm.org>
References: <20190228181710.2477-1-minyard@acm.org>
Subject: [Qemu-devel] [PULL 13/19] i2c:pm_smbus: Fix state transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, minyard@acm.org, Corey Minyard <cminyard@mvista.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Corey Minyard <cminyard@mvista.com>

Transfer the state information for the SMBus registers and
internal data so it will work on a VM transfer.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/acpi/piix4.c           |  7 +++++++
 hw/i2c/pm_smbus.c         | 31 +++++++++++++++++++++++++++++++
 hw/i2c/smbus_ich9.c       | 10 +++++++++-
 include/hw/i2c/pm_smbus.h |  9 +++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index df8c0db909..8fd25a5926 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -302,6 +302,11 @@ static const VMStateDescription vmstate_cpuhp_state = {
     }
 };
 
+static bool piix4_vmstate_need_smbus(void *opaque, int version_id)
+{
+    return pm_smbus_vmstate_needed();
+}
+
 /* qemu-kvm 1.2 uses version 3 but advertised as 2
  * To support incoming qemu-kvm 1.2 migration, change version_id
  * and minimum_version_id to 2 below (which breaks migration from
@@ -321,6 +326,8 @@ static const VMStateDescription vmstate_acpi = {
         VMSTATE_UINT16(ar.pm1.evt.en, PIIX4PMState),
         VMSTATE_UINT16(ar.pm1.cnt.cnt, PIIX4PMState),
         VMSTATE_STRUCT(apm, PIIX4PMState, 0, vmstate_apm, APMState),
+        VMSTATE_STRUCT_TEST(smb, PIIX4PMState, piix4_vmstate_need_smbus, 3,
+                            pmsmb_vmstate, PMSMBus),
         VMSTATE_TIMER_PTR(ar.tmr.timer, PIIX4PMState),
         VMSTATE_INT64(ar.tmr.overflow_time, PIIX4PMState),
         VMSTATE_STRUCT(ar.gpe, PIIX4PMState, 2, vmstate_gpe, ACPIGPE),
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 81d2a425ec..e48544f909 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -19,6 +19,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/hw.h"
+#include "hw/boards.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/i2c/smbus_master.h"
 
@@ -453,6 +454,36 @@ static const MemoryRegionOps pm_smbus_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+bool pm_smbus_vmstate_needed(void)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    return !mc->smbus_no_migration_support;
+}
+
+const VMStateDescription pmsmb_vmstate = {
+    .name = "pmsmb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(smb_stat, PMSMBus),
+        VMSTATE_UINT8(smb_ctl, PMSMBus),
+        VMSTATE_UINT8(smb_cmd, PMSMBus),
+        VMSTATE_UINT8(smb_addr, PMSMBus),
+        VMSTATE_UINT8(smb_data0, PMSMBus),
+        VMSTATE_UINT8(smb_data1, PMSMBus),
+        VMSTATE_UINT32(smb_index, PMSMBus),
+        VMSTATE_UINT8_ARRAY(smb_data, PMSMBus, PM_SMBUS_MAX_MSG_SIZE),
+        VMSTATE_UINT8(smb_auxctl, PMSMBus),
+        VMSTATE_UINT8(smb_blkdata, PMSMBus),
+        VMSTATE_BOOL(i2c_enable, PMSMBus),
+        VMSTATE_BOOL(op_done, PMSMBus),
+        VMSTATE_BOOL(in_i2c_block_read, PMSMBus),
+        VMSTATE_BOOL(start_transaction_on_status_read, PMSMBus),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk)
 {
     smb->op_done = true;
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index e6d8d28194..7b24be8256 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -43,12 +43,20 @@ typedef struct ICH9SMBState {
     PMSMBus smb;
 } ICH9SMBState;
 
+static bool ich9_vmstate_need_smbus(void *opaque, int version_id)
+{
+    return pm_smbus_vmstate_needed();
+}
+
 static const VMStateDescription vmstate_ich9_smbus = {
     .name = "ich9_smb",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, struct ICH9SMBState),
+        VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
+        VMSTATE_BOOL_TEST(irq_enabled, ICH9SMBState, ich9_vmstate_need_smbus),
+        VMSTATE_STRUCT_TEST(smb, ICH9SMBState, ich9_vmstate_need_smbus, 1,
+                            pmsmb_vmstate, PMSMBus),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index 7bcca97672..fb55c44444 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -43,4 +43,13 @@ typedef struct PMSMBus {
 
 void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk);
 
+/*
+ * For backwards compatibility on migration, older versions don't have
+ * working migration for pm_smbus, this lets us ignore the migrations
+ * for older machine versions.
+ */
+bool pm_smbus_vmstate_needed(void);
+
+extern const VMStateDescription pmsmb_vmstate;
+
 #endif /* PM_SMBUS_H */
-- 
2.17.1
