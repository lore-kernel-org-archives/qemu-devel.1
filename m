Received: from eggs.gnu.org ([2001:4830:134:3::10]:43351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0U-0002Mc-0v
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0S-0000HV-Tk
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:10 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0S-0000H0-Nz
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:08 -0500
Received: by mail-pg0-x241.google.com with SMTP id i5so22381182pgh.2
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:08 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:50 -0600
Message-Id: <1483111310-24808-20-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 19/19] ipmi_smbus: Add alert capability to the
 IPMI SSIF code
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

This lets you add "alertname=<name>" to specify an alert device
to use for letting the host know that the IPMI device has data
ready.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/smbus_ipmi.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/hw/ipmi/smbus_ipmi.c b/hw/ipmi/smbus_ipmi.c
index 4d99b48..5c7b7c2 100644
--- a/hw/ipmi/smbus_ipmi.c
+++ b/hw/ipmi/smbus_ipmi.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/i2c/smbus.h"
+#include "hw/i2c/smbus_alert.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/ipmi/ipmi.h"
@@ -49,6 +50,8 @@ typedef struct SMBusIPMIDevice {
     uint8_t inmsg[MAX_IPMI_MSG_SIZE];
     uint32_t inlen;
 
+    bool irqs_enabled;
+
     /*
      * This is a response number that we send with the command to make
      * sure that the response matches the command.
@@ -56,11 +59,15 @@ typedef struct SMBusIPMIDevice {
     uint8_t waiting_rsp;
 
     uint32_t uuid;
+
+    SMBusAlertEntry alert_entry;
+    SMBusAlertDevice *alertdev;
+    SMBusAlertDeviceClass *alertdevclass;
 } SMBusIPMIDevice;
 
 static void smbus_ipmi_handle_event(IPMIInterface *ii)
 {
-    /* No interrupts, so nothing to do here. */
+    /* Nothing to do here, we don't use events for SMBus. */
 }
 
 static void smbus_ipmi_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
@@ -74,16 +81,27 @@ static void smbus_ipmi_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
         memcpy(sid->outmsg, rsp, rsp_len);
         sid->outlen = rsp_len;
         sid->outpos = 0;
+
+        if (sid->alertdev && sid->irqs_enabled) {
+            sid->alertdevclass->alert(sid->alertdev, &sid->alert_entry);
+        }
     }
 }
 
 static void smbus_ipmi_set_atn(IPMIInterface *ii, int val, int irq)
 {
-    /* This is where PEC would go. */
+    SMBusIPMIDevice *sid = SMBUS_IPMI(ii);
+
+    if (sid->alertdev && sid->irqs_enabled) {
+        sid->alertdevclass->alert(sid->alertdev, &sid->alert_entry);
+    }
 }
 
 static void smbus_ipmi_set_irq_enable(IPMIInterface *ii, int val)
 {
+    SMBusIPMIDevice *sid = SMBUS_IPMI(ii);
+
+    sid->irqs_enabled = val;
 }
 
 static void ipmi_quick_cmd(SMBusDevice *dev, uint8_t read)
@@ -149,6 +167,12 @@ static const VMStateDescription vmstate_smbus_ipmi = {
     .minimum_version_id = 1,
     .fields      = (VMStateField[]) {
         VMSTATE_UINT8(waiting_rsp, SMBusIPMIDevice),
+        VMSTATE_BOOL(irqs_enabled, SMBusIPMIDevice),
+        VMSTATE_UINT32(outpos, SMBusIPMIDevice),
+        VMSTATE_VBUFFER_UINT32(outmsg, SMBusIPMIDevice, 1, NULL, 0,
+                               outlen),
+        VMSTATE_VBUFFER_UINT32(inmsg, SMBusIPMIDevice, 1, NULL, 0,
+                               inlen),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -165,14 +189,31 @@ static void smbus_ipmi_realize(DeviceState *dev, Error **errp)
 
     sid->uuid = ipmi_next_uuid();
 
+    if (sid->alertdev) {
+        sid->alertdevclass = SMBUS_ALERT_DEVICE_GET_CLASS(sid->alertdev);
+    }
+
+    sid->alert_entry.val = sid->parent.i2c.address << 1;
+
     sid->bmc->intf = ii;
 }
 
+static void alert_check(Object *obj, const char *name,
+                        Object *val, Error **errp)
+{
+    /* Always succeed. */
+}
+
 static void smbus_ipmi_init(Object *obj)
 {
     SMBusIPMIDevice *sid = SMBUS_IPMI(obj);
 
     ipmi_bmc_find_and_link(OBJECT(obj), (Object **) &sid->bmc);
+
+    object_property_add_link(obj, "alert", TYPE_SMBUS_ALERT_DEVICE,
+                             (Object **) &sid->alertdev, alert_check,
+                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             &error_abort);
 }
 
 static void smbus_ipmi_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
-- 
2.7.4
