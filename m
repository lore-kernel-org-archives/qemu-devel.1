Received: from eggs.gnu.org ([2001:4830:134:3::10]:53196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gKlAF-0004Wa-Vo
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gKlAA-00078G-2z
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:20:07 -0500
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:52287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gKlA9-00070R-Oa
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:20:01 -0500
Received: by mail-it1-x142.google.com with SMTP id t190-v6so1743441itb.2
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 06:19:50 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  8 Nov 2018 08:19:44 -0600
Message-Id: <20181108141944.15769-3-minyard@acm.org>
In-Reply-To: <20181108141944.15769-1-minyard@acm.org>
References: <20181108141944.15769-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] ipmi: Add a UUID device property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Using the UUID that qemu generates probably isn't the best thing
to do, allow it to be passed in via properties, and use QemuUUID
for the type.

If the UUID is not set, return an unsupported command error.  This
way we are not providing an all-zero (or randomly generated) GUID
to the IPMI user.  This lets the host fall back to the other
method of using the get device id command to determind the BMC
being accessed.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Cédric Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 22 ++++++++++++++--------
 qemu-options.hx        | 10 +++++++---
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 9b509f829b..b88c021977 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -220,7 +220,7 @@ struct IPMIBmcSim {
     uint8_t restart_cause;
 
     uint8_t acpi_power_state[2];
-    uint8_t uuid[16];
+    QemuUUID uuid;
 
     IPMISel sel;
     IPMISdr sdr;
@@ -936,8 +936,19 @@ static void get_device_guid(IPMIBmcSim *ibs,
 {
     unsigned int i;
 
+    /* An uninitialized uuid is all zeros, use that to know if it is set. */
     for (i = 0; i < 16; i++) {
-        rsp_buffer_push(rsp, ibs->uuid[i]);
+        if (ibs->uuid.data[i]) {
+            goto uuid_set;
+        }
+    }
+    /* No uuid is set, return an error. */
+    rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);
+    return;
+
+ uuid_set:
+    for (i = 0; i < 16; i++) {
+        rsp_buffer_push(rsp, ibs->uuid.data[i]);
     }
 }
 
@@ -1979,12 +1990,6 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
     ibs->acpi_power_state[0] = 0;
     ibs->acpi_power_state[1] = 0;
 
-    if (qemu_uuid_set) {
-        memcpy(&ibs->uuid, &qemu_uuid, 16);
-    } else {
-        memset(&ibs->uuid, 0, 16);
-    }
-
     ipmi_init_sensors_from_sdrs(ibs);
     register_cmds(ibs);
 
@@ -2004,6 +2009,7 @@ static Property ipmi_sim_properties[] = {
     DEFINE_PROP_UINT8("fwrev2", IPMIBmcSim, fwrev2, 0),
     DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
     DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
+    DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 38c7a978c1..37e57e27d0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -470,7 +470,7 @@ possible drivers and properties, use @code{-device help} and
 @code{-device @var{driver},help}.
 
 Some drivers are:
-@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}]
+@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}][,guid=@var{uuid}]
 
 Add an IPMI BMC.  This is a simulation of a hardware management
 interface processor that normally sits on a system.  It provides
@@ -483,8 +483,8 @@ controllers.  If you don't know what this means, it is safe to ignore
 it.
 
 @table @option
-@item bmc=@var{id}
-The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
+@item id=@var{id}
+The BMC id for interfaces to use this device.
 @item slave_addr=@var{val}
 Define slave address to use for the BMC.  The default is 0x20.
 @item sdrfile=@var{file}
@@ -493,6 +493,10 @@ file containing raw Sensor Data Records (SDR) data. The default is none.
 size of a Field Replaceable Unit (FRU) area.  The default is 1024.
 @item frudatafile=@var{file}
 file containing raw Field Replaceable Unit (FRU) inventory data. The default is none.
+@item guid=@var{uuid}
+value for the GUID for the BMC, in standard UUID format.  If this is set,
+get "Get GUID" command to the BMC will return it.  Otherwise "Get GUID"
+will return an error.
 @end table
 
 @item -device ipmi-bmc-extern,id=@var{id},chardev=@var{id}[,slave_addr=@var{val}]
-- 
2.17.1
