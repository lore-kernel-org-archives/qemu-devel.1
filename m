Received: from eggs.gnu.org ([2001:4830:134:3::10]:43377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0V-0002Od-Si
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0U-0000IY-R5
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:11 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0U-0000IC-L8
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:10 -0500
Received: by mail-pf0-x242.google.com with SMTP id c4so22163381pfb.3
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:10 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:38 -0600
Message-Id: <1483111310-24808-8-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 07/19] i2c:pm_smbus: Fix state transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: minyard@acm.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Transfer the state information for the SMBus registers and
internal data so it will work on a VM transfer.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/acpi/piix4.c           |  1 +
 hw/i2c/pm_smbus.c         | 19 +++++++++++++++++++
 hw/i2c/smbus_ich9.c       |  3 ++-
 include/hw/i2c/pm_smbus.h |  2 ++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 17d36bd..d64b53b 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -321,6 +321,7 @@ static const VMStateDescription vmstate_acpi = {
         VMSTATE_UINT16(ar.pm1.evt.en, PIIX4PMState),
         VMSTATE_UINT16(ar.pm1.cnt.cnt, PIIX4PMState),
         VMSTATE_STRUCT(apm, PIIX4PMState, 0, vmstate_apm, APMState),
+        VMSTATE_STRUCT(smb, PIIX4PMState, 1, pmsmb_vmstate, PMSMBus),
         VMSTATE_TIMER_PTR(ar.tmr.timer, PIIX4PMState),
         VMSTATE_INT64(ar.tmr.overflow_time, PIIX4PMState),
         VMSTATE_STRUCT(ar.gpe, PIIX4PMState, 2, vmstate_gpe, ACPIGPE),
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 686d411..92e3cc5 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -370,6 +370,25 @@ static const MemoryRegionOps pm_smbus_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
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
+        VMSTATE_VBUFFER_UINT32(smb_data, PMSMBus, 1, NULL, 0, smb_index),
+        VMSTATE_UINT8(smb_auxctl, PMSMBus),
+        VMSTATE_BOOL(i2c_enable, PMSMBus),
+        VMSTATE_BOOL(op_done, PMSMBus),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 void pm_smbus_init(DeviceState *parent, PMSMBus *smb)
 {
     smb->op_done = true;
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 686ed09..85c7260 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -49,7 +49,8 @@ static const VMStateDescription vmstate_ich9_smbus = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, struct ICH9SMBState),
+        VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
+        VMSTATE_STRUCT(smb, ICH9SMBState, 1, pmsmb_vmstate, PMSMBus),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index 99d5489..b1e1970 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -33,4 +33,6 @@ typedef struct PMSMBus {
 
 void pm_smbus_init(DeviceState *parent, PMSMBus *smb);
 
+extern const VMStateDescription pmsmb_vmstate;
+
 #endif /* PM_SMBUS_H */
-- 
2.7.4
