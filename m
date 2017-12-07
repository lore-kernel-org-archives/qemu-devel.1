Received: from eggs.gnu.org ([2001:4830:134:3::10]:51472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN405-000466-UV
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN404-0006Vh-In
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:37 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:44437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN404-0006U1-AO
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:36 -0500
Received: by mail-pf0-x241.google.com with SMTP id m26so5668997pfj.11
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:36 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:19 -0600
Message-Id: <1512683181-8420-13-git-send-email-minyard@acm.org>
In-Reply-To: <1512683181-8420-1-git-send-email-minyard@acm.org>
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 12/14] ipmi: Fix SSIF ACPI handling to use the
 right CRS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/acpi/ipmi-stub.c    |  2 +-
 hw/acpi/ipmi.c         | 13 +++++++------
 hw/i386/acpi-build.c   |  2 +-
 include/hw/acpi/ipmi.h |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/ipmi-stub.c b/hw/acpi/ipmi-stub.c
index 98b6dce..6c71d6c 100644
--- a/hw/acpi/ipmi-stub.c
+++ b/hw/acpi/ipmi-stub.c
@@ -9,6 +9,6 @@
 
 #include "hw/acpi/ipmi.h"
 
-void build_acpi_ipmi_devices(Aml *table, BusState *bus)
+void build_acpi_ipmi_devices(Aml *table, BusState *bus, const char *resource)
 {
 }
diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
index 651e2e9..96e48eb 100644
--- a/hw/acpi/ipmi.c
+++ b/hw/acpi/ipmi.c
@@ -13,7 +13,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ipmi.h"
 
-static Aml *aml_ipmi_crs(IPMIFwInfo *info)
+static Aml *aml_ipmi_crs(IPMIFwInfo *info, const char *resource)
 {
     Aml *crs = aml_resource_template();
 
@@ -48,7 +48,8 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
                             info->register_spacing, info->register_length));
         break;
     case IPMI_MEMSPACE_SMBUS:
-        aml_append(crs, aml_return(aml_int(info->base_address)));
+        aml_append(crs, aml_i2c_serial_bus_device(info->base_address,
+                                                  resource));
         break;
     default:
         abort();
@@ -61,7 +62,7 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
     return crs;
 }
 
-static Aml *aml_ipmi_device(IPMIFwInfo *info)
+static Aml *aml_ipmi_device(IPMIFwInfo *info, const char *resource)
 {
     Aml *dev;
     uint16_t version = ((info->ipmi_spec_major_revision << 8)
@@ -74,14 +75,14 @@ static Aml *aml_ipmi_device(IPMIFwInfo *info)
     aml_append(dev, aml_name_decl("_STR", aml_string("ipmi_%s",
                                                      info->interface_name)));
     aml_append(dev, aml_name_decl("_UID", aml_int(info->uuid)));
-    aml_append(dev, aml_name_decl("_CRS", aml_ipmi_crs(info)));
+    aml_append(dev, aml_name_decl("_CRS", aml_ipmi_crs(info, resource)));
     aml_append(dev, aml_name_decl("_IFT", aml_int(info->interface_type)));
     aml_append(dev, aml_name_decl("_SRV", aml_int(version)));
 
     return dev;
 }
 
-void build_acpi_ipmi_devices(Aml *scope, BusState *bus)
+void build_acpi_ipmi_devices(Aml *scope, BusState *bus, const char *resource)
 {
 
     BusChild *kid;
@@ -101,6 +102,6 @@ void build_acpi_ipmi_devices(Aml *scope, BusState *bus)
         iic = IPMI_INTERFACE_GET_CLASS(obj);
         memset(&info, 0, sizeof(info));
         iic->get_fwinfo(ii, &info);
-        aml_append(scope, aml_ipmi_device(&info));
+        aml_append(scope, aml_ipmi_device(&info, resource));
     }
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 73519ab..84d82bc 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1340,7 +1340,7 @@ static void build_isa_devices_aml(Aml *table)
     } else if (!obj) {
         error_report("No ISA bus, unable to define IPMI ACPI data");
     } else {
-        build_acpi_ipmi_devices(scope, BUS(obj));
+        build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
     }
 
     aml_append(table, scope);
diff --git a/include/hw/acpi/ipmi.h b/include/hw/acpi/ipmi.h
index ab2bb29..d68bc85 100644
--- a/include/hw/acpi/ipmi.h
+++ b/include/hw/acpi/ipmi.h
@@ -17,6 +17,6 @@
  * bus matches the given bus.  The resource is the ACPI resource that
  * contains the IPMI device, this is required for the I2C CRS.
  */
-void build_acpi_ipmi_devices(Aml *table, BusState *bus);
+void build_acpi_ipmi_devices(Aml *table, BusState *bus, const char *resource);
 
 #endif /* HW_ACPI_IPMI_H */
-- 
2.7.4
